# 外部接触の試み

外部接触の試みには、以下のものが含まれます。

* 連絡先情報の交換（メールアドレス、電話番号、ユーザー名、支払い手段の識別子（例：暗号資産アドレスやIBANなど））
* 連絡先情報の収集（例：「WhatsAppのIDを教えていただけますか？」）
* 実際に会うことの調整またはプラットフォーム外でのコミュニケーションの誘導（例：「このウェブサイト外で話しましょう」）__

検出された外部接触の試みは、`abuse`セクションに記録され、`type`属性は`external_contact`に設定されます。

## ユースケースの事例

外部接触の試みを検出する必要がある事例を以下に示します。

* プラットフォーム上の詐欺師が、人々を誘い込もうとしている。
* 性犯罪者
* プラットフォームの利用規約に違反しようとする悪質なユーザー。例として、ユーザーにプラットフォーム外で手数料が発生しないより良い条件で取引を行うよう提案する業者
* レビュー内のステルスマーケティング
* セックスワーカーが、マッチングアプリなどのオンラインコミュニティ上のプロフィールで自身のサービスを紹介
* ユーザー名内の広告（例：URLなど）で、ユーザーをプロフィール内の連絡先情報を探すように誘導する行為など
* 走査対象者間の関係図の作成

{% admonition type="info" %}

より詳細なスキャンと、ユーザー名やレビュー内のURLの検出を行うには、`format`を`review`または`alias`に設定してください。

{% /admonition %}

## 関連タグ

  * `payment` - 支払いに関する一切の事項
  * `pii` - 個人を特定できる情報（PII）
  * `sex_work` - 性的なサービスの広告

## 例

リクエスト：

```json
{
  "language": "en",
  "content": "your wickr ?",
  "settings": {
    "snippets":true, "explain":true
  }
}
```

レスポンス：

```json
{
  "text": "your wickr ?",
  "topics": [
    "online chat"
  ],
  "abuse": [
    {
      "sentence_index": 0,
      "offset": 0,
      "length": 10,
      "text": "your wickr",
      "type": "external_contact",
      "severity": "low",
      "explanation": "Inquiry about messenger [ID]"
    }
  ],
  "entities_summary": [
    {
      "type": "software",
      "name": "wickr",
      "wikidata": "Q16334358",
      "mentions": [
        {
          "sentence_index": 0,
          "offset": 5,
          "length": 5,
          "text": "wickr"
        }
      ],
      "subtypes": [
        "chat"
      ],
      "subtype": "chat"
    }
  ]
}
```