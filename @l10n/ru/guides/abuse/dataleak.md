# Утечки данных

Случаи утечки данных и т.п. регистрируются в разделе `abuse` с присвоением атрибуту `type` значения `data_leak`.

## Соответствующие теги

Следующие теги часто связываются с типом `data_leak`:

* `pii` — персональная идентифицируемая информация (ПИИ).
* `credentials` — электронные учетные данные, такие как имена пользователей, учетные записи, пароли.
* `payment` — данные, связанные с платежами.

## Например:

Запрос:

```json
{
  "language":"en",
  "content":"List of paypal accounts and ready for use",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```

Ответ:
```json
{
	"text": "List of paypal accounts and ready for use",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 23,
			"text": "List of paypal accounts",
			"type": "data_leak",
			"severity": "medium",
			"explanation": "List of web service accounts",
			"tags": [
				"data",
				"payment",
				"credentials",
				"pii"
			]
		}
	]
}
```
