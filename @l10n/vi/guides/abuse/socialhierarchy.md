# Khẳng định về thứ bậc

Các trường hợp khẳng định thứ bậc một cách cưỡng ép trong cộng đồng sẽ được ghi nhận trong mục `abuse`, với loại `type` thuộc tính được đặt là `social_hierarchy`.

Các trường hợp này bao gồm:

* hành vi kiểm soát thái quá
* bắt nạt nơi làm việc (ví dụ: hiện tượng [quấy rối quyền lực](https://en.wikipedia.org/wiki/Power_harassment) tại Nhật Bản và Hàn Quốc)
* ép buộc một nhóm người cụ thể phải “biết thân phận” của mình (chẳng hạn như các thành viên mới trong cộng đồng)


## Ví dụ

Yêu cầu:

```json
{
  "language":"en",
  "content":"newbies should know their place",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```

Phản hồi:

```json
{
	"text": "newbies should know their place",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 31,
			"text": "newbies should know their place",
			"type": "social_hierarchy",
			"severity": "medium",
			"explanation": "Assertion on what newcomers should do"
		}
	]
}
```