# 不安を引き起こす内容

暴力や負傷の生々しい描写が検出された場合、`abuse`セクションに記録され、`type`属性は`disturbing`に設定されます。

{% admonition type="warning" %}

不快なコンテンツが犯罪行為に該当するかどうかは状況によります。参考：[犯罪行為・告発・迷惑行為の違い](./criminalallegationdisturbing.md)

{% /admonition %}

## 例

リクエスト：

```json
{
	"language":"en",
	"content":"his finger was cut off", 
	"settings": 
  {
	 "snippets":true
  }
}
```

レスポンス：

```json
{
	"text": "his finger was cut off",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 22,
			"text": "his finger was cut off",
			"type": "disturbing",
			"severity": "extreme"
		}
	]
}
```