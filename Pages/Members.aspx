<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Members.aspx.cs" Inherits="Pages_Members" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>회원 목록</title>
	<style>
		body {
		  font-family: 'Segoe UI', sans-serif;
		  background-color: #F4F6F8;
		  margin: 0;
		  padding: 20px;
		}
		h2 {
		  text-align: center;
		  color: #333;
		}
		.member-card {
		  background-color: #fff;
		  border: 1px solid #E0E0E0;
		  border-radius: 8px;
		  padding: 16px 20px;
		  margin: 15px auto;
		  max-width: 500px;
		  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
		  transition: all 0.2s ease-in-out;
		}
		.member-card:hover {
		  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
		  transform: translateY(-3px);
		}
		.member-label {
		  font-weight: bold;
		  color: #555;
		}
		.member-value {
		  color: #222;
		  margin-bottom: 8px;
		  display: block;
		}
  </style>
</head>
<body>
    <form id="form1" runat="server">
        <h2>회원 목록</h2>

		<%--등록 버튼--%>
		<div style="text-align:right; margin-bottom: 15px;">
			<button type="button" class="action-btn" onclick="location.href='AddMember.aspx'">+ 등록하기</button>
		</div>

        <asp:Repeater ID="rptMembers" runat="server" OnItemCommand="rptMembers_ItemCommand">
			<ItemTemplate>
				<div class="member-card">
					<span class="member-label">아이디:</span>
					<span class="member-value"><%# Eval("Id") %></span>
					<span class="member-label">이름:</span>
					<span class="member-value"><%# Eval("Name") %></span>
					<span class="member-label">이메일:</span>
					<span class="member-value"><%# Eval("Email") %></span>
					<span class="member-label">가입일:</span>
					<span class="member-value"><%# Eval("JoinDate", "{0:yyyy-MM-dd}") %></span>
					<div style="margin-top: 10px;">
						<!-- JavaScript로 수정 이동 -->
						<button type="button" class="action-btn"
								onclick="location.href='AddMember.aspx?id=<%# Eval("Id") %>'">수정</button>
						<!-- 삭제는 서버에서 처리 -->
						<asp:Button ID="btnDelete" runat="server" Text="삭제"
									CommandName="Delete" CommandArgument='<%# Eval("Id") %>' CssClass="action-btn delete" />
					</div>
				</div>
			</ItemTemplate>
		</asp:Repeater>
    </form>
</body>
</html>