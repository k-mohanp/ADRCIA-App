using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using ADRCIA;

public partial class AdminSite :System.Web.UI.MasterPage
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Expires = 0;
        Response.Cache.SetNoStore();
        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        lblAgencyName.Text = MySession.AAAAgencyName;
        lblUser.Text = MySession.UserFullName;
        lblADRC.Text = MySession.ADRCAgencyName;

        //if (!(MySession.blnADRCIAOSAAdmin || MySession.blnADRCIAAdmin))
        //{
        //    Response.Redirect(Page.ResolveUrl("~/Unauthenticateduser.aspx"), true);
        //}    
    }

    // Added by PC on 21 Aug, 2020, for if session has expired, reroute to login page.
    protected void Page_Init(object sender, EventArgs e)
    {

        if (!MySession.blnLoggedIn)
        {
            Response.Redirect(Page.ResolveUrl("~/logout.aspx"));
        }
    }
}
