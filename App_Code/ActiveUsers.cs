using Microsoft.Practices.EnterpriseLibrary.Data;
using System;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Web;

/// <summary>
/// Added by KP on 23th Feb 2023(SOW-654)
/// This file has code realated to user session restriction management 
/// </summary>
public class ActiveUsers
{
    public static string AppType
    {
        //Note: Change the database name as per need of an application.
        get
        {
            return "PC";
        }
    }
    public static string DBName
    {
        //Note: Change the database name as per need of an application.
        get
        {
            return "User";
        }
    }

    public static string strConnString
    {
        //Note: Change the way of connection retrieving as per need of an application.
        get
        {
            return ConfigurationManager.ConnectionStrings[ADRCIA.MySession.strAppDB].ConnectionString;
        }
        //get
        //{
        //    return (string)AISProtectData.DPAPI.UnProtectData(ConfigurationManager.AppSettings["connString"].ToString());
        //}
    }

    /// <summary>
    /// Gets the maximum number of active sessions allowed in the application.
    /// It retrieves the value from the application configuration settings.
    /// If the "MaxActiveSessions" key is not present in the configuration or its value is less than or equal to 2, this property will return the default value of 2.
    /// </summary>
    public static int MaxActiveSessions
    {
        get
        {
            const int defaultMaxSessions = 2;

            int maxSessions;
            if (int.TryParse(GetAppSetting("MaxActiveSessions"), out maxSessions) && maxSessions > defaultMaxSessions)
                return maxSessions;

            return defaultMaxSessions;
        }
    }

    /// <summary>
    /// Gets a value indicating whether the maximum session popup feature is enabled.
    /// </summary>
    public static bool EnableMaxSessionPopup
    {
        get
        {
            string value = GetAppSetting("EnableMaxSessionPopup");
            if (value != null && Convert.ToInt32(value) == 1)
                return true;
            else
                return false;
        }

    }

    /// <summary>
    /// Added By - AV
    /// Date - 05 Feb 2024
    /// Purpose - To get 'EnableMaxSessionPopup' and 'MaxActiveSession' value from DB.
    /// </summary>
    public static string GetAppSetting(string key)
    {
        Database db = DatabaseFactory.CreateDatabase(ADRCIA.MySession.strAppDB);
        DbProviderFactory dbpf = db.DbProviderFactory;
        try
        {
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(strConnString), dbpf);
            using (DbCommand dbCommand = db.GetStoredProcCommand("AISCommonUtility.dbo.psGetAppSetting"))
            {
                db.AddInParameter(dbCommand, "@Key", DbType.String, key);
                db.AddOutParameter(dbCommand, "@Result", DbType.String, 25);

                db.ExecuteNonQuery(dbCommand);
                if (db.GetParameterValue(dbCommand, "@Result") != DBNull.Value)
                    return db.GetParameterValue(dbCommand, "@Result").ToString();
                else
                    return null;
            }
        }
        catch (Exception)
        {
            throw;
        }
        finally
        {
            db = null;
            dbpf = null;
        }
    }

    /// <summary>
    /// Added by KP on 27th Feb 2023(SOW-654)
    /// Purpose: Delete active user session record from the tracking list and table.  
    /// </summary>
    /// <param name="SessionID"></param>
    /// <param name="Command"></param>
    public static void RemoveUserFromActiveUserList(string SessionID)
    {       
        UserSessionInfo_Delete(SessionID);
    }

    /// <summary>
    /// Added by KP on 27th Feb 2023(SOW-654)
    /// Extends/update the current user's session date time in table 
    /// </summary>
    /// <param name="SessionID"></param>
    /// <returns></returns>
    public static string UserSessionInfo_Update(string SessionID, string Url = "NA")
    {
       // Url, Session["IPAddressforClient"].ToString(), strBorwserType
        SqlConnection objConn = null;
        string msgResul = "";
        try
        {
            objConn = new SqlConnection(strConnString);
            string strSP = string.Format("{0}.dbo.psUserSessionInfo_Update", DBName);
            SqlCommand objCmd = new SqlCommand(strSP, objConn);
            objCmd.CommandType = CommandType.StoredProcedure;

            SqlParameter strParam0 = new SqlParameter("@SessionID", SqlDbType.VarChar, 100);
            strParam0.Value = SessionID;
            objCmd.Parameters.Add(strParam0);
            strParam0.Direction = ParameterDirection.Input;

            SqlParameter strParam1 = new SqlParameter("@UserID", SqlDbType.VarChar, 100);
            strParam1.Value = HttpContext.Current.Session["AUTH_USER"].ToString();
            objCmd.Parameters.Add(strParam1);
            strParam1.Direction = ParameterDirection.Input;

            SqlParameter strParam2 = new SqlParameter("@Url", SqlDbType.VarChar, 100);
            strParam2.Value = Url;
            objCmd.Parameters.Add(strParam2);
            strParam2.Direction = ParameterDirection.Input;

            SqlParameter strParam3 = new SqlParameter("@AppType", SqlDbType.VarChar, 200);
            strParam3.Value = ActiveUsers.AppType;
            objCmd.Parameters.Add(strParam3);
            strParam3.Direction = ParameterDirection.Input;


            SqlParameter strParam4 = new SqlParameter("@Result", SqlDbType.VarChar, 100);
            objCmd.Parameters.Add(strParam4);
            strParam4.Direction = ParameterDirection.Output;

            objConn.Open();
            objCmd.ExecuteNonQuery();
            msgResul = objCmd.Parameters["@Result"].Value.ToString();
            objCmd.Dispose();

        }
        catch (Exception ex) { throw new Exception(ex.Message.ToString(), ex.InnerException); }
        finally
        {
            if (objConn != null && objConn.State == ConnectionState.Open)
            {
                objConn.Close();
                objConn.Dispose();
            }
        }
        return msgResul;

    }

    /// <summary>
    /// Added by KP on 27th Feb 2023(SOW-654)
    /// Purpose: Delete active user's session record from the tracking table.   
    /// </summary>
    /// <param name="SessionID"></param>
    public static void UserSessionInfo_Delete(string SessionID)
    {
        SqlConnection objConn = null;
        try
        {
            objConn = new SqlConnection(strConnString);
            string strSP = string.Format("{0}.dbo.psUserSessionInfo_Delete", DBName);
            SqlCommand objCmd = new SqlCommand(strSP, objConn);
            objCmd.CommandType = CommandType.StoredProcedure;

            SqlParameter strParam0 = new SqlParameter("@SessionIDs", SqlDbType.VarChar, 100);
            strParam0.Value = SessionID;
            objCmd.Parameters.Add(strParam0);
            strParam0.Direction = ParameterDirection.Input;

            objConn.Open();
            objCmd.ExecuteNonQuery();
            objCmd.Dispose();

        }
        catch (Exception ex) { throw new Exception(ex.Message.ToString(), ex.InnerException); }
        finally
        {
            if (objConn != null && objConn.State == ConnectionState.Open)
            {
                objConn.Close();
                objConn.Dispose();
            }
        }
    }
    
}