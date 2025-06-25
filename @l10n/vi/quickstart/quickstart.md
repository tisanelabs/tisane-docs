# Bắt đầu sử dụng Tisane
Bắt đầu hành trình của bạn bằng cách tìm hiểu cách thiết lập và sử dụng nhanh Tisane API.

## Bước 1 – Tạo tài khoản

<a href="https://dev.tisane.ai/signup/" target="_blank">Sign up to Tisane API</a> 

Gói Cộng đồng miễn phí hỗ trợ tối đa 50.000 yêu cầu, với giới hạn 10 yêu cầu mỗi phút. (Hoặc nếu muốn thì bạn có thể mua gói trả phí.)

## Bước 2 - Lấy khóa API

Tisane API sử dụng khóa API để xác thực các yêu cầu. Truy cập vào <a href="https://dev.tisane.ai/profile" target="_blank">Hồ sơ nhà phát triển</a> của bạn để xem và quản lý khóa API.

## Bước 3 - Sử dụng API

 Thực thi phương thức `POST/parse`. Phần nội dung yêu cầu của phương thức này cần có ba thuộc tính sau:

- `content` (chuỗi)
- `language` (chuỗi)
- `settings` (đối tượng)

**Ví dụ**:  

Yêu cầu:
 ```json
    {
      "language": "en", 
      "content": "Hello Tisane API", 
      "settings": {}
    }
 ```
 Phản hồi:
 ```json
 {
	"text": "Hello Tisane API",
	"topics": [
		"natural language processing",
		"artificial intelligence"
	],
	"entities_summary": [
		{
			"type": "software",
			"name": "Tisane API",
			"mentions": [
				{
					"sentence_index": 0,
					"offset": 6,
					"length": 10
				}
			]
		}
	]
}
```

|Trên nền tảng đám mây công cộng, độ dài tối đa của phần nội dung JSON là 2048 byte. Yêu cầu dài hơn được hỗ trợ trong phiên bản triển khai tại chỗ.|
|-----------------------------------------|

Bạn có thể thử gửi yêu cầu ngay trên cổng này hoặc sử dụng tùy chọn _Dùng thử_ trong <a href="https://dev.tisane.ai/api-details#api=5a3b6668a3511b11cc292655&operation=5a3b7177a3511b11cc29265c" target="_blank">Cổng thông tin dành cho nhà phát triển</a>.
Bạn cũng có thể thử nghiệm bằng cách dùng curl, Postman, Insomnia hoặc bất kỳ công cụ RESTful nào khác.

### Cú pháp curl 

```curl
curl -V -X POST \
  https://api.tisane.ai/parse \
  -H "Ocp-Apim-Subscription-Key: your_primary_or_secondary_API_key;_not_needed_on-prem" \
  -H "Content-Type: application/json" \
  -d '{
    "language": "en",
    "content": "Hello Tisane API!",
    "settings": {}
  }'
  ```

## Khắc phục sự cố

API hoạt động thông qua **yêu cầu POST** tiêu chuẩn. 

Nếu bạn gặp lỗi hết thời gian:
- Hãy kiểm tra kết nối mạng của bạn.

---

Nếu bạn gặp mã lỗi 401 (Không được phép):
```json
{
	"statusCode": 401,
	"message": "Access denied due to invalid subscription key. Make sure to provide a valid key for an active subscription."
}
```
- Đảm bảo đã cung cấp đúng khóa API làm giá trị cho tiêu đề `Ocp-Apim-Subscription-Key`. 

{% admonition type="info" %}

Để sử dụng khóa API của bạn trên Cổng thông tin tài liệu này, hãy nhấp vào nút _Bảo mật_ trong trang _Dùng thử_.

(The Developer Portal automatically fills the API key when you sign in.)

{% /admonition %}

---

Nếu bạn gặp mã lỗi 400 (Yêu cầu không hợp lệ) cho biết ngôn ngữ không có trong cơ sở dữ liệu:
- Hãy đảm bảo rằng bạn đang chỉ định đúng mã ngôn ngữ theo chuẩn ISO-639-1 và ngôn ngữ đó được Tisane hỗ trợ.

Nếu bạn cần thêm sự trợ giúp:

* [Liên hệ hỗ trợ](../support/support.md) để chúng tôi giúp bạn tìm ra nguyên nhân sự cố.
* [Mẹo khắc phục sự cố](../support/troubleshooting.md)

Tiếp theo:

* [Cách phát hiện nội dung có vấn đề](../guides/how-tos/detectabuse.md)
* [Danh sách các chức năng NLP được hỗ trợ](../guides/features/functionality.md)
* [Danh sách các ngôn ngữ được hỗ trợ](../guides/features/languages.md)