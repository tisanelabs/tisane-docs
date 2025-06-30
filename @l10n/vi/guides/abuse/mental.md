# Vấn đề về tâm thần

Các phát ngôn cho thấy dấu hiệu vấn đề tâm thần, tự hại, ý nghĩ tự sát hoặc có kế hoạch tự sát khi bị phát hiện sẽ được ghi nhận trong mục `abuse`, với thuộc tính `type` được đặt là `mental_issues`.

## Thẻ liên quan

* `bodily_harm` - tự gây hại cơ thể
* `death` -  ý nghĩ về cái chết hoặc tự sát
* `threat` - đe dọa tự sát

## Các mức độ nghiêm trọng

Các mức độ nghiêm trọng được phân loại như sau:

* `low` (thấp) - phát ngôn không mang tính đe dọa
* `medium` (trung bình) -  phát ngôn cho thấy dấu hiệu trầm cảm hoặc rối loạn tâm thần
* `high` (cao) -  trầm cảm nặng, có ý nghĩ về cái chết hoặc làm hại bản thân
* `extreme` (rất cao) - có kế hoạch tự sát

## Ví dụ

Yêu cầu:

```json
{
  "language": "en",
  "content": "i always feel sad",
  "settings": {
    "snippets": false, "explain": true
  }
}
```

Phản hồi:

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
