using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using ADRCIA;
[System.Web.Script.Services.ScriptService]
public partial class DashBoard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["CurrentHistoryID"] = null;// Added to clear it. SA on 28th Jan, 2015. SOW_335
        showHideDivND.Attributes.Add("class", "");
        divPopUpContentND.Attributes.Add("class", "");
        divpnlContactND.Attributes.Add("style", "display:none");


    }
    [System.Web.Services.WebMethod(CacheDuration = 0)]
    public static string GetPersonCountByAgency()
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        //List<VEXDocument> objListVEX = new List<VEXDocument>();
        DataTable dtlist = ADRCIADAL.GetPersonCountByAgency();
        return GetJson(dtlist);
    }

    // Added by PA
    [System.Web.Services.WebMethod(CacheDuration = 0)]
    public static string GetPersonCountByUser()
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        //List<VEXDocument> objListVEX = new List<VEXDocument>();
        DataTable dtlist = ADRCIADAL.GetPersonCountByUser();
        return GetJson(dtlist);
    }

    [System.Web.Services.WebMethod(CacheDuration = 0)]
    public static string GetNeedyPersonCountByService()
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        //List<VEXDocument> objListVEX = new List<VEXDocument>();
        DataTable dtlist = ADRCIADAL.GetNeedyPersonCountByService();
        return GetJson(dtlist);
    }

    [System.Web.Services.WebMethod(CacheDuration = 0)]
    public static string GetNdPersonBySiteIdOrServiceid(string SiteID, int ServiceID, int IsReqServiceMetNd, string UserID)
    {
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        //List<VEXDocument> objListVEX = new List<VEXDocument>();
        DataTable dtlist = ADRCIADAL.GetNdPersonBySiteIdOrServiceid(SiteID, ServiceID, IsReqServiceMetNd, UserID);
        return GetJson(dtlist);
    }




    /// <summary>
    /// Created By: SM
    /// Date:12 Sept 2013
    /// Purpose: Convert Data Table  row(s) value in JSON String format
    /// </summary>
    /// <param name="dt"></param>
    /// <returns></returns>
    public static string GetJson(DataTable dt)
    {
        System.Web.Script.Serialization.JavaScriptSerializer serializer =
           new System.Web.Script.Serialization.JavaScriptSerializer();
        List<Dictionary<string, object>> rows =
           new List<Dictionary<string, object>>();
        Dictionary<string, object> row = null;

        foreach (DataRow dr in dt.Rows)
        {
            row = new Dictionary<string, object>();
            foreach (DataColumn col in dt.Columns)
            {
                row.Add(col.ColumnName, dr[col]);
            }
            rows.Add(row);
        }
        return serializer.Serialize(rows);
    }

    //private void displayMessages()
    //{
    //    rptrMessages.DataSource = Messages.getADRCIAActiveMessages();
    //    rptrMessages.DataBind();
    //}
    ///// <summary>
    ///// Created By: SM
    ///// Date:07/03/2013
    ///// Purpose:Display Foolow up reminder
    ///// </summary>
    //private void DisplayFollowUpReminder()
    //{
    //    rptrFollowUp.DataSource = ADRCIADAL.getFollowupReminder();
    //    rptrFollowUp.DataBind();
    //}

    //[System.Web.Services.WebMethod(CacheDuration = 0)]
    //public static PersonNeedAssistance[] GetCallHistoryDetails(int HistoryID, int NeedyID)
    //{
    //    List<PersonNeedAssistance> list = new List<PersonNeedAssistance>();
    //    DataTable dt = ADRCIA.ADRCIADAL.GetCallHistoryDetails(HistoryID, NeedyID);
    //    foreach (DataRow row in dt.Rows)
    //    {
    //        PersonNeedAssistance objNeedy = new PersonNeedAssistance();
    //        objNeedy.HistoryID = Convert.ToInt32(row["ContactHistoryID"]);

    //        objNeedy.FirstName = Convert.ToString(row["Name"]);
    //        objNeedy.Email = Convert.ToString(row["Email"]);
    //        if (row["ContactDate"] != DBNull.Value)
    //            objNeedy.ContactDate = Convert.ToString(row["ContactDate"]);

    //        if (row["CallDurationMin"] != DBNull.Value)
    //            objNeedy.CallDuration = Convert.ToString(row["CallDurationMin"]);
    //        else
    //            objNeedy.CallDuration = string.Empty;
    //        if (row["ContactMethodName"] != DBNull.Value)
    //            objNeedy.ContactMethodName = Convert.ToString(row["ContactMethodName"]);

    //        if (row["ContactTypeName"] != DBNull.Value)
    //            objNeedy.ContactTypeName = Convert.ToString(row["ContactTypeName"]);

    //        objNeedy.Email = Convert.ToString(row["Email"]);
    //        objNeedy.IsADRCYesNo = Convert.ToString(row["IsADRC"]);
    //        //if (objNeedy.IsADRC)
    //        //    objNeedy.IsADRCYesNo = "Yes";
    //        //else
    //        //    objNeedy.IsADRCYesNo = "No";

    //        objNeedy.IsInfoOnlyYesNo = Convert.ToString(row["IsInfoOnly"]);
    //        //if (objNeedy.IsInfoOnly)
    //        //    objNeedy.IsInfoOnlyYesNo = "Yes";
    //        //else
    //        //    objNeedy.IsInfoOnlyYesNo = "No";

    //        objNeedy.ContactTime = Convert.ToString(row["ContactTime"]);
    //        objNeedy.ServiceRequested = Convert.ToString(row["ServiceRequested"]);
    //        //  get Notes
    //        objNeedy.Notes = Convert.ToString(row["Notes"]);
    //        //get Info request
    //        objNeedy.InfoRequested = Convert.ToString(row["InfoRequested"]);
    //        // get Follow up
    //        objNeedy.FollowUpYesNo = Convert.ToString(row["FollowUp"]);
    //        //Get Followup date
    //        objNeedy.FollowupDate = Convert.ToString(row["Followupdate"]);
    //        // get Service need Met
    //        objNeedy.ServiceNeedsMetYesNo = Convert.ToString(row["ServiceNeedsMet"]);

    //        list.Add(objNeedy);
    //    }
    //    return list.ToArray();

    //}

}