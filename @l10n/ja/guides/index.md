# ガイド
このセクションでは、機能、ソリューションのウォークスルー、その他のトピックに関するガイダンスをご紹介します。 

## 利用を開始する
Tisaneの設定と利用開始を手早く行う方法を学び、最初のステップを踏み出しましょう。

* [利用を開始する](../quickstart/quickstart.md)

## サポートされている機能

* [対応言語一覧](./features/languages.md)
* [サポートされているNLP機能の一覧](./features/functionality.md)
* [機能：エンティティの抽出](./features/entities.md)
* [機能：トピックの抽出](./features/topics.md)
* [機能：センチメント分析](./features/sentiment.md)
* [機能：組み込み翻訳](./features/translation.md)
* [Tisaneは私のプログラミング言語をサポートしていますか？](./features/programminglanguages.md)
* [Tisaneは、問題のあるコンテンツが検出された場合、どのような対応を行いますか？](./features/actupon.md)
* [スラングと敵対的文章操作](./features/algospeak.md)
* [説明可能性と透明性](./features/explainability.md)

## 問題のあるコンテンツの種類

このセクションでは、モデレーターが関心を持つ概念の検出に関連する概念、または法執行機関での用途における捜査官が関心を持つ概念の検出に関連する概念について説明します。

* [Personal Attacks/Insults/Cyberbullying（個人攻撃／侮辱／ネットいじめ）](./abuse/personalattack.md)
* [Bigotry and Hate Speech（偏見・ヘイトスピーチ）](./abuse/hatespeechandbigotry.md)
* [Attempts to Establish External Contact（外部接触の試み）](./abuse/externalcontact.md)
* [Sexual Advances（不適切な性的表現）](./abuse/sexualadvances.md)
* [Adult-Only Content（成人向けコンテンツ）](./abuse/adultonly.md)
* [Allegations（告発）](./abuse/allegation.md)
* [Criminal Activity（犯罪行為）](./abuse/criminalactivity.md)
  - [Difference between Criminal Activity, Allegation, and Disturbing（犯罪行為・告発・迷惑行為の違い ）](./abuse/criminalallegationdisturbing.md)
* [Mental Issues and Suicidal Ideation（精神的問題・自殺念慮）](./abuse/mental.md)
* [Profanity（卑猥な言葉）](./abuse/profanity.md)
* [Data Leaks（データ漏洩）](./abuse/dataleak.md)
* [Contentious Content（論争を招くコンテンツ）](./abuse/contentious.md)
* [Disturbing Content（不安を引き起こす内容）](./abuse/disturbing.md)
* [Meaningless Content（意味のないコンテンツ）](./abuse/nomeaningfulcontent.md)
* [Assertion of Social Hierarchy（ヒエラルキーの主張）](./abuse/socialhierarchy.md)
* [Spam（スパム）](./abuse/spam.md)
* [Tags（タグ）](./abuse/tags.md)
* [2-Factor Moderation（ユーザー参加型モデレーション ）](./abuse/whatis2fm.md)

## ハウツートピック
Tisaneをさまざまなコンテンツモデレーションのシナリオに実装し、最適化するためのガイド：

* [キーワードブロックリストによるフィルタリング](./how-tos/blocklists.md)
* [位置情報を使用してテキストのスニペットを特定](./how-tos/locateasnippet.md)
* [ライブチャットのモデレーション ](./how-tos/liveusercontent.md)
* [ユーザー名のモデレーション](./how-tos/aliases.md)
* [脅威の検出](./how-tos/threats.md)
* [問題のあるコンテンツの検出](./how-tos/detectabuse.md)
* [国名の検出](./how-tos/extractnamesofcountries.md)
* [ゲームやスポーツのチャットにおける対戦で使用される言語の処理](./how-tos/gamingchat.md) 
* [以前に処理されたメッセージの考慮](./how-tos/usingmemory.md)

## 配布とデプロイメント

* [月間クォータを超過した場合、どうなりますか？](./deployment/exceedquota.md)
* [オンプレミスのデプロイメント](./deployment/onprem.md)
* [Tisaneをスタンドアロンマシンにデプロイされたアプリケーションに組み込むことは可能ですか？](./deployment/embedded.md)

## 設計哲学

* [言論の自由に関する議論](./features/freespeech.md)
* [なぜ、100%正確でない自動モデレーションをデプロイするのでしょうか？](./features/why-deploy.md)
* [なぜ、センチメントの評価に固定小数点または浮動小数点スケールでのスコアを提供しないのですか？](./features/score.md)
* [信頼値は存在しますか？](./features/confidencevalue.md)