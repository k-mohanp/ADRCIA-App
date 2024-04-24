using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ADRCIA;
public partial class DefaultSite : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

        // if session has expired, reroute to login page.
        if (!MySession.blnLoggedIn)
            Response.Redirect(Page.ResolveUrl("~/logout.aspx"));

        // set session vars for current tab and current page
        functions.SetTabAndPage(Request.Url.Segments);
    }
}
