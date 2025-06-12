# Configuration and Customization

This section covers the ways you can configure and customize the API's behavior through various parameters.

The settings structure enables you to:

1. Provide cues about the content being processed to improve analysis results.
2. Customize output and select specific sections to display.
3. Define standards for tags to conform the standards you use.

### General Notes

- All settings are optional.
- To use default settings, provide an empty object: `{}`.
- Specify only the settings you want to modify.

## Content Cues

Content cues help tailor the analysis by telling where the content comes from, what topics are to be expected, and more.

### Format

The `format` setting allows using format-aware logic.

`format` (string) - Defines the format of the content. This influences how the underlying language models process the content. For example: when Tisane is told it's a review, it might look for sentiment more aggressively. With aliases, Tisane may try segment words and expect specific length. And so on. 

Default: empty/undefined.

#### Supported Format Values

The supported values are:

- `review` - For product, service, or general reviews. It prioritizes detecting sentiment and promotional spam (unwanted commercial solicitation) that may contain obfuscated words.
- `dialogue` - For comments/posts in a dialogue. It detects context-specific cues, such as name calling and other personal attacks. For example: A comment made of the word "snowflake" might be flagged as a personal attack (unlike if it's a review or an alias).

- `shortpost` - For microblogging posts. For example, a tweet which is not a reply to another tweet.

- `longform` - For long posts or articles.

- `proofread` - For posts that have been proofread. In this format, spellchecking is automatically disabled.
- `alias` - Represents a nickname in online communities or a username.

- `search` - For search queries; search queries are not necessarily complete or grammatically correct sentences. 

### Spellchecking and Adversarial Text Manipulations

These settings control the spellchecking policies. They help manage when and how spellchecking is applied to minimize errors and false positives.

- `disable_spellcheck` (boolean) - Disables automatic spellchecking when set to `true`. Default: `false` (spellchecking is enabled).
- `lowercase_spellcheck_only` (boolean) - Applies spellchecking only to lowercase words. This helps avoid false positives on proper nouns. Default: `false` (applies to all words).

### Parsing Settings

These settings control lexical filtering and parsing behavior, allowing for more precise text analysis. They help refine language processing by filtering rare terms, enabling context-specific parsing, and customizing language detection boundaries.

- `min_generic_frequency` (integer) -  Excludes rare or esoteric terms based on frequency. Only applies for lexical items without domains. Valid range: '0' to '10' (higher values exclude more rare terms).
- `subscope` (boolean) - Enables sub-scope parsing for specific contexts such as hashtags, URLs, obfuscated text (e.g., *“ihateyou”*). Default: `false`.
- `lang_detect_segmentation_regex` (string) - Custom language detection boundaries using regular expressions. For example: `(([\r\n]|[.!?][ ]))`.This regex treats newlines and sentence-ending punctuation as boundaries. This can be useful for texts that contain multiple languages.
- `disable_phrases` (boolean) - if `true`, syntactic structures are not mapped. **Only use if you need to detect simple entities or fall back to "bag of words" mode.**
- `disable_commonsense_cues` (boolean) - if `true`, syntactic structures are mapped but the common-sense knowledge is not applied. Speeds up the processing but decreases the accuracy; context-dependent structures (most of `abuse`, some entities) will not be detected.

### Domain Customization

This setting allows for fine-tuned control over content relevance by making specific domains more or less influential/prominent. 

- `domain_factors` (array of structures) -  This setting provides session-specific cues to adjust the relevance of different content domains. This helps to amplify or suppress specific types of content based on your use case.

#### Array Element Format

`{ "domain_id": multiplier }`

`domain_id` (string): The identifier for a specific domain of interest.

`multiplier` (number): A factor that increases or decreases the relevance of the domain.

Example: 
```json
"domain_factors": {"12345": 2.3, "2222": 5.0}
```

#### Sample Use Cases

1. To amplify relevant domains, by setting values greater than 1.

Example:

Emphasizing topics such as crime or drugs:

`"domain_factors": {"31058": 5.0, "45220": 5.0, "14112": 5.0, "14509": 3.0, "28309": 5.0, "43220": 5.0, "34581": 5.0}`. 

2. To suppress irrelevant domains, by setting values less than 1. This helps reduce noise from unrelated topics.

### Temporal Context (RESERVED)

The temporal context feature ensures more accurate language interpretation by considering how word usage has evolved over time.

- `when` (date string, format YYYY-MM-DD) - Enables you to specify the creation date of the content. This helps the model filter out anachronistic word meanings that didn’t exist at the specified time.

For example: The words _troll_, _mail_, and _post_ had different meanings before the Internet era. For historical texts, this setting helps ignore modern word senses that didn’t exist at that time.

## Customizing the Output

The following settings allow you to customize the output by specifying relevant/irrelevant functionality and the required level of detail. 

All settings are optional, with default values provided.

### Response Customization

Response customization enables you to eliminate irrelevant sections from the response JSON structure, or show sections normally not included in the response. 

The following settings control which aspects of the content are reported:

- `abuse` (boolean) - Outputs information on detected instances of problematic content. Default: `true`.
- `sentiment` (boolean) - Outputs sentiment-related snippets. Default: `true`.
- `document_sentiment` (boolean) - Outputs document-level sentiment. It provides an overall sentiment analysis for the entire text. Default: `false`.
- `entities` (boolean) - Outputs named entities detected in the text. For example: People, organizations, locations. Default: `true`.
- `topics` (boolean) - Outputs topics identified in the content. Default: `true`.

Note: if the structure in question is not detected in the input, the section is omitted.

#### Topic Detection

Topic detection enables you to identify key topics (subjects, themes) within the content. 

The following settings control how topics are extracted and presented:


- `topic_stats` (boolean) - Includes coverage statistics for each topic, if enabled. Default: `false`. When set to `true`, the output becomes an object with the following attributes:

  - `topic` (string): The topic name.

  - `coverage` (floating-point number): The proportion of sentences in the input that refer to the topic.

- `optimize_topics` (boolean) - Removes less specific topics when they overlap with more specific ones, if enabled. For example: When the topic is `cryptocurrency`, the optimization removes `finance`. Default: `false`.

#### Low-level Functionality

These settings provide deep insights into the structure and meaning of text by breaking it down into lexical chunks, definitions, and phrase structures. The detailed insights may be used when matching particular criteria not reflected in the upper-level sections like `abuse` or `topics`. For example, when looking for all noun phrases, or references to different types of motor vehicles, etc.

- `words` (boolean) - Outputs lexical chunks (or words) for every sentence. Default: `false`

In languages without spaces (Chinese, Japanese, Thai), results of tokenization are considered words.

In languages using compounds (German, Dutch, Norwegian, Hungarian), the compound words are divided into individual lexical components. 

- `fetch_definitions` (boolean) - Includes dictionary definitions of the words in the input text. Default: `false`. 

Note: `fetch_definitions` is only considered when `words` is set to `true`.

- `parses` (boolean) - Outputs parse forests representing the hierarchical structure of phrases within sentences. Default: `false`.

- `deterministic` (boolean) - Controls whether to output only the detected sense or include most morphologically feasible interpretations:

  - If `true` (default): Outputs only the detected sense.

  - If `false`: Outputs n-best senses.


### Explainability

These settings control the inclusion of relevant text fragments and explanations for detected abuse, sentiment, and entities. They help provide clarity on why specific text segments were flagged or extracted.

- `snippets` (boolean) - Includes text snippets in the abuse, sentiment, and entities sections. Default: `false`

- `explain` (boolean) - Provides reasoning or explanations for detected abuse and sentiment snippets, where possible. Default: `false`.
 ## Standards and Formats
The following parameters determine the standards and formats used in the response object.

 ### Feature Standard

- `feature_standard` (string) - Specifies the standard for outputting features related to grammar, style, and semantics. 

 The supported values are:

- `ud`- <a href="https://universaldependencies.org/u/pos/" target="_blank">Universal Dependencies tags</a> (default)
- `penn` - <a href="https://www.ling.upenn.edu/courses/Fall_2003/ling001/penn_treebank_pos.html" target="_blank">Penn treebank tags</a>
- `native` -  Tisane's native feature codes
- `description` - Tisane's native feature descriptions
- `glossing` - <a href="https://en.wikipedia.org/wiki/List_of_glossing_abbreviations" target="_blank">standard glossing abbreviations</a>

Note: Tisane native codes (and their descriptions) offer the largest number of feature designations, followed by the glossing abbreviations, followed by the Universal Dependencies, and then followed by the Penn treebank tags.

### Topic Standard

- `topic_standard` (string) - Defines the standard used for outputting topics in the response object. 

The supported values are:    

- `iptc_code` - IPTC topic taxonomy code

- `iptc_description` - IPTC topic taxonomy description (default)
- `iab_code` - IAB topic taxonomy code
- `iab_description` - IAB topic taxonomy description
- `native` - Tisane's domain description (derived from the family description)

### Sentiment Analysis Type

- `sentiment_analysis_type` (string) - Determines the sentiment analysis strategy used. 

The supported values are:

* `products_and_services` - The most common type of sentiment analysis: products and services.
* `entity` - Sentiment analysis with entities as targets.

## Context and Long-Term Memory

Human understanding of language goes beyond processing individual sentences in isolation. Comprehension often requires context beyond current verbal or textual input, including gestures, visuals, or knowledge based on prior verbal or textual input. 

In some cases, code-words or indirect references can conceal or obscure the original intended meaning of words.

The long-term memory module provides a way to address these gaps.

### When Text Only is Not Enough

Oftentimes, more than just textual input is required to perform an NLP task:

- Abuse: A term referring to an ethnicity or religious group may not be offensive on its own, but when it is paired with a derogatory image (For example: an ape, a pig), the intent to offend is clear.
- Gender Ambiguity in Translation: Languages like English don’t always indicate a person's gender. When translating to languages that require it (For example: Russian or French), additional context is needed.
- Scams: Fraudsters may extract details, piece-by-piece, over multiple messages. In isolation, without referencing previous messages, it’s hard or impossible to detect the moment when crime is committed.

Tisane's long-term memory module addresses these challenges. It consists of three components (all optional):

- Reassignments - Reassigning meanings, attributes, and hypernyms for custom interpretation. 
- Flags - To provide non-textual context.
- Antecedents -  For accurate pronoun and reference tracking.

This ensures more precise language understanding. The module helps detect hidden abuse, scams, and contextual nuances.

#### What Is a Hypernym?

A hypernym is a word that serves as a broad category under which more specific words (called hyponyms) fall. For example, *color* is a hypernym of *pink*; *vehicle* is a hypernym of *truck*. In computational linguistics and natural language processing (NLP), hypernyms help categorize words hierarchically, which can be useful for filtering or refining content analysis.

####  Reassignments

Reassignments modify how text is analyzed by adjusting attributes and conditions based on context. 

Examples:

- If a word is a verb in 1st or 2nd person, assign a specific gender. This will generate more accurate translations to a language where inflected forms may be different for a different gender.

- Overwriting the original meaning of a group of words (including all inflected forms).  This allows detecting code-words and secret language.

- Adding features or hypernyms. For example, we may want to mark a specific category of artifacts as `item_of_interest`, which will cause these artifacts to be extracted as an entity.  

##### How Reassignments Work

Reassignments are defined in the `assign` section as an array of structures with two main components: conditions (`if` )  and attributes (`then`). 

- `if` - The condition that must match, based on a combination of:

  - `regex` - A regular expression (RE2 syntax)
  - `family` - A family ID
  - `features` - A list of feature values. For example: `[{"index":1, "value":"NOUN"}]`.
  - `hypernym` - A hypernym's family ID

- `then` -  The attributes to assign if all requirements in the condition match:
     - `family` - a family ID
     - `features` - A list of feature values. For example: `[{"index":5, "value":"F"}]`.
     - `hypernym` - A hypernym's family ID
     

 Examples:

1. Assume the speaker is female (if 1st person, assign feminine gender):

```json
 `"assign":[{"if":{"features":[{"index":9,"value":"1"}]},"then":{"features":[{"index":5,"value":"F"}]}}]`
```

2. Assume any mention of a container refers to an illegal item: 

```json
   `"assign":[{"if":{"family":26888},"then":{"hypernym":123078}}]`
```

3. Mark attacks on specifically named 3rd parties as personal attacks (by redefining names as "discussion participants"):

 ```json
   `"assign":[{"if":{"features":[{"index":14,"value":"NA"},{"index":22,"value":"PERS"}]},"then":{"features":[{"index":33,"value":"DIPA"}],"hypernym":123887}}]`
 ```

   #### Flags

Flags serve as contextual hints that either providing information beyond the current text input, or tweak the way analysis is done in a specific way. Each flag is represented as a string. (Some of these flags may be toggled automatically with specific textual input.) 

In addition to the flags returned in the `memory` section, the following flags can be set manually:

| **Flag**                | **Meaning**                                                  |
| ----------------------- | ------------------------------------------------------------ |
| `agents_of_bad_things`  | A bad actor or was previously referred to.                  |
| `aggressive_crime_scan` | When uncertain, assume crime-related intent.                 |
| `bad_animal`            | Context involves an animal that symbolizes bad qualities. For example: pig, ape, snake. |
| `bulk_message`          | The message was sent in bulk.                                |
| `death_related`         | The context involves death.                                  |
| `game_violence_ok`      | In gaming chats, allow calls to violence.                    |
| `make_money`            | Context is about making money.                               |
| `my_departure`          | The author mentioned leaving.                                |
| `sexually_conservative` | Any photo-sharing or ambiguous interaction is assumed sexual. |
| `trusted_party`         | The author claims to be a trusted individual. For example: Spouse, relative. |
| `waste`                 | The topic is about waste (organic/inorganic).                |
| `won_prize`             | Mentions or implications of winning money/prizes.            |
| `work_from_home`        | Mentions working from home.                                  |
| `organization`          | An organization was mentioned.                               |
| `role`                  | A position or role was mentioned.                            |

####    Antecedents

Antecedents help with coreference resolution. 

This provides context for pronouns or other references, that may impact analysis results.

##### Structure

Each antecedent contains:

- `family` - The family ID of the antecedent
 - `features` - A list of feature values. For example: `{"index":36, "value":"WFH"}`.

##     Signal To Noise Ranking

When analyzing posts that comment on an issue or article, it's useful to prioritize those that are most relevant and based on reason, rather than emotion. The signal-to-noise ranking helps achieve this by filtering content for relevance and logical quality.

### How It Works

To calculate the signal to noise ranking:    
1. Analyze the article headline using `keyword_features` and (optionally) `stop_hypernyms` in the settings. Extract the `relevant` attribute.
2. Rank posts by relevance using the `relevant` attribute.

#### Step 1:  Identify Relevant Concepts

(This step can be omitted, if we already know the relevant concepts.)

To determine relevant concepts, we analyze the article's headline. This is usually sufficient.

Two key settings affect this analysis:

- `keyword_features` (an object of strings with string values) - Defines the characteristics to look for in a word. If a match is found, the corresponding family ID is added to the set of potentially relevant family IDs.
- `stop_hypernyms` (an array of integers) - Filters out unwanted generalizations, such as abstract terms or emotion. If a potentially relevant family ID has a hypernym listed in this setting, it will not be considered. For example: In the headline *Fear and Loathing in Las Vegas*, we might only want *Las Vegas*. This setting is optional.

If `keyword_features` is used, the response will include a `relevant` attribute, containing the identified family IDs.  

We recommend you include the `relevant` array in the settings when you do Step 2 ("Rank posts for relevance"). It helps prioritize posts that mention concepts related to those family IDs, ensuring the ranking process focuses on the most relevant content.

#### Step 2: Rank Posts For Relevance

Use the `relevant` attribute from step 1 to assess posts or comments. 

Ranking is boosted when:

* Relevant domains, hypernyms, or related families appear in the post. 
* Sentiment (positive or negative) is linked to specific aspects.

Ranking is penalized when:

- Negativity is not tied to specific aspects.
- Abusive content is detected (unless looking for specific criminal content).

Note: The `abuse_not_noise` parameter (when set to `true`) prevents abuse from being penalized.