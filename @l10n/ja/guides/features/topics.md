# トピックの抽出

トピックの抽出は、テキスト内の主要なトピックを特定します。 

{% admonition type="info" %}

この機能は、次のように呼ばれることもあります。

* テーマの特定
* テーマの検出
* 主要トピックの認識

{% /admonition %}

Tisaneはトピックを`topics`配列（`topic_stats`を持たない文字列、`topic_stats`を持つオブジェクト）に格納します。トピックはドキュメント単位です。

特定の単語に複数の意味がある場合、その単語の意味は現在の文脈において決定されなければなりません。例えば、ジュピターは惑星であり、ローマ神話の神でもあります。__それが惑星なのか神なのかは、文脈によって異なります。

例えば、「ジュノーはジュピターの妻である」という文は、神を指しています。__Tisaneは、関連するトピックとして`Roman mythology`、`supernatural`（神々）、 `relationship`、`family`（配偶者間のつながりが言及されているため）と判定しました。

```json
{
	"text": "Juno is the wife of Jupiter",
	"topics": [
		"supernatural",
		"Roman mythology",
		"relationship",
		"family"
	]
}
```

一方、「木星は火星よりも太陽から遠い」という文は惑星について言及しています。__Tisaneは、トピックが`outer space`と`astronomy`であると判定しました。

```json
{
	"text": "Jupiter is farther from the sun than Mars",
	"topics": [
		"outer space",
		"astronomy"
	]
}
```

## トピックの統計

`topic_stats`の設定が`true`に設定されている場合、トピックがアクティブである入力の該当部分が提供されます。トピックは文字列としてではなく、トピック自体（`topic`（文字列）属性）とその分布統計量（`coverage`（浮動小数）属性）からなるオブジェクトとして提供されます。

**例**

リクエスト：

```json
{
  "language":"en",
  "content":"Jupiter is farther from the sun than Mars. Which is not important in the current context",
  "settings": 
  {
    "topic_stats": true
  }
}
```

レスポンス：

```json
{
	"text": "Jupiter is farther from the sun than Mars. Which is not important in the current context",
	"topics": [
		{
			"topic": "outer space",
			"coverage": 0.5
		},
		{
			"topic": "astronomy",
			"coverage": 0.5
		}
	]
}
```
(both detected topics appear in 1 sentence out of 2, which is 0.5 of all sentences)

## 基準

Tisaneが`topic_standard`設定と組み合わせて使用できる一般的な分類基準があります。

* `native` - ネイティブのTisaneトピック名（トピックの標準的な英語の用語に基づく）。デフォルトの基準です。
* `iptc_code` - [IPTC（国際新聞電気通信評議会）メディアトピック](https://iptc.org/standards/media-topics/)の分類コード（メディア業界で採用されている規格）。
* `iptc_description` - IPTCコードの英語での説明。
* `iab_code` - [IAB（双方向広告業界団体）](https://www.iab.com/guidelines/content-taxonomy/)のコンテンツ分類のコード。
* `iab_description` - IABコードの英語での説明。
* `wikidata` - Wikidataコード（通常はQnnnnnの形式、例：Q123）。

基準を指定するには、`topic_standard`を追加します。 

**例**

リクエスト：

```json
{
  "language":"en",
  "content":"Jupiter is farther from the sun than Mars.",
  "settings": 
  {
    "topic_standard": "wikidata"
  }
}
```

レスポンス：

```json
{
	"text": "Jupiter is farther from the sun than Mars. Which is not important in the current contex",
	"topics": [
		"Q4169",
		"Q333"
	]
}
```


{% admonition type="warning" %}

これらの基準の分類は、ネイティブ基準のほんの一部にしか対応していません。概念が分類体系に含まれていない場合、その概念はレスポンスから省略されます。

{% /admonition %}