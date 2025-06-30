# ヒエラルキーの主張

コミュニティ内でヒエラルキーを強く主張する行為は、`abuse`セクションに記録され、`type`属性が`social_hierarchy`に設定されます。

これらのインスタンスには、以下のものが含まれます。

* コントロールフリークであること
* 職場でのいじめ（例：日本や韓国でいわゆる[パワーハラスメント](https://en.wikipedia.org/wiki/Power_harassment)と呼ばれる行為）
* 特定の集団に「自分の立場を自覚させる」こと（例：コミュニティの新規メンバーなど）


## 例

リクエスト：

```json
{
  "language":"en",
  "content":"newbies should know their place",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```

レスポンス：

```json
{
	"text": "newbies should know their place",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 31,
			"text": "newbies should know their place",
			"type": "social_hierarchy",
			"severity": "medium",
			"explanation": "Assertion on what newcomers should do"
		}
	]
}
```