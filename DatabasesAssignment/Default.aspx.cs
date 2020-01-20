using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DatabasesAssignment
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["loggedin"] != null)
            {
                loginMessage.Visible = false;
                userGreet.Visible = true;
                adminOptions.Visible = (bool)Session["isadmin"];
            } else
            {
                loginMessage.Visible = true;
                userGreet.Visible = adminOptions.Visible = false;
            }
        }
    }
}