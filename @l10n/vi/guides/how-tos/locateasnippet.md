# Xác định đoạn văn bằng dữ liệu vị trí

Tisane cung cấp dữ liệu vị trí có cấu trúc nhằm giúp xác định chính xác các đoạn văn bản bị gắn cờ.

Ba thuộc tính vị trí chính là:

- `sentence_index` : Chỉ số câu, đánh số từ 0, chứa đoạn văn bản.     
- `offset`: Vị trí bắt đầu, tính từ 0, của ký tự đầu tiên trong đoạn văn bản trong phạm vi câu.
- `length` : Số ký tự của đoạn văn bản.                         

## Cách để lấy chuỗi

1. Xác định văn bản câu chứa đoạn văn bản:
   - Truy cập vào nút `sentence_list`.
   - Chọn nút có `index` = `sentence_index`.
   - Hoặc có thể lấy trực tiếp câu đó từ mảng danh sách câu.
2. Lấy chuỗi con:
   - Sử dụng giá trị `offset` và `length` để lấy ra chuỗi con từ câu đã chọn.

## Vì sao dùng vị trí tương đối thay vì vị trí tuyệt đối?

Chúng tôi sử dụng chỉ mục theo câu thay vì vị trí ký tự tuyệt đối vì phần lớn người dùng cần lấy cả câu chứa đoạn bị gắn cờ để hiểu được ngữ cảnh.
