# Анализ тональности

Анализ тональности отвечает на вопрос, относится ли автор к чему-либо положительно или отрицательно. Случаи обнаруженных настроений регистрируются в разделе ` sentiment_expressions`; ` polarity` определяет, является ли настроение:

* `positive`
* `negative`
* `mixed`

## Дополнительные настройки

* `explain` - если` true`, включает в себя объяснение для пометки
* `snippets` — если `true` , включает фрагмент, отвечающий за настроение
* `document_sentiment` — если `true`, общая тональность всего текста представлена в атрибуте корневого уровня `sentiment` . 

## Что такое аспектный анализ тональности (ABSA)?

Википедия определяет [ABSA](https://en.wikipedia.org/wiki/Sentiment_analysis#Feature/aspect-based) как подход, который определяет тональность для конкретных аспектов, упомянутых в обзоре, а не присваивает единую оценку тональности всему документу или посту. 

По сути, аспектный анализ тональности делает для анализа тональности то же, что цветное телевидение сделало для черно-белого телевидения: он добавляет глубину и ясность.

Рассмотрим этот обзор:

> «Завтрак был немного безвкусным, но отель расположен недалеко от основных достопримечательностей». 

Владельцу отеля, который ищет практически применимую информацию, необходимо знать, что:

- Отношение к **food** является *negative*.
- Отношение к **location** является *positive*.

Единый показатель тональности, например 0,14 или -0,57, здесь не имел бы смысла. При объединении множества разносторонних отзывов такие оценки создают вводящую в заблуждение картину, которая не отражает реальных настроений клиентов.

{% admonition type="info" %}

Рекомендуется установить для настройки `format` значение `review`, чтобы более настойчиво искать признаки тональности.

{% /admonition %}

## Пример

Запрос:

```json
{
  "language":"en",
  "content":"The breakfast was a bit tasteless but the hotel is close to the major attractions",
  "settings": 
  {
    "format":"review", "snippets":true, "document_sentiment":true
  }
}
```

Ответ:

```json
{
	"text": "The breakfast was a bit tasteless but the hotel is close to the major attractions",
	"sentiment": 0.12345679012345679,
	"sentiment_expressions": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 33,
			"text": "The breakfast was a bit tasteless",
			"polarity": "negative",
			"reasons": [
				"tasteless"
			],
			"targets": [
				"food"
			]
		},
		{
			"sentence_index": 0,
			"offset": 38,
			"length": 43,
			"text": "the hotel is close to the major attractions",
			"polarity": "positive",
			"targets": [
				"location"
			]
		}
	]
}
```