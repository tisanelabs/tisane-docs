# Преступная деятельность

Tisane регистрирует случаи обнаруженной преступной деятельности в разделе `abuse` с присвоением атрибуту `type` значения `criminal_activity`. 

## Что мы обнаруживаем

Мы идентифицируем и помечаем текст, связанный со следующим:

- Планирование и координация транспортировки, распространения и производства незаконных товаров, таких как наркотики, оружие, взрывчатые вещества, и контрабанда диких животных.
- Торговля людьми и продажа человеческих органов.
- Запросы и инструкции по созданию, производству, распространению или использованию оружия (включая химическое и биологическое оружие), наркотиков и взрывчатых веществ.
- Угрозы насилия и преступной деятельности.
- Поиск запрещенных предметов, например, огнестрельного оружия, боеприпасов, взрывчатых веществ. Для анализа поисковых запросов задайте для параметра `format` значение `search`.

{% admonition type="warning" %}

1. Тип преступной деятельности не охватывает разговоры о преступлениях, совершенных кем-то другим, или обвинения. Цель типа `criminal_activity` — фиксация данных о совершаемом преступлении или признания преступной деятельности. Чтобы зафиксировать разговоры о преступной деятельности, используйте функцию извлечения темы. Рекомендуем ознакомиться: [Извлечение темы](../features/topics.md) . Чтобы собрать информацию о преступлениях, совершенных кем-то другим, см.: [Обвинения](./allegation.md)
2. Поскольку законодательство различается в зависимости от юрисдикции, ознакомьтесь с `тегами` чтобы определить, следует ли игнорировать данный экземпляр. Например, теги `cannabis` («каннабис») или `soft_drug` («слабый наркотик») могут использоваться для игнорирования упоминаний об употреблении марихуаны.

{% /admonition %}

### Например:

Запрос:

```json
{
	"language":"en",
	"content":"we sell elephant tusks. Great prices and top notch quality!", 
	"settings": 
  {
	 "snippets":true
  }
}
```

Ответ:
```json
{
	"text": "we sell elephant tusks. Great prices and top notch quality!",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 23,
			"text": "we sell elephant tusks.",
			"type": "criminal_activity",
			"severity": "high",
			"tags": [
				"for_sale",
				"wildlife"
			]
		}
	]
}
```

## Соответствующие теги

Массив `tags` может содержать следующие теги.

### Преступления

* `bodily_harm`
* `bribery`
* `call_for_violence`
* `crime`
* `death`
* `doxing`
* `escape` (исправительные учреждения)
* `extortion`
* `hacking_services`
* `human_trafficking`
* `money_laundering`
* `organized_crime`
* `organ_trade`
* `pedophilia`
* `piracy`
* `scam`
* `tax_evasion`
* `terrorism`
* `threat`
* `violence`
* `wildlife` (браконьерство)

### Контролируемые вещества

* `controlled_substance`
* `soft_drug`
* `cannabis`
* `khat`
* `hard_drug`
* `cocaine`
* `ecstasy`
* `hallucinogen`
* `heroin`
* `meth`
* `medication`
* `opioid`

### Другие ограниченные предметы

* `cold_weapons`
* `explosives`
* `firearms`
* `weapon`
* `contraband` (зависит от контекста)

### Прочие

* `admission` — признание в преступлении
* `credentials`
* `cryptocurrency`
* `debt`
* `payment`

## Соответствующие типы сущностей

`item_of_interest` entity type detects items potentially of interest to the investigation: luxury items, drugs, medications, vehicles.

## Использование в офлайн-режиме и правоохранительными органами

Приложениям правоохранительных органов часто приходится работать в изолированных средах. Чтобы удовлетворить эту потребность, доступен инструмент [Tisane Embedded](../../sdks/index.md). Tisane Embedded позволяет запускать Tisane как внутрипроцессную библиотеку. Также досупны [On-prem installations](/guides/deployment/onprem) («Локальные установки»). 


