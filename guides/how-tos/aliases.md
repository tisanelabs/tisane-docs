# Moderating Usernames

Moderating aliases/usernames/nicknames works differently than moderating chats and messages.

URLs in an alias are a telltale sign of a spammer. If someone calls themselves _BtcKing111_, it's pretty obvious what they are here for. Mentioning _3rd reich_ in a chat is very different than adopting it as your username.

Which is why Tisane has a special mode for aliases. To invoke alias moderation logic, specify **"format":"alias"** in your settings structure.

## Language Identification

One common “gotcha” is the choice of language. As Tisane has a handy automatic language identification option, it is tempting to simply use that asterisk ("language":"*"). Don't do it!

First, language identification does not work well with strings shorter than 30-50 characters. Sometimes, it is simply impossible to know what the language is. Consider a word like “status”. It is the same word in French, Spanish, English, and many other languages. If you were to identify the language judging by the word “status” alone, what is the right answer? There is simply no definite answer, that’s how languages work. (A developer asked whether adding digits or spaces to the end will solve the problem. The answer is no.)

With aliases, it’s even more complex: aliases are not necessarily legitimate words in any language. It may be a mix of characters based on other words. It may be different name components mashed together (which, again, may be legitimate in several languages: Peter, John, etc.).

How do we know the language of the alias? One way is to look at the user’s settings or IP, but it’s extremely unreliable. Moreover, in most cases, aliases are made to be understood by the other community members, which is today usually a global audience. English aliases do not only come from the US and UK. Add intentional obfuscation and mashing words together to the mix.

And then there is the issue of your audience. If one of your users created a name that is perfectly acceptable in German, it may be offensive in English. Goes without saying, it may be any combination of languages. Marketers are familiar with the issue all too well.

Can Tisane just scan all languages until it finds anything offensive? We studied the option and decided not to go with it, because most communities oppose it.

There are several routes we recommend:

1. For Latin scripts, assume the alias is either in English or in one of the main languages in your community. For every language you need to validate, send a separate request. (Note that the vertical bar separated notation, e.g. en|fr|es is not the way to do it: its purpose is to invoke language identification.)
2. For non-Latin scripts, scan the main language associated with the script.

Do not worry about filtering the URLs, emails, etc. These ones are included in every language. Automatic tokenization of nicknames into constituents (e.g. _cryptorajah1244_ -> _crypto|rajah_) is built in, too.

**Example**

Request:
```json
{
  "language": "en",
  "content": "cryptorajah1244 ",
  "settings": {
    "format": "alias"
  }
}
```

Response:
```json
{
	"text": "cryptorajah1244 ",
	"topics": [
		"cryptocurrency",
		"finance",
		"aristocracy"
	],
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 11,
			"type": "spam",
			"severity": "high",
			"tags": [
				"cryptocurrency"
			]
		}
	],
	"entities_summary": [
		{
			"type": "role",
			"name": "rajah",
			"mentions": [
				{
					"sentence_index": 0,
					"offset": 6,
					"length": 5
				}
			]
		},
		{
			"type": [
				"username",
				"person",
				"identifier"
			],
			"name": "cryptorajah1244",
			"mentions": [
				{
					"sentence_index": 0,
					"offset": 0,
					"length": 15
				}
			]
		}
	]
}
```