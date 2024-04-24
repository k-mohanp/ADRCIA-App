using System;
using System.Linq;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Security.Cryptography;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Threading;
using System.Collections.Generic;
using Microsoft.Security.Application;

namespace ADRCIA
{
    public class ADRCIADAL
    {
        public static DataTable GetContactDetails(int NeedyPersonID)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psGetContactDetails";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@NeedyPersonID", DbType.Int32, NeedyPersonID);
                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }

        /// <summary>
        /// Created By: SM
        /// Date:03/06/2013
        /// Purpose: Get common data for filling all dropdwon 
        /// </summary>
        /// <returns></returns>
        public static DataSet GetCommonData()
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psGetCommonData";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                return db.ExecuteDataSet(dbCommand);
            }
        }

        /// <summary>
        /// Created By: SA Akhtar
        /// Date:29th Dec, 2014
        /// Purpose: Get Primary and Other Language 
        /// </summary>
        /// <returns></returns>
        public static DataTable getPOLanguages()
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "[psGetPrimaryLanguage]";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }

        /// <summary>
        /// Created By : SM
        /// Date:04/11/2013
        /// Purpose: Get AdRC Agency List Name in  Ref By and Ref To DropDown
        /// </summary>
        /// <returns></returns>
        public static DataSet GetADRCAgencyList()
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psGetADRCAgencyList";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                return db.ExecuteDataSet(dbCommand);
            }
        }

        

        /// <summary>
        /// Created By: SM
        /// Date: 03/06/2013
        /// Purpose: get Person needing assistance
        /// </summary>
        /// <returns></returns>
        public static DataTable GetPersonNeeding(string FirstName, string LastName, string strPhone, string SearchType, int IsUpdateCall, int? SiteId = 0, int? AAAsiteID = 0, string ContactFirstName = "", string ContactLastName = "", string ContactPhone = "")
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);

            string cmd = "";
            if (IsUpdateCall == 1)
                cmd = "psGetNeedyPersonList_UpdateCall";
            else
                cmd = "psGetNeedyPersonList";


            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@AAASiteID", DbType.Int32, AAAsiteID);
                db.AddInParameter(dbCommand, "@FKSiteID", DbType.Int32, SiteId);

                db.AddInParameter(dbCommand, "@FName", DbType.String, FirstName);
                db.AddInParameter(dbCommand, "@LName", DbType.String, LastName);
                db.AddInParameter(dbCommand, "@Phone", DbType.String, strPhone);
                db.AddInParameter(dbCommand, "@SearchType", DbType.String, SearchType);
                db.AddInParameter(dbCommand, "@IsUpdateCall", DbType.Int16, IsUpdateCall);
                //Added by KP on 22 Sept 2017 - Sow-485
                db.AddInParameter(dbCommand, "@ContactFName", DbType.String, ContactFirstName);
                db.AddInParameter(dbCommand, "@ContactLName", DbType.String, ContactLastName);
                db.AddInParameter(dbCommand, "@ContactPhone", DbType.String, ContactPhone);
                //end 

                return db.ExecuteDataSet(dbCommand).Tables[0];
            }

        }

        int? needyIdFrom = null, needyIdTo = null;
        string firstNameFrom, middleNameFrom, lastNameFrom;
        string firstNameTo, middleNameTo, lastNameTo;

        public static DataTable GetPersonNeedyListForMerge(int AgencyID, int? NeedyPersonIdFrom, int? NeedyPersonIdTo,
            string FirstNameFrom, string MiddleNameFrom, string LastNameFrom, string FirstNameTo, string MiddleNameTo, string LastNameTo)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);

            string cmd = "psGetNeedyPersonForMerge";

            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@AgencyID", DbType.Int32, AgencyID);
                db.AddInParameter(dbCommand, "@NeedyPersonIDFrom", DbType.Int32, NeedyPersonIdFrom);
                db.AddInParameter(dbCommand, "@NeedyPersonIDTo", DbType.Int32, NeedyPersonIdTo);

                db.AddInParameter(dbCommand, "@FirstNameFrom", DbType.String, Sanitizer.GetSafeHtmlFragment(FirstNameFrom));    //Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data
                db.AddInParameter(dbCommand, "@MiddleNameFrom", DbType.String, Sanitizer.GetSafeHtmlFragment(MiddleNameFrom));  //Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data
                db.AddInParameter(dbCommand, "@LastNameFrom", DbType.String, Sanitizer.GetSafeHtmlFragment(LastNameFrom));      //Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data

                db.AddInParameter(dbCommand, "@FirstNameTo", DbType.String, Sanitizer.GetSafeHtmlFragment(FirstNameTo));        //Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data                      
                db.AddInParameter(dbCommand, "@MiddleNameTo", DbType.String, Sanitizer.GetSafeHtmlFragment(MiddleNameTo));      //Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data
                db.AddInParameter(dbCommand, "@LastNameTo", DbType.String, Sanitizer.GetSafeHtmlFragment(LastNameTo));          //Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data

                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }

        /// <summary>
        /// Created by GK on 03July18 : 
        /// </summary>
        /// <param name="MergeInto"></param>
        /// <param name="ListMergeFrom"></param>
        /// <returns></returns>
        public static int MergeDuplicateNeedyPerson(int MergeInto, List<int> ListMergeFrom)
        {
            var retVal = 0;
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            try
            {
                db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
                using (DbCommand dbCommand = db.GetStoredProcCommand("psMoveUnderneathDataOfNeedyPerson"))
                {
                    db.AddInParameter(dbCommand, "@MergeInto", DbType.Int32, MergeInto);
                    db.AddInParameter(dbCommand, "@MergeFromList", DbType.String, string.Join(",", ListMergeFrom.Select(x => x.ToString()).ToList()));

                    retVal = db.ExecuteNonQuery(dbCommand);
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                db = null;
                dbpf = null;
            }
            return retVal;
        }

        /// <summary>
        /// Created By:SM
        /// Date:03/06/2013
        /// Purpose:Get County name
        /// </summary>
        /// <param name="CountyId"></param>
        /// <returns></returns>
        public static DataTable GetCountyName()
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "Resource.dbo.psAdrcPub_GetCounty";

            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }

        /// <summary>
        /// Created By: SA
        /// Date: 07/14/2014
        /// Purpose: Get County, City and Staff agency wise. 
        /// </summary>
        public static DataSet GetAgencyWiseDetails(string SiteID = "", string County = "", string Staff = "Staff")
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "PSReportGetCountyCity";

            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@SiteID", DbType.String, SiteID);
                db.AddInParameter(dbCommand, "@County", DbType.String, County);
                db.AddInParameter(dbCommand, "@QueryType", DbType.String, Staff);


                return db.ExecuteDataSet(dbCommand);
            }

        }
       
        /// <summary>
        /// Created By: SA
        /// Date: 4th Feb, 2015.
        /// Purpose: Staff agency wise. 
        /// </summary>
        public static DataTable GetAllUsersByAgency(string SiteID)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "[psGetAllUsersByAgency_get]";

            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@SiteID", DbType.String, SiteID);
                return db.ExecuteDataSet(dbCommand).Tables[0];
            }

        }
        /// <summary>
        /// Created: SM
        /// Date:04/11/2013
        /// Purpose: Get City
        /// </summary>
        /// <param name="CountyID"></param>
        /// <returns></returns>

        public static DataTable GetCityByCounty(int? CountyID)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "Resource.dbo.psADRCPub_GetCityBycountyID";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@CountyID", DbType.Int32, CountyID);
                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }
        /// <summary>
        /// Created By:SM
        /// Date:03/06/2013
        /// Purpose: Get  ADRC Service List
        /// </summary>
        /// <returns></returns>
        public static DataTable GetServicesList()
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "Resource.dbo.psGetADRCServicesBySiteID";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@FKSiteID", DbType.String, HttpContext.Current.Session["CurrentSiteId"]);
                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }

        /// <summary>
        /// Created By:SM
        /// Date:03/06/2013
        /// Purpose: Get  ADRC Service List Agency Wise
        /// </summary>
        /// <returns></returns>
        public static DataTable GetServicesList(string siteid)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            //string cmd = "Resource.dbo.psRptGetADRCServicesBySiteID";//Commented by 16th April 2020(SOW-577)
            string cmd = "psRptGetServicesBySiteID"; //Added by 16th April 2020(SOW-577)


            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@SiteID", DbType.String, siteid);

                return db.ExecuteDataSet(dbCommand).Tables[0];

            }
        }

        /// <summary>
        /// Created By: SM
        /// Date:03/07/23013
        /// </summary>
        /// <param name="objNeedyPerson"></param>
        /// <returns></returns>
        public static int SaveNeedyPerson(PersonNeedAssistance objNeedyPerson)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psSetNeedyPerson";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@NdId", DbType.String, objNeedyPerson.NeedyPersonID);
                db.AddInParameter(dbCommand, "@FKSiteID", DbType.String, Convert.ToString(HttpContext.Current.Session["CurrentSiteId"]));
                db.AddInParameter(dbCommand, "@FirstName", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.FirstName));        //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@MI", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.MI));                      //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@LastName", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.LastName));          //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@PhonePrimary", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.PhonePrimary));  //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@PhoneAlt", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.PhoneAlt));          //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@Email", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.Email));                //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@Address", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.Address));            //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@CityName", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.CityName));          //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@CountyName", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.CountyName));      //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@FKTownshipCode", DbType.String, objNeedyPerson.TownshipCode); // Added by GK on 10Apr19 : SOW-563  
                db.AddInParameter(dbCommand, "@FKCustomCode", DbType.Int32, objNeedyPerson.CustomCode); // Added by GK on 10Apr19 : SOW-563       
                db.AddInParameter(dbCommand, "@State", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.State));      //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@Zip", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.Zip));          //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data //Changed DbType.Int32 to DbType.String by AR, 03-April-2024 
                db.AddInParameter(dbCommand, "@IsContactPreferencePhone", DbType.Int32, objNeedyPerson.ContactPreferencePhone);
                db.AddInParameter(dbCommand, "@IsContactPreferenceEmail", DbType.Int32, objNeedyPerson.ContactPreferenceEmail);
                db.AddInParameter(dbCommand, "@IsContactPreferenceSMS", DbType.Int32, objNeedyPerson.ContactPreferenceSMS);
                db.AddInParameter(dbCommand, "@IsContactPreferenceMail", DbType.Int32, objNeedyPerson.ContactPreferenceMail);

                ////Added By Kuldeep Rathore on 05-13-2015
                //db.AddInParameter(dbCommand, "@IsContactPreferenceOther", DbType.Int32, objNeedyPerson.IsPreferredContactNOther);
                //db.AddInParameter(dbCommand, "@OtherInPersonContact", DbType.String, objNeedyPerson.PreferredContactNOther);
                //// Added Section End Here By Kuldeep Rathore

                db.AddInParameter(dbCommand, "@DOB", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.DOB)); //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@Age", DbType.Int32, objNeedyPerson.Age);
                //Added by VK on 24 April,2019. For AgeOn.
                db.AddInParameter(dbCommand, "@AgeOn", DbType.DateTime, objNeedyPerson.AgeOn);
                db.AddInParameter(dbCommand, "@PrimaryLanguage", DbType.String, objNeedyPerson.PrimaryLanguage);


                db.AddInParameter(dbCommand, "@Gender", DbType.String, objNeedyPerson.Gender);
                db.AddInParameter(dbCommand, "@FKMaritalStatusID", DbType.Int32, objNeedyPerson.MarriageStatusID);
                db.AddInParameter(dbCommand, "@FKRaceID", DbType.Int32, objNeedyPerson.RaceID);
                db.AddInParameter(dbCommand, "@FKEthnicityID", DbType.Int32, objNeedyPerson.EthnicityID);
                db.AddInParameter(dbCommand, "@FKVeteranStatusID", DbType.Int32, objNeedyPerson.VeteranStatusID);

                // Commented by GK on 09Dec,2021 : Ticket #6715
                //db.AddInParameter(dbCommand, "@ServiceReqOther", DbType.String, objNeedyPerson.OtherServiceRequested);

                db.AddInParameter(dbCommand, "@FKReferredByAgencyID", DbType.Int32, objNeedyPerson.ReferredByAgencyID);
                //db.AddInParameter(dbCommand, "@FKReferredToAgencyID", DbType.Int32, objNeedyPerson.ReferredToAgencyID);
                db.AddInParameter(dbCommand, "@FKReferredToAgencyID", DbType.String, objNeedyPerson.getRefToADRCIDs);
                db.AddInParameter(dbCommand, "@ReferredByOtherAgency", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.ReferredByOtherAgency)); //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@ReferredToOtherAgency", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.ReferredToOtherAgency)); //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@ReferredToOtherServiceProvider", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.ReferredToOtherServiceProvider)); //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@AltFirstName", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.AltFirstName));       //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@AltMI", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.AltMI));                     //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@AltLastName", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.AltLastName));         //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@AltPhone", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.AltPhone));               //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@AltEmail", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.AltEmail));               //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@AltRelationShip", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.AltRelationship)); //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data

                db.AddInParameter(dbCommand, "@CreatedBy", DbType.String, MySession.strUserName);

                db.AddInParameter(dbCommand, "@VetApplicable", DbType.String, objNeedyPerson.VeteranApplicable);
                db.AddInParameter(dbCommand, "@LivingID", DbType.Int32, objNeedyPerson.LivingID);
                //Referred to service provider
                db.AddInParameter(dbCommand, "@FKRefToServiceProviderID", DbType.String, objNeedyPerson.ReferredToServiceProvider);
                // Added By: SM, Date: 03 June 2014,Purpose: Add/Edit Permission Granted  values
                db.AddInParameter(dbCommand, "@IsPermissionGranted", DbType.Int32, objNeedyPerson.IsPermissionGranted);
                // Added by SA on 3-11-2014, SOW-335
                db.AddInParameter(dbCommand, "@DisabilityTypes", DbType.Int32, objNeedyPerson.DisabilityTypes);
                db.AddInParameter(dbCommand, "@DisabilityTypesOther", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.DisabilityTypesOther)); //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data

                db.AddInParameter(dbCommand, "@IsServicesAlreadyinPlace", DbType.Boolean, objNeedyPerson.IsServicesAlreadyinPlace);
                db.AddInParameter(dbCommand, "@ServicesAlreadyinPlaceNotes", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.ServicesAlreadyinPlaceNotes)); //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@IsDisability", DbType.String, objNeedyPerson.IsDisability);

                db.AddInParameter(dbCommand, "@PhonePrimaryExtn", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.PhonePrimaryExtn));//Added By BS on 15-sep-2016 //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@PhoneAltExtn", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.PhoneAltExtn));//Added By BS on 15-sep-2016 //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@AltPhoneExtn", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.AltPhoneExtn));//Added By BS on 15-sep-2016 //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@PrimaryFax", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.NPrimaryFax));//Added By BS on 19-dec-2016 //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@FaxAlt", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.NAltFax));//Added By BS on 19-dec-2016 //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                                                                                                                              //Commented by vk on 16 Aug,2017 , this value capture in tblcallhistory.  
                                                                                                                              //db.AddInParameter(dbCommand, "@IsFundProvided", DbType.Boolean, objNeedyPerson.IsFundsProvided);//Added By KR on 21 March 2017
                                                                                                                              // db.AddInParameter(dbCommand, "@FundProvided", DbType.Decimal, objNeedyPerson.FundsProvidedAmount);//Added By KR on 21 March 2017

                db.AddOutParameter(dbCommand, "@NeedPersonID", DbType.Int32, 10);
                db.AddOutParameter(dbCommand, "@Message", DbType.String, 5000);

                db.AddInParameter(dbCommand, "@IsDemographics", DbType.Boolean, objNeedyPerson.IsDemographics);//Added by KP on 28-Sep-2017 - SOW-485  
                db.AddInParameter(dbCommand, "@Title", DbType.String, objNeedyPerson.Title);//Added By KP on 31st Jan 2020(SOW-577)

                db.ExecuteNonQuery(dbCommand);

                HttpContext.Current.Session["Message"] = db.GetParameterValue(dbCommand, "@Message");
                int NeedPersonID = Convert.ToInt32(db.GetParameterValue(dbCommand, "@NeedPersonID"));
                return NeedPersonID;
            }
        }
        /// <summary>
        /// Created By: SM
        /// date:03/07/2013
        /// Purpose: Save /Update contact person details
        /// </summary>
        /// <param name="objPerson"></param>
        /// <returns></returns>

        public static int SaveContactPerson(PersonContact objPerson)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psSetContactPerson";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@PersonNeedingDetailID", DbType.Int32, objPerson.NeedyPersonID);
                db.AddInParameter(dbCommand, "@PersonContactID", DbType.Int32, objPerson.ContactPersonID);
                db.AddInParameter(dbCommand, "@IsPrimaryContactPerson", DbType.Int32, objPerson.IsPrimaryContactPerson);
                db.AddInParameter(dbCommand, "@FirstName", DbType.String, Sanitizer.GetSafeHtmlFragment(objPerson.FirstName));       //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@MI", DbType.String, Sanitizer.GetSafeHtmlFragment(objPerson.MI));                     //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@LastName", DbType.String, Sanitizer.GetSafeHtmlFragment(objPerson.LastName));         //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@PhonePrimary", DbType.String, Sanitizer.GetSafeHtmlFragment(objPerson.PhonePrimary)); //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@PhoneAlt", DbType.String, Sanitizer.GetSafeHtmlFragment(objPerson.PhoneAlt));         //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@Email", DbType.String, Sanitizer.GetSafeHtmlFragment(objPerson.Email));               //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@Address", DbType.String, Sanitizer.GetSafeHtmlFragment(objPerson.Address));           //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@CityName", DbType.String, Sanitizer.GetSafeHtmlFragment(objPerson.CityName));         //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@CountyName", DbType.String, Sanitizer.GetSafeHtmlFragment(objPerson.CountyName));     //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@State", DbType.String, Sanitizer.GetSafeHtmlFragment(objPerson.State));               //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@Zip", DbType.String, Sanitizer.GetSafeHtmlFragment(objPerson.Zip));                   //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data //Changed DbType.Int32 to DbType.String by AR, 03-April-2024
                db.AddInParameter(dbCommand, "@IsContactPreferencePhone", DbType.Int32, objPerson.ContactPreferencePhone);
                db.AddInParameter(dbCommand, "@IsContactPreferenceEmail", DbType.Int32, objPerson.ContactPreferenceEmail);
                db.AddInParameter(dbCommand, "@IsContactPreferenceSMS", DbType.Int32, objPerson.ContactPreferenceSMS);
                db.AddInParameter(dbCommand, "@IsContactPreferenceMail", DbType.Int32, objPerson.ContactPreferenceMail);
                db.AddInParameter(dbCommand, "@IsContactPreferenceOther", DbType.Int32, objPerson.ContactPreferenceOthers); //Added By Kuldeep Rathore on 05/12/2015.
                db.AddInParameter(dbCommand, "@ContactPreferenceOthersInPerson", DbType.String, Sanitizer.GetSafeHtmlFragment(objPerson.ContactPreferenceOthersInPerson)); //Added By Kuldeep Rathore on 05/12/2015. //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@CreatedBy", DbType.String, MySession.strUserName);
                db.AddOutParameter(dbCommand, "@ContactPersonID", DbType.Int32, 10);

                db.AddInParameter(dbCommand, "@Relationship", DbType.String, Sanitizer.GetSafeHtmlFragment(objPerson.Relationship)); //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@PhonePrimaryExtn", DbType.String, Sanitizer.GetSafeHtmlFragment(objPerson.PhonePrimaryExtn));//Added By BS on 15-sep-2016. //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                db.AddInParameter(dbCommand, "@PhoneAltExtn", DbType.String, Sanitizer.GetSafeHtmlFragment(objPerson.PhoneAltExtn));//Added By BS on 15-sep-2016.
                db.AddInParameter(dbCommand, "@Fax", DbType.String, Sanitizer.GetSafeHtmlFragment(objPerson.CFax));//Added By BS on 19-dec-2016. //Modified by AR, 21-March-2024 | T#24525 | Sanitization of Data
                                                                                                                   // db.AddInParameter(dbCommand, "@IsCaregiver", DbType.String, objPerson.IsContactCaregiver);//Added By VK on 03 Aug,2017.

                db.ExecuteNonQuery(dbCommand);

                int ContactPersonID = Convert.ToInt32(db.GetParameterValue(dbCommand, "@ContactPersonID"));
                return ContactPersonID;
            }
        }
        /// <summary>
        /// Created by SA.
        /// Purpose: Save OC Details.
        /// </summary>
        /// <param name="objNeedyPerson"></param>
        public static void SaveOptionCounselling(PersonNeedAssistance objNeedyPerson)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "pssetOptionCounselling";


            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {

                //OCFinancialNotes
                // Financial Notes
                db.AddInParameter(dbCommand, "@OCFinancialNotes", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.OCFinancialNotes));     //Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data
                // needy Person id
                db.AddInParameter(dbCommand, "@NeedyPersonID", DbType.Int32, objNeedyPerson.NeedyPersonID);
                // Care giver status
                db.AddInParameter(dbCommand, "@IsCareGiverStatus", DbType.Boolean, objNeedyPerson.IsCareGiverStatus);
                // Insurance type
                db.AddInParameter(dbCommand, "@InsuranceTypes", DbType.String, objNeedyPerson.InsuranceTypes);
                db.AddInParameter(dbCommand, "@InsuranceTypesOther", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.InsuranceTypesOther));   //Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data
                //OC Trigger present
                db.AddInParameter(dbCommand, "@IsOCTriggerPresent", DbType.Boolean, objNeedyPerson.IsOCTriggerPresent);
                //OC Triggers
                db.AddInParameter(dbCommand, "@OCTriggers", DbType.String, objNeedyPerson.OCTriggers);
                // Lacks memory Is reported
                db.AddInParameter(dbCommand, "@LMIsReportedDiagnosed", DbType.Int32, objNeedyPerson.LMIsReportedDiagnosed);
                // Lacks memory Is diagnosed
                db.AddInParameter(dbCommand, "@LacksMemoryYesNo", DbType.Boolean, objNeedyPerson.LacksMemoryYesNo);
                // Lacks memory Impairements
                db.AddInParameter(dbCommand, "@LMImpairements", DbType.Int32, objNeedyPerson.LMImpairements);
                // Total asset amount
                db.AddInParameter(dbCommand, "@TotalAssetAmount", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.TotalAssetAmount));        //Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data
                // House hold income
                db.AddInParameter(dbCommand, "@TotalHouseholdIncome", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.HouseholdIncome));     //Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data
                // spouse income
                db.AddInParameter(dbCommand, "@TotalSpouseIncome", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.SpouseIncome));           //Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data
                // client income
                db.AddInParameter(dbCommand, "@TotalClientIncome", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.ClientIncome));          //Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data
                // Is no to develop
                db.AddInParameter(dbCommand, "@IsNotToDevelop", DbType.Boolean, objNeedyPerson.IsNotToDevelop);
                // Is to develop
                db.AddInParameter(dbCommand, "@IsToDevelop", DbType.Boolean, objNeedyPerson.IsToDevelop);
                // Is permission for call
                db.AddInParameter(dbCommand, "@IsPermissionForCall", DbType.Boolean, objNeedyPerson.IsPermissionForCall);


                db.ExecuteNonQuery(dbCommand);
            }
        }

        /// <summary>
        /// Created on 16-12-2014.
        /// Purpose: get TimeSpent Details.
        /// </summary>
        /// <param name="objNeedyPerson"></param>
        /// <returns></returns>
        public static DataTable getTimeSpent(int? NeedyPersonID = null)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psgetTimeSpent";

            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@NeedyPersonID", DbType.Int32, NeedyPersonID);
                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }

        /// <summary>
        /// Created on 01-12-2015.
        /// Purpose: get TimeSpent Details.
        /// </summary>
        /// <param name="objNeedyPerson"></param>
        /// <returns></returns>
        public static void UpdateTimeSpent(int TimeSpentID, int TravelTime, string TimeSpentReason, string date)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psUpdateTimeSpent";

            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@TimeSpentID", DbType.Int32, TimeSpentID);
                db.AddInParameter(dbCommand, "@TravelTime", DbType.Int32, TravelTime);
                db.AddInParameter(dbCommand, "@TimeSpentReason", DbType.String, TimeSpentReason);
                db.AddInParameter(dbCommand, "@TravelDate", DbType.String, Sanitizer.GetSafeHtmlFragment(date));                   //Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data
                db.ExecuteNonQuery(dbCommand);
            }
        }

        /// <summary>
        /// Created on 01-13-2015.
        /// Purpose: Delete TimeSpent Details.
        /// </summary>
        /// <param name="objNeedyPerson"></param>
        /// <returns></returns>
        public static void DeleteTimeSpent(int TimeSpentID)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psDeleteTimeSpent";

            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@TimeSpentID", DbType.Int32, TimeSpentID);
                db.ExecuteNonQuery(dbCommand);
            }
        }





        /// <summary>
        /// Created By: SM
        /// Date:03/08/2013
        /// Purpose: Save call details
        /// </summary>
        /// <param name="objNeedyPerson"></param>
        /// <param name="ContactPersonID"></param>
        /// <returns></returns>
        public static void SaveCallHistory(PersonNeedAssistance objNeedyPerson, int? ContactPersonID, out int ContactHistoryID, out int FollowupHistoryID)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psSetCallHistory";


            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                // needy Person id
                db.AddInParameter(dbCommand, "@NeedyPersonID", DbType.Int32, objNeedyPerson.NeedyPersonID);
                // contact person id (if contact person selected otherwise null value)
                db.AddInParameter(dbCommand, "@ContactPersonID", DbType.Int32, ContactPersonID);
                //Contact Date
                db.AddInParameter(dbCommand, "@ContactDate", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.ContactDate));     //Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data
                // Type of contact 
                db.AddInParameter(dbCommand, "@ContactTypeID", DbType.Int32, objNeedyPerson.ContactTypeID);
                db.AddInParameter(dbCommand, "@ContactTypeOther", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.ContactTypeOther));     //Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data
                // Type of contact method
                db.AddInParameter(dbCommand, "@ContactMethodID", DbType.Int32, objNeedyPerson.ContactMethodID);
                db.AddInParameter(dbCommand, "@ContactMethodOther", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.ContactMethodOther));     //Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data
                // Is Info only 
                db.AddInParameter(dbCommand, "@IsInfoOnly", DbType.Int32, Convert.ToInt32(objNeedyPerson.IsInfoOnly));
                //Is ADRC 
                db.AddInParameter(dbCommand, "@IsADRC", DbType.Int32, Convert.ToInt32(objNeedyPerson.IsADRC));
                // call duration
                db.AddInParameter(dbCommand, "@CallDurationMin", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.CallDuration));  //Modified by RK,,Task-ID: 24527,Purpose: Sanitization of data
                //Service requested
                db.AddInParameter(dbCommand, "@ServiceRequested", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.ServiceRequested));    //Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data
                db.AddInParameter(dbCommand, "@CreatedBy", DbType.String, MySession.strUserName);

                db.AddInParameter(dbCommand, "@CurrentHistoryID", DbType.Int32, Convert.ToInt32(HttpContext.Current.Session["CurrentHistoryID"]));
                // Note/comments
                db.AddInParameter(dbCommand, "@Notes", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.Notes));    //Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data
                db.AddInParameter(dbCommand, "@InfoRequested", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.InfoRequested));    //Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data
                db.AddInParameter(dbCommand, "@OtherNotes", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.OtherNotes));     //Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data
                //Make Follow up, followup date and Service Needs met at call level 
                db.AddInParameter(dbCommand, "@Followup", DbType.Int32, objNeedyPerson.FollowUp);
                db.AddInParameter(dbCommand, "@FollowupDate", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.FollowupDate));   //Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data
                db.AddInParameter(dbCommand, "@FollowupCompleted", DbType.String, objNeedyPerson.FollowupCompleted); // Added by: SM, Date: 04 April 2014 ,reason: followup completed
                db.AddInParameter(dbCommand, "@FollowupNotes", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.FollowupNotes)); // Added by: SM, Date: 04 April 2014 ,reason: followup completed,//Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data

                // Added by SA on 11-11-2014. SOW-335.
                db.AddInParameter(dbCommand, "@OCFollowUp", DbType.Int32, objNeedyPerson.OCFollowUp);
                db.AddInParameter(dbCommand, "@OCFollowUpDate", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.OCFollowupDate));  //Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data                                   
                db.AddInParameter(dbCommand, "@OCFollowUpNotes", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.OCFollowupNotes)); //Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data
                db.AddInParameter(dbCommand, "@IsReferredForOC", DbType.Boolean, objNeedyPerson.ReferredForOC);
                //added by SA on 21st aug, 2015. SOW-379. 
                db.AddInParameter(dbCommand, "@IsReferredForOCDate", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.ReferredForOCDate));    //Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data

                db.AddInParameter(dbCommand, "@ServiceNeedMet", DbType.Int32, objNeedyPerson.ServiceNeedsMet);
                db.AddInParameter(dbCommand, "@ToDo", DbType.Boolean, objNeedyPerson.IsToDo);
                db.AddInParameter(dbCommand, "@CurrentFollowupID", DbType.Int32, Convert.ToInt32(HttpContext.Current.Session["CurrentFollowupID"]));
                db.AddInParameter(dbCommand, "@IsCallUpdate", DbType.Int32, Convert.ToInt32(HttpContext.Current.Session["IsCallUpdate"]));
                // get new call history id
                db.AddOutParameter(dbCommand, "@ContactHistoryID", DbType.Int32, 10);
                db.AddOutParameter(dbCommand, "@FollowupHistoryID", DbType.Int32, 10);

                db.AddInParameter(dbCommand, "@IsFundsProvided", DbType.Boolean, objNeedyPerson.IsFundsProvided);//Added By VK on Aug  2017.
                db.AddInParameter(dbCommand, "@FundsProvidedAmount", DbType.Decimal, objNeedyPerson.FundsProvidedAmount);//Added By VK on Aug  2017.
                db.AddInParameter(dbCommand, "@FundsUtilizedDate", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.FundsUtilizedDate));//Added By VK on Aug  2017.,//Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data
                db.AddInParameter(dbCommand, "@FundsUtilizedIDs", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.FundsUtilizedIDs));//Added By VK on Aug  2017.,//Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data

                db.AddInParameter(dbCommand, "@IsManualCallDuration", DbType.Boolean, objNeedyPerson.IsManualCallDuration);//Added by KP on 28th Feb 2020(SOW-577)
                
                db.AddInParameter(dbCommand, "@FundsUtilizedForOther", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.FundsUtilizedForOther)); // Added by GK on 28June,2021 TicketID #2544,//Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data

                // Added by GK on 09Dec2021: Ticket #6715
                db.AddInParameter(dbCommand, "@ServiceReqOther", DbType.String, objNeedyPerson.OtherServiceRequested);

                db.ExecuteNonQuery(dbCommand);
                ContactHistoryID = Convert.ToInt32(db.GetParameterValue(dbCommand, "@ContactHistoryID"));
                FollowupHistoryID = Convert.ToInt32(db.GetParameterValue(dbCommand, "@FollowupHistoryID"));
            }
        }

        /// <summary>
        /// Created by SA on 18-12-2014.
        /// </summary>
        /// <param name="NeedyPersonID"></param>
        /// <returns></returns>
        public static DataTable GetNeedypersonDocsDetails(int? NeedyPersonID = null)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "[psgetNeedyPersonDocDetails]";

            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {

                db.AddInParameter(dbCommand, "@FKSiteID", DbType.Int32, HttpContext.Current.Session["CurrentSiteId"]); // modified by GK on 23July18 : changed from 'MySession.SiteId' TO 'Session["CurrentSiteId"]'
                db.AddInParameter(dbCommand, "@NeedyPersonID", DbType.Int32, NeedyPersonID);

                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }
        /// <summary>
        /// Created by SA on 22-12-2014.
        /// Purpose: Get Insurance Types
        /// </summary>
        /// <param name="NeedyPersonID"></param>
        /// <returns></returns>
        public static DataTable GetInsuranceTypes()
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "[psgetInsuranceTypes]";

            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }

        /// <summary>
        /// Created by SA on 18-12-2014.
        /// </summary>
        /// <param name="NeedyPersonID"></param>
        /// <returns></returns>
        public static void DeleteNeedypersonDocsDetails(string GUID)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "[psDeleteNeedyDocuments]";

            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {

                db.AddInParameter(dbCommand, "@FileGuid", DbType.String, GUID);

                db.ExecuteNonQuery(dbCommand);
            }
        }

        /// <summary>
        /// Created By: SM
        /// Date:03/09/3013
        /// Purpose: Get Needy person details
        /// </summary>
        /// <param name="NeedyPersonID"></param>
        /// <returns></returns>
        public static SqlDataReader GetNeedyPersonDetails(int NeedyPersonID, int CallHistoryID = 0)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psGetNeedyPersonDetails";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@NeedyPersonID", DbType.String, NeedyPersonID);
                db.AddInParameter(dbCommand, "@CallHistoryID", DbType.String, CallHistoryID);
                return (SqlDataReader)db.ExecuteReader(dbCommand);
            }
        }

        /// <summary>
        /// Created By: SM
        /// Date:03/11/2013
        /// Purpose: Get Call history
        /// </summary>
        /// <param name="NeedyPersonID"></param>
        /// <returns></returns>
        public static DataTable GetCallHistory(int NeedyPersonID)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psGetCallHistory";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@NeedyPersonID", DbType.String, NeedyPersonID);
                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }

        /// <summary>
        /// Created By: SM
        /// Date:03/18/2013
        /// Perpose:Get Person and ContactID 
        /// </summary>
        /// <returns></returns>
        public static SqlDataReader GetPersonAndContactID()
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psGetPersonAndContactId";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                return (SqlDataReader)db.ExecuteReader(dbCommand);
            }
        }

        /// <summary>
        /// Created By: SM
        /// date:03/18/2013
        /// Purpsoe: Get List of requested Services
        /// </summary>
        /// <returns></returns>
        public static DataTable GetRequestedServiceList(int NeedyPersonID, int CallHistoryID = 0)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psGetRequestedService";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@NeedyPersonID", DbType.Int32, NeedyPersonID);
                db.AddInParameter(dbCommand, "@CallHistoryID", DbType.Int32, CallHistoryID);
                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }

        /// <summary>
        /// Created By: SM
        /// Date:04/10/2013
        /// Purpose:Get User Details
        /// </summary>
        /// <returns></returns>
        public static IDataReader GetUserDetails()
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "[User].dbo.psSearchUser_Get";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@userName", DbType.String, MySession.strUserName);
                db.AddInParameter(dbCommand, "@userGUID", DbType.String, null);
                db.AddInParameter(dbCommand, "@firstName", DbType.String, null);
                db.AddInParameter(dbCommand, "@lastName", DbType.String, null);
                db.AddInParameter(dbCommand, "@resourceID", DbType.String, null);
                db.AddInParameter(dbCommand, "@email", DbType.String, null);
                db.AddInParameter(dbCommand, "@secForm", DbType.String, null);
                db.AddInParameter(dbCommand, "@testUser", DbType.String, null);
                return db.ExecuteReader(dbCommand);
            }
        }

        /// <summary>
        /// Created By: SM
        /// Date:04/11/2013
        /// Purpose: Get ADRC Agency Name
        /// </summary>
        /// <param name="AAASiteId"></param>
        /// <returns></returns>
        public static IDataReader GetADRCAgencyName(int SiteId)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psGetADRCAgencyName";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@SiteId", DbType.Int32, SiteId);
                return db.ExecuteReader(dbCommand);
            }
        }

        /// <summary>
        /// Created By:SM
        /// Date:04/22/2013
        /// Purpose: delete Contact Person
        /// </summary>
        /// <param name="AAASiteId"></param>
        /// <returns></returns>
        public static int DeleteContactPerson(int ContactPersonID)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psContactPersonDelete";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@PersonID", DbType.String, ContactPersonID);
                return Convert.ToInt32(db.ExecuteNonQuery(dbCommand));
            }
        }

        /// <summary>
        /// Created By:SM
        /// Date:04/22/2013
        /// Purpose: delete Contact Person
        /// </summary>
        /// <param name="AAASiteId"></param>
        /// <returns></returns>
        public static IDataReader GetContactPersonDetailByPersonID(int ContactPersonID)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psGetPersonDetailByPersonID";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@PersonID", DbType.String, ContactPersonID);
                return db.ExecuteReader(dbCommand);
            }
        }

        /// <summary>
        /// Created By: SM
        /// Date:06/12/2013
        /// Purpose: Get Call history more
        /// </summary>
        /// <param name="NeedyPersonID"></param>
        /// <returns></returns>
        public static DataTable GetCallHistoryDetails(int HistoryId, int NeedyID, bool isReqNeedyName = false)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psGetCallHistoryDetails";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@HistoryId", DbType.String, HistoryId);
                db.AddInParameter(dbCommand, "@NeedyPersonID", DbType.String, NeedyID);
                db.AddInParameter(dbCommand, "@IsReqNeedyName", DbType.Boolean, isReqNeedyName);
                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }

        /// <summary>
        /// Created By: SM
        /// Date:06/28/2013
        /// Purpose:Get Provide list
        /// </summary>
        /// <returns></returns>
        //public static IDataReader getVolunteerProgramNames()
        //{
        //    Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
        //    DbProviderFactory dbpf = db.DbProviderFactory;
        //    db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
        //    string cmd = "Resource.dbo.psVolunteerProgramNames_List";
        //    IDataReader rdr = null;
        //    using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
        //    {
        //        rdr = db.ExecuteReader(dbCommand);
        //    }
        //    return rdr;
        //}

        /// <summary>
        /// Created By: SM
        /// Date:07/03/2013
        /// Purpose:Get follow-up reminder list
        /// </summary>
        /// <returns></returns>
        public static DataTable GetFollowupReminder()
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psGetFollowUpReminder";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@FKSiteID", DbType.String, MySession.SiteId);
                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }

        /// <summary>
        /// Created By: NK
        /// Date:31 oct 13
        /// Purpose:Get To Do list
        /// </summary>
        /// <returns></returns>
        public static DataTable GetToDo()
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psGetToDo";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                // db.AddInParameter(dbCommand, "@FKSiteID", DbType.String, Convert.ToInt32(HttpContext.Current.Session["CurrentSiteId"]));
                db.AddInParameter(dbCommand, "@FKSiteID", DbType.String, MySession.SiteId);


                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }
        /// <summary>
        /// Created By: NK
        /// Date:31 oct 13
        /// Purpose:set To Do 
        /// </summary>
        /// <returns></returns>
        public static bool SetToDo(int HistoryID, int NeedyID, Int16 ToDoFlag)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psSetToDo";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@HistoryID", DbType.Int32, HistoryID);
                db.AddInParameter(dbCommand, "@NeedyID", DbType.Int32, NeedyID);
                db.AddInParameter(dbCommand, "@ToDoFlag", DbType.Int16, ToDoFlag);
                int Result = db.ExecuteNonQuery(dbCommand);
                if (Result > 0)
                    return true;
                else
                    return false;
            }
        }
        /// <summary>
        /// Created By: SM
        /// Date:07/05/2013
        /// Purpose:Set follow up setting
        /// </summary>
        /// <param name="priorDay"></param>
        /// <param name="IsActive"></param>
        public static bool SetFollowUpEmailConfiguration(int PriorDay, bool IsActive)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psConfigureFollowUpEmail_Set";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@FKSiteID", DbType.Int32, MySession.SiteId);
                db.AddInParameter(dbCommand, "@PeriorDay", DbType.Int32, PriorDay);
                db.AddInParameter(dbCommand, "@FollowupStatus", DbType.Boolean, IsActive);
                db.AddInParameter(dbCommand, "@CreatedModifiedBy", DbType.String, MySession.strUserName);
                int Result = db.ExecuteNonQuery(dbCommand);
                if (Result > 0)
                    return true;
                else
                    return false;
            }
        }
        /// <summary>
        /// Created By: SM
        /// Date:07/10/2013
        /// Purpose: Get follow up setting detail for that agency i.e. Prior day to email would be send and enable /disable  email Reminder 
        /// </summary>
        /// <returns></returns>
        public static DataTable GetFollowUpEmailConfiguration()
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psConfigureFollowUpEmail_Get";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@SiteID", DbType.String, MySession.SiteId);
                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }


        /// <summary>
        /// Created By: SM
        /// Date:07/18/2013
        /// Purpose: Get  last call details of logged Current Agency 
        /// </summary>
        /// <returns></returns>
        public static DataTable GetLastCallDetailsOfAgency()
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psGetLastCallDetailsOfAgency";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@SiteID", DbType.String, MySession.SiteId);
                return db.ExecuteDataSet(dbCommand).Tables[0];
            }

        }

        /// <summary>
        /// Created By:SM
        /// Date:08/21/2013
        /// Purpose:Search city and county by zip code
        /// </summary>
        /// <param name="strZip"></param>
        /// <returns></returns>
        public static DataTable GetCityCountyByZip(string strZip)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psGetCityCountyByZip";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@ZipCode", DbType.String, strZip);
                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }


        /// <summary>
        /// Created By:SM
        /// Date:08/26/2013
        /// Purpose:Get All Service Provider in of current agency
        /// </summary>
        /// <param name="strZip"></param>
        /// <returns></returns>
        public static DataTable GetServiceProvider()
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psGetServiceProvider";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@SiteID", DbType.String, HttpContext.Current.Session["CurrentSiteId"]);
                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }
        /// <summary>
        /// Created by SA on 17-12-2014. SOW-335
        /// Purpose: get referral details for mailing purpose
        /// </summary>
        /// <returns></returns>
        public static DataTable GetReferralDetailsNeedyWise(int NeedyPersonID)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psgetReferralDetailsNeedyWise";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@NeedyPersonID", DbType.Int32, NeedyPersonID);
                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }

        /// <summary>
        /// Created By:SM
        /// Date:08/26/2013
        /// Purpose:Get All AAA 
        /// </summary>
        /// <param name="strZip"></param>
        /// <returns></returns>
        public static DataTable GetAAACILAgency()
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psGetAAACILName";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }

        /// <summary>
        /// Created By:SM
        /// Date:08/27/2013
        /// Purpose:Follow-up List
        /// </summary>
        /// <param name="strZip"></param>
        /// <returns></returns>
        public static DataTable GeFollowupList(int CallHistoryID)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psGetFollowupList";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@ContactHistoryID", DbType.String, CallHistoryID);
                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }

        /// <summary>
        /// Created By:SM
        /// Date:10/31/2013
        /// Purpose:Check Duplicate needy persion if already exist
        /// </summary>
        /// <param name="strZip"></param>
        /// <returns></returns>
        public static bool CheckDuplicateNeedy(string strFirstName, string strLastName, int NeedyID)
        {

            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psCheckDuplicateNeedy";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@NeedyFirstName", DbType.String, strFirstName);
                db.AddInParameter(dbCommand, "@NeedyLastName", DbType.String, strLastName);
                db.AddInParameter(dbCommand, "@NeedyID", DbType.Int32, NeedyID);
                db.AddInParameter(dbCommand, "@SiteID", DbType.Int32, Convert.ToInt32(HttpContext.Current.Session["CurrentSiteId"]));
                db.AddOutParameter(dbCommand, "@IsDuplicate", DbType.Boolean, 0);
                db.ExecuteNonQuery(dbCommand);

                return Convert.ToBoolean(db.GetParameterValue(dbCommand, "@IsDuplicate"));
            }

        }


        /// <summary>
        /// Created By: SM
        /// Date: 24 Jan 2014
        /// Purpose: Delete Call 
        /// </summary>
        /// <param name="CallId"></param>
        /// <returns></returns>
        public static bool DeleteCallByCallId(int CallId)
        {

            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psDeleteCallByCallId";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@CallID", DbType.Int32, CallId);

                int Result = db.ExecuteNonQuery(dbCommand);
                if (Result > 0)
                    return true;
                else
                    return false;
            }

        }

        /// <summary>
        /// Created By: SM
        /// Date: 24 Jan 2014
        /// Purpose: Delete Needy Person  
        /// </summary>
        /// <param name="NeedyPersonID"></param>
        /// <returns></returns>
        public static bool DeleteNeedyPerson(int NeedyPersonID)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psDeleteNeedyPerson";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@NeedyPersonID", DbType.Int32, NeedyPersonID);
                int Result = db.ExecuteNonQuery(dbCommand);
                if (Result > 0)
                    return true;
                else
                    return false;
            }
        }

        /// <summary>
        /// Created By: SM
        /// Date:27 Jan 2014
        /// Purpose: Get Contact Person Call List
        /// </summary>
        /// <param name="ContactPersonID"></param>
        /// <returns></returns>
        public static DataTable GetContactPersonCallHistory(int ContactPersonID, int NeedyPersonId)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psGetContactPersonCallList";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@ContactPersonID", DbType.Int32, ContactPersonID);
                db.AddInParameter(dbCommand, "@NeedyPersonID", DbType.Int32, NeedyPersonId);
                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }
        /// <summary>
        /// Created By: SM
        /// Date:29 Jan 2014
        /// Purpose: Get Person count in each Agency
        /// </summary>
        /// <param name="ContactPersonID"></param>
        /// <param name="NeedyPersonId"></param>
        /// <returns></returns>
        public static DataTable GetPersonCountByAgency()
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psGetPersonByAgency";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {

                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }

        /// <summary>
        /// Created By: PA
        /// Date:04 April 2014
        /// Purpose: Get Person count in each user
        /// </summary>
        /// <param name="ContactPersonID"></param>
        /// <param name="NeedyPersonId"></param>
        /// <returns></returns>
        public static DataTable GetPersonCountByUser()
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psGetPersonByUser";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {

                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }

        /// <summary>
        /// Created By: SM
        /// Date: 29 Jan 2014
        /// Purpose: get service count
        /// </summary>
        /// <returns></returns>
        public static DataTable GetNeedyPersonCountByService()
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psNeedyPersonCountByService";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {

                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }
        /// <summary>
        /// Created By: SM
        /// Date: 29 Jan 2014
        /// Purpose: Display Needy details
        /// </summary>
        /// <returns></returns>
        public static DataTable GetNdPersonBySiteIdOrServiceid(string SideID, int ServiceID, int IsReqServiceMetNd, string strUserID)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psGetNDPersonListBySiteOrService";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@FKSiteID", DbType.String, SideID);
                db.AddInParameter(dbCommand, "@ServiceID", DbType.Int32, ServiceID);
                db.AddInParameter(dbCommand, "@ReqServiceMetNeedy", DbType.Int32, IsReqServiceMetNd);
                db.AddInParameter(dbCommand, "@UserID", DbType.String, strUserID);
                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }



        /// <summary>
        ///  Created By : SM
        ///  Purpose: Get  final search result  based on other paramete except radius and zipcode 
        ///  Date: 08/27/2012
        /// </summary>
        /// <param name="intServiceID"></param>
        /// <param name="intCountyID"></param>
        /// <param name="strServiceKeyWd"></param>
        /// <param name="strAgencyName"></param>
        /// <returns> DataTable</returns>
        public static DataTable GetServiceProviderAgency(string strServiceID, int? intCountyID = null, string strServiceKeyWd = "", string strAgencyName = "", string strCity = null)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "Resource.dbo.psADRCPub_GetAllAgencyWithoutZipRadius";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@intServiceID", DbType.String, Sanitizer.GetSafeHtmlFragment(strServiceID));   //Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data
                db.AddInParameter(dbCommand, "@intCountyID", DbType.Int32, intCountyID);
                db.AddInParameter(dbCommand, "@ServiceKeyword", DbType.String, strServiceKeyWd);
                db.AddInParameter(dbCommand, "@AgencyName", DbType.String, strAgencyName);
                db.AddInParameter(dbCommand, "@strCity", DbType.String, strCity);
                db.AddInParameter(dbCommand, "@AAASiteID", DbType.Int32, HttpContext.Current.Session["CurrentSiteId"]);

                return db.ExecuteDataSet(dbCommand).Tables[0];
            }

        }
        /// <summary>
        /// Created By: SM
        /// Date: 07/18/2014
        /// purpose: generate ADRC Report.
        /// </summary>
        /// <param name="objReportField"></param>
        /// <returns></returns>
        public static DataSet GenerateADRCReport(ADRCReport objReportField)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings
                [MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psReportADRCIAProcessData";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                dbCommand.CommandTimeout = 1200; // Added by GK/PA on 12Sept,2019 : Task ID #16715
                db.AddInParameter(dbCommand, "@ReportType", DbType.String, objReportField.ReportType);
                db.AddInParameter(dbCommand, "@ReportStyle", DbType.String, objReportField.ReportingStyle);
                db.AddInParameter(dbCommand, "@AAASiteID", DbType.String, objReportField.Agency);
                db.AddInParameter(dbCommand, "@CountyName", DbType.String, objReportField.County);
                db.AddInParameter(dbCommand, "@CityName", DbType.String, objReportField.City);
                db.AddInParameter(dbCommand, "@TownshipCode", DbType.String, objReportField.Township); // Added by GK on 15May19 : SOW-563
                db.AddInParameter(dbCommand, "@CustomCode", DbType.String, objReportField.CustomField); // Added by GK on 22May19 : SOW-563
                db.AddInParameter(dbCommand, "@ServiceID", DbType.String, objReportField.Service);
                db.AddInParameter(dbCommand, "@OtherService", DbType.String, objReportField.OtherService);//Added By KP on 27th March 2020(SOW - 577), Filter the other services
                db.AddInParameter(dbCommand, "@ReferredBy", DbType.String, objReportField.ReferredBy);//Added on 26-11-2014. SOW-335. SA. Filter Referred By Option also.
                db.AddInParameter(dbCommand, "@ReferredTo", DbType.String, objReportField.ReferredTo);
                db.AddInParameter(dbCommand, "@ReferredToOther", DbType.String, objReportField.ReferredToOther);
                db.AddInParameter(dbCommand, "@ReferredByOther", DbType.String, objReportField.ReferredByOther);//Added by SA on 10-11-2014. Purpose: To get report for Other referred to agency. SOW-335
                db.AddInParameter(dbCommand, "@Staff", DbType.String, objReportField.Staff);
                db.AddInParameter(dbCommand, "@StartDate", DbType.String, objReportField.DateRangeFrom);
                db.AddInParameter(dbCommand, "@EndDate", DbType.String, objReportField.DateRangeTo);
                db.AddInParameter(dbCommand, "@AdvanceReport", DbType.String, objReportField.AdvanceFilter);

                //16th Sep change by SA for duplicate/unduplicate reporting condition.
                if (objReportField.ReportType == "4")
                {
                    db.AddInParameter(dbCommand, "@IsInfoOnly", DbType.Int32, Convert.ToInt32(objReportField.IsInfoOnly));
                    db.AddInParameter(dbCommand, "@IsADRC", DbType.Int32, Convert.ToInt32(objReportField.IsADRC));
                }

                /* when advance filter checked*/
                if (Convert.ToBoolean(objReportField.AdvanceFilter))
                {
                    db.AddInParameter(dbCommand, "@GroupBy", DbType.String, objReportField.GroupBy);
                    db.AddInParameter(dbCommand, "@ContactType", DbType.String, objReportField.ContactType);
                    db.AddInParameter(dbCommand, "@ContactMethod", DbType.String, objReportField.ContactMethod);

                    db.AddInParameter(dbCommand, "@Gender", DbType.String, objReportField.Gender);
                    // set Age calulation field value
                    db.AddInParameter(dbCommand, "@AgeFromToday", DbType.Boolean, objReportField.AgeFromToday);
                    if (!Convert.ToBoolean(objReportField.AgeFromToday))
                        db.AddInParameter(dbCommand, "@AgeFromDate", DbType.String, objReportField.AgeFromDate);// Set age from date 
                    //db.AddInParameter(dbCommand, "@AgeRange", DbType.String, objReportField.AgeAsOfList);

                    db.AddInParameter(dbCommand, "@AgeRange0_5", DbType.Int32, Convert.ToInt32(objReportField.A1));
                    db.AddInParameter(dbCommand, "@AgeRange6_10", DbType.Int32, Convert.ToInt32(objReportField.A2));
                    db.AddInParameter(dbCommand, "@AgeRange11_15", DbType.Int32, Convert.ToInt32(objReportField.A3));
                    db.AddInParameter(dbCommand, "@AgeRange16_20", DbType.Int32, Convert.ToInt32(objReportField.A4));
                    db.AddInParameter(dbCommand, "@AgeRange21_25", DbType.Int32, Convert.ToInt32(objReportField.A5));
                    db.AddInParameter(dbCommand, "@AgeRange26_30", DbType.Int32, Convert.ToInt32(objReportField.A6));
                    db.AddInParameter(dbCommand, "@AgeRange31_35", DbType.Int32, Convert.ToInt32(objReportField.A7));
                    db.AddInParameter(dbCommand, "@AgeRange36_40", DbType.Int32, Convert.ToInt32(objReportField.A8));
                    db.AddInParameter(dbCommand, "@AgeRange41_45", DbType.Int32, Convert.ToInt32(objReportField.A9));
                    db.AddInParameter(dbCommand, "@AgeRange46_50", DbType.Int32, Convert.ToInt32(objReportField.A10));
                    db.AddInParameter(dbCommand, "@AgeRange51_55", DbType.Int32, Convert.ToInt32(objReportField.A11));
                    db.AddInParameter(dbCommand, "@AgeRange56_60", DbType.Int32, Convert.ToInt32(objReportField.A12));
                    db.AddInParameter(dbCommand, "@AgeRange61_65", DbType.Int32, Convert.ToInt32(objReportField.A13));
                    db.AddInParameter(dbCommand, "@AgeRangeGreaterThan65", DbType.Int32, Convert.ToInt32(objReportField.A14));
                    db.AddInParameter(dbCommand, "@AgeRangeUnknown", DbType.Int32, Convert.ToInt32(objReportField.AUnknown));

                    db.AddInParameter(dbCommand, "@MarritalStatus", DbType.String, objReportField.MaritalStatus);
                    db.AddInParameter(dbCommand, "@LivingArrengement", DbType.String, objReportField.LivingArrangement);
                    db.AddInParameter(dbCommand, "@Race", DbType.String, objReportField.Race);
                    db.AddInParameter(dbCommand, "@PrimaryLanguage", DbType.String, objReportField.PrimaryLanguage);
                    db.AddInParameter(dbCommand, "@VeteranStatus", DbType.String, objReportField.VeteranStatus);
                    db.AddInParameter(dbCommand, "@VerteranApplicableID", DbType.String, objReportField.VeteranApplicable);
                    db.AddInParameter(dbCommand, "@VerteranApplicable", DbType.String, objReportField.VeteranApplicableText);
                    db.AddInParameter(dbCommand, "@Ethnicity", DbType.String, objReportField.Ethnicity);
                    db.AddInParameter(dbCommand, "@ServiceNeedMet", DbType.String, objReportField.ServiceNeedMet);
                    db.AddInParameter(dbCommand, "@FollowupStatus", DbType.String, objReportField.FollowUpStatus);
                    //added on 21st Aug, 2015. sow-379.
                    db.AddInParameter(dbCommand, "@IsReferredforOC", DbType.String, objReportField.IsReferredForOC);
                    db.AddInParameter(dbCommand, "@IsReferredforOCDateFrom", DbType.String, objReportField.IsReferredForOCDate);
                    db.AddInParameter(dbCommand, "@IsReferredforOCDateTo", DbType.String, objReportField.IsReferredForOCDateTo);
                    //Added By KR on 24 March 2017.
                    if (objReportField.IsFundProvided == "1") //Pass Default value in case if only Checked to yes.
                    {
                        if (objReportField.IsFromAmount == "")
                        {
                            objReportField.IsFromAmount = "0";
                        }
                        if (objReportField.IsToAmount == "")
                        {
                            objReportField.IsToAmount = "999";
                        }
                    }
                    db.AddInParameter(dbCommand, "@IsFundProvided", DbType.String, objReportField.IsFundProvided);
                    db.AddInParameter(dbCommand, "@IsFromAmount", DbType.String, objReportField.IsFromAmount);
                    db.AddInParameter(dbCommand, "@IsToAmount", DbType.String, objReportField.IsToAmount);
                    //Added by Vk on 03 Aug,2017, fro set Parameter CaregiverNeedyPerson,FundsProvidedDateFrom,FundsProvidedDateTo and FundsUtilizedfor.
                    db.AddInParameter(dbCommand, "@CaregiverNeedyPerson", DbType.String, objReportField.CaregiverNeedyPerson);
                    db.AddInParameter(dbCommand, "@FundsProvidedDateFrom", DbType.String, objReportField.FundsProvidedDateFrom);
                    db.AddInParameter(dbCommand, "@FundsProvidedDateTo", DbType.String, objReportField.FundsProvidedDateTo);
                    db.AddInParameter(dbCommand, "@FundsUtilizedfor", DbType.String, objReportField.FundsUtilizedfor);
                    //Changes end here.
                    db.AddInParameter(dbCommand, "@IsDemographics", DbType.String, objReportField.IsDemographics); //Added by KP on 29-Sep-2017 - SOW-485    
                    
                    db.AddInParameter(dbCommand, "@ContactInfo", DbType.String, objReportField.ContactInfo);//Added By KP on 3rd Jan 2020(SOW-577), Parameters of Contact Type Info.

                }
                return db.ExecuteDataSet(dbCommand);
            }

        }

        /// <summary>
        /// Created by: SA On 07/28/2014
        /// Purpose: Get Needy Person Details
        /// </summary>
        /// <param name="NeedyIdList"></param>
        /// <param name="ContactHistoryIDList"></param>
        /// <param name="AllCallIDList"></param>
        /// <param name="ReportType"></param>
        /// <param name="rptObj"></param>
        /// <returns></returns>        
        public static DataSet getNeedyPersonDetails(string NeedyIdList, string ContactHistoryIDList, string AllCallIDList = "", int ReportType = 1, ReportSelectionFilter rptObj = null)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psReportViewNeedyPersonDetails";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                dbCommand.CommandTimeout = 1200;
                db.AddInParameter(dbCommand, "@NeedyIdList", DbType.String, NeedyIdList);
                //added by SA on 22nd July.2015
                db.AddInParameter(dbCommand, "@ContactHistoryIDList", DbType.String, ContactHistoryIDList);
                //Added by Vk on 21 Aug.2017.
                db.AddInParameter(dbCommand, "@AllCallIDList", DbType.String, AllCallIDList);
                //Added by:BS on 13-sep-2016
                db.AddInParameter(dbCommand, "@ReportType", DbType.Int16, ReportType);//added

                //Added by KP on 16th March 2020(SOW-577), new paprameter are added
                db.AddInParameter(dbCommand, "@ReuestedIDs", DbType.String, rptObj.ReuestedIDs);
                db.AddInParameter(dbCommand, "@IsNeedyReuested", DbType.Boolean, rptObj.IsNeedyReuested);
                db.AddInParameter(dbCommand, "@IsCallHistoryReuested", DbType.Boolean, rptObj.IsCallHistoryReuested);
                db.AddInParameter(dbCommand, "@IsOptionCounsReuested", DbType.Boolean, rptObj.IsOptionCounsReuested);
                db.AddInParameter(dbCommand, "@IsContactPersonReuested", DbType.Boolean, rptObj.IsContactPersonReuested);
                //End (SOW-577)

                return db.ExecuteDataSet(dbCommand);
            }

        }


        /// <summary>
        /// Created by SA on 26th March, 2015.
        /// Purpose: Log exception to DB and send mail.
        /// </summary>
        /// <param name="errMessage"></param>
        public static void SaveADRCIAError(string errMessage)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psSaveADRCIAError";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@errMessage", DbType.String, errMessage);
                db.ExecuteNonQuery(dbCommand);
            }
        }
        /// <summary>
        /// Created by VK on 26th March, 2015.
        /// Purpose: get Funds Utilized.
        /// </summary>
        /// <param name="errMessage"></param>

        public static DataTable getFundsUtilized(int CallHistoryID)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "[psgetFundsUtilized]";

            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                //Modify by VK on 26 June, 2019.Change Int16 to Int32.  
                db.AddInParameter(dbCommand, "@CallHistoryID", DbType.Int32, CallHistoryID);
                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }

        public static DataTable GetCustomFieldList()
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psGetCustomList";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                //db.AddInParameter(dbCommand, "@AAASiteID", DbType.Int32, HttpContext.Current.Session["AAASiteID"]);
                db.AddInParameter(dbCommand, "@AAASiteID", DbType.Int32, HttpContext.Current.Session["CurrentSiteId"]);
                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }

        public static int SaveCustomField(string AddedCodeList, string AddedNameList, string strDeletedList)
        {
            var retVal = 0;
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            try
            {
                db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
                using (DbCommand dbCommand = db.GetStoredProcCommand("psSetCustomField"))
                {
                    // db.AddInParameter(dbCommand, "@AAASiteID", DbType.Int32, HttpContext.Current.Session["AAASiteID"]);
                    db.AddInParameter(dbCommand, "@AAASiteID", DbType.Int32, HttpContext.Current.Session["CurrentSiteId"]);
                    db.AddInParameter(dbCommand, "@strAddedCodeList", DbType.String, AddedCodeList);
                    db.AddInParameter(dbCommand, "@strAddedNameList", DbType.String, AddedNameList);
                    db.AddInParameter(dbCommand, "@strDeletedList", DbType.String, strDeletedList);
                    db.AddInParameter(dbCommand, "@strUser", DbType.String, MySession.strUserName);

                    retVal = db.ExecuteNonQuery(dbCommand);
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                db = null;
                dbpf = null;
            }
            return retVal;
        }

        public static DataTable IsUsedCustomField(string CustomCodeList, int? NeedyPersonID)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psIsUsedCustomField";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@NeedyPersonID", DbType.Int32, NeedyPersonID);
                db.AddInParameter(dbCommand, "@CustomCodeList", DbType.String, CustomCodeList);
                // db.AddInParameter(dbCommand, "@AAASiteID", DbType.Int32, HttpContext.Current.Session["AAASiteID"]);
                db.AddInParameter(dbCommand, "@AAASiteID", DbType.Int32, HttpContext.Current.Session["CurrentSiteId"]);
                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }
        /// <summary>
        /// Created By: VK
        /// Date: 23 April,2019
        /// Purpose: Get Agency Wise Township. 
        /// </summary>
        public static DataSet GetAgencyWiseTownship(string SiteID)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "[PSReportGetAgencyWiseTownship]";

            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@SiteID", DbType.String, SiteID);
                return db.ExecuteDataSet(dbCommand);
            }
        }
        /// <summary>
        /// Created By: VK
        /// Date: 23 April,2019
        /// Purpose: Get Agency Wise CustomField. 
        /// </summary>
        public static DataSet GetAgencyWiseCustomField(string SiteID)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "[PSReportGetAgencyWiseCustomField]";

            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@SiteID", DbType.String, SiteID);
                return db.ExecuteDataSet(dbCommand);
            }
        }

        #region [SOW-577]
        /// <summary>
        /// Created By: KP
        /// Date: 18th Dec 2019(SOW-577)
        /// Purpose: Insert and update the Referring Agency Details 
        /// </summary>
        /// <param name="objNeedyPerson"></param>
        /// <returns></returns>
        public static int SaveReferringAgency(PersonNeedAssistance objNeedyPerson, int CurrentHistoryID)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psSetReferringAgency";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@ReferringAgencyDetailID", DbType.Int32, objNeedyPerson.RefAgencyDetailID);
                db.AddInParameter(dbCommand, "@NeedyPersonID", DbType.Int32, objNeedyPerson.NeedyPersonID);
                db.AddInParameter(dbCommand, "@ContactHistoryID", DbType.Int32, CurrentHistoryID);
                db.AddInParameter(dbCommand, "@SiteID", DbType.Int32, HttpContext.Current.Session["CurrentSiteId"]);
                db.AddInParameter(dbCommand, "@ActionBy", DbType.String, MySession.strUserName);
                db.AddInParameter(dbCommand, "@ContactInfo", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.RefContactInfo));    //Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data
                db.AddInParameter(dbCommand, "@AgencyName", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.RefAgencyName));      //Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data
                db.AddInParameter(dbCommand, "@ContactName", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.RefContactName));    //Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data
                db.AddInParameter(dbCommand, "@PhoneNumber", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.RefPhoneNumber));    //Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data
                db.AddInParameter(dbCommand, "@Email", DbType.String, Sanitizer.GetSafeHtmlFragment(objNeedyPerson.RefEmail));                //Modified by RK,20March2024,Task-ID: 24527,Purpose: Sanitization of data                                         
                db.AddOutParameter(dbCommand, "@NewRefAgencyDetailID", DbType.Int32, 10);
                
                db.ExecuteNonQuery(dbCommand);
                return Convert.ToInt32(db.GetParameterValue(dbCommand, "@NewRefAgencyDetailID"));
            }
        }

        /// <summary>
        /// Created By: KP
        /// Date:20th Dec 2019(SOW-577)
        /// Purpose: Get the Referring Agency Details based on NeedyPersonID 
        /// </summary>
        /// <param name="NeedyPersonID"></param>
        /// <returns></returns>
        public static DataTable GetReferringAgencyDetails(int NeedyPersonID)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psGetReferringAgencyDetails";

            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {

                //db.AddInParameter(dbCommand, "@FKSiteID", DbType.Int32, HttpContext.Current.Session["CurrentSiteId"]); 
                db.AddInParameter(dbCommand, "@NeedyPersonID", DbType.Int32, NeedyPersonID);

                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }

        /// <summary>
        /// Created By: KP
        /// Date:20th Dec 2019(SOW-577)
        /// Purpose: Delete a refrence from tblReferringAgencyXHistory     
        /// </summary>
        /// <param name="NeedyPersonID"></param>
        /// <param name="CurrentHistoryID"></param>
        /// <returns></returns>
        public static void DeleteReferringAgency(int NeedyPersonID, int CurrentHistoryID)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psDeleteReferringAgency";

            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@NeedyPersonID", DbType.Int32, NeedyPersonID);
                db.AddInParameter(dbCommand, "@ContactHistoryID", DbType.Int32, CurrentHistoryID);
                db.ExecuteNonQuery(dbCommand);
            }
        }

        /// <summary>
        /// Created By: KP
        /// Date: 24th Dec 2019(SOW-577), 
        /// Purpose: Get the Call History (Last 7 Days) details.
        /// </summary>
        public static DataTable GetLast7DaysCallHistory()
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            
            using (DbCommand dbCommand = db.GetStoredProcCommand("psGetLast7DaysCallDetailsOfAgency"))
            {
                db.AddInParameter(dbCommand, "@SiteID", DbType.Int32, MySession.SiteId);
                
                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }
        /// <summary>
        /// Created By: KP
        /// Date: 24th Dec 2019(SOW-577)
        /// Purpose: Smart Search will fetch the Needy Person data based on name or phone of Person Needing Assistance or Contact Person.
        /// </summary>
        /// <returns></returns>
        public static DataTable GetSmartSearchNeeding(string SmartSearch, Int16 IsUpdateCall, int? SiteId = 0, int? AAAsiteID = 0)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);

            string cmd = "";
            if (IsUpdateCall == 1)
                cmd = "psSmartSearch_UpdateCall";
            else
                cmd = "psSmartSearch_SearchPerson";

            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@AAASiteID", DbType.Int32, AAAsiteID);
                db.AddInParameter(dbCommand, "@FKSiteID", DbType.Int32, SiteId);
                db.AddInParameter(dbCommand, "@SmartSearch", DbType.String, SmartSearch);              

                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }
        /// <summary>
        /// Created By: KP
        /// Date:2nd Jan(SOW-577)     
        /// Purpose: Get Contact Type Info based on Site Ids 
        /// </summary>
        /// <param name="SiteID"></param>
        /// <returns></returns>
        public static DataSet GetContactTypeInfo(string SiteID)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psGetContactTypeInfo";

            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {                
                db.AddInParameter(dbCommand, "@SiteID", DbType.String, SiteID);

                return db.ExecuteDataSet(dbCommand);
            }
        }
        /// <summary>
        /// Created By: KP
        /// Date:22nd Jan(SOW-577)
        /// Purpose: Get Conatct info list based on Contact info and SiteID.
        /// </summary>
        /// <param name="NeedyPersonID"></param>
        /// <returns></returns>
        public static DataTable GetContactTypeInfoByInfo(string ContactInfo, int ContactTypeID, int? NeedyPersonID = null)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psGetContactTypeInfoByInfo";

            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@SiteID", DbType.Int32, HttpContext.Current.Session["CurrentSiteId"]);
                db.AddInParameter(dbCommand, "@ContactTypeID", DbType.Int32, ContactTypeID);
                db.AddInParameter(dbCommand, "@ContactInfo", DbType.String, ContactInfo);
                db.AddInParameter(dbCommand, "@NeedyPersonID", DbType.Int32, NeedyPersonID);

                return db.ExecuteDataSet(dbCommand).Tables[0];
            }
        }

        /// <summary>
        /// Created By: KP
        /// Date: 13th March 2020(SOW-577)
        /// Purpose: Get the report selection columns for filling all dropdwon.
        /// </summary>
        /// <returns></returns>
        public static DataSet GetReportSelectionFields()
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psGetReportSelectionFields";
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                return db.ExecuteDataSet(dbCommand);
            }
        }

        /// <summary>
        /// Created By: KP
        /// Date: 25th March 2020
        /// Purpose: Get  ADRC Other Service List Agency Wise
        /// </summary>
        /// <returns></returns>
        public static DataTable GetOtherServicesList(string siteid)
        {
            Database db = DatabaseFactory.CreateDatabase(MySession.strAppDB);
            DbProviderFactory dbpf = db.DbProviderFactory;
            db = new Microsoft.Practices.EnterpriseLibrary.Data.GenericDatabase(AISProtectData.DPAPI.UnProtectData(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString), dbpf);
            string cmd = "psRptGetOtherServicesBySiteID";

            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                db.AddInParameter(dbCommand, "@SiteID", DbType.String, siteid);

                return db.ExecuteDataSet(dbCommand).Tables[0];

            }
        }

        #endregion


    }
}