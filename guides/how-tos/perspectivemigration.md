# Migrating from Perspective API to Tisane API

## Why Migrate?

Google's Perspective API is being **sunset in 2026** and will no longer accept requests after that date. Tisane API is a natural language processing platform purpose-built for content moderation, offering comparable — and in many ways broader — coverage of problematic content types, with multi-language support, structured JSON responses, severity ratings, and explainability built in.

This guide covers everything you need to migrate your integration: account setup, request/response format changes, and a full attribute mapping table.

---

## Step 1 — Create a Tisane Account and Obtain an API Key

1. Go to [https://tisane.ai](https://tisane.ai) and sign up for a free account.
2. Log in and navigate to your account dashboard to retrieve your **primary or secondary API key**.
3. In every request, include your key as a header:

```
Ocp-Apim-Subscription-Key: YOUR_API_KEY
```

> **Note:** No Google Cloud project is required. Tisane authentication is handled entirely via this subscription key header.

---

## Step 2 — Understand the API Differences

### Endpoint

| | Perspective API | Tisane API |
|---|---|---|
| **Method** | `POST` | `POST` |
| **Endpoint** | `https://commentanalyzer.googleapis.com/v1alpha1/comments:analyze?key=API_KEY` | `https://api.tisane.ai/parse` |
| **Auth** | Query parameter (`?key=`) | Header (`Ocp-Apim-Subscription-Key`) |

### Paradigm

The two APIs take a fundamentally different approach to content moderation:

- **Perspective API** returns a **probability score (0.0–1.0)** for each attribute you explicitly request. You define thresholds in your own logic to decide what to act on.
- **Tisane API** returns **structured instances of problematic content** under an `abuse` array, each with a `type`, `severity` level (`low` / `medium` / `high` / `extreme`), the offending `text` span, character `offset`, `length`, an optional `explanation`, and optional `tags` for sub-classification. You filter or act based on type and severity rather than numerical thresholds.

This means Tisane gives you richer, more actionable output out of the box, but it does require adapting your threshold-based logic to severity-based logic. Similar to Perspective's attributes, you also need to choose what types are relevant for you.

---

## Step 3 — Rewrite Your Request

### Perspective API Request (before)

```json
POST https://commentanalyzer.googleapis.com/v1alpha1/comments:analyze?key=YOUR_KEY

{
  "comment": {
    "text": "You are a complete idiot."
  },
  "requestedAttributes": {
    "TOXICITY": {},
    "INSULT": {},
    "PROFANITY": {}
  }
}
```

### Tisane API Request (after)

```json
POST https://api.tisane.ai/parse
Header: Ocp-Apim-Subscription-Key: YOUR_KEY

{
  "language": "en",
  "content": "You are a complete idiot.",
  "settings": {}
}
```

**Key differences:**

- Replace `comment.text` → `content`
- Add a `language` field (ISO 639-1 code, e.g. `"en"`, `"de"`, `"fr"`)
- Remove `requestedAttributes` — Tisane returns all detected abuse types by default
- Add a `settings` object to configure output (optional but recommended)
- The `format` setting (e.g. `"dialogue"`, `"review"`, `"alias"`) helps Tisane apply context-appropriate analysis

---

## Step 4 — Rewrite Your Response Handling

### Perspective API Response (before)

```json
{
  "attributeScores": {
    "TOXICITY": {
      "summaryScore": { "value": 0.92, "type": "PROBABILITY" }
    },
    "INSULT": {
      "summaryScore": { "value": 0.88, "type": "PROBABILITY" }
    }
  }
}
```

You would typically check: `if (score > 0.7) { flag(); }`

### Tisane API Response (after)

```json
{
  "text": "You are a complete idiot.",
  "abuse": [
    {
      "sentence_index": 0,
      "offset": 0,
      "length": 24,
      "text": "You are a complete idiot.",
      "type": "personal_attack",
      "severity": "high",
      "explanation": "Calling someone an idiot"
    }
  ]
}
```

You would typically check: `if (abuse !== undefined
&& /* check if the types you need were found */
) { flag(); }`

**Mapping severity to your old thresholds (suggested equivalents):**

While the severity thresholds do not indicate probability, they may be used to prioritize decision making like the Perspective score.

| Tisane Severity | Equivalent Perspective Score Range |
|---|---|
| `low` | 0.30 – 0.50 |
| `medium` | 0.50 – 0.70 |
| `high` | 0.70 – 0.85 |
| `extreme` | 0.85 – 1.00 |

---

## Step 5 — Attribute Mapping

The table below maps each Perspective API attribute to its closest Tisane equivalent. Because Tisane uses a category + severity model rather than per-attribute scores, some Perspective attributes map to a Tisane type + severity filter combination.

### Production Attributes

| Perspective Attribute | Definition | Tisane Equivalent | Notes |
|---|---|---|---|
| `TOXICITY` | Rude, disrespectful, or unreasonable comment likely to make people leave a discussion | `personal_attack`, `bigotry`, `profanity` (any severity) | Tisane separates toxicity into specific subtypes for more actionable results |
| `SEVERE_TOXICITY` | Very hateful, aggressive, or disrespectful content | `personal_attack` / `bigotry` / `profanity` with `severity: "high"` or `"extreme"` | Filter by severity to match the high-confidence bar of SEVERE_TOXICITY |
| `IDENTITY_ATTACK` | Negative or hateful comments targeting identity (race, religion, gender, etc.) | `bigotry` | Direct equivalent — Tisane's `bigotry` type covers protected class targeting |
| `INSULT` | Insulting, inflammatory, or negative comment towards a person | `personal_attack` | Direct equivalent for attacks on conversation participants |
| `PROFANITY` | Swear words, curse words, or other obscene/offensive language | `profanity` | Direct equivalent; Tisane also detects obfuscated profanity (e.g. `f***`) |
| `THREAT` | Describes an intention to inflict harm | `criminal_activity` with tag `threat` | Tisane classifies explicit threats under `criminal_activity` |

### Experimental and New York Times Attributes

| Perspective Attribute | Definition | Tisane Equivalent | Notes |
|---|---|---|---|
| `SEXUALLY_EXPLICIT` | Contains explicit sexual content | `adult_only` (with `sex` tag) and/or `sexual_advances` | `adult_only` (with `sex` tag) covers explicit sexual content; `sexual_advances` covers solicitation |
| `FLIRTATION` | Pickup lines, compliments on appearance, or sexual advances | `sexual_advances` | Tisane's `sexual_advances` type covers the full spectrum from flirting to explicit solicitation |
| `ATTACK_ON_COMMENTER` | Attack on the author of an article or post | `personal_attack` | Tisane's `personal_attack` covers attacks on any conversation participant |
| `INCOHERENT` | Difficult to understand or lacking in coherent ideas | No direct equivalent; `no_meaningful_content` is closest | Tisane detects gibberish and meaningless content under this type |
| `INFLAMMATORY` | Intentionally inflammatory content likely to provoke anger | `contentious` | Tisane's `contentious` type covers content likely to start adversarial arguments |
| `LIKELY_TO_REJECT` | Content a moderator would likely reject | No direct equivalent | Use Tisane's overall `abuse` array combined with severity filtering as a proxy |
| `OBSCENE` | Obscene or grossly offensive content | `profanity` with `severity: "high"` or `"extreme"` | Filter by higher severity levels to approximate Perspective's OBSCENE attribute |
| `SPAM` | Irrelevant or unsolicited bulk messages | `spam` | Direct equivalent — Tisane has a `spam` abuse type |
| `UNSUBSTANTIAL` | Trivial or short content | No direct equivalent | Tisane does not have a direct unsubstantial signal; use text length checks in your own logic |

### Tisane-Only Abuse Types (No Perspective Equivalent)

These types are available in Tisane but have no Perspective API counterpart, giving you additional moderation coverage:

| Tisane Type | Description |
|---|---|
| `criminal_activity` | Attempts to buy/sell illegal items, drugs, stolen data, criminal services |
| `external_contact` | Attempts to establish off-platform contact (phone, email, IM) — useful for gig economy or e-commerce platforms |
| `mental_issues` | Content indicative of suicidal ideation or severe depression |
| `allegation` | Claimed knowledge or accusation of misconduct |
| `bigotry` (broader) | Covers implicit bigotry/hate speech/stereotyping, not just explicit slurs |
| `disturbing` | Content that is disturbing or distressing without being explicitly illegal |
| `data_leak` | Sharing of personally identifiable information (PII) |
| `social_hierarchy` | Attempts to establish dominance or superiority over another user |

---

## Step 6 — Language Support

Perspective API supports a limited set of languages per attribute (e.g. `TOXICITY` supports English, Spanish, French, German, Portuguese, Italian, Russian).

Tisane API supports **30+ languages** with uniform abuse detection across all of them, including Arabic, Chinese (Simplified & Traditional), Japanese, Korean, Thai, Hebrew, Persian, Indonesian, and more. Set the `language` field to the appropriate ISO 639-1 code.

Tisane API features built-in automatic language identification.

---

## Step 7 — Advanced Settings

Tisane exposes several optional settings that have no Perspective equivalent but are useful for fine-tuning moderation:

```json
"settings": {
  "abuse": true,
  "format": "forum",           // Context hint: "forum", "review", "chat", "alias"
  "snippets": true,            // Return matching text snippets
  "explain": true,             // Return human-readable explanations
  "sentiment": true,           // Return sentiment analysis
  "document_sentiment": true   // Return document-level sentiment
}
```

To replicate Perspective's `doNotStore` flag (prevents logging of submitted text), contact Tisane support or review the on-premises deployment option.

---

## Quick Code Migration Examples

### Python (before — Perspective)

```python
import googleapiclient.discovery

client = googleapiclient.discovery.build("commentanalyzer", "v1alpha1", developerKey=API_KEY)

response = client.comments().analyze(body={
    "comment": {"text": text},
    "requestedAttributes": {"TOXICITY": {}, "INSULT": {}, "PROFANITY": {}}
}).execute()

toxicity_score = response["attributeScores"]["TOXICITY"]["summaryScore"]["value"]
if toxicity_score > 0.7:
    flag_content()
```

### Python (after — Tisane)

```python
import requests

headers = {
    "Content-Type": "application/json",
    "Ocp-Apim-Subscription-Key": API_KEY
}

response = requests.post("https://api.tisane.ai/parse", json={
    "language": "en",
    "content": text,
    "settings": {"abuse": True, "explain": True}
}, headers=headers)

data = response.json()
abuse_instances = data.get("abuse", [])

HIGH_SEVERITY = {"high", "extreme"}
should_flag = any(a["severity"] in HIGH_SEVERITY for a in abuse_instances)

if should_flag:
    flag_content()
```

### JavaScript (before — Perspective)

```javascript
const response = await fetch(
  `https://commentanalyzer.googleapis.com/v1alpha1/comments:analyze?key=${API_KEY}`,
  {
    method: "POST",
    body: JSON.stringify({
      comment: { text },
      requestedAttributes: { TOXICITY: {}, INSULT: {} }
    })
  }
);
const data = await response.json();
const score = data.attributeScores.TOXICITY.summaryScore.value;
if (score > 0.7) flagContent();
```

### JavaScript (after — Tisane)

```javascript
const response = await fetch("https://api.tisane.ai/parse", {
  method: "POST",
  headers: {
    "Content-Type": "application/json",
    "Ocp-Apim-Subscription-Key": API_KEY
  },
  body: JSON.stringify({
    language: "en",
    content: text,
    settings: { abuse: true }
  })
});
const data = await response.json();
const abuse = data.abuse || [];
const highSeverity = abuse.some(a => ["high", "extreme"].includes(a.severity));
if (highSeverity) flagContent();
```

---

## Summary Checklist

- [ ] Sign up for Tisane and obtain API key
- [ ] Replace endpoint URL and authentication method
- [ ] Change `comment.text` → `content`, add `language` field
- [ ] Remove `requestedAttributes` from request body
- [ ] Add `settings` object with desired output flags
- [ ] Update response parsing from score-based to severity/type-based logic
- [ ] Map your threshold logic to Tisane severity levels (`low`, `medium`, `high`, `extreme`)
- [ ] Review Tisane-only types (e.g. `criminal_activity`, `external_contact`) for additional coverage
- [ ] Test with representative content samples across all languages you support
- [ ] Complete migration before Perspective API end-of-service in 2026
