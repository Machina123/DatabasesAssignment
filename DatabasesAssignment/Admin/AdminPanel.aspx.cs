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

namespace DatabasesAssignment.Admin
{
    public partial class AdminPanel : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["loggedin"] == null || !(bool)Session["isadmin"])
            {
                Response.Redirect("/");
            }
        }
    }
}