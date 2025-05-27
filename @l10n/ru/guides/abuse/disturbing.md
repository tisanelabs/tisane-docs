# Disturbing Content

Detected graphic descriptions of violence or injuries are logged under the `abuse` section, with the `type` attribute set to `disturbing`.

{% admonition type="warning" %}

Disturbing content may or may not constitute criminal activity. See: [Difference between Criminal Activity, Allegation, and Disturbing](./criminalallegationdisturbing.md)

{% /admonition %}

## Example

Request:

```json
{
	"language":"en",
	"content":"his finger was cut off", 
	"settings": 
  {
	 "snippets":true
  }
}
```

Response:

```json
{
	"text": "his finger was cut off",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 22,
			"text": "his finger was cut off",
			"type": "disturbing",
			"severity": "extreme"
		}
	]
}
```