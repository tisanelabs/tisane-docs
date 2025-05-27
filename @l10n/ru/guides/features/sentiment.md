# Sentiment Analysis

Sentiment analysis answers the question whether the author is positive or negative about something. Instances of detected sentiment are logged under the `sentiment_expressions` section; `polarity` determines if the sentiment is:

* `positive`
* `negative`
* `mixed`

## Optional Settings

* `explain` - if `true`, includes the explanation for flagging
* `snippets` - if `true`, includes the fragment responsible for the sentiment
* `document_sentiment` - if `true`, the overall sentiment of the entire text is provided at the root-level `sentiment` attribute. 

## What Is Aspect-based Sentiment Analysis (ABSA)?

Wikipedia defines [ABSA](https://en.wikipedia.org/wiki/Sentiment_analysis#Feature/aspect-based) as an approach that identifies sentiment for specific aspects mentioned in a review, rather than assigning a single sentiment score to the entire document or post. 

In essence, aspect-based sentiment analysis does for sentiment analysis what color TV did for black-and-white TV: it adds depth and clarity.

Consider this review:

> "The breakfast was a bit tasteless but the hotel is close to the major attractions". 

A hotel owner looking for actionable insights needs to know that:

- Sentiment towards **food** is *negative*.
- Sentiment towards **location** is *positive*.

A single sentiment score like 0.14 or -0.57 would be meaningless here. When aggregated across multiple multi-faceted reviews, these types of scores create a misleading picture that fail to capture real customer sentiment.

{% admonition type="info" %}

It is recommended to set the `format` setting to `review` to look for sentiment more aggressively.

{% /admonition %}

## Example

Request:

```json
{
  "language":"en",
  "content":"The breakfast was a bit tasteless but the hotel is close to the major attractions",
  "settings": 
  {
    "format":"review", "snippets":true, "document_sentiment":true
  }
}
```

Response:

```json
{
	"text": "The breakfast was a bit tasteless but the hotel is close to the major attractions",
	"sentiment": 0.12345679012345679,
	"sentiment_expressions": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 33,
			"text": "The breakfast was a bit tasteless",
			"polarity": "negative",
			"reasons": [
				"tasteless"
			],
			"targets": [
				"food"
			]
		},
		{
			"sentence_index": 0,
			"offset": 38,
			"length": 43,
			"text": "the hotel is close to the major attractions",
			"polarity": "positive",
			"targets": [
				"location"
			]
		}
	]
}
```