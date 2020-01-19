using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DatabasesAssignment
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["loggedin"] != null)
            {
                navRegister.Visible = navLogin.Visible = false;
                navLogout.Visible = true;
                navAdmin.Visible = (bool)Session["isadmin"];
            } else
            {
                navAdmin.Visible = navLogout.Visible = false;
                navRegister.Visible = navLogin.Visible = true;
            }
        }
    }
}