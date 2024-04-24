using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using ADRCIA;

public partial class Site : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetNoStore();
        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        lblAgencyName.Text = MySession.AAAAgencyName;
        lblUser.Text = MySession.UserFullName;
        lblADRC.Text = MySession.ADRCAgencyName;

        string strUC = Request.QueryString["UC"];
        functions.SetTabAndPage(Request.Url.Segments);

        if (MySession.blnADRCIAOSAAdmin)
        {
            liSystemSetting.Visible = true;
            hprSearchPerson.NavigateUrl = "~/Admin/AdminNeedyPersonSearch.aspx?UC=0";
            hprUpdateCall.NavigateUrl = "~/Admin/AdminNeedyPersonSearch.aspx?UC=1";
            hprHome.NavigateUrl = "~/Admin/DashBoard.aspx";

        }
        else
        {
            liSystemSetting.Visible = false;
            hprSearchPerson.NavigateUrl = "~/NeedyPersonSearch.aspx?UC=0";
            hprUpdateCall.NavigateUrl = "~/NeedyPersonSearch.aspx?UC=1";
            hprHome.NavigateUrl = "~/Home.aspx";
        }
        //Commented by vk on 08 Aug,2018. no need hide/show link.
        // Set Link Visibility
        //if (MySession.strCurrentPage.ToUpper() == "Needyperson.aspx".ToUpper())
        //{
        //    liNewPerson.Visible = false;
        //}
        //if (MySession.strCurrentPage.ToUpper() == "NeedyPersonSearch.aspx".ToUpper())
        //{
        //    if (strUC != "1")
        //        liSearchPerson.Visible = false;
        //    else
        //        liUpdateCall.Visible = false;
        //}
        //if (MySession.strCurrentPage.ToUpper() == "ADRCReporting.aspx".ToUpper())
        //{
        //    liADRCReport.Visible = false;
        //}

        //if (!MySession.blnADRCIADataEntry)
        //{

        //    Response.Redirect(Page.ResolveUrl("~/Unauthenticateduser.aspx"), true);
        //}
        //Added by vk on 08 aug,2017. for Actve tab Cssclass.
        if (MySession.strCurrentPage.ToUpper() == "Needyperson.aspx".ToUpper())
        {
            if (strUC == "0")
                hprSearchPerson.CssClass = hprSearchPerson.CssClass + " active";
            else if (strUC == "1")
                hprUpdateCall.CssClass = hprUpdateCall.CssClass + " active";
            else
                hrpNewPerson.Attributes["class"] = hrpNewPerson.Attributes["class"] + " active";
        }
        if (MySession.strCurrentPage.ToUpper() == "AdminNeedyPersonSearch.aspx".ToUpper() || MySession.strCurrentPage.ToUpper() == "NeedyPersonSearch.aspx".ToUpper())
        {
            if (strUC != "1")
                hprSearchPerson.CssClass = hprSearchPerson.CssClass + " active";
            else
                hprUpdateCall.CssClass = hprUpdateCall.CssClass + " active";
        }
        if (MySession.strCurrentPage.ToUpper() == "ADRCReporting.aspx".ToUpper())
        {
            hrpADRCReport.Attributes["class"] = hrpADRCReport.Attributes["class"] + " active";
        }
        if (MySession.strCurrentPage.ToUpper() == "messagecenter.aspx".ToUpper() || MySession.strCurrentPage.ToUpper() == "FollowupSetting.aspx".ToUpper() || MySession.strCurrentPage.ToUpper() == "MergePersonNeedyAssistance.aspx".ToUpper())
        {
            ancSystemSetting.Attributes["class"] = ancSystemSetting.Attributes["class"] + " active";
        }
    }

    // Added by PC on 21 Aug, 2020, for if session has expired, reroute to login page.
    protected void Page_Init(object sender, EventArgs e)
    {
        if (!MySession.blnLoggedIn)
        {
            Response.Redirect(Page.ResolveUrl("~/logout.aspx"));
        }
    }

    // Added by GK on 17Oct,2022: Manage UpdatePanel error, if any issue comes will throw on page.
    protected void scrptMGR_AsyncPostBackError(object sender, AsyncPostBackErrorEventArgs e)
    {
        throw e.Exception;
    }
}
