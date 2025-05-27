# Spam

Instances of spam are logged under the `abuse` section, with the `type` attribute set to `spam`. 

{% admonition type="warning" %}

Currently, our spam detection capabilities are limited. We mostly focus on spam in the reviews, profiles, and usernames.

{% /admonition %}

## Example

Request:
```json
{
  "language":"en",
  "content":"Luxury watches are affordable in Antarctica!",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```


Response:
```json
{
	"text": "Luxury watches are affordable in Antarctica!",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 43,
			"text": "Luxury watches are affordable in Antarctica",
			"type": "spam",
			"severity": "medium",
			"explanation": "Luxury items are cheap!",
			"tags": [
				"clickbait",
				"luxury",
				"sold_by_spammers"
			]
		}
	]
}
```