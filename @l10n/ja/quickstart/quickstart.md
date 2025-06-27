# Tisaneの利用を開始する
Tisane APIの設定と利用開始を手早く行う方法を学び、最初のステップを踏み出しましょう。

## ステップ1 – アカウントを作成する

<a href="https://dev.tisane.ai/signup/" target="_blank">Sign up to Tisane API</a> 

無料のコミュニティプランは、最大50,000件のリクエストに対応し、1分あたり10件のリクエストが上限です（ご希望の場合、有料プランをご購入いただけます）。

## ステップ2 – APIキーを取得する

Tisane APIは、リクエストの認証にAPIキーを使用します。<a href="https://dev.tisane.ai/profile" target="_blank">開発者プロファイル</a> にアクセスして、APIキーを確認および管理します。

## ステップ3 – APIを利用する

 `POST /parse`メソッドを呼び出します。このメソッドのリクエスト本文には、3つの属性が必要です。

- `content`（文字列）
- `language`（文字列）
- `settings`（オブジェクト）

**例**：  

リクエスト：
 ```json
    {
      "language": "en", 
      "content": "Hello Tisane API", 
      "settings": {}
    }
 ```
 レスポンス：
 ```json
 {
	"text": "Hello Tisane API",
	"topics": [
		"natural language processing",
		"artificial intelligence"
	],
	"entities_summary": [
		{
			"type": "software",
			"name": "Tisane API",
			"mentions": [
				{
					"sentence_index": 0,
					"offset": 6,
					"length": 10
				}
			]
		}
	]
}
```

|パブリッククラウドでは、JSON本文の長さは最大2048バイトです。オンプレミス版では、より長いリクエストが利用可能です。|
|-----------------------------------------|

このポータルでリクエストをテストするか、 <a href="https://dev.tisane.ai/api-details#api=5a3b6668a3511b11cc292655&operation=5a3b7177a3511b11cc29265c" target="_blank">開発者向けポータル</a>の「 試してみる」オプションを使用します。__
curl、Postman、Insomnia、またはその他のRESTfulツールを使用してテストすることもできます。

### curl構文 

```curl
curl -V -X POST \
  https://api.tisane.ai/parse \
  -H "Ocp-Apim-Subscription-Key: your_primary_or_secondary_API_key;_not_needed_on-prem" \
  -H "Content-Type: application/json" \
  -d '{
    "language": "en",
    "content": "Hello Tisane API!",
    "settings": {}
  }'
  ```

## トラブルシューティング

APIは標準の**POSTリクエスト**経由で動作します。 

タイムアウトエラーが発生した場合：
- ネットワーク接続を確認してください。

---

401（Unauthorized）のエラーコードが表示される場合：
```json
{
	"statusCode": 401,
	"message": "Access denied due to invalid subscription key. Make sure to provide a valid key for an active subscription."
}
```
- `Ocp-Apim-Subscription-Key`ヘッダーの値として正しいAPIキーが指定されていることを確認してください。 

{% admonition type="info" %}

このドキュメントポータルでAPIキーを使用するには、「試してみる」 ページの「セキュリティ」ボタンをクリックします。____

(The Developer Portal automatically fills the API key when you sign in.)

{% /admonition %}

---

データベースに言語が見つからないという内容の400（Bad Request）のエラーコードが表示される場合：
- ISO-639-1言語コードが正しく指定されていることを確認し、その言語がTisaneでサポートされていることを確認してください。

さらにサポートが必要な場合：

* [サポートへお問い合わせください。](../support/support.md)問題の原因を調査し、ご対応いたします。
* [トラブルシューティングのヒント](../support/troubleshooting.md)

次の項目：

* [問題のあるコンテンツの検出方法](../guides/how-tos/detectabuse.md)
* [サポートされているNLP機能の一覧](../guides/features/functionality.md)
* [対応言語一覧](../guides/features/languages.md)