# 成人向けコンテンツ

成人向けコンテンツは、通常はお子様向けのコミュニティでは制限されていますが、成人向けのコミュニティでは許容されます。検出された成人向けコンテンツのインスタンスは、`abuse`セクションに記録され、`type`属性は`adult_only`に設定されます。 

これには以下のものが含まれます。

* 性的内容または性に関する話題への言及。関連タグ：`sex`
* 薬物やアルコールの摂取に関する言及。関連タグ：`controlled_substance`。言及された薬物に関連するタグも使用されます。詳細はこちら：[犯罪行為](./criminalactivity.md)

## 例

リクエスト：
```json
{
  "language":"en",
  "content":"we drank so much beer last week",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```

レスポンス：
```json
{
	"text": "we drank so much beer last week",
	"topics": [
		"alcoholic beverage",
		"beverage"
	],
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 31,
			"text": "we drank so much beer last week",
			"type": "adult_only",
			"severity": "medium",
			"explanation": "Statement indicating collective consumption of alcoholic beverages",
			"tags": [
				"controlled_substance"
			]
		}
	]
}
```