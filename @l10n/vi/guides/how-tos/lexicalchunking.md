# Phân đoạn từ vựng và Tách từ

Tisane sử dụng một cách biểu diễn thống nhất cho các cụm từ vựng, lựa chọn cách biểu diễn dựa trên hình vị theo logic. 

Trong các ngôn ngữ có sử dụng từ ghép như tiếng Đức, các từ ghép sẽ được tách thành các thành phần cấu tạo.  

[Những cụm từ](https://en.wikipedia.org/wiki/Multiword_expression) mang tính thành ngữ (“kung fu”, “power plant” (nhà máy điện), “clay pigeon” (đĩa bay đất sét dùng trong bắn súng) được xem như một đơn vị từ vựng duy nhất.

### Ví dụ
* Tiếng Anh: "I don't see the power plant." => ["I", "do", "n't", "see", "the", "power plant", "."]
* Tiếng Đức: "Jetzt sollen die Stahlkugeln ersetzt werden." => ["Jetzt", "sollen", "die", "Stahl", "kugeln", "ersetzt", "werden", "."]
* Tiếng Trung Giản thể: "我给了老张三本书" => ["我", "给了", "老张", "三", "本", "书"] (Với các ngôn ngữ không dùng khoảng trắng, các trợ từ thường được nối với từ mà chúng bổ nghĩa.)
* Tiếng Tây Ban Nha: "Asimismo, San Francisco es una de las mejores ciudades de EE. UU." => ["Asimismo", ",", "San Francisco", "es", "una", "de", "las", "mejores", "ciudades", "de", "EE. UU."]

## Cách sử dụng
Để sử dụng Tisane cho việc tách từ/phân đoạn từ vựng:

1. Chỉ định `"words":true` trong `settings` của bạn.
2. Trong phản hồi, duyệt qua tất cả các phần tử trong mục `sentence_list` (các câu riêng lẻ). 
3. Các cụm từ sẽ nằm trong `words`.