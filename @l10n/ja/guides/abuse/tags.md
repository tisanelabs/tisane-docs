# タグ

中傷のタイプに加え、文脈に関する詳細情報が`tags`の文字列配列として提供されます。標的対象の個人情報のサブタイプである可能性があれば、議論されている不正な項目のタイプである可能性もあります。

タグの値は通常、検出された問題のあるコンテンツのタイプと相関関係がありますが、必ずしもそうとは限りません。タグは、一致する主節のトラバーサルを行い、関与する語彙素（または内部句）に付随する`abuse/tags`の値を収集することで取得されます。例えば、例えば、「すべての移民を殺せ」という発言では、2種類の`abuse`（`criminal_activity`と`bigotry`）が検出されます。これらには`call_for_violence`、`death`、`xenophobia`というタグが含まれます。

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

つまり、一部のタイプが意図的に無視された場合でも、これらのタグは使用可能です。

中傷のタイプに関するセクションでは、最も関連性の高いタグが一覧表示されます。 

## タグの一覧

以下のタグの一覧をご覧ください。

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



