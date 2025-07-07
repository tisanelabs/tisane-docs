# Ngôn ngữ lách thuật toán và thao túng văn bản đối kháng

Tisane sử dụng mô-đun kiểm tra chính tả tích hợp đặc biệt để xử lý văn bản chứa cả lỗi không cố ý (sai chính tả) và thao túng văn bản đối kháng (ví dụ: ngôn ngữ né tránh thuật toán). 

Bộ kiểm tra chính tả này sử dụng nhiều kỹ thuật khác nhau để xử lý các kiểu thao túng khác nhau (như thay thế ký tự, ẩn ký tự, v.v.). Việc sửa lỗi không giới hạn ở các từ tục tĩu hay xúc phạm, mà còn xem xét đến ngữ cảnh. Cùng một từ viết sai có thể được hiểu khác nhau theo các câu khác nhau.

Nếu phát hiện cần sửa lỗi trong một câu, thuộc tính `corrected_text` sẽ được gán cho câu đó và ghi lại văn bản đã được sửa. (Đặt `words` thành `true`  để xuất dữ liệu theo từng câu.)

## Hạn chế

Kiểm tra chính tả không phải là [công cụ kiểu “ý bạn là...”](https://stackoverflow.com/questions/307291/how-does-the-google-did-you-mean-algorithm-work) như nhiều người vẫn tưởng:

- Nếu từ là một từ hợp lệ, dù dùng sai ngữ cảnh hoặc mang tính học thuật, Tisane sẽ không sửa. Ví dụ: nếu *noun* bị viết sai thành *nun*, hoặc *house* bị viết sai thành *horse*, Tisane sẽ không phát hiện (trừ khi nó nằm trong cụm từ thường bị ngụy trang như _corn star_ trong tiếng Anh).
- Mục đích chính của bộ kiểm tra chính tả là giải mã từ ngữ ngụy trang. Do đó, nó thiên về phát hiện các khái niệm tục tĩu, gây phản cảm hoặc bị sử dụng sai phổ biến.

## Loại trừ các nghĩa và từ ngữ hiếm để có kết quả tốt hơn

Để tránh vấn đề này, bạn có thể sử dụng tham số `min_generic_frequency`. 

Điều này giúp loại trừ những nghĩa và từ ngữ hiếm gặp nhất. 

Tần suất được đánh giá từ 0 đến 10, với 10 là phổ biến nhất. 

Một số nghĩa cực kỳ hiếm được đánh giá ở mức -10. 

Ban đầu, bạn nên đặt `min_generic_frequency` ở mức `1` hoặc`2` để kiểm tra hiệu quả trong tình huống của bạn.

## Loại trừ danh từ riêng tiềm năng

Nếu bạn muốn tránh việc kiểm tra chính tả đối với các danh từ riêng có thể có, hãy đặt `lowercase_spellcheck_only` thành `true`.

## Ví dụ

Yêu cầu:
```json
{
  "language":"en",
  "content":"I will br*k his neck and kll him",
  "settings": 
  {
    "words":true,"topics":false,"sentiment":false,"snippets":true
  }
}
```

Phản hồi:
```json

	"text": "I will br*k his neck and kll him",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 32,
			"text": "I will br*k his neck and kll him",
			"type": "criminal_activity",
			"severity": "medium",
			"tags": [
				"threat",
				"violence",
				"death"
			]
		}
	],
	"sentence_list": [
		{
			"offset": 0,
			"text": "I will br*k his neck and kll him",
			"words": [
				{
					"type": "word",
					"offset": 0,
					"text": "I",
					"lettercase": "capitalized",
					"role": "agent",
					"lexeme": 63061,
					"family": 301,
					"grammar": [
						"PRON"
					],
					"stopword": true
				},
				{
					"type": "word",
					"offset": 2,
					"text": "will",
					"lexeme": 146938,
					"family": 316,
					"grammar": [
						"VERB"
					],
					"stopword": true
				},
				{
					"type": "word",
					"offset": 7,
					"text": "br*k",
					"role": "verb",
					"lexeme": 20996,
					"family": 107846,
					"grammar": [
						"VERB"
					]
				},
				{
					"type": "word",
					"offset": 12,
					"text": "his",
					"lexeme": 63064,
					"family": 303,
					"grammar": [
						"DET"
					],
					"stopword": true
				},
				{
					"type": "word",
					"offset": 16,
					"text": "neck",
					"lexeme": 93293,
					"family": 40510,
					"wikidata": "Q9633",
					"grammar": [
						"NOUN"
					]
				},
				{
					"type": "word",
					"offset": 21,
					"text": "and",
					"lexeme": 4096,
					"family": 322,
					"grammar": [
						"CCONJ"
					],
					"stopword": true
				},
				{
					"type": "word",
					"offset": 25,
					"text": "kll",
					"role": "verb",
					"lexeme": 77380,
					"family": 113102,
					"grammar": [
						"VERB"
					]
				},
				{
					"type": "word",
					"offset": 29,
					"text": "him",
					"role": "patient",
					"lexeme": 63062,
					"family": 303,
					"grammar": [
						"PRON"
					],
					"stopword": true
				}
			],
			"corrected_text": "I will break his neck and kill him"
		}
	]
}
```