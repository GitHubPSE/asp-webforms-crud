using System;
using System.Data;
using System.Data.SqlClient;
public partial class Pages_AddMember : System.Web.UI.Page
{
	protected void Page_Load(object sender, EventArgs e)
	{
		if (!IsPostBack)
		{
			string id = Request.QueryString["id"];
			if (!string.IsNullOrEmpty(id))
			{
				hfId.Value = id;
				lblMode.InnerText = "회원 수정";
				LoadMember(Convert.ToInt32(id));
			}
		}
	}
	private void LoadMember(int id)
	{
		SqlParameter[] param = {
			new SqlParameter("@Id", SqlDbType.Int) { Value = id }
		};
		DataTable dt = DbHelper.GetDataTableByProcedure("usp_GetMemberById", param);
		if (dt.Rows.Count > 0)
		{
			txtName.Text = dt.Rows[0]["Name"].ToString();
			txtEmail.Text = dt.Rows[0]["Email"].ToString();
		}
	}
	protected void btnSubmit_Click(object sender, EventArgs e)
	{
		string procName;
		SqlParameter[] param;
		if (string.IsNullOrEmpty(hfId.Value))
		{
			// INSERT
			procName = "usp_AddMember";
			param = new SqlParameter[]
			{
				new SqlParameter("@Name", SqlDbType.NVarChar, 100) { Value = txtName.Text },
				new SqlParameter("@Email", SqlDbType.NVarChar, 100) { Value = txtEmail.Text }
			};
		}
		else
		{
			// UPDATE
			procName = "usp_UpdateMember";
			param = new SqlParameter[]
			{
				new SqlParameter("@Id", SqlDbType.Int) { Value = Convert.ToInt32(hfId.Value) },
				new SqlParameter("@Name", SqlDbType.NVarChar, 100) { Value = txtName.Text },
				new SqlParameter("@Email", SqlDbType.NVarChar, 100) { Value = txtEmail.Text }
			};
		}
		DbHelper.ExecuteNonQueryByProcedure(procName, param);
		Response.Redirect("Members.aspx");
	}
}