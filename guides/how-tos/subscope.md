# Tokenizing URL Slugs and Hashtags

Tisane can analyze slugs and hashtags, treating them as sentences, tokenizing them into words, and extracting topics and entities like in normal text.

Set `subscope` to `true` to force tokenizing subscopes.

## Example:

Request:

```json
{
  "language": "en",
  "content": "https://www.tastingtable.com/946284/unconventional-uses-for-vodka-other-than-drinking/ ",
  "settings": {
    "subscope": true
  }
}
```

Response:

```json
{
	"text": "https://www.tastingtable.com/946284/unconventional-uses-for-vodka-other-than-drinking/ ",
	"topics": [
		"beverage",
		"alcoholic beverage",
		"hard liquor"
	],
	"entities_summary": [
		{
			"type": "item_of_interest",
			"name": "vodka",
			"wikidata": "Q374",
			"mentions": [
				{
					"sentence_index": 0,
					"offset": 60,
					"length": 5
				}
			],
			"subtypes": [
				"controlled_substance"
			],
			"subtype": "controlled_substance"
		}
	]
}
```