using System;
using System.DirectoryServices;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;






/// <summary>
/// Summary description for LDAPActivDirectory
/// </summary>
namespace ADRCIA
{
    #region enums
    public enum AdsUserFlags
    {
        Script = 1,                          // 0x1
        AccountDisabled = 2,                 // 0x2
        HomeDirectoryRequired = 8,           // 0x8 
        AccountLockedOut = 16,               // 0x10
        PasswordNotRequired = 32,            // 0x20
        PasswordCannotChange = 64,           // 0x40
        EncryptedTextPasswordAllowed = 128,  // 0x80
        TempDuplicateAccount = 256,          // 0x100
        NormalAccount = 512,                 // 0x200
        InterDomainTrustAccount = 2048,      // 0x800
        WorkstationTrustAccount = 4096,      // 0x1000
        ServerTrustAccount = 8192,           // 0x2000
        PasswordDoesNotExpire = 65536,       // 0x10000
        MnsLogonAccount = 131072,            // 0x20000
        SmartCardRequired = 262144,          // 0x40000
        TrustedForDelegation = 524288,       // 0x80000
        AccountNotDelegated = 1048576,       // 0x100000
        UseDesKeyOnly = 2097152,              // 0x200000
        DontRequirePreauth = 4194304,         // 0x400000
        PasswordExpired = 8388608,           // 0x800000
        TrustedToAuthenticateForDelegation = 16777216, // 0x1000000
        NoAuthDataRequired = 33554432        // 0x2000000
    }
    #endregion

    public class LDAPActivDirectory
    {

        public bool IsAuthenticated(string strDomain, string strUser, string strPassword)
        {
            string strDomainAndUsername = strDomain + @"\" + strUser;
            DirectoryEntry entry = new DirectoryEntry(MySession.myWebConfig.adPath, strDomainAndUsername, strPassword);

            try
            {
                //bind to the native AdsObject to force authentication
                Object obj = entry.NativeObject;
                
                return true;
            }
            catch (Exception ex)
            {
                // We encounter an exception every time we try to log in on localhost, 
                // so we probably want to ignore the error (other than to not let user in)

                return false;
            }

        }
        /// <summary>
        /// Created by SA on 4th Feb, 2015.
        /// Purpose: Get User Info 
        /// </summary>
        /// <param name="OuName"></param>
        /// <returns></returns>
        public static DataTable GetUserInfoListOfOu(string OuName)
        {
            DataTable dt = DTStructure();
            StringBuilder UserGuid = new StringBuilder();
            string strDomainAndUsername = MySession.myWebConfig.domain + @"\" + MySession.strUserName;
            string OuDn = "OU=" + OuName;
            string ldapPrefix = MySession.myWebConfig.adPath.Substring(0, MySession.myWebConfig.adPath.LastIndexOf('/'));
            string ldapSuffix = MySession.myWebConfig.adPath.Substring(MySession.myWebConfig.adPath.LastIndexOf('/') + 1);
            DirectoryEntry entry = new DirectoryEntry(ldapPrefix + "/" + OuDn + "," + ldapSuffix, strDomainAndUsername, HttpContext.Current.Session["AUTH_PASSWORD"].ToString());//Session["AUTH_USER"].ToString(), Session["AUTH_PASSWORD"].ToString()
            DirectorySearcher SearchGroup = new DirectorySearcher(entry);
            SearchGroup.Filter = "(&(objectCategory=group))";
            SearchResultCollection ResultCollection = SearchGroup.FindAll();
            foreach (SearchResult groupResult in ResultCollection)
            {
                // DirectoryEntry groups = groupResult.GetDirectoryEntry();

                foreach (object ugroup in groupResult.Properties["member"])
                {
                    if (ugroup.ToString().Split(",=".ToCharArray()).Where(a => a == "CN").Count() != 0)
                    {
                        DirectoryEntry user = new DirectoryEntry(ldapPrefix + "/" + ugroup.ToString() + "", strDomainAndUsername, HttpContext.Current.Session["AUTH_PASSWORD"].ToString());//Session["AUTH_USER"].ToString(), Session["AUTH_PASSWORD"].ToString()
                        int userAccountControl = (int)user.Properties["userAccountControl"][0];
                        user.Close();
                        if (!((userAccountControl & 2) > 0))
                        {
                            DataRow newRow = dt.NewRow();
                            //UserGuid.Append(ugroup.ToString().Split(",=".ToCharArray())[1] + ",");
                            newRow["UserName"] = ugroup.ToString().Split(",=".ToCharArray())[1];
                            GetUserInfo(newRow["UserName"].ToString().Trim(), dt);
                        }
                    }
                }
            }
            entry.Close();
            entry.Dispose();
            return dt;
        }
        /// <summary>
        /// Created by SA on 4th Feb, 2015. 
        /// </summary>
        /// <param name="UserName"></param>
        /// <param name="dt"></param>
        public static void GetUserInfo(string UserName, DataTable dt)
        {

            DataRow newRow = dt.NewRow();
            if (dt.Rows.Count == 0)
            {
                newRow = dt.NewRow();
                newRow["UserName"] = UserName;
            }
            else
            {
                for (int i = 1; i <= dt.Rows.Count; i++)
                {
                    newRow = dt.NewRow();
                    newRow["UserName"] = UserName;
                }
            }
            dt.Rows.Add(newRow);
            

        }
        /// <summary>
        /// Created by SA on 4th Feb, 2015.
        /// </summary>
        /// <returns></returns>
        private static DataTable DTStructure()
        {
            DataTable tblUserInfoList = new DataTable();
            tblUserInfoList.Columns.Add(new DataColumn("UserName", typeof(string)));
            
            return tblUserInfoList;
        }

    }
}