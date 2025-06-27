# Thẻ

Bên cạnh các loại lạm dụng, thông tin chi tiết về ngữ cảnh được cung cấp qua một mảng chuỗi `tags`. Những thẻ này có thể là một phân loại phụ của đối tượng bị nhắm tới, hoặc là loại vật phẩm bất hợp pháp đang được đề cập,…

Giá trị của các thẻ thường tương quan với loại nội dung có vấn đề được phát hiện, nhưng không phải lúc nào cũng vậy. Các thẻ được thu thập bằng cách phân tích mệnh đề chính phù hợp, rồi trích xuất các giá trị `abuse/tags` liên quan đến các từ (hoặc cụm từ) liên quan. Ví dụ, trong câu sau: "kill all immigrants" (giết hết người nhập cư), có hai loại `abuse`được phát hiện: `criminal_activity` (hành động tội phạm) và `bigotry` (định kiến thù ghét). Cả hai đều có các thẻ sau: `call_for_violence` (kêu gọi bạo lực), `death` (chết chóc), và `xenophobia` (bài ngoại).

```json
{
	"text": "kill all immigrants",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 19,
			"text": "kill all immigrants",
			"type": "criminal_activity",
			"severity": "extreme",
			"explanation": "Calls to kill a person or people",
			"tags": [
				"call_for_violence",
				"death",
				"xenophobia"
			]
		},
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 19,
			"text": "kill all immigrants",
			"type": "bigotry",
			"severity": "extreme",
			"explanation": "Calls or advocacy to commit murders of a protected class",
			"tags": [
				"call_for_violence",
				"death",
				"xenophobia"
			]
		}
	]
}
```

Điều này cũng có nghĩa là, ngay cả khi một số loại lạm dụng được chủ động bỏ qua, nhưng các thẻ vẫn có thể được sử dụng.

Các phần mô tả từng loại lạm dụng sẽ liệt kê những thẻ liên quan nhất. 

## Danh sách đầy đủ các thẻ

Xem danh sách đầy đủ các thẻ bên dưới

* `ableism` (phân biệt đối xử với người khuyết tật)
* `admission` (lời thừa nhận)
* `ageism` (phân biệt tuổi tác)
* `anticatholicism` (bài Công giáo)
* `antisemitism` (bài Do thái)
* `appearance` (ngoại hình)
* `bodily_harm` (làm hại cơ thể)
* `bribery` (hối lộ)
* `call_for_violence` (kêu gọi bạo lực)
* `cannabis` (cần sa)
* `cannibalism` (ăn thịt người)
* `caste` (phân biệt giai cấp)
* `christianophobia` (bài Kitô giáo)
* `clickbait` (mồi nhử)
* `cocaine` (ma túy)
* `cold_weapons` (vũ khí lạnh)
* `conspiracy_theory` (thuyết âm mưu)
* `contraband` (hàng lậu)
* `controlled_substance ` (chất bị kiểm soát)
* `credentials` (thông tin xác thực)
* `crime` (tội phạm)
* `cryptocurrency` (tiền mã hóa)
* `data` (dữ liệu)
* `death` (chết)
* `debt` (nợ nần)
* `doxing` (công khai thông tin cá nhân)
* `ecstasy` (thuốc lắc)
* `endearment` (sự thân mật)
* `escape` (trốn thoát)
* `explosives` (chất nô)
* `extortion` (tống tiền)
* `fake` (giả mạo)
* `firearms` (súng ống)
* `for_sale` (rao bán)
* `hacking_services` (dịch vụ hack)
* `hallucination` (ảo giác)
* `hallucinogen` (chất gây ảo giác)
* `hard_drug` (ma túy nặng)
* `heroin` (ma túy heroin)
* `homophobia` (kỳ thị người đồng tính)
* `human_trafficking` (buôn người)
* `indigenous_sensitive` (nhạy cảm với người bản địa)
* `instructions` (hướng dẫn)
* `investment` (đầu tư)
* `islamophobia` (bài Hồi giáo)
* `khat` (lá khát)
* `link` (liên kết)
* `luxury` (xa xỉ)
* `medication` (thuốc)
* `meth` (ma túy đá)
* `money_laundering` (rửa tiền)
* `not personal` (không cá nhân)
* `opioid` (thuốc phiện)
* `organ_trade` (buôn bán nội tạng)
* `organized_crime` (tội phạm có tổ chức)
* `package` (gói hàng)
* `payment` (thanh toán)
* `pedophilia` (ấu dâm)
* `pii` (thông tin định danh cá nhân)
* `piracy` (vi phạm bản quyền)
* `planning` (lên kế hoạch)
* `privacy` (quyền riêng tư)
* `promo` (khuyến mãi )
* `racism` (phân biệt chủng tộc)
* `relationship_status` (tình trạng quan hệ)
* `religion` (tôn giáo)
* `scam` (lừa đảo)
* `sex` (tình dụng)
* `sex_work` (mại dâm)
* `sexism` (phân biệt giới tính)
* `soft_drug` (ma túy nhẹ)
* `sold_by_spammers` (do spammer bán)
* `tax_evasion` (trốn thuế)
* `terrorism` (khủng bố)
* `threat` (đe dọa)
* `tisane`
* `tobacco` (thuốc lá)
* `transphobia` (kỳ thị người chuyển giới)
* `url` (địa chỉ liên kết)
* `user-generated content` ( nội dung do người dùng tạo)
* `vehicle` (phương tiện)
* `violation` (vi phạm)
* `violence` (bạo lực)
* `weapon` (vũ khí)
* `weapons_of_mass_destruction` (vũ khí hủy diệt hàng loạt)
* `wildlife` (động vật hoang dã)
* `workplace_bullying` (bắt nạt nơi làm việc)
* `xenophobia` (bài ngoại)



