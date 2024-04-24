using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using ADRCIA;
public partial class NeedyPersonSearch : System.Web.UI.Page
{
    public Int16 IsUpdateCall1;
    protected void Page_Load(object sender, EventArgs e)
    {
        // Changes done by SA on 20th May, 2015.
        if (Request.QueryString["UC"] != null)
            IsUpdateCall1 = Convert.ToInt16(Request.QueryString["UC"].ToString());

        if (!IsPostBack)
        {
            //Modified by KP on 5th Dec 2019(SOW-577), To dipslay proper message based on NeedySaved session value. 
            if (Session["NeedySaved"] != null)//(Request.QueryString["Saved"] != null)
            {
                string Message = "Person needing assistance saved successfully.";

                if (Session["NeedySaved"].ToString() == "2") //(Request.QueryString["Saved"] == "1")                
                    Message += string.Format("<br/><br/> <span style=font-size:16px;line-height:20px;>Person ID: <b>{0}</b><br/> First Name: <b>{1}</b><br/>  Last Name: <b>{2}</b> </span>", Session["NeedyPersonID"], Session["NeedyFirstName"], Session["NeedyLastName"]);
                   
                if (Session["Message"] != null && Session["Message"].ToString() != "")
                    Message += @"<br/><br/>" + Session["Message"].ToString().Trim().Replace('\r', ' ').Replace('\n', ' ').Replace('\t', ' ') + "";

                System.Web.UI.ScriptManager.RegisterStartupScript(this, this.GetType(), "saved", " ShowAlert('" + Message + "','S');", true); //Added By BS on 6-Feb-2018 Task ID-10142
                Session["NeedySaved"] = null;//reset as null after message is displayed.
            }         

        }
        ClearSession();

        //Response.Write(MySession.SiteId.ToString());

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
    public static SearchResultField[] GetPersonDetails(string strFirstName, string strLastName, string strPhone, string strSearchType, Int16 IsUpdateCall, string ContactFirstName, string ContactLastName, string ContactPhone)
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        DataTable dt = ADRCIA.ADRCIADAL.GetPersonNeeding(strFirstName.Trim(), strLastName.Trim(), strPhone, strSearchType, IsUpdateCall, MySession.SiteId, null, ContactFirstName, ContactLastName, ContactPhone);

        return GetNeedyList(dt, IsUpdateCall);
    }

    [System.Web.Services.WebMethod(CacheDuration = 0)]
    public static SearchResultField[] GetSmartSearchNeeding(string SmartSearch, Int16 IsUpdateCall)
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        //Added By AV 9 Feb 2024 Ticket-23892
        SmartSearch = functions.SanitizeString(SmartSearch);
        DataTable dt = ADRCIA.ADRCIADAL.GetSmartSearchNeeding(SmartSearch.Trim(), IsUpdateCall, MySession.SiteId, null);

        return GetNeedyList(dt, IsUpdateCall);
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

            if (row["ContactPersonPhonePri"] != DBNull.Value)
                objSearch.ContactPersonPhonePri = Convert.ToString(row["ContactPersonPhonePri"]);
            if (row["ContactPersonPhoneAlt"] != DBNull.Value)
                objSearch.ContactPersonPhoneAlt = Convert.ToString(row["ContactPersonPhoneAlt"]);
            objSearch.ContactPersonEmail = Convert.ToString(row["ContactPersonEmail"]);
            objSearch.ContactDateTime = Convert.ToString(row["ContactDatetime"]);
            
            if (IsUpdateCall == 1)
                objSearch.UserName = Convert.ToString(row["UserName"]);

            if (row["CallHistoryID"] != DBNull.Value)
                objSearch.CallHistoryID = Convert.ToInt32(row["CallHistoryID"]);

            // Search object Added to list
            listSearchResult.Add(objSearch);
        }
        return listSearchResult.ToArray();
    }



}
