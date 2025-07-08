# Chế độ Tải chậm so với chế độ Tải đầy đủ

Các mô hình ngôn ngữ của Tisane chứa lượng lớn thông tin ngôn ngữ, vì vậy khi tải đầy đủ vào RAM, chúng có thể chiếm đến hàng trăm megabyte. 

Khi bạn chỉ sử dụng Tisane không thường xuyên hoặc đang chạy trên thiết bị có RAM hạn chế, lựa chọn phù hợp hơn là chế độ tải chậm. Trong chế độ này, dữ liệu ngôn ngữ chỉ được tải khi cần thiết, giúp tiết kiệm đáng kể bộ nhớ RAM.

1. Tải chậm (Khuyến nghị khi sử dụng không thường xuyên)
   - Chỉ tải các phần thiết yếu của mô hình ngôn ngữ khi khởi tạo. Từ điển đầy đủ sẽ được truy cập khi cần.
   - Thời gian khởi tạo: khoảng 1 giây
   - Hiệu suất truy vấn ban đầu:  Chậm hơn nhiều trong vài truy vấn đầu tiên, sau đó chậm hơn khoảng 10–30%.
   - Bộ nhớ sử dụng: khoảng 20–40 MB cho mỗi ngôn ngữ + 40–60 MB cơ bản
2. Preloading (Khuyến nghị cho máy chủ / xử lý dữ liệu số lượng lớn)
   - Tải toàn bộ mô hình ngôn ngữ vào RAM khi khởi động (trừ từ điển kiểm tra chính tả).
   - Thời gian khởi tạo: khoảng 20–40 giây trên máy hiện đại có ổ SSD.
   - Bộ nhớ sử dụng: khoảng 400 MB – 2 GB cho mỗi ngôn ngữ + 40–60 MB cơ bản (Các ngôn ngữ có cấu trúc hình thái phức tạp sẽ yêu cầu nhiều RAM hơn.)

Các lưu ý quan trọng:

*   Bạn có thể tải trước một số mô hình ngôn ngữ, đồng thời để các mô hình khác ở chế độ tải chậm.
*   Sau khi kích hoạt tải chậm, bạn không thể tắt nó trong suốt vòng đời của thư viện hoặc của instance `Tisane.Server`.
*   Hãy chọn chiến lược tải phù hợp nhất với yêu cầu hiệu suất và hạn chế tài nguyên của ứng dụng của bạn.

## Kích hoạt Tải chậm

Theo mặc định, tất cả các mô hình ngôn ngữ sẽ được tải đầy đủ. Để kích hoạt chế độ tải chậm, sử dụng phương thức `ActivateLazyLoading`. (Thư viện .NET sẽ gọi phương thức này sau khi hoàn tất tải trước.)

Ngay khi chế độ tải chậm được kích hoạt, mọi mô hình ngôn ngữ được tải sau đó sẽ được đặt ở chế độ tải chậm.