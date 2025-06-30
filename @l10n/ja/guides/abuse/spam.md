# スパム

スパムのインスタンスは`abuse`セクションで記録され、`type`属性は`spam`に設定されます。 

{% admonition type="warning" %}

現在、Tisaneのスパム検出機能は限定的です。Tisaneは、レビュー、プロフィール、ユーザー名におけるスパム対策に注力しています。

{% /admonition %}

## 例

リクエスト：
```json
{
  "language":"en",
  "content":"Luxury watches are affordable in Antarctica!",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```


レスポンス：
```json
{
	"text": "Luxury watches are affordable in Antarctica!",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 43,
			"text": "Luxury watches are affordable in Antarctica",
			"type": "spam",
			"severity": "medium",
			"explanation": "Luxury items are cheap!",
			"tags": [
				"clickbait",
				"luxury",
				"sold_by_spammers"
			]
		}
	]
}
```