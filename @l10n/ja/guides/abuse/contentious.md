# 論争を招くコンテンツ

論争を招く可能性のあるコンテンツのインスタンスは、`abuse`セクションに記録され、`type`属性は`contentious`に設定されます。 

これらのインスタンスには、以下のものが含まれます。

* ある地政学的存在が国家であるか否か、または他の地政学的存在に属するという主張
* 保護対象に該当しない社会集団に関する主張または一般論
* 地政学的存在に対する否定的な態度
* 政治的な行動の呼びかけ（特に、議論を呼ぶようなものの場合）
* 国際的に悪名高い歴史的人物に賛同する主張
* 争いを引き起こすために作成した挑発的な偽名

{% admonition type="info" %}

こうした概念そのものが議論の的となる可能性があります。これは、以下の2つの相反する懸念に対応するために作成されました。

1. コミュニティが、対立的な議論（ヘイトスピーチ（や偏見）ではない）であっても政治的な議論を許可したい場合。
2. コミュニティが、あらゆる種類の活動（例：編み物や旅行などに関連するライフスタイルコミュニティ）を禁止したい場合。

{% /admonition %}

## 例

リクエスト：
```json
{
  "language":"en",
  "content":"Voldermort is a loser",
  "settings": 
  {
    "format":"alias", "snippets":true, "explain":true
  }
}
```


レスポンス：
```json
{
	"text": "Voldermort is a loser",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 21,
			"text": "Voldermort is a loser",
			"type": "contentious",
			"severity": "medium",
			"explanation": "Nickname saying someone is bad person"
		}
	]
}
```