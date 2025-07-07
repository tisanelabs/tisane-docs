# Tôi có thể gửi phản hồi để cải thiện kết quả không?

Có.

Phương thức là `POST /feedback.` (Lưu ý: đây là phương thức thuộc dịch vụ web LaMP, không phải Tisane.)

Chỉ cần gửi lại yêu cầu gốc đến API của Tisane, đồng thời chỉ định khóa API hoặc mã tùy chỉnh của bạn trong phần tiêu đề Ủy quyền.

Ví dụ:

Nội dung yêu cầu

```json
{"language":"en", "content":"it's alive", "settings":{}}
```

Phương thức này sẽ trả về phản hồi ở định dạng JSON với các thuộc tính sau:

success (boolean): cho biết việc gửi phản hồi có thành công hay không
error (kiểu chuỗi, tùy chọn): nếu có lỗi xảy ra, mô tả lỗi là gì
Phản hồi này chỉ phục vụ mục đích gỡ lỗi. Bạn có thể gửi yêu cầu một cách bất đồng bộ và bỏ qua phản hồi.