# Phân tích cảm xúc

Phân tích cảm xúc trả lời cho câu hỏi liệu tác giả có thái độ tích cực hay tiêu cực đối với điều gì đó. Các trường hợp phát hiện cảm xúc sẽ được ghi lại trong phần `sentiment_expressions`; thuộc tính `polarity` xác định cảm xúc là:

* `positive` (tích cực)
* `negative` (tiêu cực)
* `mixed` (lẫn lộn)

## Thiết lập tùy chọn

* `explain` - nếu đặt là `true`, bao gồm giải thích lý do gắn cờ.
* `snippets` - nếu đặt là `true`, bao gồm trích đoạn nội dung tạo ra cảm xúc đó.
* `document_sentiment` - nếu đặt là `true`, cảm xúc tổng thể của toàn bộ văn bản sẽ được cung cấp tại thuộc tính  `sentiment` ở cấp độ gốc. 

## Phân tích cảm xúc theo khía cạnh (ABSA) là gì?

Theo định nghĩa của Wikipedia, [ABSA](https://en.wikipedia.org/wiki/Sentiment_analysis#Feature/aspect-based)) là phương pháp xác định cảm xúc đối với từng khía cạnh cụ thể được đề cập trong bài đánh giá, thay vì gán một điểm cảm xúc duy nhất cho toàn bộ tài liệu hoặc bài viết. 

Nói đơn giản, ABSA đối với phân tích cảm xúc cũng giống như truyền hình màu so với truyền hình đen trắng: nó thêm chiều sâu và độ rõ ràng.

Xem xét ví dụ sau:

> “Bữa sáng hơi nhạt nhẽo nhưng khách sạn gần các điểm tham quan chính.” 

Một chủ khách sạn cần thông tin mang tính hành động sẽ cần biết rằng:

- Cảm xúc đối với **food** (đồ ăn) là *negative* (tiêu cực).
- Cảm xúc đối với **location** (địa điểm) là *positive* (tích cực).

Một điểm cảm xúc đơn lẻ như 0,14 hoặc -0,57 sẽ không có ý nghĩa trong trường hợp này. Khi tổng hợp nhiều bài đánh giá có nhiều khía cạnh như vậy, các điểm số đơn giản đó sẽ tạo ra một bức tranh sai lệch, không phản ánh đúng cảm xúc thực sự của khách.

{% admonition type="info" %}

Do đó, bạn nên đặt thiết lập `format` thành `review` để hệ thống phân tích cảm xúc chi tiết hơn.

{% /admonition %}

## Ví dụ

Yêu cầu:

```json
{
  "language":"en",
  "content":"The breakfast was a bit tasteless but the hotel is close to the major attractions",
  "settings": 
  {
    "format":"review", "snippets":true, "document_sentiment":true
  }
}
```

Phản hồi:

```json
{
	"text": "The breakfast was a bit tasteless but the hotel is close to the major attractions",
	"sentiment": 0.12345679012345679,
	"sentiment_expressions": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 33,
			"text": "The breakfast was a bit tasteless",
			"polarity": "negative",
			"reasons": [
				"tasteless"
			],
			"targets": [
				"food"
			]
		},
		{
			"sentence_index": 0,
			"offset": 38,
			"length": 43,
			"text": "the hotel is close to the major attractions",
			"polarity": "positive",
			"targets": [
				"location"
			]
		}
	]
}
```