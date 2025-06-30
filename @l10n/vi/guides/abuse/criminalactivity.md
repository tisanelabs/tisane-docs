# Hoạt động tội phạm

Tisane ghi lại các trường hợp hoạt động tội phạm được phát hiện trong phần `abuse`, với thuộc tính `type` được đặt thành `criminal_activity`. 

## Chúng tôi phát hiện những gì

Chúng tôi xác định và đánh dấu văn bản liên quan đến:

- Lập kế hoạch và điều phối vận chuyển, phân phối và sản xuất các mặt hàng bất hợp pháp như ma túy, vũ khí, thuốc nổ và động vật hoang dã bị săn trộm.
- Buôn bán người và mua bán nội tạng người.
- Các yêu cầu và hướng dẫn về việc chế tạo, sản xuất, phân phối hoặc vận hành vũ khí (bao gồm vũ khí hóa học và sinh học), ma túy và chất nổ.
- Các mối đe dọa bạo lực và hoạt động tội phạm.
- Hành vi tìm kiếm các mặt hàng bị hạn chế, ví dụ: Súng, đạn dược, chất nổ). Để phân tích truy vấn tìm kiếm, hãy đặt tham số `format` thành `search`.

{% admonition type="warning" %}

1. Loại hoạt động tội phạm không bao gồm các cuộc trò chuyện về tội phạm do người khác thực hiện hoặc các cáo buộc. Mục đích của loại `criminal_activity` là phát hiện hành vi phạm tội đang diễn ra hoặc sự thừa nhận hành vi phạm tội. Để phát hiện các cuộc trò chuyện về tội phạm, hãy sử dụng trích xuất chủ đề. Xem phần: [Trích xuất chủ đề](../features/topics.md). Để phát hiện những cáo buộc về việc người khác phạm tội, xem phần: [Cáo buộc](./allegation.md)
2. Vì luật pháp khác nhau tùy theo khu vực pháp lý, hãy kiểm tra `tags` để xác định xem có thể bỏ qua trường hợp đó hay không. Ví dụ: `cannabis` hoặc `soft_drug` có thể được sử dụng để bỏ qua các tham chiếu về việc sử dụng cần sa.

{% /admonition %}

### Ví dụ

Yêu cầu:

```json
{
	"language":"en",
	"content":"we sell elephant tusks. Great prices and top notch quality!", 
	"settings": 
  {
	 "snippets":true
  }
}
```

Phản hồi:
```json
{
	"text": "we sell elephant tusks. Great prices and top notch quality!",
	"abuse": [
		{
			"sentence_index": 0,
			"offset": 0,
			"length": 23,
			"text": "we sell elephant tusks.",
			"type": "criminal_activity",
			"severity": "high",
			"tags": [
				"for_sale",
				"wildlife"
			]
		}
	]
}
```

## Thẻ liên quan

Mảng `tags` có thể chứa các thẻ sau.

### Tội phạm

* `bodily_harm`
* `bribery`
* `call_for_violence`
* `crime`
* `death`
* `doxing`
* `escape` (cơ sở cải tạo)
* `extortion`
* `hacking_services`
* `human_trafficking`
* `money_laundering`
* `organized_crime`
* `organ_trade`
* `pedophilia`
* `piracy`
* `scam`
* `tax_evasion`
* `terrorism`
* `threat`
* `violence`
* `wildlife` (săn trộm)

### Chất bị kiểm soát

* `controlled_substance`
* `soft_drug`
* `cannabis`
* `khat`
* `hard_drug`
* `cocaine`
* `ecstasy`
* `hallucinogen`
* `heroin`
* `meth`
* `medication`
* `opioid`

### Các mặt hàng bị hạn chế khác

* `cold_weapons`
* `explosives`
* `firearms`
* `weapon`
* `contraband` (tùy thuộc vào ngữ cảnh)

### Khác

* `admission` - thừa nhận phạm tội
* `credentials`
* `cryptocurrency`
* `debt`
* `payment`

## Các loại Thực thể có liên quan

`item_of_interest` entity type detects items potentially of interest to the investigation: luxury items, drugs, medications, vehicles.

## Sử dụng ngoại tuyến và phục vụ mục đích thực thi pháp luật

Các ứng dụng thực thi pháp luật thường phải hoạt động trong môi trường cô lập. [Tisane Embedded](../../sdks/index.md) có thể đáp ứng nhu cầu này. Tisane Embedded cho phép chạy Tisane như một thư viện đang xử lý. Cũng có thể [Cài đặt tại chỗ](/guides/deployment/onprem). 


