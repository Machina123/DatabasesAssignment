using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DatabasesAssignment
{
    public partial class Login1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(IsPostBack)
            {
                string connStr = ConfigurationManager.ConnectionStrings["alphaConnString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_proj_LoginUser", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Username", login.Text);
                        cmd.Parameters.AddWithValue("@Password", password.Text);
                        cmd.Parameters.Add("@UserId", SqlDbType.Int).Direction = ParameterDirection.Output;
                        cmd.Parameters.Add("@IsAdmin", SqlDbType.Bit).Direction = ParameterDirection.Output;
                        conn.Open();
                        try
                        {
                            cmd.ExecuteNonQuery();
                            Session["loggedin"] = true;
                            Session["userid"] = cmd.Parameters["@UserId"].Value;
                            Session["isadmin"] = cmd.Parameters["@IsAdmin"].Value;
                            Response.Redirect("/");
                        } catch(SqlException ex)
                        {
                            executeResult.Visible = true;
                            executeResult.Attributes.Remove("class");
                            executeResult.Attributes.Add("class", "alert alert-danger");
                            executeResult.InnerHtml = "<strong>SQL Error:</strong> " + ex.Message;
                        }
                    }
                }
            }
        }
    }
}