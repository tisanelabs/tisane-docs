# Nội dung chỉ dành cho người lớn

Nội dung chỉ dành cho người lớn là những nội dung thường bị giới hạn trong các cộng đồng dành cho trẻ em, nhưng có thể chấp nhận được trong các cộng đồng người lớn. Các trường hợp phát hiện nội dung chỉ dành cho người lớn sẽ được ghi nhận trong phần `abuse` với thuộc tính `type` được đặt là `adult_only`. 

Bao gồm:

* tài liệu khiêu dâm hoặc các đề cập đến chủ đề liên quan đến tình dục. Thẻ liên quan: `sex`
* các đề cập đến việc sử dụng ma túy và rượu bia. Thẻ liên quan: `controlled_substance`. Các thẻ liên quan đến loại ma túy được đề cập cũng sẽ được sử dụng. Đọc thêm: [Hoạt động tội phạm](./criminalactivity.md).

## Ví dụ

Yêu cầu:
```json
{
  "language":"en",
  "content":"we drank so much beer last week",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```

Phản hồi:
```json
{
	"text": "we drank so much beer last week",
	"topics": [
		"alcoholic beverage",
		"beverage"
	],
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 31,
			"text": "we drank so much beer last week",
			"type": "adult_only",
			"severity": "medium",
			"explanation": "Statement indicating collective consumption of alcoholic beverages",
			"tags": [
				"controlled_substance"
			]
		}
	]
}
```