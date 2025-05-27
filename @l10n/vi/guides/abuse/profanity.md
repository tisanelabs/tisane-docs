# Profanities

Profanities are logged under the `abuse` section, with the `type` attribute set to `profanity`.

{% admonition type="warning" %}

Racial and other derogatory slurs are not considered profanities. They are handled by the `bigotry` type. 

See: [Bigotry and Hate Speech](./hatespeechandbigotry.md) 

{% /admonition %}

## Severity Levels

The severity levels are as following:

* `low` - very mild profanities that are often not considered profanities
* `medium` - the bulk of profanities
* `high` - highly inappropriate profanities
* `extreme` - usually "absolutely unacceptable" profanities (e.g. F-word in English or the [mat category in Slavic languages](https://en.wikipedia.org/wiki/Mat_(profanity)))

Attempts to obfuscate (e.g. with asterisks) does not impact the severity.

## Relevant Tags

The following tags are often associated with the `profanity` type:

* `sex` - profanities related to sexual activities or organs

## Example

Request:
```json
{
  "language":"en",
  "content":"i hate this fu*r",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```

Response:
```json
{
	"text": "i hate this fu*r",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 12,
			"length": 4,
			"text": "fu*r",
			"type": "profanity",
			"severity": "extreme",
			"tags": [
				"sex"
			]
		}
	]
}
```
