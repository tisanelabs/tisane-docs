# Cấu hình và tùy chỉnh

Phần này trình bày những cách bạn có thể cấu hình và tùy chỉnh hành vi của API thông qua các tham số khác nhau.

Cấu trúc cài đặt cho phép bạn:

1. Cung cấp các dấu hiệu về nội dung đang được xử lý để cải thiện kết quả phân tích.
2. Tùy chỉnh đầu ra và chọn các phần cụ thể để hiển thị.
3. Xác định các tiêu chuẩn cho thẻ để tuân thủ các tiêu chuẩn bạn sử dụng.

### Lưu ý chung

- Tất cả cài đặt đều là tùy chọn.
- Để sử dụng cài đặt mặc định, hãy cung cấp một đối tượng trống: `{}`.
- Chỉ xác định những cài đặt bạn muốn sửa đổi.

## Các đặc điểm của nội dung

Các đặc điểm của nội dung giúp điều chỉnh phân tích bằng cách cho biết nội dung đến từ đâu, chủ đề nào sẽ được mong đợi và nhiều thông tin khác.

### Định dạng

Cài đặt `format` cho phép sử dụng logic nhận biết định dạng.

`format` (string) - Defines the format of the content. This influences how the underlying language models process the content. For example: when Tisane is told it's a review, it might look for sentiment more aggressively. With aliases, Tisane may try segment words and expect specific length. And so on. 

Mặc định: trống/không xác định.

#### Các giá trị định dạng được hỗ trợ

Các giá trị được hỗ trợ là:

- `review` - Dành cho đánh giá sản phẩm, dịch vụ hoặc đánh giá chung. Định dạng này ưu tiên phát hiện cảm xúc và thư rác quảng cáo (gửi lời chào hàng thương mại không mong muốn) có thể chứa từ ngữ tối nghĩa.
- `dialogue` - Dành cho bình luận/bài đăng trong cuộc hội thoại. Định dạng này phát hiện các đặc điểm cụ thể theo ngữ cảnh, chẳng hạn như chửi rủa và các hành vi tấn công cá nhân khác. Ví dụ: Bình luận sử dụng từ "bông tuyết" có thể bị đánh dấu là tấn công cá nhân (không giống như trường hợp từ này xuất hiện trong đánh giá hoặc biệt danh).

- `shortpost` - Dành cho bài đăng microblog. Ví dụ: một tweet không phải là phản hồi cho một tweet khác.

- `longform` - Dành cho bài đăng hoặc bài viết dài.

- `proofread` - Dành cho bài đăng đã được hiệu đính. Ở định dạng này, tính năng kiểm tra chính tả sẽ tự động bị tắt.
- `alias` - Biểu thị biệt danh trong cộng đồng trực tuyến hoặc tên người dùng.

- `search` - Dành cho truy vấn tìm kiếm; truy vấn tìm kiếm không nhất thiết phải là câu hoàn chỉnh hoặc đúng ngữ pháp. 

### Kiểm tra chính tả và sử dụng văn bản đối nghịch

Các cài đặt này kiểm soát chính sách kiểm tra chính tả. Chúng giúp quản lý thời điểm và cách kiểm tra chính tả được áp dụng nhằm giảm thiểu các trường hợp lỗi và nhận diện sai.

- `disable_spellcheck` (boolean) - Tắt kiểm tra chính tả tự động khi được đặt thành `true`. Mặc định: `false` (đã bật kiểm tra chính tả).
- `lowercase_spellcheck_only` (boolean) - Chỉ áp dụng kiểm tra chính tả cho các từ viết thường. Điều này giúp tránh nhận diện sai với danh từ riêng. Mặc định: `false` (áp dụng cho tất cả từ).

### Cài đặt phân tích cú pháp

Các cài đặt này kiểm soát hành vi phân tích cú pháp và lọc từ vựng, cho phép phân tích văn bản chính xác hơn. Chúng giúp tinh chỉnh quá trình xử lý ngôn ngữ bằng cách lọc các thuật ngữ hiếm, cho phép phân tích cú pháp theo ngữ cảnh và tùy chỉnh các ranh giới phát hiện ngôn ngữ.

- `min_generic_frequency` (số nguyên) -  Loại trừ các thuật ngữ hiếm hoặc khó hiểu dựa trên tần suất. Chỉ áp dụng cho các mục từ vựng không có miền. Phạm vi hợp lệ: '0' đến '10' (giá trị cao hơn loại trừ các thuật ngữ hiếm hơn).
- `subscope` (boolean) - Cho phép phân tích cú pháp phạm vi phụ cho các ngữ cảnh cụ thể như hashtag, URL, văn bản bị làm cho tối nghĩa (ví dụ: *“ihateyou”*). Mặc định: `false`.
- `lang_detect_segmentation_regex` (chuỗi) -  Tùy chỉnh ranh giới phát hiện ngôn ngữ bằng cách sử dụng biểu thức chính quy. Ví dụ: `(([\r\n]|[.!?][ ]))`.Biểu thức chính quy này coi ký tự xuống dòng và dấu chấm kết thúc câu là các ranh giới. Điều này có thể hữu ích cho các văn bản chứa nhiều ngôn ngữ.
- `disable_phrases` (boolean) - nếu được đặt thành `true`, cấu trúc cú pháp không được ánh xạ. **Chỉ sử dụng nếu bạn cần phát hiện các thực thể đơn giản hoặc quay lại chế độ "túi từ".**
- `disable_commonsense_cues` (boolean) -nếu được đặt thành `true`, cấu trúc cú pháp được ánh xạ nhưng kiến ​​thức thông thường không được áp dụng. Tăng tốc độ xử lý nhưng làm giảm độ chính xác; các cấu trúc phụ thuộc vào ngữ cảnh (phần lớn `abuse`, một số thực thể) sẽ không được phát hiện.

### Tùy chỉnh miền

Cài đặt này cho phép kiểm soát chặt chẽ mức độ liên quan của nội dung bằng cách tăng hoặc giảm mức độ ảnh hưởng/đáng chú ý của các miền cụ thể. 

- `domain_factors` (mảng cấu trúc) - Cài đặt này cung cấp đặc điểm cụ thể theo từng phiên để điều chỉnh mức độ liên quan của các miền nội dung khác nhau. Điều này giúp mở rộng hoặc hạn chế các loại nội dung cụ thể dựa trên trường hợp sử dụng của bạn.

#### Định dạng phần tử mảng

`{ "domain_id": multiplier }`

`domain_id` (string): The identifier for a specific domain of interest.

`multiplier` (number): A factor that increases or decreases the relevance of the domain.

Ví dụ: 
```json
"domain_factors": {"12345": 2.3, "2222": 5.0}
```

#### Các trường hợp sử dụng mẫu

1. Để mở rộng các miền có liên quan bằng cách đặt các giá trị lớn hơn 1.

Ví dụ:

Nhấn mạnh các chủ đề như tội phạm hoặc ma túy:

`"domain_factors": {"31058": 5.0, "45220": 5.0, "14112": 5.0, "14509": 3.0, "28309": 5.0, "43220": 5.0, "34581": 5.0}`. 

2. Để hạn chế các miền không liên quan, bằng cách đặt giá trị nhỏ hơn 1. Điều này giúp giảm nhiễu từ các chủ đề không liên quan.

### Ngữ cảnh thời gian (ĐÃ ĐẶT TRƯỚC)

Tính năng ngữ cảnh thời gian đảm bảo việc diễn giải ngôn ngữ chính xác hơn bằng cách xem xét cách sử dụng từ đã thay đổi như thế nào theo thời gian.

- `when` (chuỗi ngày, định dạng YYYY-MM-DD) - Cho phép bạn chỉ định ngày tạo nội dung. Cài đặt này giúp mô hình lọc ra những nghĩa từ không đúng thời điểm không tồn tại tại thời điểm được chỉ định.

Ví dụ: Trước thời đại internet, các từ _troll_, _mail_, và _post_ có nghĩa khác với bây giờ. Đối với các văn bản lịch sử, cài đặt này giúp bỏ qua các nghĩa từ hiện đại không tồn tại vào thời điểm đó.

## Tùy chỉnh đầu ra

Các thiết lập sau đây cho phép bạn tùy chỉnh đầu ra bằng cách chỉ định chức năng có liên quan/không liên quan và mức độ chi tiết yêu cầu. 

Tất cả các cài đặt đều là tùy chọn, có sẵn các giá trị mặc định.

### Tùy chỉnh phản hồi

Tùy chỉnh phản hồi cho phép bạn loại bỏ các phần không liên quan khỏi cấu trúc JSON của phản hồi hoặc hiển thị các phần thường không có trong phản hồi. 

Các cài đặt sau đây kiểm soát những khía cạnh nào của nội dung sẽ được báo cáo:

- `abuse` (boolean) - Xuất thông tin về các trường hợp phát hiện nội dung có vấn đề. Mặc định: `true`.
- `sentiment` (boolean) - Đưa ra các đoạn trích liên quan đến cảm xúc. Mặc định: `true`.
- `document_sentiment` (boolean) - Đưa ra cảm xúc ở cấp độ tài liệu. Cài đặt này cung cấp phân tích cảm xúc chung cho toàn bộ văn bản. Mặc định: `false`.
- `entities` (boolean) - Đưa ra các thực thể được đặt tên được phát hiện trong văn bản. Ví dụ: Con người, tổ chức, địa điểm. Mặc định: `true`.
- `topics` (boolean) - Đưa ra các chủ đề được xác định trong nội dung. Mặc định: `true`.

Lưu ý: nếu cấu trúc đang đề cập không được phát hiện trong dữ liệu đầu vào, phần này sẽ bị bỏ qua.

#### Phát hiện chủ đề

Phát hiện chủ đề cho phép bạn xác định các chủ đề chính (đề tài, chủ đề) trong nội dung. 

Các cài đặt sau kiểm soát cách chủ đề được trích xuất và trình bày:


- `topic_stats` (boolean) - Bao gồm số liệu thống kê phạm vi cho từng chủ đề, nếu được bật. Mặc định: `false`. Khi được đặt thành `true`, đầu ra trở thành một đối tượng có các thuộc tính sau:

  - `topic` (chuỗi): Tên chủ đề.

  - `coverage` (số dấu phẩy động): Tỷ lệ các câu trong văn bản đầu vào đề cập đến chủ đề.

- `optimize_topics` (boolean) - Xóa các chủ đề ít cụ thể hơn khi chúng chồng chéo với các chủ đề cụ thể hơn, nếu được bật. Ví dụ: Khi chủ đề là `cryptocurrency`, thuộc tính tối ưu hóa sẽ xóa `finance`. Mặc định: `false`.

#### Chức năng cấp thấp

Các cài đặt này cung cấp thông tin chuyên sâu về cấu trúc và ý nghĩa của văn bản bằng cách chia nhỏ văn bản thành các khối từ vựng, định nghĩa và cấu trúc cụm từ. Thông tin chi tiết có thể được sử dụng khi đối chiếu các tiêu chí cụ thể không được phản ánh trong các phần ở cấp độ cao hơn như `abuse` hoặc `topics`. Ví dụ: khi tìm kiếm tất cả các cụm danh từ hoặc tham chiếu đến các loại phương tiện cơ giới khác nhau, v.v.

- `words` (boolean) - Đưa ra các khối từ vựng (hoặc từ) cho mỗi câu. Mặc định: `false`

Trong các ngôn ngữ không có khoảng trắng (tiếng Trung, tiếng Nhật, tiếng Thái), kết quả của phép phân tách được coi là các từ.

Trong các ngôn ngữ sử dụng từ ghép (tiếng Đức, tiếng Hà Lan, tiếng Na Uy, tiếng Hungary), các từ ghép được chia thành các thành phần từ vựng riêng lẻ. 

- `fetch_definitions` (boolean) - Bao gồm định nghĩa theo từ điển của các từ trong văn bản đầu vào. Mặc định: `false`. 

Lưu ý: `fetch_definitions` chỉ được cân nhắc khi cài đặt `words` được đặt thành `true`.

- `parses` (boolean) - Đưa ra các rừng phân tích cú pháp biểu diễn cấu trúc phân cấp của cụm từ trong câu. Mặc định: `false`.

- `deterministic` (boolean) - Kiểm soát việc chỉ đưa ra ý nghĩa được phát hiện hay bao gồm hầu hết các cách giải thích khả thi về mặt hình thái:

  - Nếu được đặt thành `true` (mặc định): Chỉ đưa ra các nghĩa được phát hiện.

  - Nếu được đặt thành `false`: Đưa ra các nghĩa n-best.


### Khả năng giải thích

Các cài đặt này kiểm soát việc đưa vào các đoạn văn bản có liên quan và giải thích về hành vi lạm dụng, cảm xúc và thực thể được phát hiện. Chúng giúp làm rõ lý do tại sao các đoạn văn bản cụ thể được đánh dấu hoặc trích xuất.

- `snippets` (boolean) - Bao gồm các đoạn văn bản trong phần lạm dụng, cảm xúc và thực thể. Mặc định: `false`

- `explain` (boolean) - Cung cấp lý do hoặc giải thích cho các đoạn trích liên quan đến lạm dụng và cảm xúc được phát hiện, nếu có thể. Mặc định: `false`.
 ## Tiêu chuẩn và định dạng
Các tham số sau đây xác định các tiêu chuẩn và định dạng được sử dụng trong đối tượng phản hồi.

 ### Tiêu chuẩn đặc điểm

- `feature_standard` (string) - Chỉ định tiêu chuẩn để đưa ra các đặc điểm liên quan đến ngữ pháp, phong cách và ngữ nghĩa. 

 Các giá trị được hỗ trợ là:

- `ud`- <a href="https://universaldependencies.org/u/pos/" target="_blank">Universal Dependencies tags</a> (mặc định)
- `penn` - <a href="https://www.ling.upenn.edu/courses/Fall_2003/ling001/penn_treebank_pos.html" target="_blank">Penn treebank tags</a>
- `native` -  Mã đặc điểm gốc của Tisane
- `description` - Mô tả đặc điểm gốc của Tisane
- `glossing` - <a href="https://en.wikipedia.org/wiki/List_of_glossing_abbreviations" target="_blank">standard glossing abbreviations</a>

Lưu ý: Mã gốc Tisane (và các mô tả của chúng) cung cấp số lượng lớn nhất các ký hiệu đặc điểm, tiếp theo là các chữ viết tắt chú thích, tiếp theo là Universal Dependencies và cuối cùng là các thẻ Penn treebank.

### Tiêu chuẩn chủ đề

- `topic_standard` (string) - Xác định tiêu chuẩn được sử dụng để đưa ra chủ đề trong đối tượng phản hồi. 

Các giá trị được hỗ trợ là:    

- `iptc_code` - Mã phân loại chủ đề IPTC

- `iptc_description` - Mô tả phân loại chủ đề IPTC (mặc định)
- `iab_code` - Mã phân loại chủ đề IAB
- `iab_description` - Mô tả phân loại chủ đề IAB
- `native` - Mô tả miền của Tisane (lấy từ mô tả họ)

### Loại phân tích cảm xúc

- `sentiment_analysis_type` (chuỗi) - Xác định chiến lược phân tích cảm xúc được sử dụng. 

Các giá trị được hỗ trợ là:

* `products_and_services` - Loại phân tích cảm xúc phổ biến nhất: sản phẩm và dịch vụ.
* `entity` - Phân tích cảm xúc  với các thực thể là mục tiêu.

## Bối cảnh và Bộ nhớ dài hạn

Sự hiểu biết của con người về ngôn ngữ không chỉ giới hạn ở việc xử lý từng câu riêng lẻ. Sự hiểu biết thường đòi hỏi ngữ cảnh vượt ra ngoài thông tin bằng lời nói hoặc văn bản hiện tại, bao gồm cử chỉ, hình ảnh hoặc kiến ​​thức dựa trên thông tin bằng lời nói hoặc văn bản trước đó. 

Trong một số trường hợp, mật mã hoặc tham chiếu gián tiếp có thể che giấu hoặc làm lu mờ ý nghĩa ban đầu của từ.

Mô-đun bộ nhớ dài hạn cung cấp một giải pháp để giải quyết những khoảng trống này.

### Khi chỉ văn bản là không đủ

Thông thường, cần nhiều hơn là chỉ đầu vào văn bản để thực hiện tác vụ NLP:

- Lạm dụng: Một thuật ngữ đề cập đến một nhóm dân tộc hoặc tôn giáo có thể không mang tính xúc phạm, nhưng khi đi kèm với một hình ảnh mang tính xúc phạm (Ví dụ: con vượn, con lợn), thì ý định xúc phạm là rõ ràng.
- Sự mơ hồ về giới tính trong dịch thuật: Các ngôn ngữ như tiếng Anh không phải lúc nào cũng thể hiện giới tính của một người. Khi dịch sang các ngôn ngữ yêu cầu xác định giới tính (Ví dụ: Tiếng Nga hoặc tiếng Pháp), cần có thêm ngữ cảnh.
- Lừa đảo: Kẻ lừa đảo có thể trích xuất thông tin chi tiết từng phần qua nhiều tin nhắn. Nếu chỉ xét riêng lẻ, không tham chiếu đến các tin nhắn trước đó, sẽ rất khó hoặc không thể phát hiện ra thời điểm phạm tội.

Mô-đun bộ nhớ dài hạn của Tisane giải quyết được những thách thức này. Mô-đun này bao gồm ba thành phần (tất cả đều là tùy chọn):

- Gán lại - Gán lại ý nghĩa, thuộc tính và thượng vị để diễn giải theo ý muốn. 
- Dấu hiệu - Để cung cấp ngữ cảnh phi văn bản.
- Tiền đề - Để theo dõi đại từ và tham chiếu chính xác.

Điều này đảm bảo khả năng hiểu ngôn ngữ chính xác hơn. Mô-đun này giúp phát hiện hành vi lạm dụng, lừa đảo và các sắc thái ngữ cảnh tiềm ẩn.

#### Thượng vị là gì?

Thượng vị là một từ đóng vai trò như một danh mục rộng trong đó chứa những từ cụ thể hơn (gọi là hạ vị). Ví dụ: *color* là thượng vị của *pink*; *vehicle* là thượng vị của *truck*. Trong ngôn ngữ học tính toán và xử lý ngôn ngữ tự nhiên (NLP), thượng vị giúp phân loại các từ theo thứ bậc, có thể hữu ích cho việc lọc hoặc tinh chỉnh phân tích nội dung.

####  Gán lại

Gán lại sẽ thay đổi cách phân tích văn bản bằng cách điều chỉnh các thuộc tính và điều kiện dựa trên ngữ cảnh. 

Ví dụ:

- Nếu một từ là động từ ở ngôi thứ nhất hoặc thứ hai thì sẽ được chỉ định giới tính cụ thể. Điều này sẽ tạo ra bản dịch sang ngôn ngữ mà các dạng biến cách có thể khác nhau đối với những giới tính khác nhau chính xác hơn.

- Ghi đè lên nghĩa gốc của một nhóm từ (bao gồm tất cả các dạng biến cách).  Điều này cho phép phát hiện mật mã và ngôn ngữ bí mật.

- Thêm các đặc điểm hoặc thượng vị. Ví dụ: chúng ta có thể muốn đánh dấu một danh mục hiện vật cụ thể là `item_of_interest`, việc này sẽ khiến các hiện vật này được trích xuất dưới dạng một thực thể.  

##### Gán lại hoạt động như thế nào

Gán lại được định nghĩa trong phần `assign` là một mảng các cấu trúc với hai thành phần chính: điều kiện (`if` )  và thuộc tính (`then`). 

- `if` - Điều kiện phải phù hợp, dựa trên sự kết hợp của:

  - `regex` - Một biểu thức chính quy (cú pháp RE2)
  - `family` - Một ID họ
  - `features` - Một danh sách các giá trị đặc điểm. Ví dụ: `[{"index":1, "value":"NOUN"}]`.
  - `hypernym` - ID họ của một thượng vị

- `then` -  Các thuộc tính cần gán nếu tất cả các yêu cầu trong điều kiện phù hợp:
     - `family` - một ID họ
     - `features` - Một danh sách các giá trị đặc điểm. Ví dụ: `[{"index":5, "value":"F"}]`.
     - `hypernym` - ID họ của một thượng vị
     

 Ví dụ:

1. Giả sử người nói là nữ (nếu là ngôi thứ nhất, chỉ định giới tính nữ):

```json
 `"assign":[{"if":{"features":[{"index":9,"value":"1"}]},"then":{"features":[{"index":5,"value":"F"}]}}]`
```

2. Giả sử mọi trường hợp nhắc đến container đều đề cập đến một mặt hàng bất hợp pháp: 

```json
   `"assign":[{"if":{"family":26888},"then":{"hypernym":123078}}]`
```

3. Đánh dấu các hành vi tấn công vào bên thứ 3 được nêu tên cụ thể là các hành vi tấn công cá nhân (bằng cách định nghĩa lại tên là "người tham gia thảo luận"):

 ```json
   `"assign":[{"if":{"features":[{"index":14,"value":"NA"},{"index":22,"value":"PERS"}]},"then":{"features":[{"index":33,"value":"DIPA"}],"hypernym":123887}}]`
 ```

   #### Dấu hiệu

Dấu hiệu đóng vai trò gợi ý theo ngữ cảnh, cung cấp thông tin ngoài nội dung văn bản hiện tại hoặc điều chỉnh cách phân tích theo một cách cụ thể. Mỗi dấu hiệu được biểu diễn dưới dạng một chuỗi. (Một vài trong số các dấu hiệu này có thể được bật/tắt tự động với đầu vào văn bản cụ thể.) 

Ngoài các dấu hiệu được trả về trong phần `memory`, các dấu hiệu sau đây có thể được đặt thủ công:

| **Dấu hiệu**                | **Nghĩa**                                                  |
| ----------------------- | ------------------------------------------------------------ |
| `agents_of_bad_things`  | Một kẻ xấu hoặc đã từng được nhắc đến trước đó.                  |
| `aggressive_crime_scan` | Khi không chắc chắn, cho rằng đó là chủ đích phạm tội.                 |
| `bad_animal`            | Ngữ cảnh liên quan đến một loài động vật tượng trưng cho những phẩm chất xấu. Ví dụ: lợn, vượn, rắn. |
| `bulk_message`          | Tin nhắn được gửi hàng loạt.                                |
| `death_related`         | Ngữ cảnh liên quan đến cái chết.                                  |
| `game_violence_ok`      | Trong các cuộc trò chuyện khi chơi game, cho phép kêu gọi bạo lực.                    |
| `make_money`            | Ngữ cảnh nói về việc kiếm tiền.                               |
| `my_departure`          | Tác giả nhắc đến việc rời đi.                                |
| `sexually_conservative` | Mọi hành động chia sẻ ảnh hoặc tương tác mơ hồ đều bị coi là có liên quan đến tình dục. |
| `trusted_party`         | Tác giả tự nhận mình là người đáng tin cậy. Ví dụ: Vợ/chồng, họ hàng. |
| `waste`                 | Chủ đề nói về chất thải (hữu cơ/vô cơ).                |
| `won_prize`             | Đề cập hoặc ngụ ý đến việc thắng tiền/giải thưởng.            |
| `work_from_home`        | Đề cập đến việc làm việc tại nhà.                                  |
| `organization`          | Một tổ chức được nhắc đến.                               |
| `role`                  | Một vị trí hoặc vai trò được nhắc đến.                            |

####    Tiền đề

Tiền đề hỗ trợ phân giải đồng tham chiếu. 

Quá trình này cung cấp ngữ cảnh cho đại từ hoặc các tham chiếu khác, điều này có thể ảnh hưởng đến kết quả phân tích.

##### Cấu trúc

Mỗi tiền đề chứa:

- `family` - ID họ của tiền đề
 - `features` - Một danh sách các giá trị đặc điểm. Ví dụ: `{"index":36, "value":"WFH"}`.

##     Xếp hạng tín hiệu trên nhiễu

Khi phân tích các bài đăng bình luận về một vấn đề hoặc bài viết, điều hữu ích là ưu tiên những bài đăng có liên quan nhất và dựa trên lý trí thay vì cảm xúc. Xếp hạng tín hiệu trên nhiễu giúp thực hiện điều này bằng cách lọc nội dung theo mức độ liên quan và chất lượng logic.

### Cách thức hoạt động

Để tính toán xếp hạng tín hiệu trên nhiễu:    
1. Phân tích tiêu đề bài viết bằng cách sử dụng `keyword_features` và (tùy chọn) `stop_hypernyms` trong phần cài đặt. Trích xuất thuộc tính `relevant`.
2. Xếp hạng các bài đăng theo mức độ liên quan bằng cách sử dụng thuộc tính `relevant`.

#### Bước 1:  Xác định các khái niệm có liên quan

(This step can be omitted, if we already know the relevant concepts.)

Để xác định các khái niệm có liên quan, ta phân tích tiêu đề của bài viết. Thông thường như vậy là đủ.

Hai cài đặt chính ảnh hưởng đến phân tích này:

- `keyword_features` (một đối tượng chuỗi có giá trị chuỗi) - Xác định các đặc điểm cần tìm kiếm trong một từ. Nếu tìm thấy kết quả trùng khớp, ID họ tương ứng sẽ được thêm vào tập hợp các ID họ có liên quan.
- `stop_hypernyms` (một mảng số nguyên) - Lọc ra những trường hợp khái quát không mong muốn, chẳng hạn như các thuật ngữ trừu tượng hoặc cảm xúc. Nếu một ID họ có khả năng liên quan có thượng vị được liệt kê trong cài đặt này, thì ID đó sẽ không được xem xét. Ví dụ: Trong tiêu đề *Fear and Loathing in Las Vegas*, ta có thể chỉ muốn *Las Vegas*. Cài đặt này là tùy chọn.

Nếu sử dụng `keyword_features`, phản hồi sẽ bao gồm một thuộc tính `relevant`, chứa các ID họ đã xác định.  

Chúng tôi đề xuất nên bao gồm mảng `relevant` trong cài đặt khi bạn thực hiện Bước 2 ("Xếp hạng các bài đăng theo mức độ liên quan"). Thao tác này giúp ưu tiên các bài đăng đề cập đến các khái niệm liên quan đến các ID họ đó, đảm bảo quá trình xếp hạng tập trung vào nội dung có liên quan nhất.

#### Bước 2: Xếp hạng các bài đăng theo mức độ liên quan

Sử dụng thuộc tính `relevant` từ bước 1 để đánh giá các bài đăng và bình luận. 

Xếp hạng được tăng cường khi:

* Các miền, thượng vị hoặc họ có liên quan xuất hiện trong bài đăng. 
* Cảm xúc (tích cực hoặc tiêu cực) có liên quan đến những khía cạnh cụ thể.

Xếp hạng bị phạt khi:

- Sự tiêu cực không liên quan đến khía cạnh cụ thể nào.
- Phát hiện nội dung lạm dụng (trừ trường hợp đang tìm kiếm nội dung tội phạm cụ thể).

Lưu ý: Tham số `abuse_not_noise` (khi được đặt thành `true`) ngăn việc phạt nội dung lạm dụng.