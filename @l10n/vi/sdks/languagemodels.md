# Kho dữ liệu mô hình ngôn ngữ

Các mô hình ngôn ngữ của Tisane được lưu trữ trong các thư mục. Chúng có thể được chia thành:

1. **Dữ liệu đặc thù theo ngôn ngữ** - mô tả một ngôn ngữ cụ thể
2. **Dữ liệu liên ngôn ngữ** được dùng chung cho tất cả các ngôn ngữ (ví dụ: kết nối ngữ nghĩa giữa các khái niệm)

### Dữ liệu đặc thù theo ngôn ngữ


Các kho dữ liệu đặc thù theo ngôn ngữ được đặt tên theo quy ước sau: `(language_code)-(data_store_name)`

*   Mã ngôn ngữ: Dựa trên tiêu chuẩn mã ngôn ngữ <a href="https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes" target="_blank">ISO-639-1</a>, có thể bao gồm cả phương ngữ.
*   Tên kho dữ liệu: Cấu trúc lưu trữ.

Ví dụ:

*   `en-phrase`: mẫu cụm từ tiếng Anh
*   `fr-nondic`: các quy tắc thực thể không có trong từ điển cho tiếng Pháp
*   `zh_CN-phrase`: Mẫu cụm từ tiếng Trung giản thể

### Kho dữ liệu liên ngôn ngữ

Các kho dữ liệu sau được sử dụng cho *tất cả* các ngôn ngữ:

*   `family`
*   `role`
*   `pragma`

**Important:** Lưu ý quan trọng: Tất cả các kho dữ liệu cho một ngôn ngữ phải nằm trong *cùng một* thư mục.

### Phân phối một phần

Để tiết kiệm dung lượng hoặc vì lý do khác, bạn có thể loại trừ một số ngôn ngữ hoặc thành phần khi triển khai.

## Chỉ cung cấp một số ngôn ngữ được chọn

Để chỉ bao gồm một số ngôn ngữ nhất định, hãy xác định mã ngôn ngữ tương ứng (ví dụ: `en`, `de`, `zh_CN`) và thêm vào các kho dữ liệu đặc thù cho các ngôn ngữ đó, cùng với ba kho dữ liệu dùng chung (`family`, `role`, `pragma`).

## Cung cấp chức năng một phần

Các kho dữ liệu `xx-famlex` and `xx-famphrase` chỉ được dùng cho chức năng dịch, nên có thể loại bỏ khỏi gói cài đặt nếu bạn không sử dụng Tisane để dịch thuật.

## kiểm tra chính tả

Dữ liệu kiểm tra chính tả được lưu trong các kho dữ liệu có tên `xx-spell`. Nếu không được bao gồm, chức năng kiểm tra chính tả sẽ không hoạt động.