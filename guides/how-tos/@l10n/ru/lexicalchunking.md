# Lexical Chunking and Tokenization

Tisane uses a unified representation for lexical chunks, opting for a logical, morpheme-based representation. 

In languages using compounds like German, the compounds are sliced into constituents.  

Idiomatic [multi-word expressions](https://en.wikipedia.org/wiki/Multiword_expression) ("kung fu", "power plant", "clay pigeon") are viewed as a single lexeme.

### Examples
* English: "I don't see the power plant." => ["I", "do", "n't", "see", "the", "power plant", "."]
* German: "Jetzt sollen die Stahlkugeln ersetzt werden." => ["Jetzt", "sollen", "die", "Stahl", "kugeln", "ersetzt", "werden", "."]
* Simplified Chinese: "我给了老张三本书" => ["我", "给了", "老张", "三", "本", "书"] (In languages not using white spaces, particles are often joined with the word they modify.)
* Spanish: "Asimismo, San Francisco es una de las mejores ciudades de EE. UU." => ["Asimismo", ",", "San Francisco", "es", "una", "de", "las", "mejores", "ciudades", "de", "EE. UU."]

## How To Use
To use Tisane for tokenization/lexical chunking:

1. Specify `"words":true` in your `settings`.
2. In the response, traverse all elements in the `sentence_list` section (individual sentences). 
3. The lexical chunks are under `words`.