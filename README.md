# Ứng dụng Quản lý Danh bạ (Contact List App)

Ứng dụng quản lý danh bạ đơn giản được phát triển bằng Flutter, sử dụng kiến trúc BLoC để quản lý trạng thái và lưu trữ dữ liệu cục bộ với SQLite.

### Tính năng chính

* **Quản lý danh bạ:** Thêm, sửa, xóa, và hiển thị thông tin liên hệ.

* **Quản lý người dùng:** Đăng nhập và duy trì trạng thái đăng nhập.

* **Lưu trữ cục bộ:** Dữ liệu người dùng và danh bạ được lưu an toàn trên thiết bị.

### Thư viện sử dụng

Dự án này sử dụng các thư viện sau để xây dựng các chức năng chính:

* `sqflite: ^2.4.2`
  Lưu trữ dữ liệu cục bộ trên thiết bị (SQLite), được dùng để lưu thông tin người dùng và danh bạ.

* `flutter_bloc: ^9.1.1`
  Quản lý trạng thái ứng dụng theo kiến trúc BLoC cho các module như login, logout, và danh bạ.

* `get_it: ^8.2.0`
  Thư viện dependency injection, giúp khởi tạo và quản lý các repository hoặc service một cách hiệu quả.

* `shared_preferences: ^2.5.3`
  Lưu trạng thái đăng nhập của người dùng, giúp họ không phải đăng nhập lại mỗi khi mở ứng dụng.

* `font_awesome_flutter: ^10.9.1`
  Cung cấp một bộ sưu tập các icon đẹp từ Font Awesome để trang trí giao diện.

* `path: ^1.9.1`
  Hỗ trợ xử lý các đường dẫn file, cần thiết cho việc khởi tạo database.

### Cấu trúc thư mục

Dự án được tổ chức theo cấu trúc sau để đảm bảo tính dễ đọc và dễ bảo trì:
lib/
├─ domain/
│ ├─ entities/ # Các model đối tượng như User và Contact
│ ├─ repositories/ # Các interface repository (định nghĩa các phương thức)
├─ data/
│ ├─ datasources/ # Local data source (sqflite)
│ ├─ models/ # Các data model cho sqflite
│ └─ repositories/ # Triển khai các repository
├─ presentation/
│ ├─ pages/ # Các trang UI (LoginPage, ContactPage, RootPage)
│ ├─ blocs/ # BLoC và các file Event/State tương ứng
└─ utils/
└─ email_session.dart # Lưu trạng thái đăng nhập
### Hướng dẫn cài đặt và chạy

Để chạy ứng dụng trên máy của bạn, hãy làm theo các bước sau:

1. **Clone code về máy** 
2. **Tạo project Flutter trong thư mục hiện tại**
flutter create .
3. **Cấu hình Android NDK** Mở file `android/app/build.gradle.kts` và thay đổi `ndkVersion` như sau: ndkVersion = "27.0.12077973"
4. **Cài đặt dependencies và chạy app**
flutter pub get
flutter run