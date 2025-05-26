# Mental Issues

Detected utterances indicating mental issues, self-harm, suicidal thoughts, or plans to commit suicide are logged under the `abuse` section, with the `type` attribute set to `mental_issues`.

## Relevant Tags

* `bodily_harm` - self-harm
* `death` - thoughts about death or suicide
* `threat` - threatening suicide

## Severity Levels

The severity levels are as following:

* `low` - non-threatening utterances
* `medium` - utterances indicative of depression or mental illness
* `high` - severe depression, thoughts about death, or bodily harm
* `extreme` - planning suicide

## Example

Request:

```json
{
  "language": "en",
  "content": "i always feel sad",
  "settings": {
    "snippets": false, "explain": true
  }
}
```

Response:

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
