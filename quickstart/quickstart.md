# Get Started With Tisane
Kick off your journey by learning how to quickly set up and start using Tisane API.

## Step 1 – Create An Account

<a href="https://dev.tisane.ai/signup/" target="_blank">Sign up to Tisane API</a> 

The free Community Plan supports up to 50,000 requests, with a limit of 10 requests per minute. (Or, you can purchase a paid plan, if you like.)

## Step 2 - Obtain Your API Key

Tisane API uses API keys to authenticate requests. Go to your <a href="https://dev.tisane.ai/profile" target="_blank">Developer Profile</a> to view and manage your API keys.

## Step 3 - Use the API

 Invoke the `POST /parse` method. The method's request body requires three attributes:

- `content` (string)
- `language` (string)
- `settings` (object)

**Example**:  

Request:
 ```json
    {
      "language": "en", 
      "content": "Hello Tisane API", 
      "settings": {}
    }
 ```
 Response:
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

|In the public cloud, the maximum length of the JSON body is 2048 bytes. Longer requests are available in the on-prem version.|
|-----------------------------------------|

You can test your request on this portal or use the _Try It_ option in the <a href="https://dev.tisane.ai/api-details#api=5a3b6668a3511b11cc292655&operation=5a3b7177a3511b11cc29265c" target="_blank">Developer Portal</a>.
You can also test using curl, Postman, Insomnia, or any other RESTful tool.

### Curl syntax 

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

## Troubleshooting

The API works via a standard **POST request**. 

If you are getting a timeout error:
- Check your network connection.

---

If you are getting a 401 (Unauthorized) error code:
```json
{
	"statusCode": 401,
	"message": "Access denied due to invalid subscription key. Make sure to provide a valid key for an active subscription."
}
```
- Make sure you provided a correct API key as a value of the `Ocp-Apim-Subscription-Key` header. 

{% admonition type="info" %}

To use your API key on this Documentation Portal, click on the _Security_ button in the _Try It_ page.

(The Developer Portal automatically fills the API key when you sign in.)

{% /admonition %}

---

If you are getting a 400 (Bad Request) error code saying that a language is not found in the database:
- Make sure you are specifying a correct ISO-639-1 language code, and that this language is supported by Tisane.

If you need more help:

* [Contact Support](../support/support.md) and we'll see why it's not working for you.
* [Troubleshooting tips](../support/troubleshooting.md)

Next:

* [How to Detect Problematic Content](../guides/how-tos/detectabuse.md)
* [List of Supported NLP Functions](../guides/features/functionality.md)
* [List of Supported Languages](../guides/features/languages.md)