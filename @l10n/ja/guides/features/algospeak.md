# スラングと敵対的文章操作

Tisaneは、特殊な組み込みスペルチェッカーモジュールを用いて意図しない誤り（スペルミス）と敵対的文章操作（例：スラング）の両方を処理します。 

このスペルチェッカーは複数の技術を採用しており、さまざまな種類の操作（文字のマスキング、置換など）に対応できます。これらの修正は、卑猥な言葉や差別的な表現に限らず、文脈を考慮して行われます。同じ誤字は、異なる文脈では異なる意味に解釈される可能性があります。

文章に修正が必要と判断された場合、その文に`corrected_text`属性が付与され、修正されたテキストが記録されます（`words`を`true`に設定して、文章のデータを出力します）。

## 制限事項

スペルチェックは、多くの人が考えているような[「正しい単語を提案する」ツール](https://stackoverflow.com/questions/307291/how-does-the-google-did-you-mean-algorithm-work)ではありません。

- 正当な単語である場合、誤用や専門用語であっても、Tisaneは訂正しません。例えば、「noun」が 「nun」と誤って入力された場合、または「house」が「horse」と誤って入力された場合、Tisaneは対応できません（ただし、既知の難解な概念の一部である場合を除く。例えば、英語の「corn star」など）。********__
- スペルチェッカーの主な目的は、難読化された表現を解読することです。そのため、スペルチェッカーは、より卑猥、不快、または頻繁に使用される概念に偏っています。

## 専門的な意味や言葉を排除して、より良好な結果を取得

この問題を回避するには、 `min_generic_frequency`パラメータを使用できます。 

これにより、最も専門的な意味や単語を除外することができます。 

頻度は0から10のスケールで評価され、10が最も高い頻度を示します。 

一部の専門的な意味は、-10で評価されます。 

まず、`min_generic_frequency`を`1`または`2`に設定して、ご自身の環境で正常に動作するか確認することをおすすめします。

## 潜在的な固有名詞の除外

固有名詞のスペルチェックを無効にしたい場合は、`lowercase_spellcheck_only`を`true`に設定します。

## 例

リクエスト：
```json
{
  "language":"en",
  "content":"I will br*k his neck and kll him",
  "settings": 
  {
    "words":true,"topics":false,"sentiment":false,"snippets":true
  }
}
```

レスポンス：
```json

	"text": "I will br*k his neck and kll him",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 32,
			"text": "I will br*k his neck and kll him",
			"type": "criminal_activity",
			"severity": "medium",
			"tags": [
				"threat",
				"violence",
				"death"
			]
		}
	],
	"sentence_list": [
		{
			"offset": 0,
			"text": "I will br*k his neck and kll him",
			"words": [
				{
					"type": "word",
					"offset": 0,
					"text": "I",
					"lettercase": "capitalized",
					"role": "agent",
					"lexeme": 63061,
					"family": 301,
					"grammar": [
						"PRON"
					],
					"stopword": true
				},
				{
					"type": "word",
					"offset": 2,
					"text": "will",
					"lexeme": 146938,
					"family": 316,
					"grammar": [
						"VERB"
					],
					"stopword": true
				},
				{
					"type": "word",
					"offset": 7,
					"text": "br*k",
					"role": "verb",
					"lexeme": 20996,
					"family": 107846,
					"grammar": [
						"VERB"
					]
				},
				{
					"type": "word",
					"offset": 12,
					"text": "his",
					"lexeme": 63064,
					"family": 303,
					"grammar": [
						"DET"
					],
					"stopword": true
				},
				{
					"type": "word",
					"offset": 16,
					"text": "neck",
					"lexeme": 93293,
					"family": 40510,
					"wikidata": "Q9633",
					"grammar": [
						"NOUN"
					]
				},
				{
					"type": "word",
					"offset": 21,
					"text": "and",
					"lexeme": 4096,
					"family": 322,
					"grammar": [
						"CCONJ"
					],
					"stopword": true
				},
				{
					"type": "word",
					"offset": 25,
					"text": "kll",
					"role": "verb",
					"lexeme": 77380,
					"family": 113102,
					"grammar": [
						"VERB"
					]
				},
				{
					"type": "word",
					"offset": 29,
					"text": "him",
					"role": "patient",
					"lexeme": 63062,
					"family": 303,
					"grammar": [
						"PRON"
					],
					"stopword": true
				}
			],
			"corrected_text": "I will break his neck and kill him"
		}
	]
}
```