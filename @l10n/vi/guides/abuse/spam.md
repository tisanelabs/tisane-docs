# Spam

Các trường hợp spam được ghi nhận trong mục `abuse`, với thuộc tính `type` được đặt là `spam`. 

{% admonition type="warning" %}

Hiện tại, khả năng phát hiện spam của chúng tôi còn hạn chế. Chúng tôi chủ yếu tập trung vào việc phát hiện spam trong phần đánh giá, hồ sơ cá nhân và tên người dùng.

{% /admonition %}

## Ví dụ:

Yêu cầu:
```json
{
  "language":"en",
  "content":"Luxury watches are affordable in Antarctica!",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```


Phản hồi:
```json
{
	"text": "Luxury watches are affordable in Antarctica!",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 43,
			"text": "Luxury watches are affordable in Antarctica",
			"type": "spam",
			"severity": "medium",
			"explanation": "Luxury items are cheap!",
			"tags": [
				"clickbait",
				"luxury",
				"sold_by_spammers"
			]
		}
	]
}
```