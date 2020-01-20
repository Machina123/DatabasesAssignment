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
            if(!IsPostBack)
            {
                Debug.WriteLine("NOT POSTBACK");
                createViewState();
            } else
            {
                Debug.WriteLine("POSTBACK");
                restoreViewState();
            }
        }

        protected void btnAddPerformer_Click(object sender, EventArgs e)
        {
            
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

            Debug.WriteLine("V:" + eventVenue.SelectedValue + " P:" + eventPerf.SelectedValue);
            SqlCommand cmd = new SqlCommand("sp_proj_CreateEvent", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@VenueId", ViewState["eventVenue"]);
            cmd.Parameters.AddWithValue("@PerformerId", ViewState["eventPerf"]);
            cmd.Parameters.AddWithValue("@EventTime", DateTime.Parse(eventDate.Text));
            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                successContainer.Visible = true;
                successAlert.InnerText = "Event added successfully";
            }
            catch (Exception ex)
            {
                errorContainer.Visible = true;
                errorAlert.InnerText = "Error: " + ex.Message;
            }
        }

        protected void eventPerf_SelectedIndexChanged(object sender, EventArgs e)
        {
            ViewState.Add("eventPerf", eventPerf.SelectedValue);
        }

        protected void eventVenue_SelectedIndexChanged(object sender, EventArgs e)
        {
            ViewState.Add("eventVenue", eventVenue.SelectedValue);
        }

        protected void perfSelect_SelectedIndexChanged(object sender, EventArgs e)
        {
            ViewState.Add("perfSelect", perfSelect.SelectedValue);
        }

        protected void venueSelect_SelectedIndexChanged(object sender, EventArgs e)
        {
            ViewState.Add("venueSelect", venueSelect.SelectedValue);
        }

        protected void eventSelect_SelectedIndexChanged(object sender, EventArgs e)
        {
            ViewState.Add("eventSelect", eventSelect.SelectedValue);
        }

        protected void btnRemovePerformer_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("sp_proj_RemovePerformer", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@PerformerId", ViewState["perfSelect"]);
            conn.Open();
            try
            {
                cmd.ExecuteNonQuery();
                conn.Close();
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
            cmd.Parameters.AddWithValue("@VenueId", ViewState["venueSelect"]);
            conn.Open();
            try
            {
                cmd.ExecuteNonQuery();
                conn.Close();
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
            cmd.Parameters.AddWithValue("@EventId", ViewState["eventSelect"]);
            conn.Open();
            try
            {
                cmd.ExecuteNonQuery();
                conn.Close();
                successContainer.Visible = true;
                successAlert.InnerText = "Event removed successfully";
            }
            catch (SqlException ex)
            {
                errorContainer.Visible = true;
                errorAlert.InnerText = "SQL Error: " + ex.Message;
            }
        }

        protected void updateDataSets(bool clearDataSets = false)
        {
            if (clearDataSets)
            {
                venueDS.Clear();
                eventDS.Clear();
                performerDS.Clear();
            }
            venueA.Fill(venueDS);
            eventA.Fill(eventDS);
            performerA.Fill(performerDS);
            eventSelect.DataBind();
            eventPerf.DataBind();
            perfSelect.DataBind();
            eventVenue.DataBind();
            venueSelect.DataBind();
        }

        protected void createViewState()
        {
            ViewState.Add("eventPerf", eventPerf.SelectedValue);
            ViewState.Add("eventVenue", eventVenue.SelectedValue);
            ViewState.Add("perfSelect", perfSelect.SelectedValue);
            ViewState.Add("venueSelect", venueSelect.SelectedValue);
            ViewState.Add("eventSelect", eventSelect.SelectedValue);
        }

        protected void restoreViewState()
        {
            eventPerf.SelectedValue = ViewState["eventPerf"].ToString();
            eventVenue.SelectedValue = ViewState["eventVenue"].ToString();
            perfSelect.SelectedValue = ViewState["perfSelect"].ToString();
            venueSelect.SelectedValue = ViewState["venueSelect"].ToString();
            eventSelect.SelectedValue = ViewState["eventSelect"].ToString();
        }
    }
}