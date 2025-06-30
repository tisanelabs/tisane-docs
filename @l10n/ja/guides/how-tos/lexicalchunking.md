# 語彙チャンクとトークン化

Tisaneでは、語彙チャンクの表現に統一性を持たせ、論理的な形態素ベースの表現を採用しています。 

ドイツ語のような複合語を使う言語では、複合語は構成要素に切り分けられます。  

慣用的な[複数単語表現](https://en.wikipedia.org/wiki/Multiword_expression)（「kung fu」、「power plant」、「clay pigeon」）は1つの語彙とみなされます。

### 例：
* 英語："I don't see the power plant."=> ["I", "do", "n't", "see", "the", "power plant", "."]
* ドイツ語："Jetzt sollen die Stahlkugeln ersetzt werden."=> ["Jetzt", "sollen", "die", "Stahl", "kugeln", "ersetzt", "werden", "."]
* 中国語簡体字："我给了老张三本书" => ["我", "给了", "老张", "三", "本", "书"]（空白を使わない言語では、助詞は修飾する単語と一緒になることが多くあります。）
* スペイン語："Asimismo, San Francisco es una de las mejores ciudades de EE.UU."=> ["Asimismo", ",", "San Francisco", "es", "una", "de", "las", "mejores", "ciudades", "de", "EE.UU."]

## 使い方
トークン化／語彙チャンクにTisaneを利用するには：

1. `"words":true`を`settings`で指定する。
2. レスポンスでは、`sentence_list`セクションのすべての要素（個々の文章）を横断する。 
3. 語彙チャンクは `words`の下にあります。