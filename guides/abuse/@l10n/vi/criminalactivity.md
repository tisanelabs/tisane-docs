# Criminal Activity

Tisane logs instances of detected criminal activity under the `abuse` section, with the `type` attribute set to `criminal_activity`. 

## What We Detect

We identify and flag text related to:

- Planning and coordination of transportation, distribution, and manufacturing of illicit items such as narcotics, arms, explosives, and poached wildlife.
- Human trafficking and the sale of human organs.
- Inquiries and instructions on creating, manufacturing, distributing, or operating weapons (including chemical and biological weapons), narcotics, and explosives.
- Threats of violence and criminal activity.
- Searches for restricted items, For example: Firearms, ammunition, explosive precursors). To analyze search queries, set the `format` parameter to `search`.

{% admonition type="warning" %}

1. The criminal activity type does not capture conversations about crime committed by someone else or allegations. The purpose of the `criminal_activity` type is to capture either crime in progress or admission of criminal activity. To capture conversations about crime, use topic extraction. See: [Topic Extraction](/guides/features/@l10n/vi/topics.md). To capture allegations about someone else committing crimes, see: [Allegations](./allegation.md)
2. As the legislation varies from jurisdiction to jurisdiction, inspect `tags` to determine if the instance is to be ignored. For example, `cannabis` or `soft_drug` may be used to ignore the references to use of marijuana.

{% /admonition %}

### Example

Request:

```json
{
	"language":"en",
	"content":"we sell elephant tusks. Great prices and top notch quality!", 
	"settings": 
  {
	 "snippets":true
  }
}
```

Response:
```json
{
	"text": "we sell elephant tusks. Great prices and top notch quality!",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 23,
			"text": "we sell elephant tusks.",
			"type": "criminal_activity",
			"severity": "high",
			"tags": [
				"for_sale",
				"wildlife"
			]
		}
	]
}
```

## Relevant Tags

The `tags` array may contain the following tags.

### Crimes

* `bodily_harm`
* `bribery`
* `call_for_violence`
* `crime`
* `death`
* `doxing`
* `escape` (correctional institutions)
* `extortion`
* `hacking_services`
* `human_trafficking`
* `money_laundering`
* `organized_crime`
* `organ_trade`
* `pedophilia`
* `piracy`
* `scam`
* `tax_evasion`
* `terrorism`
* `threat`
* `violence`
* `wildlife` (poaching)

### Controlled Substances

* `controlled_substance`
* `soft_drug`
* `cannabis`
* `khat`
* `hard_drug`
* `cocaine`
* `ecstasy`
* `hallucinogen`
* `heroin`
* `meth`
* `medication`
* `opioid`

### Other Restricted Items

* `cold_weapons`
* `explosives`
* `firearms`
* `weapon`
* `contraband` (depends on the context)

### Miscellaneous

* `admission` - admission in a crime
* `credentials`
* `cryptocurrency`
* `debt`
* `payment`

## Relevant Entity types

`item_of_interest` entity type detects items potentially of interest to the investigation: luxury items, drugs, medications, vehicles.

## Offline and Law Enforcement Use

Law enforcement applications often have to operate in air-gapped environments. To accommodate this need, [Tisane Embedded](/sdks/@l10n/vi/index.md) is available. Tisane Embedded allows running Tisane as an in-process library. [On-prem installations](/guides/deployment/onprem) are are available as well. 


