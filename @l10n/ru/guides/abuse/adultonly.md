# Adult-only Content

Adult-only content is content usually restricted in communities for children, but acceptable in adult communities. Instances of detected adult-only content are logged under the `abuse` section, with the `type` attribute set to `adult_only`. 

That includes:

* erotic material or references to sex-related topics. Relevant tag: `sex`
* references to consumption of drugs and alcohol. Relevant tag: `controlled_substance`. Tags associated with the drugs mentioned are also used. Read more: [Criminal Activity](./criminalactivity.md).

## Example

Request:
```json
{
  "language":"en",
  "content":"we drank so much beer last week",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```

Response:
```json
{
	"text": "we drank so much beer last week",
	"topics": [
		"alcoholic beverage",
		"beverage"
	],
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 31,
			"text": "we drank so much beer last week",
			"type": "adult_only",
			"severity": "medium",
			"explanation": "Statement indicating collective consumption of alcoholic beverages",
			"tags": [
				"controlled_substance"
			]
		}
	]
}
```