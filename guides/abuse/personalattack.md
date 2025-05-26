# Personal Attack

A personal attack is an insult, an ad hominem attack, an instance of cyberbullying, or any other kind of attack on a participant in a conversation. Instances of detected personal attacks are logged under the `abuse` section, with the `type` attribute set to `personal_attack`.

## What Is Not Considered A Personal Attack?

- An attack on a social group

   - If the target is an ethnic, religious, or racial group, as this is categorized as `bigotry` (hate speech).
   - Attacks on other social groups may not fall under any of the categories, or they can be marked as `contentious` (content likely to start disputes).

- An attack on a fictional character or public figure

   - Criticizing a fictional character or a public figure does not count as a personal attack.
   - An attack on someone currently not part of the conversation. That means anyone who is not a 2nd person ("you"), and is not identified by a mention linked to a user handle (e.g. @user12345). 
   - Negative sentiment that does not attack the person directly. For example, _"your music is bad"_ is not a personal attack.

## Example

Request:

```json
{
  "language":"en",
  "content":"You are so stupid, nobody likes you here!",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```

Response:

```json
{
	"text": "You are so stupid, nobody likes you here!",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 17,
			"text": "You are so stupid",
			"type": "personal_attack",
			"severity": "medium",
			"explanation": "Calling someone unsatisfactory"
		},
		{
			"sentence_index": 0,
			"offset": 19,
			"length": 16,
			"text": "nobody likes you",
			"type": "personal_attack",
			"severity": "medium",
			"explanation": "Claim of universal dislike"
		}
	]
}
```

## Redefining Default Policy

The default policy of excluding 3rd parties can be modified using the `memory` module.

### Detecting Attacks on Named Parties

In order to detect attacks on people referenced by names, add the following memory setting:

```json
{
  "assign": [
    {
      "if": {
        "features": [
          {
            "index": 1,
            "value": "NOUN"
          },
          {
            "index": 14,
            "value": "NA"
          },
          {
            "index": 22,
            "value": "PERS"
          }
        ]
      },
      "then": {
        "features": [
          {
            "index": 33,
            "value": "DIPA"
          }
        ],
        "hypernym": 123887
      }
    }
  ]
}
```

For example:

```json
{
  "language": "en",
  "content": "John Smith sucks",
  "settings": 
  {
    "memory":
    {
      "assign": [
      {
        "if": {
          "features": [
            {
              "index": 1,
              "value": "NOUN"
            },
            {
              "index": 14,
              "value": "NA"
            },
            {
              "index": 22,
              "value": "PERS"
            }
          ]
        },
        "then": {
          "features": [
            {
              "index": 33,
              "value": "DIPA"
            }
          ],
          "hypernym": 123887
        }
      } ]
    }
  }
}
```

### Detecting Attacks on all 3rd Parties

In order to detect attacks on all 3rd parties, add the following memory setting:

```json
{
  "assign": [
    {
      "if": {
        "features": [
          {
            "index": 1,
            "value": "NOUN"
          },
          {
            "index": 9,
            "value": "3"
          },
          {
            "index": 22,
            "value": "PERS"
          }
        ]
      },
      "then": {
        "features": [
          {
            "index": 33,
            "value": "DIPA"
          }
        ],
        "hypernym": 123887
      }
    }
  ]
}
```

For example:

```json
{
  "language": "en",
  "content": "He is an idiot",
  "settings": 
  {
    "memory":
    {
      "assign": [
      {
        "if": {
          "features": [
            {
              "index": 1,
              "value": "NOUN"
            },
            {
              "index": 9,
              "value": "3"
            },
            {
              "index": 22,
              "value": "PERS"
            }
          ]
        },
        "then": {
          "features": [
            {
              "index": 33,
              "value": "DIPA"
            }
          ],
          "hypernym": 123887
        }
      } ]
    }
  }
}
```