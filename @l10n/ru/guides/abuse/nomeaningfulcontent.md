# Meaningless Content

Instances of content that has no meaning (e.g. words that appear to be gibberish) are logged under the `abuse` section, with the `type` attribute set to `no_meaninful_content`.

This functionality is used to detect hacker-initiated flooding with meaningless content, or nonsensical sign-ups. 

{% admonition type="warning" %}

If the `format` is set to `alias`, content is analyzed differently, and may look for portions that have meaning even if the entire piece of text appears meaningless.

Likewise, characters often used for obfuscation (e.g. asterisk) may result in a different interpretation.

{% /admonition %}

## Example

Request:
```json
{
  "language":"en",
  "content":"asdkjasldkasdaasa",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```

Response:
```json
{
	"text": "asdkjasldkasdaasa",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 17,
			"text": "asdkjasldkasdaasa",
			"type": "no_meaningful_content",
			"severity": "low",
			"explanation": "Unidentifed (English)"
		}
	]
}
```
