# Processing Competitive Language In Game And Sports Chats 

## The Challenge Of Competitive Language

*“Kill him! Kill him NOW!”*
*“I will kick your a*!”*
*“Touch your chest. Then push the ball harder.”*

When processing chat in computer games and sports-related communities, moderation APIs face a dilemma. 

On one hand, they can’t just ignore utterances that are normally considered policy violation. 

On the other, as Dr. Evil’s support group might say, *“We don’t actually want to kill each other in here.”*  Yet, real threats must still be taken seriously.

### The Problem With Using Severity Levels

Some moderation APIs attempt to address this by assigning "severity levels" and advising users to ignore messages below a certain threshold.

But game violence can be severe, and it’s still nothing to do with the real world.  This means even the most severe utterances should be ignored. At the same time, this severity-based approach risks filtering out genuine threats that should not be ignored.

## Tisane's Approach

Tisane offers two methods of handling this dilemma:

- **Method 1**: Ignore all `criminal_activity` type occurrences that have tags like `violence` and `death` on the client app side.

- **Method 2** (recommended): Use a special `game violence` flag to ignore game and sporting competitive language.

Example:

```

{"language":"en","content":"Shoot him!!!","settings":{"snippets":true,"memory":{"flags":["game_violence_ok"]}}}

```
The `game_violence_ok` flag ensures that all alerts related to sports competitive language and game violence are silenced. 

Note: The flag won’t silence actual threats like *“I know where you live”* or anything clearly not related to gaming.

### Output

Example without the `game violence` flag:

![tisaneShootHimNoGVOK.png](/images/tisaneShootHimNoGVOK.png)

Example with the  `game violence` flag set:

![tisaneGvOk.png](/images/tisaneGvOk.png)

Also see: [2-Factor Moderation](/guides/abuse/@l10n/ja/whatis2fm.md)

##  Using Tisane in an iGaming platform

Tisane’s iGaming clients usually use Tisane to moderate:

- Real-time chat
- User names

The logic may be different from the chat moderation. For example:  *BitcoinKing*, *Hitler*, *nakedsupermodels* etc. give a pretty good idea about the user’s intentions.

The two moderation functions are handled by the same method (`POST /parse`). 

The only difference is the `format` setting:

- For the chat, use `"format":"dialogue"`. 
- For user names, use `"format":"alias"`.

Our partners at PubNub provide both chat infrastructure and a [seamlessly integrated open-source moderation dashboard for Tisane](https://www.pubnub.com/demos/moderation-dashboard/).

