# Các chức năng được hỗ trợ

Tisane là một nền tảng Hiểu ngôn ngữ tự nhiên (NLU) mạnh mẽ, được thiết kế từ đầu để xử lý văn bản trên mạng xã hội hoặc nội dung do người dùng tạo ra — thường không chuẩn ngữ pháp, có thể bị ngụy trang (ví dụ như algospeak) và chứa nhiều tiếng lóng hoặc lỗi. Các ứng dụng chính của Tisane là kiểm duyệt nội dung và phục vụ cho thực thi pháp luật / an ninh quốc gia / tình báo.

Tất cả tính năng đều khả dụng cho mọi ngôn ngữ được hỗ trợ. Mọi kết quả được trả về chỉ trong một lần gọi API.

## Chức năng cốt lõi

Tisane cung cấp các khả năng tiên tiến về phát hiện hành vi lạm dụng, phân tích cảm xúc và nhận dạng thực thể:

- Phát hiện nội dung có vấn đề phục vụ cho kiểm duyệt nội dung hoặc điều tra:
  - Công kích cá nhân, lăng mạ, bắt nạt trên mạng
  - Ngôn từ thù ghét
  - Từ ngữ tục tĩu
  - Gạ gẫm tình dục
  - Nội dung chỉ dành cho người lớn
  - Hành vi phạm pháp (mua bán các mặt hàng bị cấm như ma túy, vũ khí, v.v.)
  - Đe dọa
  - Cáo buộc (dù có phải phỉ báng hay không)
  - Ý định tự sát
  - Mời gọi liên lạc ngoài nền tảng hiện tại
  - Miêu tả bạo lực rùng rợn
  - Ép buộc phân cấp thứ bậc (ví dụ: bắt nạt nơi làm việc)
  - Rò rỉ dữ liệu (ví dụ: rò rỉ thông tin cá nhân, lộ thông tin đăng nhập)
  - Spam
  
- Phát hiện thực thể được đặt tên và xác định mối quan hệ giữa các thực thể, bao gồm:
  - người
  - tổ chức
  - vai trò xã hội (chức danh, nghề nghiệp, v.v.)
  - địa điểm
  - số điện thoại
  - số thẻ tín dụng
  - ngày tháng
  - số tiền
  - Mặt hàng liên quan đến điều tra (ma túy, vũ khí, phương tiện)
  - địa chỉ tiền mã hóa
  - và hơn nữa
- Phát hiện chủ đề (chủ đề / lĩnh vực / nội dung chính)
- Phân tích cảm xúc (tích cực, tiêu cực hoặc hỗn hợp), bao gồm
  - đánh giá cảm xúc hướng tới từng thực thể hoặc đặc điểm cụ thể trong văn bản. (Phân tích cảm xúc theo khía cạnh

## Phân tích ngôn ngữ sau

Tisane còn cung cấp truy cập vào các thành phần cơ bản của ngôn ngữ:

- tách câu thông minh
  - Cung cấp cả câu gốc và câu đã được sửa (nếu có). 
  - Sử dụng các dấu ngắt hợp lý để tránh tách câu sai (ví dụ: `EE. UU.` hoặc `www.google.com`)
- Phân tách từ vựng theo ngữ đoạn
  - Tách câu theo hình vị
  - Hỗ trợ tất cả các kiểu phân đoạn:
    - ngôn ngữ dùng khoảng trắng
    - Ngôn ngữ không dùng khoảng trắng (ví dụ: tiếng Trung, Nhật, Thái)
    - ngôn ngữ dùng từ ghép (tiếng Đức, Hà Lan, Nam Phi)
    - từ phụ thuộc
    - cụm từ cố định
    - thực thể không nằm trong từ điển (email, số điện thoại, v.v.)
- Cây phân tích cú pháp và cụm từ
  - Cung cấp cấu trúc phân cấp của câu, hiển thị các cụm từ và mối quan hệ giữa chúng
  - Trích xuất cụm danh từ, động từ, giới từ, tính từ và trạng từ.
- Từ vựng
  - Cung cấp thông tin chi tiết về từng từ (hoặc đơn vị từ vựng), bao gồm dạng gốc (lemma), vai trò trong câu và các đặc điểm ngữ pháp
- Phân biệt nghĩa theo ngữ cảnh
  - Xác định nghĩa của từng từ trong ngữ cảnh hiện tại.