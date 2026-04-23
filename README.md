# ASP.NET Web Forms CRUD - 회원 관리 시스템

ASP.NET Web Forms(.NET Framework 4.6.1)로 구현한 회원 관리 CRUD 예제입니다.  
ORM 없이 ADO.NET과 Stored Procedure만으로 DB 작업을 처리하며, 공통 헬퍼 클래스(`DbHelper.cs`)로 중복 코드를 제거하는 패턴을 학습하기 위해 만들었습니다.

---

## 기술 스택

| 분류 | 기술 | 선택 이유 |
|------|------|-----------|
| 프레임워크 | ASP.NET Web Forms (.NET 4.6.1) | 서버 이벤트 모델(PostBack)과 페이지 생명주기를 직접 학습하기 위해 |
| 언어 | C# (Code-Behind) | .aspx 마크업과 서버 로직을 분리하는 전통적인 Web Forms 구조 유지 |
| DB 접근 | ADO.NET | ORM 없이 SQL 실행 흐름(연결 → 명령 → 결과)을 명시적으로 이해하기 위해 |
| DB 로직 | SQL Server Stored Procedure | 쿼리를 DB 레이어에 캡슐화하고, 애플리케이션 코드에서 SP 이름만 호출하는 구조 연습 |
| DB | SQL Server (LocalDB / Express) | Integrated Security 기반 로컬 개발 환경 |

---

## 주요 기능

- **회원 목록 조회** — `Repeater` 컨트롤로 카드형 UI 렌더링, 최신 가입 순 정렬
- **회원 등록** — 이름 · 이메일 입력 후 저장, 가입일은 DB 기본값(`GETDATE()`) 자동 처리
- **회원 수정** — 목록에서 [수정] 클릭 시 QueryString(`?id=N`)으로 동일 폼 재사용 (등록/수정 단일 페이지)
- **회원 삭제** — `asp:Button`의 `CommandName="Delete"` + `ItemCommand` 이벤트로 서버 측 처리
- **공통 DB 헬퍼** — `DbHelper.cs` 정적 클래스가 연결·명령·해제를 담당, 페이지 코드는 SP 이름과 파라미터만 전달

---

## 프로젝트 구조

```
asp-webforms-crud/
│
├── Pages/
│   ├── Members.aspx          # 회원 목록 (Repeater + 삭제)
│   ├── Members.aspx.cs       # 목록 로드, ItemCommand 처리
│   ├── AddMember.aspx        # 등록/수정 폼 (단일 페이지)
│   └── AddMember.aspx.cs     # QueryString id 유무로 INSERT/UPDATE 분기
│
├── App_Code/
│   ├── DbHelper.cs           # ADO.NET 공통 헬퍼 (핵심)
│   ├── BundleConfig.cs       # CSS/JS 번들 설정
│   ├── RouteConfig.cs        # URL 라우팅 설정
│   ├── Startup.cs            # OWIN 파이프라인 진입점
│   ├── Startup.Auth.cs       # 인증 미들웨어 설정 (이 프로젝트에서는 미사용)
│   └── IdentityModels.cs     # ASP.NET Identity 모델 (미사용 스캐폴딩)
│
├── Sql/
│   ├── 01_create_tables.sql  # Members 테이블 생성
│   ├── 02_insert_dummy_data.sql  # 테스트용 샘플 데이터
│   └── 03_stored_procedures.sql  # usp_GetMembers 외 4개 SP
│
├── Site.master               # 공통 마스터 페이지
├── Default.aspx              # 루트 진입 페이지
├── Web.config                # DB 연결 문자열, .NET 런타임 설정
├── Bundle.config             # 번들 대상 리소스 목록
└── packages.config           # NuGet 패키지 목록
```

### DbHelper.cs — 핵심 구조

```csharp
// SELECT → DataTable 반환
DbHelper.GetDataTableByProcedure("usp_GetMembers");

// INSERT / UPDATE / DELETE → 영향받은 행 수 반환
DbHelper.ExecuteNonQueryByProcedure("usp_DeleteMember", param);

// 단일 값 조회 (COUNT, 생성된 ID 등)
DbHelper.ExecuteScalarByProcedure("usp_...", param);
```

모든 메서드는 `using` 블록으로 `SqlConnection`, `SqlCommand`, `SqlDataAdapter`를 관리하므로, 호출부에서 연결 해제를 신경 쓸 필요가 없습니다.

### Stored Procedures 목록

| SP 이름 | 동작 |
|---------|------|
| `usp_GetMembers` | 전체 목록 조회 (Id DESC) |
| `usp_GetMemberById` | 단일 회원 조회 (수정 시 폼 초기화) |
| `usp_AddMember` | 신규 회원 INSERT |
| `usp_UpdateMember` | 이름·이메일 UPDATE |
| `usp_DeleteMember` | 회원 DELETE |

---

## 실행 방법

### 1. SQL Server 데이터베이스 준비

SQL Server Management Studio(SSMS) 또는 Azure Data Studio에서 새 데이터베이스를 생성합니다.

```sql
CREATE DATABASE localTest;
```

### 2. SQL 스크립트 순서대로 실행

```
Sql/01_create_tables.sql      -- Members 테이블 생성
Sql/02_insert_dummy_data.sql  -- 샘플 데이터 삽입
Sql/03_stored_procedures.sql  -- Stored Procedure 5개 생성
```

### 3. Web.config 연결 문자열 확인

```xml
<connectionStrings>
  <add name="DefaultConnection"
       connectionString="Data Source=.;Initial Catalog=localTest;Integrated Security=True"
       providerName="System.Data.SqlClient" />
</connectionStrings>
```

- `Data Source=.` — 로컬 기본 인스턴스. 명명된 인스턴스라면 `.\SQLEXPRESS` 등으로 변경
- `Integrated Security=True` — Windows 인증 사용. SQL Server 인증이라면 `User Id=...;Password=...`로 교체

### 4. Visual Studio에서 실행

1. Visual Studio 2019 이상에서 프로젝트 폴더를 **웹 사이트(Web Site)** 로 열기
2. `Pages/Members.aspx`를 시작 페이지로 설정
3. `F5` 또는 IIS Express로 실행

> **Note** Web Application 프로젝트(.csproj)가 아닌 **Web Site** 방식입니다. 솔루션 파일이 없으며, Visual Studio에서 `파일 > 웹 사이트 열기`로 폴더를 직접 열어야 합니다.

---

## 배운 점 / 구현 포인트

### 1. Web Forms 페이지 생명주기와 IsPostBack

```csharp
protected void Page_Load(object sender, EventArgs e)
{
    if (!IsPostBack)
        LoadMembers(); // 최초 접근 시에만 DB 조회
}
```

`IsPostBack` 체크 없이 매번 `LoadMembers()`를 호출하면 삭제 등의 PostBack 후에도 불필요한 DB 조회가 중복 발생합니다. Web Forms의 PostBack 메커니즘을 이해하는 핵심 패턴입니다.

### 2. 단일 폼으로 등록/수정 분기 처리

`AddMember.aspx` 하나가 등록과 수정 두 가지 역할을 합니다. QueryString의 `id` 유무로 분기합니다.

```csharp
// Page_Load: id가 있으면 수정 모드로 초기화
string id = Request.QueryString["id"];
if (!string.IsNullOrEmpty(id))
{
    hfId.Value = id;          // HiddenField에 저장
    lblMode.InnerText = "회원 수정";
    LoadMember(Convert.ToInt32(id));
}

// 저장 버튼: HiddenField 값으로 INSERT / UPDATE 결정
if (string.IsNullOrEmpty(hfId.Value))
    procName = "usp_AddMember";   // 신규
else
    procName = "usp_UpdateMember"; // 수정
```

`HiddenField`는 PostBack 사이에 값을 유지하는 Web Forms의 상태 관리 방법입니다.

### 3. Repeater + ItemCommand 패턴

GridView와 달리 Repeater는 UI를 완전히 직접 제어합니다. 삭제 버튼은 서버 컨트롤(`asp:Button`)로 두어 `CommandName`과 `CommandArgument`에 Id를 실어 이벤트로 처리합니다.

```aspx
<asp:Button CommandName="Delete" CommandArgument='<%# Eval("Id") %>' ... />
```

```csharp
protected void rptMembers_ItemCommand(object source, RepeaterCommandEventArgs e)
{
    if (e.CommandName == "Delete")
    {
        int id = Convert.ToInt32(e.CommandArgument);
        // ...
    }
}
```

### 4. ADO.NET의 using 블록과 리소스 해제

`SqlConnection`은 `IDisposable`을 구현합니다. `using` 블록을 쓰면 예외 발생 시에도 연결이 반드시 닫힙니다. `DbHelper`가 이를 일관되게 처리하므로, 페이지 코드는 연결 관리를 전혀 신경 쓰지 않아도 됩니다.

### 5. Stored Procedure를 통한 SQL 분리

애플리케이션 코드에 SQL 문자열이 전혀 없습니다. SP 이름과 파라미터만 전달하므로, SQL 변경 시 DB 레이어만 수정하면 됩니다. 또한 파라미터화된 쿼리 방식이라 SQL Injection을 원천 차단합니다.
