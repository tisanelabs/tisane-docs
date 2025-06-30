# Gạ gẫm tình dục

Gạ gẫm tình dục được định nghĩa là những nỗ lực nhằm đạt được một dạng ân huệ hoặc khoái cảm tình dục nào đó. Những hành vi này có thể được chấp nhận hoặc không; Tisane không có mục đích phân định điều đó. 

Các hành vi gạ gẫm tình dục được ghi nhận là các trường hợp lạm dụng với loại là `sexual_advances` trong phần phản hồi. Như các hình thức lạm dụng khác, mỗi trường hợp phát hiện sẽ được gán mức nghiêm trọng; các hành vi gợi dục rõ ràng hơn sẽ bị đánh giá mức nghiêm trọng cao hơn.

## Thẻ liên quan

* `endearment`
* `pedophilia`
* `relationship_status` (ví dụ: hỏi người kia đã kết hôn hay chưa)
* `sex`
* `sex_work` (giúp phát hiện các đề cập đến người hành nghề mại dâm)

## Gạ gẫm tình dục vs Nội dung chỉ dành cho người lớn

Lưu ý rằng không phải mọi cuộc trò chuyện liên quan đến chủ đề tình dục đều là gạ gẫm tình dục. Chỉ những nỗ lực thực sự nhằm đạt được ân huệ hay khoái cảm tình dục mới được tính là gạ gẫm.

Mặc dù có sự chồng chéo đáng kể giữa hai loại `sexual_advances` và `adult_only`, nhưng chúng không hoàn toàn giống nhau. Ví dụ, việc đề cập đến các bộ phận cơ thể liên quan đến tình dục mà không có ngữ cảnh rõ ràng thì không được xem là gạ gẫm tình dục.

Để theo dõi tất cả nội dung tình dục, hãy chú ý:

* các trường hợp có loại là `sexual_advances`
* các trường hợp có loại là `adult_only` và có thẻ `sex`.

Xem phần: [Nội dung chỉ dành cho người lớn](./adultonly.md)

## Lưu ý quan trọng

- API không đưa ra quyết định thực thi; nó chỉ phát hiện và phân loại nội dung.
- Việc nội dung bị gắn cờ có vi phạm quy định cộng đồng hay không sẽ do người điều hành hoặc quản trị viên nền tảng quyết định. Ví dụ, hành vi gạ gẫm tình dục không vi phạm điều khoản sử dụng trong các ứng dụng hẹn hò.

## Ví dụ:

Yêu cầu:
```json
{
  "language":"en",
  "content":"do u hv a bf",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```

Phản hồi:
```json
{
	"text": "do u hv a bf",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 12,
			"text": "do u hv a bf",
			"type": "sexual_advances",
			"severity": "medium",
			"explanation": "Do you have partner"
		}
	]
}
```