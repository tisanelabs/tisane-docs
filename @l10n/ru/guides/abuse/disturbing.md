# Беспокоящий контент

Обнаруженные графические описания насилия или травм регистрируются в разделе `abuse` с присвоением атрибуту `type` значения `disturbing`.

{% admonition type="warning" %}

Беспокоящий контент может быть как связан с преступной деятельностью, так и не связан с ней. Рекомендуем ознакомиться: [Разница между преступной деятельностью, обвинением и нарушением порядка](./criminalallegationdisturbing.md)

{% /admonition %}

## Например:

Запрос:

```json
{
	"language":"en",
	"content":"his finger was cut off", 
	"settings": 
  {
	 "snippets":true
  }
}
```

Ответ:

```json
{
	"text": "his finger was cut off",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 22,
			"text": "his finger was cut off",
			"type": "disturbing",
			"severity": "extreme"
		}
	]
}
```