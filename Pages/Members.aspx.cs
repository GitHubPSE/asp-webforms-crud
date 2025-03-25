using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class Pages_Members : System.Web.UI.Page
{
	protected void Page_Load(object sender, EventArgs e)
	{
		if (!IsPostBack)
		{
			LoadMembers();
		}
	}
	private void LoadMembers()
	{
		DataTable dt = DbHelper.GetDataTableByProcedure("usp_GetMembers");
		rptMembers.DataSource = dt;
		rptMembers.DataBind();
	}
	protected void rptMembers_ItemCommand(object source, RepeaterCommandEventArgs e)
	{
		if (e.CommandName == "Delete")
		{
			int id = Convert.ToInt32(e.CommandArgument);
			SqlParameter[] param = new SqlParameter[]
			{
				new SqlParameter("@Id", SqlDbType.Int) { Value = id }
			};
			DbHelper.ExecuteNonQueryByProcedure("usp_DeleteMember", param);
			LoadMembers();  // 갱신
		}
	}
}