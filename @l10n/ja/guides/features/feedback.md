# 結果を改善するためにフィードバックを送信することはできますか？

はい。

メソッドは`POST /feedback.`です（注意：これはLaMPウェブサービス内のメソッドであり、Tisaneではありません）。

元のTisane APIリクエストをそのまま転送し、AuthorizationヘッダーにAPIキーまたはカスタムコードを指定します。

例：

本文

```json
{"language":"en", "content":"it's alive", "settings":{}}
```

このメソッドは、以下の属性を持つJSONレスポンスを返します。

success (boolean)：フィードバックの送信が成功したかどうか
error (string, optional)：エラーが発生した場合、エラーの内容
このレスポンスはデバッグのみを目的としています。リクエストを非同期で送信し、レスポンスを無視できます。