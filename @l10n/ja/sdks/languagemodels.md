# Language Models Data Stores

Tisane language models are stored in directories. They can be divided into:

1. **Language-specific data** that describes a particular language.
2. **Crosslingual data** used by all languages (for example, semantic connections between concepts).

### Language-Specific Data


Language-specific data stores are named according to the following convention: `(language_code)-(data_store_name)`

*   Language code: Based on <a href="https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes" target="_blank">ISO-639-1</a> language code standard, optionally including dialects.
*   Data store name: Structures stored.

Examples:

*   `en-phrase`: English phrasal patterns
*   `fr-nondic`: French nondictionary entity heuristics
*   `zh_CN-phrase`: Chinese (Simplified) phrasal patterns

### Crosslingual Data Stores

These data stores used by *all* languages:

*   `family`
*   `role`
*   `pragma`

**Important:** All data stores for a language must reside in the *same* directory.

### Partial Distribution

In order to conserve space or out of other considerations, it is possible to exclude languages or components from deployment.

## Providing Selected Languages Only

To include only specific languages, identify the appropriate language codes (e.g., `en`, `de`, `zh_CN`) and include the corresponding language-specific data stores along with the three shared data stores (`family`, `role`, `pragma`).

## Providing Partial Functionality

Stores `xx-famlex` and `xx-famphrase` are used for translation only, and can be excluded from distribution if Tisane is not used for translation.

## spellchecking

Spellchecking data is stored under `xx-spell` stores. If omitted, spellchecking will not work.