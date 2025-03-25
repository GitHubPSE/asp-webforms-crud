using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
public static class DbHelper
{
	private static string GetConnectionString()
	{
		return ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
	}
	// SELECT용 SP 실행 → DataTable 반환
	public static DataTable GetDataTableByProcedure(string procName, SqlParameter[] parameters = null)
	{
		using (SqlConnection conn = new SqlConnection(GetConnectionString()))
		using (SqlCommand cmd = new SqlCommand(procName, conn))
		using (SqlDataAdapter da = new SqlDataAdapter(cmd))
		{
			cmd.CommandType = CommandType.StoredProcedure;
			if (parameters != null && parameters.Length > 0)
				cmd.Parameters.AddRange(parameters);
			DataTable dt = new DataTable();
			da.Fill(dt);
			return dt;
		}
	}
	// INSERT/UPDATE/DELETE용 SP 실행 → 영향받은 행 수 반환
	public static int ExecuteNonQueryByProcedure(string procName, SqlParameter[] parameters)
	{
		using (SqlConnection conn = new SqlConnection(GetConnectionString()))
		using (SqlCommand cmd = new SqlCommand(procName, conn))
		{
			cmd.CommandType = CommandType.StoredProcedure;
			cmd.Parameters.AddRange(parameters);
			conn.Open();
			return cmd.ExecuteNonQuery();
		}
	}
	// 단일 값 조회 (예: COUNT, ID 등)
	public static object ExecuteScalarByProcedure(string procName, SqlParameter[] parameters)
	{
		using (SqlConnection conn = new SqlConnection(GetConnectionString()))
		using (SqlCommand cmd = new SqlCommand(procName, conn))
		{
			cmd.CommandType = CommandType.StoredProcedure;
			cmd.Parameters.AddRange(parameters);
			conn.Open();
			return cmd.ExecuteScalar();
		}
	}
}