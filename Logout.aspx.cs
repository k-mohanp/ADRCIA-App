using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using ADRCIA;
public partial class Logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            ActiveUsers.RemoveUserFromActiveUserList(Session.SessionID);//Added by: AR 06-Nov-2023(SOW-654) | To remove the user session id from DB
            Session.Abandon();
            FormsAuthentication.SignOut();

            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Buffer = true;
            Response.ExpiresAbsolute = DateTime.Now.AddMinutes(-1);
            Response.Expires = -1000;
            Response.CacheControl = "no-cache";
            Response.Cache.SetExpires(DateTime.Now.AddMinutes(-1));
            Response.Cache.SetNoStore();
            Request.Cookies.Remove(FormsAuthentication.FormsCookieName);

            // clear authentication cookie
            HttpCookie cookie1 = new HttpCookie(FormsAuthentication.FormsCookieName, "");
            cookie1.Expires = DateTime.Now.AddMinutes(-1);
            Response.Cookies.Add(cookie1);

            // clear session cookie
            HttpCookie cookie2 = new HttpCookie("ASP.NET_SessionId", "");
            cookie2.Expires = DateTime.Now.AddMinutes(-1);
            Response.Cookies.Add(cookie2);

            // Redirect to pclogin page
            FormsAuthentication.RedirectToLoginPage();
        }
        catch
        {
           // if (MySession.strEnv != "localhost")
            //    FormsAuthentication.RedirectToLoginPage();
               // Response.Redirect(Page.ResolveClientUrl("/PCLogin/PCLogin.aspx"));
        }
    }
}