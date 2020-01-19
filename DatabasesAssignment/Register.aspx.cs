using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Diagnostics;

namespace DatabasesAssignment
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                string connStr = ConfigurationManager.ConnectionStrings["alphaConnString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_proj_RegisterUser", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Username", login.Text);
                        cmd.Parameters.AddWithValue("@Password", password.Text);
                        cmd.Parameters.AddWithValue("@ConfirmPass", password_confirm.Text);
                        cmd.Parameters.AddWithValue("@Email", email.Text);
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                while (reader.Read())
                                {
                                    if (reader["ErrorMessage"] != null)
                                    {
                                        executeResult.Visible = true;
                                        executeResult.Attributes.Remove("class");
                                        executeResult.Attributes.Add("class", "alert alert-danger");
                                        executeResult.InnerHtml = "<strong>SQL Error:</strong> " + reader["ErrorMessage"];
                                    }
                                }
                            }
                            else
                            {
                                executeResult.Visible = true;
                                executeResult.Attributes.Remove("class");
                                executeResult.Attributes.Add("class", "alert alert-success");
                                executeResult.InnerText = "User registered successfully. You may now log in with provided details.";
                            }
                        }
                    }
                }
            }
        }
    }
}