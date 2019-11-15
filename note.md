# User Interface

## 1. Widget
- Flutter sử dụng widget lấy ý tưởng từ React tương tự component.
- Gồm 2 loại cơ bản 
    - visible widget: hiển thị
    - layout widget: để bố trí giao diện
- Tất cả các layout widget đều chứa thuộc tính `con` để xây dựng layout:
    - child: Nếu nó chỉ nhận 1 widget con - Center, container
    - children: Nếu nó có thể nhận nhiều widget con - Row, Column, ListView, Stack.
- Một widget là 1 stateful hoặc stateless.
    - stateful: Người dùng có thể tương tác là widget thay đổi.
    - stateless: Widget ko thay đổi.
- `Key`:  Mọi Widget đều độc lập. Lí do là vì Widget không thể tự vẽ lại bản thân. Để thực hiện điều này ta cần thông báo cho Element. Cách dễ nhất để có thể dễ dàng thông báo cho Element là làm bẩn (dirty) instance tương ứng dẫn đến Widget Tree được vẽ lại. Widget Tree được vẽ lại thì instance của Widget cũ sẽ không còn. Trong một vài trường hợp cần phải tìm lại giá trị của Widget tại vị trí được vẽ lại, ta sử dụng key làm chìa khóa cho vấn đề này.
### Basic Widget
1. Text: tạo và cusome style các đoạn text
2. Row, Column: tạo layout linh hoạt theo row và column.
3. Stack: thay vì các widget được sắp xếp theo 1 mặt phẳng. stack giúp chúng có thể sếp chồng lên nhau.
4. Container: widget cho phép customize các widget con. thêm margin, padding, border, background color

## 2. Layout

- Layout trong flutter được xây dựng bởi widget
- Trong flutter tất cả mọi thứ đều là widgets
`Node`: Để hiển thị giao diện phát triển trong flutter
   ```
        import 'package:flutter/rendering.dart';

        void main() {
            debugPaintSizeEnabled = true;
            runApp(MyApp());
        }
   ```
- Mỗi app Flutter chính là 1 widget, hầu hết widget sẽ chứa phương thức `build()`.

### Row, Column
- Aligning widgets: Căn chỉnh trong layout bằng cách sử dung mainAxisAlignment theo chiều ngang và crossAxisAlignment theo chiều dọc.
- Sizing widgets: chỉnh layout vừa với device bằng Expanded.
- Packing widgets: Thông thường Row và Column ko có giới hạn theo chiều ngang và dọc. Packing widget được sử dụng để chỉ định kích thước cho nó. mainAxisSize: MainAxisSize.min chỉnh kích thước vừa khit với nội dung bên trong.
- Common layout widgets: Layout common có 2 loại thường dùng:
    - Standard widgets: tiêu chuẩn 
        - Container: Thêm padding, margins, borders, background color, ...
        - GridView: Hiển thị dạng lưới có thể scroll.
        - ListView: Hiển thị dạng danh sách có thể scroll.
        - Stack:Hiển thị các layout đè lên nhau.
    - Material widgets. Từ thư viện Material
        - Card:
        - ListTitle:

### Responsive
Có 2 cách cơ bản tạo responsive:
- Sử dụng class LayoutBuilder
- Sử dụng hàm MediaQuery.of()

## 3. State
Có 3 cách để quản lý state tùy theo mục địch:
- Widget tự quản lý state của nó.
- Widget cha sẽ quản lý state
- Kết hợp

`Có 2 loại state:`
- ephemeral state (UI state hoặc local state): 
    - là state chỉ nằm trong 1 widget
    - state khá dễ quản lý, không cẩn quan tâm tới phạm vi state và dễ thao tác thay đổi state.
- app state: là những state được chia sẽ trên nhiều thành phần của app(ex: thông tin người dùng đăng nhập, giỏ hàng, ...)

**State không có quy tắc rõ ràng để phân biệt 2 lại trên**

`Các cách quản lý state`
- setState()
- InheritedWidget & InheritedModel
- BLoC Architecture (gg kkhuyên dùng): quản lý bởi stream, tách biệt với logic. mô hình MVVM
- MobX
- Scoped Model
- Redux

## 4. Navigation and routing
