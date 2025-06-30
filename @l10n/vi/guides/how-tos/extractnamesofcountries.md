# Phát hiện quốc gia

Tisane có thể trích xuất tên các quốc gia, nhưng chúng tôi không gán loại đặc biệt riêng cho các tên đó. Để tránh tranh cãi về tính hợp pháp của các thực thể chính trị khác nhau, mỗi quốc gia sẽ bao gồm hai thành phần trong mảng `type`:

* `organization`
* `place`

Cách tiếp cận này:

* giúp tránh các tranh cãi liên quan đến chủ quyền hoặc vị thế
* không cần tạo ngoại lệ đặc biệt khi một quốc gia được xem như một tổ chức (ví dụ: trong việc ra quyết định) hoặc như một địa điểm 
