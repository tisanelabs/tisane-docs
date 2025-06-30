# Hành vi thiết lập liên lạc bên ngoài

Các hành vi thiết lập liên lạc bên ngoài bao gồm:

* trao đổi thông tin liên lạc như email, số điện thoại, tên người dùng, thông tin phương thức thanh toán như địa chỉ ví tiền mã hóa hoặc số tài khoản IBAN
* yêu cầu cung cấp thông tin liên lạc (ví dụ: “WhatsApp của bạn là gì?”)
* sắp xếp cuộc gặp hoặc khuyến khích giao tiếp bên ngoài nền tảng (ví dụ: _“Mình ra ngoài trang web này nói chuyện riêng đi”_)

Các hành vi thiết lập liên lạc bên ngoài khi bị phát hiện sẽ được ghi nhận trong mục `abuse`, với thuộc tính `type` được đặt là `external_contact`.

## Tình huống sử dụng

Dưới đây là một số tình huống cần phát hiện hành vi thiết lập liên lạc bên ngoài:

* kẻ lừa đảo trên nền tảng cố gắng dụ người dùng rời khỏi hệ thống
* kẻ quấy rối tình dục
* người dùng tuy hợp lệ nhưng cố tình vi phạm điều khoản sử dụng của nền tảng Ví dụ: người bán rủ người mua giao dịch riêng để có giá tốt hơn mà không phải trả hoa hồng
* quảng cáo trá hình trong phần đánh giá
* gái mại dâm quảng bá dịch vụ của họ trên hồ sơ cá nhân trong các ứng dụng hẹn hò và cộng đồng trực tuyến khác
* quảng cáo trong tên người dùng, chẳng hạn như chèn đường dẫn URL, hoặc gợi ý người dùng tìm thông tin liên lạc trong hồ sơ cá nhân,…
* truy vết và kết nối những người liên quan trong quá trình điều tra

{% admonition type="info" %}

Để quét mạnh hơn và phát hiện đường dẫn URL trong tên người dùng và phần đánh giá, hãy đặt `format` là `review` hoặc `alias`.

{% /admonition %}

## Thẻ liên quan

  * `payment` - mọi nội dung liên quan đến thanh toán
  * `pii` - thông tin nhận dạng cá nhân (PII)
  * `sex_work` - quảng bá dịch vụ tình dục

## Ví dụ

Yêu cầu:

```json
{
  "language": "en",
  "content": "your wickr ?",
  "settings": {
    "snippets":true, "explain":true
  }
}
```

Phản hồi:

```json
{
  "text": "your wickr ?",
  "topics": [
    "online chat"
  ],
  "abuse": [
    {
      "sentence_index": 0,
      "offset": 0,
      "length": 10,
      "text": "your wickr",
      "type": "external_contact",
      "severity": "low",
      "explanation": "Inquiry about messenger [ID]"
    }
  ],
  "entities_summary": [
    {
      "type": "software",
      "name": "wickr",
      "wikidata": "Q16334358",
      "mentions": [
        {
          "sentence_index": 0,
          "offset": 5,
          "length": 5,
          "text": "wickr"
        }
      ],
      "subtypes": [
        "chat"
      ],
      "subtype": "chat"
    }
  ]
}
```