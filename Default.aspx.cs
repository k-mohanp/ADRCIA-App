using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data;
using ADRCIA;

public partial class _Default : System.Web.UI.Page

{
    protected void Page_Load(object sender, EventArgs e)
    {

        Response.Cache.SetNoStore();
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        if (MySession.blnADRCIAOSAAdmin == false && (MySession.blnADRCIAAdmin == false && MySession.blnADRCIADataEntry==false))
        {
            Response.Redirect("~/Unauthenticateduser.aspx", true);
        }
       // Redirect OSA Admin to OSA page
        if (MySession.blnADRCIAOSAAdmin)
            Response.Redirect("~/Admin/DashBoard.aspx", true);   
        else
            Response.Redirect("~/Home.aspx",true);       
    }

}