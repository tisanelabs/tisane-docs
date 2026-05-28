# Migrating from Two Hat Community Sift to Tisane API

A developer how-to guide for teams moving their text moderation pipeline from Microsoft/Two Hat Community Sift to Tisane API.

---

## Table of Contents

1. [Background and Motivation](#1-background-and-motivation)
2. [Architecture Overview](#2-architecture-overview)
3. [Authentication](#3-authentication)
4. [API Endpoint Mapping](#4-api-endpoint-mapping)
5. [Request Structure Mapping](#5-request-structure-mapping)
6. [Response Structure Mapping](#6-response-structure-mapping)
7. [Abuse Category Mapping](#7-abuse-category-mapping)
8. [Severity and Risk Level Mapping](#8-severity-and-risk-level-mapping)
9. [User Reputation and Trust States](#9-user-reputation-and-trust-states)
10. [Webhook and Decision Handling](#10-webhook-and-decision-handling)
11. [Settings and Configuration Mapping](#11-settings-and-configuration-mapping)
12. [Code Migration Examples](#12-code-migration-examples)
13. [Feature Parity Reference](#13-feature-parity-reference)
14. [Migration Checklist](#14-migration-checklist)

---

## 1. Background and Motivation

Two Hat Community Sift (now marketed under Microsoft) is sunsetting. Teams that built real-time text moderation pipelines on Community Sift need a replacement that offers:

- Granular, per-instance abuse classification (not just a binary pass/fail)
- Multi-language support
- Real-time latency suitable for pre-publish filtering
- Transparent, explainable results

**Tisane API** is a natural language processing (NLP) API focused on abusive content detection and analysis. It classifies text into typed abuse instances with per-instance severity levels, and supports 35+ languages. Its `POST /parse` method is broadly equivalent to Community Sift's text analysis endpoint.

> **Scope of this guide:** This guide covers text-based moderation. Community Sift's image, video, and OCR moderation capabilities are outside Tisane's scope. For image/video, you will need a separate provider alongside Tisane.

---

## 2. Architecture Overview

### Community Sift

Community Sift is a managed, opaque SaaS platform. You POST content (text, images, usernames) and receive a structured decision. Risk sliders and topic sensitivity are configured through its dashboard. Webhooks push decisions (FLOOD, MUTE, BAN, etc.) to your application.

### Tisane API

Tisane is a text-only NLP API. You POST a JSON body with `content`, `language`, and `settings`, and receive a structured JSON response listing every detected instance of problematic content, sentiment, entities, and topics. Moderation decisions (block, review, pass) are made by your application based on the returned classifications. There is no built-in dashboard for policy management; your policy logic lives in your code or a wrapper layer.

**Key architectural implication:** Community Sift acted as a decision engine. Tisane acts as a classifier. You must implement your own decision layer on top of Tisane's response.

---

## 3. Authentication

| Community Sift | Tisane API |
|---|---|
| API key passed as a query parameter (`?apiKey=...`) or as a request header | API key passed as the `Ocp-Apim-Subscription-Key` HTTP request header |
| Key obtained from the Two Hat / Microsoft developer portal | Key obtained from the Tisane Labs developer portal at `dev.tisane.ai` |

**Community Sift (before):**
```http
POST https://api.communitysift.com/v2/content?apiKey=YOUR_KEY
Content-Type: application/json
```

**Tisane API (after):**
```http
POST https://api.tisane.ai/parse
Content-Type: application/json
Ocp-Apim-Subscription-Key: YOUR_KEY
```

> **Note:** For on-premise Tisane deployments, the `Ocp-Apim-Subscription-Key` header is not required.

---

## 4. API Endpoint Mapping

| Community Sift Endpoint | Tisane Equivalent | Notes |
|---|---|---|
| `POST /v2/content` — analyze text | `POST /parse` | Core text analysis endpoint |
| `POST /v2/username` — analyze a username | `POST /parse` with `"format": "alias"` in settings | Tisane uses format cues rather than a separate endpoint |
| `POST /v2/image` — analyze image | No direct equivalent | Tisane is text-only; use a separate image moderation provider |
| `GET /v2/languages` — list supported languages | `GET /languages` | Same purpose; Tisane supports 35+ languages |
| User reputation / trust state update | No direct equivalent | Must be implemented in your application layer; see Section 9 |
| Webhook (CS → your app) | Not applicable — Tisane is synchronous only | Tisane returns results inline in the HTTP response; no push model |

---

## 5. Request Structure Mapping

### Community Sift Request

```json
{
  "text": "You're such an idiot, kill yourself",
  "lang": "en",
  "userId": "user_12345",
  "contextId": "chat_room_42",
  "customFilter": "default"
}
```

| CS Field | Type | Purpose |
|---|---|---|
| `text` | string | Content to analyze |
| `lang` | string | ISO 639-1 language code |
| `userId` | string | Identifies the author (used for reputation tracking) |
| `contextId` | string | Channel or session identifier |
| `customFilter` | string | Selects which risk configuration profile to apply |

### Tisane API Request

```json
{
  "language": "en",
  "content": "You're such an idiot, kill yourself",
  "settings": {
    "format": "dialogue",
    "explain": true
  }
}
```

| Tisane Field | Type | Purpose |
|---|---|---|
| `language` | string | ISO 639-1 language code (required) |
| `content` | string | Content to analyze (required) |
| `settings` | object | Optional configuration; controls output format and analysis behavior |

### Field Mapping

| Community Sift | Tisane | Notes |
|---|---|---|
| `text` | `content` | Direct rename |
| `lang` | `language` | Direct rename; same ISO 639-1 codes |
| `userId` | Not in request | User identity is not sent to Tisane; manage reputation in your layer |
| `contextId` | Not in request | No session context in Tisane |
| `customFilter` | `settings` object | Risk thresholds are implemented in your decision layer, not in Tisane |

> **Maximum content length:** Tisane's public cloud API accepts JSON bodies up to 2,048 bytes. For longer texts, use an on-premise or private cloud deployment.

---

## 6. Response Structure Mapping

### Community Sift Response (representative)

```json
{
  "text": "You're such an idiot, kill yourself",
  "action": "ESCALATE",
  "risk_level": 3,
  "categories": {
    "bully": 95,
    "hatespeech": 12,
    "selfharm": 78,
    "profanity": 20
  },
  "filtered_text": "You're such an *****, kill yourself",
  "user_reputation": "NOT_TRUSTED"
}
```

Key Community Sift response fields:

| CS Field | Description |
|---|---|
| `text` | The analyzed text |
| `action` | Platform decision: `PASS`, `WARN`, `MUTE`, `ESCALATE`, `BAN`, `BLOCK` |
| `risk_level` | Overall risk score (integer 0–5 or 0–100 depending on configuration) |
| `categories` | Map of topic names to confidence scores (0–100) |
| `filtered_text` | Text with detected terms replaced by asterisks |
| `user_reputation` | Author's computed trust state: `NOT_TRUSTED`, `DEFAULT`, `TRUSTED` |

### Tisane API Response (equivalent)

```json
{
	"text": "You're such an idiot, kill yourself",
	"topics": [
		"death",
		"suicide"
	],
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 20,
			"text": "You're such an idiot",
			"type": "personal_attack",
			"severity": "low",
			"explanation": "You are a something negative",
			"tags": [
				"ableism"
			]
		},
		{
			"sentence_index": 0,
			"offset": 22,
			"length": 13,
			"text": "kill yourself",
			"type": "personal_attack",
			"severity": "extreme",
			"explanation": "Suggestion to commit suicide",
			"tags": [
				"bodily_harm",
				"death"
			]
		}
	],
	"sentiment_expressions": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 20,
			"text": "You're such an idiot",
			"polarity": "negative",
			"reasons": [
				"intelligence"
			],
			"explanation": "Smb is an unpleasant person"
		},
		{
			"sentence_index": 0,
			"offset": 22,
			"length": 13,
			"text": "kill yourself",
			"polarity": "negative",
			"explanation": "Suffer"
		}
	]
}
```

Key Tisane response fields:

| Tisane Field | Description |
|---|---|
| `text` | Echo of the analyzed text |
| `abuse` | Array of detected abuse instances; each is a typed, located finding |
| `abuse[].type` | Category of problematic content (see Section 7) |
| `abuse[].severity` | Severity level: `low`, `medium`, `high`, `extreme` |
| `abuse[].offset` | Character offset of the abusive span within the text |
| `abuse[].length` | Character length of the abusive span |
| `abuse[].text` | The exact abusive text span |
| `abuse[].explanation` | Human-readable rationale (requires `"explain": true` in settings) |
| `abuse[].tags` | Subtypes and contextual labels (e.g. `xenophobia`, `death`, `firearms`) |
| `sentiment_expressions` | Aspect-based sentiment snippets |
| `topics` | Detected topics |
| `entities_summary` | Named entity mentions |

### Response Structure Comparison

| Community Sift Field | Tisane Equivalent | Notes |
|---|---|---|
| `action` | Not returned — derive from `abuse[].severity` | Implement your own decision logic; see Section 10 |
| `risk_level` | Derived from `abuse[].severity` | Map `extreme`→block, `high`→escalate, etc. |
| `categories{}` | `abuse[].type` per instance | Tisane returns typed instances, not document-level scores |
| `filtered_text` | Not returned | Tisane identifies spans via `offset`+`length`; apply censoring in your app |
| `user_reputation` | Not returned | Must be tracked in your application layer |

---

## 7. Problematic Content (Abuse) Category Mapping

Community Sift classified content against approximately 19 topics using confidence scores. Tisane classifies content into typed abuse instances. The mapping below is conceptual — Tisane does not output confidence scores but does output per-instance severity.

| Community Sift Category | Tisane `abuse.type` | Tisane Tags (for further specificity) |
|---|---|---|
| cyberbullying | `personal_attack` |  |
| hate speech | `bigotry` | `racism`, `xenophobia`, `homophobia`, `antisemitism`, `islamophobia`, `sexism`, `transphobia`, `ableism`, `ageism`, `christianophobia`, `sinophobia` |
| violent threats | `criminal_activity` | `call_for_violence`, `threat` |
| self-harm, suicide | `mental_issues` | `bodily_harm` |
| sexual harassment | `sexual_advances` | `sex` |
| adult-only content | `adult_only` | |
| `profanity` | `profanity` | |
| PII / contact details | `criminal_activity` with tags | `pii`, `credentials`, `doxing`, `privacy`, `data` |
| attempts to share contact info | `external_contact` |  |
| drug use | `criminal_activity` | `controlled_substance`, `cannabis`, `cocaine`, `heroin`, `meth`, `hard_drug`, `soft_drug`, `opioid` |
| weapons | `criminal_activity` | `firearms`, `cold_weapons`, `explosives` |
| `spam` | `spam` |  |
| terrorism | `criminal_activity` | `call_for_violence` |
| human trafficking | `criminal_activity` | `sex_work` |
| gambling | No direct equivalent | Use topic extraction (`topics`) to detect gambling-related subjects |
| `allegation` | `allegation` | — |

> **Important:** Community Sift returned a single confidence score per category for the whole message. Tisane returns one or more discrete, located instances per type. A single message may generate multiple `abuse` entries of the same or different types.

---

## 8. Severity and Risk Level Mapping

Community Sift expressed risk as either a numeric level (0–5 or 0–100) or a named action. Tisane uses a four-level severity per abuse instance.

| Tisane Severity | Approximate Community Sift Equivalent | Suggested Action |
|---|---|---|
| `low` | Risk level 1 / category score 20–40 | Log; consider a soft warning for repeated low-severity offenses |
| `medium` | Risk level 2–3 / category score 40–70 | Warn the user; queue for human review |
| `high` | Risk level 3–4 / category score 70–90 | Escalate for review; consider pre-publication hold |
| `extreme` | Risk level 5 / category score 90–100 | Auto-reject / block immediately |

**Deriving a composite risk level from Tisane:**

Because Tisane returns per-instance severity rather than a document-level score, you need to derive a document-level risk in your application:

```javascript
function getDocumentRisk(abuseArray) {
  const severityRank = { low: 1, medium: 2, high: 3, extreme: 4 };
  if (!abuseArray || abuseArray.length === 0) return 'none';
  return abuseArray.reduce((max, instance) => {
    return severityRank[instance.severity] > severityRank[max]
      ? instance.severity
      : max;
  }, 'low');
}
```

---

## 9. User Reputation and Trust States

Community Sift's patented User Reputation system maintained three states per user — `NOT_TRUSTED`, `DEFAULT`, and `TRUSTED` — updated automatically based on moderation history. This is one of the most significant architectural differences.

**Tisane has no built-in user reputation model.** You must replicate this in your application layer.

### Recommended Implementation

Track a reputation state per user in your own datastore and factor it into your decision logic:

```javascript
// Pseudocode: reputation-aware decision layer on top of Tisane
async function moderateWithReputation(userId, text, language) {
  const reputation = await db.getUserReputation(userId); // 'not_trusted' | 'default' | 'trusted'
  const tisaneResult = await tisane.parse({ language, content: text, settings: { explain: true } });

  const documentRisk = getDocumentRisk(tisaneResult.abuse);

  // Apply stricter thresholds for untrusted users
  if (reputation === 'not_trusted') {
    if (['medium', 'high', 'extreme'].includes(documentRisk)) return 'BLOCK';
  } else if (reputation === 'trusted') {
    if (documentRisk === 'extreme') return 'BLOCK';
    if (documentRisk === 'high') return 'ESCALATE';
  } else {
    if (documentRisk === 'extreme') return 'BLOCK';
    if (['high', 'medium'].includes(documentRisk)) return 'ESCALATE';
  }

  // Update reputation based on history
  if (documentRisk !== 'none') await db.recordViolation(userId, documentRisk);

  return 'PASS';
}
```

---

## 10. Webhook and Decision Handling

Community Sift pushed decisions to your webhook in real time using named event types (`FLOOD`, `MUTE`, `BAN`, `BLOCK`, `ESCALATE`). Tisane is a **synchronous request-response API** — there are no outbound webhooks from Tisane.

### Migration Pattern

Replace your webhook handler with synchronous in-line decision logic:

**Before (Community Sift webhook handler):**
```javascript
// CS pushed decisions to your endpoint
app.post('/cs-webhook', (req, res) => {
  const { action, userId, text } = req.body;
  if (action === 'BAN') banUser(userId);
  else if (action === 'MUTE') muteUser(userId, 3600);
  else if (action === 'ESCALATE') queueForReview(text, userId);
  res.sendStatus(200);
});
```

**After (Tisane synchronous decision layer):**
```javascript
async function analyzeAndAct(userId, text, language) {
  const response = await fetch('https://api.tisane.ai/parse', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Ocp-Apim-Subscription-Key': process.env.TISANE_KEY
    },
    body: JSON.stringify({ language, content: text, settings: { explain: true } })
  });

  const result = await response.json();
  const risk = getDocumentRisk(result.abuse);

  if (risk === 'extreme') {
    blockMessage();
    await recordViolation(userId, result.abuse);
  } else if (risk === 'high') {
    queueForReview(text, userId, result.abuse);
  } else if (risk === 'medium') {
    warnUser(userId);
  }

  return result;
}
```

---

## 11. Settings and Configuration Mapping

Community Sift allowed risk sensitivity to be tuned per topic through sliders in its dashboard. Tisane exposes these as settings in the request body.

| Community Sift Configuration | Tisane `settings` Parameter | Notes |
|---|---|---|
| Risk slider per topic (0–100) | No equivalent — implement thresholds in your decision layer | Tisane returns raw severity; your code applies thresholds |
| Language selection | `language` (required top-level field) | ISO 639-1 code |
| Username / alias mode | `"format": "alias"` | Tells the model to expect a screen name, not prose |
| Chat / message mode | `"format": "dialogue"` | Optimizes analysis for short conversational messages |
| Review mode | `"format": "review"` | Better sentiment detection for product/service reviews |
| Explainability / rationale | `"explain": true` | Populates the `explanation` field in each abuse instance |
| Spellcheck disable | `"disable_spellcheck": true` | Useful for usernames or structured data |

### Example: Full moderation-oriented settings object

```json
{
  "language": "en",
  "content": "User message here",
  "settings": {
    "format": "dialogue",
    "explain": true
  }
}
```

---

## 12. Code Migration Examples

### Python

**Before (Community Sift):**
```python
import requests

def check_content(text, user_id, lang='en'):
    response = requests.post(
        'https://api.communitysift.com/v2/content',
        params={'apiKey': CS_API_KEY},
        json={'text': text, 'lang': lang, 'userId': user_id}
    )
    data = response.json()
    return data['action'], data['risk_level'], data['categories']
```

**After (Tisane API):**
```python
import requests

SEVERITY_RANK = {'low': 1, 'medium': 2, 'high': 3, 'extreme': 4}

def get_document_risk(abuse_list):
    if not abuse_list:
        return 'none'
    return max(abuse_list, key=lambda x: SEVERITY_RANK.get(x['severity'], 0))['severity']

def check_content(text, lang='en'):
    response = requests.post(
        'https://api.tisane.ai/parse',
        headers={'Ocp-Apim-Subscription-Key': TISANE_KEY},
        json={
            'language': lang,
            'content': text,
            'settings': {'format': 'chat', 'explain': True}
        }
    )
    data = response.json()
    abuse = data.get('abuse', [])
    document_risk = get_document_risk(abuse)

    # Replicate CS-style action names
    action_map = {'none': 'PASS', 'low': 'WARN', 'medium': 'ESCALATE',
                  'high': 'ESCALATE', 'extreme': 'BLOCK'}
    action = action_map.get(document_risk, 'PASS')

    return action, document_risk, abuse
```

### Node.js

**Before (Community Sift):**
```javascript
async function moderateText(text, userId, lang = 'en') {
  const res = await fetch(`https://api.communitysift.com/v2/content?apiKey=${CS_KEY}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ text, lang, userId })
  });
  return await res.json(); // { action, risk_level, categories, filtered_text }
}
```

**After (Tisane API):**
```javascript
const SEVERITY_RANK = { low: 1, medium: 2, high: 3, extreme: 4 };

function getDocumentRisk(abuseArray) {
  if (!abuseArray?.length) return 'none';
  return abuseArray.reduce((max, i) =>
    SEVERITY_RANK[i.severity] > SEVERITY_RANK[max] ? i.severity : max, 'low');
}

function applyRedactions(text, abuseArray) {
  // Build filtered_text equivalent using Tisane's offset+length spans
  let result = text;
  const sorted = [...abuseArray].sort((a, b) => b.offset - a.offset);
  for (const instance of sorted) {
    const stars = '*'.repeat(instance.length);
    result = result.slice(0, instance.offset) + stars + result.slice(instance.offset + instance.length);
  }
  return result;
}

async function moderateText(text, lang = 'en') {
  const res = await fetch('https://api.tisane.ai/parse', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Ocp-Apim-Subscription-Key': process.env.TISANE_KEY
    },
    body: JSON.stringify({
      language: lang,
      content: text,
      settings: { format: 'chat', explain: true }
    })
  });

  const data = await res.json();
  const abuse = data.abuse || [];
  const documentRisk = getDocumentRisk(abuse);
  const filteredText = applyRedactions(text, abuse);

  const actionMap = { none: 'PASS', low: 'WARN', medium: 'ESCALATE', high: 'ESCALATE', extreme: 'BLOCK' };

  return {
    action: actionMap[documentRisk] || 'PASS',
    risk: documentRisk,
    abuse,
    filtered_text: filteredText,
    raw: data
  };
}
```

---

## 13. Feature Parity Reference

| Feature | Community Sift | Tisane API | Notes |
|---|---|---|---|
| Text moderation | Yes | Yes | Core capability |
| Per-instance abuse location (offset + length) | No — document-level scores only | Yes | Tisane is more granular |
| Abuse type classification | Yes (19 topics) | Yes (5 primary types + tag subtypes) | Broadly equivalent; see Section 7 |
| Severity levels | Numeric score 0–100 per topic | 4-level categorical: low/medium/high/extreme | Different representation |
| Explainability / rationale | Limited | Yes (with `"explain": true`) | Tisane is more transparent |
| Username moderation | Yes (dedicated endpoint) | Yes (via `"format": "alias"`) | |
| Image moderation | Yes | No | Need a separate provider |
| Video moderation | Yes | No | Need a separate provider |
| OCR on images | Yes | No | Need a separate provider |
| Multi-language support | English primary; limited others | 35+ languages | Tisane has significantly broader language support |
| User Reputation / Trust States | Yes (patented) | No | Must implement in application layer |
| Real-time pre-publish filtering | Yes | Yes | Both support sub-100ms latency at scale |
| Webhook / push decisions | Yes | No — synchronous only | Must rework to inline decision logic |
| Dashboard UI | Yes | No | Tisane is API-only |
| Spam detection | Yes | Yes (with `"spam": true` in settings) | |
| Sentiment analysis | No | Yes | Tisane bonus capability |
| Topic extraction | No | Yes (IAB/IPTC) | Tisane bonus capability |
| Named entity extraction | No | Yes | Tisane bonus capability |
| On-premise deployment | No | Yes | Tisane Embedded SDKs available |
| Free tier | No | Yes (rate-limited) | |

---

## 14. Migration Checklist

Use this checklist to track your migration:

### Preparation

- [ ] Sign up for a Tisane Labs account at `https://tisane.ai/signup/`
- [ ] Obtain your API key from the Tisane developer portal
- [ ] Review the Tisane API documentation at `https://docs.tisane.ai`
- [ ] Inventory all Community Sift API call sites in your codebase
- [ ] Document which CS categories and risk sliders are active in your current setup
- [ ] Identify all webhook handlers and decision actions your system currently uses

### Implementation

- [ ] Replace authentication header (`apiKey` query param → `Ocp-Apim-Subscription-Key` header)
- [ ] Replace endpoint URLs
- [ ] Rename request fields (`text` → `content`, `lang` → `language`)
- [ ] Add `settings` object with appropriate `format` and feature flags
- [ ] Implement `getDocumentRisk()` to derive a composite severity from the `abuse` array
- [ ] Implement your decision layer mapping Tisane severity → your actions (PASS/WARN/ESCALATE/BLOCK)
- [ ] Implement text redaction using `abuse[].offset` and `abuse[].length` (replaces `filtered_text`)
- [ ] Rework webhook handlers into synchronous inline decision logic
- [ ] Implement a user reputation datastore if you relied on CS's trust states
- [ ] Map CS abuse categories to Tisane `type` + `tags` values (see Section 7)
- [ ] Add a fallback / error handler for Tisane `4xx`/`5xx` responses

### Testing

- [ ] Run a representative sample of historical messages through both APIs in parallel
- [ ] Compare decisions; calibrate your severity thresholds to match your previous CS risk sliders
- [ ] Test edge cases: algospeak, l33t speak, emoji-encoded abuse, mixed-language messages
- [ ] Validate username moderation using `"format": "alias"`
- [ ] Test with all languages your platform supports; verify Tisane language codes
- [ ] Load-test against your peak message throughput

### Cutover

- [ ] Deploy new code in shadow mode (run Tisane alongside CS, log both, act on CS)
- [ ] Compare disagreement rates and refine thresholds
- [ ] Ramp traffic to Tisane as confidence increases
- [ ] Decommission Community Sift integration
- [ ] Update monitoring and alerting dashboards

---

## Additional Resources

- Tisane API documentation: https://docs.tisane.ai
- Tisane API reference (OpenAPI): https://docs.tisane.ai/apis/tisane-api-short
- Tisane abuse type guides: https://docs.tisane.ai/guides/abuse/tags
- Tisane configuration reference: https://docs.tisane.ai/apis/tisane-api-configuration
- Tisane free plan sign-up: https://tisane.ai/signup/

