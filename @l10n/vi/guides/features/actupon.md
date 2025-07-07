# Tisane xử lý thế nào khi phát hiện nội dung có vấn đề?

- Chúng tôi không phải là người kiểm duyệt hay điều tra viên. Chúng tôi chỉ xử lý nội dung văn bản.
- Chúng tôi không đặt ra chính sách. 

Vai trò của Tisane kết thúc khi đã phát hiện nội dung. Tisane nhận đầu vào là đoạn văn bản, xử lý nó và phản hồi bằng một cấu trúc JSON chứa thông tin chi tiết về những gì phát hiện. 

Ứng dụng gọi Tisane sau đó sẽ dựa vào kết quả này để hành động. Ứng dụng đó có toàn quyền xử lý phản hồi theo cách riêng. Nó có thể bỏ qua một số phần theo chính sách, yêu cầu con người kiểm duyệt, hoặc hành động ngay lập tức, v.v. 

Tisane không thông báo cho bất kỳ ai cũng như không cấm người dùng. Tisane chỉ phục vụ cho mục đích phân tích (hoặc dịch thuật).

## Nếu tôi cần một giải pháp hoàn chỉnh thì sao?

Chúng tôi đã xây dựng một số plugin dành cho các nền tảng phổ biến, để sử dụng Tisane mà không cần viết mã. Bao gồm cả các nền tảng kiểm duyệt hoàn chỉnh tích hợp với kiểm duyệt viên là con người và tuân thủ pháp lý, cũng như các ứng dụng nhắn tin tức thì và trò chơi.

Xem phần: [Tích hợp](https://tisane.ai/integrations).

Nếu bạn cần mã nguồn để bắt đầu xây dựng giao diện người dùng, đối tác của chúng tôi tại PubNub đã xây dựng một tích hợp liền mạch với Tisane cùng với bản [demo](https://moderation-dashboard.pubnub.com/). Mã nguồn: [Kho lưu trữ GitHub của PubNub](https://github.com/pubnub/moderation-dashboard)

Nếu nền tảng bạn đang sử dụng không được liệt kê, hoặc bạn đang xây dựng một giải pháp từ đầu, [hãy liên hệ với chúng tôi](https://tisane.ai/consulting) để trao đổi chi tiết về dự án. 

## Nếu tôi cần nội dung từ mạng xã hội cho giải pháp của mình thì sao?

Chúng tôi không cung cấp nội dung.

Tuy nhiên, chúng tôi hợp tác với các đối tác chuyên cung cấp nội dung từ các nền tảng mạng xã hội thông thường và cả Darkweb.

[Contact us](https://tisane.ai/contact-us) for directions. 