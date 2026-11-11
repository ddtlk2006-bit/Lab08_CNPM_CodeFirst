# BÁO CÁO BÀI TẬP THỰC HÀNH - LAB 08
## MÔN: CÔNG NGHỆ PHẦN MỀM / KỸ THUẬT PHẦN MỀM (SOFTWARE ENGINEERING)
### CHỦ ĐỀ: ASP.NET CORE VỚI RAZOR PAGES & MVC - TIẾP CẬN CODE-FIRST VỚI ENTITY FRAMEWORK CORE

---

**THÔNG TIN SINH VIÊN:**
- **Họ và tên:** `[Dau Dinh Thang]`
- **Mã số sinh viên (MSSV):** `[524h0190]`
- **Lớp:** `[24H50303]`
- **Giảng viên hướng dẫn:** TS. Phạm Thái Kỳ Trung
- **Link GitHub Repository:** `[Dán link GitHub repo tại đây, ví dụ: https://github.com/username/Lab08_ASPNetCore_CodeFirst]`

---

## MỤC LỤC (BOOKMARKS)
- [1. Giới thiệu (Introduction)](#1-giới-thiệu-introduction)
- [2. Bài tập 1: Xây dựng SchoolApp bằng ASP.NET Core Razor Pages (Exercise 1)](#2-bài-tập-1-xây-dựng-schoolapp-bằng-aspnet-core-razor-pages-exercise-1)
  - [2.1. Cấu hình môi trường và cài đặt Package](#21-cấu-hình-môi-trường-và-cài-đặt-package)
  - [2.2. Chỉnh sửa thanh điều hướng trong _Layout.cshtml](#22-chỉnh-sửa-thanh-điều-hướng-trong-_layoutcshtml)
  - [2.3. Định nghĩa các Data Models](#23-định-nghĩa-các-data-models)
  - [2.4. Tạo DbContext (SchoolContext)](#24-tạo-dbcontext-schoolcontext)
  - [2.5. Cấu hình chuỗi kết nối và Program.cs](#25-cấu-hình-chuỗi-kết-nối-và-programcs)
  - [2.6. Khởi tạo Migration và Cập nhật Database](#26-khởi-tạo-migration-và-cập-nhật-database)
  - [2.7. Tạo các trang Razor Pages (CRUD Scaffolding)](#27-tạo-các-trang-razor-pages-crud-scaffolding)
  - [2.8. Tùy biến Dropdown hiển thị Mã và Tên Khoa (Amend Web Form)](#28-tùy-biến-dropdown-hiển-thị-mã-và-tên-khoa-amend-web-form)
  - [2.9. Kiểm thử và Ảnh chụp kết quả (Screenshots Exercise 1)](#29-kiểm-thử-và-ảnh-chụp-kết-quả-screenshots-exercise-1)
- [3. Bài tập 2: Xây dựng SchoolApp bằng ASP.NET Core MVC (Exercise 2)](#3-bài-tập-2-xây-dựng-schoolapp-bằng-aspnet-core-mvc-exercise-2)
  - [3.1. Cấu hình môi trường MVC và Package](#31-cấu-hình-môi-trường-mvc-và-package)
  - [3.2. Chỉnh sửa Menu điều hướng trong Views/Shared/_Layout.cshtml](#32-chỉnh-sửa-menu-điều-hướng-trong-viewsshared_layoutcshtml)
  - [3.3. Xây dựng Data Models và SchoolContext](#33-xây-dựng-data-models-và-schoolcontext)
  - [3.4. Cấu hình Program.cs và Connection String](#34-cấu-hình-programcs-và-connection-string)
  - [3.5. Migration và Database Schema](#35-migration-và-database-schema)
  - [3.6. Xây dựng Controllers và Razor Views (CRUD)](#36-xây-dựng-controllers-và-razor-views-crud)
  - [3.7. Kiểm thử và Ảnh chụp kết quả (Screenshots Exercise 2)](#37-kiểm-thử-và-ảnh-chụp-kết-quả-screenshots-exercise-2)
- [4. So sánh chuyên sâu: ASP.NET Core Razor Pages vs ASP.NET Core MVC](#4-so-sánh-chuyên-sâu-aspnet-core-razor-pages-vs-aspnet-core-mvc)
  - [4.1. Cấu trúc Project (Project Structure)](#41-cấu-trúc-project-project-structure)
  - [4.2. Đặc điểm ASP.NET Core Razor Pages](#42-đặc-điểm-aspnet-core-razor-pages)
  - [4.3. Đặc điểm ASP.NET Core MVC](#43-đặc-điểm-aspnet-core-mvc)
  - [4.4. Bảng tổng hợp so sánh (Comparison Matrix)](#44-bảng-tổng-hợp-so-sánh-comparison-matrix)
  - [4.5. Kịch bản ứng dụng thực tế (Example Scenarios)](#45-kịch-bản-ứng-dụng-thực-tế-example-scenarios)
- [5. Bài tập 3: Tổ chức Project và Tải lên GitHub (Exercise 3)](#5-bài-tập-3-tổ-chức-project-và-tải-lên-github-exercise-3)
- [6. Script cơ sở dữ liệu (SchoolDB.sql)](#6-script-cơ-sở-dữ-liệu-schooldbsql)
- [7. Kết luận và Bài học kinh nghiệm (Conclusion)](#7-kết-luận-và-bài-học-kinh-nghiệm-conclusion)
- [8. Phụ lục (Appendix): Link GitHub](#8-phụ-lục-appendix-link-github)

---

## 1. GIỚI THIỆU (INTRODUCTION)
Mục tiêu của bài thực hành Lab 8 là làm chủ phương pháp tiếp cận **Code-First** với **Entity Framework Core (EF Core)** trong môi trường phát triển ứng dụng web trên nền tảng **ASP.NET Core (.NET 8)**.

Phương pháp **Code-First** cho phép lập trình viên định nghĩa cấu trúc cơ sở dữ liệu hoàn toàn bằng các lớp C# (POCO Classes/Entities) và DbContext. Sau đó, công cụ EF Core Migrations sẽ tự động phân tích mô hình quan hệ dữ liệu và phát sinh mã tạo bảng, khóa chính, khóa ngoại, chỉ mục cũng như áp dụng trực tiếp xuống hệ quản trị cơ sở dữ liệu Microsoft SQL Server mà không cần viết các câu lệnh DDL SQL thủ công.

Bài thực hành bao gồm 2 kiến trúc web phổ biến trong hệ sinh thái ASP.NET Core:
1. **ASP.NET Core Razor Pages**: Mô hình hướng trang (Page-Centric Model), thích hợp cho việc phát triển nhanh chóng các trang biểu mẫu nghiệp vụ, thao tác CRUD trực tiếp với cấu trúc file `.cshtml` và `.cshtml.cs` gắn kết chặt chẽ.
2. **ASP.NET Core MVC (Model - View - Controller)**: Mô hình truyền thống phân tách nghiêm ngặt giữa dữ liệu (Model), giao diện hiển thị (View) và điều khiển xử lý logic yêu cầu (Controller), tối ưu cho các hệ thống phức tạp và kiểm thử tự động.

---

## 2. BÀI TẬP 1: XÂY DỰNG SCHOOLAPP BẰNG ASP.NET CORE RAZOR PAGES (EXERCISE 1)

### 2.1. Cấu hình môi trường và cài đặt Package
- **Tên project:** `SchoolAppCoreRazor` (nằm trong thư mục `Exercise1_RazorPages`).
- **Template:** ASP.NET Core Web App (Razor Pages) trên nền .NET 8.0.
- **Packages đã cài đặt:**
  - `Microsoft.EntityFrameworkCore.SqlServer` (phiên bản 8.0.x): Cung cấp Database Provider để EF Core kết nối và làm việc với Microsoft SQL Server.
  - `Microsoft.EntityFrameworkCore.Tools` (phiên bản 8.0.x): Cung cấp các lệnh trong Package Manager Console như `Add-Migration`, `Update-Database`.

### 2.2. Chỉnh sửa thanh điều hướng trong `_Layout.cshtml`
Tệp: `Exercise1_RazorPages/SchoolAppCoreRazor/Pages/Shared/_Layout.cshtml`
Cập nhật thanh menu với các liên kết tương ứng:
- **Home**: `asp-page="/Index"`
- **Students**: `asp-page="/Students/Index"`
- **Courses**: `asp-page="/Courses/Index"`
- **Instructors**: `asp-page="/Instructors/Index"`
- **Enrollments**: `asp-page="/Enrollments/Index"`
- **Departments**: `asp-page="/Departments/Index"`

### 2.3. Định nghĩa các Data Models
Tất cả các thực thể được đặt trong thư mục `Models/` với namespace `SchoolAppCoreRazor.Models`:
1. **Department.cs**: Đại diện cho khoa/phòng ban.
   - `DepartmentID` (int, PK)
   - `DepartmentName` (string, required)
   - `Budget` (decimal)
   - `StartDate` (DateTime)
   - `ICollection<Course>? Courses` (Navigation property)
2. **Course.cs**: Đại diện cho môn học.
   - `CourseID` (int, PK)
   - `Title` (string, required)
   - `Credits` (int)
   - `DepartmentID` (int, FK tham chiếu Department)
   - `Department? Department` (Navigation property)
   - `ICollection<Enrollment>? Enrollments` (Navigation property)
3. **Instructor.cs**: Đại diện cho giảng viên.
   - `InstructorID` (int, PK)
   - `LastName` (string, required)
   - `FirstName` (string, required)
   - `HireDate` (DateTime)
4. **Student.cs**: Đại diện cho sinh viên.
   - `StudentID` (int, PK)
   - `LastName` (string, required)
   - `FirstName` (string, required)
   - `EnrollmentDate` (DateTime)
   - `ICollection<Enrollment>? Enrollments` (Navigation property)
5. **Enrollment.cs**: Bảng liên kết sinh viên đăng ký môn học và lưu điểm số.
   - `EnrollmentID` (int, PK)
   - `CourseID` (int, FK)
   - `StudentID` (int, FK)
   - `Grade` (decimal)
   - `Course? Course`
   - `Student? Student`
6. **ErrorViewModel.cs**: Quản lý thông tin lỗi xử lý request.

### 2.4. Tạo DbContext (SchoolContext)
Tệp: `Exercise1_RazorPages/SchoolAppCoreRazor/Models/SchoolContext.cs`
Kế thừa từ `DbContext` và khai báo các `DbSet`:
- `DbSet<Department> Departments { get; set; }`
- `DbSet<Instructor> Instructors { get; set; }`
- `DbSet<Course> Courses { get; set; }`
- `DbSet<Student> Students { get; set; }`
- `DbSet<Enrollment> Enrollments { get; set; }`

### 2.5. Cấu hình chuỗi kết nối và Program.cs
- Trong `appsettings.json`:
  ```json
  "ConnectionStrings": {
    "SchoolDBConnectionString": "Server=(local)\\SQLEXPRESS;Database=SchoolDB;Trusted_Connection=True;TrustServerCertificate=True"
  }
  ```
- Trong `Program.cs`:
  Đăng ký `SchoolContext` vào Dependency Injection Container:
  ```csharp
  builder.Services.AddDbContext<SchoolContext>(options =>
      options.UseSqlServer(builder.Configuration.GetConnectionString("SchoolDBConnectionString")));
  ```

### 2.6. Khởi tạo Migration và Cập nhật Database
Thực hiện trong Package Manager Console:
```powershell
Add-Migration InitialCreate
Update-Database
```
Tạo ra thư mục `Migrations/` với tệp `20250429100129_InitialCreate.cs` và `SchoolContextModelSnapshot.cs`.

### 2.7. Tạo các trang Razor Pages (CRUD Scaffolding)
Xây dựng đầy đủ 5 phân hệ CRUD trong thư mục `Pages/`:
- `Pages/Departments/`: `Index`, `Create`, `Edit`, `Details`, `Delete`
- `Pages/Courses/`: `Index`, `Create`, `Edit`, `Details`, `Delete`
- `Pages/Instructors/`: `Index`, `Create`, `Edit`, `Details`, `Delete`
- `Pages/Students/`: `Index`, `Create`, `Edit`, `Details`, `Delete`
- `Pages/Enrollments/`: `Index`, `Create`, `Edit`, `Details`, `Delete`

### 2.8. Tùy biến Dropdown hiển thị Mã và Tên Khoa (Amend Web Form)
Theo yêu cầu tại trang 9 & 10 của tài liệu: Mặc định dropdown chỉ hiển thị `DepartmentID`, gây khó khăn cho người dùng. 
Đã cập nhật logic trong `Courses/Create.cshtml.cs` và `Courses/Edit.cshtml.cs`:
```csharp
ViewData["DepartmentID"] = new SelectList(
    _context.Departments.Select(d => new
    {
        d.DepartmentID,
        DisplayText = d.DepartmentID + " - " + d.DepartmentName
    }),
    "DepartmentID",
    "DisplayText"
);
```
Kết quả: Dropdown hiển thị rõ ràng, trực quan định dạng: `1 - Computer Science`, `2 - Information Systems`,...

### 2.9. Kiểm thử và Ảnh chụp kết quả (Screenshots Exercise 1)
*(Hướng dẫn sinh viên chụp ảnh minh chứng đưa vào báo cáo hoàn chỉnh)*:
- **Hình 1.1:** Cửa sổ Package Manager Console thực thi lệnh `Add-Migration InitialCreate` thành công.
- **Hình 1.2:** Cửa sổ Package Manager Console thực thi lệnh `Update-Database` tạo cơ sở dữ liệu `SchoolDB`.
- **Hình 1.3:** Cây thư mục Solution Explorer của project `SchoolAppCoreRazor`.
- **Hình 1.4:** Trang danh sách Khoa `/Departments` sau khi khởi chạy ứng dụng (F5).
- **Hình 1.5:** Trang tạo mới Môn học `/Courses/Create` với dropdown kết hợp `DepartmentID - DepartmentName`.
- **Hình 1.6:** Trang danh sách Sinh viên `/Students` và Giảng viên `/Instructors`.

---

## 3. BÀI TẬP 2: XÂY DỰNG SCHOOLAPP BẰNG ASP.NET CORE MVC (EXERCISE 2)

### 3.1. Cấu hình môi trường MVC và Package
- **Tên project:** `SchoolAppCoreMVC` (nằm trong thư mục `Exercise2_MVC`).
- **Template:** ASP.NET Core Web App (Model-View-Controller) trên nền .NET 8.0.
- **Packages:** `Microsoft.EntityFrameworkCore.SqlServer`, `Microsoft.EntityFrameworkCore.Tools`.

### 3.2. Chỉnh sửa Menu điều hướng trong `Views/Shared/_Layout.cshtml`
Cập nhật thanh menu sử dụng Tag Helpers dạng MVC (`asp-controller` và `asp-action`):
- `Home`: `asp-controller="Home" asp-action="Index"`
- `Students`: `asp-controller="Students" asp-action="Index"`
- `Courses`: `asp-controller="Courses" asp-action="Index"`
- `Instructors`: `asp-controller="Instructors" asp-action="Index"`
- `Enrollments`: `asp-controller="Enrollments" asp-action="Index"`
- `Departments`: `asp-controller="Departments" asp-action="Index"`

### 3.3. Xây dựng Data Models và SchoolContext
Sử dụng cùng cấu trúc Data Models, với namespace `SchoolAppCoreMVC.Models`:
- `Department.cs`, `Course.cs`, `Instructor.cs`, `Student.cs`, `Enrollment.cs`, `ErrorViewModel.cs`
- `SchoolContext.cs` kế thừa `DbContext` quản lý các DbSet thực thể.

### 3.4. Cấu hình Program.cs và Connection String
- Trong `appsettings.json`: Cấu hình chuỗi kết nối `SchoolDBConnectionString`.
- Trong `Program.cs`:
  ```csharp
  builder.Services.AddControllersWithViews();
  builder.Services.AddDbContext<SchoolContext>(options =>
      options.UseSqlServer(builder.Configuration.GetConnectionString("SchoolDBConnectionString")));
  ```

### 3.5. Migration và Database Schema
Tạo migration cho MVC project:
```powershell
Add-Migration InitialCreate
Update-Database
```
Tạo các tệp `Migrations/20250430021132_InitialCreate.cs` và `SchoolContextModelSnapshot.cs`.

### 3.6. Xây dựng Controllers và Razor Views (CRUD)
Đã triển khai đầy đủ 5 Controllers trong thư mục `Controllers/` và các Views tương ứng trong `Views/`:
1. `DepartmentsController.cs` & `Views/Departments/` (`Index`, `Create`, `Edit`, `Details`, `Delete`)
2. `CoursesController.cs` & `Views/Courses/` (`Index`, `Create`, `Edit`, `Details`, `Delete`)
3. `InstructorsController.cs` & `Views/Instructors/` (`Index`, `Create`, `Edit`, `Details`, `Delete`)
4. `StudentsController.cs` & `Views/Students/` (`Index`, `Create`, `Edit`, `Details`, `Delete`)
5. `EnrollmentsController.cs` & `Views/Enrollments/` (`Index`, `Create`, `Edit`, `Details`, `Delete`)

Đảm bảo giữ nguyên thanh điều hướng menu chính khi duyệt các trang bằng cách đặt đúng tiêu đề:
```csharp
@{
    ViewData["Title"] = "Departments"; // hoặc Courses, Students...
}
```

### 3.7. Kiểm thử và Ảnh chụp kết quả (Screenshots Exercise 2)
- **Hình 2.1:** Solution Explorer hiển thị cấu trúc MVC chuẩn (`Controllers/`, `Models/`, `Views/`).
- **Hình 2.2:** Cửa sổ SSMS hiển thị database `SchoolDB` với đầy đủ các bảng đã sinh tự động.
- **Hình 2.3:** Giao diện trang `/Departments` trên trình duyệt sau khi nhấn F5.
- **Hình 2.4:** Giao diện trang `/Courses` hiển thị thông tin môn học và tên khoa.
- **Hình 2.5:** Giao diện tạo sinh viên `/Students/Create` và đăng ký môn học `/Enrollments/Create`.

---

## 4. SO SÁNH CHUYÊN SÂU: ASP.NET CORE RAZOR PAGES VS ASP.NET CORE MVC

Dựa trên nội dung nghiên cứu và trang 20–22 của tài liệu thực hành Lab 8:

### 4.1. Cấu trúc Project (Project Structure)
- **Razor Pages**: Tổ chức thư mục theo hướng trang (`Pages/`). Mỗi chức năng thường nằm gọn trong một file giao diện `.cshtml` và một file code-behind đi kèm `.cshtml.cs` (PageModel). Mọi logic liên quan đến một trang duy nhất được nhóm lại một nơi.
- **MVC**: Tổ chức theo 3 tầng riêng biệt: `Controllers/`, `Models/`, và `Views/`. Khi xử lý một chức năng, lập trình viên phải chuyển đổi qua lại giữa thư mục Controller và thư mục View tương ứng.

### 4.2. Đặc điểm ASP.NET Core Razor Pages
- **Cấu trúc:**
  - Page Model (`.cshtml.cs`): Chứa logic xử lý của trang, các phương thức handler (`OnGet`, `OnPost`, `OnGetAsync`,...) và binding thuộc tính (`[BindProperty]`).
  - Razor Page (`.cshtml`): Chứa mã markup HTML và cú pháp Razor hiển thị dữ liệu.
- **Trường hợp sử dụng (Use Cases):**
  - Các ứng dụng điều hướng dựa trên trang đơn giản hoặc vừa.
  - Dự án cần tốc độ phát triển nhanh (Rapid Application Development).
  - Các hệ thống quản trị, biểu mẫu CRUD nội bộ.
- **Ưu điểm (Benefits):**
  - Đơn giản, trực quan, giảm thiểu lượng code thừa (boilerplate code).
  - Tích hợp chặt chẽ giữa Page Model và View, dễ quản trị theo từng màn hình nghiệp vụ.
  - Tốc độ xây dựng các màn hình CRUD rất nhanh.
- **Nhược điểm (Drawbacks):**
  - Khả năng tùy biến cấu trúc URL và cơ chế định tuyến (routing) không linh hoạt bằng MVC.
  - Ít phù hợp hơn cho các ứng dụng quy mô cực lớn có luồng nghiệp vụ tương tác phức tạp hoặc yêu cầu tái sử dụng view mạnh mẽ.

### 4.3. Đặc điểm ASP.NET Core MVC
- **Cấu trúc:**
  - **Controllers:** Nhận và xử lý request của người dùng, tương tác với Model để lấy hoặc cập nhật dữ liệu, sau đó lựa chọn View thích hợp để phản hồi.
  - **Views:** Hiển thị dữ liệu nhận được từ Controller thông qua ViewModel hoặc ViewData/ViewBag.
  - **Models:** Đại diện cho dữ liệu, thực thể nghiệp vụ và quy tắc xác thực (Business Validation Logic).
- **Trường hợp sử dụng (Use Cases):**
  - Ứng dụng quy mô lớn, tương tác phức tạp, một Controller có thể điều phối trả về nhiều dạng View khác nhau.
  - Dự án đòi hỏi phân tách trách nhiệm (Separation of Concerns) khắt khe giữa các nhóm lập trình (Frontend vs Backend).
  - Ứng dụng cần cấu hình định tuyến phong phú và can thiệp sâu vào URL (Action Filters, Custom Routes).
- **Ưu điểm (Benefits):**
  - Phân tách trách nhiệm rõ ràng (Separation of Concerns).
  - Khả năng kiểm thử đơn vị (Unit Testing) vượt trội do Controller và Model độc lập hoàn toàn với tầng giao diện.
  - Kiểm soát tối đa cấu trúc HTML và luồng điều hướng URL.
- **Nhược điểm (Drawbacks):**
  - Độ phức tạp cao hơn khi thiết lập và cấu hình dự án.
  - Lượng boilerplate code nhiều hơn; quản lý nhiều file rải rác giữa các thư mục Controllers và Views.

### 4.4. Bảng tổng hợp so sánh (Comparison Matrix)

| Tiêu chí so sánh | ASP.NET Core MVC | ASP.NET Core Razor Pages |
| :--- | :--- | :--- |
| **Cấu trúc (Structure)** | Phân tách theo `Controllers`, `Views`, `Models` | Ghép cặp theo trang: `Page Model (.cshtml.cs)` và `Razor Page (.cshtml)` |
| **Mô hình kiến trúc** | Controller-Centric (Action-oriented) | Page-Centric (Page-oriented) |
| **Cơ chế Request** | URL ánh xạ tới Controller / Action method | URL ánh xạ trực tiếp tới đường dẫn file trong thư mục `Pages/` |
| **Độ phức tạp (Complexity)** | Cao hơn, nhiều cấu hình và lớp trừu tượng | Đơn giản, dễ tiếp cận, ít tốn thời gian thiết lập ban đầu |
| **Mức độ phân tách (SoC)** | Phân tách nghiêm ngặt 3 tầng | Gắn kết logic xử lý và hiển thị của từng trang |
| **Khả năng kiểm thử (Testing)** | Rất dễ viết Unit Test cho Controller độc lập | Kiểm thử PageModel cần mock môi trường PageContext |
| **Định tuyến (Routing)** | Linh hoạt cao (Attribute Routing, Conventional Routing) | Định tuyến mặc định theo cây thư mục (File-based Routing) |
| **Ứng dụng phù hợp** | Hệ thống lớn, Enterprise, E-Commerce, CMS đa người dùng | Biểu mẫu nghiệp vụ, Dashboard nội bộ, Web quản lý CRUD |

### 4.5. Kịch bản ứng dụng thực tế (Example Scenarios)
- **Kịch bản phù hợp Razor Pages:**
  - Ứng dụng quản lý hồ sơ nhân viên / sinh viên trong trường học với các tác vụ CRUD tiêu chuẩn.
  - Website blog cá nhân hoặc trang portfolio tin tức đơn giản.
  - Trang đăng nhập, đăng ký, quên mật khẩu (ngay cả ASP.NET Core Identity mặc định cũng dùng Razor Pages).
- **Kịch bản phù hợp MVC:**
  - Sàn thương mại điện tử (E-Commerce) với giỏ hàng phức tạp, thanh toán đa cổng, phân quyền đa cấp, tích hợp API.
  - Hệ thống quản trị nội dung (CMS) quy mô lớn phục vụ hàng triệu người dùng với các giao diện responsive thay đổi theo ngữ cảnh người dùng.

---

## 5. BÀI TẬP 3: TỔ CHỨC PROJECT VÀ TẢI LÊN GITHUB (EXERCISE 3)

### Cấu trúc thư mục chuẩn theo yêu cầu:
```
Lab08 _CNPM/
│
├── SchoolApp.sln                     # File Solution chứa cả 2 project
├── SchoolDB.sql                      # Script tạo CSDL và seed data
├── README.md                         # Hướng dẫn chi tiết dự án
├── .gitignore                        # Loại trừ bin, obj, .vs khi commit
│
├── Exercise1_RazorPages/             # Solution Folder cho Bài 1
│   └── SchoolAppCoreRazor/
│       ├── Models/                   # Department, Course, Instructor, Student, Enrollment, SchoolContext
│       ├── Migrations/               # 20250429100129_InitialCreate
│       ├── Pages/                    # Razor Pages CRUD cho 5 bảng
│       ├── Program.cs
│       └── appsettings.json
│
└── Exercise2_MVC/                    # Solution Folder cho Bài 2
    └── SchoolAppCoreMVC/
        ├── Models/                   # Models & SchoolContext
        ├── Migrations/               # 20250430021132_InitialCreate
        ├── Controllers/              # 5 Controllers cho 5 thực thể
        ├── Views/                    # 5 thư mục Views tương ứng
        ├── Program.cs
        └── appsettings.json
```

### Các bước đẩy lên GitHub:
1. Mở terminal tại thư mục gốc `Lab08 _CNPM`:
   ```bash
   git init
   git add .
   git commit -m "Initial commit for Exercise 1 and Exercise 2"
   ```
2. Đặt nhánh chính và kết nối repository từ xa:
   ```bash
   git branch -M main
   git remote add origin https://github.com/YourUsername/Lab08_ASPNetCore_CodeFirst.git
   git push -u origin main
   ```
3. Chụp ảnh giao diện GitHub hiển thị 2 thư mục `Exercise1_RazorPages` và `Exercise2_MVC` cùng tệp `README.md` để đính kèm vào báo cáo.

---

## 6. SCRIPT CƠ SỞ DỮ LIỆU (SCHOLLDB.SQL)
Tệp `SchoolDB.sql` đã được khởi tạo hoàn chỉnh tại thư mục gốc của giải pháp, bao gồm:
1. Tự động kiểm tra và tạo cơ sở dữ liệu `SchoolDB`.
2. Bảng theo dõi phiên bản `__EFMigrationsHistory` tương thích 100% với EF Core 8.0.
3. Tạo 5 bảng: `Departments`, `Instructors`, `Courses`, `Students`, `Enrollments` với đầy đủ thuộc tính `IDENTITY`, ràng buộc khóa chính (`PK`), khóa ngoại (`FK`) kèm cơ chế `ON DELETE CASCADE`, và các chỉ mục phi cụm (`Non-Clustered Indexes`).
4. Nạp sẵn dữ liệu mẫu (`Seed Data`) trùng khớp hoàn toàn với dữ liệu thực nghiệm trong tài liệu hướng dẫn Lab.

---

## 7. KẾT LUẬN VÀ BÀI HỌC KINH NGHIỆM (CONCLUSION)

### 7.1. Kết quả đạt được
- Nắm vững quy trình phát triển cơ sở dữ liệu theo phương pháp **Code-First**: Bắt đầu từ việc thiết kế các lớp C# Entity, cấu hình DbContext, phát sinh Migration và cập nhật cơ sở dữ liệu tự động.
- Hiểu rõ sự khác biệt giữa hai kiến trúc **Razor Pages** và **MVC** trong ASP.NET Core thông qua việc trực tiếp triển khai cùng một bài toán thực tế.
- Thành thạo kỹ năng tùy biến điều khiển giao diện (như SelectList dropdown kết hợp nhiều trường thông tin) và thiết lập quan hệ dữ liệu 1-nhiều, nhiều-nhiều giữa các thực thể.
- Biết cách tổ chức mã nguồn khoa học trong một Visual Studio Solution duy nhất và quản lý phiên bản với Git/GitHub.

### 7.2. Khó khăn gặp phải và giải pháp khắc phục
- **Khó khăn 1:** Khi khởi tạo ban đầu, dropdown của Môn học chỉ hiển thị mã số `DepartmentID` làm người dùng không nhận diện được tên khoa.
  - *Giải pháp:* Can thiệp vào phương thức `OnGet()` của Razor Page hoặc Action `Create()`/`Edit()` của Controller để sử dụng LINQ `.Select(d => new { d.DepartmentID, DisplayText = d.DepartmentID + " - " + d.DepartmentName })` trước khi gán vào `SelectList`.
- **Khó khăn 2:** Xung đột quan hệ khóa ngoại khi thực hiện Migration hoặc xóa dữ liệu.
  - *Giải pháp:* Cấu hình đúng `Cascade Delete` và sắp xếp thứ tự xóa theo chiều từ bảng con (`Enrollments`) lên bảng cha (`Courses`, `Students`, `Departments`).

---

## 8. PHỤ LỤC (APPENDIX): LINK GITHUB
- **Địa chỉ Repository:** `[Dán link GitHub repository của bạn ở đây]`
- **Cấu trúc nộp bài eLearning:**
  - File 1: `MSSV_HoTen.zip` (Chứa toàn bộ mã nguồn của cả 2 project và tệp `SchoolDB.sql`).
  - File 2: `MSSV_HoTen.pdf` (Báo cáo đầy đủ hình ảnh, bookmark phân mục và link GitHub ở phụ lục).

