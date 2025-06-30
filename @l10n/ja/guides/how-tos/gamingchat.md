# ゲームやスポーツのチャットにおける競争的な言葉の処理 

## 競争的な言葉の課題

*“Kill him! Kill him NOW!”*
*“I will kick your a*!”*
*“Touch your chest. Then push the ball harder.”*

コンピュータゲームやスポーツ関連のコミュニティでチャットを処理する場合、モデレーションAPIはジレンマに直面します。 

通常、ポリシー違反とみなされる発言を無視することはできません。 

しかし、悪のカリスマ「ドクター・イーブル」の支持者が言うように、*「ここで本当に殺し合いをしたいわけではない」*のです。  それでも、現実にある脅迫は真剣に受け止めなければなりません。

### 重大度レベルを使用することの問題点

モデレーションAPIには、「重大度レベル」を割り当て、ある閾値以下のメッセージは無視するようユーザーに助言することで、これに対処しようとするものもあります。

ゲームの暴力は重大なものである可能性がありますが、それでも現実世界とは何の関係もありません。  つまり、最も厳しい発言であっても無視すべきだということになります。同時に、この重大度ベースのアプローチは、無視すべきではない本物の脅威をフィルタリングしてしまう危険性があります。

## Tisaneのアプローチ

Tisaneは、このジレンマに対処する2つの方法を提示します。

- **方法1**：クライアントアプリ側で、 `violence` and `death`といったタグを持つ`criminal_activity`タイプの発生をすべて無視します。

- **方法2**（推奨）：特別な`game violence`フラグを使用し、ゲームやスポーツの競争的な言葉を無視します。

例：

```

{"language":"en","content":"Shoot him!!!","settings":{"snippets":true,"memory":{"flags":["game_violence_ok"]}}}

```
`game_violence_ok`フラグは、スポーツの競争的な言葉やゲームの暴力に関連するすべての警告を止めます。 

注：このフラグは、*「どこに住んでいるか知っている」*といった実際の脅迫や、明らかにゲームとは関係のないものは止めません。

### 出力

`game violence`フラグがない場合の例：

![tisaneShootHimNoGVOK.png](/images/tisaneShootHimNoGVOK.png)

`game violence`フラグセットがある場合の例：

![tisaneGvOk.png](/images/tisaneGvOk.png)

こちらも参考：[2要素モデレーション](../abuse/whatis2fm.md)

##  iGamingプラットフォームでTisaneを使用

TisaneのiGamingのクライアントは通常、以下をモデレートするためにTisaneを使用します。

- リアルタイムチャット
- ユーザー名

ロジックはチャットモデレーションとは異なります。例：  *BitcoinKing*、*Hitler*、*nakedsupermodels*などは、ユーザーの意図について大体の見当はつきます。

2つのモデレーション機能は、同じ方法（`POST /parse`）で処理されます。 

唯一の違いは、`format`設定です。

- チャットには `"format":"dialogue"`を使用する。 
- ユーザー名には`"format":"alias"`を使用する。

PubNubのパートナーはチャットインフラと[Tisane向けのシームレスに統合されたオープンソースのモデレーションダッシュボード](https://www.pubnub.com/demos/moderation-dashboard/)の両方を提供しています。

