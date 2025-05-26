# Algospeak and Adversarial Text Manipulations

Tisane uses a special type of built-in spellchecker module to process text with both unintentional errors (misspellings) and adversarial text manipulations (e.g. algospeak). 

The spellchecker employs several different techniques to handle different types of manipulations (masking characters, substitutions, etc.). These corrections are not limited by profanities or slurs, and consider the context. The same misspelled word may be interpreted differently in different sentences.

If corrections were found to be necessary in a sentence, the sentence gets a `corrected_text` attribute where the corrected text is logged. (Set `words` to `true` to output sentence data.)

## Limitations

Spell-checking is not a ["did you mean" tool](https://stackoverflow.com/questions/307291/how-does-the-google-did-you-mean-algorithm-work), as many people seem to believe:

- If the word is a legitimate word, no matter if misused or esoteric, Tisane will not correct it. For example, if *noun* is misspelled as *nun*, or *house* is misspelled as *horse*, Tisane won't help (unless it's part of a known often obfuscated concept, e.g. _corn star_ in English).
- The primary purpose of the spellchecker is to decipher obfuscations. Therefore, the spellchecker is biased toward more profane, objectionable, or heavily used concepts.

## Excluding Esoteric Senses And Words To Get Better Results

To get around the issue, you can use the  `min_generic_frequency` parameter. 

This allows you to exclude the most esoteric senses and words. 

The frequency is graded between 0 and 10, with 10 being the most frequent. 

Some esoteric senses are also graded at -10. 

We recommend you initially set `min_generic_frequency` to `1` or`2` to see if it works in your situation.

## Excluding Potential Proper Nouns

If you need to avoid spell-checking potential proper nouns, set `lowercase_spellcheck_only` to `true`.

## Example

Request:
```json
{
  "language":"en",
  "content":"I will br*k his neck and kll him",
  "settings": 
  {
    "words":true,"topics":false,"sentiment":false,"snippets":true
  }
}
```

Response:
```json

	"text": "I will br*k his neck and kll him",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 32,
			"text": "I will br*k his neck and kll him",
			"type": "criminal_activity",
			"severity": "medium",
			"tags": [
				"threat",
				"violence",
				"death"
			]
		}
	],
	"sentence_list": [
		{
			"offset": 0,
			"text": "I will br*k his neck and kll him",
			"words": [
				{
					"type": "word",
					"offset": 0,
					"text": "I",
					"lettercase": "capitalized",
					"role": "agent",
					"lexeme": 63061,
					"family": 301,
					"grammar": [
						"PRON"
					],
					"stopword": true
				},
				{
					"type": "word",
					"offset": 2,
					"text": "will",
					"lexeme": 146938,
					"family": 316,
					"grammar": [
						"VERB"
					],
					"stopword": true
				},
				{
					"type": "word",
					"offset": 7,
					"text": "br*k",
					"role": "verb",
					"lexeme": 20996,
					"family": 107846,
					"grammar": [
						"VERB"
					]
				},
				{
					"type": "word",
					"offset": 12,
					"text": "his",
					"lexeme": 63064,
					"family": 303,
					"grammar": [
						"DET"
					],
					"stopword": true
				},
				{
					"type": "word",
					"offset": 16,
					"text": "neck",
					"lexeme": 93293,
					"family": 40510,
					"wikidata": "Q9633",
					"grammar": [
						"NOUN"
					]
				},
				{
					"type": "word",
					"offset": 21,
					"text": "and",
					"lexeme": 4096,
					"family": 322,
					"grammar": [
						"CCONJ"
					],
					"stopword": true
				},
				{
					"type": "word",
					"offset": 25,
					"text": "kll",
					"role": "verb",
					"lexeme": 77380,
					"family": 113102,
					"grammar": [
						"VERB"
					]
				},
				{
					"type": "word",
					"offset": 29,
					"text": "him",
					"role": "patient",
					"lexeme": 63062,
					"family": 303,
					"grammar": [
						"PRON"
					],
					"stopword": true
				}
			],
			"corrected_text": "I will break his neck and kill him"
		}
	]
}
```