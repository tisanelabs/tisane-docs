# Khắc phục sự cố
Nếu yêu cầu gửi tới API Tisane  của bạn không thành công, hãy kiểm tra mã lỗi và các bước khắc phục sự cố bên dưới.

## Gọi API không thành công với mã lỗi 400 (Yêu cầu không hợp lệ)

Thông thường lỗi này có nghĩa là nội dung yêu cầu không đúng định dạng hoặc không hợp lệ. Trong `/parse` và `/transform`, nội dung đầu vào và mã ngôn ngữ hợp lệ phải được chỉ định.

Các lý do có khả năng:

- JSON không hợp lệ. Kiểm tra các chuỗi ký tự chưa kết thúc hoặc dấu ngoặc kép chưa thoát trong chuỗi của bạn.
- Mã ngôn ngữ không hợp lệ. Xác minh rằng mô hình ngôn ngữ tồn tại và tên thuộc tính là chính xác (`ngôn ngữ` trong `/parse`, `from` và `to` trong `/transform`).
- Thiếu phần tử `nội dung`.

## Gọi API không thành công với mã lỗi 401 (Không được cấp quyền)

Lỗi này có nghĩa là yêu cầu của bạn không được cấp quyền. Các lý do có khả năng:

- Khóa API không chính xác
  - Đảm bảo bạn cung cấp giá trị khóa API chính xác cho tiêu đề HTTP `Ocp-Apim-Subscription-Key`.

- Vượt quá giới hạn tần suất
  - Mỗi gói đăng ký đều có giới hạn tần suất. Giới hạn tần suất của Gói Cộng đồng miễn phí chỉ được đặt ở mức 10 yêu cầu mỗi phút (đủ để thử nghiệm, không đủ để đưa vào sản xuất cho hầu hết các mục đích). Kiểm tra giới hạn trên [trang Các gói đăng ký](https://tisane.ai/subscription-plans/).

- Vượt quá hạn ngạch hàng tháng
  - Nếu bạn đã đạt đến mức tối đa hàng tháng, hãy cân nhắc nâng cấp trên [trang Các gói đăng ký](https://tisane.ai/subscription-plans/). Nhiều thông báo sẽ được gửi khi đạt đến mức tối đa hàng tháng.

## Gọi API không thành công với mã lỗi 404

Kiểm tra xem tên phương thức và động từ có chính xác hay không. Ví dụ: chỉ định `GET` khi thao tác sử dụng `POST` sẽ dẫn đến mã trạng thái 404.

##  Các mã lỗi khác (JSON không hợp lệ hoặc sự cố đánh dấu)

Nếu bạn gặp lỗi khác ngoài lỗi 401, hãy kiểm tra định dạng JSON không hợp lệ:

- Thoát khỏi dấu ngoặc kép đúng cách
  - Nếu nội dung của bạn chứa dấu ngoặc kép (`"`), hãy đảm bảo chúng được thoát đúng cách (`\"`).

- Tránh gửi nội dung đánh dấu
  - API Tisane xử lý ngôn ngữ tự nhiên, do đó việc gửi HTML, XML hoặc JSON dưới dạng nội dung có thể gây ra sự cố.
  - Nếu bạn phải gửi nội dung đánh dấu, hãy làm sạch dữ liệu đầu vào của bạn trước khi gửi.

##  Tìm khóa API của bạn

**tl;dr**: Đăng nhập vào cổng thông tin dành cho nhà phát triển của chúng tôi và lấy khóa API từ trang hồ sơ của bạn.

### Hướng dẫn từng bước

1. Đăng nhập bằng thông tin đăng nhập của bạn [tại đây](https://dev.tisane.ai/signin/).
2. Nếu bạn chưa có tài khoản, hãy đăng ký [tại đây](https://dev.tisane.ai/signup/).
3. Nhấp vào menu ở góc trên bên phải và vào phần *Hồ sơ*, hoặc sử dụng [liên kết trực tiếp này](https://dev.tisane.ai/profile).
4. Trong phần *Khóa chính* hoặc *Khóa phụ*, nhấp vào *Hiển thị* để hiển thị khóa API của bạn.
5. Trong ứng dụng của bạn, hãy cung cấp khóa này dưới dạng tiêu đề HTTP `Ocp-Apim-Subscription-Key`.

##  Các bước khắc phục sự cố tổng quát

- Kiểm tra khóa API của bạn 
- Kiểm tra giới hạn gói đăng ký của bạn
- Xác thực định dạng JSON trước khi gửi
- Làm sạch dữ liệu đầu vào để xóa tất cả thẻ đánh dấu

## Chúng tôi không nhận được phản hồi như chúng tôi mong đợi

Mặc dù chúng tôi không thể đảm bảo độ chính xác 100%, vui lòng [gửi ghi chú cho chúng tôi](https://tisane.ai/contact-us/#support) và chúng tôi sẽ xem xét. Chúng tôi không ngừng nỗ lực cải thiện độ chính xác của Tisane và rất trân trọng sự hợp tác của bạn.

## Tôi có thể xử lý văn bản từ nội dung đánh dấu (HTML hoặc XML) không?

Sau đây là biểu thức chính quy chung có thể được sử dụng trong bất kỳ ngôn ngữ lập trình nào để xóa thẻ HTML khỏi văn bản:

`<[^>]+>`

- `<` → Phù hợp với **dấu ngoặc nhọn mở** của thẻ HTML.
- `[^>]+` → Phù hợp với **mọi ký tự bên trong thẻ**, ngoại trừ `>`.
- `>` → Phù hợp với **dấu ngoặc nhọn đóng** của thẻ HTML.
