# Xem xét các tin nhắn đã được xử lý trước đó

Theo mặc định, các lệnh gọi Tisane không có trạng thái. Nghĩa là Tisane chỉ nhận thức được văn bản mà nó nhận được trong yêu cầu hiện tại. (Tuy nhiên, trong văn bản, ngữ cảnh được theo dõi giữa các câu để phục vụ mục đích giải quyết tham chiếu chung). Đây là một lựa chọn có chủ đích để đảm bảo sự đơn giản của việc triển khai và tránh các vấn đề pháp lý liên quan đến việc lưu giữ dữ liệu. Lệnh gọi API = phiên.

Nhưng sẽ thế nào nếu chúng ta cần tham chiếu đến các tin nhắn trước đó? Trong bối cảnh nội dung có vấn đề, có một số tình huống liên quan, đáng chú ý nhất là dụ dỗ và gian lận trực tuyến, trong đó bức tranh toàn cảnh chỉ xuất hiện khi một số phát ngôn được liên hệ với nhau.

Hãy xem xét phát ngôn sau đây: “Bố mẹ bạn hiện giờ đang ở đâu vậy?” Nếu chỉ xét riêng câu hỏi này, chúng ta không có đủ bối cảnh để coi nó là có vấn đề. Nó có thể là bất cứ điều gì: hai đứa trẻ nói chuyện về cha mẹ chúng hoặc một người thợ sửa chữa đang cố gắng tìm gặp chủ nhà. Tiếp theo hãy xem xét một phát ngôn khác: "Bạn bật camera lên được không?" Một lần nữa, phát ngôn này không nhất thiết là ngầm thể hiện ý đồ xấu. Nó có thể đến từ cuộc trò chuyện giữa các đồng nghiệp tại nơi làm việc.

Tuy nhiên, khi yêu cầu bật camera tiếp nối câu hỏi về vị trí của phụ huynh, nó trở nên đáng sợ như những thứ chất nổ tự chế từ các nguyên liệu vô hại mà ta hay thấy trong phim vậy. Một lý do rất chính đáng để đưa ra cảnh báo.

Để duy trì ngữ cảnh trong khi vẫn giữ cho Tisane không có trạng thái, một mô-đun có tên gọi “bộ nhớ dài hạn” được sử dụng. Đối tượng `memory` phản hồi chứa các dấu hiệu lưu trữ các quan sát trung gian. Phần tương tự của phản hồi cần được đưa vào các yêu cầu tiếp theo trong cài đặt (`"memory":{...}`).

{% admonition type="info" %}

Để hiển thị nội dung của mô-đun bộ nhớ, hãy đặt `state` thành `true` trong cấu trúc `settings`.

{% /admonition %}

Nếu đó là một cuộc đối thoại đang diễn ra, thì cấu trúc bộ nhớ của mọi tin nhắn được xử lý cuối cùng phải được đưa vào yêu cầu tiếp theo như thể hiện trong sơ đồ bên dưới:

![tisaneMemoryUse.png](/images/tisaneMemoryUse.png)

Có thể thay đổi và chỉnh sửa các bộ nhớ này không? Tất nhiên, bối cảnh bên ngoài cũng có thể được thêm vào. Xin lưu ý rằng việc lưu giữ dữ liệu là trách nhiệm của người gọi.

Xem phần: [Bối cảnh và Bộ nhớ dài hạn](/apis/tisane-api-configuration#context-and-long-term-memory)