using System;
using System.Configuration;
using System.Web;
using System.Web.SessionState;

namespace ADRCIA
{
    public enum Tabs { market, questionnaire, report, mfresh, congmealsite }
    public enum OperationType { INSERT, UPDATE }

     [Serializable]
    public static class MySession
    {
      
        public static WebConfigSection myWebConfig
        {
             get { return (WebConfigSection)ConfigurationManager.GetSection(strEnv); }
            //get { return (WebConfigSection)ConfigurationManager.GetSection(_strEnv); }
        }

        public static string strHost
        {
            get { return HttpContext.Current.Request.ServerVariables["HTTP_HOST"].Split(':')[0].ToString(); }
            
            //get { return _strHost; }
            //set { _strHost = value; }
        }

        public static string strEnv
        {
            get { return ConfigurationManager.AppSettings[strHost]; }
            
            //get { return _strEnv; }
            //set { _strEnv = value; }
        }

        public static string strAppDB
        {
            get
            {
                if (strEnv != "")
                    return strEnv + "AppDB";
                else
                {
                    throw new Exception("Lost session data");
                }
            }
        }

        public static string strErrDB
        {
            get
            {
                if (strEnv != "")
                    return strEnv + "ErrDB";
                else
                {
                    throw new Exception("Lost session data");
                }
            }
        }

        public static string strAppDBConnString
        {
            get { return ConfigurationManager.ConnectionStrings[strEnv + "AppDB"].ToString(); }
        }

        public static string strErrDBConnString
        {
            get
            {
                return ConfigurationManager.ConnectionStrings[strEnv + "ErrDB"].ToString();
            }
        }

        public static string strUserName
        {
            get
            {
                HttpSessionState sess = HttpContext.Current.Session;
                if (sess["AUTH_USER"] == null)
                    return "";
                else
                    return sess["AUTH_USER"].ToString();
            }
        }
        public static string strCurrentTab
        {
            get
            {
                HttpSessionState sess = HttpContext.Current.Session;
                if (sess["CurrentTab"] == null)
                    return "";
                else
                    return sess["CurrentTab"].ToString();
            }
            set
            {
                HttpSessionState sess = HttpContext.Current.Session;
                sess["CurrentTab"] = value;
            }
        }

        public static string strCurrentPage
        {
            get
            {
                HttpSessionState sess = HttpContext.Current.Session;
                if (sess["CurrentPage"] == null)
                    return "";
                else
                    return sess["CurrentPage"].ToString();
            }
            set
            {
                HttpSessionState sess = HttpContext.Current.Session;
                sess["CurrentPage"] = value;
            }
        }
        public static  int SiteId {

            get
            {
                HttpSessionState sess = HttpContext.Current.Session;
                if (sess["SiteId"] == null)
                    return 0;
                else
                    return Convert.ToInt32(sess["SiteId"]);
            }
            set
            {
                HttpSessionState sess = HttpContext.Current.Session;
                sess["SiteId"] = value;
            }
        
        
        }

        public static int AAASiteId
        {

            get
            {
                HttpSessionState sess = HttpContext.Current.Session;
                if (sess["AAASiteId"] == null)
                    return 0;
                else
                    return Convert.ToInt32(sess["AAASiteId"]);
            }
            set
            {
                HttpSessionState sess = HttpContext.Current.Session;
                sess["AAASiteId"] = value;
            }


        }

        public static bool blnADRCIADataEntry {
            get
            {
                HttpSessionState sess = HttpContext.Current.Session;
                if (sess["blnADRCIADataEntry"] == null)
                    return false;
                else
                    return bool.Parse(sess["blnADRCIADataEntry"].ToString());
            }
            set
            {
                HttpSessionState sess = HttpContext.Current.Session;
                sess["blnADRCIADataEntry"] = value;
            }
            
        
        }
        public static bool blnADRCIAAdmin {

            get
            {
                HttpSessionState sess = HttpContext.Current.Session;
                if (sess["blnADRCIAAdmin"] == null)
                    return false;
                else
                    return bool.Parse(sess["blnADRCIAAdmin"].ToString());
            }
            set
            {
                HttpSessionState sess = HttpContext.Current.Session;
                sess["blnADRCIAAdmin"] = value;
            }
            
        
        }

        public static bool blnADRCIAOSAAdmin { 
        
           get
            {
                HttpSessionState sess = HttpContext.Current.Session;
                if (sess["blnADRCIAOSAAdmin"] == null)
                    return false;
                else
                    return bool.Parse(sess["blnADRCIAOSAAdmin"].ToString());
            }
            set
            {
                HttpSessionState sess = HttpContext.Current.Session;
                sess["blnADRCIAOSAAdmin"] = value;
            }
        
        
        }



        public static string strValidateDDSelectionAllowZero
        {
            get { return @"[0-9]*"; }
        }
        public static int intProviderSiteID { get; set; }

        public static string strUserType
        {
            get
            {
                HttpSessionState sess = HttpContext.Current.Session;
                if (sess["AUTH_Type"] == null)
                    return "";
                else
                    return sess["AUTH_Type"].ToString();
            }
            set
            {
                HttpSessionState sess = HttpContext.Current.Session;
                sess["AUTH_Type"] = value;
            }
        }

        public static bool blnLoggedIn
        {
            get
            {
                HttpSessionState sess = HttpContext.Current.Session;
                if (sess["LoggedIn"] == null)
                    return false;
                else
                    return bool.Parse(sess["LoggedIn"].ToString());
            }
            set
            {
                HttpSessionState sess = HttpContext.Current.Session;
                sess["LoggedIn"] = value;
            }
        }


        public static  string AAAAgencyName {

            get
            {
                HttpSessionState sess = HttpContext.Current.Session;
                if (sess["AgencyName"] == null)
                    return "";
                else
                    return sess["AgencyName"].ToString();
            }
            set
            {
                HttpSessionState sess = HttpContext.Current.Session;
                sess["AgencyName"] = value;
            }
        
        }

        public static string UserFullName {

            get
            {
                HttpSessionState sess = HttpContext.Current.Session;
                if (sess["UserFullName"] == null)
                    return "";
                else
                    return sess["UserFullName"].ToString();
            }
            set
            {
                HttpSessionState sess = HttpContext.Current.Session;
                sess["UserFullName"] = value;
            }
        
        
        }
        public static string ADRCAgencyName { 
            get
            {
                HttpSessionState sess = HttpContext.Current.Session;
                if (sess["ADRCAgencyName"] == null)
                    return "";
                else
                    return sess["ADRCAgencyName"].ToString();
            }
            set
            {
                HttpSessionState sess = HttpContext.Current.Session;
                sess["ADRCAgencyName"] = value;
            } 
        }

        // Added by:SM
        // Date: 23 June 2014
        // Purpose: Prevent/allow mobile user to download Report   

        public static bool blnIsMobileAgent
        {
            get
            {
                HttpSessionState sess = HttpContext.Current.Session;

                if (sess["IsMobileAgent"] == null)
                    return false;
                else
                    return Convert.ToBoolean(sess["IsMobileAgent"]);
            }
            set
            {
                HttpSessionState sess = HttpContext.Current.Session;
                sess["IsMobileAgent"] = value;
            }
        }
        // Added By PA
        public static string strActiveModule
        {
            get
            {
                HttpSessionState sess = HttpContext.Current.Session;
                if (sess["ActiveModule"] == null)
                    return "";
                else
                    return sess["ActiveModule"].ToString();
            }
            set
            {
                HttpSessionState sess = HttpContext.Current.Session;
                sess["ActiveModule"] = value;
            }
        }
        
    }
   
    

}
