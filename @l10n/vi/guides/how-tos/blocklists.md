# Filtering By Keyword Blocklists

While most users use Tisane for context-aware moderation, some users require simple keyword filtering for this or another reason. 

Tisane can be used to monitor lists of words, with options helping to avoid usual pitfalls of wordlist monitoring.

## Including Word Breakdown in the Response

By default, Tisane outputs only the `abuse`, `sentiment`, and `entities_summary` sections in its response. However, Tisane can provide a breakdown of words making up every sentence.

To output the words, add `"words":true` to the `settings` parameter.

All words are tokenized (divided into chunks); the tokenization algorithm in use depends on the language. It is transparent to the user, whether the language uses spaces or not, has compounds (such as in German or Dutch), or has words that have spaces in between (for example: *kung fu* in English or *EE. UU.* in Spanish). 

The result is a structured array named `words`. It is located inside the `sentence_list` structure in the response. 

Every word element contains:

- The actual string (`text`)
- The `offset` where it starts
- A `stopword` flag for stop words
- Some internal Tisane IDs (see Option 2 below)
- Associated features such as grammar or style

## Implementing Keyword Filtering

There are two ways to implement keyword filtering with Tisane:

* Option 1: Simple (Not Recommended)
* Option 2: More Powerful

Both approaches avoid false positive issues, known as a “[clbuttic problem](https://en.wikipedia.org/wiki/Scunthorpe_problem)”.

## Option 1: Simple (Not Recommended)

The simple and the obvious solution is:

1. Traverse the `words` array.
2. For every element, check if the `text` attribute contains one of the prohibited words (or expressions, because the tokenization is logical, and *kung fu* or *power plant* is one word).

### Limitations

The simplicity comes with drawbacks:

- What happens if the word is inflected? Some people will say “we can use the stem”, but it’s not always possible to reduce it to a stem. 
- How do we capture the word _bought_ in English based on the lemma _buy_? If you assume _b_ to be its stem, should you assume every word starting with _b_ is an inflected form of _buy_? 
- More morphologically rich languages (French, German, Arabic, Russian, Hindi, etc.) have a lot more variety and numerous inflections.
- What happens if the word is spelled slightly differently, e.g. *U.S.A.* instead of *USA* or *email* instead of *e-mail*?
- What happens if the word is obfuscated or, in information security speak, employs “adversarial text manipulations”?
- What if we want to screen any mention of *Alaska* (the state) but allow *Alaska Air* and *baked Alaska*? (For a recent real-life example, an article about [_Enola Gay_](https://en.wikipedia.org/wiki/Enola_Gay) was removed in the [2025 Pentagon cleanup](https://www.newsweek.com/military-remove-enola-gay-photos-dei-rules-2041029) because keyword matching flagged the word "gay".)

## Option 2: More Powerful

Option 2 relies on Tisane’s internal identifiers. This route allows solving all the shortcomings listed above, taking advantage of Tisane's algospeak and deciphering and morphological analysis capabilites.

The internal identifiers in the word entries are `lexeme` and `family`. 

### About lexeme ID

A lexeme ID in Tisane is associated with a word and all its possible inflections. 

If the word is obfuscated (e.g. “br*k” instead of “break”) or misspelled, and Tisane manages to recognize the original word, then the lexeme ID of the original word is provided.

### About family ID

Family ID is another option, if we want to filter according to the word-sense. 

For example: A device called “elevator” in the US is called “lift” in the UK.  It’s the same real-world entity, just different terms. They both have the same family ID. However, “lift” in the sense of aerodynamic lift, has a different family ID. 

An added bonus here is that the family IDs are the same across languages. That is, you can create a “list of concepts” to capture, regardless of the language or the dialect. 

Power users can even filter by categories. For example: Any kind of plane, any kind of car, any kind of bird while ignoring “clay pigeon” but capturing “pigeon”, etc.

### Why We Recommend Using lexeme ID

But, while Tisane is generally word-sense oriented, we came to realize that the difference between word-senses is not always obvious to the users. Also, the keyword filtering usually intentionally ignores the context. This is why we recommend using lexeme ID.

For every word or phrase in your list:

1. Look up the lexeme ID, either by running a sample sentence and getting the lexeme ID from there, or by using our Language Model Direct Access API.
2. Traverse the `words` array.
3. For every word, compare the lexeme ID with the list of your lexeme IDs.

Example:

Request (`sentiment`, `topics`, and `entities` turned off to simplify the output):

```json
{
  "language":"en",
  "content":"d/l star t*k for free",
  "settings":
  {
    "snippets":true,
    "words":true,
    "sentiment":false,
    "entities":false,
    "topics":false
  }
}
```

Response:
```json
{
	"text": "d/l star t*k for free",
	"sentence_list": [
		{
			"offset": 0,
			"text": "d/l star t*k for free",
			"words": [
				{
					"type": "word",
					"offset": 0,
					"text": "d/l",
					"role": "verb",
					"lexeme": 44058,
					"family": 117658,
					"grammar": [
						"VERB"
					]
				},
				{
					"type": "word",
					"offset": 4,
					"text": "star t*k",
					"role": "patient",
					"lexeme": 317071,
					"family": 152100,
					"wikidata": "Q1092",
					"grammar": [
						"PROPN"
					]
				},
				{
					"type": "word",
					"offset": 13,
					"text": "for free",
					"lexeme": 62119,
					"family": 93462,
					"grammar": [
						"ADV"
					]
				}
			],
			"corrected_text": "d/l star trek for free"
		}
	]
}
```

In the response: 

1. The obfuscated word _Star Trek_ is:

 * chunked as one unit
 * assigned lexeme ID 317071
 * assigned family ID 152100

2. The *corrected_text* attribute contains de-obfuscated version of the sentence: _d/l star trek for free_.