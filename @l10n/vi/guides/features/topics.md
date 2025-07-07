# Trích xuất chủ đề

Trích xuất chủ đề nhằm xác định các chủ đề chính trong văn bản. 

{% admonition type="info" %}

Chức năng này còn được gọi là:

* nhận diện chủ đề
* phát hiện nội dung
* nhận biết chủ đề chính

{% /admonition %}

Tisane lưu các chủ đề vào mảng `topics` (dưới dạng chuỗi nếu không có `topic_stats`, hoặc đối tượng nếu có `topic_stats`). Các chủ đề được xác định ở cấp độ tài liệu.

Khi một từ có nhiều nghĩa, Tisane sẽ xác định nghĩa phù hợp dựa trên ngữ cảnh hiện tại. Ví dụ, _Jupiter_ có thể là một hành tinh hoặc một vị thần La Mã. Việc hiểu là hành tinh hay thần phụ thuộc vào ngữ cảnh.

Ví dụ, câu _Juno is the wife of Jupiter_ (Juno là vợ của Jupiter) đề cập đến thần linh. Tisane sẽ xác định các chủ đề liên quan là `Roman mythology` (thần thoại La Mã), `supernatural` (siêu nhiên) (thần), `relationship`, and `family` (quan hệ và gia đình) (vì có đề cập đến mối quan hệ vợ chồng).

```json
{
	"text": "Juno is the wife of Jupiter",
	"topics": [
		"supernatural",
		"Roman mythology",
		"relationship",
		"family"
	]
}
```

Ngược lại, câu _Jupiter is farther from the sun than Mars_ (Jupiter xa mặt trời hơn sao Hỏa) đề cập đến hành tinh. Tisane sẽ xác định các chủ đề là `outer space` (không gian vũ trụ) và `astronomy` (thiên văn học).

```json
{
	"text": "Jupiter is farther from the sun than Mars",
	"topics": [
		"outer space",
		"astronomy"
	]
}
```

## Thống kê chủ đề

Nếu bật thiết lập `topic_stats` thành `true`, thì phần nội dung đầu vào mà chủ đề đó xuất hiện sẽ được cung cấp. Lúc này, chủ đề sẽ không còn được cung cấp dưới dạng chuỗi, mà dưới dạng một đối tượng bao gồm chính tên chủ đề (thuộc tính) `topic` (chuỗi) và thống kê mức độ phân bố của nó (thuộc tính) (`coverage` (kiểu số thực).

**Ví dụ**

Yêu cầu:

```json
{
  "language":"en",
  "content":"Jupiter is farther from the sun than Mars. Which is not important in the current context",
  "settings": 
  {
    "topic_stats": true
  }
}
```

Phản hồi:

```json
{
	"text": "Jupiter is farther from the sun than Mars. Which is not important in the current context",
	"topics": [
		{
			"topic": "outer space",
			"coverage": 0.5
		},
		{
			"topic": "astronomy",
			"coverage": 0.5
		}
	]
}
```
(both detected topics appear in 1 sentence out of 2, which is 0.5 of all sentences)

## Tiêu chuẩn

Có nhiều tiêu chuẩn phân loại chủ đề phổ biến mà Tisane có thể sử dụng khi bạn thiết lập `topic_standard`:

* `native` -  chủ đề theo chuẩn riêng của Tisane, dựa trên thuật ngữ tiếng Anh phổ biến. Tiêu chuẩn mặc định
* `iptc_code` - mã phân loại của [Chủ đề Truyền thông của IPTC (Hội đồng Viễn thông Báo chí Quốc tế)](https://iptc.org/standards/media-topics/) - tiêu chuẩn thường dùng trong truyền thông
* `iptc_description` - mô tả bằng tiếng Anh cho các mã IPTC
* `iab_code` - mã phân loại nội dung của [IAB (Interactive Advertising Bureau)](https://www.iab.com/guidelines/content-taxonomy/).
* `iab_description` - Mô tả bằng tiếng Anh của mã IAB.
* `wikidata` - Mã theo Wikidata (thường có dạng Qxxxx, ví dụ Q123).

Để chọn tiêu chuẩn, thêm thiết lập  `topic_standard`. 

**Ví dụ**

Yêu cầu:

```json
{
  "language":"en",
  "content":"Jupiter is farther from the sun than Mars.",
  "settings": 
  {
    "topic_standard": "wikidata"
  }
}
```

Phản hồi:

```json
{
	"text": "Jupiter is farther from the sun than Mars. Which is not important in the current contex",
	"topics": [
		"Q4169",
		"Q333"
	]
}
```


{% admonition type="warning" %}

Hệ thống phân loại tiêu chuẩn chỉ bao phủ một phần nhỏ so với chuẩn gốc của Tisane. Khi một khái niệm không thuộc bất kỳ hệ phân loại nào, nó sẽ không được đưa vào kết quả phản hồi.

{% /admonition %}