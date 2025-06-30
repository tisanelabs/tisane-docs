# 個人攻撃

個人攻撃とは、侮辱、個人攻撃（人身攻撃）、ネットいじめ、または会話の参加者に対するその他のいかなる種類の攻撃を指します。検出された個人攻撃のインスタンスは、`abuse`セクションに記録され、`type`属性は`personal_attack`に設定されます。

## 個人攻撃とみなされないものは何ですか？

- 社会集団に対する攻撃

   - 対象が民族的、宗教的、または人種的な集団である場合、これは`bigotry`（ヘイトスピーチ）に分類されます。
   - 他の社会集団に対する攻撃は、いずれのカテゴリーにも該当しない場合があります。または、`contentious`（争いを引き起こす可能性のあるコンテンツ）としてマークされる場合があります。

- 架空のキャラクターまたは著名人に対する攻撃

   - 架空のキャラクターや著名人に対する批判は、個人攻撃には該当しません。
   - 現在、会話に参加していない人物に対する攻撃。つまり、2人称（「あなた」）ではなく、ユーザーのハンドル名（例：@user12345）に紐付けられた発言で特定されていないすべてのユーザーを指します。 
   - 個人を直接攻撃しない否定的な感情。例えば、「お前の音楽はひどい」は個人的な攻撃ではありません。__

## 例

リクエスト：

```json
{
  "language":"en",
  "content":"You are so stupid, nobody likes you here!",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```

レスポンス：

```json
{
	"text": "You are so stupid, nobody likes you here!",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 17,
			"text": "You are so stupid",
			"type": "personal_attack",
			"severity": "medium",
			"explanation": "Calling someone unsatisfactory"
		},
		{
			"sentence_index": 0,
			"offset": 19,
			"length": 16,
			"text": "nobody likes you",
			"type": "personal_attack",
			"severity": "medium",
			"explanation": "Claim of universal dislike"
		}
	]
}
```

## デフォルトポリシーの再定義

デフォルトのポリシー（第三者を除外する設定）は、`memory`モジュールを使用して変更可能です。

### 指定された当事者に対する攻撃の検出

名前で参照されている人物に対する攻撃を検出するため、以下のメモリ設定を追加してください。

```json
{
  "assign": [
    {
      "if": {
        "features": [
          {
            "index": 1,
            "value": "NOUN"
          },
          {
            "index": 14,
            "value": "NA"
          },
          {
            "index": 22,
            "value": "PERS"
          }
        ]
      },
      "then": {
        "features": [
          {
            "index": 33,
            "value": "DIPA"
          }
        ],
        "hypernym": 123887
      }
    }
  ]
}
```

例：

```json
{
  "language": "en",
  "content": "John Smith sucks",
  "settings": 
  {
    "memory":
    {
      "assign": [
      {
        "if": {
          "features": [
            {
              "index": 1,
              "value": "NOUN"
            },
            {
              "index": 14,
              "value": "NA"
            },
            {
              "index": 22,
              "value": "PERS"
            }
          ]
        },
        "then": {
          "features": [
            {
              "index": 33,
              "value": "DIPA"
            }
          ],
          "hypernym": 123887
        }
      } ]
    }
  }
}
```

### すべての第三者に対する攻撃の検出

すべての第三者に対する攻撃を検出するため、以下のメモリ設定を追加してください。

```json
{
  "assign": [
    {
      "if": {
        "features": [
          {
            "index": 1,
            "value": "NOUN"
          },
          {
            "index": 9,
            "value": "3"
          },
          {
            "index": 22,
            "value": "PERS"
          }
        ]
      },
      "then": {
        "features": [
          {
            "index": 33,
            "value": "DIPA"
          }
        ],
        "hypernym": 123887
      }
    }
  ]
}
```

例：

```json
{
  "language": "en",
  "content": "He is an idiot",
  "settings": 
  {
    "memory":
    {
      "assign": [
      {
        "if": {
          "features": [
            {
              "index": 1,
              "value": "NOUN"
            },
            {
              "index": 9,
              "value": "3"
            },
            {
              "index": 22,
              "value": "PERS"
            }
          ]
        },
        "then": {
          "features": [
            {
              "index": 33,
              "value": "DIPA"
            }
          ],
          "hypernym": 123887
        }
      } ]
    }
  }
}
```