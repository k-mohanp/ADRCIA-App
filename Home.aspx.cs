using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using ADRCIA;
public partial class Home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ClearSession();

        displayMessages();


        showHideDiv2.Attributes.Add("class", "");
        divPopUpContent2.Attributes.Add("class", "");
        divpnlContact2.Attributes.Add("style", "display:none");

        showHideDiv3.Attributes.Add("class", "");
        divPopUpContent3.Attributes.Add("class", "");
        divpnlContact3.Attributes.Add("style", "display:none");


    }

    void ClearSession()
    {
        Session["ContactPersonID"] = null;
        Session["CurrentHistoryID"] = null;
        Session["CurrentFollowupID"] = null;
        Session["TimerLimit"] = null;
        Session["minutLimit"] = null;

    }
    // Commented by NK On 31 Oct 13
    private void displayMessages()
    {
        rptrMessages.DataSource = Messages.getADRCIAActiveMessages();
        rptrMessages.DataBind();
    }

    /// <summary>
    /// Created By: SM
    /// Date:07/03/2013
    /// Purpose:Display Foolow up reminder
    /// </summary>
    /// 

    [System.Web.Services.WebMethod(CacheDuration = 0)]
    public static clsFollowupReminderList[] GetFollowUpReminderList()
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        List<clsFollowupReminderList> Followuplist = new List<clsFollowupReminderList>();
        DataTable dtList = ADRCIADAL.GetFollowupReminder();
        foreach (DataRow row in dtList.Rows)
        {
            clsFollowupReminderList objFollowupitem = new clsFollowupReminderList();
            objFollowupitem.CallHistoryID = Convert.ToInt32(row["CallHistoryID"]);
            objFollowupitem.NeedyPersonID = Convert.ToInt32(row["NeedyPersonID"]);
            objFollowupitem.ContactPersonID = Convert.ToInt32(row["ContactPersonID"]);
            objFollowupitem.NeedyPersonName = Convert.ToString(row["Name"]);
            objFollowupitem.LastCallAndTime = Convert.ToString(row["LastCallDateAndTime"]);
            objFollowupitem.FollowupDate = Convert.ToString(row["Followupdate"]);
            objFollowupitem.FollowupCreatedModifedBy = Convert.ToString(row["UserName"]);
            Followuplist.Add(objFollowupitem);
        }
        return Followuplist.ToArray();

    }

    [System.Web.Services.WebMethod(CacheDuration = 0)]
    public static PersonNeedAssistance[] GetFollowupNeedyDetails(int HistoryID, int NeedyID)
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        DataTable dtND = ADRCIA.ADRCIADAL.GetCallHistoryDetails(HistoryID, NeedyID);//Modified by KP on 30th Jan 2020(SOW-577), 3rd parameter value('True') is removed from method.

        return SetNeedyDetailsProperty(dtND);

    }
    // NK on 31 Oct 13
    [System.Web.Services.WebMethod(CacheDuration = 0)]
    public static clsFollowupReminderList[] GetToDoList()
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        List<clsFollowupReminderList> Followuplist = new List<clsFollowupReminderList>();
        DataTable dtList = ADRCIADAL.GetToDo();
        foreach (DataRow row in dtList.Rows)
        {
            clsFollowupReminderList objFollowupitem = new clsFollowupReminderList();
            objFollowupitem.CallHistoryID = Convert.ToInt32(row["CallHistoryID"]);
            objFollowupitem.NeedyPersonID = Convert.ToInt32(row["NeedyPersonID"]);
            objFollowupitem.NeedyPersonName = Convert.ToString(row["Name"]);
            objFollowupitem.LastCallAndTime = Convert.ToString(row["LastCallDateAndTime"]);
            objFollowupitem.IsToDo = Convert.ToBoolean(row["ToDo"]);
            objFollowupitem.UserName = Convert.ToString(row["UserName"]);
            Followuplist.Add(objFollowupitem);
        }
        return Followuplist.ToArray();

    }
    // NK on 31 Oct 13
    [System.Web.Services.WebMethod(CacheDuration = 0)]
    public static bool SetToDo(int HistoryID, int NeedyID, Int16 ToDoFlag)
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return false;

        return ADRCIA.ADRCIADAL.SetToDo(HistoryID, NeedyID, ToDoFlag);

    }

    ///// <summary>
    ///// Created By: SM
    ///// Date:07/18/2013
    ///// Purpose: Last call details that was made in current Agency
    ///// </summary>
    ///// <returns></returns>
    //[System.Web.Services.WebMethod(CacheDuration = 0)]
    //public static PersonNeedAssistance[] GetLastCallDetailOfAgency()
    //{ DataTable dtND = ADRCIA.ADRCIADAL.GetLastCallDetailsOfAgency();
    //  return SetNeedyDetailsProperty(dtND);
    //}

    public static PersonNeedAssistance[] SetNeedyDetailsProperty(DataTable dtNeedyDetails)
    {

        List<PersonNeedAssistance> list = new List<PersonNeedAssistance>();
        foreach (DataRow row in dtNeedyDetails.Rows)
        {
            PersonNeedAssistance objNeedy = new PersonNeedAssistance();
            objNeedy.HistoryID = Convert.ToInt32(row["ContactHistoryID"]);
            objNeedy.NeedyPersonID = Convert.ToInt32(row["NeedyPersonID"]);
            //objNeedy.FirstName = Convert.ToString(row["Name"]);
            //Above Line Changed by kuldeep Rathore on 21th Aug due to Name Field does not exist.
            objNeedy.FirstName = Convert.ToString(row["FirstName"]);
            objNeedy.LastName = Convert.ToString(row["LastName"]);
            objNeedy.Email = Convert.ToString(row["Email"]);
            if (row["ContactDate"] != DBNull.Value)
                objNeedy.ContactDate = Convert.ToString(row["ContactDate"]);

            if (row["CallDurationMin"] != DBNull.Value)
                objNeedy.CallDuration = Convert.ToString(row["CallDurationMin"]);
            else
                objNeedy.CallDuration = string.Empty;
            if (row["ContactMethodName"] != DBNull.Value)
                objNeedy.ContactMethodName = Convert.ToString(row["ContactMethodName"]);

            if (row["ContactTypeName"] != DBNull.Value)
                objNeedy.ContactTypeName = Convert.ToString(row["ContactTypeName"]);

            objNeedy.Email = Convert.ToString(row["Email"]);
            objNeedy.IsADRCYesNo = Convert.ToString(row["IsADRC"]);
            //if (objNeedy.IsADRC)
            //    objNeedy.IsADRCYesNo = "Yes";
            //else
            //    objNeedy.IsADRCYesNo = "No";

            objNeedy.IsInfoOnlyYesNo = Convert.ToString(row["IsInfoOnly"]);
            //if (objNeedy.IsInfoOnly)
            //    objNeedy.IsInfoOnlyYesNo = "Yes";
            //else
            //    objNeedy.IsInfoOnlyYesNo = "No";

            objNeedy.ContactTime = Convert.ToString(row["ContactTime"]);
            objNeedy.ServiceRequested = Convert.ToString(row["ServiceRequested"]);
            //  get Notes
            objNeedy.Notes = Convert.ToString(row["Notes"]);
            //get Info request
            objNeedy.InfoRequested = Convert.ToString(row["InfoRequested"]);
            // get Follow up
            objNeedy.FollowUpYesNo = Convert.ToString(row["FollowUp"]);
            //Get Followup date
            objNeedy.FollowupDate = Convert.ToString(row["Followupdate"]);
            // get Service need Met
            objNeedy.ServiceNeedsMetYesNo = Convert.ToString(row["ServiceNeedsMet"]);

            // Added later for  followup needy details
            objNeedy.CityName = Convert.ToString(row["CityName"]);
            objNeedy.CountyName = Convert.ToString(row["CountyName"]);
            objNeedy.PhonePrimary = Convert.ToString(row["PhonePrimary"]);
            objNeedy.PhoneAlt = Convert.ToString(row["PhoneAlt"]);
            objNeedy.PrimaryLanguage = Convert.ToString(row["PrimaryLanguage"]);
            objNeedy.DOB = Convert.ToString(row["DOB"]);
            objNeedy.Age = row["Age"] != DBNull.Value ? Convert.ToInt32(row["Age"]) : (int?)null;
            objNeedy.Address = Convert.ToString(row["Address"]);
            objNeedy.Gender = Convert.ToString(row["Gender"]);
            objNeedy.Ethnicity = Convert.ToString(row["Ethnicity"]);
            objNeedy.LivingArrangement = Convert.ToString(row["LivingArrangement"]);

            objNeedy.MarriageStatus = Convert.ToString(row["MaritalStatus"]);
            objNeedy.Race = Convert.ToString(row["Race"]);
            objNeedy.VeteranStatus = Convert.ToString(row["VeteranStatus"]);
            objNeedy.State = Convert.ToString(row["State"]);
            objNeedy.Zip = Convert.ToString(row["Zip"]);

            objNeedy.ContactPreferencePhone = Convert.ToBoolean(row["IsContactPreferencePhone"]);
            objNeedy.ContactPreferenceEmail = Convert.ToBoolean(row["IsContactPreferenceEmail"]);
            objNeedy.ContactPreferenceSMS = Convert.ToBoolean(row["IsContactPreferenceSMS"]);
            objNeedy.ContactPreferenceMail = Convert.ToBoolean(row["IsContactPreferenceMail"]);
            objNeedy.Relationship = Convert.ToString(row["Relationship"]);

            //Added by KP on 29th Jan 2020(SOW-577), Get Referring Agency fields
            objNeedy.RefAgencyDetailID = row["ReferringAgencyDetailID"] != DBNull.Value ? Convert.ToInt32(row["ReferringAgencyDetailID"]) : 0;
            objNeedy.RefContactInfo = row["RefContactInfo"] != DBNull.Value ? Convert.ToString(row["RefContactInfo"]) : string.Empty;
            objNeedy.RefAgencyName = row["RefAgencyName"] != DBNull.Value ? Convert.ToString(row["RefAgencyName"]) : string.Empty;
            objNeedy.RefContactName = row["RefContactName"] != DBNull.Value ? Convert.ToString(row["RefContactName"]) : string.Empty;
            objNeedy.RefPhoneNumber = row["RefPhoneNumber"] != DBNull.Value ? Convert.ToString(row["RefPhoneNumber"]) : string.Empty;
            objNeedy.RefEmail = row["RefEmail"] != DBNull.Value ? Convert.ToString(row["RefEmail"]) : string.Empty;
            //End (SOW-577)

            list.Add(objNeedy);
        }
        return list.ToArray();

    }

    /// <summary>
    /// Created By: KP
    /// Date: 24th Dec 2019(SOW-577), 
    /// Purpose: Get the Call History (Last 7 Days) details.
    /// </summary>
    [System.Web.Services.WebMethod(CacheDuration = 0)]
    public static SearchResultField[] GetLast7DaysCallHistory()
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        List<SearchResultField> listSearchResult = new List<SearchResultField>();
        DataTable dt = ADRCIA.ADRCIADAL.GetLast7DaysCallHistory();

        foreach (DataRow row in dt.Rows)
        {
            SearchResultField objSearch = new SearchResultField();

            objSearch.NeedyPersonID = Convert.ToInt32(row["NeedyPersonID"]);
            objSearch.NeedyPersonFirstName = Convert.ToString(row["NeedyFirstName"]);
            objSearch.NeedyPersonLastName = Convert.ToString(row["NeedyLastName"]);
            if (row["NeedyDOB"] != DBNull.Value)
            {
                if (row["NeedyDOB"].ToString() != string.Empty)
                    objSearch.NeedyPersonDOB = Convert.ToString(row["NeedyDOB"]);
                else
                    objSearch.NeedyPersonDOB = "";
            }
            if (row["NeedyPhonePri"] != DBNull.Value)
                objSearch.NeedyPersonPhonePri = Convert.ToString(row["NeedyPhonePri"]);
            if (row["NeedyPhoneAlt"] != DBNull.Value)
                objSearch.NeedyPersonPhoneAlt = Convert.ToString(row["NeedyPhoneAlt"]);
            objSearch.NeedyPersonEmail = Convert.ToString(row["NeedyEmail"]);

            //Contact Person Searched Result
            if (row["ContactPersonDetailID"] != DBNull.Value)
                objSearch.ContactPersonID = Convert.ToInt32(row["ContactPersonDetailID"]);
            else
                objSearch.ContactPersonID = 0;

            objSearch.ContactPersonFirstName = Convert.ToString(row["ContactPersonFirstName"]);
            objSearch.ContactPersonLastName = Convert.ToString(row["ContactPersonLastName"]);

            if (row["ContactPersonPhonePri"] != DBNull.Value)
                objSearch.ContactPersonPhonePri = Convert.ToString(row["ContactPersonPhonePri"]);
            if (row["ContactPersonPhoneAlt"] != DBNull.Value)
                objSearch.ContactPersonPhoneAlt = Convert.ToString(row["ContactPersonPhoneAlt"]);
            objSearch.ContactPersonEmail = Convert.ToString(row["ContactPersonEmail"]);
            objSearch.ContactDateTime = Convert.ToString(row["ContactDatetime"]);

            objSearch.UserName = Convert.ToString(row["UserName"]);

            if (row["CallHistoryID"] != DBNull.Value)
                objSearch.CallHistoryID = Convert.ToInt32(row["CallHistoryID"]);

            // Search object Added to list
            listSearchResult.Add(objSearch);
        }
        return listSearchResult.ToArray();
    }




}