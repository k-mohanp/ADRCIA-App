using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Security;
using System.Data.SqlClient;
using System.Security.Principal;
using System.Net;
using ADRCIA;
using System.Web.Services;

public partial class Login : System.Web.UI.Page
{
    // Added by GK on 02Sept 2019 : Task Id #17097 (ADRCIA login issues)
    string AdrciaRoles;

    protected void Page_Load(object sender, EventArgs e)
    {


        // need to split on : for localhost to work

        string strHost = Request.ServerVariables["HTTP_HOST"].Split(':')[0].ToString();


        // check if user is logged in yet
        try
        {
            Session["AUTH_USER"].ToString();
            Session["AUTH_PASSWORD"].ToString();
        }
        catch
        {
            // check where user is coming from and redirect to proper login page
            if (strHost == "localhost" || strHost == "10.0.0.105")
            {
                Session["AUTH_USER"] = "";
                Session["AUTH_PASSWORD"] = "";
                Session["USER_NAME"] = "";
                Session["GUID"] = "";
                Session["SITEID"] = "";
                Session["AAASiteID"] = "";
                Session["RESOURCEID"] = "";
                Session["USERID"] = "";

                //Session["GROUPNAMES"] = "|ADRCIAAdmin|ADRCIAOSAAdmin|ADRCIADataEntry";
                //  Session["GROUPNAMES"] = "|ADRCIAOSAAdmin";
                // Session["Role"] = "ADRCIAOSAAdmin";
                Session["GROUPNAMES"] = "|ADRCIAOSAAdmin";
                //  Session["GROUPNAMES"] = "|ADRCIADataEntry|ADRCIAOSAAdmin";

                //Session["AUTH_USER"] = "APrakash62065";
                //Session["AUTH_PASSWORD"] = "Acro@1234";
                //Session["USER_NAME"] = "Abhinav Prakash";
                //Session["GUID"] = "1AC5CEC3-85D2-4CFF-8CCE-7CB6B506A18D";
                //Session["SITEID"] = "0";
                //Session["AAASiteID"] = "0";
                //Session["RESOURCEID"] = "0";
                //Session["USERID"] = "62065";
                //Session["GROUPNAMES"] = "|ADRCIADataEntry|ADRCIAAdmin";

                Session["AUTH_USER"].ToString();
                Session["AUTH_PASSWORD"].ToString();
            }
            else
            {
                if (strHost == "192.168.0.130" || strHost == "192.168.0.30")
                    Response.Redirect("http://192.168.0.75/PCLogin/PCLogin.aspx", true);
                else
                    Response.Redirect("/PCLogin/PCLogin.aspx", true);
                // Response.Redirect("Login.aspx", false);                    
            }
        }

        // Grab proper section from Web.Config to access variable set there
        // put it in session for access thru-out application
        // MySession.strHost = strHost;
        //  MySession.strEnv = ConfigurationManager.AppSettings[strHost];

        //get path to the LDAP directory server on the network
        string adPath = MySession.myWebConfig.adPath;

        LDAPActivDirectory adAuth = new LDAPActivDirectory();
        if (adAuth.IsAuthenticated(MySession.myWebConfig.domain, Session["AUTH_USER"].ToString(), Session["AUTH_PASSWORD"].ToString()))
        {

            // blnUserIsAuthenticated = true;
            if (SetUpUser())
            {
                try
                {
                    SetControlValues();
                    // Modified by GK on 02Sept 2019 : Task Id #17097 (ADRCIA login issues)
                    FormsAuthenticationUtil.RedirectFromLoginPage(Session["AUTH_USER"].ToString(), AdrciaRoles, false, null);
                    //FormsAuthenticationUtil.RedirectFromLoginPage(Session["AUTH_USER"].ToString(), GetUserRole(), false, null);                      
                    //FormsAuthenticationUtil.RedirectFromLoginPage(Session["AUTH_USER"].ToString(), ".ADRCIA", false, null);                      
                    // Response.Redirect(Page.ResolveUrl("~/Default.aspx"), true);
                }
                catch (Exception ex)
                {
                    lblError.Text = ex.Message.ToString();
                    //Response.End();
                }
            }
            else
            {
                lblError.Text = "Sorry! Unable to setup your rights. Please contact to administrator";

                //Response.Redirect("logout.aspx");
            }
        }
        else
        {
            // check for errors
            if (Request.QueryString["error"] == "expired")
            {
                lblError.Text = "Your session has expired. Please log in again to use this application.";
            }
            else
            {
                lblError.Text = "You do not have permission to use this application.";

                //Response.Redirect("logout.aspx");

            }

        }
    }


    /// <summary>
    /// Create comma seperated string of users role
    /// </summary>
    /// <returns></returns>
    /// Commented by GK 09July 2021 : SOW-613B
    //private string GetUserRole()
    //{
    //    string userData = Convert.ToString(Session["GROUPNAMES"]).Replace("|", ",");
    //    if (userData.Substring(0, 1).IndexOf(",") > -1)
    //    {
    //        userData = userData.Substring(1);
    //    }

    //    return userData;
    //}


    protected bool SetUpUser()
    {
        // check user group membership and set session vars
        bool IsAuthenticated = false;

        if (!SetUserRights())
        {
            // create forms auth ticket cookie
            FormsAuthentication.Initialize();
            FormsAuthentication.RedirectFromLoginPage(Session["AUTH_USER"].ToString(), true);

            FormsAuthenticationTicket authTicket = new FormsAuthenticationTicket(1, Session["AUTH_USER"].ToString(), DateTime.Now,
                DateTime.Now.AddMinutes(Session.Timeout), true, AdrciaRoles);
            // Now encrypt the ticket.
            string strEncryptedTicket = FormsAuthentication.Encrypt(authTicket);

            if (!FormsAuthentication.CookiesSupported)
            {
                //If the authentication ticket is specified not to use cookie, set it in the URL
                FormsAuthentication.SetAuthCookie(strEncryptedTicket, false);
            }
            else
            {
                //If the authentication ticket is specified to use a cookie,
                //wrap it within a cookie.
                //The default cookie name is .ASPXAUTH if not specified
                //in the <forms> element in web.config
                HttpCookie authCookie = new HttpCookie(FormsAuthentication.FormsCookieName,
                strEncryptedTicket);
                //Set the cookie's expiration time to the tickets expiration time
                authCookie.Expires = authTicket.Expiration;
                //Set the cookie in the Response
                Response.Cookies.Add(authCookie);
            }


            //// Create a cookie and add the encrypted ticket to the cookie as data.
            // HttpCookie authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, strEncryptedTicket);

            // // Add the cookie to the outgoing cookies collection.
            // Response.Cookies.Add(authCookie);

            // get provider site ID from db and set in session
            IsAuthenticated = true;

        }
        return IsAuthenticated;
    }

    protected bool SetUserRights()
    {
        // set username in session to use later thru-out app
        //if (MySession.strUserName.Length == 0)
        MySession.blnLoggedIn = true;
        MySession.blnADRCIADataEntry = false;
        MySession.blnADRCIAAdmin = false;
        MySession.blnADRCIAOSAAdmin = false;

        bool blnError = false;

        //retrieve the user's groups	
        string strGroups = Session["groupnames"].ToString();

        // first check if user has ANY Market rights
        if (strGroups.ToLower().IndexOf("adrcia") != -1)
        {
            //split the groups into an array
            string[] strGroupsArr = strGroups.Split('|');
            string strIdxLC = "";

            // grant rights based on group membership
            foreach (string strIdx in strGroupsArr)
            {
                //Response.Write(strIdx);
                strIdxLC = strIdx.ToLower();
                if (strIdxLC.IndexOf("adrcia") != -1)
                {
                    // Added by GK on 02Sept 2019 : Task Id #17097 (ADRCIA login issues)
                    AdrciaRoles += string.IsNullOrEmpty(AdrciaRoles) ? strIdxLC : "," + strIdxLC;
                    switch (strIdxLC)
                    {
                        case ("adrciadataentry"):
                            {
                                MySession.blnADRCIADataEntry = true;
                                break;
                            }

                        case ("adrciaadmin"):
                            {
                                MySession.blnADRCIAAdmin = true;

                                break;
                            }

                        case ("adrciaosaadmin"):
                            {
                                MySession.blnADRCIAOSAAdmin = true;

                                break;
                            }
                    }
                }
            }
        }
        else
        {
            lblError.Text = "Username: " + MySession.strUserName + " does not have permission to use this application.";
            blnError = true;
        }
        // Response.End();
        return blnError;
    }


    /// <summary>
    /// Created By:SM
    /// Date:04/09/2013
    /// purpose: Set User Name, Agency Name and ADRC Name.
    /// </summary>
    private void SetControlValues()
    {
        SqlDataReader objRdr;
        //get User Details
        objRdr = (SqlDataReader)ADRCIADAL.GetUserDetails();
        string SiteID = string.Empty;
        if (objRdr.HasRows)
        {
            objRdr.Read();

            MySession.AAAAgencyName = objRdr["resourcename"].ToString();

            //MySession.AAAAgencyName = objRdr["resourcename"].ToString();
            MySession.UserFullName = Convert.ToString(objRdr["LastName"]) + ", " + Convert.ToString(objRdr["FirstName"]);
            SiteID = Convert.ToString(objRdr["SiteId"]);
            MySession.SiteId = Convert.ToInt32(SiteID);
        }
        objRdr.Dispose();

        // Get ADRC Agency Name
        objRdr = (SqlDataReader)ADRCIADAL.GetADRCAgencyName(Convert.ToInt32(SiteID));
        if (objRdr.HasRows)
        {
            objRdr.Read();
            //Session["ADRCAgencyName"] = objRdr["ADRCName"].ToString(); 
            MySession.ADRCAgencyName = objRdr["ADRCName"].ToString();
        }
        else
            MySession.ADRCAgencyName = "NA";

        objRdr.Dispose();
    }


    #region Added By: AR, 14-Nov-2023 | SOW-654
    //Added By: AR, 14-Nov-2023 (SOW-654) | To check if the user's session is killed.
    // True: If the session is killed and the request is AJAX request.
    [WebMethod]
    public static bool IsSessionKilled()
    {
            if (HttpContext.Current.Session["IsAjaxLogout"] != null && Convert.ToBoolean(HttpContext.Current.Session["IsAjaxLogout"]))
            {
                HttpContext.Current.Session["IsAjaxLogout"] = null;
                return true;
            }
            else
                return false;  
    }
    #endregion
}