# データ漏洩

データ漏洩などのインスタンスは、`abuse`セクションに記録され、`type`属性が`data_leak`に設定されます。

## 関連タグ

以下のタグは、`data_leak`のタイプとよく関連付けられています。

* `pii` - 個人を特定できる情報（PII）
* `credentials` - 電子認証情報（ユーザー名、アカウント、パスワードなど）
* `payment` - 支払いに関するデータ

## 例

リクエスト：

```json
{
  "language":"en",
  "content":"List of paypal accounts and ready for use",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```

レスポンス：
```json
{
	"text": "List of paypal accounts and ready for use",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 23,
			"text": "List of paypal accounts",
			"type": "data_leak",
			"severity": "medium",
			"explanation": "List of web service accounts",
			"tags": [
				"data",
				"payment",
				"credentials",
				"pii"
			]
		}
	]
}
```
