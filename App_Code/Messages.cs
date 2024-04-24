using System;
using System.Data;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Configuration;
using System.Web.Security;
using System.Security.Cryptography;
using AISProtectData;
using Microsoft.Security.Application;

namespace ADRCIA
{
    public class Messages
    {
      
        // we use a DataSet instead of IDataReader because we want to allow paging and sorting
   
      
        /// <summary>
        /// Created By:SM
        /// Date:06/28/2013
        /// Purpose: Get message list on the basis of siteid.
        /// </summary>
        /// <param name="intSiteID"></param>
        /// <returns></returns>
        public static DataSet getADRCIAMessageList(int intSiteID)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psARRCIAMessage_LIST";
         
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@SiteID", DbType.Int32, intSiteID);
                return  db.ExecuteDataSet(dbCommand);
            }

           
        }

        /// <summary>
        /// Created BY: SM
        /// Date: 06/28/2013
        /// Purpose: Get ADRCIA Active msg. 
        /// </summary>
        /// <returns></returns>
        public static IDataReader getADRCIAActiveMessages()
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);

            string cmd = "psADRCIAMessageActive_LIST";
         
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@SiteID", DbType.Int32, MySession.SiteId);
               return (IDataReader) db.ExecuteReader(dbCommand);
            }

            
        }

        /// <summary>
        /// Created By: SM
        /// Date:06/28/2013
        /// Purpose:Get message details on the basis of messageid.
        /// </summary>
        /// <param name="intMessageID"></param>
        /// <returns></returns>
        public static IDataReader getADRCIAMessage(int intMessageID)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psADRCIAMessage_GET";
        
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@MessageID", DbType.Int32, intMessageID);
                return (IDataReader) db.ExecuteReader(dbCommand);
            }

        
        }

      
        /// <summary>
        /// Created By; SM
        /// Date:06/28/2013
        /// Purpose: Delete the message on the basis of messageid.
        /// </summary>
        /// <param name="intMessageID"></param>
        public static void deleteADRCIAMessage(int intMessageID)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psADRCIAMessage_DELETE";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@MessageID", DbType.Int32, intMessageID);
                db.AddInParameter(dbCommand, "@Username", DbType.String, MySession.strUserName);
                db.ExecuteNonQuery(dbCommand);
            }


        }
        

        /// <summary>
        /// Created By: SM
        /// Date:06/28/2013
        /// Purpose:Set message details for a site id
        /// </summary>
        /// <param name="intMessageID"></param>
        /// <param name="intSiteID"></param>
        /// <param name="strMessageText"></param>
        /// <param name="dtDateFrom"></param>
        /// <param name="dtDateTo"></param>
        /// <param name="blnCritical"></param>
        public static void setADRCIAMessage(int intMessageID, int intSiteID, string strMessageText, DateTime dtDateFrom, DateTime dtDateTo, bool blnCritical)
                                       
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psADRCIAMessage_SET";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@MessageID", DbType.Int32, intMessageID);
                db.AddInParameter(dbCommand, "@SiteID", DbType.Int32, intSiteID);
                db.AddInParameter(dbCommand, "@DateFrom", DbType.DateTime, Sanitizer.GetSafeHtmlFragment(dtDateFrom.ToShortDateString()));  //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@DateTo", DbType.DateTime, Sanitizer.GetSafeHtmlFragment(dtDateTo.ToShortDateString()));      //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@Critical", DbType.Boolean, blnCritical);
                db.AddInParameter(dbCommand, "@MessageText", DbType.String, Sanitizer.GetSafeHtmlFragment(strMessageText));                 //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@UserName", DbType.String, MySession.strUserName);
                db.ExecuteNonQuery(dbCommand);
            }
        }

    }
 
}