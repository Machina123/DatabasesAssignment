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
    public partial class AddEvent : System.Web.UI.Page
    {
        SqlConnection conn = null;
        SqlDataAdapter performerA, venueA;
        DataSet performerDS, venueDS;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["loggedin"] == null || !(bool)Session["isadmin"])
            {
                Response.Redirect("/");
            }
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["alphaConnString"].ConnectionString);

            if(!IsPostBack)
            {
                SqlCommand cmd = new SqlCommand("sp_proj_GetPerformers", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                performerA = new SqlDataAdapter(cmd);
                performerDS = new DataSet();
                performerA.Fill(performerDS);
                eventPerf.DataSource = performerDS;
                eventPerf.DataTextField = "performer";
                eventPerf.DataValueField = "id";
                eventPerf.DataBind();

                cmd = new SqlCommand("sp_proj_GetVenues", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                venueA = new SqlDataAdapter(cmd);
                venueDS = new DataSet();
                venueA.Fill(venueDS);
                eventVenue.DataSource = venueDS;
                eventVenue.DataTextField = "vname";
                eventVenue.DataValueField = "id";
                eventVenue.DataBind();
            } else
            {
                SqlCommand cmd = new SqlCommand("sp_proj_CreateEvent", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@VenueId", eventVenue.SelectedValue);
                cmd.Parameters.AddWithValue("@PerformerId", eventPerf.SelectedValue);
                cmd.Parameters.AddWithValue("@EventTime", DateTime.Parse(eventDate.Text));
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