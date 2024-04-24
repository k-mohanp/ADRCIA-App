using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using ADRCIA;
public partial class AdminNeedyPersonSearch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        showHideDiv2.Attributes.Add("class", "");
        divPopUpContent2.Attributes.Add("class", "");
        divpnlContact2.Attributes.Add("style", "display:none");

        showHideDivCallDetails.Attributes.Add("class", "");
        divPopUpContentCallDetails.Attributes.Add("class", "");
        divpnlContactCallDetails.Attributes.Add("style", "display:none");

        showHideDivCP.Attributes.Add("class", "");
        divPopUpContentCP.Attributes.Add("class", "");
        divpnlContactCP.Attributes.Add("style", "display:none");
        

        if (!IsPostBack)
        {
            BindAAA();
        }
        

        //Added by KP on 6th Dec 2019(SOW-577),To dipslay proper message based on NeedySaved session value. 
        if (Session["NeedySaved"] != null)//(Request.QueryString["Saved"] != null)
        {
            string Message = "";
            if (Convert.ToString(HttpContext.Current.Session["IsCallUpdate"]) == "1")
                Message = "Person needing assistance update successfully.";
            else
                Message = "Person needing assistance save successfully.";

            if (Session["NeedySaved"].ToString() == "2")             
                Message += string.Format("<br/><br/> <span style=font-size:16px;line-height:20px;>Person ID: <b>{0}</b><br/> First Name: <b>{1}</b><br/>  Last Name: <b>{2}</b> </span>", Session["NeedyPersonID"], Session["NeedyFirstName"], Session["NeedyLastName"]);

            if (Session["Message"] != null && Session["Message"].ToString() != "")
                Message += @"<br/><br/>" + Session["Message"].ToString().Trim().Replace('\r', ' ').Replace('\n', ' ').Replace('\t', ' ') + "";

            System.Web.UI.ScriptManager.RegisterStartupScript(this, this.GetType(), "saved1", " ShowAlert('" + Message + "','S');", true); //Added By BS on 6-Feb-2018 Task ID-10142
            Session["NeedySaved"] = null;//reset as null after message is displayed.
        }

        ClearSession();        
    }
    /// <summary>
    /// Created By: SM
    /// Date:08/27/2013
    /// Purpose:Clear Session;
    /// </summary>
    void ClearSession()
    {
        Session["ContactPersonID"] = null;
        Session["CurrentHistoryID"] = null;
        Session["CurrentFollowupID"] = null;
        Session["TimerLimit"] = null;
        Session["minutLimit"] = null;
        Session["PrintNeedyId"] = null;// for print needy page
        Session["PrintCallHistoryId"] = null;// for print needy page
        Session["CurrentSiteId"] = null;
    }


    /// <summary>
    /// Created By: SM
    /// Date:04/09/2013
    /// Purpose: Get Serch result
    /// </summary>
    /// <param name="strName"></param>
    /// <param name="strPhone"></param>
    /// <param name="strSearchType"></param>
    /// <returns></returns>

    [System.Web.Services.WebMethod(CacheDuration = 0)]

    public static SearchResultField[] GetPersonDetails(string strFirstName, string strLastName, string strPhone, string strSearchType, Int16 IsUpdateCall, int AAASiteID, string ContactFirstName, string ContactLastName, string ContactPhone)
    {
        if (ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
        {
            DataTable dt = ADRCIA.ADRCIADAL.GetPersonNeeding(strFirstName.Trim(), strLastName.Trim(), strPhone.Trim(), strSearchType, IsUpdateCall, null, AAASiteID, ContactFirstName, ContactLastName, ContactPhone);

            return GetNeedyList(dt, IsUpdateCall);
        }
        else
            return null;
    }
    /// <summary>
    /// Create BY: SM
    /// Date:24Jan2014
    /// </summary>

    private void BindAAA()
    {
        ////// bind AAA  as Reffred by Agency
        ddlAAACILName.DataSource = ADRCIA.ADRCIADAL.GetAAACILAgency();
        ddlAAACILName.DataValueField = "AAACILSiteID";
        ddlAAACILName.DataTextField = "AAACILSiteName";
        ddlAAACILName.DataBind();
        ddlAAACILName.Items.Insert(0, new ListItem("--All--", "-1"));
        //ddlAAACILName.Items.Insert(1, new ListItem("OSA", "0"));//commented By KP on 2nd Apr 2020(TaskID:18464)

    }

    /// <summary>
    /// Created By: SM
    /// Date:03/15/2013
    /// Purpose:Get Call History with respect to person needing assistance
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod(CacheDuration = 0)]
    public static PersonNeedAssistance[] GetCallHistory(int NeedyID)
    {
        if (ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
        {
            List<PersonNeedAssistance> list = new List<PersonNeedAssistance>();
            DataTable dt = ADRCIA.ADRCIADAL.GetCallHistory(NeedyID);
            foreach (DataRow row in dt.Rows)
            {
                PersonNeedAssistance objNeedy = new PersonNeedAssistance();
                objNeedy.HistoryID = Convert.ToInt32(row["ContactHistoryID"]);
                objNeedy.PersonID = Convert.ToString(row["FKContactPersonDetailID"]);
                objNeedy.NeedyPersonID = NeedyID;
                //objNeedy.FirstName = Convert.ToString(row["Name"]);//Commneted By kuldeep rathore on 21th Aug, 2015. SOW-379
                //Added By Kuldeep rathore 21th Aug,2015. SOW-379
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
                objNeedy.IsADRC = Convert.ToBoolean(row["IsADRC"]);
                if (objNeedy.IsADRC)
                    objNeedy.IsADRCYesNo = "Yes";
                else
                    objNeedy.IsADRCYesNo = "No";

                objNeedy.IsInfoOnly = Convert.ToBoolean(row["IsInfoOnly"]);
                if (objNeedy.IsInfoOnly)
                    objNeedy.IsInfoOnlyYesNo = "Yes";
                else
                    objNeedy.IsInfoOnlyYesNo = "No";

                objNeedy.ContactTime = Convert.ToString(row["ContactTime"]);
                objNeedy.ServiceRequested = Convert.ToString(row["ReqServices"]);
                objNeedy.IsToDo = Convert.ToBoolean(row["ToDo"]);
                objNeedy.UserName = Convert.ToString(row["UserName"]);
                list.Add(objNeedy);
            }
            return list.ToArray();
        }
        else
        {
            return null;
        }
    }

    /// <summary>
    /// Created By:SM
    /// Date : 24Jan2014
    /// Purpose: Delete Particuler call
    /// </summary>
    /// <param name="CallId"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod(CacheDuration = 0)]
    public static bool DeleteCall(int CallId)
    {
        if (ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
        {
            return ADRCIADAL.DeleteCallByCallId(CallId);
        }
        else
        {
            return false;
        }
    }

    /// <summary>
    /// Created By: SM
    /// Date:24 Jan 2014
    /// Purpose: Delete  Contact person by contact person id
    /// </summary>
    /// <param name="ContactPersonId"></param>
    /// <returns></returns>

    [System.Web.Services.WebMethod(CacheDuration = 0)]
    public static bool DeleteContactPerson(int ContactPersonId)
    {
        if (ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
        {
            int i = ADRCIADAL.DeleteContactPerson(ContactPersonId);
            if (i > 0)
                return true;
            else
                return false;
        }
        else
        {
            return false;
        }
    }


    /// <summary>
    /// Created By: SM
    /// Date: 24 Jan 2014
    /// Purpose: Get Contact Person w.r.t. needy Person Id
    /// </summary>
    /// <param name="NeedyID"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod(CacheDuration = 0)]
    public static SearchResultField[] GetContactPersonByNeedyID(int NeedyID)
    {
        if (ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
        {
            List<SearchResultField> listSearchResult = new List<SearchResultField>();


            DataTable dtContact = ADRCIA.ADRCIADAL.GetContactDetails(Convert.ToInt32(NeedyID));

            foreach (DataRow row in dtContact.Rows)
            {
                SearchResultField objSearch = new SearchResultField();
                //Needy Person Searched Result
                objSearch.NeedyPersonID = Convert.ToInt32(row["FKPersonNeedingDetailID"]);
                //Contact Person Searched Result
                if (row["ContactPersonDetailID"] != DBNull.Value)
                    objSearch.ContactPersonID = Convert.ToInt32(row["ContactPersonDetailID"]);
                else
                    objSearch.ContactPersonID = 0;

                //objSearch.ContactPersonName = Convert.ToString(row["Name"]); //Commnetd by kuldeep rathore on 21th Aug, 2015. SOW-379
                //Added By Kuldeep Rathore on 21th aug, 2015. SOW-379
                objSearch.ContactPersonFirstName = Convert.ToString(row["FirstName"]);
                objSearch.ContactPersonLastName = Convert.ToString(row["LastName"]);

                if (row["PhonePrimary"] != DBNull.Value)
                    objSearch.ContactPersonPhonePri = Convert.ToString(row["PhonePrimary"]);
                if (row["PhoneAlt"] != DBNull.Value)
                    objSearch.ContactPersonPhoneAlt = Convert.ToString(row["PhoneAlt"]);

                objSearch.ContactPersonEmail = Convert.ToString(row["Email"]);

                // Search object Added to list
                listSearchResult.Add(objSearch);
            }
            return listSearchResult.ToArray();
        }
        else
        {
            return null;
        }
    }

    /// <summary>
    /// Created By: SM
    /// Date: 24 Jan 2014
    /// Purpose: Delete All information that are associated with  a Needy i.e. 
    /// Delete all call  history, Followup history, Requested Service History and Contact Person 
    /// that are assosicated with needy.
    /// </summary>
    /// <param name="NeedyPersonId"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod(CacheDuration = 0)]
    public static bool DeleteNeedyPerson(int NeedyPersonId)
    {
        if (ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
        {
            return ADRCIADAL.DeleteNeedyPerson(NeedyPersonId);
        }
        else
        {
            return false;
        }
    }

    /// <summary>
    /// Created By: SM
    /// Date:27 Jan 2014
    /// Purpose:Get Call History with respect to Contact Person
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod(CacheDuration = 0)]
    public static PersonNeedAssistance[] GetContactPersonCallHistory(int ContactPersonID, int NeedyPersonID)
    {
        if (ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
        {
            List<PersonNeedAssistance> list = new List<PersonNeedAssistance>();
            DataTable dt = ADRCIA.ADRCIADAL.GetContactPersonCallHistory(ContactPersonID, NeedyPersonID);
            foreach (DataRow row in dt.Rows)
            {
                PersonNeedAssistance objNeedy = new PersonNeedAssistance();
                objNeedy.HistoryID = Convert.ToInt32(row["ContactHistoryID"]);
                objNeedy.PersonID = Convert.ToString(row["FKContactPersonDetailID"]);
                objNeedy.NeedyPersonID = Convert.ToInt32(row["FKPersonNeedingDetailID"]);
                objNeedy.ContactPersonID = ContactPersonID;
                //objNeedy.FirstName = Convert.ToString(row["Name"]);//Commnetd by kuldeep rathore on 21th Aug, 2015. SOW-379
                //Added by kuldeep rathore on 21th Aug, 2015. SOW-379
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
                objNeedy.IsADRC = Convert.ToBoolean(row["IsADRC"]);
                if (objNeedy.IsADRC)
                    objNeedy.IsADRCYesNo = "Yes";
                else
                    objNeedy.IsADRCYesNo = "No";

                objNeedy.IsInfoOnly = Convert.ToBoolean(row["IsInfoOnly"]);
                if (objNeedy.IsInfoOnly)
                    objNeedy.IsInfoOnlyYesNo = "Yes";
                else
                    objNeedy.IsInfoOnlyYesNo = "No";

                objNeedy.ContactTime = Convert.ToString(row["ContactTime"]);
                objNeedy.ServiceRequested = Convert.ToString(row["ReqServices"]);
                objNeedy.IsToDo = Convert.ToBoolean(row["ToDo"]);
                objNeedy.UserName = Convert.ToString(row["UserName"]);
                list.Add(objNeedy);
            }
            return list.ToArray();
        }
        else
        {
            return null;
        }
    }


    [System.Web.Services.WebMethod(CacheDuration = 0)]
    public static PersonNeedAssistance[] GetCallHistoryDetails(int HistoryID, int NeedyID)
    {
        if (ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
        {
            List<PersonNeedAssistance> list = new List<PersonNeedAssistance>();
            DataTable dt = ADRCIA.ADRCIADAL.GetCallHistoryDetails(HistoryID, NeedyID);
            foreach (DataRow row in dt.Rows)
            {
                PersonNeedAssistance objNeedy = new PersonNeedAssistance();
                objNeedy.HistoryID = Convert.ToInt32(row["ContactHistoryID"]);
                //objNeedy.FirstName = Convert.ToString(row["Name"]);//Commnetd by kuldeep rathore on 21th Aug, 2015. SOW-379
                //Added by kuldeep rathore on 21th Aug, 2015. SOW-379
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
                objNeedy.IsToDo = Convert.ToBoolean(row["ToDo"]);
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

                objNeedy.PhonePrimary = Convert.ToString(row["PhonePrimary"]);

                objNeedy.Relationship = Convert.ToString(row["Relationship"]);


                //Added by KP on 30th Jan 2020(SOW-577), Get Referring Agency fields
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
        else
        {
            return null;
        }
    }

    static SearchResultField[] GetNeedyList(DataTable dt, Int16 IsUpdateCall)
    {
        List<SearchResultField> listSearchResult = new List<SearchResultField>();

        foreach (DataRow row in dt.Rows)
        {
            SearchResultField objSearch = new SearchResultField();

            //Needy Person Searched Result
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

            if (row["NeedyPhonePri"] != DBNull.Value)
                objSearch.ContactPersonPhonePri = Convert.ToString(row["ContactPersonPhonePri"]);
            if (row["NeedyPhoneAlt"] != DBNull.Value)
                objSearch.ContactPersonPhoneAlt = Convert.ToString(row["ContactPersonPhoneAlt"]);
            objSearch.ContactPersonEmail = Convert.ToString(row["ContactPersonEmail"]);
            objSearch.ContactDateTime = Convert.ToString(row["ContactDatetime"]);
            
            if (IsUpdateCall == 1)
                objSearch.UserName = Convert.ToString(row["UserName"]);
            
            if (row["CallHistoryID"] != DBNull.Value)
                objSearch.CallHistoryID = Convert.ToInt32(row["CallHistoryID"]);
            
            objSearch.ADRCAgencyName = row["ADRCAgencyName"].ToString();
            
            objSearch.ADRCSiteId = Convert.ToString(row["ADRCSiteId"]); // Added by GK on 26July18 : Setting individual current siteId for each record.
            
            // Search object Added to list
            listSearchResult.Add(objSearch);
        }
        return listSearchResult.ToArray();
    }

    [System.Web.Services.WebMethod(CacheDuration = 0)]
    public static SearchResultField[] GetSmartSearchNeeding(string SmartSearch, Int16 IsUpdateCall, int AAASiteID)
    {        
        if (ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
        {
            //Added By AV 9 Feb 2024 Ticket-23892
            SmartSearch = functions.SanitizeString(SmartSearch);
            DataTable dt = ADRCIA.ADRCIADAL.GetSmartSearchNeeding(SmartSearch.Trim(), IsUpdateCall, null, AAASiteID);

            return GetNeedyList(dt, IsUpdateCall);
        }
        else
        {
            return null;
        }
    }

}
