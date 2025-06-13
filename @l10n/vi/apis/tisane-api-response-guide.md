# Phản hồi

Phần này trình bày chi tiết về tất cả các thành phần và cấu trúc dữ liệu trong các cấu trúc phản hồi được Tisane trả về.

Phản hồi `POST /parse` bao gồm các phần có thể được hiển thị hoặc ẩn đi dựa trên các cài đặt được cung cấp. (Xem [Hướng dẫn cấu hình và tùy chỉnh](/apis/tisane-api-configuration) để biết thêm thông tin). 

Các thuộc tính cấp gốc bao gồm:

- `text` (chuỗi) - Văn bản đầu vào ban đầu.
- `language` (chuỗi) - Mã ngôn ngữ được phát hiện, nếu sử dụng nhận dạng ngôn ngữ.
- `reduced_output` (boolean) - Cho biết liệu thông tin chi tiết có bị bỏ qua do kích thước dữ liệu đầu vào hay không. 
- `sentiment` (số dấu phẩy động) - Điểm cảm xúc ở cấp độ tài liệu (-1 đến 1). Chỉ hiển thị khi cài đặt `document_sentiment` được đặt thành `true`.
- `signal2noise` (số dấu phẩy động) - Điểm liên quan cho biết mức độ phù hợp của văn bản với các khái niệm từ cài đặt `relevant`. Giá trị này chỉ xuất hiện nếu có cài đặt `relevant`.

 ## Nội dung có vấn đề

Tisane tự động phân tích văn bản để tìm ra các trường hợp lạm dụng tiềm ẩn (nội dung có vấn đề) và gắn cờ chúng trong phản hồi.

Phần `abuse` liệt kê các trường hợp nội dung được phát hiện có thể cần sự chú ý của người kiểm duyệt hoặc có liên quan đến các cơ quan thực thi pháp luật. 

Phần này sẽ xuất hiện nếu:

1. Tìm thấy các trường hợp nội dung có vấn đề và;
2. Cài đặt `abuse` được đặt thành `true` (hoặc bỏ qua).

Lưu ý: trường hợp sử dụng có thể khác nhau. Người tích hợp và quản trị viên cộng đồng có trách nhiệm quyết định có xử lý hay không và xử lý như thế nào đối với các loại nội dung bị gắn cờ khác nhau. 

Ví dụ: Hạn chế những hành vi tình dục trong ứng dụng hẹn hò, kiểm duyệt lời nói tục tĩu trong những cộng đồng mà những hành vi này được chấp nhận rộng rãi, hoặc hạn chế tiếp xúc bên ngoài nếu được phép có thể là những việc không phù hợp.

Nếu bạn *không* muốn nội dung có vấn đề xuất hiện trong phản hồi của mình, bạn phải chủ động đặt cài đặt `abuse` thành `false`.

### Thuộc tính nội dung

Mỗi trường hợp đều chứa các thuộc tính sau:


 - `type` (chuỗi) - Loại hành vi lạm dụng
 - `offset` (số nguyên không dấu) - Vị trí bắt đầu của trường hợp. Giá trị này bắt đầu từ số không.
 - `length` (số nguyên không dấu) - Độ dài của nội dung.
 - `sentence_index` (số nguyên không dấu) - Chỉ mục của câu chứa trường hợp đó. Giá trị này bắt đầu từ số không.
 - `text` (chuỗi) - Đoạn văn bản chứa trường hợp. Chỉ xuất hiện nếu cài đặt `snippets` được đặt thành `true`.
 - `tags` (mảng chuỗi) - Thông tin chi tiết bổ sung về hành vi lạm dụng. Ví dụ: nếu đoạn văn bản được phân loại là hành vi bán ma túy hạng nặng, thì trường hợp này sẽ mang thẻ `hard_drug`.
 - `severity` (chuỗi) - Mức độ nghiêm trọng của hành vi lạm dụng. Các mức độ nghiêm trọng là `low`, `medium`, `high` và `extreme`.
 - `explanation` (chuỗi) - Cơ sở cho việc phân loại (nếu `explain` được bật).

###  Các loại được hỗ trợ 

Các loại vấn đề được hỗ trợ là:

- `personal_attack` - Lăng mạ hoặc tấn công trực tiếp nhắm vào một cá nhân. Ví dụ: các trường hợp bắt nạt trên mạng. Lưu ý: Việc chỉ trích ý tưởng, bài đăng hoặc quan điểm tiêu cực nói chung không giống với hành vi xúc phạm cá nhân. Xem phần: [Tấn công cá nhân](/guides/abuse/personalattack.md)
- `bigotry` - Phát ngôn thù hận hoặc thể hiện quan điểm cố chấp; nhận xét mang tính thù địch nhắm vào <a href="https://en.wikipedia.org/wiki/Protected_group" target="_blank">các nhóm được bảo vệ</a>. Điều này không chỉ bao gồm những lời lẽ phân biệt chủng tộc mà còn bao gồm bất kỳ phát biểu thù địch nào nhắm vào toàn thể nhóm. Xem phần: [Cố chấp và phát ngôn thù hận](/guides/abuse/hatespeechandbigotry.md)
- `profanity` - Sử dụng ngôn ngữ tục tĩu, bất kể ngữ cảnh hoặc mục đích. Lưu ý rằng loại vấn đề này không bao gồm lời lẽ phân biệt chủng tộc. Xem phần: [Thô tục](/guides/abuse/profanity.md)
- `sexual_advances` - Các hành vi, bất kể có được hoan nghênh hay không, nhằm tìm kiếm sự ưu ái hoặc thỏa mãn tình dục. Xem thêm phần: [Hành vi tình dục](/guides/abuse/sexualadvances.md)
- `criminal_activity` - Nội dung liên quan đến các hành vi bán hoặc mua các mặt hàng bất hợp pháp, tham gia vào các dịch vụ tội phạm, đưa ra sự đe dọa hoặc các hành động tương tự. Xem thêm phần: [Hoạt động tội phạm](/guides/abuse/criminalactivity.md)
- `external_contact` - Các hành vi khởi xướng giao tiếp hoặc thanh toán thông qua các kênh bên ngoài. Ví dụ: Điện thoại, email, ứng dụng nhắn tin. Các hành vi này có thể vi phạm quy định ở một số cộng đồng, chẳng hạn như các nền tảng kinh tế gig hoặc các trang web thương mại điện tử. Xem thêm phần: [Hành vi thiết lập liên lạc bên ngoài](/guides/abuse/externalcontact.md)

- `adult_only` - các hoạt động bị hạn chế đối với trẻ vị thành niên. Ví dụ: Sử dụng đồ uống có cồn. Xem thêm phần: [Nội dung chỉ dành cho người lớn](/guides/abuse/adultonly.md)
- `mental_issue` - Nội dung có thể chỉ ra những lo ngại về sức khỏe tâm thần, chẳng hạn như ý định tự tử hoặc dấu hiệu trầm cảm. Xem thêm phần: [Vấn đề về tâm thần](/guides/abuse/mental.md)
- `allegation` - Khiếu nại hoặc cáo buộc về hành vi sai trái, có thể liên quan hoặc không liên quan đến hoạt động tội phạm. Xem thêm phần: [Cáo buộc](/guides/abuse/allegation.md)
- `contentious` - Nội dung có khả năng kích động hoặc khơi dậy phản ứng cảm xúc từ cá nhân hoặc nhóm người. Xem thêm phần: [Nội dung gây tranh cãi](/guides/abuse/contentious.md)
- `disturbing` - Mô tả chi tiết hoặc gây khó chịu có thể khiến người đọc cảm thấy khó chịu. Xem thêm phần: [Nội dung gây khó chịu](/guides/abuse/disturbing.md)
- `no_meaningful_content` - Văn bản vô nghĩa hoặc vô lý, thiếu ý nghĩa rõ ràng. Xem thêm phần: [Nội dung vô nghĩa](/guides/abuse/nomeaningfulcontent.md)
- `data_leak` - Thông tin cá nhân nhạy cảm. Ví dụ: Mật khẩu, số ID. Xem thêm phần: [Rò rỉ dữ liệu](/guides/abuse/dataleak.md)
- `spam` - Nội dung gây phiền toái. Xem thêm phần: [Làm phiền](/guides/abuse/spam.md)
- `social_hierarchy` - Sự khẳng định mạnh mẽ về thứ bậc trong một cộng đồng. Ví dụ: Ai đó đang hành động như một kẻ thích kiểm soát. Xem thêm phần: [Khẳng định về thứ bậc](/guides/abuse/socialhierarchy.md)
- `generic` - Nội dung không thuộc bất kỳ danh mục cụ thể nào; không xác định.

 ## Phân tích cảm xúc

Phần `sentiment_expressions` làm nổi bật cảm xúc đối với các khía cạnh hoặc thực thể.

Phần này sẽ xuất hiện nếu: 

1. Xác định được những trường hợp thể hiện cảm xúc, và; 
2. Cài đặt `sentiment` được đặt thành `true` (hoặc bỏ qua).

 Mỗi trường hợp đều chứa các thuộc tính sau:

 - `offset` (số nguyên không dấu) - Vị trí bắt đầu của trường hợp. Giá trị này bắt đầu từ số không.
 - `length` (số nguyên không dấu) - Độ dài của nội dung.
 - `sentence_index` (số nguyên không dấu) - Chỉ mục của câu chứa trường hợp đó. Giá trị này bắt đầu từ số không.
 - `text` (chuỗi) - Đoạn văn bản chứa trường hợp (nếu cài đặt `snippets` được đặt thành `true`).
 - `polarity` (chuỗi) - Biểu thị cảm xúc của văn bản: `positive`, `negative` hoặc `mixed`. Ngoài ra còn có một giá trị mặc định được sử dụng khi cảm xúc đã được xác định trước bởi ứng dụng. Ví dụ: nếu bài đánh giá được chia thành hai phần, _What did you like?_ và _What did you not like?_, và người đánh giá trả lời ngắn gọn bằng _The quiet. The service_. Trong những trường hợp như vậy, cực _default_ cho phép ứng dụng gán cảm xúc bên ngoài dựa trên ngữ cảnh.
 - `targets` (mảng chuỗi) - Liệt kê các khía cạnh hoặc thực thể cụ thể mà cảm xúc đề cập đến, nếu có. Ví dụ: trong câu _The breakfast was yummy but the staff is unfriendly_, mục tiêu của cảm xúc là `meal` và `staff`. Các thực thể được đặt tên cũng có thể là mục tiêu của cảm xúc.
 - `reasons` (mảng chuỗi) - Lý do cho cảm xúc, nếu có. Ví dụ: trong câu _The breakfast was yummy but the staff is unfriendly_, mảng `reasons` cho `staff` là `["unfriendly"]`, trong khi mảng `reasons` cho `meal` là `["tasty"]`.
 - `explanation` (chuỗi) - Lý do cho cảm xúc (nếu `explain` được bật).

 Ví dụ:

 ```json
"sentiment_expressions": [
        {
            "sentence_index": 0,
             "offset": 0,
             "length": 32,
             "polarity": "positive",
             "reasons": ["close"],
             "targets": ["location"]
         },
         {
            "sentence_index": 0,
             "offset": 38,
             "length": 29,
             "polarity": "negative",
             "reasons": ["disrespectful"],
             "targets": ["staff"]
         }
     ]
 ```

 ## Các thực thể được đặt tên

Phần `entities_summary` liệt kê các thực thể được phát hiện trong văn bản. 

Phần này sẽ xuất hiện nếu: 

1. Tìm thấy các thực thể được đặt tên và;
2. Cài đặt `entities` được đặt thành `true` (hoặc bỏ qua).

 Mỗi thực thể đều chứa các thuộc tính sau:

 - `name` (chuỗi) - Dạng đầy đủ nhất của tên thực thể được tìm thấy trong văn bản trong tất cả các lần đề cập.
 - `ref_lemma` (chuỗi) - Dạng từ điển (lemma) của thực thể bằng tiếng Anh, nếu có, bất kể ngôn ngữ đầu vào.
 - `type` (chuỗi hoặc mảng chuỗi) - Xác định loại của thực thể. Một số thực thể có thể có nhiều loại. Một quốc gia (hoặc bất kỳ thực thể địa chính trị nào tự tuyên bố mình là một quốc gia, ngay cả khi không được công nhận rộng rãi) được đồng thời coi là một địa điểm và một tổ chức.
 - `subtype` (chuỗi) - Xác định phân loại chi tiết hơn trong loại thực thể.
 - `mentions` (mảng đối tượng) - Liệt kê tất cả các trường hợp mà thực thể xuất hiện trong văn bản.

 Mỗi lần đề cập đều chứa các thuộc tính sau:

 - `offset` (số nguyên không dấu) - Vị trí bắt đầu của trường hợp. Giá trị này bắt đầu từ số không.
 - `length` (số nguyên không dấu) - Độ dài của nội dung.
 - `sentence_index` (số nguyên không dấu) - Chỉ mục của câu chứa trường hợp. Giá trị này bắt đầu từ số không.
 - `text` (chuỗi) - Đoạn văn bản chứa trường hợp (nếu cài đặt `snippets` được đặt thành `true`).

 Ví dụ:

 ```json
 "entities_summary": [
        {
            "type": "person",
             "name": "John Smith",
             "ref_lemma": "John Smith",
             "mentions": [
                {
                    "sentence_index": 0,
                     "offset": 0,
                     "length": 10 }
             ]
         }
    ,
         {
            "type": [ "organization", "place" ]
        ,
             "name": "UK",
             "ref_lemma": "U.K.",
             "mentions": [
                {
                    "sentence_index": 0,
                     "offset": 40,
                     "length": 2 }
             ]
         }
     ]
 ```

 ### Các loại thực thể và các loại phụ

 Các loại thực thể hiện được hỗ trợ là:

- `person`, với các loại phụ tùy chọn: `fictional_character`, `important_person`, `spiritual_being`
- `organization` Lưu ý: Một quốc gia vừa là một tổ chức vừa là một địa điểm
- `place`
- `time_range`
- `date`
- `time`
- `hashtag`
- `email`
- `amount_of_money`
- `phone` - Số điện thoại, trong nước hoặc quốc tế, ở nhiều định dạng khác nhau
- `role` - Một vai trò xã hội. Ví dụ: Một vị trí trong một tổ chức.
- `software` - Một gói phần mềm được đặt tên
- `website` (URL), với một loại phụ tùy chọn: `tor` cho các liên kết Onion; Lưu ý; Các dịch vụ web cũng có thể có loại `software` được chỉ định
- `item_of_interest` - Bất kỳ loại hiện vật nào có thể có ích cho cuộc điều tra. Ví dụ: Vũ khí, ma túy, xe cộ, đồ xa xỉ.
- `weight`
- `bank_account` Hiện tại chỉ hỗ trợ định dạng IBAN; các loại phụ: `iban`
- `credit_card` - Một số thẻ tín dụng, với các loại phụ tùy chọn: `visa`, `mastercard`, `american_express`, `diners_club`, `discovery`, `jcb`, `unionpay`
- `coordinates` - Tọa độ GPS
- `credential`, với các loại phụ tùy chọn: `md5`, `sha-1`
- `crypto`, với các loại phụ tùy chọn: `bitcoin`, `ethereum`, `monero`, `monero_payment_id`, `litecoin`, `dash`
- `event` - Một sự kiện đáng chú ý có sự tham gia của nhiều người.
- `file` Chỉ hỗ trợ tên đường dẫn Windows; các loại phụ: `windows`, `facebook` (đối với hình ảnh tải xuống từ Facebook)
- `flight_code`
- `identifier` Mọi mã định danh gồm chữ và số (số ID, mã, v.v.) không được phân loại ở nơi khác.
- `ip_address`, các loại phụ: `v4`, `v6`
- `mac_address`
- `numeric` (một thực thể số chưa được phân loại)
- `username` - Tên người dùng hoặc bí danh của người dùng.

 ## Chủ đề

Phần `topics` liệt kê các chủ đề được phát hiện trong văn bản. Ví dụ: chủ đề, lĩnh vực, chủ đề nói theo những thuật ngữ khác. 

Phần này sẽ xuất hiện nếu:

1. Xác định được các chủ đề và; 
2. Cài đặt `topics` được đặt thành `true` (hoặc bỏ qua).

 Nếu cài đặt `topic_stats` được đặt thành `true`, thì mọi mục nhập trong mảng đều chứa:

 - `topic` (chuỗi) - Tên của chủ đề.
 - `coverage` (số dấu phẩy động) - Điểm liên quan biểu thị tỷ lệ các câu phát hiện ra chủ đề trên tổng số câu.

 ## Bộ nhớ dài hạn

Phần `memory` cung cấp ngữ cảnh tùy chọn có thể được chuyển đến `settings` trong các tin nhắn tiếp theo trong cùng một chuỗi hội thoại. 

Xem phần [Bối cảnh và Bộ nhớ dài hạn](/apis/tisane-api-configuration#context-and-long-term-memory) để biết thêm chi tiết.

 ## Dữ liệu cấp thấp: Câu, cụm từ và từ

 Tisane cũng có thể cung cấp dữ liệu ngôn ngữ chi tiết hơn:

 - Câu: Câu gốc, cùng với bản sửa lỗi nếu phát hiện có lỗi chính tả.
 - Các khối từ vựng: Nhóm từ (khối) được chú thích bằng các đặc điểm ngữ pháp và phong cách.
 - Cây phân tích cú pháp và cụm từ: Biểu diễn phân cấp của cấu trúc câu, làm nổi bật các cụm từ và mối quan hệ của chúng.

### Câu

 Phần `sentence_list` được tạo nếu:

* Cài đặt `words` hoặc `parses` được đặt thành `true`.

 Mỗi cấu trúc câu trong danh sách đều chứa:

 - `offset` (số nguyên không dấu) - Vị trí bắt đầu của trường hợp. Giá trị này bắt đầu từ số không.
 - `length` (số nguyên không dấu) - Độ dài của nội dung. 
 - `text` (chuỗi) - Văn bản đầu vào ban đầu. 
 - `corrected_text` (chuỗi) - Phiên bản được tự động sửa của câu, nếu phát hiện lỗi chính tả hoặc lỗi tối nghĩa/thuật ngữ và tính năng kiểm tra chính tả được bật.
 - `words` (mảng cấu trúc) - Cung cấp thông tin chi tiết về từng khối từ vựng, nếu cài đặt `words` được đặt thành `true`. Lưu ý: Mặc dù thuật ngữ "từ" được sử dụng để đơn giản hóa, nhưng có thể không chính xác về mặt ngôn ngữ khi coi các khối từ vựng là các từ riêng lẻ.
 - `parse_tree` (đối tượng) - Bao gồm cây phân tích cú pháp và cụm từ được phát hiện cho câu khi cài đặt `parses` được đặt thành `true`.
 - `nbest_parses` (mảng các đối tượng phân tích cú pháp) - Liệt kê các cây phân tích cú pháp thay thế gần với cây chính xác nhất. Được tạo khi cả hai cài đặt `parses` được đặt thành `true` và cài đặt `deterministic` được chủ động đặt thành `false`.

 ### Từ

 Phần từ được tạo nếu:

* Cài đặt `words` được đặt thành `true`.

 Mỗi khối từ vựng (được gọi đơn giản là "từ") trong mảng `words` đều chứa:

 - `type` (chuỗi) - Xác định danh mục của phần tử. Ví dụ: `punctuation` cho các dấu câu, `numeral` cho các chữ số hoặc `word` cho tất cả các thành phần văn bản khác.
 - `text` (chuỗi) - Văn bản đầu vào ban đầu. 
 - `offset` (số nguyên không dấu) - Vị trí bắt đầu của trường hợp. Giá trị này bắt đầu từ số không.
 - `length` (số nguyên không dấu) - Độ dài của nội dung.
 - `corrected_text` (chuỗi) - Phiên bản được tự động sửa của câu nếu phát hiện lỗi chính tả.
 - `lettercase` (chuỗi) - Biểu thị trạng thái viết hoa ban đầu của từ: `upper`, `capitalized` hoặc `mixed`. Lưu ý: Nếu toàn bộ văn bản là chữ thường hoặc không phân biệt chữ hoa chữ thường, thuộc tính này sẽ bị bỏ qua.
 - `stopword` (boolean) - Xác định xem từ đó có phải là <a href="https://en.wikipedia.org/wiki/Stop_words" target="_blank">stopword</a> hay không
 - `grammar` (mảng chuỗi hoặc cấu trúc) - Liệt kê các đặc điểm ngữ pháp liên quan đến `word`. Nếu cài đặt `feature_standard` được định nghĩa là `native`, thì mỗi tính năng là một đối tượng chứa một `index`(số) và một `value`(chuỗi). Nếu không, mỗi đặc điểm sẽ được biểu diễn dưới dạng một chuỗi thông thường.

 #### Nâng cao

 Chỉ dành cho các từ vựng:

 - `role` (chuỗi) - Vai trò ngữ nghĩa của từ. Ví dụ: `agent` hoặc `patient`. Lưu ý: Trong dạng bị động, vai trò ngữ nghĩa bị đảo ngược so với vai trò cú pháp. Ví dụ: Trong _The car was driven by David_, _car_ là bị thể và _David_ là tác thể.
 - `numeric_value` (số dấu phẩy động) - Giá trị số, nếu từ biểu thị hoặc liên kết với một số.
 - `family` (số nguyên) - ID của họ liên quan đến nghĩa từ được giải thích rõ ràng của khối từ vựng.
 - `definition` (chuỗi) - định nghĩa của họ. 
   - Được bao gồm nếu cài đặt `fetch_definitions` được đặt thành `true`.
 - `lexeme` (số nguyên) - ID của mục từ vựng liên quan đến nghĩa của từ đã được giải thích rõ ràng.
 - `nondictionary_pattern` (số nguyên) - ID của một mẫu không có trong từ điển khớp với từ nếu mẫu không được tìm thấy trong mô hình ngôn ngữ nhưng được phân loại bằng phương pháp tìm kiếm không có trong từ điển.
 - `style` (mảng chuỗi hoặc cấu trúc) - Tạo danh sách các đặc điểm phong cách liên quan đến `word`.
   - Được bao gồm nếu cài đặt `feature_standard` được đặt thành `native` hoặc `description`.
 - `semantics` (mảng chuỗi hoặc cấu trúc) - Tạo danh sách các đặc điểm ngữ nghĩa liên quan đến `từ`. 
   - Được bao gồm nếu cài đặt `feature_standard` được đặt thành `native` hoặc `description`.
 - `segmentation` (cấu trúc) - Cung cấp thông tin về phân đoạn đã chọn. Phân đoạn là một mảng các cấu trúc từ.

   - Được bao gồm nếu có thể phân đoạn nhiều lần và cài đặt `deterministic` được đặt thành `false`.

 - `other_segmentations` (mảng cấu trúc) - Liệt kê các phân đoạn thay thế được coi là không chính xác trong quá trình phân định. Mỗi mục nhập có cùng cấu trúc như `segmentation`.
 - `nbest_senses` (mảng cấu trúc) - Cung cấp các giả thuyết giải thích thay thế. 

   - Được bao gồm nếu cài đặt `deterministic` được đặt thành `false`.

   - Mỗi giả thuyết bao gồm: 

     - `grammar`, `style` và `semantics`. Chúng có cấu trúc giống hệt với các thuộc tính tương ứng ở trên. 
     - `senses`. Liệt kê các nghĩa của từ cho giả thuyết, mỗi nghĩa chứa:
       - `family`: ID họ liên quan. 
       - `definition`: Định nghĩa của họ nếu `fetch_definitions` được bật. 
       - `ref_lemma`: Bổ đề tham chiếu, nếu có.


 Chỉ dành cho dấu chấm câu:

 - `id` (số nguyên) - ID của dấu chấm câu.

 - `behavior` (chuỗi) - Mã hành vi xác định chức năng của dấu chấm câu. Các giá trị:
   - `sentenceTerminator`
   - `genericComma`
   - `bracketStart`
   - `bracketEnd`
   - `scopeDelimiter`
   - `hyphen`
   - `quoteStart`
   - `quoteEnd`
   - `listComma` (dành cho dấu phẩy liệt kê trong các ngôn ngữ Đông Á như `、`)

Dấu câu không có nghĩa n-best.

 ### Cây phân tích cú pháp và cụm từ

Cây phân tích cú pháp, hay chính xác hơn là rừng phân tích cú pháp, là tập hợp các cụm từ theo thứ bậc được liên kết với nhau.

Phần cây phân tích cú pháp được tạo ra nếu:

* Cài đặt `parses` được đặt thành `true`.

Ở cấp độ cao nhất của cú pháp, có một mảng các cụm từ gốc được chứa trong phần tử `phrases`, mỗi cụm từ được liên kết với một `id` số. 

Mỗi cụm từ có thể có các cụm từ con, tạo thành một cấu trúc lồng nhau.

 Mỗi cụm từ bao gồm các thuộc tính sau:

 - `type` (chuỗi) - Thẻ cụm từ chuẩn biểu thị loại cụm từ. Ví dụ: `S`, `VP`, `NP`, `ADJP`, `ADVP`.
 - `family` (số nguyên) - ID của họ cụm từ.
 - `offset` (số nguyên không dấu) - Vị trí bắt đầu của trường hợp. Giá trị này bắt đầu từ số không.
 - `length` (số nguyên không dấu) - Độ dài của cụm từ.
 - `role` (chuỗi) - Vai trò ngữ nghĩa của cụm từ, nếu có, tương tự như vai trò ngữ nghĩa được gán cho từng từ riêng lẻ.
 - `text` (chuỗi) - Biểu diễn văn bản của cụm từ: Các phần của cụm từ được phân tách bằng ký tự thanh dọc (|). Cụm từ con được đặt trong dấu ngoặc đơn (). Ví dụ: 
   - _driven|by|David_ 9 (một cụm từ đơn giản với ba phần) 
   - _(The|car)|was|(driven|by|David)_ (một cấu trúc phân cấp với các cụm từ con).


 Ví dụ:

 ```json
"parse_tree": {
"id": 4,
"phrases": [
{
        "type": "S",
        "family": 1451,
        "offset": 0,
        "length": 27,
        "text": "(The|car)|was|(driven|by|David)",
        "children": [
                {
                        "type": "NP",
                        "family": 1081,
                        "offset": 0,
                        "length": 7,
                        "text": "The|car",
                        "role": "patient"
                },
                {
                        "type": "VP",
                        "family": 1172,
                        "offset": 12,
                        "length": 15,
                        "text": "driven|by|David",
                        "role": "verb"
                }
        ]
}
 ```

 ### Sửa lỗi chính tả theo ngữ cảnh

Tisane hỗ trợ sửa lỗi chính tả theo ngữ cảnh. Nó xác định và sửa lỗi chính tả hoặc lỗi cố ý làm tối nghĩa bằng cách suy ra ý nghĩa mong muốn, đặc biệt là khi mô hình ngôn ngữ không nhận dạng được một từ.

Khi thực hiện chỉnh sửa, Tisane sẽ thêm thuộc tính `corrected_text`:

 - Ở cấp độ từ: Nếu trả về từng từ riêng lẻ hoặc từng khối từ vựng.

 - Ở cấp độ câu: Nếu tạo văn bản câu. 


`corrected_text` cấp độ câu xuất hiện khi:

* Cài đặt `words` hoặc `parses` được đặt thành `true`.

####  Loại trừ các thuật ngữ hiếm

Tisane làm việc với các từ điển lớn. Bạn có thể loại trừ các thuật ngữ khó hiểu bằng cách điều chỉnh cài đặt `min_generic_frequency`.

####  Gọi Kiểm tra chính tả

Lưu ý: Kiểm tra chính tả sẽ chạy bất kể câu hay phần từ có được bao gồm trong đầu ra hay không.

Bạn có thể kiểm soát hành vi này bằng các cài đặt sau:

- Đặt `disable_spellcheck` thành `true` để tắt hoàn toàn kiểm tra chính tả.

- Để tránh sửa danh từ riêng (trong các ngôn ngữ viết hoa), hãy đặt `lowercase_spellcheck_only` thành `true`. Thao tác này hạn chế kiểm tra chính tả đối với các từ viết thường, bỏ qua các thuật ngữ viết hoa chữ cái đầu và viết hoa toàn bộ.
