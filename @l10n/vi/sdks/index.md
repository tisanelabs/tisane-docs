# Tổng quan

Tisane Embedded cho phép tích hợp trực tiếp các chức năng của Tisane vào trong ứng dụng máy tính để bàn và máy chủ, loại bỏ nhu cầu kết nối tới máy chủ từ xa. Hai thành phần chính của gói này là thư viện thời gian chạy (runtime library) và tập hợp các mô hình ngôn ngữ. 

Thư viện lõi được xây dựng dựa trên POSIX C/C++ và sử dụng RocksDB để lưu trữ các mô hình ngôn ngữ, hỗ trợ tất cả các hệ điều hành tuân thủ POSIX. Để dễ dàng tích hợp vào các ứng dụng .NET, một thành phần bao bọc Core .NET được cung cấp.

* [Tisane Embedded SDK for C/C++](./candc++.md)
* [Tisane Embedded SDK for .NET](./dotnet.md)

Để triển khai Tisane tại chỗ dưới dạng dịch vụ web riêng biệt, vui lòng xem: [Triển khai tại chỗ](../guides/deployment/onprem.md).

## Hướng dẫn Cấu hình và Phản hồi

* [Hướng dẫn cấu hình và tùy chỉnh](../apis/tisane-api-configuration.md)
* [Tham chiếu định dạng JSON phản hồi](../apis/tisane-api-response-guide.md)

