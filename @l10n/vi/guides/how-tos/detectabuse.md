# Phát hiện nội dung có vấn đề

Các trường hợp nội dung có vấn đề sẽ được ghi vào phần `abuse`. 

Phần này sẽ xuất hiện nếu:

1. Tìm thấy các loại nội dung có vấn đề, và;
2. Cài đặt `abuse` được đặt thành `true` (hoặc bỏ qua).

Một thành viên của mảng `abuse` chứa:

* dữ liệu vị trí
  * `offset` - một vị trí bắt đầu từ số không nơi bắt đầu đoạn văn bản 
  * `length` - độ dài của đoạn văn bản
  * `sentence_index` - câu chứa đoạn văn bản
* `type` - loại nội dung có vấn đề
* `severity` - mức độ nghiêm trọng của vấn đề, có thể được sử dụng để ưu tiên các trường hợp được phát hiện
* `explanation` - một sự giải thích dễ hiểu với con người về lý do tại sao hệ thống cho rằng nội dung này có vấn đề. (Nếu cài đặt `explain` được đặt thành `true`)
* `text` - đoạn văn bản có vấn đề. (Nếu cài đặt `snippets` được đặt thành `true`) 

{% admonition type="warning" %}

**Không thực hiện bất kỳ hành động nào đối với tất cả các mục nhập** trong phần `abuse` mà không có sự phân biệt. 

Người kiểm duyệt hoặc người tạo chính sách có trách nhiệm quyết định xem nội dung bị gắn cờ có thực sự gây vấn đề trong bối cảnh cộng đồng hay không. Ví dụ: Hạn chế những hành vi tình dục trong ứng dụng hẹn hò hoặc kiểm duyệt lời nói tục tĩu trong những cộng đồng mà những hành vi này được chấp nhận rộng rãi có thể là những việc không phù hợp.

Mỗi loại nội dung có vấn đề khác nhau cần có biện pháp xử lý khác nhau. Ví dụ, hiển nhiên việc phát hiện hành vi tự tử không dẫn đến việc cấm người dùng. 

Đối với các ứng dụng như bộ công cụ điều tra, đây lại là một loại thông tin được trích xuất khác. Tuy nhiên, vì mục đích sử dụng, bạn nên cân nhắc đến nhu cầu thực tế và không nên cung cấp cho người dùng quá nhiều dữ liệu mà họ có thể không cần.

{% /admonition %}

Để tham khảo về các loại nội dung có vấn đề, xem phần: [Nội dung có vấn đề](/apis/tisane-api-response-guide#supported-types).

## Nếu bạn không muốn phát hiện nội dung có vấn đề

Nếu nội dung có vấn đề không liên quan, hãy chủ động đặt cài đặt `abuse` thành `false`, hoặc chỉ cần bỏ qua phần đó.

## Xác định vị trí đoạn văn bản có liên quan trong văn bản

Để trích xuất đoạn văn bản chính xác có chứa nội dung lạm dụng, hãy sử dụng **location data** được cung cấp trong phản hồi.

Để biết thêm chi tiết, xem phần: [Cách xác định vị trí một đoạn trích dựa trên dữ liệu vị trí](./locateasnippet.md)

{% admonition type="info" %}

Nếu tất cả những gì bạn cần là bản thân đoạn văn bản, chỉ cần thêm `"snippets":true` vào đối tượng `settings` và sử dụng thuộc tính `text` ở cấp độ của từng đối tượng `abuse` riêng lẻ.

{% /admonition %}

## Phát hiện nội dung lạm dụng có giống với phân tích cảm xúc không?

Nội dung lạm dụng và phân tích cảm xúc là hai khía cạnh khác nhau.

Đúng là nội dung lạm dụng và có vấn đề thường có những vùng giao thoa với cảm xúc tiêu cực. Nhưng không phải lúc nào cũng vậy. Ví dụ, khi ai đó quảng cáo “cocaine chất lượng cao”, rõ ràng là có cảm xúc tích cực, nhưng đây lại là hoạt động tội phạm cần được gắn nhãn là `abuse`.

Khi ai đó trao đổi thông tin liên lạc, cảm xúc là trung lập; tuy nhiên, nó vẫn có thể được đánh dấu là `external_contact`. Những lời lẽ phân biệt chủng tộc cũng có thể dễ dàng được sử dụng trong những câu nói mang tính tích cực.

Mặt khác, “cảm xúc rất tiêu cực” không nhất thiết có nghĩa là bắt nạt trên mạng hoặc phát ngôn gây thù hận. Ngay cả những câu nói như "Tôi ghét anh ta" cũng không phải là lời công kích cá nhân, vì chúng không nhắm vào người đang tham gia vào cuộc trò chuyện hiện tại.  Xem phần: [Tấn công cá nhân](../abuse/personalattack.md)