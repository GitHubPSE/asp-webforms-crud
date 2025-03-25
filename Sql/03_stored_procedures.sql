-- 조회
CREATE PROCEDURE usp_GetMembers
AS
BEGIN
  SELECT * FROM Members ORDER BY Id DESC
END
GO

-- 추가
CREATE PROCEDURE usp_AddMember
  @Name NVARCHAR(100),
  @Email NVARCHAR(100)
AS
BEGIN
  INSERT INTO Members (Name, Email) VALUES (@Name, @Email)
END
GO

-- 수정
CREATE PROCEDURE usp_UpdateMember
  @Id INT, @Name NVARCHAR(100), @Email NVARCHAR(100)
AS
BEGIN
  UPDATE Members SET Name = @Name, Email = @Email WHERE Id = @Id
END
GO

-- 삭제
CREATE PROCEDURE usp_DeleteMember
  @Id INT
AS
BEGIN
  DELETE FROM Members WHERE Id = @Id
END
GO

-- 회원 조회
CREATE PROCEDURE usp_GetMemberById
 @Id INT
AS
BEGIN
	SELECT Name, Email FROM Members WHERE Id = @Id
END
GO