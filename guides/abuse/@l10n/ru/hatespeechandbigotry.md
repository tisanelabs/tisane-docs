# Bigotry and Hate Speech

This type covers hate speech or expression of bigoted opinions; adversarial remarks targetting [protected groups](https://en.wikipedia.org/wiki/Protected_group) (in other terms, a group that may be targeted for discrimination). This includes not just racial slurs but any hostile statements directed at the group as a whole. 

Currently, we detect references to:

- Ethniticies or race
- Religious and [ethnoreligious](https://en.wikipedia.org/wiki/Ethnoreligious_group) groups
- Sexual minorities, except those illegal in most countries (e.g. pedophiles)
- Foreigners / immigrants
- Nonreligious people
- People with disabilities
- Castes (e.g. in India)
- Obese people
- Either of the genders

Every detected instance of bigotry is logged as a form of abuse. The type assigned is `bigotry`, and like other types of problematic content, it includes a severity level for context.

## What Qualifies As Bigotry Or Hate Speech?

We define bigotry as hostility, negative opinions, or calls for discrimination and/or violence directed at an entire demographic group - or individuals - solely because of their association with that group.

An association between one’s feelings and being a member is a group will also be tagged as an instance of bigotry.

### Implicit Bigotry
Implicit bigotry towards one of the targeted groups without naming it (e.g. “get out of my country”) is also in the scope of recognition, although is significantly more difficult to recognize.

### Not Bigotry

- Attacks on:
  - Public figures
  - People of particular occupation
  - People who underwent specific experience, even if the experience was traumatic
- A statement about a group member committing a wrongdoing. 

Some of these attacks may be flagged as `contentious`. See: [Contentious Content](./contentious.md)

## Severity Levels

The severity levels are as following:

* `low` - bigoted opinion or generalization that may not be particularly offensive
* `medium` - a bigoted opinion or expression, including most slurs
* `high` - an extremely offensive slur or denying the group basic rights or the right to exist
* `extreme` - a call to violence against the target group or actively trying to bring its demise

## Relevant Tags

The following tags are relevant to the `bigotry` type:

* `ableism`
* `ageism`
* `anticatholicism`
* `antisemitism`
* `caste` (caste-based discrimination)
* `christianophobia`
* `homophobia`
* `islamophobia`
* `racism`
* `religion`
* `sexism`
* `transphobia`
* `xenophobia`

## Example

Request:

```json
{
  "language":"en",
  "content":"Antarcticans should be kicked out of our country",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```

Response:

```json
{
	"text": "Antarcticans should be kicked out of our country",
	"topics": [
		"Antarctica"
	],
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 48,
			"text": "Antarcticans should be kicked out of our country",
			"type": "bigotry",
			"severity": "high",
			"explanation": "Protected group must be bothered"
		}
	]
}
```