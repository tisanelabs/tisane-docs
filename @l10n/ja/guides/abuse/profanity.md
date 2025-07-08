# 卑猥な言葉

卑猥な言葉は`abuse`セクションに記録され、`type`属性は`profanity`に設定されます。

{% admonition type="warning" %}

人種差別的な表現やその他の中傷的な表現は、卑猥な言葉とはみなされません。これらは`bigotry`タイプによって処理されます。 

参考：[偏見・ヘイトスピーチ](./hatespeechandbigotry.md) 

{% /admonition %}

## 重大度

重大度は以下の通りです。

* `low` - 非常に軽度の卑猥な言葉で、通常は卑猥な言葉とは見なされないもの
* `medium` - 大部分が卑猥な言葉
* `high` - 極めて不適切な卑猥な言葉
* `extreme` - 通常「到底で容認できない」卑猥な言葉（例：英語のFワードや[スラブ語の「mat」カテゴリーに該当する言葉](https://en.wikipedia.org/wiki/Mat_(profanity)))

難読化（例：伏せ字の使用）は、重大度に影響しません。

## 関連タグ

以下のタグは、`profanity`タイプと関連付けられることが多いです。

* `sex` - 性行為や性器に関する卑猥な言葉

## 例

リクエスト：
```json
{
  "language":"en",
  "content":"i hate this fu*r",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```

レスポンス：
```json
{
	"text": "i hate this fu*r",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 12,
			"length": 4,
			"text": "fu*r",
			"type": "profanity",
			"severity": "extreme",
			"tags": [
				"sex"
			]
		}
	]
}
```
