# 告発

告発とは、不正行為に関する主張または非難を指します。その不適切な行為は犯罪に該当しないかもしれませんが、人物の評判を損なってしまう可能性があります。検出された告発のインスタンスは、`abuse`セクションに記録され、`type`属性は`allegation`に設定されます。 

告発の検出は、以下の目的で使用されます。

* レビューサイトやマーケットプレイスでの[レビュー爆撃](https://en.wikipedia.org/wiki/Review_bomb)の防止
* 大規模な荒らし、特に著名人のアカウントに対する攻撃をブロック（`personal_attack`の検出機能と組み合わせて使用する必要があります）。
* コミュニティやアカウントに投稿された名誉毀損の申し立てに基づく訴訟を防止
* 評判を損なうことを防止

関連タグ：ほぼすべてのタグが該当します。これは、告発の範囲が広範であるためです。

{% admonition type="warning" %}

Tisaneは、提起された告発の真偽について推測しません。申し立ての真偽を判断することは、Tisaneの業務範囲外です。

{% /admonition %}

## 例

リクエスト：
```json
{
  "language":"en",
  "content":"He is a pickpocket",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```


レスポンス：
```json
{
	"text": "He is a pickpocket",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 18,
			"text": "He is a pickpocket",
			"type": "allegation",
			"severity": "medium",
			"explanation": "Allegation of someone being a guilty party"
		}
	]
}
```

こちらも参考：[犯罪行為・告発・迷惑行為の違い](./criminalallegationdisturbing.md)