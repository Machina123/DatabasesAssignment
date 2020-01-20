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
    public partial class ShowUserOrders : System.Web.UI.Page
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
                SqlCommand cmd = new SqlCommand("sp_proj_GetUsers", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataSet performerDS = new DataSet();
                adapter.Fill(performerDS);
                userSelect.DataSource = performerDS;
                userSelect.DataTextField = "email";
                userSelect.DataValueField = "id";
                userSelect.DataBind();
            }
            else
            {
                SqlCommand cmd = new SqlCommand("sp_proj_GetOrdersByUser", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserId", userSelect.SelectedValue);
                conn.Open();
                try
                {
                    using(SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if(!reader.HasRows)
                        {
                            result.InnerHtml = "<div class=\"alert alert-info\">No orders found</div>";
                        } else
                        {
                            result.InnerHtml = "<div class=\"list-group\">";
                            while(reader.Read())
                            {
                                result.InnerHtml += $"<div class=\"list-group-item\">" +
                                    $"<h4 class=\"list-group-item-heading\">{reader["performer"]} @ {reader["vname"]}</h4>" +
                                    $"<p class=\"list-group-item-text\">Event time: {reader["eventtime"]}<br>Ticket count: {reader["ticketcount"]}<br>" +
                                    $"Ordered: {reader["orderdate"]}<br>Checksum: {reader["orderchecksum"]}</p></div>";
                            }
                            result.InnerHtml += "</div>";
                        }
                    }
                    conn.Close();
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