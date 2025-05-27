# Data Leaks

Instances of leaked data etc. are logged under the `abuse` section, with the `type` attribute set to `data_leak`.

## Relevant Tags

The following tags are often associated with the `data_leak` type:

* `pii` - personally identified information (PII)
* `credentials` - electronic credentials, such as usernames, accounts, passwords
* `payment` - data related to payments

## Example

Request:

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

Response:
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
