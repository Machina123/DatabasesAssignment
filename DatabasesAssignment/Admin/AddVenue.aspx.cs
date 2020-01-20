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
    public partial class AddVenue : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection conn = null;
            if (Session["loggedin"] == null || !(bool)Session["isadmin"])
            {
                Response.Redirect("/");
            }
            if (IsPostBack)
            {
                conn = new SqlConnection(ConfigurationManager.ConnectionStrings["alphaConnString"].ConnectionString);
                if (venueName.Text.Length < 1 || venueAddr.Text.Length < 1 || Convert.ToInt32(venueCap.Text) < 1)
                {
                    errorContainer.Visible = true;
                    errorAlert.InnerText = "Incomplete or wrong Venue data!";
                }
                else
                {
                    SqlCommand cmd = new SqlCommand("sp_proj_InsertVenue", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@VenueName", venueName.Text);
                    cmd.Parameters.AddWithValue("@VenueAddress", venueAddr.Text);
                    cmd.Parameters.AddWithValue("@Capacity", venueCap.Text);
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
}