using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DatabasesAssignment
{
    public partial class AdminPanel : Page
    {
        SqlConnection conn = null;
        SqlDataAdapter performerA, venueA, eventA;
        DataSet performerDS, venueDS, eventDS;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["loggedin"] == null || !(bool)Session["isadmin"])
            {
                Response.Redirect("/");
            }
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["alphaConnString"].ConnectionString);

            // data bindings for Performer
            SqlCommand cmd = new SqlCommand("sp_proj_GetPerformers", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            performerA = new SqlDataAdapter(cmd);
            performerDS = new DataSet();
            eventPerf.DataSource = performerDS;
            eventPerf.DataTextField = "performer";
            eventPerf.DataValueField = "id";
            perfSelect.DataSource = performerDS;
            perfSelect.DataTextField = "performer";
            perfSelect.DataValueField = "id";              

            // data bindings for Venue
            cmd = new SqlCommand("sp_proj_GetVenues", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            venueA = new SqlDataAdapter(cmd);
            venueDS = new DataSet();
            eventVenue.DataSource = venueDS;
            eventVenue.DataTextField = "vname";
            eventVenue.DataValueField = "id";
            venueSelect.DataSource = venueDS;
            venueSelect.DataTextField = "vname";
            venueSelect.DataValueField = "id";

            // data bindings for Event
            cmd = new SqlCommand("sp_proj_GetEvents", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            eventA = new SqlDataAdapter(cmd);
            eventDS = new DataSet();
            eventSelect.DataSource = eventDS;
            eventSelect.DataTextField = "friendlyname";
            eventSelect.DataValueField = "id";

            updateDataSets();
        }

        protected void btnAddPerformer_Click(object sender, EventArgs e)
        {
            if (perfName.Text.Length < 1)
            {
                errorContainer.Visible = true;
                errorAlert.InnerText = "Performer name cannot be empty!";
            } else
            {
                SqlCommand cmd = new SqlCommand("sp_proj_InsertPerformer", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PerformerName", perfName.Text);
                conn.Open();
                try
                {
                    cmd.ExecuteNonQuery();
                    conn.Close();
                    updateDataSets();
                    successContainer.Visible = true;
                    successAlert.InnerText = "Performer added successfully";
                } catch(SqlException ex)
                {
                    errorContainer.Visible = true;
                    errorAlert.InnerText = "SQL Error: " + ex.Message;
                }
            }
        }

        protected void btnAddVenue_Click(object sender, EventArgs e)
        {
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
                    updateDataSets();
                    successContainer.Visible = true;
                    successAlert.InnerText = "Venue added successfully";
                }
                catch (SqlException ex)
                {
                    errorContainer.Visible = true;
                    errorAlert.InnerText = "SQL Error: " + ex.Message;
                }
            }
        }

        protected void btnAddEvent_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("sp_proj_CreateEvent", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@VenueId", eventVenue.Value);
            cmd.Parameters.AddWithValue("@PerformerId", eventPerf.Value);
            cmd.Parameters.AddWithValue("@EventTime", DateTime.Parse(eventDate.Text));
            conn.Open();
            try
            {
                cmd.ExecuteNonQuery();
                conn.Close();
                updateDataSets();
                successContainer.Visible = true;
                successAlert.InnerText = "Event added successfully";
            }
            catch (SqlException ex)
            {
                errorContainer.Visible = true;
                errorAlert.InnerText = "SQL Error: " + ex.Message;
            }
        }

        protected void btnRemovePerformer_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("sp_proj_RemovePerformer", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@PerformerId", perfSelect.Value);
            conn.Open();
            try
            {
                cmd.ExecuteNonQuery();
                conn.Close();
                updateDataSets();
                successContainer.Visible = true;
                successAlert.InnerText = "Performer deleted successfully";
            }
            catch (SqlException ex)
            {
                errorContainer.Visible = true;
                errorAlert.InnerText = "SQL Error: " + ex.Message;
            }
        }

        protected void btnRemoveVenue_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("sp_proj_RemoveVenue", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@VenueId", venueSelect.Value);
            conn.Open();
            try
            {
                cmd.ExecuteNonQuery();
                conn.Close();
                updateDataSets();
                successContainer.Visible = true;
                successAlert.InnerText = "Venue removed successfully";
            }
            catch (SqlException ex)
            {
                errorContainer.Visible = true;
                errorAlert.InnerText = "SQL Error: " + ex.Message;
            }
        }

        protected void btnRemoveEvent_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("sp_proj_RemoveEvent", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@EventId", eventSelect.Value);
            conn.Open();
            try
            {
                cmd.ExecuteNonQuery();
                conn.Close();
                updateDataSets();
                successContainer.Visible = true;
                successAlert.InnerText = "Event removed successfully";
            }
            catch (SqlException ex)
            {
                errorContainer.Visible = true;
                errorAlert.InnerText = "SQL Error: " + ex.Message;
            }
        }

        protected void updateDataSets()
        {
            venueDS.Clear();
            venueA.Fill(venueDS);
            eventDS.Clear();
            eventA.Fill(eventDS);
            performerDS.Clear();
            performerA.Fill(performerDS);
            eventSelect.DataBind();
            eventPerf.DataBind();
            perfSelect.DataBind();
            eventVenue.DataBind();
            venueSelect.DataBind();
        }
    }
}