# Allegations

Allegation is claimed knowledge or accusation of a misconduct. The misconduct may not be a crime, but something potentially damaging to one's reputation. Instances of detected allegations are logged under the `abuse` section, with the `type` attribute set to `allegation`. 

Allegation detection is used to:

* prevent [review bombing](https://en.wikipedia.org/wiki/Review_bomb) on review sites and marketplaces
* block mass troll attacks, especially on public figure accounts (must be combined with `personal_attack` detection)
* prevent lawsuits over alleged libel posted in a community or an account
* prevent reputational damage

Relevant tags: nearly all tags apply, as the scope of allegations is broad.

{% admonition type="warning" %}

Tisane makes no assumptions as for the authenticity or inauthenticity of the allegations made. Determining if the claim is true is out of our scope.

{% /admonition %}

## Example

Request:
```json
{
  "language":"en",
  "content":"He is a pickpocket",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```


Response:
```json
{
	"text": "He is a pickpocket",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 18,
			"text": "He is a pickpocket",
			"type": "allegation",
			"severity": "medium",
			"explanation": "Allegation of someone being a guilty party"
		}
	]
}
```

Also see: [Difference between Criminal Activity, Allegation, and Disturbing](./criminalallegationdisturbing.md)