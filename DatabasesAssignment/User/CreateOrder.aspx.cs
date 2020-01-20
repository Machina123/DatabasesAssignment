using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DatabasesAssignment.User
{
    public partial class CreateOrder : System.Web.UI.Page
    {
        SqlConnection conn = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["loggedin"] == null)
            {
                Response.Redirect("/");
            }
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["alphaConnString"].ConnectionString);

            if (!IsPostBack)
            {
                SqlCommand cmd = new SqlCommand("sp_proj_GetEvents", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataSet eventDS = new DataSet();
                adapter.Fill(eventDS);
                eventSelect.DataSource = eventDS;
                eventSelect.DataTextField = "friendlyname";
                eventSelect.DataValueField = "id";
                eventSelect.DataBind();
            }
            else
            {
                SqlCommand cmd = new SqlCommand("sp_proj_CreateOrder", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EventId", eventSelect.SelectedValue);
                cmd.Parameters.AddWithValue("@TicketCount", ticketCount.Text);
                cmd.Parameters.AddWithValue("@UserId", (int)Session["userid"]);
                conn.Open();
                try
                {
                    cmd.ExecuteNonQuery();
                    conn.Close();
                    Response.Redirect("/");
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