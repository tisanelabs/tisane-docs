# Triển khai tại chỗ

Dịch vụ web Tisane có thể được triển khai bên ngoài đám mây công cộng của Tisane Labs tại cơ sở của khách hàng, trong một trung tâm cuộc gọi riêng hoặc trong một đám mây riêng.

Các phương thức API trên các cài đặt tại chỗ tương tự như trong đám mây công cộng của chúng tôi. (Xem phần: [Tài liệu tham khảo về API Tisane](/apis/tisane-api-short).) Không yêu cầu tiêu đề xác thực.

Giấy phép tại chỗ được cấp theo từng trường hợp cụ thể. [Liên hệ với chúng tôi để thảo luận về các yêu cầu của bạn](https://tisane.ai/on-prem).

Để tích hợp Tisane như một thành phần trong quá trình, xem phần: [Các SDK của Tisane Embedded](/sdks)

## Yêu cầu về RAM

**Tải chậm**: 50 Mb cố định + 50 đến 100 Mb cho mỗi mô hình ngôn ngữ
**Tải đầy đủ**: từ 400 Mb đến 2 Gb cho mỗi mô hình ngôn ngữ

Đọc thêm: [Chế độ Tải chậm so với chế độ Tải đầy đủ](/sdks/lazyloading.md)

## Linux

Tisane Web Service cho Linux là một chương trình thực thi tự lưu trữ (`tisane`) chạy như một dịch vụ web, với tùy chọn là một daemon (trình nền). Nhiều phiên bản có thể chạy trên cùng một cơ sở dữ liệu ngôn ngữ, cùng một máy và sử dụng cùng một cấu hình. Mỗi phiên bản yêu cầu một cổng riêng. 

### Yêu cầu

Kernel phiên bản 6.0.0 trở lên

### Tham số dòng lệnh

**Không có tham số**

Chạy một thử nghiệm đơn giản, đưa ra kết quả và thoát.

**-port**

Khởi chạy dịch vụ đang chờ trên cổng được chỉ định với (các) tham số sau:

* *Tham số 1*: số cổng hợp lệ

**-parse**

Khởi chạy một lệnh phân tích cú pháp duy nhất và đưa ra kết quả với các tham số sau:

* *Tham số 1*: mã ngôn ngữ
* *Tham số 2*: nội dung
* *Tham số 3*: cài đặt (phải được đặt trong dấu `{}` )

**-transform**

Khởi chạy một lệnh chuyển đổi duy nhất và đưa ra kết quả với các tham số sau:

* *Tham số 1*: mã ngôn ngữ nguồn
* *Tham số 2*: (các) mã ngôn ngữ đích
* *Tham số 3*: nội dung
* *Tham số 4*: cài đặt (phải được đặt trong dấu `{}` )

**--version**

Đưa ra phiên bản thời gian chạy.

### Cấu hình

Các tệp cấu hình Linux của Tisane sử dụng [định dạng TOML](https://en.wikipedia.org/wiki/TOML). Tất cả các cài đặt đều nằm trong phần *\[main\]*. Các cài đặt gồm:

* *path* (chuỗi, bắt buộc) - thư mục chứa các tệp dữ liệu Tisane. Có thể dùng đường dẫn tương đối, nếu nó nằm trong cùng một thư mục, `./` hợp lệ.
* *preload* (mảng chuỗi, tùy chọn) - các mã ngôn ngữ sẽ tải đầy đủ khi khởi động. Phần còn lại sẽ sử dụng chế độ tải chậm (tải theo yêu cầu). Bạn chỉ nên tải trước không quá một hoặc hai mô hình ngôn ngữ, trừ trường hợp môi trường có nhiều ngôn ngữ được sử dụng thường xuyên. Đọc thêm phần: [Chế độ Tải chậm so với chế độ Tải đầy đủ](/sdks/lazyloading.md)
* *daemon* (boolean, tùy chọn) - nếu có giá trị *true*, Tisane sẽ được khởi chạy như một daemon (dịch vụ). 
* *limit* (số nguyên, tùy chọn) - độ dài tối đa của yêu cầu tính bằng byte.

Ví dụ:

```bash
[main]
path = "./"
preload = ["en", "es"]
daemon = true
```

{% admonition type="warning" %}

Không sử dụng tùy chọn `daemon` khi sử dụng Docker.

{% /admonition %}

### Cài đặt

Khi bắt đầu với tham số `-port` được chỉ định, `tisane` sẽ chấp nhận và phản hồi các yêu cầu HTTP. Để cài đặt, chỉ cần đảm bảo tệp thực thi được khởi chạy khi hệ thống khởi động. Cách đơn giản nhất là sử dụng bộ `systemd`.

Chúng tôi cung cấp một tập lệnh Bash để cấu hình `systemd` để khởi chạy nhiều phiên bản của Tisane Web Service: [install.sh](/guides/sourcecode/install.sh)

Các tập lệnh Bash hỗ trợ khác:

* dừng tất cả các phiên bản đang chạy của Tisane: [stop.sh](/guides/sourcecode/stop.sh)
* bắt đầu các phiên bản Tisane được quản lý bởi `systemd`: [startall.sh](/guides/sourcecode/startall.sh)

#### Các tham số install.sh
Tham số
- -f : Đường dẫn đến tệp zip tisane (cài đặt hoặc cập nhật gói)
- -p : Danh sách các cổng được phân tách bằng dấu phẩy nơi bạn muốn bắt đầu dịch vụ
- -d : Nếu bạn không muốn chạy tisane như một daemon, hãy đặt tham số này thành "simple" và cập nhật tệp cấu hình của bạn. (Đề xuất không thay đổi tham số này, mặc định là fork cho daemon)
- -u : Nếu sử dụng tùy chọn này, nó sẽ cố gắng cài đặt tisane bằng cách xóa tất cả các tệp cũ hơn và dừng tất cả các dịch vụ đang chạy

### Cập nhật

Để cập nhật:

1. Tắt mọi phiên bản Tisane đang chạy được kết nối với cơ sở dữ liệu ngôn ngữ đích.
2. Triển khai bản cập nhật.
3. Khởi chạy lại các phiên bản.

{% admonition type="info" %}

Các tập lệnh Bash hỗ trợ phân phối và giám sát được cung cấp theo yêu cầu.

{% /admonition %}

## Windows

Tisane Runtime là ứng dụng dịch vụ ASP.NET của Windows. Tisane Runtime chỉ chạy dưới dạng dịch vụ. Nhiều phiên bản có thể chạy trên cùng một máy ở các cổng khác nhau. 

Sau khi cài đặt, có thể truy cập các phiên bản trong bảng điều khiển quản lý Dịch vụ Windows như được hiển thị trên ảnh chụp màn hình bên dưới.

![Tisane Windows services](/guides/images/tisaneWindowsServices.png)

Tisane Runtime tự lưu trữ và không yêu cầu máy chủ web bên ngoài (không cần IIS, Apache, nginx, v.v.).

### Yêu cầu

ASP.NET Core Runtime 8 trở lên

[Download .NET 8.0](https://dotnet.microsoft.com/en-us/download/dotnet/8.0) (.NET Runtime package is required as well)

### Cài đặt

1. Đảm bảo đã cài đặt ASP.NET Code 8 và .NET Runtime 8 trở lên.
2. Tạo một thư mục trên máy chủ (ví dụ: `C:\Tisane`).
3. Tạo một thư mục con cho các tệp nhị phân (ví dụ: `C:\Tisane\bin`).
4. Sao chép các tệp nhị phân Tisane và tệp cấu hình (`Tisane.Runtime.Service.dll.config`) vào (các) thư mục con có thể thực thi. Đừng quên thư mục con `native` cho các thư viện RocksDB. Không giống như phiên bản Linux, mỗi phiên bản phải có thư mục riêng vì chúng tôi dựa vào tệp cấu hình để thiết lập cổng mà dịch vụ sẽ chạy.
5. Chạy `Tisane.Runtime.Service.exe -i` để cài đặt.
6. Sao chép các mô hình ngôn ngữ vào thư mục được chỉ định trong cấu hình (ví dụ: `C:\Tisane` hoặc `C:\Tisane\db`).

#### Tham số dòng lệnh

* `-i` - cài đặt một dịch vụ mới cho các tệp nhị phân trong thư mục hiện tại
* `-u` - gỡ cài đặt dịch vụ được liên kết với thư mục hiện tại
* `-r` - cài đặt lại dịch vụ được liên kết với thư mục hiện tại

### Cấu hình

Tệp cấu hình (`Tisane.Runtime.Service.dll.config`) là tệp định dạng Trình quản lý cấu hình (XML) chuẩn chứa các cài đặt được dịch vụ Tisane sử dụng trong phần `appSettings` của dịch vụ:

* `DbPath` - (bắt buộc) một thư mục chứa các tệp dữ liệu Tisane. Đường dẫn tuyệt đối phải kết thúc bằng `\` hoặc `/`.
* `Port` - (bắt buộc) một cổng để chạy dịch vụ. Phải là cổng chưa được sử dụng.
* `PreloadLanguages` - danh sách mã ngôn ngữ phân cách bằng dấu phẩy sẽ tải đầy đủ khi khởi động. Phần còn lại sẽ sử dụng chế độ tải chậm (tải theo yêu cầu). Bạn chỉ nên tải trước không quá một hoặc hai mô hình ngôn ngữ, trừ trường hợp môi trường có nhiều ngôn ngữ được sử dụng thường xuyên. Đọc thêm phần: [Chế độ Tải chậm so với chế độ Tải đầy đủ](/sdks/lazyloading.md)

Ví dụ 

```xml
<?xml version="1.0" encoding="utf-8" ?>
<configuration>
  <appSettings>
      <add key="DbPath" value="C:\Tisane\" />
      <add key="Port" value="3780" /> <!-- run on port 3780 -->
      <add key="PreloadLanguages" value="en,fr" /> <!-- preload English and French -->
   </appSettings>
</configuration>
```

### Cập nhật

1. Tắt tất cả dịch vụ Tisane. Đảm bảo không có ứng dụng bên ngoài nào truy cập vào các tệp dữ liệu và tệp nhị phân của Tisane.
2. Sao chép các tệp Tisane mới đè lên các tệp hiện có. 
3. Khởi chạy lại dịch vụ.

{% admonition type="warning" %}

Đảm bảo bạn **không ghi đè lên tệp cấu hình hiện có**.

{% /admonition %}

## Thực hành được khuyến nghị

Tisane là luồng an toàn, do đó nhiều người gọi có thể kết nối tới cùng một phiên bản. Khi nhiều mô hình ngôn ngữ được tải, việc giữ số lượng phiên bản ở mức thấp sẽ hữu ích. Tuy nhiên, nên giữ số lượng yêu cầu đồng thời ở mức hợp lý.

Theo kinh nghiệm của chúng tôi, trạng thái cân bằng tốt nhất là 3 phiên bản cho một máy 4 lõi 8 Gb.

