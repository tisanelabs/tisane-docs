# Assertion of Hierarchy

Instances of forceful assertion of hierarchy in a community are logged under the `abuse` section, with the `type` attribute set to `social_hierarchy`.

These instances include:

* being a control freak
* workspace bullying (e.g. so-called [power harassment](https://en.wikipedia.org/wiki/Power_harassment) in Japan and South Korea)
* forcing a particular group to "know their place" (e.g. new members of a community)


## Example

Request:

```json
{
  "language":"en",
  "content":"newbies should know their place",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```

Response:

```json
{
	"text": "newbies should know their place",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 31,
			"text": "newbies should know their place",
			"type": "social_hierarchy",
			"severity": "medium",
			"explanation": "Assertion on what newcomers should do"
		}
	]
}
```