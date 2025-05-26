# Response

This section details all the components and data structures in response structures returned by Tisane.

The `POST /parse` response includes sections that can be displayed or hidden based to the provided settings. (See [Configuration And Customization Guide](/apis/tisane-api-configuration) for more information.) 

The root-level attributes are:

- `text` (string) - The original input text.
- `language` (string) - The detected language code, if language identification was used.
- `reduced_output` (boolean) - Indicates if verbose information was omitted due to input size. 
- `sentiment` (floating-point number) - A document-level sentiment score (-1 to 1). Only shown when `document_sentiment` setting is set to `true`.
- `signal2noise` (floating-point number) - A relevance score showing how closely the text matches the concepts from the `relevant` setting. This value appears only if the `relevant` setting exists.

 ## Problematic Content

Tisane automatically analyzes the text for potential instances of abuse (problematic content) and flags them in the response.

The `abuse` section lists detected instances of content that may require attention of moderators, or be relevant to law enforcement agencies. 

This section appears if:

1. Instances of problematic content is found, and;
2. The `abuse` setting is set to `true` (or omitted).

Note: use case scenarios can vary. It is the responsibility of integrators and community administrators whether and how to act upon different types of flagged content. 

For example: It might not be appropriate to restrict sexual advances in a dating app, or censor profanity in communities where it’s commonly accepted, or restrict external contact if it's allowed.

### If You Don't Want Abuse Appear in Response

If you *don't* want problematic content appear in your response, you must explicitly set the `abuse` setting to `false`.

### Content Attributes

Every instance contains the following attributes:


 - `type` (string) - The type of the abuse
 - `offset` (unsigned integer) - The starting position of the instance. It is zero-based.
 - `length` (unsigned integer) - Length of the content.
 - `sentence_index` (unsigned integer)  - Index of the sentence containing the instance. It is zero-based.
 - `text` (string) -  The fragment of text containing the instance. Only appears if the `snippets` setting is set to `true`.
 - `tags` (array of strings) - Additional abuse details. For example: if the fragment is classified as an attempt to sell hard drugs, the instance contains the `hard_drug` tag.
 - `severity` (string) - How severe the abuse is. The levels of severity are `low`, `medium`, `high`, and `extreme`.
 - `explanation` (string) - The rationale for classification (if `explain` is enabled).

###  Supported Types 

The supported problematic types are:

- `personal_attack` - Direct insults or attacks targeting an individual. For example: instances of cyberbullying. Note: Criticism of ideas, posts, or general negative sentiment is not the same as a personal insult. See: [Personal Attack](/guides/abuse/personalattack.md)
- `bigotry` - Hate speech or expression of bigoted opinions; adversarial remarks targetting <a href="https://en.wikipedia.org/wiki/Protected_group" target="_blank">protected groups</a>. This includes not just racial slurs but any hostile statements directed at the group as a whole. See: [Bigotry and Hate Speech](/guides/abuse/hatespeechandbigotry.md)
- `profanity` - Use of profane language, regardless of the context or intent. Note that racial slurs are not captured by this type. See: [Profanity](/guides/abuse/profanity.md)
- `sexual_advances` - Attempts, whether welcome or unwelcome, to seek sexual favors or gratification. Also see: [Sexual Advances](/guides/abuse/sexualadvances.md)
- `criminal_activity` - Content involving attempts to sell or acquire illegal items, engage in criminal services, issue threats, or similar actions. Also see: [Criminal Activity](/guides/abuse/criminalactivity.md)
- `external_contact` - Attempts to initiate communication or payment through external channels. For example: Phone, email, messaging apps. These attempts might violate rules in certain communities, such as gig economy platforms or e-commerce sites. Also see: [Attempts to Establish External Contact](/guides/abuse/externalcontact.md)

- `adult_only` - activities restricted for minors. For example: Consumption of alcohol. Also see: [Adult-Only Content](/guides/abuse/adultonly.md)
- `mental_issues` - Content that might indicate mental health concerns, such as suicidal thoughts or signs of depression. Also see: [Mental Issues](/guides/abuse/mental.md)
- `allegation` - Claims or accusations of misconduct, which may or may not involve criminal activity. Also see: [Allegations](/guides/abuse/allegation.md)
- `contentious` - Content likely to incite or provoke emotional reactions from individuals or groups. Also see: [Contentious Content](/guides/abuse/contentious.md)
- `disturbing` - Graphic or unsettling descriptions that might be distressing to readers. Also see: [Disturbing Content](/guides/abuse/disturbing.md)
- `no_meaningful_content` - Nonsensical or gibberish text that lacks clear meaning. Also see: [Meaningless Content](/guides/abuse/nomeaningfulcontent.md)
- `data_leak` - Sensitive personal information. For example: Passwords, ID numbers. Also see: [Data Leaks](/guides/abuse/dataleak.md)
- `spam` - Spam content. Also see: [Spam](/guides/abuse/spam.md)
- `social_hierarchy` - Forceful assertion of hierarchy in a community. For example: Someone is acting as a control freak. Also see: [Assertion of Hierarchy](/guides/abuse/socialhierarchy.md)
- `generic` - Content that doesn't fit into any specific category; undefined.

 ## Sentiment Analysis

The `sentiment_expressions` section highlights the sentiment towards aspects or entities.

This section appears if: 

1. Instances where sentiment is expressed are found, and; 
2. The `sentiment` setting is set to `true` (or omitted).

 Every instance contains the following attributes:

 - `offset` (unsigned integer) - The starting position of the instance. It is zero-based.
 - `length` (unsigned integer) - Length of the content.
 - `sentence_index`  (unsigned integer)  - Index of the sentence containing the instance. It is zero-based.
 - `text` (string) -  The fragment of text containing the instance (if the `snippets` setting is set to `true`).
 - `polarity` (string) - Indicates the sentiment of the text: `positive`, `negative`, or `mixed`. There is also a default value used when the sentiment has been pre-determined by the application. For example: if a review is split into two portions, _What did you like?_ and _What did you not like?_, and the reviewer replies briefly with _The quiet. The service_. In such cases, the _default_ polarity allows the application to assign sentiment externally based on the context.
 - `targets` (array of strings) - Lists the specific aspects or entities the sentiment refers to, if available. For example, in the sentence _The breakfast was yummy but the staff is unfriendly_, the the sentiment targets are `meal` and `staff`. Named entities can also be sentiment targets.
 - `reasons` (array of strings) - Justifications for the sentiment. if  available. For example, in the sentence _The breakfast was yummy but the staff is unfriendly_, the `reasons` array for the `staff` is `["unfriendly"]`, while the `reasons` array for `meal` is `["tasty"]`.
 - `explanation` (string) - The rationale for the sentiment (if `explain` is enabled).

 Example:

 ```json
"sentiment_expressions": [
        {
            "sentence_index": 0,
             "offset": 0,
             "length": 32,
             "polarity": "positive",
             "reasons": ["close"],
             "targets": ["location"]
         },
         {
            "sentence_index": 0,
             "offset": 38,
             "length": 29,
             "polarity": "negative",
             "reasons": ["disrespectful"],
             "targets": ["staff"]
         }
     ]
 ```

 ## Named Entities

The `entities_summary` section lists detected entities in the text. 

This section appears if: 

1. Named entities are found, and;
2. The `entities` setting is set to `true` (or omitted).

 Every entity contains the following attributes:

 - `name` (string) - The most complete form of the entity's name found in the text across all mentions.
 - `ref_lemma` (string) - The dictionary form (lemma) of the entity in English, if available, regardless of the input language.
 - `type` (string or array of strings) - Defines the entity's type. Some entities may have multiple types. A country (or any other geopolical entity declaring itself a country, even if not universally recognized as such) is considered both a place and an organization.
 - `subtype` (string) - Specifies a more detailed classification within the entity type.
 - `mentions` (array of objects) - Lists all instances where the entity appears in the text.

 Every mention contains the following attributes:

 - `offset` (unsigned integer) - The starting position of the instance. It is zero-based.
 - `length` (unsigned integer) - Length of the content.
 - `sentence_index` (unsigned integer) - Index of the sentence containing the instance. It is zero-based.
 - `text` (string) - The fragment of text containing the instance (if the `snippets` setting is set to `true`).

 Example:

 ```json
 "entities_summary": [
        {
            "type": "person",
             "name": "John Smith",
             "ref_lemma": "John Smith",
             "mentions": [
                {
                    "sentence_index": 0,
                     "offset": 0,
                     "length": 10 }
             ]
         }
    ,
         {
            "type": [ "organization", "place" ]
        ,
             "name": "UK",
             "ref_lemma": "U.K.",
             "mentions": [
                {
                    "sentence_index": 0,
                     "offset": 40,
                     "length": 2 }
             ]
         }
     ]
 ```

 ### Entity Types And Subtypes

 The currently supported entity types are:

- `person`, with optional subtypes: `fictional_character`, `important_person`, `spiritual_being`
- `organization` Note: A country is both an organization and a place
- `place`
- `time_range`
- `date`
- `time`
- `hashtag`
- `email`
- `amount_of_money`
- `phone` - Phone number, either domestic or international, in a variety of formats
- `role` - A social role. For example: A position in an organization.
- `software` - A named software package
- `website` (URL), with an optional subtype: `tor` for Onion links; Note: Web services can also have the `software` type assigned
- `item_of_interest` - Any type of artifact of potential interest to the investigation. For example: Weapons, drugs, vehicles, luxury.
- `weight`
- `bank_account` Only IBAN format is currently supported; subtypes: `iban`
- `credit_card` - A credit card number, with optional subtypes: `visa`, `mastercard`, `american_express`, `diners_club`, `discovery`, `jcb`, `unionpay`
- `coordinates` - GPS coordinates
- `credential`, with optional subtypes: `md5`, `sha-1`
- `crypto`, with optional subtypes: `bitcoin`, `ethereum`, `monero`, `monero_payment_id`, `litecoin`, `dash`
- `event` - A notable event involving participation of multiple people.
- `file` Only Windows pathnames are supported; subtypes: `windows`, `facebook` (for images downloaded from Facebook)
- `flight_code`
- `identifier` Any alphanumeric identifiers (ID numbers, codes, etc.) not classified elsewhere.
- `ip_address`, subtypes: `v4`, `v6`
- `mac_address`
- `numeric` (an unclassified numeric entity)
- `username` - A user name or a user's alias.

 ## Topics

The `topics` section lists detected topics in the text. For example: subjects, domains, themes in other terms. 

This section appears if:

1. Topics are found, and; 
2. The `topics` setting is set to `true` (or omitted).

 If `topic_stats` setting is set to `true`, every entry in the array contains:

 - `topic` (string) - The name of the topic.
 - `coverage` (floating-point number) - A relevance score representing the ratio of sentences where the topic is detected to the total number of sentences.

 ## Long-Term Memory

The `memory` section provides optional context that can be passed to the `settings` in subsequent messages within the same conversation thread. 

See [Context and Long-Term Memory](/apis/tisane-api-configuration#context-and-long-term-memory) for more details.

 ## Low-Level Data: Sentences, Phrases, and Words

 Tisane can also provide more detailed linguistic data:

 - Sentences: Original sentences, along with their corrected versions if any misspellings are detected.
 - Lexical chunks: Groups of words (chunks) annotated with grammatical and stylistic features.
 - Parse Trees and Phrases: Hierarchical representations of sentence structure, highlighting phrases and their relationships.

### Sentences

 The `sentence_list` section is generated if:

* The `words` or the `parses` setting is set to `true`.

 Every sentence structure in the list contains:

 - `offset` (unsigned integer) - The starting position of the instance. It is zero-based.
 - `length` (unsigned integer) - Length of the content. 
 - `text` (string) - The original input text. 
 - `corrected_text` (string) - The automatically corrected version of the sentence, if a misspelling or obfuscation/algospeak was detected and spellchecking is enabled.
 - `words` (array of structures) - Provides detailed information about each lexical chunk, if `words` setting is set to `true`. Note: While the term "word" is used for simplicity, it may not be linguistically accurate to equate lexical chunks with individual words.
 - `parse_tree` (object) - Contains the parse tree and detected phrases for the sentence when the `parses` setting is set to `true`.
 - `nbest_parses` (array of parse objects) - Lists alternative parse trees that are close to the best one. Generated when both `parses` setting is `true` and `deterministic` setting is explicitly set to `false`.

 ### Words

 The words section is generated if:

* The `words` setting is set to `true`.

 Every lexical chunk (referred to as a "word" for simplicity) structure in the `words` array contains:

 - `type` (string) - Defines the element's category. For example: `punctuation` for punctuation marks, `numeral` for numerals, or `word` for all other text elements.
 - `text` (string) - The original input text. 
 - `offset` (unsigned integer) - The starting position of the instance. It is zero-based.
 - `length` (unsigned integer) - Length of the content.
 - `corrected_text` (string) - The automatically corrected version of the sentence, if a misspelling was detected.
 - `lettercase` (string) - Indicates the original letter case of the word: `upper`, `capitalized`, or `mixed`. Note: If the text is entirely lowercase or case-insensitive, this attribute is omitted.
 - `stopword` (boolean) - Specifies whether the word is a <a href="https://en.wikipedia.org/wiki/Stop_words" target="_blank">stopword</a>
 - `grammar` (array of strings or structures) - Lists the grammatical features associated with the `word`. If the `feature_standard` setting is defined as `native`, each feature is an object containing an `index`(a numeral) and a `value`(string). Otherwise, each feature is represented as a plain string.

 #### Advanced

 For lexical words only:

 - `role` (string) - The semantic role of the word. For example: `agent` or `patient`. Note: In the passive voice, semantic roles are reversed relative to syntactic roles. For example: In _The car was driven by David_, _car_ is the patient, and _David_ is the agent.
 - `numeric_value` (floating-point number) - The numeric value, if the word represents or is associated with one.
 - `family` (integer number) - the ID of the associated family with the disambiguated word-sense of the lexical chunk.
 - `definition` (string) - the definition of the family. 
   - Included if the `fetch_definitions` setting is set to `true`.
 - `lexeme` (integer number) - The ID of the lexeme entry associated with the disambiguated word-sense.
 - `nondictionary_pattern` (integer number) - The ID of a non-dictionary pattern that matched the word if it was not found in the language model but classified using non-dictionary heuristics.
 - `style` (array of strings or structures) - Generates a list of style features associated with the `word`.
   - Included if the `feature_standard` setting is set to `native` or `description`.
 - `semantics` (array of strings or structures) - Generates a list of semantic features associated with the `word`. 
   - Included if the `feature_standard` setting is set to `native` or `description`.
 - `segmentation` (structure) - Provides information on the selected segmentation. A segmentation is an array of word structures.

   - Included if multiple segmentations are possible, and the `deterministic` setting is set to `false`.

 - `other_segmentations` (array of structures) - Lists alternative segmentations considered incorrect during the disambiguation process. Each entry has the same structure as `segmentation`.
 - `nbest_senses` (array of structures) - Provides alternative disambiguation hypotheses. 

   - Included if the `deterministic` setting is `false`.

   - Each hypothesis includes: 

     - `grammar`, `style`, and `semantics`. These are structured identically to the corresponding attributes above. 
     - `senses`. Lists word-senses for the hypothesis, each containing:
       - `family`: The associated family ID. 
       - `definition`: The family’s definition if `fetch_definitions` is enabled. 
       - `ref_lemma`: The reference lemma, if available.


 For punctuation marks only:

 - `id` (integer number) - The ID of the punctuation mark.

 - `behavior` (string) - The behavior code  that defines the function of the punctuation mark. Values:
   - `sentenceTerminator`
   - `genericComma`
   - `bracketStart`
   - `bracketEnd`
   - `scopeDelimiter`
   - `hyphen`
   - `quoteStart`
   - `quoteEnd`
   - `listComma` (for East-Asian enumeration commas such as  `、`)

Punctuation marks have no n-best senses.

 ### Parse Trees and Phrases

A parse tree, or more precisely, a parse forest, is a hierarchical collection of phrases linked to one another.

The parse tree section is generated if:

* The `parses` setting is set to `true`.

At the top level of the parse, there is an array of root phrases contained within the `phrases` element, each associated with a numeric `id`. 

Every phrase can have child phrases, forming a nested structure.

 Each phrase includes the following attributes:

 - `type` (string) - A standard phrase tag denoting the type of the phrase. For example: `S`, `VP`, `NP`, `ADJP`, `ADVP`.
 - `family` (integer number) - An ID of the phrase family.
 - `offset` (unsigned integer) - The starting position of the instance. It is zero-based.
 - `length` (unsigned integer) -  Length of the phrase.
 - `role` (string) - The semantic role of the phrase, if applicable, similar to semantic roles assigned to individual words.
 - `text` (string) - The textual representation of the phrase: Phrase members are separated by the vertical bar character (|). Children phrases are enclosed in parentheses (). For example: 
   - _driven|by|David_ 9 (a flat phrase with three members) 
   - _(The|car)|was|(driven|by|David)_ (a hierarchical structure with child phrases).


 Example:

 ```json
"parse_tree": {
"id": 4,
"phrases": [
{
        "type": "S",
        "family": 1451,
        "offset": 0,
        "length": 27,
        "text": "(The|car)|was|(driven|by|David)",
        "children": [
                {
                        "type": "NP",
                        "family": 1081,
                        "offset": 0,
                        "length": 7,
                        "text": "The|car",
                        "role": "patient"
                },
                {
                        "type": "VP",
                        "family": 1172,
                        "offset": 12,
                        "length": 15,
                        "text": "driven|by|David",
                        "role": "verb"
                }
        ]
}
 ```

 ### Context-Aware Spelling Correction

Tisane supports context-aware spelling correction. It identifies and corrects misspellings or intentional obfuscations by deducing the intended meaning, especially when the language model does not recognize a word.

When a correction is made, Tisane adds the `corrected_text` attribute:

 - At the word level: If individual words or lexical chunks are returned.

 - At the sentence level: If the sentence text is generated. 


Sentence-level `corrected_text` appears when:

* The `words` or `parses` settings are set to `true`.

####  Exclude Rare Terms

Tisane works with large dictionaries. You can exclude esoteric terms by adjusting the `min_generic_frequency` setting.

####  Spell-Check Invocation

Note: Spell-checking runs regardless of whether sentence or word sections are included in the output.

You can control this behavior with the following settings:

- Set `disable_spellcheck` to `true` to turn off spell-checking entirely.

- To avoid correcting proper nouns (in languages with capitalization), set `lowercase_spellcheck_only` to `true`. This restricts spell-checking to lowercase words, excluding capitalized and uppercase terms.
