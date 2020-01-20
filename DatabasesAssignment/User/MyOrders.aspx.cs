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
    public partial class MyOrders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["loggedin"] == null) Response.Redirect("/");

            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["alphaConnString"].ConnectionString);
            SqlCommand cmd = new SqlCommand("sp_proj_GetOrdersByUser", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@UserId", (int)Session["userid"]);
            conn.Open();
            try
            {
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (!reader.HasRows)
                    {
                        result.InnerHtml = "<div class=\"alert alert-info\">No orders found</div>";
                    }
                    else
                    {
                        result.InnerHtml = "<div class=\"list-group\">";
                        while (reader.Read())
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