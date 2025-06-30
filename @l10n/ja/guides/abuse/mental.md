# メンタルヘルスに関する内容

メンタルヘルスに関する内容、自傷行為、自殺念慮、または自殺計画を示す発言は、`abuse`セクションに記録され、`type`属性は`mental_issues`に設定されます。

## 関連タグ

* `bodily_harm` - 自傷行為
* `death` - 死や自殺に関する考え
* `threat` - 自殺の恐れ

## 重大度

重大度は以下の通りです。

* `low` - 非脅迫的な発言
* `medium` - 抑うつ状態や精神疾患を示す発言
* `high` - 深刻な抑うつ状態、死について考える、または身体的な危害を加える発言
* `extreme` - 自殺計画

## 例

リクエスト：

```json
{
  "language": "en",
  "content": "i always feel sad",
  "settings": {
    "snippets": false, "explain": true
  }
}
```

レスポンス：

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
