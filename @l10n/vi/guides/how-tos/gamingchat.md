# Xử lý ngôn ngữ mang tính ganh đua trong nội dung trò chuyện về game và thể thao 

## Thách thức của ngôn ngữ mang tính ganh đua

*“Kill him! Kill him NOW!”*
*“I will kick your a*!”*
*“Touch your chest. Then push the ball harder.”*

Khi xử lý nội dung trò chuyện trong các game trên máy tính và cộng đồng liên quan đến thể thao, API kiểm duyệt phải đối mặt với một tình huống khó xử. 

Một mặt, chúng không thể bỏ qua những phát ngôn mà thông thường sẽ được coi là vi phạm chính sách. 

Mặt khác, như nhóm ủng hộ Dr. Evil có thể sẽ nói: *“Thực ra chúng tôi không muốn giết nhau ở đây.”*  Tuy nhiên, những mối đe dọa thực sự vẫn phải được xem xét một cách nghiêm túc.

### Vấn đề khi sử dụng mức độ nghiêm trọng

Một số API kiểm duyệt cố gắng giải quyết vấn đề này bằng cách chỉ định "mức độ nghiêm trọng" và khuyên người dùng bỏ qua các tin nhắn ở dưới một ngưỡng nhất định.

Nhưng tính bạo lực trong game có thể rất nghiêm trọng và không liên quan gì đến thế giới thực.  Điều này có nghĩa là ta nên mặc kệ ngay cả những phát ngôn nghiêm trọng nhất. Đồng thời, cách tiếp cận dựa trên mức độ nghiêm trọng này có nguy cơ bỏ sót những mối đe dọa thực sự không nên bỏ qua.

## Cách tiếp cận của Tisane

Tisane đưa ra hai phương thức để giải quyết tình huống khó xử này:

- **Phương thức 1**: Bỏ qua mọi trường hợp thuộc loại `criminal_activity` và có những thẻ như `violence` và `death` trên ứng dụng máy khách.

- **Phương thức 2** (khuyến nghị): Sử dụng một cờ `game violence` đặc biệt để bỏ qua ngôn ngữ mang tính ganh đua liên quan đến game và thể thao.

Ví dụ:

```

{"language":"en","content":"Shoot him!!!","settings":{"snippets":true,"memory":{"flags":["game_violence_ok"]}}}

```
Cờ `game_violence_ok` đảm bảo rằng mọi cảnh báo liên quan đến ngôn ngữ mang tính ganh đua liên quan đến thể thao và bạo lực trong game đều bị bỏ qua. 

Lưu ý: Cờ này sẽ không bỏ qua những lời đe dọa thực sự như *“Tao biết mày sống ở đâu đấy”* hay bất cứ điều gì rõ ràng không liên quan đến game.

### Đầu ra

Ví dụ không có cờ `game violence`:

![tisaneShootHimNoGVOK.png](/images/tisaneShootHimNoGVOK.png)

Ví dụ có bộ cờ  `game violence`:

![tisaneGvOk.png](/images/tisaneGvOk.png)

Xem thêm phần: [Kiểm duyệt 2 yếu tố](../abuse/whatis2fm.md)

