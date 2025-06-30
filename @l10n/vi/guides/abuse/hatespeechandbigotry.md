# Cố chấp và Phát ngôn thù hận

Loại này bao gồm phát ngôn thù hận hoặc thể hiện quan điểm cố chấp; những phát biểu đối đầu nhắm vào [các nhóm được bảo vệ](https://en.wikipedia.org/wiki/Protected_group) (nói cách khác, một nhóm có thể là mục tiêu của việc phân biệt đối xử). Các phát ngôn này không chỉ bao gồm những lời lẽ phân biệt chủng tộc mà còn bao gồm bất kỳ phát biểu thù địch nào nhắm vào toàn thể nhóm. 

Hiện tại, chúng tôi phát hiện các tham chiếu tới:

- Dân tộc hoặc chủng tộc
- Các nhóm tôn giáo và [sắc tộc tôn giáo](https://en.wikipedia.org/wiki/Ethnoreligious_group)
- Những người thiểu số tình dục, ngoại trừ những trường hợp được quy định là bất hợp pháp ở hầu hết các quốc gia (ví dụ: ấu dâm)
- Người nước ngoài/người nhập cư
- Người không theo tôn giáo
- Người khuyết tật
- Đẳng cấp xã hội (ví dụ như ở Ấn Độ)
- Người béo phì
- Bất kỳ giới tính nào

Mọi trường hợp cố chấp được phát hiện đều được ghi lại như một hình thức lạm dụng. Loại được chỉ định là `bigotry` và giống như các loại nội dung có vấn đề khác, nó bao gồm mức độ nghiêm trọng tùy theo bối cảnh.

## Thế nào được coi là cố chấp hoặc phát ngôn thù hận?

Chúng tôi định nghĩa cố chấp là thái độ thù địch, ý kiến ​​tiêu cực hoặc kêu gọi phân biệt đối xử và/hoặc bạo lực nhắm vào toàn bộ một nhóm nhân khẩu học - hoặc các cá nhân - chỉ vì họ có mối liên hệ với nhóm đó.

Mối liên hệ giữa cảm xúc của một người và việc trở thành thành viên của một nhóm cũng sẽ được coi là một trường hợp cố chấp.

### Cố chấp ngầm
Thái độ cố chấp ngầm đối với một trong những nhóm mục tiêu mà không gọi tên (ví dụ: “cút khỏi đất nước của tao”) cũng nằm trong phạm vi nhận dạng, mặc dù khó nhận biết hơn đáng kể.

### Không phải cố chấp

- Các hành vi công kích hướng tới:
  - Nhân vật công chúng
  - Người có nghề nghiệp đặc biệt
  - Những người đã trải qua những trải nghiệm cụ thể, ngay cả khi trải nghiệm đó để lại sang chấn
- Phát ngôn về một thành viên trong nhóm đã thực hiện hành vi sai trái. 

Một vài trong số các hành vi công kích này có thể được đánh dấu là `contentious`. Xem phần: [Nội dung gây tranh cãi](./contentious.md)

## Mức độ nghiêm trọng

Các mức độ nghiêm trọng như sau:

* `low` - quan điểm ​​hoặc sự khái quát hóa mang tính cố chấp có thể không đặc biệt gây khó chịu
* `medium` - một ý kiến ​​hoặc biểu hiện cố chấp, bao gồm hầu hết các lời lăng mạ
* `high` - một lời lăng mạ cực kỳ xúc phạm hoặc phủ nhận các quyền cơ bản hoặc quyền tồn tại của nhóm
* `extreme` - lời kêu gọi bạo lực chống lại nhóm mục tiêu hoặc tích cực cố gắng tiêu diệt nhóm đó

## Thẻ liên quan

Các thẻ sau đây có liên quan đến loại `bigotry`:

* `ableism`
* `ageism`
* `anticatholicism`
* `antisemitism`
* `caste` (phân biệt đối xử dựa trên đẳng cấp xã hội)
* `christianophobia`
* `homophobia`
* `islamophobia`
* `racism`
* `religion`
* `sexism`
* `transphobia`
* `xenophobia`

## Ví dụ

Yêu cầu:

```json
{
  "language":"en",
  "content":"Antarcticans should be kicked out of our country",
  "settings": 
  {
    "snippets":true, "explain":true
  }
}
```

Phản hồi:

```json
{
	"text": "Antarcticans should be kicked out of our country",
	"topics": [
		"Antarctica"
	],
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 48,
			"text": "Antarcticans should be kicked out of our country",
			"type": "bigotry",
			"severity": "high",
			"explanation": "Protected group must be bothered"
		}
	]
}
```