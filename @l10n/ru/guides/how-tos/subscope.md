# Токенизация URL-слагов и хэштегов

Tisane может анализировать слаги и хэштеги, рассматривая их как предложения, разбивая их на слова и извлекая темы и сущности, как в обычном тексте.

Установите `subscope` на `true` для принудительной токенизации подобластей.

## Например:

Запрос:

```json
{
  "language": "en",
  "content": "https://www.tastingtable.com/946284/unconventional-uses-for-vodka-other-than-drinking/ ",
  "settings": {
    "subscope": true
  }
}
```

Ответ:

```json
{
	"text": "https://www.tastingtable.com/946284/unconventional-uses-for-vodka-other-than-drinking/ ",
	"topics": [
		"beverage",
		"alcoholic beverage",
		"hard liquor"
	],
	"entities_summary": [
		{
			"type": "item_of_interest",
			"name": "vodka",
			"wikidata": "Q374",
			"mentions": [
				{
					"sentence_index": 0,
					"offset": 60,
					"length": 5
				}
			],
			"subtypes": [
				"controlled_substance"
			],
			"subtype": "controlled_substance"
		}
	]
}
```