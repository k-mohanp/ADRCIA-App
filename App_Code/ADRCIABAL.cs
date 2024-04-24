using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Transactions;
using System.IO;
using System.DirectoryServices;
using System.Net.Mail;
using System.Diagnostics;
namespace ADRCIA
{
    /// <summary>
    /// Class for Contact Person section
    /// </summary>
    public class PersonContact
    {
        public int? ContactPersonID { get; set; }
        public int NeedyPersonID { get; set; }
        public bool IsPrimaryContactPerson { get; set; }
        //Person Details
        public string FirstName { get; set; }
        public string MI { get; set; }
        public string LastName { get; set; }
        public string PhonePrimary { get; set; }
        public string PhonePrimaryExtn { get; set; }//Added by:BS on 14-sep-2016
        public string PhoneAlt { get; set; }
        public string PhoneAltExtn { get; set; }//Added by:BS on 14-sep-2016
        public string CFax { get; set; }//Added by:BS on 19-Dec-2016
        public string Email { get; set; }
        public string Address { get; set; }
        public string CityName { get; set; }
        public string CountyName { get; set; }
        public string TownshipCode { get; set; } // Added by GK on 10Apr19 : SOW-563
        public int? CustomCode { get; set; } // Added by GK on 14May19 : SOW-563
        public string State { get; set; }
        public string Zip { get; set; }

        //Contact Preference
        public bool ContactPreferencePhone { get; set; }
        public bool ContactPreferenceEmail { get; set; }
        public bool ContactPreferenceSMS { get; set; }
        public bool ContactPreferenceMail { get; set; }
        public bool ContactPreferenceOthers { get; set; } //Added By KR On 05/12/2015
        public string ContactPreferenceOthersInPerson { get; set; } //Added By KR on 05/12/2015
        public string Relationship { get; set; }
        // public bool? IsContactCaregiver { get; set; }//Added by VK 03 Aug,2017 For get/Set. 

        public string Title { get; set; }//Added By KP on 31st Jan 2020(SOW-577), Used for Needy Personal.
        
    }
    [Serializable()]
    public class ReferredEmail
    {
        public string NeedyPersonName { get; set; }
        public string DOB { get; set; }
        public string Gender { get; set; }
        public string ReferredBy { get; set; }
        public string ReferredTo { get; set; }
    }

    /// <summary>
    /// Class for person needing assistance section
    /// </summary>
    public class PersonNeedAssistance : PersonContact
    {
        public string ContactId { get; set; }
        public string PersonID { get; set; }
        //Contact Date and Time
        public string ContactDate { get; set; }
        public string ContactTime { get; set; }
        //Contact Type
        public int? ContactTypeID { get; set; }
        public string ContactTypeName { get; set; }
        public string ContactTypeOther { get; set; }
        //Contact Method
        public int? ContactMethodID { get; set; }
        public string ContactMethodName { get; set; }
        public string ContactMethodOther { get; set; }
        //ADRC, Info
        public bool IsInfoOnly { get; set; }
        public bool IsADRC { get; set; }
        public string IsInfoOnlyYesNo { get; set; }
        public string IsADRCYesNo { get; set; }
        //Person needing Assistance other field
        public string DOB { get; set; }
        public int? Age { get; set; }
        public string PrimaryLanguage { get; set; }

        public string Gender { get; set; }
        public int? MarriageStatusID { get; set; }
        public string MarriageStatus { get; set; }
        public int? RaceID { get; set; }
        public string Race { get; set; }
        //Veteran status
        public int? VeteranStatusID { get; set; }
        public string VeteranStatus { get; set; }

        public int? EthnicityID { get; set; }
        public string Ethnicity { get; set; }
        //follow up
        public int? FollowUp { get; set; }
        public int? OCFollowUp { get; set; }// Added by SA on 10-11-2014. SOW-335
        public string FollowUpYesNo { get; set; }
        public string FollowupDate { get; set; }
        public string OCFollowupDate { get; set; }// Added by SA on 10-11-2014. SOW-335
        public bool FollowupCompleted { get; set; }// add by SM , 4 April 2014, 
        public bool ReferredForOC { get; set; }// Added by SA on 10-11-2014. SOW-335
        public string ReferredForOCDate { get; set; }// Added by SA on 21st Aug, 2015. SOW-379
        public string FollowupNotes { get; set; } // add by SM , 4 April 2014
        public string OCFollowupNotes { get; set; }// Added by SA on 10-11-2014. SOW-335
        // Services already in place and its notes.
        public bool IsServicesAlreadyinPlace { get; set; }// Added by SA on 24-11-2014. SOW-335
        public string ServicesAlreadyinPlaceNotes { get; set; }// Added by SA on 24-11-2014. SOW-335

        //service Requested
        public string ServiceRequested { get; set; }
        public string OtherServiceRequested { get; set; }

        public int? ServiceNeedsMet { get; set; }
        public string ServiceNeedsMetYesNo { get; set; }
        //Reffered By /TO
        public int? ReferredByAgencyID { get; set; }
        public int? ReferredToAgencyID { get; set; }
        //public string RefToADRCIDs { get; set; }
        public string getRefToADRCIDs { get; set; }
        public string ReferredByOtherAgency { get; set; }
        public string ReferredToOtherAgency { get; set; }
        public string ReferredToOtherServiceProvider { get; set; } //Added By KR on 05/12/2015
        public bool? IsPermissionGranted { get; set; }
        //Call duration
        public string CallDuration { get; set; }
        public bool IsManualCallDuration { get; set; }//Added by KP on 28th Feb 2020(SOW-577)
        // Notes 
        public string Notes { get; set; }
        public string AllPreviousNotes { get; set; }
        public string InfoRequested { get; set; }
        public string OtherNotes { get; set; }
        //Living Arrangement
        public int? LivingID { get; set; }
        public string LivingArrangement { get; set; }
        public string VeteranApplicable { get; set; }
        //History ID
        public int? HistoryID { get; set; }// call HistoryId
        public string ReferredToServiceProvider { get; set; }
        public bool IsToDo { get; set; }
        //Followup History ID
        public int? FollowupHistoryID { get; set; }

        //Alternate Contact Info
        // Added by PM 3-April-2014
        //Purpose: Add 3)	Alternate Contact Info (under Person Needing Assistance tab)
        public string AltFirstName { get; set; }
        public string AltMI { get; set; }
        public string AltLastName { get; set; }
        public string AltPhone { get; set; }
        public string AltPhoneExtn { get; set; }//Added by:BS on 14-sep-2016
        public string NPrimaryFax { get; set; }//Added by:BS on 19-sep-2016
        public string NAltFax { get; set; }//Added by:BS on 19-sep-2016
        public string AltEmail { get; set; }
        public string AltRelationship { get; set; }
        public string UserName { get; set; }
        public string LastCallBy { get; set; }
        //Added on 3-11-2014. SA, SOW-335 (under Person Needing Assistance tab - Personal Information)
        public int? DisabilityTypes { get; set; }
        public string IsDisability { get; set; }
        public string DisabilityTypesOther { get; set; }

        /// Option Counseling Section
        /// Added by SA on 19-11-2014. SOW-335.

        public bool? IsCareGiverStatus { get; set; }
        public string InsuranceTypes { get; set; }// Changed from int to string to hold multiselection ids
        public string InsuranceTypesOther { get; set; }
        public bool IsOCTriggerPresent { get; set; }
        public string OCTriggers { get; set; }
        public int? LMIsReportedDiagnosed { get; set; }
        public bool? LacksMemoryYesNo { get; set; }
        public int? LMImpairements { get; set; }
        public string TotalAssetAmount { get; set; }
        public string HouseholdIncome { get; set; }
        public string SpouseIncome { get; set; }
        public string ClientIncome { get; set; }
        public bool IsNotToDevelop { get; set; }
        public bool IsToDevelop { get; set; }
        public bool IsPermissionForCall { get; set; }
        public string TravelDate { get; set; }
        public string TravelTime { get; set; }
        public int? ResearchingResources { get; set; }
        public int? Communications { get; set; }
        public string OCFinancialNotes { get; set; }

        public bool IsFundsProvided { get; set; }//Added By KR on 21 March 2017
        public decimal? FundsProvidedAmount { get; set; }//Added By KR on 21 March 2017
        // Added by VK 03 Aug,2017 For get/Set. 
        public string FundsUtilizedIDs { get; set; }
        public string FundsUtilizedDate { get; set; }

        //public bool IsPreferredContactNOther { get; set; } // Added By:KR, date:05-13-2015
        //public string PreferredContactNOther { get; set; } // Added By:KR, date:05-13-2015

        //Addition ends here.

        public bool IsDemographics { get; set; } //Added by KP on 28-Sep-2017 - SOW-485              
        public DateTime? AgeOn { get; set; }//Added by VK on 24 April,2019.

        //Added By KP on 18th Dec 2019(SOW-577), Used for Referring Agency section.
        public int RefAgencyDetailID { get; set; }
        public string RefContactInfo { get; set; }
        public string RefAgencyName { get; set; }
        public string RefContactName { get; set; }
        public string RefPhoneNumber { get; set; }
        public string RefEmail { get; set; }
        public bool IsContacTypeForReferringAgency { get; set; }
        public string FundsUtilizedForOther { get; set; } // Added by GK on 28June,2021 TicketID #2544
    }
    /// <summary>
    /// class for drop down field
    /// </summary>
    public class clsDDL
    {
        public string ValueField { get; set; }
        public string TextField { get; set; }
    }
    /// <summary>
    /// Class for Serach resuld field
    /// </summary>
    public class SearchResultField
    {
        public int ContactPersonID { get; set; }
        public int NeedyPersonID { get; set; }
        public string ContactPersonFirstName { get; set; } //Rename 'ContactPersonName' By KR on 20th Aug 2015
        public string ContactPersonLastName { get; set; } //Added By KR on 20th Aug 2015
        public string ContactPersonPhonePri { get; set; }
        public string ContactPersonPhoneAlt { get; set; }
        public string ContactPersonEmail { get; set; }
        public string NeedyPersonFirstName { get; set; } //Rename 'NeedyPersonName' By KR on 20th Aug 2015
        public string NeedyPersonLastName { get; set; }//Added By KR on 20th Aug 2015
        public string NeedyPersonPhonePri { get; set; }
        public string NeedyPersonPhoneAlt { get; set; }
        public string NeedyPersonEmail { get; set; }
        public string NeedyPersonDOB { get; set; }
        public string ContactDateTime { get; set; }
        public string UserName { get; set; } //Added By KR on 19th May, 2015
        public int CallHistoryID { get; set; }
        public string ADRCAgencyName { get; set; }
        public string ADRCSiteId { get; set; }

    }

    public class clsFollowupReminderList
    {
        public string UserName { get; set; }
        public int FollowupID { get; set; }
        public int CallHistoryID { get; set; }
        public int NeedyPersonID { get; set; }
        public int ContactPersonID { get; set; }
        public string NeedyPersonName { get; set; }
        public string LastCallAndTime { get; set; }
        public string FollowupDate { get; set; }
        public string ContactDateTime { get; set; }
        public string FollowupCreatedBy { get; set; }
        public string CallDuration { get; set; }
        public string FollowupCreatedModifedBy { get; set; }// Added by SM on 29 Aug 2014
        public bool IsToDo { get; set; }

    }

    /// <summary>
    /// Added by GK on 11May2019 : SOW-563
    /// </summary>
    [Serializable()]
    public class CustomField
    {
        public string CustomCode { get; set; }
        public string CustomName { get; set; }
        public int FKAAASiteID { get; set; }
        public int DisplayOrder { get; set; }
        public bool IsDeleted { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedOn { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime ModifiedOn { get; set; }
    }
      
    public class ADRCIABAL
    {


        public static Boolean SaveData(PersonNeedAssistance objNd, PersonContact objPerson, bool IsSelfContactType, bool IsNewContact)
        {
            int? ContactPersonID;
            bool isSavedSuccess = false;
            int CurrentHistoryID = 0;
            int CurretFollowupID = 0;

            using (TransactionScope transSaveSite = new TransactionScope())
            {
                try
                {
                    //if contact type is Self and old needy Person
                    if (IsSelfContactType == true && IsNewContact == false)
                    {
                        objNd.NeedyPersonID = ADRCIADAL.SaveNeedyPerson(objNd);



                        if (!string.IsNullOrEmpty(Convert.ToString(HttpContext.Current.Session["ContactPersonID"])))
                        {

                            ADRCIADAL.SaveCallHistory(objNd, Convert.ToInt32(HttpContext.Current.Session["ContactPersonID"]), out CurrentHistoryID, out CurretFollowupID);
                            ADRCIADAL.SaveOptionCounselling(objNd);// Added by SA on 20-11-2014. SOW-335// Set Option Counselling

                        }
                        else
                        {
                            ADRCIADAL.SaveCallHistory(objNd, null, out CurrentHistoryID, out CurretFollowupID);
                            ADRCIADAL.SaveOptionCounselling(objNd);// Added by SA on 20-11-2014. SOW-335// Set Option Counselling

                        }

                    }
                    //if contact type is not  Self for New Needy Person
                    else if (IsSelfContactType == false && IsNewContact == true)
                    {
                        objNd.NeedyPersonID = ADRCIADAL.SaveNeedyPerson(objNd);

                        objPerson.NeedyPersonID = objNd.NeedyPersonID;

                        ContactPersonID = ADRCIADAL.SaveContactPerson(objPerson);
                        HttpContext.Current.Session["ContactPersonID"] = ContactPersonID;
                        ADRCIADAL.SaveCallHistory(objNd, ContactPersonID, out CurrentHistoryID, out CurretFollowupID);
                        ADRCIADAL.SaveOptionCounselling(objNd);// Added by SA on 20-11-2014. SOW-335// Set Option Counselling
                    }
                    //if contact type is Self for  New  Needy Person
                    else if (IsSelfContactType == true && IsNewContact == true)
                    {
                        objNd.NeedyPersonID = ADRCIADAL.SaveNeedyPerson(objNd);
                        objPerson.NeedyPersonID = objNd.NeedyPersonID;
                        ADRCIADAL.SaveCallHistory(objNd, null, out CurrentHistoryID, out CurretFollowupID);
                        ADRCIADAL.SaveOptionCounselling(objNd); //Added by SA on 20-11-2014. SOW-335// Set Option Counselling

                    }

                    else if (IsSelfContactType == false && IsNewContact == false)// Added.
                    {
                        objNd.NeedyPersonID = ADRCIADAL.SaveNeedyPerson(objNd);
                        objPerson.NeedyPersonID = objNd.NeedyPersonID;
                        ////ContactPersonID = ADRCIADAL.SaveContactPerson(objPerson);
                        //HttpContext.Current.Session["ContactPersonID"] = objPerson.ContactPersonID;
                        ADRCIADAL.SaveCallHistory(objNd, objPerson.ContactPersonID, out CurrentHistoryID, out CurretFollowupID);
                        ADRCIADAL.SaveOptionCounselling(objNd);
                    }                    

                    HttpContext.Current.Session["CurrentHistoryID"] = CurrentHistoryID;
                    HttpContext.Current.Session["CurrentFollowupID"] = CurretFollowupID;
                    HttpContext.Current.Session["NeedyPersonID"]     = objNd.NeedyPersonID;

                    //Added by KP on 18th Dec 2019(SOW-577) 
                    if (!string.IsNullOrEmpty(objNd.ContactTypeOther))//Save Referring Agency details.
                    {
                        HttpContext.Current.Session["ReferringAgencyDetailID"] = ADRCIADAL.SaveReferringAgency(objNd, CurrentHistoryID);
                    }
                    else if(objNd.RefAgencyDetailID > 0 || objNd.IsContacTypeForReferringAgency)//Delete Referring Agency referece, whenever user change the ContactType selection as 'Self' or 'Caregiver' etc.
                    {
                        ADRCIADAL.DeleteReferringAgency(objNd.NeedyPersonID, CurrentHistoryID);
                    }
                    //End 

                        isSavedSuccess = true;
                    objPerson = null;

                    transSaveSite.Complete();
                    transSaveSite.Dispose();
                }
                catch (SqlException ex)
                {
                    ADRCIA.ADRCIABAL.Log(sqlEx: ex);
                }
            }

            return isSavedSuccess;

        }


        /// <summary>
        /// Created By: SM
        /// Date:03/10/2013
        /// Purpsoe: Get needy Person details 
		/// Modify by VK on 12 April,2021.Ticket 1687:Error in application name (ADRCIA)
        /// </summary>
        /// <param name="NeedyPersonID"></param>
        /// <returns></returns>
        public static PersonNeedAssistance GetNeedyDetails(int NeedyPersonID, int CallHistoryID = 0)
        {
            PersonNeedAssistance objNeedy = new PersonNeedAssistance();

            //Reder to get person needing assistance  details
            SqlDataReader Rdr = ADRCIADAL.GetNeedyPersonDetails(NeedyPersonID, CallHistoryID);
            if (Rdr.HasRows)
            {
                Rdr.Read();

                if (Rdr["Title"] != DBNull.Value)//Added By KP on 31st Jan 2020(SOW-577)
                    objNeedy.Title = Convert.ToString(Rdr["Title"]); 

                objNeedy.FirstName = HttpUtility.HtmlDecode(Rdr["FirstName"].ToString());  //Modified by AR, 09-April-2024 | Desanitization of Data
                objNeedy.MI = HttpUtility.HtmlDecode(Convert.ToString(Rdr["MI"]));         //Modified by AR, 09-April-2024 | Desanitization of Data

                //Added by SA on 4-11-2014. SOW-335
                if (Rdr["DisabilityTypes"] != DBNull.Value)
                    objNeedy.DisabilityTypes = Convert.ToInt32(Rdr["DisabilityTypes"]);
                else
                    objNeedy.DisabilityTypes = null;

                if (Rdr["DisabilityTypesOther"] != DBNull.Value)
                    objNeedy.DisabilityTypesOther = HttpUtility.HtmlDecode(Convert.ToString(Rdr["DisabilityTypesOther"])); //Modified by AR, 09-April-2024 | Desanitization of Data
                else
                    objNeedy.DisabilityTypesOther = null;


                objNeedy.IsDisability = Rdr["IsDisability"].ToString();
                if (Rdr["IsServicesAlreadyinPlace"] != DBNull.Value)
                    objNeedy.IsServicesAlreadyinPlace = Convert.ToBoolean(Rdr["IsServicesAlreadyinPlace"]);

                if (Rdr["ServicesAlreadyinPlaceNotes"] != DBNull.Value)
                    objNeedy.ServicesAlreadyinPlaceNotes = HttpUtility.HtmlDecode(Convert.ToString(Rdr["ServicesAlreadyinPlaceNotes"]));
                else
                    objNeedy.ServicesAlreadyinPlaceNotes = string.Empty;


                objNeedy.LastName = HttpUtility.HtmlDecode(Convert.ToString(Rdr["LastName"])); //Modified by AR, 09-April-2024 | Desanitization of Data
                if (Rdr["PhonePrimary"] != DBNull.Value)
                    objNeedy.PhonePrimary = HttpUtility.HtmlDecode(Convert.ToString(Rdr["PhonePrimary"])); //Modified by AR, 09-April-2024 | Desanitization of Data

                if (Rdr["PhonePrimaryExtn"] != DBNull.Value)//Added by BS on 15-sep-2016
                    objNeedy.PhonePrimaryExtn = HttpUtility.HtmlDecode(Convert.ToString(Rdr["PhonePrimaryExtn"])); //Modified by AR, 09-April-2024 | Desanitization of Data

                if (Rdr["PhoneAlt"] != DBNull.Value)
                    objNeedy.PhoneAlt = HttpUtility.HtmlDecode(Convert.ToString(Rdr["PhoneAlt"])); //Modified by AR, 09-April-2024 | Desanitization of Data

                if (Rdr["PhoneAltExtn"] != DBNull.Value)//Added by BS on 15-sep-2016
                    objNeedy.PhoneAltExtn = HttpUtility.HtmlDecode(Convert.ToString(Rdr["PhoneAltExtn"])); //Modified by AR, 09-April-2024 | Desanitization of Data

                if (Rdr["FaxPrimary"] != DBNull.Value)//Added by BS on 19-Dec-2016
                    objNeedy.NPrimaryFax = HttpUtility.HtmlDecode(Convert.ToString(Rdr["FaxPrimary"]));    //Modified by AR, 09-April-2024 | Desanitization of Data

                if (Rdr["FaxAlt"] != DBNull.Value)//Added by BS on 20-Dec-2016
                    objNeedy.NAltFax = HttpUtility.HtmlDecode(Convert.ToString(Rdr["FaxAlt"])); //Modified by AR, 09-April-2024 | Desanitization of Data

                objNeedy.Email = HttpUtility.HtmlDecode(Convert.ToString(Rdr["Email"]));        //Modified by AR, 09-April-2024 | Desanitization of Data
                objNeedy.Address = HttpUtility.HtmlDecode(Convert.ToString(Rdr["Address"]));

                // Added by PM 3-April-2014
                //Purpose: Add 3)	Alternate Contact Info (under Person Needing Assistance tab)

                objNeedy.AltFirstName = HttpUtility.HtmlDecode(Rdr["AltFirstName"].ToString()); //Modified by AR, 09-April-2024 | Desanitization of Data
                objNeedy.AltMI = HttpUtility.HtmlDecode(Convert.ToString(Rdr["AltMName"]));     //Modified by AR, 09-April-2024 | Desanitization of Data

                objNeedy.AltLastName = HttpUtility.HtmlDecode(Convert.ToString(Rdr["AltLastName"])); //Modified by AR, 09-April-2024 | Desanitization of Data
                if (Rdr["AltPhone"] != DBNull.Value)
                    objNeedy.AltPhone = HttpUtility.HtmlDecode(Convert.ToString(Rdr["AltPhone"]));   //Modified by AR, 09-April-2024 | Desanitization of Data

                if (Rdr["AltPhoneExtn"] != DBNull.Value)//Added by BS on 15-sep-2016
                    objNeedy.AltPhoneExtn = HttpUtility.HtmlDecode(Convert.ToString(Rdr["AltPhoneExtn"]));   //Modified by AR, 09-April-2024 | Desanitization of Data

                objNeedy.AltEmail = HttpUtility.HtmlDecode(Convert.ToString(Rdr["AltEmail"]));               //Modified by AR, 09-April-2024 | Desanitization of Data
                objNeedy.AltRelationship = HttpUtility.HtmlDecode(Convert.ToString(Rdr["AltRelationShip"])); //Modified by AR, 09-April-2024 | Desanitization of Data

                //End

                if (Rdr["CityName"] != DBNull.Value)
                    objNeedy.CityName = HttpUtility.HtmlDecode(Convert.ToString(Rdr["CityName"]));     //Modified by AR, 09-April-2024 | Desanitization of Data
                else
                    objNeedy.CityName = "--Select--";

                if (Rdr["CountyName"] != DBNull.Value)
                    objNeedy.CountyName = HttpUtility.HtmlDecode(Convert.ToString(Rdr["CountyName"])); //Modified by AR, 09-April-2024 | Desanitization of Data
                else

                    objNeedy.CountyName = "--Select--";

                // Added by GK on 10Apr19 : SOW-563
                if (Rdr["FKTownshipCode"] != DBNull.Value) objNeedy.TownshipCode = Convert.ToString(Rdr["FKTownshipCode"]);
                if (Rdr["FKCustomCode"] != DBNull.Value) objNeedy.CustomCode = Convert.ToInt32(Rdr["FKCustomCode"]);

                objNeedy.State = HttpUtility.HtmlDecode(Convert.ToString(Rdr["State"])); //Modified by AR, 09-April-2024 | Desanitization of Data
                objNeedy.Zip = HttpUtility.HtmlDecode(Convert.ToString(Rdr["Zip"]));     //Modified by AR, 09-April-2024 | Desanitization of Data
                if (Rdr["IsContactPreferencePhone"] != DBNull.Value)
                    objNeedy.ContactPreferencePhone = Convert.ToBoolean(Rdr["IsContactPreferencePhone"]);
                if (Rdr["IsContactPreferenceEmail"] != DBNull.Value)
                    objNeedy.ContactPreferenceEmail = Convert.ToBoolean(Rdr["IsContactPreferenceEmail"]);
                if (Rdr["IsContactPreferenceSMS"] != DBNull.Value)
                    objNeedy.ContactPreferenceSMS = Convert.ToBoolean(Rdr["IsContactPreferenceSMS"]);
                if (Rdr["IsContactPreferenceMail"] != DBNull.Value)
                    objNeedy.ContactPreferenceMail = Convert.ToBoolean(Rdr["IsContactPreferenceMail"]);

                ////Added by KR on 05--12-2015
                //if (Rdr["IsContactPreferenceOther"] != DBNull.Value)
                //    objNeedy.ContactPreferenceOthers = Convert.ToBoolean(Rdr["IsContactPreferenceOther"]);
                ////Added Section End Here

                if (Rdr["DOB"] != DBNull.Value)
                    objNeedy.DOB = HttpUtility.HtmlDecode(Convert.ToString(Rdr["DOB"])); //Modified by AR, 09-April-2024 | Desanitization of Data

                if (Rdr["Age"] != DBNull.Value)
                    objNeedy.Age = Convert.ToInt32(Rdr["Age"]);
                //Added by vk on April,2019 for AgeOn.
                if (Rdr["AgeOn"] != DBNull.Value)
                    objNeedy.AgeOn = Convert.ToDateTime(Rdr["AgeOn"]);

                if (Rdr["PrimaryLanguage"] != DBNull.Value)
                    objNeedy.PrimaryLanguage = Convert.ToString(Rdr["PrimaryLanguage"]);



                if (Rdr["Gender"] != DBNull.Value)
                    objNeedy.Gender = Convert.ToString(Rdr["Gender"]);
                else
                    objNeedy.Gender = "-1";

                if (Rdr["FKMaritalStatusID"] != DBNull.Value)
                    objNeedy.MarriageStatusID = Convert.ToInt32(Rdr["FKMaritalStatusID"]);
                else
                    objNeedy.MarriageStatusID = -1;

                objNeedy.IsDemographics = Convert.ToBoolean(Rdr["IsDemographics"]);//Added by KP on 28-Sep-2017 - SOW-485    

                if (Rdr["FKRaceID"] != DBNull.Value)
                    objNeedy.RaceID = Convert.ToInt32(Rdr["FKRaceID"]);
                else
                    objNeedy.RaceID = -1;
                if (Rdr["FKEthnicityID"] != DBNull.Value)
                    objNeedy.EthnicityID = Convert.ToInt32(Rdr["FKEthnicityID"]);
                else
                    objNeedy.EthnicityID = -1;

                if (Rdr["FKVeteranStatusID"] != DBNull.Value)
                    objNeedy.VeteranStatusID = Convert.ToInt32(Rdr["FKVeteranStatusID"]);
                else
                    objNeedy.VeteranStatusID = -1;
                objNeedy.CallDuration = null;
                //if (Rdr["FollowUp"] != DBNull.Value)
                //    objNeedy.FollowUp = Convert.ToInt32(Rdr["FollowUp"]);
                //else
                //    objNeedy.FollowUp = -1;

                // Commented by GK on 09Dec2021 : TicketID #6715
                //if (Rdr["ServiceReqOther"] != DBNull.Value)
                //    objNeedy.OtherServiceRequested = Convert.ToString(Rdr["ServiceReqOther"]);

                //if (Rdr["ServiceNeedsMet"] != DBNull.Value)
                //    objNeedy.ServiceNeedsMet = Convert.ToInt32(Rdr["ServiceNeedsMet"]);
                //else
                //    objNeedy.ServiceNeedsMet = -1;

                if (Rdr["FKReferredByAgencyID"] != DBNull.Value)
                    objNeedy.ReferredByAgencyID = Convert.ToInt32(Rdr["FKReferredByAgencyID"]);
                else
                    objNeedy.ReferredByAgencyID = -1;

                //if (Rdr["FKReferredToAgencyID"] != DBNull.Value)
                //    objNeedy.ReferredToAgencyID = Convert.ToInt32(Rdr["FKReferredToAgencyID"]);
                //else
                //    objNeedy.ReferredToAgencyID = -1;

                if (Rdr["FKReferredToAgencyID"] != DBNull.Value)
                    objNeedy.getRefToADRCIDs = Convert.ToString(Rdr["FKReferredToAgencyID"]);
                else
                    objNeedy.getRefToADRCIDs = string.Empty;

                if (Rdr["FKReferredToServiceProvider"] != DBNull.Value)
                    objNeedy.ReferredToServiceProvider = Convert.ToString(Rdr["FKReferredToServiceProvider"]);
                else
                    objNeedy.ReferredToServiceProvider = null;

                objNeedy.ReferredByOtherAgency = HttpUtility.HtmlDecode(Convert.ToString(Rdr["ReferredByOtherAgency"])); //Modified by AR, 09-April-2024 | Desanitization of Data
                objNeedy.ReferredToOtherAgency = HttpUtility.HtmlDecode(Convert.ToString(Rdr["ReferredToOtherAgency"])); //Modified by AR, 09-April-2024 | Desanitization of Data

                objNeedy.ReferredToOtherServiceProvider = HttpUtility.HtmlDecode(Convert.ToString(Rdr["ReferredToServiceProviderOther"])); // added By: KR, Date:05-12-2015 //Modified by AR, 09-April-2024 | Desanitization of Data


                if (Rdr["IsPermissionGranted"] != DBNull.Value)
                    objNeedy.IsPermissionGranted = Convert.ToBoolean(Rdr["IsPermissionGranted"]);
                else
                    objNeedy.IsPermissionGranted = null;


                //if (Rdr["Notes"] != DBNull.Value)
                //objNeedy.Notes = Convert.ToString(Rdr["Notes"]);
                //if (Rdr["InfoRequested"] != DBNull.Value)
                //objNeedy.InfoRequested = Convert.ToString(Rdr["InfoRequested"]);

                if (Rdr["VeteranApplicable"] != DBNull.Value)
                    objNeedy.VeteranApplicable = Convert.ToString(Rdr["VeteranApplicable"]);
                if (Rdr["FKLivingID"] != DBNull.Value)
                    objNeedy.LivingID = Convert.ToInt32(Rdr["FKLivingID"]);
                else
                    objNeedy.LivingID = -1;
                //Commented by vk on 16 Aug,2017 , this value capture in tblcallhistory. 
                //if (Rdr["isFundProvided"] != DBNull.Value) //Added By KR on 21 March 2017
                //   objNeedy.IsFundsProvided = Convert.ToBoolean(Rdr["isFundProvided"]);//Added By KR on 21 March 2017
                //if (Rdr["FundProvided"] != DBNull.Value)//Added By KR on 21 March 2017
                //   objNeedy.FundsProvidedAmount = Convert.ToDecimal(Rdr["FundProvided"]);//Added By KR on 21 March 2017

                //get needy contact info (i.e. Contact Type, Contact method, ADRC and Info filed value )
                if (Rdr.NextResult())
                {
                    if (Rdr.HasRows)
                    {
                        Rdr.Read();
                        objNeedy.ContactDate = HttpUtility.HtmlDecode(Convert.ToString(Rdr["ContactDate"])); //Modified by AR, 09-April-2024 | Desanitization of Data

                        if (Rdr["ContactTypeID"] != DBNull.Value)
                            objNeedy.ContactTypeID = Convert.ToInt32(Rdr["ContactTypeID"]);
                        else
                            objNeedy.ContactTypeID = -1;

                        objNeedy.ContactTypeOther = Convert.ToString(Rdr["ContactTypeOther"]);

                        if (Rdr["ContactMethodID"] != DBNull.Value)
                            objNeedy.ContactMethodID = Convert.ToInt32(Rdr["ContactMethodID"]);
                        else
                            objNeedy.ContactMethodID = -1;

                        objNeedy.ContactMethodOther = HttpUtility.HtmlDecode(Convert.ToString(Rdr["ContactMethodOther"])); //Modified by AR, 09-April-2024 | Desanitization of Data


                        objNeedy.IsADRC = Convert.ToBoolean(Rdr["IsADRC"]);
                        objNeedy.IsInfoOnly = Convert.ToBoolean(Rdr["IsInfoOnly"]);
                        objNeedy.ContactDate = HttpUtility.HtmlDecode(Rdr["ContactDate"].ToString());  //Modified by AR, 09-April-2024 | Desanitization of Data
                        objNeedy.ContactTime = Rdr["ContactTime"].ToString();
                        objNeedy.AllPreviousNotes = Rdr["AllPreNotes"].ToString();
                        if (Rdr["Notes"] != DBNull.Value)
                            objNeedy.Notes = HttpUtility.HtmlDecode(Convert.ToString(Rdr["Notes"]));
                        if (Rdr["InfoRequested"] != DBNull.Value)
                            objNeedy.InfoRequested = HttpUtility.HtmlDecode(Convert.ToString(Rdr["InfoRequested"])); //Modified by AR, 09-April-2024 | Desanitization of Data

                        //Other Notes
                        if (Rdr["OtherNotes"] != DBNull.Value)
                            objNeedy.OtherNotes = HttpUtility.HtmlDecode(Convert.ToString(Rdr["OtherNotes"])); // Modified by GK on 09Feb,2022 Ticket #7935

                        //Get FollowUp
                        if (Rdr["FollowUp"] != DBNull.Value)
                            objNeedy.FollowUp = Convert.ToInt32(Rdr["FollowUp"]);
                        else
                            objNeedy.FollowUp = -1;

                        // Added by SA on 11-11-2014. SOW-335.

                        if (Rdr["OCFollowUp"] != DBNull.Value)
                            objNeedy.OCFollowUp = Convert.ToInt32(Rdr["OCFollowUp"]);
                        else
                            objNeedy.OCFollowUp = -1;

                        if (Rdr["OCFollowUpDate"] != DBNull.Value)
                            objNeedy.OCFollowupDate = HttpUtility.HtmlDecode(Convert.ToString(Rdr["OCFollowUpDate"])); //Modified by AR, 09-April-2024 | Desanitization of Data
                        else
                            objNeedy.OCFollowupDate = string.Empty;

                        if (Rdr["OCFollowUpNotes"] != DBNull.Value)
                            objNeedy.OCFollowupNotes = HttpUtility.HtmlDecode(Convert.ToString(Rdr["OCFollowUpNotes"]));

                        objNeedy.ReferredForOC = Convert.ToBoolean(Rdr["IsReferredForOC"]);
                        // Added by SA on 21st Aug, 2015. SOW-379
                        if (Rdr["IsReferredForOCDate"] != DBNull.Value)
                            objNeedy.ReferredForOCDate = HttpUtility.HtmlDecode(Convert.ToString(Rdr["IsReferredForOCDate"])); //Modified by AR, 09-April-2024 | Desanitization of Data

                        //addition ends here.
                        //get Follow up Date
                        if (Rdr["Followupdate"] != DBNull.Value)
                            objNeedy.FollowupDate = HttpUtility.HtmlDecode(Convert.ToString(Rdr["Followupdate"])); //Modified by AR, 09-April-2024 | Desanitization of Data
                        else
                            objNeedy.FollowupDate = string.Empty;

                        // Get Service Need Mets
                        if (Rdr["ServiceNeedsMet"] != DBNull.Value)
                            objNeedy.ServiceNeedsMet = Convert.ToInt32(Rdr["ServiceNeedsMet"]);
                        else
                            objNeedy.ServiceNeedsMet = -1;

                        //get followup completed status
                        objNeedy.FollowupCompleted = Convert.ToBoolean(Rdr["IsFollowupCompleted"]); // Added By: SM, Date:04 April 2014
                        objNeedy.FollowupNotes = HttpUtility.HtmlDecode(Convert.ToString(Rdr["FollowupNotes"])); // Added By: SM, Date: 04 April 2014

                        //get to do
                        if (Rdr["ToDo"] != DBNull.Value)
                            objNeedy.IsToDo = Convert.ToBoolean(Rdr["ToDo"]);
                        else
                            objNeedy.IsToDo = false;

                        if (Rdr["CallDurationMin"] != DBNull.Value)
                        {
                            objNeedy.CallDuration = Convert.ToString(Rdr["CallDurationMin"]);
                        }

                        if (Rdr["IsManualCallDuration"] != DBNull.Value)//Added by KP on 28th Feb 2020(SOW-577)
                            objNeedy.IsManualCallDuration = Convert.ToBoolean(Rdr["IsManualCallDuration"]);

                        if (Rdr["FollowupHistoryID"] != DBNull.Value)
                            objNeedy.FollowupHistoryID = Convert.ToInt32(Rdr["FollowupHistoryID"]);
                        else
                            objNeedy.FollowupHistoryID = 0;
                        // Added by VK 03 Aug,2017 For get/Set IsFundsProvided,FundsProvidedAmount,FundsUtilizedDate,
                        if (Rdr["IsFundsProvided"] != DBNull.Value)
                            objNeedy.IsFundsProvided = Convert.ToBoolean(Rdr["IsFundsProvided"]);
                        if (Rdr["FundsProvidedAmount"] != DBNull.Value)
                            objNeedy.FundsProvidedAmount = Convert.ToDecimal(Rdr["FundsProvidedAmount"]);
                        else
                            objNeedy.FundsProvidedAmount = null;

                        // Added by GK on 28June,2021 TicketID #2544
                        if (Rdr["FundsUtilizedForOther"] != DBNull.Value)
                            objNeedy.FundsUtilizedForOther = HttpUtility.HtmlDecode(Rdr["FundsUtilizedForOther"].ToString()); //Modified by AR, 09-April-2024 | Desanitization of Data

                        if (Rdr["FundsUtilizedDate"] != DBNull.Value)
                            objNeedy.FundsUtilizedDate = HttpUtility.HtmlDecode(Convert.ToString(Rdr["FundsUtilizedDate"])); //Modified by AR, 09-April-2024 | Desanitization of Data
                        else
                            objNeedy.FundsUtilizedDate = string.Empty;

                        //Added by: SM, date: 03 June 2014
                        if (Rdr["LastCallBy"] != DBNull.Value)
                            objNeedy.LastCallBy = Rdr["LastCallBy"].ToString();
                        else
                            objNeedy.LastCallBy = string.Empty;

                        // Added by GK on 9Dec,2021 TicketID #6715
                        if (Rdr["ServiceReqOther"] != DBNull.Value)
                            objNeedy.OtherServiceRequested = Convert.ToString(Rdr["ServiceReqOther"]);
                    }

                }
                // Option Counselling section by SA. SOW-335
                if (Rdr.NextResult())
                {
                    if (Rdr.HasRows)
                    {
                        Rdr.Read();

                        //OCFinancialNotes
                        if (Rdr["OCFinancialNotes"] != DBNull.Value)
                            objNeedy.OCFinancialNotes = HttpUtility.HtmlDecode(Convert.ToString(Rdr["OCFinancialNotes"]));
                        else
                            objNeedy.OCFinancialNotes = string.Empty;

                        if (Rdr["CaregiverStatus"] != DBNull.Value)
                            objNeedy.IsCareGiverStatus = Convert.ToBoolean(Rdr["CaregiverStatus"]);
                        else
                            objNeedy.IsCareGiverStatus = null;

                        if (Rdr["InsuranceTypes"] != DBNull.Value)
                        {
                            objNeedy.InsuranceTypes = Convert.ToString(Rdr["InsuranceTypes"]);
                        }
                        else
                        { objNeedy.InsuranceTypes = null; }

                        if (Rdr["InsuranceTypesOther"] != DBNull.Value)
                        {
                            objNeedy.InsuranceTypesOther = HttpUtility.HtmlDecode(Convert.ToString(Rdr["InsuranceTypesOther"])); //Modified by AR, 09-April-2024 | Desanitization of Data
                        }
                        else
                        { objNeedy.InsuranceTypesOther = null; }


                        objNeedy.IsOCTriggerPresent = Convert.ToBoolean(Rdr["IsOCTriggerPresent"]);

                        if (Rdr["OCTriggers"] != DBNull.Value)
                        {
                            objNeedy.OCTriggers = Convert.ToString(Rdr["OCTriggers"]);
                        }
                        else
                        { objNeedy.OCTriggers = null; }

                        if (Rdr["LMIsReportedDiagnosed"] != DBNull.Value)
                            objNeedy.LMIsReportedDiagnosed = Convert.ToInt32(Rdr["LMIsReportedDiagnosed"]);
                        else
                            objNeedy.LMIsReportedDiagnosed = null;

                        if (Rdr["LacksMemoryYesNo"] != DBNull.Value)
                            objNeedy.LacksMemoryYesNo = Convert.ToBoolean(Rdr["LacksMemoryYesNo"]);
                        else
                            objNeedy.LacksMemoryYesNo = null;

                        if (Rdr["LMImpairements"] != DBNull.Value)
                        { objNeedy.LMImpairements = Convert.ToInt32(Rdr["LMImpairements"]); }
                        else { objNeedy.LMImpairements = null; }

                        if (Rdr["TotalAssetAmount"] != DBNull.Value)
                        {
                            objNeedy.TotalAssetAmount = HttpUtility.HtmlDecode(Convert.ToString(Rdr["TotalAssetAmount"])); //Modified by AR, 09-April-2024 | Desanitization of Data
                        }
                        else
                        { objNeedy.TotalAssetAmount = null; }

                        if (Rdr["TotalHouseholdIncome"] != DBNull.Value)
                        {
                            objNeedy.HouseholdIncome = HttpUtility.HtmlDecode(Convert.ToString(Rdr["TotalHouseholdIncome"])); //Modified by AR, 09-April-2024 | Desanitization of Data
                        }
                        else
                        { objNeedy.HouseholdIncome = null; }

                        if (Rdr["TotalSpouseIncome"] != DBNull.Value)
                        {
                            objNeedy.SpouseIncome = HttpUtility.HtmlDecode(Convert.ToString(Rdr["TotalSpouseIncome"])); //Modified by AR, 09-April-2024 | Desanitization of Data
                        }
                        else
                        { objNeedy.SpouseIncome = null; }

                        if (Rdr["TotalClientIncome"] != DBNull.Value)
                        {
                            objNeedy.ClientIncome = HttpUtility.HtmlDecode(Convert.ToString(Rdr["TotalClientIncome"])); //Modified by AR, 09-April-2024 | Desanitization of Data
                        }
                        else
                        { objNeedy.ClientIncome = null; }


                        objNeedy.IsNotToDevelop = Convert.ToBoolean(Rdr["IsNotToDevelop"]);
                        objNeedy.IsToDevelop = Convert.ToBoolean(Rdr["IsToDevelop"]);
                        objNeedy.IsPermissionForCall = Convert.ToBoolean(Rdr["IsPermissionForCall"]);



                    }
                }

                //get Contact ID           
                if (Rdr.NextResult())
                {
                    Rdr.Read();
                    objNeedy.ContactId = Rdr["ContactID"].ToString();
                }

                //Added by KP on 18th Dec 2019(SOW-577), Get Referring Agency Details.
                if (Rdr.NextResult())
                {
                    if (Rdr.HasRows)
                    {
                        Rdr.Read();

                        objNeedy.RefAgencyDetailID = Rdr["ReferringAgencyDetailID"] != DBNull.Value ? Convert.ToInt32(Rdr["ReferringAgencyDetailID"]) : 0; 
                        objNeedy.RefContactInfo = Rdr["ContactInfo"] != DBNull.Value ? HttpUtility.HtmlDecode(Convert.ToString(Rdr["ContactInfo"])) : string.Empty; //Modified by AR, 09-April-2024 | Desanitization of Data
                        objNeedy.RefAgencyName = Rdr["AgencyName"] != DBNull.Value ? HttpUtility.HtmlDecode(Convert.ToString(Rdr["AgencyName"])) : string.Empty;    //Modified by AR, 09-April-2024 | Desanitization of Data
                        objNeedy.RefContactName = Rdr["ContactName"] != DBNull.Value ? HttpUtility.HtmlDecode(Convert.ToString(Rdr["ContactName"])) : string.Empty; //Modified by AR, 09-April-2024 | Desanitization of Data
                        objNeedy.RefPhoneNumber = Rdr["PhoneNumber"] != DBNull.Value ? HttpUtility.HtmlDecode(Convert.ToString(Rdr["PhoneNumber"])) : string.Empty; //Modified by AR, 09-April-2024 | Desanitization of Data
                        objNeedy.RefEmail = Rdr["Email"] != DBNull.Value ? HttpUtility.HtmlDecode(Convert.ToString(Rdr["Email"])) : string.Empty;                   //Modified by AR, 09-April-2024 | Desanitization of Data

                    }
                }
            }
                    
            Rdr.Dispose();
            return objNeedy;
        }


        /// <summary>
        /// Created By: SM
        /// Date: 11 April 2014
        /// Purpose: Generate file Stream.
        /// </summary>
        /// <param name="table"></param>
        /// <returns></returns>
        public static MemoryStream DataTableToStream(DataTable table)
        {

            MemoryStream ms;
            StringBuilder sb = new StringBuilder();

            sb.Append("<font style='font-size:11.0pt; font-family:Calibri;'>");
            sb.Append("<BR><BR><BR>");
            sb.Append("<Table border='1' bgColor='#ffffff' " +
              "borderColor='#000000' cellSpacing='0' cellPadding='0' " +
              "style='font-size:10.0pt; font-family:Calibri; background:white;'> <TR >");
            //sets font
            int Rowscount = table.Rows.Count;
            sb.Append("<Td  colspan='4'>");
            sb.Append("<B>");
            sb.Append("Total number of Agency:" + Rowscount.ToString());
            sb.Append("</B>");
            sb.Append("</Td>");
            sb.Append("</TR>");

            sb.Append(" <TR >");//  TR open
            // Column:- Agency name
            sb.Append("<Td style='color:White;background-color:#1a3895;' width='25%' align='center'>");
            sb.Append("<B>");
            sb.Append("Agency Name");
            sb.Append("</B>");
            sb.Append("</Td>");
            // Column:-  Services
            sb.Append("<Td style='color:White;background-color:#1a3895;' width='25%' align='center'>");
            sb.Append("<B>");
            sb.Append("Services");
            sb.Append("</B>");
            sb.Append("</Td>");
            // Column:-  Address
            //Get column headers  and make it as bold in excel columns
            sb.Append("<Td style='color:White;background-color:#1a3895;' width='20%' align='center'>");
            sb.Append("<B>");
            sb.Append("Address");
            sb.Append("</B>");
            sb.Append("</Td>");
            // Column:- Contact 
            //Get column headers  and make it as bold in excel columns
            sb.Append("<Td style='color:White;background-color:#1a3895;' width='30%' align='center'>");
            sb.Append("<B>");
            sb.Append("Contact");
            sb.Append("</B>");
            sb.Append("</Td>");

            sb.Append("</TR>"); // TR Close

            int count = 1;
            string strAltnatRow = "style='background-color:#F0F8FF;'";
            string strStyle = string.Empty;
            foreach (DataRow row in table.Rows)
            {  //write in new row
                sb.Append("<TR >"); // Open TR
                if (count % 2 == 0)
                    strStyle = strAltnatRow;
                else
                    strStyle = "";

                sb.Append("<Td " + strStyle + " valign='top' width='25%'>");
                sb.Append(Convert.ToString(row["SiteName"]));
                sb.Append("</Td>");

                sb.Append("<Td " + strStyle + " valign='top' width='25%' >");
                sb.Append(Convert.ToString(row["AgencyServices"]));
                sb.Append("</Td>");

                var ShowonMap = "";
                var Showlink = "http://maps.google.com/?q=" + Convert.ToString(row["AddressLine1"]) + " +" + Convert.ToString(row["City"]) + " +" + Convert.ToString(row["State"]) + " +" + Convert.ToString(row["Zip"]);
                ShowonMap = "<br/><a  href='" + Showlink + "' target='_blank' >Show on Map</a>";




                sb.Append("<Td " + strStyle + " valign='top' width='25%'>");
                sb.Append(Convert.ToString(row["AddressLine1"]) + ", " + Convert.ToString(row["AddressLine2"]) + "<br/>" + Convert.ToString(row["City"]) + "," + Convert.ToString(row["State"]) + "," + Convert.ToString(row["Zip"]));
                sb.Append(ShowonMap);
                sb.Append("</Td>");



                var WebAddressLink = "";
                if (Convert.ToString(row["WebAddress"]) != "")
                    WebAddressLink = "<br/>Website:<a  href=" + Convert.ToString(row["WebAddress"]) + "  target='_blank' >" + Convert.ToString(row["WebAddress"]) + "</a>";

                var Email = "";
                if (Convert.ToString(row["GenEmailAddress"]) != "")
                    Email = "<br/>Email:" + Convert.ToString(row["GenEmailAddress"]);


                sb.Append("<Td " + strStyle + " valign='top' >");
                sb.Append(Convert.ToString(row["Contact"]));
                sb.Append(Email);
                sb.Append(WebAddressLink);
                sb.Append("</Td>");
                sb.Append("</TR>");// close TR       
                count++;
            }
            sb.Append("</Table>");
            sb.Append("</font>");


            byte[] myByteArray = System.Text.Encoding.UTF8.GetBytes(sb.ToString());
            ms = new MemoryStream(myByteArray);
            //  sw.Write(sb.ToString());
            sb.Clear();
            return ms;


        }

        /// <summary>
        /// Created by: NK
        /// Date: 11 June 2014
        /// Purpose: To get all UserID from AD having member of specific OU (such as "FSEP") and Group (such as "SGAGRANTEE") and having active account
        /// Desc: To send SGA notification to who has member of SGAGRANTEE group
        /// </summary>
        /// <param name="OuName">FSEP</param>
        /// <param name="GroupName">SGAGRANTEE</param>      
        /// <returns></returns>
        public static StringBuilder GetUserInfoListOfOuAndGroup(string OuName, string GroupName)
        {
            string strDomainAndUsername = MySession.myWebConfig.domain + @"\" + MySession.strUserName;
            string ldapPrefix = MySession.myWebConfig.adPath.Substring(0, MySession.myWebConfig.adPath.LastIndexOf('/'));
            string ldapSuffix = MySession.myWebConfig.adPath.Substring(MySession.myWebConfig.adPath.LastIndexOf('/') + 1);
            StringBuilder UserGuid = new StringBuilder();

            DirectoryEntry entry = new DirectoryEntry(MySession.myWebConfig.adPath, "asinha1371", "Acro@1234");//strDomainAndUsername, HttpContext.Current.Session["AUTH_PASSWORD"].ToString()
            entry.RefreshCache();
            DirectoryEntry ou = entry.Children.Find("OU=PC");
            DirectoryEntry ouChild = ou.Children.Find("OU=" + OuName);
            DirectoryEntry group = ouChild.Children.Find("CN=" + GroupName, "group");
            group.RefreshCache();
            foreach (object ugroup in group.Properties["member"])
            {
                if (ugroup.ToString().Split(",=".ToCharArray()).Where(a => a == "CN").Count() != 0)
                {
                    DirectoryEntry user = new DirectoryEntry(ldapPrefix + "/" + ugroup.ToString() + "", strDomainAndUsername, HttpContext.Current.Session["AUTH_PASSWORD"].ToString());
                    int userAccountControl = (int)user.Properties["userAccountControl"][0];
                    user.Close();
                    if (!((userAccountControl & 2) > 0))
                    {

                        UserGuid.Append(ugroup.ToString().Split(",=".ToCharArray())[1] + ",");
                    }
                }
            }
            return UserGuid;
        }

        /// <summary>
        /// Created by SA on 26th March, 2015.
        /// Purpose: Log exception to DB and send mail.
        /// </summary>
        /// <param name="ex"></param>
        public static void Log(Exception ex = null, SqlException sqlEx = null)
        {
            try
            {
                string errADRCIA = "Error Message: ", strSubject = "ADRC I&A Issue";

                //StackTrace st = null; StackFrame sf = null;
                //if (ex != null)
                //{
                //    st = new StackTrace(ex, true);
                //}
                //sf = st.GetFrame(st.FrameCount - 1);

                if (sqlEx != null)
                {
                    errADRCIA += sqlEx.Message + "<br/>" + "Line No." + sqlEx.LineNumber.ToString() + "<br/>" + "Procedure Name: " + sqlEx.Procedure;
                }
                if (ex != null)
                {
                    errADRCIA += "<br/>" + ex.Message + "<br/>" + ex.StackTrace + "<br/>";
                }

                ADRCIADAL.SaveADRCIAError(errADRCIA);

                //string ToEmail = "sakhtar@acrocorp.com"; // commented by BS on 31-jan-2018
                ////MailAddress cc1 = new MailAddress("rkumar@acrocorp.com", "RK");
                ////MailAddress cc2 = new MailAddress("nkumar@acrocorp.com", "NK");
                //MailMessage mailMsg = new MailMessage(System.Configuration.ConfigurationManager.AppSettings["EmailFromID"], ToEmail, strSubject, errADRCIA);
                ////mailMsg.CC.Add(cc2);
                //mailMsg.IsBodyHtml = true;
                //SmtpClient smtp = new SmtpClient();
                //smtp.Host = System.Configuration.ConfigurationManager.AppSettings["SMTPClient"];// Set SMTP Server            
                ////smtp.DeliveryMethod = SmtpDeliveryMethod.PickupDirectoryFromIis;// uncomment for production                 
                //smtp.Send(mailMsg);
                //smtp.Dispose();

                SendMail objSendMail = new SendMail();//Added by BS on 31-Jan-2018 to send error mail 
                string EmailTo = System.Configuration.ConfigurationManager.AppSettings["ToError"].ToString();
                string EmailFrom = System.Configuration.ConfigurationManager.AppSettings["FromError"].ToString();
                //objSendMail.sendmail(EmailFrom, EmailTo, strSubject, errADRCIA, "");// commented by PC on 13-jan-2021, SOW-623

            }
            catch (Exception ex1) { }
        }
        /// <summary>
        /// Created By: KP
        /// Date: 20th Dec 2019(SOW-577)
        /// Purpose: Update a Referring Agency Detail.
        /// </summary>
        /// <param name="objNd"></param>
        /// <param name="CurrentHistoryID"></param>
        /// <returns></returns>
        public static Boolean UpdateReferringAgency(PersonNeedAssistance objNd, int CurrentHistoryID)
        {
            bool isSavedSuccess = false;

            using (TransactionScope transSaveReferringAgency = new TransactionScope())
            {
                try
                {
                    ADRCIADAL.SaveReferringAgency(objNd, CurrentHistoryID);
                    isSavedSuccess = true;

                    transSaveReferringAgency.Complete();
                    transSaveReferringAgency.Dispose();
                }
                catch (SqlException ex)
                {
                    ADRCIA.ADRCIABAL.Log(sqlEx: ex);
                }
            }

            return isSavedSuccess;

        }

    }

}