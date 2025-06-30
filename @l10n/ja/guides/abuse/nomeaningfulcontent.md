# 意味のないコンテンツ

意味のないコンテンツのインスタンス（例：意味不明な言葉）は、`abuse`セクションに記録され、`type`属性は`no_meaninful_content`に設定されます。

この機能は、ハッカーによる意味のないコンテンツの大量送信や、意味のない登録を検出するために使用されます。 

{% admonition type="warning" %}

`format`が`alias`に設定されている場合、コンテンツは異なる方法で分析され、全体として意味のないテキストであっても、意味のある部分を検索する可能性があります。

同様に、難読化に頻繁に使用される文字（例：アスタリスク）は、異なる解釈を引き起こす可能性があります。

{% /admonition %}

## 例

リクエスト：
```json
{
  "language":"en",
  "content":"asdkjasldkasdaasa",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```

レスポンス：
```json
{
	"text": "asdkjasldkasdaasa",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 17,
			"text": "asdkjasldkasdaasa",
			"type": "no_meaningful_content",
			"severity": "low",
			"explanation": "Unidentifed (English)"
		}
	]
}
```
