# Explainability and Transparency

Both in trust & safety and law enforcement, ability to trace the system's reasoning when making a decision is paramount. Today, algorithmic transparency is also required by [EU Digital Services Act](https://digital-strategy.ec.europa.eu/en/policies/dsa-brings-transparency). 

## Providing Human-Readable Explanation

If `"explain":true` is specified as a setting, then human-readable explaination is provided for every `abuse` and `sentiment_expressions` element.

### Example

Request:
```json
{
  "content":"u r a liar",
  "language":"en",
  "settings":{"snippets":true, =="explain":true==}
}
```

Response:
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

## Tracing and Debugging Platform Decisions

In debugging mode, Tisane generates a log which can then be loaded in a special debugger environment.

![Parse tree presented in the debugger](/images/lamp-es-debugger1.png)

![Debugger: intermediate structures](/images/lamp-es-debugger2.png)

Language Model Portal platform is available only for private cloud installations.

[Contact us](https://tisane.ai/contact-us/) for more info.