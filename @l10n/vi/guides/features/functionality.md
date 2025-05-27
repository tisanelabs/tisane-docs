# Supported Functions

Tisane is a powerful Natural Language Understanding (NLU) platform, designed from scratch for social media / user-generated text: ungrammatical, possibly obfuscated (e.g. algospeak), and heavy on slang and errors. Tisane's main applications are content moderation and law enforcement/national security/intelligence.

All features are available across all supported languages. All output is provided in one call.

## Core Functionality

Tisane offers sophisticated capabilities for abuse detection, sentiment analysis, and entity recognition:

- Detect problematic content for content moderation and investigations:
  - Personal attacks, insults, cyberbullying
  - Hate speech
  - Profanity
  - Sexual advances
  - Adult only references
  - Criminal activity (trade in restricted items like drugs, firearms, etc.)
  - Threats
  - Allegations (whether libel or not)
  - Suicidal ideation
  - Solicitation of contact outside the current media or platform
  - Graphic depictions of violence
  - Forceful assertions of hierarchy (e.g. workplace bullying)
  - Data leaks (e.g. PII exfiltration, exposure of credentials)
  - Spam
  
- Detect named entities and find relations between them:
  - people
  - organizations
  - social roles (titles, occupations, etc.)
  - places
  - phone numbers
  - credit card numbers
  - dates
  - amounts of money
  - items of interest in investigations (drugs, weapons, vehicles)
  - cryptocurrency addresses
  - more
- Detect topics (Subjects/Themes/Domains)
- Sentiment analysis (positive, negative, or mixed), including
  - sentiment expressed towards specific aspects or entities within the text. (Aspect-based sentiment analysis)

## Deep Linguistic Analysis

Tisane also provides access to linguistic fundamentals:

- Inteligent sentence splitting
  - Provides original sentences and their corrected versions (if applicable). 
  - Uses non-breaks to avoid false positives (e.g. `EE. UU.` or `www.google.com`)
- Lexical chunking
  - Tokenizes sentences by morpheme
  - Supports all types of segmentation:
    - languages using white spaces
    - languages not using white spaces (e.g. Chinese, Japanese, Thai)
    - languages using compounds (German, Dutch, Afrikaans)
    - clitics
    - multiword expressions
    - nondictionary entities (emails, phone numbers, etc.)
- Parse Trees and Phrases
  - Offers hierarchical representations of sentence structure, highlighting phrases and their relationships.
  - Extracts noun phrases, verbal phrases, prepositional phrases, adjectival phrases, adverbial phrases.
- Words
  - Provides detailed information about each word (or lexical chunk), including its lemma, role in the sentence, and grammatical features.
- Sense disambiguation
  - Detects the sense for every word in the current context.