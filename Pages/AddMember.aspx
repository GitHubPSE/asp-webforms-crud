<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddMember.aspx.cs" Inherits="Pages_AddMember" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>회원 등록 / 수정</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #F4F6F8;
            padding: 20px;
        }
        .form-container {
            max-width: 500px;
            margin: auto;
            background-color: #fff;
            border-radius: 8px;
            padding: 24px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .form-container h2 {
            margin-bottom: 20px;
            color: #333;
        }
        .form-field {
            margin-bottom: 15px;
        }
        .form-field label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-field input[type="text"] {
            width: 100%;
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .btn-submit {
            background-color: #28A745;
            color: white;
            border: none;
            padding: 10px 16px;
            font-size: 15px;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-submit:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <h2 runat="server" id="lblMode">회원 등록</h2>
            <asp:HiddenField ID="hfId" runat="server" />
            <div class="form-field">
                <label for="txtName">이름</label>
                <asp:TextBox ID="txtName" runat="server" />
            </div>
            <div class="form-field">
                <label for="txtEmail">이메일</label>
                <asp:TextBox ID="txtEmail" runat="server" />
            </div>
            <asp:Button ID="btnSubmit" runat="server" Text="저장하기" OnClick="btnSubmit_Click" CssClass="btn-submit" />
        </div>
    </form>
</body>
</html>