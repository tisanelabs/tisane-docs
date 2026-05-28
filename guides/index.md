# Guides
This section provides guidance on features, solution walkthrus, and other topics. 

## Getting Started
Kick off your journey with Tisane by learning how to quickly set up and start using Tisane:

* [Get Started](../quickstart/quickstart.md)

## Supported Features

* [List of Supported Languages](./features/languages.md)
* [Full List of Supported NLP Functions](./features/functionality.md)
* [Feature: Entity Extraction](./features/entities.md)
* [Feature: Topic Extraction](./features/topics.md)
* [Feature: Sentiment Analysis](./features/sentiment.md)
* [Feature: Built-in Translation](./features/translation.md)
* [Does Tisane Support My Programming Language?](./features/programminglanguages.md)
* [What does Tisane do when problematic content is detected?](./features/actupon.md)
* [Algospeak and Adversarial Text Manipulations](./features/algospeak.md)
* [Explainability and Transparency](./features/explainability.md)

## Types of Problematic Content

This section covers the concepts relevant to detection of concept of interest to moderators or, in law enforcement applications, of investigators.

* [Bullying / Insult (Personal Attack)](./abuse/personalattack.md)
* [Hate Speech (Bigotry)](./abuse/hatespeechandbigotry.md)
* [Attempts to Establish External Contact](./abuse/externalcontact.md)
* [Sexual Solicitation (Sexual Advances)](./abuse/sexualadvances.md)
* [Adult-Only Content](./abuse/adultonly.md)
* [Allegations](./abuse/allegation.md)
* [Criminal Activity](./abuse/criminalactivity.md)
  - [Difference between Criminal Activity, Allegation, and Disturbing](./abuse/criminalallegationdisturbing.md)
* [Self-harm / Mental Health (Mental Issues)](./abuse/mental.md)
* [Profanities](./abuse/profanity.md)
* [Privacy Violations (Data Leaks)](./abuse/dataleak.md)
* [Contentious Content](./abuse/contentious.md)
* [Disturbing Content](./abuse/disturbing.md)
* [Meaningless Content](./abuse/nomeaningfulcontent.md)
* [Assertion of Social Hierarchy](./abuse/socialhierarchy.md)
* [Spam](./abuse/spam.md)
* [Tags](./abuse/tags.md)
* [2-Factor Moderation](./abuse/whatis2fm.md)

## How-to Topics
Guides to help you implement and fine-tune Tisane for various content moderation scenarios:

* [Migrating from Perspective API to Tisane API](./how-tos/perspectivemigration.md)
* [Migrating from Two Hat Community Sift to Tisane API](./how-tos/communitysiftmigration.md)
* [Filtering By Keyword Blocklists](./how-tos/blocklists.md)
* [Locating a Text Snippet Using Location Data](./how-tos/locateasnippet.md)
* [Moderating Live Chat](./how-tos/liveusercontent.md)
* [Moderating Usernames](./how-tos/aliases.md)
* [Detecting Threats](./how-tos/threats.md)
* [Detecting Problematic Content](./how-tos/detectabuse.md)
* [Detecting Names of Countries](./how-tos/extractnamesofcountries.md)
* [Processing Competitive Language In Game And Sports Chats](./how-tos/gamingchat.md) 
* [Considering Previously Processed Messages](./how-tos/usingmemory.md)

## Distribution and Deployment

* [What Happens When My Monthly Quota Is Exceeded?](./deployment/exceedquota.md)
* [On-Premise Deployment](./deployment/onprem.md)
* [Can Tisane Be Embedded In My Application Deployed On A Standalone Machine?](./deployment/embedded.md)

## Design Philosophy

* [The Free Speech Debate](./features/freespeech.md)
* [Why Deploy Automatic Moderation if it's not 100% accurate?](./features/why-deploy.md)
* [Why Don't You Provide A Score On A Fixed Or Floating-Point Scale For Your Sentiment?](./features/score.md)
* [Is There a Confidence Value?](./features/confidencevalue.md)