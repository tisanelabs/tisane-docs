# Contentious Content

Instances of contentious content that is likely to start an adversarial argument are logged under the `abuse` section, with the `type` attribute set to `contentious`. 

These instances include:

* assertion that a geopolitical entity is a country or not a country or belongs to another geopolitical entity
* assertion or generalization about a social group that is not a protected class
* negativity toward a geopolitical entity
* calls for a political action, especially if controversial
* assertion that a universally notorious historical figure is/was positive
* provocative aliases, designed to start fights

{% admonition type="info" %}

The concept may be contentious itself. It was created to address two opposite concerns:

1. Cases when a community wants to allow political discussions, even if adversarial, but not hate speech (or bigotry).
2. Cases when a community wants to ban any type of activism (e.g. a lifestyle community related to knitting, travel, etc.).

{% /admonition %}

## Example

Request:
```json
{
  "language":"en",
  "content":"Voldermort is a loser",
  "settings": 
  {
    "format":"alias", "snippets":true, "explain":true
  }
}
```


Response:
```json
{
	"text": "Voldermort is a loser",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 21,
			"text": "Voldermort is a loser",
			"type": "contentious",
			"severity": "medium",
			"explanation": "Nickname saying someone is bad person"
		}
	]
}
```