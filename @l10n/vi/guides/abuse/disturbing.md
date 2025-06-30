# Nội dung gây khó chịu

Các mô tả hình ảnh chi tiết mang tính bạo lực hoặc thương tích khi bị phát hiện sẽ được ghi nhận trong mục `abuse`, với `type` thuộc tính được đặt là `disturbing`.

{% admonition type="warning" %}

Nội dung gây khó chịu có thể là, hoặc không phải là hành vi tội phạm. Xem: [Sự khác biệt giữa Hoạt động phạm tội, Cáo buộc và Nội dung gây khó chịu](./criminalallegationdisturbing.md)

{% /admonition %}

## Ví dụ

Yêu cầu:

```json
{
	"language":"en",
	"content":"his finger was cut off", 
	"settings": 
  {
	 "snippets":true
  }
}
```

Phản hồi:

```json
{
	"text": "his finger was cut off",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 22,
			"text": "his finger was cut off",
			"type": "disturbing",
			"severity": "extreme"
		}
	]
}
```