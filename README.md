# School App Projects

This solution contains two implementations of a University/School management application using ASP.NET Core (.NET 8) with Entity Framework Core Code-First approach:
1. **Exercise 1: Razor Pages Application (`SchoolAppCoreRazor`)**
2. **Exercise 2: MVC Application (`SchoolAppCoreMVC`)**

---

## Exercise 1: Razor Pages Application
- **Directory**: `Exercise1_RazorPages/SchoolAppCoreRazor`
- **Description**: ASP.NET Core Razor Pages project using Code First approach.
- **Technologies**: ASP.NET Core 8.0, Razor Pages, Entity Framework Core 8.0 (SqlServer, Tools).
- **Features**:
  - Full CRUD operations for `Department`, `Course`, `Instructor`, `Student`, `Enrollment`.
  - Custom dropdown for Courses binding `DepartmentID` and `DepartmentName` as display text (`DepartmentID - DepartmentName`).
  - Integrated navigation menu in `_Layout.cshtml`.
- **Instructions**:
  - Open `SchoolApp.sln` in Visual Studio 2022 (or open project directly).
  - Set `SchoolAppCoreRazor` as the Startup Project.
  - Press `F5` or `Ctrl + F5` to run.
  - Or via terminal:
    ```bash
    dotnet run --project Exercise1_RazorPages/SchoolAppCoreRazor
    ```

---

## Exercise 2: MVC Application
- **Directory**: `Exercise2_MVC/SchoolAppCoreMVC`
- **Description**: ASP.NET Core MVC project using Code First approach.
- **Technologies**: ASP.NET Core 8.0, MVC (Model-View-Controller), Entity Framework Core 8.0 (SqlServer, Tools).
- **Features**:
  - Controllers and Razor Views for `Departments`, `Courses`, `Instructors`, `Students`, `Enrollments`.
  - Responsive Bootstrap navigation layout in `_Layout.cshtml`.
  - Full CRUD operations with server-side validation and EF Core tracking.
- **Instructions**:
  - Open `SchoolApp.sln` in Visual Studio 2022.
  - Set `SchoolAppCoreMVC` as the Startup Project.
  - Press `F5` or `Ctrl + F5` to run.
  - Or via terminal:
    ```bash
    dotnet run --project Exercise2_MVC/SchoolAppCoreMVC
    ```

---

## Database Setup (Code First & SQL Script)
Both applications connect to SQL Server database `SchoolDB` using the connection string:
```
Server=(local)\SQLEXPRESS;Database=SchoolDB;Trusted_Connection=True;TrustServerCertificate=True
```
*(If you are using SQL Server LocalDB, you can adjust the connection string in `appsettings.json` to: `Server=(localdb)\\mssqllocaldb;Database=SchoolDB;Trusted_Connection=True;MultipleActiveResultSets=true;TrustServerCertificate=True`)*

### Applying Migrations via Package Manager Console in Visual Studio:
1. Set the target project as Default project in Package Manager Console.
2. Run:
   ```powershell
   Add-Migration InitialCreate
   Update-Database
   ```

### Alternatively, using SQL Server Management Studio (SSMS):
Execute `SchoolDB.sql` included in this repository to create the database, tables, foreign keys, and seed sample data directly.

---

## Git & GitHub Structure
```
Lab08 _CNPM/
├── SchoolApp.sln
├── SchoolDB.sql
├── README.md
├── Exercise1_RazorPages/
│   └── SchoolAppCoreRazor/
└── Exercise2_MVC/
    └── SchoolAppCoreMVC/
```

