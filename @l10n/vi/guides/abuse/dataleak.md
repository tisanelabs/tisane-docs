# Rò rỉ dữ liệu

Các trường hợp rò rỉ dữ liệu, v.v. sẽ được ghi nhận trong phần `abuse` với thuộc tính `type` được đặt là `data_leak`.

## Các thẻ liên quan

Các thẻ sau đây thường được gắn với loại  `data_leak`:

* `pii` -  thông tin nhận dạng cá nhân (PII)
* `credentials` - thông tin xác thực điện tử, như tên người dùng, tài khoản, mật khẩu
* `payment` - dữ liệu liên quan đến thanh toán

## Ví dụ

Yêu cầu:

```json
{
  "language":"en",
  "content":"List of paypal accounts and ready for use",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```

Phản hồi:
```json
{
	"text": "List of paypal accounts and ready for use",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 23,
			"text": "List of paypal accounts",
			"type": "data_leak",
			"severity": "medium",
			"explanation": "List of web service accounts",
			"tags": [
				"data",
				"payment",
				"credentials",
				"pii"
			]
		}
	]
}
```
