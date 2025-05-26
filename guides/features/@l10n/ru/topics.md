# Topic Extraction

Topic extraction determines the dominant topics in the text. 

{% admonition type="info" %}

This functionality is also known as:

* theme identification
* subject detection
* key topic recognition

{% /admonition %}

Tisane stores the topics under the `topics` array (strings without `topic_stats`, objects with `topic_stats`). The topics are document level.

When a particular word has multiple interpretations, the sense of the word must be determined in the current context. For example, _Jupiter_ is a planet and a Roman deity. Whether it's the planet or the deity, depends on the text.

For example, the sentence _Juno is the wife of Jupiter_ refers to the deity. Tisane determines the relevant topics as `Roman mythology`, `supernatural` (gods), `relationship`, and `family` (since the spousal connection is mentioned).

```json
{
	"text": "Juno is the wife of Jupiter",
	"topics": [
		"supernatural",
		"Roman mythology",
		"relationship",
		"family"
	]
}
```

On the other hand, the sentence _Jupiter is farther from the sun than Mars_ refers to planets. Tisane determines the topics to be `outer space` and `astronomy`.

```json
{
	"text": "Jupiter is farther from the sun than Mars",
	"topics": [
		"outer space",
		"astronomy"
	]
}
```

## Topic Statistics

If the setting `topic_stats` is set to `true`, then the portion of the input where the topic is active is provided. The topic is then not provided as a string but as an object made of the topic itself (`topic` (string) attribute) and its distribution statistic (`coverage` (float) attribute).

**Example**

Request:

```json
{
  "language":"en",
  "content":"Jupiter is farther from the sun than Mars. Which is not important in the current context",
  "settings": 
  {
    "topic_stats": true
  }
}
```

Response:

```json
{
	"text": "Jupiter is farther from the sun than Mars. Which is not important in the current context",
	"topics": [
		{
			"topic": "outer space",
			"coverage": 0.5
		},
		{
			"topic": "astronomy",
			"coverage": 0.5
		}
	]
}
```
(both detected topics appear in 1 sentence out of 2, which is 0.5 of all sentences)

## Standards

There are common taxonomy standards that Tisane can use with `topic_standard` setting:

* `native` - native Tisane topic names; based on standard English terms for the topic. The default standard.
* `iptc_code` - codes of the [IPTC (International Press Telecommunications Council) Media Topics](https://iptc.org/standards/media-topics/) classification - a standard used in the media.
* `iptc_description` - English descriptions of the IPTC codes.
* `iab_code` - codes of the [IAB (Interactive Advertising Bureau)](https://www.iab.com/guidelines/content-taxonomy/) content taxonomy.
* `iab_description` - English descriptions of the IAB codes.
* `wikidata` - Wikidata codes (usually of the form Qnnnnn, e.g. Q123).

To specify the standard, add the `topic_standard` setting. 

**Example**

Request:

```json
{
  "language":"en",
  "content":"Jupiter is farther from the sun than Mars.",
  "settings": 
  {
    "topic_standard": "wikidata"
  }
}
```

Response:

```json
{
	"text": "Jupiter is farther from the sun than Mars. Which is not important in the current contex",
	"topics": [
		"Q4169",
		"Q333"
	]
}
```


{% admonition type="warning" %}

The standard taxonomies cover a small fraction of the native standard. When a concept is not covered by a taxonomy, it is omitted from the response.

{% /admonition %}