# ASP.NET WebForms CRUD (Stored Procedure + ADO.NET Helper)

ASP.NET Web Site 방식으로 구현한 간단한 회원 관리 CRUD 예제입니다.  
SQL Server의 Stored Procedure 기반으로 구성되며, ADO.NET 헬퍼 클래스(`DbHelper.cs`)를 통해 DB 작업을 공통화했습니다.

---

## 📂 프로젝트 구조
<pre>
asp-webforms-crud/
├── Pages/                Members.aspx, AddMember.aspx
├── App_Code/             DbHelper.cs (공통 DB 유틸)
├── Sql/                  테이블, SP, 더미데이터 SQL
├── Web.config            DB 연결 문자열 포함
└── README.md
</pre>

---

## 🛠 실행 방법

1. **SQL Server에 데이터베이스 생성**
   - 이름: `localTest`

2. **SQL 스크립트 실행**
   - `Sql/01_create_tables.sql`
   - `Sql/02_insert_dummy_data.sql`
   - `Sql/03_stored_procedures.sql`

3. **Web.config 설정 확인**

    ```xml
    <connectionStrings>
      <add name="DefaultConnection"
           connectionString="Data Source=.;Initial Catalog=localTest;Integrated Security=True"
           providerName="System.Data.SqlClient" />
    </connectionStrings>
    ```

4. **Visual Studio에서 실행**
   - 시작 페이지: `Pages/Members.aspx`
   - 등록/수정: `Pages/AddMember.aspx`

---

## ✅ 주요 기능

- 회원 목록 조회 (Read)
- 신규 회원 등록 (Create)
- 회원 정보 수정 (Update)
- 회원 삭제 (Delete)
- Stored Procedure 기반 DB 처리
- DbHelper 유틸 클래스 적용 (재사용 가능)

---
