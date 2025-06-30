# Nội dung vô nghĩa

Các trường hợp nội dung không mang ý nghĩa (ví dụ: những từ ngữ có vẻ như là vô nghĩa) sẽ được ghi nhận trong phần `abuse`, với thuộc tính `type` được đặt là `no_meaninful_content`.

Chức năng này được dùng để phát hiện các hành vi phát tán nội dung vô nghĩa do hacker thực hiện hoặc các lượt đăng ký tài khoản không hợp lệ, vô lý. 

{% admonition type="warning" %}

Nếu `format` được đặt là `alias`, nội dung sẽ được phân tích theo cách khác, và hệ thống có thể tìm kiếm những phần có ý nghĩa ngay cả khi toàn bộ đoạn văn bản trông có vẻ vô nghĩa.

Tương tự, các ký tự thường được dùng để làm rối (ví dụ: dấu hoa thị *) cũng có thể dẫn đến cách diễn giải khác.

{% /admonition %}

## Ví dụ

Yêu cầu:
```json
{
  "language":"en",
  "content":"asdkjasldkasdaasa",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```

Phản hồi:
```json
{
	"text": "asdkjasldkasdaasa",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 17,
			"text": "asdkjasldkasdaasa",
			"type": "no_meaningful_content",
			"severity": "low",
			"explanation": "Unidentifed (English)"
		}
	]
}
```
