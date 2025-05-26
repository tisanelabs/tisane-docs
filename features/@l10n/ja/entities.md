# Entity Extraction

Entities are elements of relevance or interest in the text. Tisane extracts both standard entities and those relevant to trust & safety/law enforcement applications.

Standard entities are names of people, their social roles, organizations, places, and so on. We also extract cryptocurrency addresses, bank accounts, credit card numbers, phone numbers, software package names, and more.

Entities are logged under the `entities_summary` section. Every entity entry is an object made of:
  * `type` - the type of the entity
  * `name` - a standard name, if exists; otherwise, the string that was logged
  * `subtypes` - more detailed additional types
  * `subtype` - the first subtype (for backward compatibility purposes)
  * `mentions` - an array of all detected mentions, with:
    * `offset`
    * `length`
    * `sentence_index`
    * `text`
  * `wikidata` - a Wikidata ID, if exists  

See full list of detected entities: [Response Reference](/apis/tisane-api-response-guide#named-entities)

## Subtypes

Additional detail is provided in the `subtypes` array of strings (the first subtype is also logged as the `subtype` attribute).

The following subtypes are associated with specific entity types:

- `person`
  - `fictional_character` - a name of a character in a work of fiction
  - `important_person` - a name of an historic figure or a public figure or a celebrity
  - `spiritual_being` - a name of a deity or an angel or an evil spirit
- `organization`
  - `media` - a media outlet or a periodical publication
  - `authorities` - a government agency
  - `law_enforcement_agency` - a law enforcement agency
  - `intelligence_agency` - an intelligence agency
  - `military` - a military unit
- `software`
  - `chat` - any software often used for instant messaging
  - `online_community` - an online community such as a social network
  - `low_trust_payment_method` - used for payments and commonly perceived as prone to abuse
- `age`
  - `minor_age` - age under the age of consent
- `crypto`
  - `bitcoin`
  - `ethereum`
  - `dogecoin`
  - `erc20-wallet`
  - `monero`
  - `tether`
  - `dash`
  - `litecoin`
- `ip_address`
  - `v4` - IP address version 4
  - `v6` - IP address version 6
- `file`
  - `windows` - a Windows pathname
  - `unix` - a Unix pathname
- `credit_card`
  - `american_express`
  - `visa`
  - `mastercard`
  - `maestro`
  - `jcb`
  - `discovery`
  - `diners_club`
  - `zcash`
- `credential`
  - `password`
- `website`
  - `high_risk` - high probability of encountering malware or scams
- `item_of_interest`
  - `cold_weapons`
  - `luxury` - any luxury item, e.g. expensive watches, yachts, luxury cars
  - `firearms`
  - `weapon`
