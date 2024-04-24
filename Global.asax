<%@ Application Language="C#" %>
<%@ Import Namespace="System.Web.Optimization" %>

<script RunAt="server">


    void Application_Start(object sender, EventArgs e)
    {
        //Added by PC on 6 Feb 2023, Purpose: WebForms UnobtrusiveValidationMode requires a ScriptResourceMapping for 'jquery'. 
        //Please add a ScriptResourceMapping named jquery(case-sensitive).
        ScriptManager.ScriptResourceMapping.Clear();
        ScriptResourceDefinition Jquery = new ScriptResourceDefinition();
        Jquery.Path = "~/Scripts/ajaxUnobtrusiveHandling.js";
        ScriptManager.ScriptResourceMapping.AddDefinition("jquery",Jquery);
        //End
        // Code that runs on application startup
        BundleConfig.RegisterBundles(BundleTable.Bundles);
    }

    void Application_End(object sender, EventArgs e)
    {
        //  Code that runs on application shutdown

    }

    void Application_Error(object sender, EventArgs e)
    {

        // Code that runs when an unhandled error occurs
        Exception objErr = Server.GetLastError().GetBaseException();
        Application["LastError"] = objErr;
        //added: Log exception to DB and send mail on 26th March, 2015. SA
        //ADRCIA.ADRCIABAL.Log(ex:objErr);

        //Added by PC on 27 oct 22, To prevent Http Parameter Pollution on aspxerrorpath parameter.
        HttpApplication httpApp = (HttpApplication)sender;
        System.Web.Configuration.CustomErrorsSection customErrors = (System.Web.Configuration.CustomErrorsSection)httpApp.Context.GetSection("system.web/customErrors");
        if (customErrors != null && customErrors.DefaultRedirect != null && customErrors.DefaultRedirect.Length > 0 && customErrors.Mode == System.Web.Configuration.CustomErrorsMode.On)
        {
            if (!httpApp.Request.RawUrl.ToLower().Contains(customErrors.DefaultRedirect.ToLower()))
            {
                if(httpApp.Request.Url.LocalPath.Contains("=") || httpApp.Request.Url.LocalPath.Contains("&")|| httpApp.Request.Url.LocalPath.Contains(";"))
                    Response.Redirect(customErrors.DefaultRedirect);
                else
                    Response.Redirect(String.Concat(customErrors.DefaultRedirect, "?aspxerrorpath=", httpApp.Request.Url.LocalPath));

            }
        }
        //End
    }

    void Session_Start(object sender, EventArgs e)
    {
        // Code that runs when a new session is started
        // HttpContext.Current.Request.Cookies.Remove(FormsAuthentication.FormsCookieName);
    }

    void Session_End(object sender, EventArgs e)
    {


        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

        //FormsAuthentication.SignOut();
        //HttpContext.Current.Response.Cookies.Remove("strUser");
        //HttpContext.Current.Request.Cookies.Remove(FormsAuthentication.FormsCookieName);
        //HttpContext.Current.Request.Cookies.Clear();
        //HttpContext.Current.Session.RemoveAll();

    }


    // Added by GK on 14July2021 : SOW-613B, for forms authentication and authorization.
    protected void FormsAuthentication_OnAuthenticate(Object sender, FormsAuthenticationEventArgs e)
    {
        if (FormsAuthentication.CookiesSupported == true)
        {
            if (Request.Cookies[FormsAuthentication.FormsCookieName] != null)
            {
                try
                {
                    //let us take out the username now                
                    string username = FormsAuthentication.Decrypt(Request.Cookies[FormsAuthentication.FormsCookieName].Value).Name;
                    string roles = FormsAuthentication.Decrypt(Request.Cookies[FormsAuthentication.FormsCookieName].Value).UserData;
                    //Let us set the Pricipal with our user specific details
                    e.User = new System.Security.Principal.GenericPrincipal(
                      new System.Security.Principal.GenericIdentity(username, "Forms"), roles.Split(','));
                }
                catch (Exception)
                {
                }
            }

        }
    }


    //protected void Application_AuthenticateRequest(Object sender, EventArgs e)
    //{


    //    if (HttpContext.Current.User != null)
    //    {
    //        if (HttpContext.Current.User.Identity.IsAuthenticated)
    //        {
    //            if (HttpContext.Current.User.Identity is FormsIdentity)
    //            {
    //                FormsIdentity id = (FormsIdentity)HttpContext.Current.User.Identity;
    //                FormsAuthenticationTicket ticket = (id.Ticket);
    //                if (!FormsAuthentication.CookiesSupported)
    //                {
    //                    //If cookie is not supported for forms authentication, then the
    //                    //authentication ticket is stored in the URL, which is encrypted.
    //                    //So, decrypt it
    //                    ticket = FormsAuthentication.Decrypt(id.Ticket.Name);
    //                }
    //                // Get the stored user-data, in this case, user roles
    //                if (!string.IsNullOrEmpty(ticket.UserData))
    //                {
    //                    string userData = ticket.UserData;
    //                    string[] roles = userData.Split(',');
    //                    //Roles were put in the UserData property in the authentication ticket
    //                    //while creating it
    //                    HttpContext.Current.User =
    //                      new System.Security.Principal.GenericPrincipal(id, roles);
    //                }
    //            }
    //        }
    //    }
    //}

    //Added by: AR, 10-Nov-2023(SOW-654) | To prevent ajax call when the session is killed.
    protected void Application_AcquireRequestState(Object sender, EventArgs e)
    {
        if (ActiveUsers.EnableMaxSessionPopup)
        {
            if (((HttpContext.Current.Handler is IReadOnlySessionState || HttpContext.Current.Handler is IRequiresSessionState) && (Session != null && Session["AUTH_USER"] != null)))
            {
                string rCode = ActiveUsers.UserSessionInfo_Update(Session.SessionID);//Extends/update the current time in DB.

                if (!string.IsNullOrEmpty(rCode.Split(':')[1]))//Varifying, a session item is removed/killed by another process or not.
                {

                    Session.RemoveAll();

                    if (Context.Request.Headers["X-Requested-With"] == "XMLHttpRequest")
                        Session["IsAjaxLogout"] = true;
                    else
                        Response.Redirect("~/Logout.aspx");
                }
            }
        }
    }
</script>
