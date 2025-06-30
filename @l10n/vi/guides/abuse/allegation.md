# Cáo buộc

Cáo buộc là việc tuyên bố hoặc tố cáo một hành vi sai trái nào đó. Hành vi sai trái này có thể không phải là tội phạm, nhưng vẫn có khả năng gây tổn hại đến danh tiếng của một người. Các trường hợp phát hiện cáo buộc được ghi nhận trong mục `abuse`, với thuộc tính `type` được đặt là `allegation`. 

Phát hiện cáo buộc được sử dụng để:

* ngăn chặn tình trạng [ném đá đồng loạt](https://en.wikipedia.org/wiki/Review_bomb) trên các trang đánh giá và sàn giao dịch
* chặn các cuộc tấn công troll hàng loạt, đặc biệt là nhắm vào tài khoản của người nổi tiếng (cần kết hợp với phát hiện `personal_attack`)
* ngăn chặn các vụ kiện tụng liên quan đến nội dung phỉ báng bị cáo buộc được đăng trên cộng đồng hoặc tài khoản
* ngăn ngừa tổn hại danh tiếng

Thẻ liên quan: hầu hết tất cả các thẻ đều áp dụng vì phạm vi của cáo buộc rất rộng.

{% admonition type="warning" %}

Tisane không đưa ra giả định nào về tính xác thực hay không xác thực của các cáo buộc được nêu ra. Việc xác định cáo buộc đó có đúng sự thật hay không nằm ngoài phạm vi xử lý của chúng tôi.

{% /admonition %}

## Ví dụ

Yêu cầu:
```json
{
  "language":"en",
  "content":"He is a pickpocket",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```


Phản hồi:
```json
{
	"text": "He is a pickpocket",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 18,
			"text": "He is a pickpocket",
			"type": "allegation",
			"severity": "medium",
			"explanation": "Allegation of someone being a guilty party"
		}
	]
}
```

Xem thêm phần: [Sự khác biệt giữa Hoạt động tội phạm, cáo buộc và gây rối](./criminalallegationdisturbing.md)