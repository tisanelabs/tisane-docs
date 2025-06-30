# URLスラッグとハッシュタグのトークン化

Tisaneはスラッグやハッシュタグを分析し、それらを文章として扱い、単語にトークン化し、通常のテキストと同様にトピックやエンティティを抽出することができます。

サブスコープのトークン化を強制するには`subscope`を`true`に設定します。

## 例：

リクエスト：

```json
{
  "language": "en",
  "content": "https://www.tastingtable.com/946284/unconventional-uses-for-vodka-other-than-drinking/ ",
  "settings": {
    "subscope": true
  }
}
```

レスポンス：

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