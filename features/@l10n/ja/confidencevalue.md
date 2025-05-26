# Is There a Confidence Value?

We do not use confidence values for 2 reasons:

1. We witnessed on multiple occasions how the confidence values are abused. It is safe to say that **the confidence values do more harm than good**. 

Industry leaders like Alice Goguen Hunsberger (formerly a lead of Trust & Safety in Grindr) say that it's not uncommon for an ML model to have high confidence but be wrong, and the human moderators must not be swayed by it.

We view the confidence value as a security theater, introducing dangers like [automation bias](https://en.wikipedia.org/wiki/Automation_bias). In the perfect world, human moderators are PhDs in ethics debating big philosophical questions; in the real world, they are often underpaid students strongly encouraged to perform their tasks as fast as possible. The ["Computer says no"](https://en.wikipedia.org/wiki/Computer_says_no) phenomenon more often than not means the human moderators will say no, too.

2. Confidence values are simply not applicable to our headless NLP architecture.