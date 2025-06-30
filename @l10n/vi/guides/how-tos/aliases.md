# Kiểm duyệt Tên người dùng

Việc kiểm duyệt bí danh / tên người dùng / biệt danh khác với việc kiểm duyệt nội dung trò chuyện và tin nhắn.

Các URL xuất hiện trong tên thường là dấu hiệu rõ ràng của spam. Nếu ai đó đặt tên là _BtcKing111_, thì rõ ràng mục đích của họ là gì. Việc nhắc đến _3rd reich_ trong cuộc trò chuyện rất khác với việc sử dụng nó làm tên người dùng.

Đó là lý do Tisane có chế độ đặc biệt dành cho bí danh. Để kích hoạt logic kiểm duyệt bí danh, hãy chỉ định **"format":"alias"** trong cấu hình cài đặt.

## Nhận diện ngôn ngữ

Một “bẫy” phổ biến là việc lựa chọn ngôn ngữ. Vì Tisane có chức năng tự động nhận diện ngôn ngữ, nhiều người bị hấp dẫn bởi cách dùng dấu sao ("language":"*"). Đừng làm vậy!

Thứ nhất, việc nhận diện ngôn ngữ không hiệu quả với chuỗi ngắn hơn 30–50 ký tự. Đôi khi, không thể xác định chính xác ngôn ngữ. Hãy xem từ “status”. Nó là cùng một từ trong tiếng Pháp, Tây Ban Nha, Anh và nhiều ngôn ngữ khác. Nếu bạn cố xác định ngôn ngữ chỉ dựa vào từ “status”, thì đâu là câu trả lời đúng? Không có câu trả lời chắc chắn, đó chính là bản chất của ngôn ngữ. (Một lập trình viên từng hỏi rằng liệu thêm số hoặc khoảng trắng vào cuối có giúp ích không. Câu trả lời là: không.)

Với bí danh, vấn đề còn phức tạp hơn: chúng không nhất thiết là từ hợp lệ trong bất kỳ ngôn ngữ nào. Chúng có thể là tổ hợp ký tự từ các từ khác nhau. Hoặc là các phần tên ghép lại với nhau (mà lại có thể hợp lệ trong nhiều ngôn ngữ như: Peter, John…).

Vậy làm sao để biết ngôn ngữ của bí danh? Một cách là dựa vào cấu hình hoặc địa chỉ IP của người dùng — nhưng điều này cực kỳ không đáng tin. Hơn nữa, hầu hết bí danh được tạo ra để các thành viên khác trong cộng đồng hiểu được, và hiện nay phần lớn khán giả là toàn cầu. Bí danh tiếng Anh không chỉ đến từ Mỹ hoặc Anh. Chưa kể đến việc người dùng cố tình gây nhiễu bằng cách ghép từ ngẫu nhiên.

Vấn đề tiếp theo là đối tượng khán giả của bạn. Một tên có thể hoàn toàn chấp nhận được trong tiếng Đức nhưng lại mang tính xúc phạm trong tiếng Anh. Và điều này có thể xảy ra với mọi tổ hợp ngôn ngữ. Các nhà tiếp thị rất hiểu điều này.

Liệu Tisane có thể quét tất cả các ngôn ngữ để tìm nội dung vi phạm? Chúng tôi đã cân nhắc và quyết định không áp dụng cách đó, vì phần lớn cộng đồng phản đối.

Chúng tôi khuyến nghị một số hướng như sau:

1. Với các bảng chữ cái Latin, hãy giả định bí danh là tiếng Anh hoặc một trong các ngôn ngữ chính của cộng đồng bạn. Với mỗi ngôn ngữ cần xác minh, hãy gửi một yêu cầu riêng biệt. (Lưu ý: không nên dùng viết dạng phân tách bằng dấu gạch dọc như en|fr|es: mục đích của nó là để kích hoạt chế độ nhận diện ngôn ngữ tự động.)
2. Với các hệ chữ phi Latin, hãy quét bằng ngôn ngữ chính đi kèm với hệ chữ đó.

Không cần lo về việc lọc URL, email, v.v... vì chúng được bao gồm trong mọi ngôn ngữ. Hệ thống cũng tự động phân tách các biệt danh thành thành phần riêng biệt (ví dụ _cryptorajah1244_ -> _crypto|rajah_).

**Ví dụ**

Yêu cầu:
```json
{
  "language": "en",
  "content": "cryptorajah1244 ",
  "settings": {
    "format": "alias"
  }
}
```

Phản hồi:
```json
{
	"text": "cryptorajah1244 ",
	"topics": [
		"cryptocurrency",
		"finance",
		"aristocracy"
	],
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 11,
			"type": "spam",
			"severity": "high",
			"tags": [
				"cryptocurrency"
			]
		}
	],
	"entities_summary": [
		{
			"type": "role",
			"name": "rajah",
			"mentions": [
				{
					"sentence_index": 0,
					"offset": 6,
					"length": 5
				}
			]
		},
		{
			"type": [
				"username",
				"person",
				"identifier"
			],
			"name": "cryptorajah1244",
			"mentions": [
				{
					"sentence_index": 0,
					"offset": 0,
					"length": 15
				}
			]
		}
	]
}
```