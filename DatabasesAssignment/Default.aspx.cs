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
                foreach(var obj in Session)
                {
                    string objStr = obj.ToString();
                    Debug.WriteLine(Session[objStr] + " " + Session[objStr].GetType());
                }
            }
        }
    }
}