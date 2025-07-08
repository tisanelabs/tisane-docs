# Ngôn từ tục tĩu

Ngôn từ tục tĩu được ghi vào phần `abuse`, với thuộc tính `type` được đặt thành `profanity`.

{% admonition type="warning" %}

Những lời lẽ phân biệt chủng tộc và xúc phạm khác không được coi là ngôn từ tục tĩu. Chúng được phân vào loại `bigotry`. 

Xem phần: [Cố chấp và phát ngôn thù hận](./hatespeechandbigotry.md) 

{% /admonition %}

## Mức độ nghiêm trọng

Các mức độ nghiêm trọng như sau:

* `low` - ngôn từ tục tĩu rất nhẹ thường không được coi là tục tĩu
* `medium` - phần lớn ngôn từ tục tĩu
* `high` - ngôn từ tục tĩu cực kỳ không phù hợp
* `extreme` - thường là những ngôn từ tục tĩu "hoàn toàn không thể chấp nhận được" (ví dụ: từ bắt đầu bằng chữ F trong tiếng Anh hoặc [từ mat trong các ngôn ngữ Slavic](https://en.wikipedia.org/wiki/Mat_(profanity)))

Các nỗ lực làm tối nghĩa (ví dụ như sử dụng dấu hoa thị) không ảnh hưởng đến mức độ nghiêm trọng.

## Thẻ liên quan

Các thẻ sau đây thường được liên kết với loại `profanity`:

* `sex` - ngôn từ tục tĩu liên quan đến hoạt động tình dục hoặc cơ quan sinh dục

## Ví dụ

Yêu cầu:
```json
{
  "language":"en",
  "content":"i hate this fu*r",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```

Phản hồi:
```json
{
	"text": "i hate this fu*r",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 12,
			"length": 4,
			"text": "fu*r",
			"type": "profanity",
			"severity": "extreme",
			"tags": [
				"sex"
			]
		}
	]
}
```
