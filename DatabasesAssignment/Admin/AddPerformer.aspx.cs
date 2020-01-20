using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DatabasesAssignment.Admin
{
    public partial class AddPerformer : System.Web.UI.Page
    {
        SqlConnection conn = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["loggedin"] == null || !(bool)Session["isadmin"])
            {
                Response.Redirect("/");
            }
            if (IsPostBack)
            {
                conn = new SqlConnection(ConfigurationManager.ConnectionStrings["alphaConnString"].ConnectionString);
                if (perfName.Text.Length < 1)
                {
                    errorContainer.Visible = true;
                    errorAlert.InnerText = "Performer name cannot be empty!";
                }
                else
                {
                    SqlCommand cmd = new SqlCommand("sp_proj_InsertPerformer", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@PerformerName", perfName.Text);
                    conn.Open();
                    try
                    {
                        cmd.ExecuteNonQuery();
                        conn.Close();
                        Response.Redirect("~/AdminPanel");
                    }
                    catch (SqlException ex)
                    {
                        errorContainer.Visible = true;
                        errorAlert.InnerText = "SQL Error: " + ex.Message;
                    }
                }
            }
        }
    }
}