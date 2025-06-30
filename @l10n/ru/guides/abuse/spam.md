# Спам

Случаи спама регистрируются в разделе `abuse` с присвоением атрибуту `type` значения `spam`. 

{% admonition type="warning" %}

В настоящее время наши возможности обнаружения спама ограничены. Мы в основном фокусируемся на спаме в отзывах, профилях и именах пользователей.

{% /admonition %}

## Например:

Запрос:
```json
{
  "language":"en",
  "content":"Luxury watches are affordable in Antarctica!",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```


Ответ:
```json
{
	"text": "Luxury watches are affordable in Antarctica!",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 43,
			"text": "Luxury watches are affordable in Antarctica",
			"type": "spam",
			"severity": "medium",
			"explanation": "Luxury items are cheap!",
			"tags": [
				"clickbait",
				"luxury",
				"sold_by_spammers"
			]
		}
	]
}
```