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
    public partial class RemoveVenue : System.Web.UI.Page
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
                SqlCommand cmd = new SqlCommand("sp_proj_GetVenues", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataSet venueDS = new DataSet();
                adapter.Fill(venueDS);
                venueSelect.DataSource = venueDS;
                venueSelect.DataTextField = "vname";
                venueSelect.DataValueField = "id";
                venueSelect.DataBind();
            }
            else
            {
                SqlCommand cmd = new SqlCommand("sp_proj_RemoveVenue", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@VenueId", venueSelect.SelectedValue);
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