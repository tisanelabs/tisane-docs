# 感情分析

感情分析は、著者が物事に対して肯定的か否定的かを判断します。検出された感情のインスタンスは、`sentiment_expressions`セクションに記録され、`polarity`が、感情が以下のように分類されるかを決定します。

* `positive`
* `negative`
* `mixed`

## オプション設定

* `explain` - `true`の場合、フラグ付けの説明が含まれます
* `snippets` -  `true`の場合、感情を表現するフラグメントが含まれます
* `document_sentiment` - `true`の場合、テキスト全体の全体的な感情がルートレベルの`sentiment`属性として提供されます。 

## アスペクトベースの感情分析（ABSA）とは

Wikipediaは、[ABSA](https://en.wikipedia.org/wiki/Sentiment_analysis#Feature/aspect-based)を文書や投稿全体に単一の感情スコアを割り当てるのではなく、レビューで言及された特定の側面に対する感情を特定するアプローチと定義しています。 

本質的に、アスペクトベースの感情分析は、感情分析に対してカラーテレビが白黒テレビに対して行ったのと同じ役割（深みと明瞭さを加える）を果たします。

このレビューを検討しましょう。

> 「朝食は少し味が薄かったですが、ホテルは主要な観光地に近いです」 

ホテルのオーナーが実用的な情報を求めている場合、以下の点を理解する必要があります。

- **食**に対する感情は否定的なものです。**
- **立地**に対する感情は肯定的なものです。**

0.14や-0.57のような単一の感情スコアは、ここでは意味を成しません。複数の多面的なレビューを統合すると、このようなスコアは実際の顧客の感情を正確に反映しない誤った印象を与えることになります。

{% admonition type="info" %}

感情分析をより積極的に行うためには、`format`設定を`review`に設定することをおすすめします。

{% /admonition %}

## 例

リクエスト：

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

レスポンス：

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