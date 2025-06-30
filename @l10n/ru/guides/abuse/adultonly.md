# Контент только для взрослых

Контент только для взрослых — это контент, который обычно ограничен в сообществах для детей, но приемлем в сообществах для взрослых. Случаи обнаружения контента только для взрослых регистрируются в разделе `abuse` с присвоением `type` атрибута `adult_only`. 

К такому контенту относятся:

* эротические материалы или упоминания тем, связанных с сексом. Соответствующий тег: `sex`
* упоминания употребления наркотиков и алкоголя. Соответствующий тег: `controlled_substance`. Также используются теги, связанные с упоминанием наркотиков. Подробнее: [Преступная деятельность](./criminalactivity.md).

## Например:

Запрос:
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

Ответ:
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