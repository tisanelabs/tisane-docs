# 説明可能性と透明性

信頼性と安全性の分野においても、法執行の分野においても、システムが意思決定を行う際にその論理を追跡できる能力は最も重要です。現在、アルゴリズムの透明性は、[EUのデジタルサービス法](https://digital-strategy.ec.europa.eu/en/policies/dsa-brings-transparency)においても求められています。 

## 人間が判読できる説明の提供

`"explain":true`が設定されている場合、すべての`abuse`と`sentiment_expressions`要素に対して、人間が判読できる説明が提供されます。

### 例

リクエスト：
```json
{
  "content":"u r a liar",
  "language":"en",
  "settings":{"snippets":true, =="explain":true==}
}
```

レスポンス：
```json
{
	"text": "u r a liar",
	"topics": [
		"dishonesty"
	],
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 10,
			"text": "u r a liar",
			"type": "personal_attack",
			"severity": "high",
			"explanation": "Claim that discussion participant is unwelcome person"
		}
	],
	"sentiment_expressions": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 10,
			"text": "u r a liar",
			"polarity": "negative",
			"explanation": "Unfavourable opinion",
			"targets": [
				"credibility"
			]
		}
	]
}
```

## プラットフォームによる決定の追跡とデバッグ

デバッグモードでは、Tisaneはログを生成し、そのログを特殊なデバッガー環境で読み込むことができます。

![Parse tree presented in the debugger](../../images/lamp-es-debugger1.png)

![Debugger: intermediate structures](../../images/lamp-es-debugger2.png)

言語モデルポータルプラットフォームは、プライベートクラウドのインストール専用です。

[詳細については、お問い合わせください。](https://tisane.ai/contact-us/)