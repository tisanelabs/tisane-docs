# エンティティの抽出

エンティティは、テキスト内の関連性や関心の対象となる要素です。Tisaneは、標準的なエンティティと、トラスト＆セーフティ／法執行機関のアプリケーションに関連するエンティティを抽出します。

標準的なエンティティは、人名、その社会的役割、組織、場所などです。Tisaneでは、暗号資産のアドレス、銀行口座番号、クレジットカード番号、電話番号、ソフトウェアパッケージ名など、さらに多くの情報も抽出しています。

エンティティは、`entities_summary`セクションに記録されます。すべてのエンティティエントリは、次の要素から構成されるオブジェクトです。
  * `type` - エンティティのタイプ
  * `name` - 標準名（存在する場合）。存在しない場合は、ログに記録された文字列
  * `subtypes` - より詳細な追加のタイプ
  * `subtype` - 最初のサブタイプ（後方互換性のため）
  * `mentions` - 検出されたすべてのメンションの配列、以下を含む。
    * `offset`
    * `length`
    * `sentence_index`
    * `text`
  * `wikidata` - Wikidata ID（存在する場合）  

検出されたエンティティの全リストを表示：[Response Reference](/apis/tisane-api-response-guide#named-entities)

## サブタイプ

追加の詳細は、文字列の`subtypes`配列に記載されています（最初のサブタイプは`subtype`属性としても記録されます）。

以下のサブタイプは、特定のエンティティタイプと関連付けられています。

- `person`
  - `fictional_character` - フィクション作品に登場するキャラクターの名前
  - `important_person` - 歴史上の人物、著名人、またはセレブの名前
  - `spiritual_being` - 神や天使、または悪霊の名前
- `organization`
  - `media` - メディア機関または定期刊行物
  - `authorities` - 政府機関
  - `law_enforcement_agency` - 法執行機関
  - `intelligence_agency` - 諜報機関
  - `military` - 軍隊
- `software`
  - `chat` - インスタントメッセージングに頻繁に使用されるソフトウェア全般
  - `online_community` - ソーシャルネットワークのようなオンラインコミュニティ
  - `low_trust_payment_method` - 支払い用に使用され、一般的に悪用されやすいと認識される
- `age`
  - `minor_age` - 承諾年齢未満の年齢
- `crypto`
  - `bitcoin`
  - `ethereum`
  - `dogecoin`
  - `erc20-wallet`
  - `monero`
  - `tether`
  - `dash`
  - `litecoin`
- `ip_address`
  - `v4` - IPアドレスバージョン4
  - `v6` - IPアドレスバージョン6
- `file`
  - `windows` - Windowsのパス名
  - `unix` - Unixのパス名
- `credit_card`
  - `american_express`
  - `visa`
  - `mastercard`
  - `maestro`
  - `jcb`
  - `discovery`
  - `diners_club`
  - `zcash`
- `credential`
  - `password`
- `website`
  - `high_risk` - マルウェアや詐欺に遭遇する可能性が高い
- `item_of_interest`
  - `cold_weapons`
  - `luxury` - 高級品全般（例：高級時計、ヨット、高級車）
  - `firearms`
  - `weapon`
