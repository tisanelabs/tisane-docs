# 名前の分析、検証、比較

## フルネームのパーシング

Tisaneは、フルネームを主要な構成要素に分解することができます。

| 属性     | 説明                         |
| ------------- | ----------------------------------- |
| `given_name`  | 名（*John*など）           |
| `middle_name` | ミドルネーム（ある場合）         |
| `surname`     | 姓（*Doe*など）             |
| `title`       | 敬称（*Dr.、Mr.、Ms.*など）  |
| `suffix`      | 名前に付ける称号（*Jr.、Sr.、III*など） |
| `social_role` | *Haji*や*Dr.*などの役割          |

## 名前のパーシング方法

姓名をパーシングするには、以下とともに`POST /parse`リクエストを送信します。

* `"entity": "person"`
* `"words": true`


レスポンスは、`role`属性の下の名前の構成要素を分類します。

名前のパーシングの例：
![tisaneAliKilicoglu.png](/images/tisaneAliKilicoglu.png)


## 本名を検証する

Tisaneは、ユーザーの名前が本名かどうかを確認することはできませんが、以下に関連する多くの名前を認識することができます。

- 有名人（`important_person`）
- 架空の人物（`fictional_character`）
- 霊的存在（`spiritual_being`）
- 名前らしくない名前（例：User-13789026152908425434）

一般的な偽名のリストについては、[Quoraの投稿](https://qr.ae/pNKxWl)を参照してください。


`entity`構造の`subtype`属性は、検出された名前の種類を示し、ウィキデータIDがあればそれも示します。

架空の人物の名前のパーシングの例：

![tisaneFictionalCharacter.png](/images/tisaneFictionalCharacter.png)



## 名前を比較する

`/compare/entities`メソッドは、2つの名前を（複数の言語間でも）比較し、違いを検出することができます。

### 比較例

| 名前1           | 名前2                              | 結果                                                 |
| ---------------- | ----------------------------------- | ------------------------------------------------------ |
| *William Smith*  | *Will Smith*                        | `{"result":"different","differences":["variation"]}`   |
| *Musa Bin Osman* | *Haji Musa Bin Osman*               | `{"result":"different","differences":["social_role"]}` |
| *William Smith*  | *Вилл Смит* (Will Smith in Russian) | `{"result":"different","differences":["variation"]}`   |
| *Kevin Tan*      | *TAN Kevin*                         | `{"result":"same"}`                                    |

### **名前の比較方法**

`compare/entities`エンドポイントに比較したい名前を指定してリクエストを送ると、レスポンスとして以下のような属性の違いが返されます：

- `variation`（例：*William*と*Will*）
- `social_role`（例： *Haji Musa*と*Musa*）
- `case_difference`（例：*John Doe*と*JOHN DOE*）
- `same`（同姓同名（順番が異なっている場合でも））


## ニックネームとエイリアスの審査

ユーザー名やエイリアスは、誤解を招いたり、攻撃的であったり、悪用されたりする可能性があります。Tisaneは不適切なユーザー名（例：*Hitler*（ヒットラー）、*UserJohn_is_liar*（ユーザージョンは嘘つき）など）を検出します。

### ニックネームの審査方法

次のものと一緒に`POST /parse`リクエストを送信します。

- ` "format": "alias"`

- `subscope`設定は、キャメルケース、アンダースコア、スペースなしで書かれていても、名前が適切にセグメントされることを保証します。

ニックネームの審査例：

![tisaneAliasCreep.png](/images/tisaneAliasCreep.png)
