# Lọc nội dung theo danh sách từ khóa bị chặn

Dù đa số người dùng sử dụng Tisane để kiểm duyệt theo ngữ cảnh, một số người dùng lại cần lọc từ khóa vì những lý do khác nhau. 

Có thể dùng Tisane để giám sát danh sách từ khóa, với các tùy chọn giúp tránh những sai sót phổ biến trong việc giám sát danh sách từ.

## Bao gồm phân tách từ trong phản hồi

Theo mặc định, Tisane chỉ xuất ra các phần `abuse`, `sentiment`, và `entities_summary` trong phản hồi. Tuy nhiên, Tisane cũng có thể cung cấp chi tiết về các từ tạo nên mỗi câu.

Để xuất ra các từ, hãy thêm  `"words":true` vào tham số `settings`.

Tất cả các từ được tách (thành từng đơn vị nhỏ); thuật toán tách từ được sử dụng phụ thuộc vào ngôn ngữ. Quá trình này rõ ràng đối với người dùng, dù ngôn ngữ có dùng khoảng trắng hay không, có dùng từ ghép (như tiếng Đức hoặc Hà Lan), hoặc có những từ bao gồm nhiều phần cách nhau bằng khoảng trắng (ví dụ: *kung fu* trong tiếng Anh hoặc *EE. UU.* trong tiếng Tây Ban Nha). 

Kết quả tạo được mảng cấu trúc tên là `words`. Được đặt trong cấu trúc `sentence_list` ở trong phản hồi. 

Mỗi phần tử từ bao gồm:

- Chuỗi thực tế (`text`)
- `offset` vị trí bắt đầu
- Cờ `stopword` để đánh dấu từ dừng
- Một số ID nội bộ của Tisane (xem Tùy chọn 2 bên dưới)
- Các đặc điểm liên quan đến ngữ pháp hoặc văn phong

## Triển khai lọc từ khóa

Có hai cách để triển khai lọc từ khóa với Tisane:

* Tùy chọn 1: Đơn giản (Không khuyến khích)
* Tùy chọn 2: Mạnh hơn

Cả hai cách đều giúp tránh các lỗi dò từ sai, còn gọi là “[clbuttic problem](https://en.wikipedia.org/wiki/Scunthorpe_problem)”.

## Tùy chọn 1: Đơn giản (Không khuyến khích)

Giải pháp đơn giản và dễ hiểu nhất là:

1. Duyệt qua mảng `words`.
2. Đối với mỗi phần tử, hãy kiểm tra xem thuộc tính `text` có chứa một trong những từ bị cấm (hoặc cụm từ, vì việc tách từ là theo logic và *kung fu* hoặc *power plant* cũng được xem là một từ).

### Hạn chế

Phương pháp đơn giản này đi kèm với những bất cập:

- Nếu từ bị biến đổi hình thức thì sao? Một số người sẽ nói “có thể dùng dạng gốc”, nhưng không phải lúc nào cũng dễ dàng quy về dạng gốc. 
- Làm sao để nhận diện từ _bought_ (đã mua) trong tiếng Anh dựa trên từ gốc _buy_ (mua)? Nếu cho rằng _b_ là gốc của từ, thì có nên xem mọi từ bắt đầu bằng _b_ là biến thể của _buy_ (mua)? 
- Những ngôn ngữ giàu hình thái học (tiếng Pháp, Đức, Ả Rập, Nga, Hindi...) có rất nhiều biến thể đa dạng và phức tạp.
- Nếu từ được viết khác đi một chút thì sao, ví dụ *U.S.A.* thay vì *USA* hoặc *email* thay vì *e-mail*?
- Nếu từ bị viết méo mó, theo cách nói trong lĩnh vực bảo mật thông tin — sử dụng các "kỹ thuật thao túng văn bản đối kháng" thì sao?
- Nếu muốn chặn mọi đề cập đến *Alaska* (tiểu bang) nhưng vẫn cho phép *Alaska Air* và *baked Alaska* (món tráng miệng Alaska nướng) thì sao? (Một ví dụ thực tế gần đây: một bài viết về [_Enola Gay_](https://en.wikipedia.org/wiki/Enola_Gay) đã bị gỡ bỏ trong [đợt rà soát của Lầu Năm Góc năm 2025](https://www.newsweek.com/military-remove-enola-gay-photos-dei-rules-2041029) vì hệ thống lọc từ khóa phát hiện từ "gay".)

## Tùy chọn 2: Mạnh hơn

Tùy chọn 2 dựa vào mã định danh nội bộ của Tisane Phương pháp này giúp khắc phục tất cả các hạn chế ở trên bằng cách tận dụng khả năng phân tích hình thái học và thuật toán giải mã văn bản nhiễu.

Hai mã định danh trong mỗi phần tử từ là `lexeme` và `family`. 

### Về ID lexeme

ID lexeme trong Tisane được gán cho một từ và tất cả các biến thể có thể có của từ đó. 

Nếu từ bị viết sai hoặc làm nhiễu (ví dụ: “br*k” thay vì “break”) mà Tisane vẫn nhận diện đúng từ gốc, thì hệ thống sẽ gán ID lexeme của từ gốc.

### Về ID family

ID family là một tùy chọn khác dùng để lọc theo nghĩa của từ. 

Ví dụ: Một thiết bị được gọi là “elevator” (thang máy) ở Mỹ, nhưng ở Anh lại được gọi là “lift” (thang máy).  Đó là cùng một vật thể ngoài đời thực, chỉ khác nhau về cách gọi. Cả hai đều có cùng một ID family. Tuy nhiên, từ “lift” (nâng) theo nghĩa nâng khí động học thì có  ID family khác. 

Một điểm cộng nữa là các ID family đều giống nhau trong các ngôn ngữ. Nghĩa là bạn có thể tạo một “danh sách khái niệm” để nhận diện, bất kể ngôn ngữ hay phương ngữ. 

Người dùng nâng cao thậm chí có thể lọc theo danh mục. Ví dụ: Bất kỳ máy bay, bất kỳ ô tô, bất kỳ loài chim trong khi bỏ qua “clay pigeon” (đĩa bay đất sét dùng trong bắn súng) nhưng vẫn nhận diện “pigeon” (bồ câu), v.v.

### Vì sao chúng tôi khuyến nghị sử dụng ID lexeme

Tuy Tisane nhìn chung được thiết kế theo định hướng nghĩa của từ, nhưng chúng tôi nhận ra rằng không phải lúc nào người dùng cũng dễ phân biệt được các nghĩa khác nhau của một từ. Ngoài ra, việc lọc từ khóa thường cố tình bỏ qua ngữ cảnh. Đó là lý do vì sao chúng tôi khuyến nghị sử dụng ID lexeme.

Với mỗi từ hoặc cụm từ trong danh sách của bạn:

1. Tìm ID lexeme bằng cách chạy một câu mẫu để lấy ID lexeme từ đó, hoặc sử dụng API Language Model Direct Access của chúng tôi.
2. Duyệt qua mảng `words`.
3. Với mỗi từ, hãy so sánh ID lexeme của từ đó với danh sách ID lexeme của bạn.

Ví dụ:

Yêu cầu (tắt `sentiment`, `topics` và `entities` để đơn giản hóa đầu ra):

```json
{
  "language":"en",
  "content":"d/l star t*k for free",
  "settings":
  {
    "snippets":true,
    "words":true,
    "sentiment":false,
    "entities":false,
    "topics":false
  }
}
```

Phản hồi:
```json
{
	"text": "d/l star t*k for free",
	"sentence_list": [
		{
			"offset": 0,
			"text": "d/l star t*k for free",
			"words": [
				{
					"type": "word",
					"offset": 0,
					"text": "d/l",
					"role": "verb",
					"lexeme": 44058,
					"family": 117658,
					"grammar": [
						"VERB"
					]
				},
				{
					"type": "word",
					"offset": 4,
					"text": "star t*k",
					"role": "patient",
					"lexeme": 317071,
					"family": 152100,
					"wikidata": "Q1092",
					"grammar": [
						"PROPN"
					]
				},
				{
					"type": "word",
					"offset": 13,
					"text": "for free",
					"lexeme": 62119,
					"family": 93462,
					"grammar": [
						"ADV"
					]
				}
			],
			"corrected_text": "d/l star trek for free"
		}
	]
}
```

Trong phản hồi: 

1. Từ bị làm nhiễu _Star Trek_ được:

 * phân tách như một đơn vị
 * ID lexeme được gán là 317071
 * ID family được gán là 152100

2. Thuộc tính *corrected_text* chứa phiên bản đã được khôi phục của câu: _d/l star trek for free_ (star trek miễn phí).