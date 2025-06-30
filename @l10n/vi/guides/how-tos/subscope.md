# Tách từ trong đường dẫn URL và hashtag

Tisane có thể phân tích các đường dẫn và hashtag bằng cách xử lý chúng như các câu, tách thành từng từ và trích xuất chủ đề cũng như thực thể giống như với văn bản thông thường.

Đặt `subscope` thành `true` để buộc hệ thống tách các phạm vi con.

## Ví dụ:

Yêu cầu:

```json
{
  "language": "en",
  "content": "https://www.tastingtable.com/946284/unconventional-uses-for-vodka-other-than-drinking/ ",
  "settings": {
    "subscope": true
  }
}
```

Phản hồi:

```json
{
	"text": "https://www.tastingtable.com/946284/unconventional-uses-for-vodka-other-than-drinking/ ",
	"topics": [
		"beverage",
		"alcoholic beverage",
		"hard liquor"
	],
	"entities_summary": [
		{
			"type": "item_of_interest",
			"name": "vodka",
			"wikidata": "Q374",
			"mentions": [
				{
					"sentence_index": 0,
					"offset": 60,
					"length": 5
				}
			],
			"subtypes": [
				"controlled_substance"
			],
			"subtype": "controlled_substance"
		}
	]
}
```