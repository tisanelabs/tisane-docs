# 偏見・ヘイトスピーチ

このタイプは、ヘイトスピーチや偏狭な発言、[保護対象グループ](https://en.wikipedia.org/wiki/Protected_group)（差別対象となる可能性のあるグループ）を標的とした敵対的な発言を含みます。これには人種的中傷だけでなく、グループ全体に向けられた敵対的な発言も含まれます。 

現在、以下の発言が検出対象です。

- 民族または人種
- 宗教団体および[民族宗教](https://en.wikipedia.org/wiki/Ethnoreligious_group)団体
- 性的少数者（ただし、大部分の国で違法とされている場合（例：小児性愛者）を除く）
- 外国人／移民
- 無宗教の人
- 障害者
- カースト（インドなど）
- 肥満の人
- いずれかの性別

検出された差別的発言は、すべて中傷の一種として記録されます。割り当てられたタイプは`bigotry`であり、他の問題のあるコンテンツのタイプと同様に、状況に応じた重大度レベルが含まれます。

## 何が偏見やヘイトスピーチに該当しますか？

Tisaneでは、特定の集団（またはその集団に属する個人）に対して、その集団との関連性のみを理由として、敵意、否定的な意見、または差別や暴力を扇動する行為を偏見と定義します。

個人の感情と集団の一員であることとの関連性も、偏見の一例としてタグ付けされます。

### 暗黙の偏見
特定の集団を名指しせずに、その集団に対する暗黙の偏見（例：「この国から出て行け」）も認識の対象に含まれますが、これは認識が著しく困難です。

### 偏見ではない

- 攻撃対象：
  - 著名人
  - 特定の職業に従事する人
  - 特定の経験をした人（トラウマ的な経験であった場合でも）
- 集団に属するメンバーが不正行為を行った事に関する発言。 

これらの攻撃の一部は、`contentious`のフラグが立てられる場合があります。参考：[論争を招くコンテンツ](./contentious.md)

## 重大度

重大度は以下の通りです。

* `low` - 偏狭な意見や一般化で、特に侮辱的ではないもの
* `medium` - 偏狭な意見や表現（多くの差別的な言葉を含む）
* `high` - 極めて侮辱的な言葉または、集団の基本的な権利や存在権の否定
* `extreme` - 対象集団に対する暴力の扇動または集団の消滅を積極的に図る行為

## 関連タグ

以下のタグは`bigotry`のタイプに関連するものです。

* `ableism`
* `ageism`
* `anticatholicism`
* `antisemitism`
* `caste`（カーストに基づく差別）
* `christianophobia`
* `homophobia`
* `islamophobia`
* `racism`
* `religion`
* `sexism`
* `transphobia`
* `xenophobia`

## 例

リクエスト：

```json
{
  "language":"en",
  "content":"Antarcticans should be kicked out of our country",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```

レスポンス：

```json
{
	"text": "Antarcticans should be kicked out of our country",
	"topics": [
		"Antarctica"
	],
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 48,
			"text": "Antarcticans should be kicked out of our country",
			"type": "bigotry",
			"severity": "high",
			"explanation": "Protected group must be bothered"
		}
	]
}
```