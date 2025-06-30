# 犯罪行為

Tisaneは、検出された犯罪行為のインスタンスを`abuse`セクションに記録し、`type`属性を`criminal_activity`に設定します。 

## 検出する内容

以下の内容に関連するテキストを特定し、フラグを立てます。

- 違法な物品（麻薬、武器、爆発物、密猟された野生生物など）の輸送、配送、製造に関する計画立案と調整。
- 人身取引と人体臓器の売買。
- 武器（化学兵器および生物兵器を含む）、麻薬、爆発物の作成、流通に関する問い合わせや指示。
- 暴力や犯罪行為の脅威。
- 規制品目の検索（例：銃器、弾薬、爆発性前駆物質）。検索クエリを分析するには、`format`パラメータを`search`に設定します。

{% admonition type="warning" %}

1. 犯罪行為の種類には、他人が犯した犯罪に関する会話や告発は含まれません。`criminal_activity`の種類は、進行中の犯罪または犯罪行為の自白を検出することを目的としています。犯罪に関する会話を検出するには、トピック抽出を使用します。参考：[トピックの抽出](../features/topics.md)。他人が犯罪を犯したとの告発を検出するには、[告発](./allegation.md)をご覧ください。
2. 法規制は管轄によって異なるため、`tags`を確認して該当するインスタンスを無視するかどうかを判断してください。例えば、`cannabis`や`soft_drug`という表現を使用することで、マリファナの使用に関する言及を無視することができます。

{% /admonition %}

### 例

リクエスト：

```json
{
	"language":"en",
	"content":"we sell elephant tusks. Great prices and top notch quality!", 
	"settings": 
  {
	 "snippets":true
  }
}
```

レスポンス：
```json
{
	"text": "we sell elephant tusks. Great prices and top notch quality!",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 23,
			"text": "we sell elephant tusks.",
			"type": "criminal_activity",
			"severity": "high",
			"tags": [
				"for_sale",
				"wildlife"
			]
		}
	]
}
```

## 関連タグ

`tags`の配列には、以下のタグが含まれる場合があります。

### 犯罪

* `bodily_harm`
* `bribery`
* `call_for_violence`
* `crime`
* `death`
* `doxing`
* `escape`（矯正施設）
* `extortion`
* `hacking_services`
* `human_trafficking`
* `money_laundering`
* `organized_crime`
* `organ_trade`
* `pedophilia`
* `piracy`
* `scam`
* `tax_evasion`
* `terrorism`
* `threat`
* `violence`
* `wildlife`（密猟）

### 規制薬物

* `controlled_substance`
* `soft_drug`
* `cannabis`
* `khat`
* `hard_drug`
* `cocaine`
* `ecstasy`
* `hallucinogen`
* `heroin`
* `meth`
* `medication`
* `opioid`

### その他規制品目

* `cold_weapons`
* `explosives`
* `firearms`
* `weapon`
* `contraband`（状況による）

### その他

* `admission` - 犯罪の自白
* `credentials`
* `cryptocurrency`
* `debt`
* `payment`

## 関連するエンティティの種類

`item_of_interest` entity type detects items potentially of interest to the investigation: luxury items, drugs, medications, vehicles.

## オフラインおよび法執行機関での利用

法執行機関のアプリケーションは、多くの場合、エアギャップ環境で動作する必要があります。このニーズに対応するため、[Tisaneエンベデッド](../../sdks/index.md)をご用意しています。Tisaneエンベデッドは、Tisaneをプロセス内ライブラリとして実行することが可能です。[オンプレミスのインストール](/guides/deployment/onprem)もご利用いただけます。 


