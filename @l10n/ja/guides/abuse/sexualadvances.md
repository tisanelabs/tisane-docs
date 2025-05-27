# Sexual Advances

Sexual advances are defined as attempts to gain some sort of sexual favor or gratification. These attempts can be welcome or unwelcome; Tisane does not aim to determine that. 

Sexual advances are recorded as instances of abuse under the type `sexual_advances` in the response. Like other types of abuse, each detected instance is assigned a severity level, with more explicit advances receiving a higher severity rating.

## Relevant tags

* `endearment`
* `pedophilia`
* `relationship_status` (e.g. questions whether the other person is married or single)
* `sex`
* `sex_work` (helps detecting references to sex workers)

## Sexual Advances vs Adult Only Content

Note that not all conversations on sexual topics constitute sexual advances. Only actual attempts to gain sexual favors or gratification are.

While there is a significant overlap between `sexual_advances` and `adult_only`, these two types are not the same. Mentioning body parts related to sexual activities without context is not qualified as sexual advances, for example.

To track all sexual content, watch for:

* instances with the `sexual_advances` type
* instances with the `adult_only` type and `sex` as one of the tags.

See: [Adult Only Content](./adultonly.md)

## Key Considerations

- The API does not enforce rules; it only detects and categorizes content.
- Community moderators and administrators determine whether flagged content violates platform guidelines. For example, sexual advances do not violate terms and conditions in dating apps.

## Example

Request:
```json
{
  "language":"en",
  "content":"do u hv a bf",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```

Response:
```json
{
	"text": "do u hv a bf",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 12,
			"text": "do u hv a bf",
			"type": "sexual_advances",
			"severity": "medium",
			"explanation": "Do you have partner"
		}
	]
}
```