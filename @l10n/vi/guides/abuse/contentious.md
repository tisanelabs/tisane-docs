# Nội dung gây tranh cãi

Các trường hợp nội dung gây tranh cãi có khả năng dẫn đến tranh luận đối kháng sẽ được ghi nhận trong phần `abuse`, với thuộc tính `type` được đặt là `contentious`. 

Những trường hợp này bao gồm:

* khẳng định rằng một thực thể địa chính trị là hoặc không phải là một quốc gia, hoặc thuộc về một thực thể địa chính trị khác.
* khẳng định hoặc khái quát hóa về một nhóm xã hội không thuộc tầng lớp được bảo vệ
* thái độ tiêu cực đối với một thực thể địa chính trị
* kêu gọi hành động chính trị, đặc biệt nếu gây tranh cãi
* khẳng định rằng một nhân vật lịch sử khét tiếng được nhìn nhận là tích cực
* kử dụng biệt danh khiêu khích, nhằm châm ngòi cho xung đột

{% admonition type="info" %}

Bản thân khái niệm này cũng có thể là gây tranh cãi. Nó được tạo ra nhằm giải quyết hai mối quan tâm trái ngược nhau:

1. Trường hợp một cộng đồng muốn cho phép thảo luận chính trị, dù có tính đối kháng, nhưng không chấp nhận ngôn từ thù ghét (hoặc thành kiến).
2. Trường hợp một cộng đồng muốn cấm mọi hình thức hoạt động vận động (ví dụ: một cộng đồng về đan len, du lịch, v.v.).

{% /admonition %}

## Ví dụ

Yêu cầu:
```json
{
  "language":"en",
  "content":"Voldermort is a loser",
  "settings": 
  {
    "format":"alias", "snippets":true, "explain":true
  }
}
```


Phản hồi:
```json
{
	"text": "Voldermort is a loser",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 21,
			"text": "Voldermort is a loser",
			"type": "contentious",
			"severity": "medium",
			"explanation": "Nickname saying someone is bad person"
		}
	]
}
```