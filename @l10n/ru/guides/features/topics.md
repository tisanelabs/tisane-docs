# Извлечение тем

Извлечение тем определяет доминирующие темы в тексте. 

{% admonition type="info" %}

Эта функциональность также известна как:

* идентификация темы
* обнаружение предмета
* распознавание ключевой темы

{% /admonition %}

Tisane хранит темы в массиве `topics` (строки без `topic_stats`, объекты с `topic_stats`). Темы находятся на уровне документа.

Когда определенное слово имеет несколько толкований, его смысл необходимо определять в текущем контексте. Например, _Юпитер_ планета и римское божество. Планета это или божество, зависит от текста.

Например, предложение _Юнона — жена Юпитера_ относится к божеству. Tisane определяет соответствующие темы как `Roman mythology`, `supernatural` (боги), `relationship` и`family` (поскольку упоминается супружеская связь).

```json
{
	"text": "Juno is the wife of Jupiter",
	"topics": [
		"supernatural",
		"Roman mythology",
		"relationship",
		"family"
	]
}
```

С другой стороны, предложение _Юпитер находится дальше от Солнца, чем Марс_ относится к планетам. Tisane определяет темы, которые будут `outer space` и ` astronomy`.

```json
{
	"text": "Jupiter is farther from the sun than Mars",
	"topics": [
		"outer space",
		"astronomy"
	]
}
```

## Статистика темы

Если для настройки `topic_stats` установлено значение `true`, указывается часть введенной информации, где тема активна. В этом случае тема предоставляется не как строка, а как объект, созданный из самой темы (атрибут `topic` (строка)) и его статистика распределения (атрибут `coverage` (число в экспоненциальной форме)).

**Пример**

Запрос:

```json
{
  "language":"en",
  "content":"Jupiter is farther from the sun than Mars. Which is not important in the current context",
  "settings": 
  {
    "topic_stats": true
  }
}
```

Ответ:

```json
{
	"text": "Jupiter is farther from the sun than Mars. Which is not important in the current context",
	"topics": [
		{
			"topic": "outer space",
			"coverage": 0.5
		},
		{
			"topic": "astronomy",
			"coverage": 0.5
		}
	]
}
```
(both detected topics appear in 1 sentence out of 2, which is 0.5 of all sentences)

## Стандарты

Существуют общие стандарты таксономии, которые Tisane может использовать с параметром `topic_standard`:

* `native` — нативные названия тем Tisane; основаны на стандартных английских терминах для данной темы. Стандарт по умолчанию.
* `iptc_code` — коды классификации [IPTC (темы СМИ, установленные Международным советом по прессе и телекоммуникациям)](https://iptc.org/standards/media-topics/) — стандарт, используемый в средствах массовой информации.
* `iptc_description` — английские описания кодов IPTC.
* `iab_code` — коды таксономии контента [IAB (Бюро интерактивной рекламы)](https://www.iab.com/guidelines/content-taxonomy/).
* `iab_description` — английские описания кодов IAB.
* `wikidata` — коды Wikidata (обычно в форме Qnnnnn, например Q123).

Чтобы указать стандарт, добавьте параметр `topic_standard`. 

**Пример**

Запрос:

```json
{
  "language":"en",
  "content":"Jupiter is farther from the sun than Mars.",
  "settings": 
  {
    "topic_standard": "wikidata"
  }
}
```

Ответ:

```json
{
	"text": "Jupiter is farther from the sun than Mars. Which is not important in the current contex",
	"topics": [
		"Q4169",
		"Q333"
	]
}
```


{% admonition type="warning" %}

Стандартные таксономии охватывают лишь небольшую часть нативного стандарта. Если понятие не охвачено таксономией, оно исключается из ответа.

{% /admonition %}