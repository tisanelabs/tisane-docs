# Утверждение иерархии

Случаи насильственного утверждения иерархии в сообществе регистрируются в разделе `abuse` с присвоением атрибуту `type` значения `social_hierarchy`.

К таким случаям относятся:

* помешанность на контроле
* издевательства на рабочем месте (например, так называемое [ притеснение с помощью власти](https://en.wikipedia.org/wiki/Power_harassment) в Японии и Южной Корее)
* принуждение определенной группы «знать свое место» (например, новых членов сообщества)


## Например:

Запрос:

```json
{
  "language":"en",
  "content":"newbies should know their place",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```

Ответ:

```json
{
	"text": "newbies should know their place",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 31,
			"text": "newbies should know their place",
			"type": "social_hierarchy",
			"severity": "medium",
			"explanation": "Assertion on what newcomers should do"
		}
	]
}
```