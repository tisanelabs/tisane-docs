# Психические проблемы

Обнаруженные высказывания, указывающие на психические проблемы, членовредительство, мысли о самоубийстве или планы совершить самоубийство, регистрируются в разделе `abuse` с присвоением атрибуту `type` значения `mental_issues`.

## Соответствующие теги

* `bodily_harm` — причинение себе вреда
* `death` — мысли о смерти или самоубийстве
* `threat` — угроза самоубийством

## Уровни серьезности

Уровни серьезности следующие:

* `low` — неугрожающие высказывания
* `medium` — высказывания, указывающие на депрессию или психическое заболевание
* `high` — тяжелая депрессия, мысли о смерти или телесных повреждениях
* `extreme` — планирование самоубийства

## Например:

Запрос:

```json
{
  "language": "en",
  "content": "i always feel sad",
  "settings": {
    "snippets": false, "explain": true
  }
}
```

Ответ:

```json
{
  "text": "i always feel sad",
  "abuse": [
    {
      "sentence_index": 0,
      "offset": 0,
      "length": 17,
      "text": "i always feel sad",
      "type": "mental_issues",
      "severity": "high",
      "explanation": "Complaining about regular sadness"
    }
  ],
  "sentiment_expressions": [
    {
      "sentence_index": 0,
      "offset": 0,
      "length": 17,
      "text": "i always feel sad",
      "polarity": "negative",
      "explanation": "Complaining about regular sadness"
    }
  ]
}
```
