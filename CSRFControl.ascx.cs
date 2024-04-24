using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Helpers;
using Microsoft.Security.Application;     //Added by RK,01April2024

public partial class CSRFControl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Added by PC on 03 Feb 2020, Purpose: Cross-site request forgery (CSRF)
        if (IsPostBack)
        {
            try
            {
                AntiForgery.Validate();
            }
            catch (Exception ex)
            {
                string url = Request.Url.AbsoluteUri;
                string error = ex.Message.Replace('<', ' ').Replace('>', ' ');
                string innerException = Convert.ToString(ex.InnerException).Replace('<', ' ').Replace('>', ' ');
                string source = ex.Source;
                string targetSite = Convert.ToString(ex.TargetSite);
                Response.Redirect(Page.ResolveUrl("/PCLogin/CSRFTokenError.aspx?url=" + Sanitizer.GetSafeHtmlFragment(url) + "&error='" + Sanitizer.GetSafeHtmlFragment(error) + "'" + "&source=" + Sanitizer.GetSafeHtmlFragment(source) + "&innerex=" + Sanitizer.GetSafeHtmlFragment(innerException) + "&targetsite=" + Sanitizer.GetSafeHtmlFragment(targetSite)));  //Modified by RK,27March2024,Task-ID: 24527,Purpose: Sanitization of data

            }
        }
        //End
    }
}