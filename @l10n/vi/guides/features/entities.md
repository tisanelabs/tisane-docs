# Trích xuất thực thể

Thực thể là các yếu tố có liên quan hoặc đáng chú ý trong văn bản. Tisane trích xuất cả các thực thể tiêu chuẩn và các thực thể phục vụ cho các ứng dụng về an toàn – tin cậy và thực thi pháp luật.

Các thực thể tiêu chuẩn bao gồm tên người, vai trò xã hội, tổ chức, địa điểm, v.v. Chúng tôi cũng trích xuất các địa chỉ tiền mã hóa, số tài khoản ngân hàng, số thẻ tín dụng, số điện thoại, tên gói phần mềm và nhiều hơn nữa.

Các thực thể được ghi lại trong phần `entities_summary`. Mỗi thực thể là một đối tượng bao gồm các thành phần:
  * `type` - loại thực thể
  * `name` - tên chuẩn nếu có; nếu không có thì là chuỗi đã được phát hiện
  * `subtypes` - các loại phụ chi tiết hơn
  * `subtype` - loại phụ đầu tiên (để đảm bảo tương thích ngược)
  * `mentions` - mảng chứa tất cả các lần đề cập đến thực thể, với:
    * `offset`
    * `length`
    * `sentence_index`
    * `text`
  * `wikidata` - mã định danh trên Wikidata, nếu có  

Xem danh sách đầy đủ các thực thể được phát hiện: [Response Reference](/apis/tisane-api-response-guide#named-entities)

## Loại phụ

Thông tin chi tiết bổ sung được cung cấp trong mảng `subtypes` (loại phụ đầu tiên cũng được ghi lại riêng dưới thuộc tính `subtype`).

Các loại phụ cụ thể sẽ được liên kết với từng loại thực thể tương ứng.

- `person`
  - `fictional_character` -  tên của một nhân vật trong tác phẩm hư cấu
  - `important_person` -  tên của một nhân vật lịch sử, người nổi tiếng hoặc nhân vật của công chúng
  - `spiritual_being` -  tên của một vị thần, thiên thần hoặc ác hồn
- `organization`
  - `media` - cơ quan truyền thông hoặc ấn phẩm định kỳ
  - `authorities` - ơ quan chính phủ
  - `law_enforcement_agency` - cơ quan thực thi pháp luật
  - `intelligence_agency` - cơ quan tình báo
  - `military` - đơn vị quân đội
- `software`
  - `chat` -  bất kỳ phần mềm nào thường dùng để nhắn tin tức thì
  - `online_community` - cộng đồng trực tuyến, chẳng hạn như mạng xã hội
  - `low_trust_payment_method` - phương thức thanh toán thường bị xem là dễ bị lạm dụng
- `age`
  - `minor_age` - người chưa đủ tuổi hợp pháp
- `crypto`
  - `bitcoin`
  - `ethereum`
  - `dogecoin`
  - `erc20-wallet`
  - `monero`
  - `tether`
  - `dash`
  - `litecoin`
- `ip_address`
  - `v4` - địa chỉ IP phiên bản 4
  - `v6` - địa chỉ IP phiên bản 6
- `file`
  - `windows` - tên đường dẫn Windows
  - `unix` - tên đường dẫn Unix
- `credit_card`
  - `american_express`
  - `visa`
  - `mastercard`
  - `maestro`
  - `jcb`
  - `discovery`
  - `diners_club`
  - `zcash`
- `credential`
  - `password`
- `website`
  - `high_risk` - nguy cơ cao gặp phải phần mềm độc hại hoặc lừa đảo
- `item_of_interest`
  - `cold_weapons`
  - `luxury` - bất kỳ món đồ xa xỉ nào, ví dụ như đồng hồ đắt tiền, du thuyền, xe hơi hạng sang
  - `firearms`
  - `weapon`
