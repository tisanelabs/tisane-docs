# Phân tích, Xác thực và So sánh tên

## Phân tách Họ tên đầy đủ

Tisane có thể phân tích họ tên đầy đủ thành các thành phần chính:

| Thuộc tính     | Mô tả                         |
| ------------- | ----------------------------------- |
| `given_name`  | Tên gọi (ví dụ *John*)           |
| `middle_name` | Tên đệm (nếu có)         |
| `surname`     | Họ (ví dụ *Doe*)             |
| `title`       | Danh xưng (ví dụ: *Dr., Mr., Ms.*)  |
| `suffix`      | Hậu tố tên (ví dụ *Jr., Sr., III*) |
| `social_role` | Vai trò như *Haji* hoặc *Dr.*          |

## Cách phân tách tên

Để phân tách một tên đầy đủ, gửi yêu cầu `POST /parse` với:

* `"entity": "person"`
* `"words": true`


Phản hồi sẽ phân loại các thành phần của tên theo thuộc tính `role`.

Ví dụ về phân tích tên:
![tisaneAliKilicoglu.png](/images/tisaneAliKilicoglu.png)


## Xác thực tên thật

Mặc dù Tisane không thể xác minh liệu tên người dùng cung cấp có thật hay không, nhưng hệ thống có thể nhận biết nhiều tên liên quan đến:

- Nhân vật nổi tiếng (`important_person`)
- Nhân vật hư cấu (`fictional_character`)
- Thực thể tâm linh (`spiritual_being`)
- Những tên không giống tên người (ví dụ: User-13789026152908425434)

Có thể tham khảo danh sách các tên giả phổ biến tại bài viết trên [Quora](https://qr.ae/pNKxWl).


Thuộc tính `subtype` trong cấu trúc `entity` thể hiện loại tên được phát hiện, kèm theo ID Wikidata nếu có.

Ví dụ về phân tích tên nhân vật hư cấu:

![tisaneFictionalCharacter.png](/images/tisaneFictionalCharacter.png)



## So sánh tên

Phương thức `/compare/entities` cho phép so sánh hai tên (kể cả khác ngôn ngữ) và phát hiện các điểm khác biệt.

### Ví dụ so sánh

| Tên 1           | Tên 2                              | Kết quả                                                 |
| ---------------- | ----------------------------------- | ------------------------------------------------------ |
| *William Smith*  | *Will Smith*                        | `{"result":"different","differences":["variation"]}`   |
| *Musa Bin Osman* | *Haji Musa Bin Osman*               | `{"result":"different","differences":["social_role"]}` |
| *William Smith*  | *Вилл Смит* (Will Smith trong tiếng Nga) | `{"result":"different","differences":["variation"]}`   |
| *Kevin Tan*      | *TAN Kevin*                         | `{"result":"same"}`                                    |

### **Cách so sánh tên**

Gửi yêu cầu đến endpoint `/compare/entities` với hai tên cần so sánh. Phản hồi sẽ trả về sự khác biệt dựa trên các thuộc tính như:

- `variation` (ví dụ *William* vs *Will*)
- `social_role` (ví dụ *Haji Musa* vs *Musa*)
- `case_difference` (ví dụ *John Doe* vs *JOHN DOE*)
- `same` (Tên giống nhau, kể cả khi thứ tự khác nhau)


## Kiểm tra biệt danh và tên thay thế

Tên người dùng và biệt danh có thể gây hiểu nhầm, xúc phạm hoặc mang tính lạm dụng. Tisane phát hiện các tên không phù hợp  (ví dụ *Hitler*, *UserJohn_is_liar*).

### Cách kiểm tra biệt danh

Gửi yêu cầu `POST /parse` với:

- ` "format": "alias"`

- Cài đặt `subscope` giúp phân tách tên một cách chính xác, kể cả khi viết liền, dùng dấu gạch dưới hoặc không có dấu cách.

Ví dụ về kiểm tra biệt danh:

![tisaneAliasCreep.png](/images/tisaneAliasCreep.png)
