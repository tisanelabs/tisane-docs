# Теги

В дополнение к типам злоупотреблений, более подробная информация о контексте предоставляется в виде массива строк `tags`. Это может быть подтип личности, являющейся целью, или тип обсуждаемого незаконного предмета и т. д.

Значения тегов обычно коррелируют с типом обнаруженного проблемного контента, но необязательно. Теги получаются путем обхода соответствующего главного предложения и сбора значений `abuse/tags`, связанных с используемыми лексемами (или внутренними фразами). Например, в таком высказывании: «убить всех иммигрантов», обнаруживаются два типа `abuse`: ` criminal_activity` и `bigotry`. Они оба имеют следующие теги: `call_for_violence`, `death` и `xenophobia`.

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

Это также означает, что даже если некоторые типы якобы игнорируются, теги все равно можно использовать.

В разделах, посвященных типам злоупотреблений, перечислены наиболее релевантные теги. 

## Полный список тегов

Полный список тегов смотрите ниже.

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



