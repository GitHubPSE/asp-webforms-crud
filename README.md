# ASP.NET WebForms CRUD (Stored Procedure + ADO.NET Helper)

ASP.NET Web Site 방식으로 구현한 간단한 회원 관리 CRUD 예제입니다.  
SQL Server의 Stored Procedure 기반으로 구성되며, ADO.NET 헬퍼 클래스(`DbHelper.cs`)를 통해 DB 작업을 공통화했습니다.

---

## 📂 프로젝트 구조
asp-webforms-crud/
Pages/                # Members.aspx, AddMember.aspx
App_Code/             # DbHelper.cs (공통 DB 유틸)
Sql/                  # 테이블 + SP + 더미데이터 SQL
Web.config            # 연결 문자열 설정
README.md

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

3. **Visual Studio에서 실행**
	•	시작 페이지: Pages/Members.aspx
	•	등록/수정: Pages/AddMember.aspx
