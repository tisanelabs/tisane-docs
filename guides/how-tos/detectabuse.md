# Detecting Problematic Content

Instances of problematic content are logged under the `abuse` section. 

This section appears if:

1. Problematic types of content are found, and;
2. The `abuse` setting is set to `true` (or omitted).

An member of the `abuse` array contains:

* location data
  * `offset` - a zero-based position where the fragment starts 
  * `length` - the length of the fragment
  * `sentence_index` - the sentence where the fragment is located
* `type` - the type of the problematic content
* `severity` - the severity of the issue, which can be used to prioritize the detected instances
* `explanation` - a human-readable explanation why the system believes the content is problematic. (If the `explain` setting is set to `true`)
* `text` - the problematic fragment. (If the `snippets` setting is set to `true`) 

{% admonition type="warning" %}

**Do not act upon all types of entries** under the `abuse` section without distinction. 

It is the responsibility of moderators or policy creators to decide whether the flagged content is indeed problematic in the context of the community. For example: It might not be appropriate to restrict sexual advances in a dating app, or censor profanity in communities where it's commonly accepted.

Different types of problematic content require different action. For example, detected suicidal behavior certainly should not result in banning the user. 

For applications like investigation suites, it's yet another type of extracted information. Still, for the sake of usability, it is recommended to consider the actual needs and not flood the users with data they may not need.

{% /admonition %}

For the complete reference on types of problematic content, see: [Type of Problematic Content](https://doctest.tisane.ai/guides#types-of-problematic-content).

## If You Don't Want Problematic Content Detected

If the problematic content is not relevant, either explicitly set the `abuse` setting to `false`, or simply ignore the section.

## Locating Relevant Fragment In Text

To extract the exact text fragment containing the abusive content, use the **location data** provided in the response.

For further details, see: [How to Locate a Snippet Based on Location Data](./locateasnippet.md)

{% admonition type="info" %}

If all you need is the text fragment itself, simply add `"snippets":true` to the `settings` object, and use the `text` attribute at the level of an individual `abuse` object.

{% /admonition %}

## Is The Detection Of Abusive Content The Same As Sentiment Analysis?

Abusive content and sentiment analysis are two different things.

Indeed, abusive and problematic content often overlaps with negative sentiment. But it's not always the case. For example, when someone is advertising “high-quality cocaine”, the sentiment is clearly positive, but it's criminal activity that needs to be tagged as `abuse`.

When someone is exchanging contact details, the sentiment is neutral; however, it still can be marked as `external_contact`. Racial slurs can easily be used in utterances with positive sentiment, too.

On the other hand, “very negative sentiment” does not necessarily mean cyberbullying or hate speech. Even utterances like "I hate him" are not personal attacks, as they are not aimed at someone participating in the current conversation.  See: [Personal Attacks](../abuse/personalattack.md)