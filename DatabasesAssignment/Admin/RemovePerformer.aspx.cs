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
    public partial class RemovePerformer : System.Web.UI.Page
    {
        SqlConnection conn = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["loggedin"] == null || !(bool)Session["isadmin"])
            {
                Response.Redirect("/");
            }
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["alphaConnString"].ConnectionString);

            if (!IsPostBack)
            {
                SqlCommand cmd = new SqlCommand("sp_proj_GetPerformers", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataSet performerDS = new DataSet();
                adapter.Fill(performerDS);
                performerSelect.DataSource = performerDS;
                performerSelect.DataTextField = "performer";
                performerSelect.DataValueField = "id";
                performerSelect.DataBind();
            }
            else
            {
                SqlCommand cmd = new SqlCommand("sp_proj_RemovePerformer", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PerformerId", performerSelect.SelectedValue);
                conn.Open();
                try
                {
                    cmd.ExecuteNonQuery();
                    conn.Close();
                    Response.Redirect("~/Admin/AdminPanel");
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