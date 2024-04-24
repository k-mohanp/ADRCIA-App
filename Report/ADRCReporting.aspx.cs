using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ADRCIA;
using System.Data;
using System.Web.Services;
using System.Web.Script.Serialization;
using System.Configuration;
using System.Web.Configuration;
using System.Data.SqlClient;

public partial class Report_ADRCReporting : System.Web.UI.Page
{
    string SiteID = string.Empty;
    public static int TimeOutException = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        if (!Page.IsPostBack)
        {

            BindAgency();
            BindChkList();
            //Conditions for different agencies.
            if (MySession.blnADRCIAOSAAdmin == false)
            {
                Agency.Attributes.Add("style", "display:none;");
            }
        }
    }
    /// <summary>
    /// Created by SA on 4th Feb, 2015.
    /// </summary>
    /// <param name="SiteID"></param>
    /// <returns></returns>
    private static DataTable GetExactUsers(string SiteID = "")
    {
        //Commentes by VK on 29 May 2023. staff listed in the list dependency on the Active Directory(T-18178).
        //DataTable dtUser = LDAPActivDirectory.GetUserInfoListOfOu("ADRCIA");
        //DataView dvUser = dtUser.DefaultView;
        //dvUser.Sort = "UserName asc";
        //DataTable dtAllUser = ADRCIA.ADRCIADAL.GetAllUsersByAgency(SiteID);

        //Added by vk on 31 April, 2019. check user count before Match User.  
        //DataTable FilteredUsers = new DataTable();
        //if (dtAllUser.Rows.Count > 0)
        //{
        //    FilteredUsers = getLinq(dvUser.ToTable(true), dtAllUser);
        //}
        //return new DataTable();

        //Added by VK on 29 May 2023. staff listed in the list item will display omn Needy Persons Call/account(T-18178).
        DataTable dtAllUser = ADRCIA.ADRCIADAL.GetAllUsersByAgency(SiteID);

        return dtAllUser;
        
    }
    /// <summary>
    /// Created by SA on 4th Feb, 2015.
    /// Purpose: Get Users after exact match from two datatables.
    /// </summary>
    /// <param name="dt1"></param>
    /// <param name="dt2"></param>
    /// <returns></returns>
    public static DataTable getLinq(DataTable dt1, DataTable dt2)
    {
        //Commented by vk on 3 April 2019, 
        // dtMerged =
        // (from a in dt2.AsEnumerable()
        // join b in dt1.AsEnumerable()
        // on a["UserName"].ToString() equals b["UserName"].ToString()
        // into g
        // where g.Count() > 0
        // select a).CopyToDataTable();

        //Added by vk on 3 April 2019, marge table if UserName Match int both table.
        DataTable dtMerged = new DataTable();
        var q = (from a in dt2.AsEnumerable()
                 join b in dt1.AsEnumerable() on a["UserName"].ToString() equals b["UserName"].ToString()
                 select a);
        if (q.Count() > 0)
        {
            dtMerged = q.CopyToDataTable();
        }
        return dtMerged;
    }

    /// <summary>
    /// Created by SA
    /// Function to get county on the basis of agency, conditional basis i.e, different agencies wise.
    /// </summary>
    /// <param name="SiteID"></param>
    /// <returns></returns>
    [WebMethod(CacheDuration = 0)]
    public static string GetCounty(string SiteID)
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        string strSiteID = GetSiteByRole(SiteID);

        DataSet ds = ADRCIADAL.GetAgencyWiseDetails(SiteID: strSiteID);
        return GetJson(ds.Tables[0]);

    }    

    /// <summary>
    /// Created by VK
    /// Date: 23 April,2019
    /// Function to Get Agency Wise Township, conditional basis i.e, different agencies wise.
    /// </summary>
    /// <param name="SiteID"></param>
    /// <returns></returns>
    [WebMethod(CacheDuration = 0)]
    public static string GetTownship(string SiteID)
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        string strSiteID = GetSiteByRole(SiteID);

        DataSet ds = ADRCIADAL.GetAgencyWiseTownship(SiteID: strSiteID);
        return GetJson(ds.Tables[0]);

    }

    /// <summary>
    /// Created by VK
    /// Date: 23 April,2019
    /// Function to Get Agency Wise Township, conditional basis i.e, different agencies wise.
    /// </summary>
    /// <param name="SiteID"></param>
    /// <returns></returns>
    [WebMethod(CacheDuration = 0)]
    public static string GetCustomField(string SiteID)
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        string strSiteID = GetSiteByRole(SiteID);

        DataSet ds = ADRCIADAL.GetAgencyWiseCustomField(SiteID: strSiteID);
        return GetJson(ds.Tables[0]);

    }
    /// <summary>
    /// Created by SA
    /// Function to get city on the basis of agency, conditional basis i.e, different agencies wise.
    /// </summary>
    /// <param name="County1"></param>
    /// <param name="SiteID"></param>
    /// <returns></returns>
    [WebMethod(CacheDuration = 0)]
    public static string GetCity(string County1, string SiteID)
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        string strSiteID = GetSiteByRole(SiteID);

        DataSet ds = ADRCIADAL.GetAgencyWiseDetails(County: County1, SiteID: strSiteID);
        if (County1 == "")
        {
            return GetJson(ds.Tables[1]);
        }
        else
        {
            return GetJson(ds.Tables[0]);
        }
    }
    /// <summary>
    /// Created by SA
    /// Function to get services on the basis of agency, conditional basis i.e, different agencies wise.
    /// </summary>
    /// <param name="SiteID"></param>
    /// <returns></returns>
    [WebMethod(CacheDuration = 0)]
    public static string GetService(string SiteID)
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        DataTable dt = null;
        //try
        //{
        string strSiteID = GetSiteByRole(SiteID);

        dt = ADRCIADAL.GetServicesList(strSiteID);

        //}
        //catch (SqlException ex)commented by SA as was implemented to handle exception.
        //{
        //    if (ex.Number == -2)
        //    {
        //        TimeOutException = ex.Number;

        //    }
        //}

        return GetJson(dt);//TimeOutException == -2 ? TimeOutException.ToString() : GetJson(dt);
    }
    /// <summary>
    /// Created by SA
    /// Function to get staff on the basis of agency, conditional basis i.e, different agencies wise.
    /// </summary>
    /// <param name="SiteID"></param>
    /// <returns></returns>
    [WebMethod(CacheDuration = 0)]
    public static string GetStaff(string SiteID)
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        string strSiteID = GetSiteByRole(SiteID);

        DataTable ds = GetExactUsers(strSiteID);//ADRCIADAL.GetAgencyWiseDetails(SiteID: strSiteID);
        return GetJson(ds);
    }

    public static string GetJson(DataTable dt)
    {
        JavaScriptSerializer serializer = new JavaScriptSerializer();

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
    private void BindAgency()
    {
        DataTable dt = ADRCIA.ADRCIADAL.GetAAACILAgency();
        lstAgencyFrom.DataSource = dt;
        lstAgencyFrom.DataValueField = "AAACILSiteID";
        lstAgencyFrom.DataTextField = "AAACILSiteName";
        lstAgencyFrom.DataBind();
        ToolTip(lstAgencyFrom);

        lstReferredByFrom.DataSource = ADRCIADAL.GetADRCAgencyList().Tables[1];//
        lstReferredByFrom.DataValueField = "AAASiteIDAAA";
        lstReferredByFrom.DataTextField = "AAAName1AAA";
        lstReferredByFrom.DataBind();
        ToolTip(lstReferredByFrom);



        // Added on 25-11-2014. SA. SOW-335. Enhancement.
        DataTable ds = ADRCIADAL.GetADRCAgencyList().Tables[2];
        lstRefferedtoFrom.DataSource = ds;
        lstRefferedtoFrom.DataValueField = "AAASiteIDAAA";
        lstRefferedtoFrom.DataTextField = "AAAName1AAA";
        lstRefferedtoFrom.DataBind();
        ToolTip(lstRefferedtoFrom);

    }



    void ToolTip(ListBox TTip)
    {
        foreach (ListItem item in TTip.Items)
        {
            item.Attributes.Add("title", item.Text);
        }
    }
    void BindChkList()
    {
        DataSet dsCommonData = ADRCIA.ADRCIADAL.GetCommonData();

        //Contact Type
        chkContactType.DataSource = dsCommonData.Tables[0];
        chkContactType.DataValueField = "ContactTypeId";
        chkContactType.DataTextField = "ContactTypeName";
        chkContactType.DataBind();


        chkContactType.Items.Add(new ListItem("Unknown", "999"));



        //Contact method
        chkContactMethod.DataSource = dsCommonData.Tables[1];
        chkContactMethod.DataValueField = "ContactMethodID";
        chkContactMethod.DataTextField = "ContactMethodName";
        chkContactMethod.DataBind();

        chkContactMethod.Items.Add(new ListItem("Unknown", "999"));



        //Marital Status
        chkMaritalStatus.DataSource = dsCommonData.Tables[2];
        chkMaritalStatus.DataValueField = "MaritalStatusID";
        chkMaritalStatus.DataTextField = "MaritalStatus";
        chkMaritalStatus.DataBind();

        //chkMaritalStatus.Items.Add(new ListItem("Unknown", "-1"));

        //Race
        chkRace.DataSource = dsCommonData.Tables[3];
        chkRace.DataValueField = "RaceID";
        chkRace.DataTextField = "Race";
        chkRace.DataBind();

       // chkRace.Items.Add(new ListItem("Unknown", "999"));

        //Veteran
        chkVeteranStatus.DataSource = dsCommonData.Tables[4];
        chkVeteranStatus.DataValueField = "VeteranID";
        chkVeteranStatus.DataTextField = "VeteranStatus";
        chkVeteranStatus.DataBind();

        chkVeteranStatus.Items.Add(new ListItem("Unknown", "999"));

        // Living Arrangement
        chkLivingArrangement.DataSource = dsCommonData.Tables[5];
        chkLivingArrangement.DataValueField = "LivingID";
        chkLivingArrangement.DataTextField = "LivingArrangement";
        chkLivingArrangement.DataBind();
        chkLivingArrangement.Items.Add(new ListItem("Unknown", "999"));

        //Added by vk on 03 Aug For bind FundsUtilized.
        DataTable dt = ADRCIADAL.getFundsUtilized(0);
        chklistFundsUtilized.DataSource = dt;
        chklistFundsUtilized.DataValueField = "FundsUtilizedID";
        chklistFundsUtilized.DataTextField = "FundsUtilized";
        chklistFundsUtilized.DataBind();
        chklistFundsUtilized.Items.Add(new ListItem("Unknown", "999"));
        dsCommonData.Dispose();

        //// Added by GK on 12Apr19 : SOW-563
        //DataRow newRow = dsCommonData.Tables[8].NewRow();
        //newRow["TownshipCode"] = "999";
        //newRow["TownshipName"] = "Unknown";
        //dsCommonData.Tables[8].Rows.InsertAt(newRow, 0);
        ////dsCommonData.Tables[8].Rows.Add(newRow);
        //lstTownshipFrom.DataSource = dsCommonData.Tables[8];
        //lstTownshipFrom.DataValueField = "TownshipCode";
        //lstTownshipFrom.DataTextField = "TownshipName";
        //lstTownshipFrom.DataBind();
        //ToolTip(lstTownshipFrom);

        //DataRow newRowCustom = dsCommonData.Tables[9].NewRow();
        //newRowCustom["CustomCode"] = "999";
        //newRowCustom["CustomName"] = "Unknown";
        //dsCommonData.Tables[9].Rows.InsertAt(newRowCustom, 0);
        //lstCustomFieldFrom.DataSource = dsCommonData.Tables[9];
        //lstCustomFieldFrom.DataValueField = "CustomCode";
        //lstCustomFieldFrom.DataTextField = "CustomName";
        //lstCustomFieldFrom.DataBind();
        //ToolTip(lstCustomFieldFrom);
        // Ends

        
        //ddlEthnicity
        chkEthnicity.DataSource = dsCommonData.Tables[10];
        chkEthnicity.DataValueField = "EthnicityID";
        chkEthnicity.DataTextField = "Ethnicity";
        chkEthnicity.DataBind();


    }
    protected void btnClose_Click(object sender, EventArgs e)
    {
        //if (MySession.blnADRCIADataEntry == true)
        //{
        //    Response.Redirect("~/Home.aspx", true);
        //}

        //if (MySession.blnADRCIAAdmin == true || MySession.blnADRCIAOSAAdmin == true)
        //{
        //    Response.Redirect("~/Admin/DashBoard.aspx", true);
        //}

        //if (MySession.blnADRCIAOSAAdmin || MySession.blnADRCIAAdmin) 
        if (MySession.blnADRCIAOSAAdmin)// MySession.blnADRCIAAdmin removed by PC on 13 sep 2022, ADRCIAAdmin has no right to access Dashboard, Reference default.aspx.cs code 
            Response.Redirect("~/Admin/DashBoard.aspx", true);
        else
            Response.Redirect("~/Home.aspx", true);

    }

    [WebMethod(CacheDuration = 0)]
    public static string getLanguages()
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        DataTable dt = ADRCIADAL.getPOLanguages();
        return GetJson(dt);
    }

    /// <summary>
    /// Created by KP on 31st Dec 2019(SOW-577)
    /// Get ContactType info based on Site.
    /// </summary>
    /// <param name="SiteID"></param>
    /// <returns></returns>
    [WebMethod(CacheDuration = 0)]
    public static string GetContactTypeInfo(string SiteID)
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        return DataSetToJSONWithJavaScriptSerializer(ADRCIADAL.GetContactTypeInfo(GetSiteByRole(SiteID)));
    }
    /// <summary>
    /// Created by KP on 31st Dec 2019(SOW-577)
    /// Convert DataSet to serialoze in JSON format.
    /// </summary>
    public static string DataSetToJSONWithJavaScriptSerializer(DataSet dataset)
    {
        JavaScriptSerializer jsSerializer = new JavaScriptSerializer();

        Dictionary<string, object> ssvalue = new Dictionary<string, object>();

        foreach (DataTable table in dataset.Tables)
        {
            List<Dictionary<string, object>> parentRow = new List<Dictionary<string, object>>();
            Dictionary<string, object> childRow;

            string tablename = table.TableName;
            foreach (DataRow row in table.Rows)
            {
                childRow = new Dictionary<string, object>();
                foreach (DataColumn col in table.Columns)
                {
                    childRow.Add(col.ColumnName, row[col]);
                }
                parentRow.Add(childRow);
            }
            ssvalue.Add(tablename, parentRow);
        }

        return jsSerializer.Serialize(ssvalue);
    }
    /// <summary>
    /// Created by KP on 6th Jan 2020(SOW-577)
    /// Get Site ID based on role and selection.
    /// </summary>
    /// <param name="SiteID"></param>
    /// <returns></returns>
    static string GetSiteByRole(string SiteID)
    {
        return MySession.blnADRCIAOSAAdmin == false ? MySession.SiteId.ToString() : SiteID;
    }

    /// <summary>
    /// Created by KP on 25th March 2020(SOW-577)
    /// Function to get other services on the basis of agency, conditional basis i.e, different agencies wise.
    /// </summary>
    /// <param name="SiteID"></param>
    /// <returns></returns>
    [WebMethod(CacheDuration = 0)]
    public static string GetOtherService(string SiteID)
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        DataTable dt = null;
        string strSiteID = GetSiteByRole(SiteID);

        dt = ADRCIADAL.GetOtherServicesList(strSiteID);

        return GetJson(dt);
    }
}