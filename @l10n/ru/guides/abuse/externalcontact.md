# Attempts to Establish External Contact

Attempts to establish external contact include:

* exchange of contact details such as emails, phone numbers, usernames, payment instrument identifiers like crypto addresses or IBANs
* solicitation of contact details (e.g. "What's your WhatsApp?")
* arranging meetings or encouragement to communicate off the platform (e.g. _"Let's just talk off the website"_)

Detected attempts to establish external contact are logged under the `abuse` section, with the `type` attribute set to `external_contact`.

## Use Case Scenarios

These are some scenarios when detection of attempts to establish external contact is required:

* scammers on a platform, trying to lure people away
* sex predators
* otherwise legitimate users attempting to violate the terms of the platform. For example, vendors offering the users get off the platform and cut a better deal without paying a commission
* covert advertising in reviews
* sex workers advertising their services in their profiles on dating apps and other online communities
* advertising in usernames, e.g. URLs, directing users to look for contact details in the profile, etc.
* mapping connections between persons of interest in an investigation

{% admonition type="info" %}

For more aggressive scan and finding URLs in usernames and reviews, set `format` to `review` or `alias`.

{% /admonition %}

## Relevant Tags

  * `payment` - anything payment-related
  * `pii` - personally identifiable information (PII)
  * `sex_work` - advertising of sexual services

## Example

Request:

```json
{
  "language": "en",
  "content": "your wickr ?",
  "settings": {
    "snippets":true, "explain":true
  }
}
```

Response:

```json
{
  "text": "your wickr ?",
  "topics": [
    "online chat"
  ],
  "abuse": [
    {
      "sentence_index": 0,
      "offset": 0,
      "length": 10,
      "text": "your wickr",
      "type": "external_contact",
      "severity": "low",
      "explanation": "Inquiry about messenger [ID]"
    }
  ],
  "entities_summary": [
    {
      "type": "software",
      "name": "wickr",
      "wikidata": "Q16334358",
      "mentions": [
        {
          "sentence_index": 0,
          "offset": 5,
          "length": 5,
          "text": "wickr"
        }
      ],
      "subtypes": [
        "chat"
      ],
      "subtype": "chat"
    }
  ]
}
```