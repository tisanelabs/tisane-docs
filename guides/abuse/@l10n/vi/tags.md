# Tags

In addition to the abuse types, more detail on the context is provided as a `tags` string array. It may be a subtype of the identity being targeted, or a type of the illicit item being discussed, etc.

The values of the tags usually correlate with the type of problematic content detected, but not necessarily. The tags are obtained by traversing the matching main clause, and collecting the `abuse/tags` values associated with the lexemes (or inner phrases) involved. For example, in an utterance like: "kill all immigrants", two types of `abuse` are detected: `criminal_activity` and `bigotry`. They both have the following tags: `call_for_violence`, `death`, and `xenophobia`.

```json
{
	"text": "kill all immigrants",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 19,
			"text": "kill all immigrants",
			"type": "criminal_activity",
			"severity": "extreme",
			"explanation": "Calls to kill a person or people",
			"tags": [
				"call_for_violence",
				"death",
				"xenophobia"
			]
		},
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 19,
			"text": "kill all immigrants",
			"type": "bigotry",
			"severity": "extreme",
			"explanation": "Calls or advocacy to commit murders of a protected class",
			"tags": [
				"call_for_violence",
				"death",
				"xenophobia"
			]
		}
	]
}
```

That also means that even if some types are ignored purportedly, the tags can still be used.

The sections dedicated to the abuse types list most relevant tags. 

## Complete List of Tags

See the full listing of the tags below.

* `ableism`
* `admission`
* `ageism`
* `anticatholicism`
* `antisemitism`
* `appearance`
* `bodily_harm`
* `bribery`
* `call_for_violence`
* `cannabis`
* `cannibalism`
* `caste`
* `christianophobia`
* `clickbait`
* `cocaine`
* `cold_weapons`
* `conspiracy_theory`
* `contraband`
* `controlled_substance `
* `credentials`
* `crime`
* `cryptocurrency`
* `data`
* `death`
* `debt`
* `doxing`
* `ecstasy`
* `endearment`
* `escape`
* `explosives`
* `extortion`
* `fake`
* `firearms`
* `for_sale`
* `hacking_services`
* `hallucination`
* `hallucinogen`
* `hard_drug`
* `heroin`
* `homophobia`
* `human_trafficking`
* `indigenous_sensitive`
* `instructions`
* `investment`
* `islamophobia`
* `khat`
* `link`
* `luxury`
* `medication`
* `meth`
* `money_laundering`
* `not personal`
* `opioid`
* `organ_trade`
* `organized_crime`
* `package`
* `payment`
* `pedophilia`
* `pii`
* `piracy`
* `planning`
* `privacy`
* `promo`
* `racism`
* `relationship_status`
* `religion`
* `scam`
* `sex`
* `sex_work`
* `sexism`
* `soft_drug`
* `sold_by_spammers`
* `tax_evasion`
* `terrorism`
* `threat`
* `tisane`
* `tobacco`
* `transphobia`
* `url`
* `user-generated content`
* `vehicle`
* `violation`
* `violence`
* `weapon`
* `weapons_of_mass_destruction`
* `wildlife`
* `workplace_bullying`
* `xenophobia`



