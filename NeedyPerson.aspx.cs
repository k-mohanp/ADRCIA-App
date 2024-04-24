using ADRCIA;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Linq;
using System.Web.Security.AntiXss;
using System.Web.Script.Services;

public partial class NeedyPerson : System.Web.UI.Page
{
    public int numberOfRecords = 0;
    public int TimeSpentID = 0;
    string TSID = string.Empty;
    public string TriggerValues = "\"0\"";
    public string getRefToIDs = "\"-1\"";//Modified By KP on 2nd Apr 2020(TaskID:18464), Replace the '0' value with '-1', due to it make the AASA option select.
    public string ReferredToServiceProvider = "\"0\"";
    public string InsuranceTypes = "\"0\"";
    public string strTimelimit1 = string.Empty;
    public string IsNew = string.Empty;
    public string NeedyID = "0";
    public string CallHistoryID = "0";
    public int FULength = 0;
    public bool IsPrimary = false;
    protected string Key
    {
        get { return ViewState["Key"].ToString(); }
        set { ViewState["Key"] = value; }
    }

    /// <summary>
    /// Added by KP 26th Dec 2019(SOW-577)
    /// Purpose: When ContactType is Caregiver, Professional, Other, Proxy or Family Type, then return true else false.
    /// </summary>
    public bool IsContacTypeForReferringAgency
    {
        get
        {
            return (ddlContactType.SelectedValue == "2" || ddlContactType.SelectedValue == "3" || ddlContactType.SelectedValue == "4"
                || ddlContactType.SelectedValue == "5" || ddlContactType.SelectedValue == "6") ? true : false;
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        //imgStopPostback.Focus();//To stop the deafult postback 
        //Added by vk on 24 April,for Date of Birth of person needing assistance can not be future date.
        calNDoB.EndDate = DateTime.Now;
        //for upload file
        if (!IsPostBack)
        {
            //Added by GK on 07 July 2021. Purpose to Clear All session on "New Needy Person"
            if (Request.QueryString["NdID"] == "0")
                ClearSession();

            this.Key = Guid.NewGuid().ToString();
            Cache[this.Key] = new List<HttpPostedFile>();
            AddDefaultFirstRecordTimeSpent();
            Session["ReferringAgencyDetailID"] = null;
            Session["IsManualCallDuration"] = null;
        }

        if (IsPostBack)
        {
            //added by vk for Clear Session. after tab hide/show need to Clear Session.
            if (Request.QueryString["IsNew"] == "1")
            {
                ClearSession();
            }
            //if (ddlInsuranceTypes.SelectedItem.Text == "Other")
            //    txtInsuranceOther.Attributes.Add("style", "display:inline;");
            //else
            //    txtInsuranceOther.Attributes.Add("style", "display:none;");
            // Commented above code to handle multiple selection as upgraded to below code. SA on 9th March, 2015. TID:2695
            if (InsuranceTypes.Contains("8"))// 8 means 'Other' then to show other textbox.
                txtInsuranceOther.Attributes.Add("style", "display:inline;");
            else
                txtInsuranceOther.Attributes.Add("style", "display:none;");

            if (ddlDisabilityTypes.SelectedItem.Text == "Other")
                txtOtherDisability.Attributes.Add("style", "display:inline;");
            else
                txtOtherDisability.Attributes.Add("style", "display:none;");

            ClientScript.RegisterStartupScript(this.GetType(), "ReBindServReqOnPostBack", "ReBindServReqOnPostBack();", true);

            TriggerValues = HFTriggers.Value != "" ? "\"" + HFTriggers.Value + "\"" : ViewState["TriggerValues"] != null ? ViewState["TriggerValues"].ToString() : "\"0\"";
            getRefToIDs = HFgetRefToIds.Value != "" ? "\"" + HFgetRefToIds.Value + "\"" : ViewState["getRefToIDs"] != null ? ViewState["getRefToIDs"].ToString() : "\"-1\"";//Modified By KP on 2nd Apr 2020(TaskID:18464), Replace the '0' value with '-1', due to it make the AASA option select.
            ReferredToServiceProvider = HFchkReferredtoServiceProvider.Value != "" ? "\"" + HFchkReferredtoServiceProvider.Value + "\"" : ViewState["RefToValues"] != null ? ViewState["RefToValues"].ToString() : "\"0\"";

            InsuranceTypes = HFInsuranceTypes.Value != "" ? "\"" + HFInsuranceTypes.Value + "\"" : ViewState["InsuranceTypes"] != null ? ViewState["InsuranceTypes"].ToString() : "\"0\"";

            if (ddlContactType.SelectedItem.Text.ToUpper() == "SELF")
            {
                divpnlContact.Attributes.Add("style", "display:none");
                divContact.Attributes.Add("style", "display:none");

            }


        }

        Response.Cache.SetCacheability(HttpCacheability.NoCache);


        // call javascript function for Check Person Person
        chkIsPrimaryContactPesron.Attributes.Add("onclick", "javascript:CheckPPerson();");
        //txtAllPrevousNotes.Attributes.Add("style", "word-break:break-all;word-wrap:break-word");
        txtAllPrevousNotes.Attributes.Add("style", "word-wrap:break-word");
        ddlContactPerson.Attributes.Add("onclick", "BindRelationshipLabel(this);");
        //Call Javascript method on  item changed      
        ddlContactType.Attributes.Add("onChange", "ShowHideContactDetails(this);");

        ddlContactMethod.Attributes.Add("onclick", "ShowHideOther()");
        //chkIsPrimaryContactPesron.Attributes.Add("onclick", "Javascript:MyClientFunction();");


        showHideDivCP.Attributes.Add("class", "");
        divPopUpContentCP.Attributes.Add("class", "");
        divpnlContactCP.Attributes.Add("style", "display:none");

        //showHideDivProvider.Attributes.Add("class", "");
        //divPopUpContentProvider.Attributes.Add("class", "");
        //divpnlContactProvider.Attributes.Add("style", "display:none");

        divContactInfoParent.Attributes.Add("class", "");
        divPopUpContactInfo.Attributes.Add("class", "");
        divpnContactInfo.Attributes.Add("style", "display:none");


        TextBox txtcmbNCity = (TextBox)cmbNCity.FindControl("cmbNCity_TextBox");
        if (txtcmbNCity != null)
            txtcmbNCity.Attributes.Add("onBlur", "javascript:SetFlageForCityCounty('NdCity');");
        TextBox txtcmbNCounty = (TextBox)cmbNCounty.FindControl("cmbNCounty_TextBox");
        if (txtcmbNCounty != null)
            txtcmbNCounty.Attributes.Add("onBlur", "javascript:SetFlageForCityCounty('NdCounty');");
        TextBox txtcmbCCity = (TextBox)cmbCCity.FindControl("cmbCCity_TextBox");
        if (txtcmbCCity != null)
            txtcmbCCity.Attributes.Add("onBlur", "javascript:SetFlageForCityCounty('CPCity');");
        TextBox txtcmbCCounty = (TextBox)cmbCCounty.FindControl("cmbCCounty_TextBox");
        if (txtcmbCCounty != null)
            txtcmbCCounty.Attributes.Add("onBlur", "javascript:SetFlageForCityCounty('CPCounty');");

        //set Min and Max date range to DOB and date of Contact Validatior
        rngeDOBValidator.MinimumValue = "01/01/1900";
        rngeDOBValidator.MaximumValue = DateTime.Today.ToString("MM/dd/yyyy");
        rngeDoC.MinimumValue = "01/01/1900";
        rngeDoC.MaximumValue = DateTime.Today.ToString("MM/dd/yyyy");

        // Added by SM ; Date: 31Jan2014
        //if (Request.QueryString["siteId"] != null)// Commented by SA on 16-1-2015. SOW-335 As Referred to agency has been changed to multiselection, so for the same impact only.

        //    Session["CurrentSiteId"] = Request.QueryString["siteId"];
        //else
        //    Session["CurrentSiteId"] = MySession.SiteId;

        if (Request.QueryString["Saved"] == null)//Added by vk on 31 April,2019 for Set  Session["CurrentSiteId"] When QueryString Save is Null.
        {
            if (Request.QueryString["siteId"] == null || Request.QueryString["siteId"].ToString() == "0")
                Session["CurrentSiteId"] = MySession.SiteId;
            else // Added by GK on 25July18 : Set CurrentSiteId(session) from QueryString 'siteId' on behalf logged in user.
            {
                Session["CurrentSiteId"] = Convert.ToInt32(Request.QueryString["siteId"]);
            }
        }
        //checked for if followup selected from dash board
        if (Request.QueryString["FLWP"] != null)
        {
            hdnFlwpSelected.Value = "1";
            NeedyPersonTab.ActiveTabIndex = 4;
            CallHistoryID = Request.QueryString["CLID"];

        }
        // UC : Query String used for Update Cal
        Session["IsCallUpdate"] = 0;// set default value 0: as new call 
        if (Request.QueryString["UC"] != null)
        {
            if (Request.QueryString["UC"].ToString() == "1")
            {
                CallHistoryID = Request.QueryString["CLID"];
                hdnUpdateCall.Value = "1";
                Session["IsCallUpdate"] = 1;//used for pass as parametervalue in setCallHistory

            }
        }
        // Check  That user come  to this page by using 'Add new  Needy' link or from Search (or from followup) screen
        if (Request.QueryString["IsNew"] == "0")
        {
            IsNew = "0";
            btnPrintPage.Enabled = true;
        }
        else
        {
            IsNew = "1";
            btnPrintPage.Enabled = false;
        }
        if (!IsPostBack)
        {
            hdnExistsContactPID.Value = "-1";

            txtCDoC.Text = DateTime.Now.ToShortDateString();
            //Added by vk on 03 Aug,2017. Set default FundsUtilizedDate
            hdnFundsUtilizedDate.Value = "";// DateTime.Now.ToShortDateString(); Remove Default Date By BS on 9-May-2018 Task ID-10462
            BindDropDown();

            //BindInsuranceTypes();
            if (IsNew == "0")
            {
                NeedyID = Convert.ToString(Request.QueryString["NdID"]);

                BindDocuments(Convert.ToInt32(Request.QueryString["NdID"]));
                BindTimeSpent(Convert.ToInt32(Request.QueryString["NdID"]));

                lblPersonIdValue.Text = NeedyID;    
                //pnlContact.Visible = false;
                divpnlContact.Attributes.Add("style", "display:none");

                pnlContactPersonGrid.Attributes.Add("style", "display:block");
                hyprAddContact.Attributes.Add("style", "display:block");
                if (Request.QueryString["CPID"] != null)
                {
                    if (Request.QueryString["Saved"] != null || (hdnFlwpSelected.Value == "1" || hdnUpdateCall.Value == "1"))
                    {
                        if (Session["ContactPersonID"] == null)// Added.
                        {
                            if (Convert.ToInt32(Request.QueryString["CPID"]) > 0)
                                Session["ContactPersonID"] = Request.QueryString["CPID"].ToString();
                            else
                                Session["ContactPersonID"] = null;
                        }
                    }
                }
                // Get contact person Details
                BindContacPersontDetailsGird();
                // Get Needy Person Details
                //BindInsuranceTypes();
                FillNeedyPersonDetails();
            }
            else
            {
                lblContactPerson.Visible = false;
                ddlContactPerson.Visible = false;
                //reqPerson.Visible = false;

                divpnlContact.Attributes.Add("style", "display:block");
                pnlContactPersonGrid.Attributes.Add("style", "display:none");
                hyprAddContact.Attributes.Add("style", "display:none");
                GetPersonAndContactId();

                //Set City and County default value '--Select--'
                cmbCCity.ClearSelection();
                cmbCCity.Items.FindByText("--Select--").Selected = true;
                cmbCCounty.ClearSelection();
                cmbCCounty.Items.FindByText("--Select--").Selected = true;
                cmbNCity.ClearSelection();
                cmbNCity.Items.FindByText("--Select--").Selected = true;
                cmbNCounty.ClearSelection();
                cmbNCounty.Items.FindByText("--Select--").Selected = true;

                // Added by GK on 10Apr19 : SOW-563
                ddlTownship.ClearSelection();
                ddlTownship.Items.FindByText("--Select--").Selected = true;

                //Hide  other textbox of Contact Type and Conatct method. 
                txtOtherContactType.Attributes.Add("style", "display:none");
                lblOtherContacType.Attributes.Add("style", "display:none");
                lblOtherContactMethod.Attributes.Add("style", "display:none");
                txtOtherContactMethod.Attributes.Add("style", "display:none");
                inputSearchSpan.Attributes.Add("style", "display:none");

                if (ddlContactType.SelectedItem.Text.ToUpper() != "SELF")
                    lblRelationLabel.Attributes.Add("style", "display:none;");

                //Added By KP on 31st Jan 2020(SOW-577)
                cmbTitle.ClearSelection();
                //cmbTitle.Items.FindByText("Title").Selected = true;

            }
            if (Request.QueryString["Saved"] != null)
            {
                if (Session["NeedySaved"] != null)//Added by KP on 5th Dec 2019(SOW-577), validate
                {
                    hdnTimerLimit.Value = Convert.ToString(Session["TimerLimit"]);
                    var Message = "Person needing assistance saved successfully.";

                    if (Session["NeedySaved"].ToString() == "2")//Added by KP on 5th Dec 2019(SOW-577), 2 is for new record saved.
                        Message += string.Format("<br/><br/> <span style=font-size:16px;line-height:20px;>Person ID: <b>{0}</b><br/> First Name: <b>{1}</b><br/>  Last Name: <b>{2}</b> </span>", lblPersonIdValue.Text, txtNFName.Text, txtNLName.Text);

                    if (Session["Message"] != null && Session["Message"].ToString() != "")
                        Message += @"<br/><br/>" + Session["Message"].ToString().Trim().Replace('\r', ' ').Replace('\n', ' ').Replace('\t', ' ') + "";

                    System.Web.UI.ScriptManager.RegisterStartupScript(this, this.GetType(), "saved", " ShowAlert('" + Message + "','S');", true); //Added By BS on 6-Feb-2018 Task ID-10142
                    Session["NeedySaved"] = null;//reset as null after message is displayed.
                }
                Session["TimerLimit"] = null;
            }
            else
            {
                if (!(hdnUpdateCall.Value == "1" || hdnFlwpSelected.Value == "1"))
                {
                    txtNotes.Text = string.Empty;
                    txtInfoReq.Text = string.Empty;
                }
                //if follow-up selected than all value visible 
                //if (hdnFlwpSelected.Value != "1"  )
                //{

                //    txtNotes.Text = string.Empty;
                //    txtInfoReq.Text = string.Empty;
                //}
            }

            BindReferringAgencyDetails();//Call to bind ReferringAgency grid after FillNeedyPersonDetails();  
        }
        else//Page Postback = true
        {
            hdnTimerLimit.Value = Microsoft.Security.Application.Sanitizer.GetSafeHtmlFragment(SetTimerSession(false));      //Modified by RK,01April2024,Task-ID: 24527,Purpose: Sanitization of data
        }
        rwContactSave.Attributes.Add("style", "display:none");
        //Hide call history list
        showHideDiv2.Attributes.Add("class", "");
        divPopUpContent2.Attributes.Add("class", "");
        divpnlContact2.Attributes.Add("style", "display:none");

        SetAttributesToControl(this.Page);
        // if  followp call then  make some  control read only
        if (hdnFlwpSelected.Value == "1" && Request.QueryString["UC"] == null)
        {


            ddlRefBy.Enabled = false;
            //ddlRefTo.Enabled = false;
            // ddlRefToServiceProvider.Enabled = false;
            txtRefByOther.Enabled = false;
            txtRefToOther.Enabled = false;
            txtReferredToServiceProvider.Enabled = false; //Added By Kuldeep rathore on 05/02/2015

        }
        // Mobile Download prevention
        if (MySession.blnIsMobileAgent)
            btnPrintPage.Enabled = false;
        else
            btnPrintPage.Enabled = true;

        if (chkFundProvided.Checked)//Added By:BS on 6-Feb-2017 Task ID-10142
        {
            txtFundProvided.Enabled = true;
            txtFundsUtilizedDate.Enabled = true;
        }
        else
        {
            txtFundProvided.Enabled = false;
            txtFundsUtilizedDate.Enabled = false;
        }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        RegisterPostBackControl();
    }

    //Added by KP on 5th Sep 2023(T20745), Registering the ImageButton/Button (Edit/Delete) as PostBack Trigger inside GridView within AJAX UpdatePanel
    void RegisterPostBackControl()
    {
        foreach (GridViewRow row in grdContactDetails.Rows)
        {
            ImageButton imgbtnEdit1 = row.FindControl("imgbtnEdit1") as ImageButton;
            ImageButton imgbtnDelete = row.FindControl("imgbtnDelete") as ImageButton;

            if (imgbtnEdit1 != null)
                ScriptManager.GetCurrent(this).RegisterPostBackControl(imgbtnEdit1);
            if (imgbtnDelete != null)
                ScriptManager.GetCurrent(this).RegisterPostBackControl(imgbtnDelete);
        }
        foreach (GridViewRow row in gvDocuments.Rows)
        {
            ImageButton lnkDelete = row.FindControl("lnkDelete") as ImageButton;
            if (lnkDelete != null)
                ScriptManager.GetCurrent(this).RegisterPostBackControl(lnkDelete);
        }

        foreach (GridViewRow row in grdRefrringAgency.Rows)
        {
            ImageButton imgbtnEdit = row.FindControl("imgbtnEdit") as ImageButton;
            ImageButton imgbtnDelete = row.FindControl("imgbtnDelete") as ImageButton;
            ImageButton imgbtnUpdate = row.FindControl("imgbtnUpdate") as ImageButton;
            ImageButton imgbtnCancel = row.FindControl("imgbtnCancel") as ImageButton;            
                
            if (imgbtnEdit != null)
                ScriptManager.GetCurrent(this).RegisterPostBackControl(imgbtnEdit);
            if (imgbtnDelete != null)
                ScriptManager.GetCurrent(this).RegisterPostBackControl(imgbtnDelete);
            if (imgbtnUpdate != null)
                ScriptManager.GetCurrent(this).RegisterPostBackControl(imgbtnUpdate);
            if (imgbtnCancel != null)
                ScriptManager.GetCurrent(this).RegisterPostBackControl(imgbtnCancel);
        }
    }

    //Added by KP on 5th Sep 2023(T20745), Assign NeedyID from querystring, whenever page is fully postback.
    void AssignNeedyID()
    {
        if (Request.QueryString["NdID"] != null && Request.QueryString["NdID"] != "0")
        {
            NeedyID = Convert.ToString(Request.QueryString["NdID"]);
        }
    }
    /// <summary>
    /// Created By: vk
    ///  Date: 08/10/2018
    ///  Purpsoe: for Clear Session.
    /// </summary>
    void ClearSession()
    {
        Session["ContactPersonID"] = null;
        Session["CurrentHistoryID"] = null;
        Session["CurrentFollowupID"] = null;
        Session["TimerLimit"] = null;
        Session["PrintNeedyId"] = null;// for print needy page
        Session["PrintCallHistoryId"] = null;// for print needy page
        Session["CurrentSiteId"] = null;
    }
    /// <summary>
    /// Created By: SM
    ///  Date: 03/09/2013
    ///  Purpsoe: Get Person needing assistance details
    /// </summary>
    void FillNeedyPersonDetails()
    {
        try
        {
            int CallHistoryID = 0;
            if (Request.QueryString["CLID"] != null)
            {
                CallHistoryID = Convert.ToInt32(Request.QueryString["CLID"]);
                Session["PrintCallHistoryId"] = CallHistoryID;
            }
            else if (HttpContext.Current.Session["CurrentHistoryID"] != null)//Added by KP on 24 OCT 2017, To set Session["PrintCallHistoryId"] for Print uses after a new call save
            {
                CallHistoryID = Convert.ToInt32(HttpContext.Current.Session["CurrentHistoryID"]);
                Session["PrintCallHistoryId"] = HttpContext.Current.Session["CurrentHistoryID"];
            }
            else
                Session["PrintCallHistoryId"] = 0;

            Session["PrintNeedyId"] = Convert.ToInt32(Request.QueryString["NdID"]);// added on 24 june 2014 , Purpose:  set needy id value in session for print

            PersonNeedAssistance objNeedy = ADRCIA.ADRCIABAL.GetNeedyDetails(Convert.ToInt32(Request.QueryString["NdID"]), CallHistoryID);

            lblLastCallValue.Text = objNeedy.ContactDate + " " + objNeedy.ContactTime;
            lblLastCallBy.Text = objNeedy.LastCallBy;//  Added By: SM , Date: 03 June 2014 , Purpose: Set last call user name 
            // person Needing assistance part       
            txtNFName.Text = objNeedy.FirstName;
            txtNMi.Text = objNeedy.MI;
            txtNLName.Text = objNeedy.LastName;

            //Added By KP on 31st Jan 2020(SOW-577), Make as selected item of combobox Title.
            try
            {

                cmbTitle.ClearSelection();
                if (!string.IsNullOrWhiteSpace(objNeedy.Title))
                {
                    cmbTitle.Items.Cast<ListItem>()
                            .FirstOrDefault(i => i.Text.Equals(objNeedy.Title, StringComparison.InvariantCultureIgnoreCase)).Selected = true;
                }
                //else
                //    cmbTitle.Items.FindByText("Title").Selected = true;
            }
            catch
            {
                cmbTitle.Items.Insert(cmbTitle.Items.Count, objNeedy.Title);
                cmbTitle.Items.FindByText(objNeedy.Title).Selected = true;
            }
            //(SOW-577)

            //Added by SA on 4-11-2014. SOW-335
            if (objNeedy.IsDisability == "1")
                chkDisabilityYes.Checked = true;
            else if (objNeedy.IsDisability == "2")
                chkDisabilityUnknown.Checked = true;
            else if (objNeedy.IsDisability == "0")
                chkDisabilityNo.Checked = true;
            else
            { chkDisabilityNo.Checked = false; chkDisabilityYes.Checked = false; chkDisabilityUnknown.Checked = false; }

            if (objNeedy.PhonePrimary != null)
                txtNPhonePrime.Text = objNeedy.PhonePrimary.ToString();

            if (objNeedy.PhonePrimaryExtn != null)//Added by BS on 15-sep-2016
                txtNPhonePrimeExtn.Text = objNeedy.PhonePrimaryExtn;

            if (objNeedy.PhoneAlt != null)
                txtNPhonAlt.Text = objNeedy.PhoneAlt.ToString();


            if (objNeedy.PhoneAltExtn != null)//Added by BS on 15-sep-2016
                txtNPhoneAltExtn.Text = objNeedy.PhoneAltExtn;

            if (objNeedy.NPrimaryFax != null)//Added by BS on 19-dec-2016
                txtNPriFax.Text = objNeedy.NPrimaryFax;

            if (objNeedy.NAltFax != null)//Added by BS on 19-dec-2016
                txtNAltFax.Text = objNeedy.NAltFax;

            txtNEmail.Text = objNeedy.Email.ToString();
            txtNAddress.Text = objNeedy.Address.ToString();

            txtNDOB.Text = Convert.ToString(objNeedy.DOB);
            txtNAge.Text = Convert.ToString(objNeedy.Age);
            //Added by Vk on 24 April,2019.for Hold Saved Age.
            if (!string.IsNullOrEmpty(objNeedy.DOB))
            {
                txtNAge.Enabled = false;
                txtNDOB.Enabled = true;
                hdnIsAgeOn.Value = "0";
            }
            else if (!string.IsNullOrEmpty(Convert.ToString(objNeedy.AgeOn)))
            {
                txtNDOB.Enabled = false;
                txtNAge.Enabled = true;
                hdnIsAgeOn.Value = "1";
            }
            hdnAge.Value = Convert.ToString(objNeedy.Age);
            hdnAgeOn.Value = Convert.ToString(objNeedy.AgeOn);
            // Added by PA 3-April-2014
            //Purpose: Add 3)	Alternate Contact Info (under Person Needing Assistance tab)
            txtAltFName.Text = objNeedy.AltFirstName;
            txtAltMName.Text = objNeedy.AltMI;
            txtAltLName.Text = objNeedy.AltLastName;
            txtAltEmailID.Text = objNeedy.AltEmail;
            txtAltRelationShip.Text = objNeedy.AltRelationship;
            if (objNeedy.AltPhone != null)
                txtAltPhone.Text = objNeedy.AltPhone.ToString();

            if (objNeedy.AltPhoneExtn != null)//Added by BS on 15-sep-2016
                txtAltPhoneExtn.Text = objNeedy.AltPhoneExtn;
            //End

            try
            {
                if (objNeedy.PrimaryLanguage != null)
                {
                    if (Convert.ToString(objNeedy.PrimaryLanguage).Trim() != "")
                    {
                        cmbPrimaryLaguage.ClearSelection();
                        //cmbPrimaryLaguage.Items.Insert(cmbPrimaryLaguage.Items.Count, objNeedy.PrimaryLanguage);Commented on 3/30/2015. SA.
                        cmbPrimaryLaguage.Items.FindByText(objNeedy.PrimaryLanguage).Selected = true;
                    }
                }
            }

            catch
            {
                cmbPrimaryLaguage.Items.Insert(cmbPrimaryLaguage.Items.Count, objNeedy.PrimaryLanguage);
                cmbPrimaryLaguage.Items.FindByText(objNeedy.PrimaryLanguage).Selected = true;
            }

            txtNZip.Text = objNeedy.Zip;
            chkNPhone.Checked = objNeedy.ContactPreferencePhone;
            chkNEmail.Checked = objNeedy.ContactPreferenceEmail;
            chkNSMS.Checked = objNeedy.ContactPreferenceSMS;
            chkNMail.Checked = objNeedy.ContactPreferenceMail;

            // chkNOther.Checked = objNeedy.IsPreferredContactNOther;


            try
            {
                cmbNCounty.ClearSelection();
                if (objNeedy.CountyName.ToString().Trim() != "")
                    cmbNCounty.Items.FindByText(objNeedy.CountyName.ToString()).Selected = true;
                else
                    cmbNCounty.Items.FindByText("--Select--").Selected = true;
            }
            catch
            {
                cmbNCounty.Items.Insert(cmbNCounty.Items.Count, objNeedy.CountyName.ToString());
                cmbNCounty.Items.FindByText(objNeedy.CountyName.ToString()).Selected = true;
            }

            // Added by GK on 10Apr19 : SOW-563
            ddlTownship.ClearSelection();
            if (!string.IsNullOrEmpty(objNeedy.TownshipCode)) ddlTownship.Items.FindByValue(objNeedy.TownshipCode.ToString()).Selected = true;
            else ddlTownship.Items.FindByValue("-1").Selected = true;

            //Modified by KP on 2nd Apr 2020(TaskID:18464),
            //Handle the exception, whenever AASA refer a needy to other aganecy, as we know custom work based on agency.
            try
            {
                ddlCustomField.ClearSelection();
                if (objNeedy.CustomCode != null)
                    ddlCustomField.Items.FindByValue(objNeedy.CustomCode.ToString()).Selected = true;
                else ddlCustomField.Items.FindByValue("-1").Selected = true;
            }
            catch { }
            // Ends

            cmbNCity.ClearSelection();
            try
            {
                if (objNeedy.CityName.ToString().Trim() != "")
                    cmbNCity.Items.FindByText(objNeedy.CityName.ToString()).Selected = true;
                else
                    cmbNCity.Items.FindByText("--Select--").Selected = true;
            }
            catch
            {
                cmbNCity.Items.Insert(cmbNCounty.Items.Count, objNeedy.CityName.ToString());
                cmbNCity.Items.FindByText(objNeedy.CityName.ToString()).Selected = true;

            }
            txtNState.Text = objNeedy.State;
            ddlMaritalStatus.ClearSelection();
            ddlMaritalStatus.Items.FindByValue(objNeedy.MarriageStatusID.ToString()).Selected = true;
            ddlGender.ClearSelection();
            ddlGender.Items.FindByValue(objNeedy.Gender).Selected = true;
            ChkNoDemographics.Checked = !objNeedy.IsDemographics; //Added by KP on 28-Sep-2017 - SOW-485              
            ddlRace.ClearSelection();
            ddlRace.Items.FindByValue(objNeedy.RaceID.ToString()).Selected = true;
            ddlEthnicity.ClearSelection();
            ddlEthnicity.Items.FindByValue(objNeedy.EthnicityID.ToString()).Selected = true;
            ddlVetStatus.ClearSelection();
            ddlVetStatus.Items.FindByValue(objNeedy.VeteranStatusID.ToString()).Selected = true;
            ddlLivingArrangement.ClearSelection();
            ddlLivingArrangement.Items.FindByValue(objNeedy.LivingID.ToString()).Selected = true;
            try
            {
                ddlVetApplicable.ClearSelection();
                if (string.IsNullOrEmpty(objNeedy.VeteranApplicable))
                    ddlVetApplicable.Items.FindByText("--Select--").Selected = true;
                else
                    ddlVetApplicable.Items.FindByText(objNeedy.VeteranApplicable).Selected = true;
            }
            catch
            {

            }

            //Added by SA on 3-11-2014. SOW-335
            txtOtherDisability.Text = objNeedy.DisabilityTypesOther;
            if (objNeedy.DisabilityTypes != null && chkDisabilityYes.Checked)
            {

                ddlDisabilityTypes.SelectedValue = Convert.ToString(objNeedy.DisabilityTypes);
                //trDisabilityTypes.Attributes.Add("style", "visibility:visible");

                if (ddlDisabilityTypes.SelectedItem.Text == "Other")
                    txtOtherDisability.Attributes.Add("style", "display:inline;");

            }
            else
            {
                ddlDisabilityTypes.Enabled = false;
                ddlDisabilityTypes.Items.FindByText("--Select--").Selected = true;
            }





            txtNotes.Text = objNeedy.Notes != null ? objNeedy.Notes : string.Empty;
            //txtAllPrevousNotes.Text = objNeedy.AllPreviousNotes != null ? objNeedy.AllPreviousNotes.Replace("<br/>", Environment.NewLine) : string.Empty;
            //txtAllPrevousNotes.ReadOnly = true;
            //Modify by vk on 9 Aug,2020.#19477(Call Notes Update).
            string AllPreviousNotes = "";
            string[] delim = { "<br/>" };
            string[] Notes = objNeedy.AllPreviousNotes.Split(delim, StringSplitOptions.None);

            for (int i = 0; i < Notes.Length; i++)
            {

                if (Notes[i].Length > 0)
                {
                    string encodedNote = HttpUtility.HtmlEncode(Notes[i].Replace("\n", "<br/>")); //Added by AR, 12-April-2024 | T#24525 | To Encode the Html element so that it is seen in the textbox
                    if (AllPreviousNotes.Length == 0)
                        AllPreviousNotes = AllPreviousNotes + "<span style = color:green;>" + encodedNote + "</span><br/><br/>"; //Modified by AR, 12-April-2024
                    else
                        AllPreviousNotes = AllPreviousNotes + encodedNote + "<br/><br/>"; //Modified by AR, 12-April-2024
                }
            }
            txtAllPrevousNotes.Text = AllPreviousNotes;

            txtInfoReq.Text = objNeedy.InfoRequested;
            txtOtherNotes.Text = objNeedy.OtherNotes;// quick notes values
            imgToDo.Src = "~/images/ToDoFlag_White.png";

            // Search page conditions for other textbox visibility.
            //if (Request.QueryString["UC"] != null && Request.QueryString["UC"] == "0")
            //{
            //    if (objNeedy.DisabilityTypes != null)
            //        if (objNeedy.DisabilityTypes == 10)
            //            txtOtherDisability.Attributes.Add("style", "display:inline;");

            //    if (objNeedy.InsuranceTypes != null)
            //        if (objNeedy.InsuranceTypes == 8)
            //            txtInsuranceOther.Attributes.Add("style", "display:inline;");

            //}

            //Added by KP on 31st March 2020(TaskID:18464), Always make the selection of Ref. by Agency 
            if (objNeedy.ReferredByAgencyID != null)
            {
                if (objNeedy.ReferredByAgencyID != -1)
                {
                    ddlRefBy.ClearSelection();
                    try { ddlRefBy.Items.FindByValue(objNeedy.ReferredByAgencyID.ToString()).Selected = true; }
                    catch { }
                }
            }


            //On new call entry screen, Service Available/Requested tab, Referred By, Referred To, Referred To Service Provider ddws should be always show "Select" option by default else
            //for followup level call or after save button clicked (not Save & Close) current saved value would be displayed.
            //here check  that this page call  throgh followup or page is post back after clicked on save button (not Save& Close button)

            // ================== Start  Call level Setting i.e  when come from followup or update call or after saved ======================================================

            if (Request.QueryString["Saved"] != null || (hdnFlwpSelected.Value == "1" || hdnUpdateCall.Value == "1"))
            {

                chkInfoOnly.Checked = objNeedy.IsInfoOnly;
                chkADRC.Checked = objNeedy.IsADRC;


                HttpContext.Current.Session["CurrentFollowupID"] = (objNeedy.FollowupHistoryID == 0) ? null : objNeedy.FollowupHistoryID;
                if (objNeedy.IsToDo)
                    imgToDo.Src = "~/images/ToDoFlag_Red.png";
                else
                    imgToDo.Src = "~/images/ToDoFlag_White.png";
                // Edited by Naivn on 06 December 2013 Start
                // Call level information binding
                // Person needing assistance contact Part 

                txtCDoC.Text = objNeedy.ContactDate;
                if (objNeedy.ContactMethodID != null)
                    ddlContactMethod.Items.FindByValue(objNeedy.ContactMethodID.ToString()).Selected = true;

                if (objNeedy.ContactTypeID != null)
                {

                    ddlContactType.Items.FindByValue(objNeedy.ContactTypeID.ToString()).Selected = true;
                    if (ddlContactType.SelectedItem.Text.ToUpper() == "SELF")
                    {
                        lblContactPerson.Attributes.Add("style", "display:none");
                        ddlContactPerson.Attributes.Add("style", "display:none");
                        //  reqPerson.Enabled = false;
                        lblRelationship.Text = "Self";
                    }
                    else if (ddlContactPerson.Items.Count > 1)
                    {
                        //MP(as per logic if data comes from follow-up ,data should be populated else not populated)
                        if (hdnFlwpSelected.Value == "1")
                        {
                            lblContactPerson.Attributes.Add("style", "display:inline");
                            ddlContactPerson.Attributes.Add("style", "display:inline");

                        }
                        // reqPerson.Enabled = true;
                    }

                    if (objNeedy.ContactTypeID == 1)
                        hyprAddContact.Attributes.Add("style", "display:none");
                    else
                        hyprAddContact.Attributes.Add("style", "display:block");

                }
                // Added SA 27th Jan, 2015
                //if (ddlContactType.SelectedItem.Text.ToUpper() != "SELF")
                //    divpnlContact.Attributes.Add("style", "display:block");





                txtOtherContactType.Text = !string.IsNullOrEmpty(objNeedy.RefContactInfo) ? objNeedy.RefContactInfo : objNeedy.ContactTypeOther;
                //HidContactInfo.Value = objNeedy.ContactTypeOther;
                txtOtherContactMethod.Text = HttpUtility.HtmlDecode(objNeedy.ContactMethodOther); //Modified by AR, 07-April-2024 |T#24525 | Desanitization of Data to show on UI
                hdnCMethodOther.Value = HttpUtility.HtmlDecode(objNeedy.ContactMethodOther);      //Modified by AR, 07-April-2024 |T#24525 | Desanitization of Data

                //Added by KP on 18th Dec 2019(SOW-577), Set values the Referring Agency details textbox and hidden control.
                Session["ReferringAgencyDetailID"] = objNeedy.RefAgencyDetailID;
                txtRefAgencyName.Text = objNeedy.RefAgencyName;
                txtRefContactName.Text = objNeedy.RefContactName;
                txtRefPhoneNumber.Text = objNeedy.RefPhoneNumber;
                txtRefEmailID.Text = objNeedy.RefEmail;

                Session["IsManualCallDuration"] = objNeedy.IsManualCallDuration;//Added by KP on 28th Feb 2020
                //End (SOW-577)

                //chkInfoOnly.Checked = objNeedy.IsInfoOnly;
                //chkADRC.Checked = objNeedy.IsADRC;

                // Edited by Naivn on 06 December 2013 End

                // Requested Services part
                DataTable dtReqestedSrv = ADRCIADAL.GetRequestedServiceList(Convert.ToInt32(Request.QueryString["NdID"]), CallHistoryID);
                if (dtReqestedSrv.Rows.Count > 0)
                {
                    lstServicesRequested.DataSource = dtReqestedSrv;
                    lstServicesRequested.DataValueField = "ServiceID";
                    lstServicesRequested.DataTextField = "ServiceName";
                    lstServicesRequested.DataBind();

                    ////============ Bind requested Service ===========================
                    string strReqServID = string.Empty;
                    foreach (DataRow rw in dtReqestedSrv.Rows)
                    {
                        if (strReqServID.Length == 0)
                            strReqServID = rw["ServiceID"].ToString();
                        else
                            strReqServID = strReqServID + "," + rw["ServiceID"].ToString();
                    }
                    hdnServReq.Value = Microsoft.Security.Application.Sanitizer.GetSafeHtmlFragment(strReqServID);

                }
                ddlServiceNeedMet.ClearSelection();
                if (objNeedy.ServiceNeedsMet != null)
                    ddlServiceNeedMet.Items.FindByValue(objNeedy.ServiceNeedsMet.ToString()).Selected = true;
                else
                    ddlServiceNeedMet.SelectedValue = "-1";

                chkServicesAlreadyinPlace.Checked = objNeedy.IsServicesAlreadyinPlace;
                txtAlreadyServiceNotes.Text = objNeedy.ServicesAlreadyinPlaceNotes;
                // Reffered To By AAA

                //commented by KP on 31st March 2020(TaskID:18464)
                //if (objNeedy.ReferredByAgencyID != null)
                //{
                //    if (objNeedy.ReferredByAgencyID != -1)
                //    {
                //        ddlRefBy.ClearSelection();
                //        try { ddlRefBy.Items.FindByValue(objNeedy.ReferredByAgencyID.ToString()).Selected = true; }
                //        catch { }
                //    }
                //}

                // Reffered To Agency
                if (objNeedy.getRefToADRCIDs != null)
                {
                    getRefToIDs = "\"" + objNeedy.getRefToADRCIDs + "\"";
                    ViewState["getRefToIDs"] = getRefToIDs;
                }

                // Reffered to Service Providers
                if (objNeedy.ReferredToServiceProvider != null)
                {
                    ReferredToServiceProvider = "\"" + objNeedy.ReferredToServiceProvider + "\"";
                    ViewState["RefToValues"] = ReferredToServiceProvider;
                }
                // Permission Granted
                if (objNeedy.IsPermissionGranted != null)
                {
                    if (objNeedy.IsPermissionGranted == true)
                        chkPermissionGranted.Items[0].Selected = true;
                    else
                        chkPermissionGranted.Items[1].Selected = true;
                }
                // Added by SA on 21st Aug, 2015. SOW-379
                chkreferredforoc.Checked = objNeedy.ReferredForOC;
                if (objNeedy.ReferredForOC)
                {
                    referredforocdate.Attributes.Add("style", "display:inline;");
                    txtreferredforocdate.Text = objNeedy.ReferredForOCDate;
                }


                ddlFollowUp.ClearSelection();
                if (objNeedy.FollowUp != null)
                    ddlFollowUp.Items.FindByValue(objNeedy.FollowUp.ToString()).Selected = true;
                else
                    ddlFollowUp.SelectedValue = "-1";
                // Added by SA on 10-11-2014. SOW-335.
                ddlOCFollowUp.ClearSelection();
                if (objNeedy.OCFollowUp != null)
                    ddlOCFollowUp.Items.FindByValue(objNeedy.OCFollowUp.ToString()).Selected = true;
                else
                    ddlOCFollowUp.SelectedValue = "-1";
                if (objNeedy.OCFollowupDate != null)
                    txtOCfollowupdate.Text = objNeedy.OCFollowupDate.ToString();
                if (objNeedy.OCFollowupNotes != null)
                    txtOCFollowupnotes.Text = objNeedy.OCFollowupNotes;

                //Addition ends here.

                if (objNeedy.FollowupDate != null)
                    txtFollowupDate.Text = objNeedy.FollowupDate.ToString();
                if (objNeedy.FollowupCompleted != null)
                    chkFollowupCompleted.Checked = objNeedy.FollowupCompleted;//Added By SM, Date:04 April 2014
                if (objNeedy.FollowupNotes != null)
                    txtFollowUpNotes.Text = objNeedy.FollowupNotes;//Added By SM, Date:04 April 2014

                txtRefByOther.Text = objNeedy.ReferredByOtherAgency;
                txtRefToOther.Text = objNeedy.ReferredToOtherAgency;
                txtReferredToServiceProvider.Text = objNeedy.ReferredToOtherServiceProvider;
                chkFundProvided.Checked = objNeedy.IsFundsProvided;//Added By KR on 27 March 2017.   
                txtFundProvided.Text = objNeedy.FundsProvidedAmount.ToString();//Added By KR on 27 March 2017
                //Added By VK on 04 Aug 2017.
                hdnFundProvided.Value = HttpUtility.HtmlDecode(objNeedy.FundsProvidedAmount.ToString());    //Modified by AR, 07-April-2024 |T#24525 | Desanitization of Data
                //if (objNeedy.FundsUtilizedDate == "")-- Commented By BS on 9-May-2018 to remove default date Task ID-10462
                //{
                //    txtFundsUtilizedDate.Text = objNeedy.ContactDate.ToString();
                //    hdnFundsUtilizedDate.Value = Convert.ToDateTime(objNeedy.ContactDate.ToString()).ToString("MM/dd/yyyy");
                //}

                txtFundsUtilizedDate.Text = Convert.ToString(objNeedy.FundsUtilizedDate);//objNeedy.FundsUtilizedDate.ToString();
                if (!string.IsNullOrWhiteSpace(objNeedy.FundsUtilizedDate))
                    hdnFundsUtilizedDate.Value = Convert.ToDateTime(HttpUtility.HtmlDecode(objNeedy.FundsUtilizedDate.ToString())).ToString("MM/dd/yyyy");   //Modified by AR, 07-April-2024 |T#24525 | Desanitization of Data

                txtFundsUtilizedForOther.Text = hdnFundsUtilizedForOther.Value = HttpUtility.HtmlDecode(objNeedy.FundsUtilizedForOther); // Added by GK on 28June,2021 TicketID #2544    //Modified by RK,01April2024,Task-ID: 24527,Purpose: Sanitization of data

                // Added by GK on 09Dec,2021 : TicketID #6715
                txtServReqOther.Text = Convert.ToString(objNeedy.OtherServiceRequested);

                try
                {
                    // checked for Update Call 
                    //if (hdnUpdateCall.Value == "1" || hdnFlwpSelected.Value == "1")
                    //{
                    HidHoldDuration.Value = txtCallDuration.Text = HttpUtility.HtmlDecode(objNeedy.CallDuration);    //Modified by AR, 07-April-2024 |T#24525 | Desanitization of Data
                    hdnTimerLimit.Value = ConvertTimeToSecond(objNeedy.CallDuration);
                    //}
                }
                catch (Exception) { }

                btnSave.Text = "Update";
                btnSaveAndClose.Text = "Update & Close";
            }
            else
            {
                hdnServReq.Value = "";
                lstServicesRequested.Items.Clear();

                //lblRelationLabel.Attributes.Add("style", "display:none");
                lblRelationship.Text = "";

                lblContactPerson.Attributes.Add("style", "display:none");
                ddlContactPerson.Attributes.Add("style", "display:none");
            }




            //if (objNeedy.ReferredToAgencyID != null)
            //{
            //    if (objNeedy.ReferredToAgencyID != -1)
            //    {
            //        ddlRefTo.ClearSelection();
            //        try { ddlRefTo.Items.FindByValue(objNeedy.ReferredToAgencyID.ToString()).Selected = true; }
            //        catch { }
            //    }
            //}





            //========== End of Call level Setting ==========================================================================

            lblContactIdValue.Text = objNeedy.ContactId;

            // Commented by GK on 09Dec,2021 : TicketID #6715
            //txtServReqOther.Text = Convert.ToString(objNeedy.OtherServiceRequested);

            //ContactType
            //if (ddlContactType.SelectedItem.Text.ToUpper() == "OTHER")            
            if (IsContacTypeForReferringAgency)//For Professional, Other, Proxy and Family Type
            {
                lblOtherContacType.Attributes.Add("style", "display:inline");
                txtOtherContactType.Attributes.Add("style", "display:inline");
                lblOtherContacType.InnerText = ddlContactType.SelectedItem.Text + " Info";
                refringAgencyDiv.Attributes.Add("style", "display:block");
                inputSearchSpan.Attributes.Add("style", "display:inline");
            }
            else
            {
                lblOtherContacType.Attributes.Add("style", "display:none");
                txtOtherContactType.Attributes.Add("style", "display:none");
                refringAgencyDiv.Attributes.Add("style", "display:none");
                inputSearchSpan.Attributes.Add("style", "display:none");
            }

            //Contact method
            if (ddlContactMethod.SelectedItem.Text.ToUpper() == "OTHER")
            {
                lblOtherContactMethod.Attributes.Add("style", "display:inline");
                txtOtherContactMethod.Attributes.Add("style", "display:inline");
            }
            else
            {
                lblOtherContactMethod.Attributes.Add("style", "display:none");
                txtOtherContactMethod.Attributes.Add("style", "display:none");
            }
            #region
            // Option Counselling Section. SA on 20-11-2014. SOW-335
            try
            {

                txtFinancialNotes.Text = objNeedy.OCFinancialNotes;



                if (objNeedy.IsCareGiverStatus == true)
                    chkCaregiverYes.Checked = true;
                else if (objNeedy.IsCareGiverStatus == false)
                    chkCaregiverNo.Checked = true;

                txtInsuranceOther.Text = objNeedy.InsuranceTypesOther;

                //if (objNeedy.InsuranceTypes != null)
                //{
                //    ddlInsuranceTypes.SelectedValue = Convert.ToString(objNeedy.InsuranceTypes);

                //    if (ddlInsuranceTypes.SelectedItem.Text == "Other")
                //        txtInsuranceOther.Attributes.Add("style", "display:inline;");
                //}
                //else
                //    ddlInsuranceTypes.Items.FindByText("--Select--").Selected = true;

                // Commented above code to handle multiple selection as upgraded to below code. SA on 9th March, 2015. TID:2695

                if (objNeedy.InsuranceTypes != null)
                {
                    InsuranceTypes = "\"" + objNeedy.InsuranceTypes + "\"";
                    ViewState["InsuranceTypes"] = InsuranceTypes;
                    if (InsuranceTypes.Contains("8"))// 8 means 'Other' then to show other textbox.
                        txtInsuranceOther.Attributes.Add("style", "display:inline;");
                }


                chkOCTriggerPresent.Checked = objNeedy.IsOCTriggerPresent;

                if (objNeedy.OCTriggers != null)
                {
                    TriggerValues = "\"" + objNeedy.OCTriggers + "\"";
                    ViewState["TriggerValues"] = TriggerValues;
                }



                if (objNeedy.LacksMemoryYesNo != null)
                    if (objNeedy.LacksMemoryYesNo == true)
                        chkLMYes.Checked = true;
                    else if (objNeedy.LacksMemoryYesNo == false)
                        chkLMNo.Checked = true;

                if (objNeedy.LMIsReportedDiagnosed != null)
                    ddlLMReportedDiagnosed.SelectedValue = Convert.ToString(objNeedy.LMIsReportedDiagnosed);
                else
                    ddlLMReportedDiagnosed.Items.FindByText("--Select--").Selected = true;

                if (objNeedy.LMImpairements != null)
                {
                    ddlLacksMemory.SelectedValue = Convert.ToString(objNeedy.LMImpairements);
                }
                else
                    ddlLacksMemory.Items.FindByText("--Select--").Selected = true;

                if (objNeedy.TotalAssetAmount != null)
                {
                    txtAssetAmount.Text = string.Format("{0:G29}", decimal.Parse(objNeedy.TotalAssetAmount));
                }
                if (objNeedy.HouseholdIncome != null)
                {
                    txtTotalHouseholdIncome.Text = string.Format("{0:G29}", decimal.Parse(objNeedy.HouseholdIncome));
                }
                if (objNeedy.SpouseIncome != null)
                {
                    txtSpouse.Text = string.Format("{0:G29}", decimal.Parse(objNeedy.SpouseIncome));
                }
                if (objNeedy.ClientIncome != null)
                {
                    txtClient.Text = string.Format("{0:G29}", decimal.Parse(objNeedy.ClientIncome));
                }


                chkNottoDevelop.Checked = objNeedy.IsNotToDevelop;
                chkDevelopPlan.Checked = objNeedy.IsToDevelop;
                chkPermissiotoCall.Checked = objNeedy.IsPermissionForCall;

            }
            catch { }


            //Section ends here.
            #endregion
        }
        catch (Exception ex)
        {
            //throw ex;
        }
    }


    /// <summary>
    /// Created By: SM
    /// Date:06/26/2013
    /// Purpose: Show tooltip on dropdown item
    /// </summary>
    /// <param name="ddl"></param>
    void AddtoolTip(DropDownList ddl)
    {
        foreach (ListItem item in ddl.Items)
        {
            item.Attributes.Add("title", item.Text);

        }

    }
    /// <summary>
    /// Created By: SM
    /// Date:05/05/2013
    /// Purpose: Bind All drop down control when page load
    /// </summary>

    void BindDropDown()
    {
        int CallHistoryID = 0;
        DataSet dsCommonData = ADRCIA.ADRCIADAL.GetCommonData();


        //ddlEthnicity
        ddlEthnicity.DataSource = dsCommonData.Tables[10];
        ddlEthnicity.DataValueField = "EthnicityID";
        ddlEthnicity.DataTextField = "Ethnicity";
        ddlEthnicity.DataBind();
        AddtoolTip(ddlEthnicity);
        ddlEthnicity.Items.Insert(0, new ListItem("--Select--", "-1"));


        //Added By KP on 31st Jan 2020(SOW-577), To get and bind the Title Combobox.      
        cmbTitle.DataSource = dsCommonData.Tables[9];
        cmbTitle.DataValueField = "Title";
        cmbTitle.DataTextField = "Title";
        cmbTitle.DataBind();
        //cmbTitle.Items.Insert(0, new ListItem("Title", "-1"));

        //Contact Type
        ddlContactType.DataSource = dsCommonData.Tables[0];
        ddlContactType.DataValueField = "ContactTypeId";
        ddlContactType.DataTextField = "ContactTypeName";
        ddlContactType.DataBind();
        AddtoolTip(ddlContactType);
        ddlContactType.Items.Insert(0, new ListItem("--Select--", "-1"));

        //Contact method
        ddlContactMethod.DataSource = dsCommonData.Tables[1];
        ddlContactMethod.DataValueField = "ContactMethodID";
        ddlContactMethod.DataTextField = "ContactMethodName";
        ddlContactMethod.DataBind();
        AddtoolTip(ddlContactMethod);
        ddlContactMethod.Items.Insert(0, new ListItem("--Select--", "-1"));

        //Marital Status
        ddlMaritalStatus.DataSource = dsCommonData.Tables[2];
        ddlMaritalStatus.DataValueField = "MaritalStatusID";
        ddlMaritalStatus.DataTextField = "MaritalStatus";
        ddlMaritalStatus.DataBind();
        AddtoolTip(ddlMaritalStatus);
        ddlMaritalStatus.Items.Insert(0, new ListItem("--Select--", "-1"));

        //Race
        ddlRace.DataSource = dsCommonData.Tables[3];
        ddlRace.DataValueField = "RaceID";
        ddlRace.DataTextField = "Race";
        ddlRace.DataBind();
        AddtoolTip(ddlRace);
        ddlRace.Items.Insert(0, new ListItem("--Select--", "-1"));

        //Veteran
        ddlVetStatus.DataSource = dsCommonData.Tables[4];
        ddlVetStatus.DataValueField = "VeteranID";
        ddlVetStatus.DataTextField = "VeteranStatus";
        ddlVetStatus.DataBind();
        AddtoolTip(ddlVetStatus);
        ddlVetStatus.Items.Insert(0, new ListItem("--Select--", "-1"));

        // Living Arrangement
        ddlLivingArrangement.DataSource = dsCommonData.Tables[5];
        ddlLivingArrangement.DataValueField = "LivingID";
        ddlLivingArrangement.DataTextField = "LivingArrangement";
        ddlLivingArrangement.DataBind();
        AddtoolTip(ddlLivingArrangement);
        ddlLivingArrangement.Items.Insert(0, new ListItem("--Select--", "-1"));

        // Disability Types : Added by SA on 3-11-2014. SOW-335
        ddlDisabilityTypes.DataSource = dsCommonData.Tables[6];
        ddlDisabilityTypes.DataValueField = "DisabilityTypeID";
        ddlDisabilityTypes.DataTextField = "DisabilityTypeName";
        ddlDisabilityTypes.DataBind();
        AddtoolTip(ddlDisabilityTypes);
        ddlDisabilityTypes.Items.Insert(0, new ListItem("--Select--", "-1"));
        ddlDisabilityTypes.Items.Insert(10, new ListItem("Other", "10"));

        dsCommonData.Dispose();
        //Contact Person City
        DataTable dtTemp = ADRCIA.ADRCIADAL.GetCityByCounty(null);
        cmbCCity.DataSource = dtTemp;
        cmbCCity.DataValueField = "CityID";
        cmbCCity.DataTextField = "CityName";
        cmbCCity.DataBind();
        cmbCCity.Items.Insert(0, new ListItem("--Select--", "-1"));

        // Needy Person City
        cmbNCity.DataSource = dtTemp;
        cmbNCity.DataValueField = "CityID";
        cmbNCity.DataTextField = "CityName";
        cmbNCity.DataBind();
        cmbNCity.Items.Insert(0, new ListItem("--Select--", "-1"));

        //Contact person County
        dtTemp.Rows.Clear();
        dtTemp = ADRCIA.ADRCIADAL.GetCountyName();
        cmbCCounty.DataSource = dtTemp;
        cmbCCounty.DataValueField = "CountyId";
        cmbCCounty.DataTextField = "CountyName";
        cmbCCounty.DataBind();
        cmbCCounty.Items.Insert(0, new ListItem("--Select--", "-1"));

        //Needing Person County
        cmbNCounty.DataSource = dtTemp;
        cmbNCounty.DataValueField = "CountyId";
        cmbNCounty.DataTextField = "CountyName";
        cmbNCounty.DataBind();
        cmbNCounty.Items.Insert(0, new ListItem("--Select--", "-1"));

        // Added by GK on 10Apr19 : SOW-563
        // Needing Person Township
        ddlTownship.DataSource = dsCommonData.Tables[8];
        ddlTownship.DataValueField = "TownshipCode";
        ddlTownship.DataTextField = "TownshipName";
        ddlTownship.DataBind();
        ddlTownship.Items.Insert(0, new ListItem("--Select--", "-1"));

        // Added by GK on 15May19 : SOW-563
        ddlCustomField.DataSource = ADRCIADAL.GetCustomFieldList();
        ddlCustomField.DataValueField = "CustomCode";
        ddlCustomField.DataTextField = "CustomName";
        ddlCustomField.DataBind();
        ddlCustomField.Items.Insert(0, new ListItem("--Select--", "-1"));

        var dtService = ADRCIA.ADRCIADAL.GetServicesList();
        lstServicesAvailable.DataSource = dtService;
        lstServicesAvailable.DataValueField = "ServiceID";
        lstServicesAvailable.DataTextField = "ServiceName";
        lstServicesAvailable.DataBind();

        //Response.Write("Current Site ID " + HttpContext.Current.Session["CurrentSiteId"].ToString());

        string strAvailServID = string.Empty;
        //Added By KR on 15 May 2017. Purpose to add title in lisbox items.
        foreach (ListItem item in lstServicesAvailable.Items)
        {
            item.Attributes["title"] = item.Text;

            // Commented by GK on 4Feb 2021 : Ticket #925
            //if (strAvailServID.Length == 0)//Added By BS on 1-March-2018 sow-512
            //    strAvailServID = "<option value=" + item.Value + ">" + item.Text + "</option";
            //else
            //    strAvailServID = strAvailServID + "~" + "<option value=" + item.Value + ">" + item.Text + "</option>";
        }

        // Added by GK on 4Feb 2021 : Ticket #925
        dtService.Columns["ServiceID"].ColumnName = "Value";
        dtService.Columns["ServiceName"].ColumnName = "Text";
        hdnServAvail.Value = GetJson(dtService);  
        //  lstbxServicesRequested.Items.Insert(0, new ListItem("--Select--", "-1"));

        dtTemp.Dispose();


        //// bind AAA  as Reffred by Agency
        ddlRefBy.DataSource = ADRCIA.ADRCIADAL.GetAAACILAgency();
        ddlRefBy.DataValueField = "AAACILSiteID";
        ddlRefBy.DataTextField = "AAACILSiteName";
        ddlRefBy.DataBind();
        ddlRefBy.Items.Insert(0, new ListItem("--Select--", "-1"));

        //Added By KP on 20th Apr 2020(TaskID:18464), To exclude the current loged-in Agency from dropdownlist.        
        ListItem removeItem = ddlRefBy.Items.FindByValue(MySession.SiteId.ToString());
        if (removeItem != null)
            ddlRefBy.Items.Remove(removeItem);
        //(TaskID:18464)

        // bind AAA in Reffered To Agency
        //ddlRefTo.DataSource = ADRCIADAL.GetADRCAgencyList();// 
        //ddlRefTo.DataValueField = "ADRCSiteIDADRC";
        //ddlRefTo.DataTextField = "ADRCName1ADRC";
        //ddlRefTo.DataBind();
        //ddlRefTo.Items.Insert(0, new ListItem("--Select--", "-1"));


        //bind Reffred to Service providers
        //ddlRefToServiceProvider.DataSource = ADRCIADAL.GetServiceProvider();
        //ddlRefToServiceProvider.DataValueField = "SiteID";
        //ddlRefToServiceProvider.DataTextField = "SiteName";
        //ddlRefToServiceProvider.DataBind();
        //ddlRefToServiceProvider.Items.Insert(0, new ListItem("--Select--", "-1"));


        //Added By VK on 03 Aug 2017. Purpose to bind  chklistFundsUtilized.
        //Modified by GK on 07 July 2021. Purpose to clear callhistory ID on "New Needy Person"
        if (Request.QueryString["CLID"] != null)
            CallHistoryID = Convert.ToInt32(Request.QueryString["CLID"]);
        else if (HttpContext.Current.Session["CurrentHistoryID"] != null)
            CallHistoryID = Convert.ToInt32(HttpContext.Current.Session["CurrentHistoryID"]);
        else
            CallHistoryID = 0;

        DataTable dt = ADRCIADAL.getFundsUtilized(CallHistoryID);
        chklistFundsUtilized.DataSource = dt;
        chklistFundsUtilized.DataValueField = "FundsUtilizedID";
        chklistFundsUtilized.DataTextField = "FundsUtilized";
        chklistFundsUtilized.DataBind();

        // Added by GK on 25June,2021 : TicketID #2419
        // Modified by GK on 20July,2021 : TicketID #3730
        foreach (ListItem li in chklistFundsUtilized.Items)
        {
            if (li.Value == "4") // Other
            {
                // Bind onclick event for "Other" item list of "Funds Utilized For" field
                li.Attributes.Add("onclick", "EnableDisableTextFundProvidedOther(this)");

                // When update an existing call
                if (CallHistoryID != 0)
                    li.Text = li.Text.Split(':')[0].ToString().Trim(); //Same SP is calling from report that why we need to manage 'Other' item text here
            }
        }

        // if (Convert.ToString(Session["IsCallUpdate"]) == "1")
        if ((Convert.ToString(Request.QueryString["IsNew"]) == "0" && Convert.ToString(Request.QueryString["Saved"]) != null) || (Convert.ToString(Session["IsCallUpdate"]) == "1"))
        {
            foreach (ListItem s in chklistFundsUtilized.Items)
            {
                DataRow[] result = dt.Select("FundsUtilizedID = " + s.Value);
                string IsFundsUtilized = result[0]["IsFundsUtilized"].ToString();
                if (IsFundsUtilized == "1")
                {
                    s.Selected = true;
                    hdnFundsUtilized.Value = hdnFundsUtilized.Value + result[0]["FundsUtilizedID"].ToString() + ",";  //Modified by AR, 07-April-2024 |T#24525 | Desanitization of Data
                    if (s.Value == "4") txtFundsUtilizedForOther.Enabled = true; // Modified by GK on 20July,2021 : TicketID #3730 FundsUtilized Other=4   // Added by GK on 25June,2021 : TicketID #2419
                }
            }
        }
    }


    //Save person needing assistance and Contact Person Details(Only of new person and contact type other than 'Self') 
    protected void btnSave_Click(object sender, EventArgs e)
    {
        //if (hdnIsStop.Value != "True")
        //{
        //Session["TimerLimit"] = hdnTimerLimit.Value;
        //}
        //else
        //{
        //    Session["TimerLimit"] = 0;
        //}
        SetTimerSession(true);
        SaveRecord(false);
    }
    /// <summary>
    /// Created By: SM
    /// Date:03/07/2013
    /// Purpose: Save Person Needing Assistance details
	/// Modify by VK on 12 April,2021.Ticket 1687:Error in application name (ADRCIA)
    /// </summary>
    void SaveRecord(bool isSaveAndClose)
    {
        hdnFundsUtilized.Value = "";
        try
        {   // Create  object and set value to be save
            bool IsValid = true;
            string MessageList = "Please correct the maximum length of the field below to save the record:";
            MessageList += "<dl>";
            if (txtNAddress.MaxLength < AntiXssEncoder.HtmlEncode(txtNAddress.Text, true).Trim().Length)
            {
                IsValid = false;
                MessageList += "<dt>Personal Information Tab:</dt>";
                MessageList += "<dd>The length of the address field must be " + txtNAddress.MaxLength + " characters or less.Due to a special character or tag entered in the address field, you have exceeded the maximum limit by entering " + (AntiXssEncoder.HtmlEncode(txtNAddress.Text, true).Trim().Length) + " characters.</dd>";
            }
            //txtAlreadyServiceNotes
            if (txtAlreadyServiceNotes.MaxLength < AntiXssEncoder.HtmlEncode(txtAlreadyServiceNotes.Text, true).Trim().Length)
            {
                IsValid = false;
                MessageList += "<dt>Services Available/Requested Tab:</dt>";
                MessageList += "<dd>The length of the Notes field must be " + txtAlreadyServiceNotes.MaxLength + " characters or less.Due to a special character or tag entered in the Notes field, you have exceeded the maximum limit by entering " + (AntiXssEncoder.HtmlEncode(txtAlreadyServiceNotes.Text, true).Trim().Length) + " characters.</dd>";
            }

            if (txtNotes.MaxLength < AntiXssEncoder.HtmlEncode(txtNotes.Text, true).Trim().Length)
            {
                IsValid = false;
                MessageList += "<dt>Call info Tab:</dt>";
                MessageList += "<dd>The length of the Notes field must be " + txtNotes.MaxLength + " characters or less.Due to a special character or tag entered in the Notes field, you have exceeded the maximum limit by entering " + (AntiXssEncoder.HtmlEncode(txtNotes.Text, true).Trim().Length) + " characters.</dd>";
            }
            if (txtFollowUpNotes.MaxLength < AntiXssEncoder.HtmlEncode(txtFollowUpNotes.Text, true).Trim().Length)
            {
                IsValid = false;
                MessageList += "<dt>Follow up Tab:</dt>";
                MessageList += "<dd>The length of the I&A Follow-up Notes field must be " + txtFollowUpNotes.MaxLength + " characters or less.Due to a special character or tag entered in the I&A Follow-up Notes field, you have exceeded the maximum limit by entering " + (AntiXssEncoder.HtmlEncode(txtFollowUpNotes.Text, true).Trim().Length) + " characters.</dd>";
            }
            if (txtOCFollowupnotes.MaxLength < AntiXssEncoder.HtmlEncode(txtOCFollowupnotes.Text, true).Trim().Length)
            {
                IsValid = false;
                MessageList += "<dd>The length of the Option Counseling Follow-up Notes field must be " + txtOCFollowupnotes.MaxLength + " characters or less.Due to a special character or tag entered in the Option Counseling Follow-up Notes field, you have exceeded the maximum limit by entering " + (AntiXssEncoder.HtmlEncode(txtOCFollowupnotes.Text, true).Trim().Length) + " characters.</dd>";
            }
            if (txtFinancialNotes.MaxLength < AntiXssEncoder.HtmlEncode(txtFinancialNotes.Text, true).Trim().Length)
            {
                IsValid = false;
                MessageList += "<dt>Option Counseling Tab:</dt>";
                MessageList += "<dd>The length of the Financial Notes field must be " + txtFinancialNotes.MaxLength + " characters or less.Due to a special character or tag entered in the Financial Notes field, you have exceeded the maximum limit by entering " + (AntiXssEncoder.HtmlEncode(txtFinancialNotes.Text, true).Trim().Length) + " characters.</dd>";
            }
            if (txtDescription.MaxLength < AntiXssEncoder.HtmlEncode(txtDescription.Text, true).Trim().Length)
            {
                IsValid = false;
                MessageList += "<dt>Description Tab:</dt>";
                MessageList += "<dd>The length of the Description field must be " + txtFinancialNotes.MaxLength + " characters or less.Due to a special character or tag entered in the Description field, you have exceeded the maximum limit by entering " + (AntiXssEncoder.HtmlEncode(txtFinancialNotes.Text, true).Trim().Length) + " characters.</dd>";
            }
            if (!IsValid)
            {
                MessageList += "</dl>";
                System.Web.UI.ScriptManager.RegisterStartupScript(this, this.GetType(), "Maxlenghterror", " ShowAlert('" + MessageList + "','E')", true);
                return;
            }
            else
            {
                PersonNeedAssistance objNeedy = new PersonNeedAssistance();
                objNeedy.getRefToADRCIDs = Convert.ToString(Session["RefToADRCIDs"]);
                ViewState["RefToADRCIDs"] = null;

                // Option Counselling . SOW-335. SA on 20-11-2014.

                //OCFinancialNotes
                objNeedy.OCFinancialNotes = AntiXssEncoder.HtmlEncode((txtFinancialNotes.Text == String.Empty) ? null : txtFinancialNotes.Text, true);

                if (chkCaregiverYes.Checked == true)
                    objNeedy.IsCareGiverStatus = true;//chkCaregiverYes.Checked;
                else if (chkCaregiverNo.Checked)
                    objNeedy.IsCareGiverStatus = false;//chkCaregiverNo.Checked;
                else
                    objNeedy.IsCareGiverStatus = null;


                //if (ddlInsuranceTypes.SelectedIndex > 0)
                //    objNeedy.InsuranceTypes = Convert.ToInt32(ddlInsuranceTypes.SelectedValue);
                //else
                //    objNeedy.InsuranceTypes = null;

                // Commented above code to handle multiple selection as upgraded to below code. SA on 9th March, 2015. TID:2695

                if (!string.IsNullOrEmpty(Session["InsuranceTypes"].ToString()))
                {
                    objNeedy.InsuranceTypes = Session["InsuranceTypes"].ToString();
                    Session["InsuranceTypes"] = null;
                }

                else
                    objNeedy.InsuranceTypes = null;


                objNeedy.InsuranceTypesOther = txtInsuranceOther.Text;
                objNeedy.IsOCTriggerPresent = chkOCTriggerPresent.Checked;
                if (!string.IsNullOrEmpty(Session["TriggerValues"].ToString()))
                {
                    objNeedy.OCTriggers = Session["TriggerValues"].ToString();
                    Session["TriggerValues"] = null;
                }
                else
                    objNeedy.OCTriggers = null;

                objNeedy.IsServicesAlreadyinPlace = chkServicesAlreadyinPlace.Checked;
                objNeedy.ServicesAlreadyinPlaceNotes = AntiXssEncoder.HtmlEncode(txtAlreadyServiceNotes.Text, true);
                if (ddlLMReportedDiagnosed.SelectedIndex > 0)
                    objNeedy.LMIsReportedDiagnosed = Convert.ToInt32(ddlLMReportedDiagnosed.SelectedValue);
                else
                    objNeedy.LMIsReportedDiagnosed = null;

                if (chkLMYes.Checked == true)
                    objNeedy.LacksMemoryYesNo = true;
                else if (chkLMNo.Checked == true)
                    objNeedy.LacksMemoryYesNo = false;
                else
                    objNeedy.LacksMemoryYesNo = null;

                if (ddlLacksMemory.SelectedIndex > 0)
                    objNeedy.LMImpairements = Convert.ToInt32(ddlLacksMemory.SelectedValue);
                else
                    objNeedy.LMImpairements = null;

                if (!string.IsNullOrEmpty(txtAssetAmount.Text))
                    objNeedy.TotalAssetAmount = txtAssetAmount.Text;
                else
                    objNeedy.TotalAssetAmount = null;

                if (!string.IsNullOrEmpty(txtTotalHouseholdIncome.Text))
                    objNeedy.HouseholdIncome = txtTotalHouseholdIncome.Text;
                else
                    objNeedy.HouseholdIncome = null;

                if (!string.IsNullOrEmpty(txtSpouse.Text))
                    objNeedy.SpouseIncome = txtSpouse.Text;
                else
                    objNeedy.SpouseIncome = null;

                if (!string.IsNullOrEmpty(txtClient.Text))
                    objNeedy.ClientIncome = txtClient.Text;
                else
                    objNeedy.ClientIncome = null;

                objNeedy.IsNotToDevelop = chkNottoDevelop.Checked;
                objNeedy.IsToDevelop = chkDevelopPlan.Checked;
                objNeedy.IsPermissionForCall = chkPermissiotoCall.Checked;
                //OC Ends here..

                //Added By KP on 31st Jan 2020(SOW-577), To set selected title into Title prop.
                if ((cmbTitle.SelectedIndex > 0 || cmbTitle.SelectedIndex != -1) && cmbTitle.SelectedItem.Text != "")
                {
                    //if (!cmbTitle.SelectedItem.Text.Contains("Title"))
                    objNeedy.Title = cmbTitle.SelectedItem.Text;
                }

                objNeedy.FirstName = txtNFName.Text.Trim();
                objNeedy.MI = string.IsNullOrEmpty(txtNMi.Text.Trim()) ? null : txtNMi.Text.Trim();
                objNeedy.LastName = string.IsNullOrEmpty(txtNLName.Text.Trim()) ? null : txtNLName.Text.Trim();

                if (!string.IsNullOrEmpty(txtNPhonePrime.Text))
                    objNeedy.PhonePrimary = txtNPhonePrime.Text.Replace("-", "").Replace("(", "").Replace(")", "");
                if (!string.IsNullOrEmpty(txtNPhonAlt.Text))
                    objNeedy.PhoneAlt = txtNPhonAlt.Text.Replace("-", "").Replace("(", "").Replace(")", "");

                objNeedy.PhonePrimaryExtn = string.IsNullOrEmpty(txtNPhonePrimeExtn.Text) ? null : txtNPhonePrimeExtn.Text;//Added By BS on 15-sep-2016
                objNeedy.PhoneAltExtn = string.IsNullOrEmpty(txtNPhoneAltExtn.Text) ? null : txtNPhoneAltExtn.Text;//Added By BS on 15-sep-2016


                if (!string.IsNullOrEmpty(txtNPriFax.Text))//Added By BS on 19-dec-2016
                    objNeedy.NPrimaryFax = txtNPriFax.Text.Replace("-", "").Replace("(", "").Replace(")", "");
                objNeedy.Email = string.IsNullOrEmpty(txtNEmail.Text.Trim()) ? null : txtNEmail.Text.Trim();

                if (!string.IsNullOrEmpty(txtNDOB.Text) && hdnIsAgeOn.Value == "0")
                    objNeedy.DOB = Convert.ToString(txtNDOB.Text);
                else
                {
                    //Added by vk on 24 April,2019, for AgeOn.
                    if (!string.IsNullOrEmpty(txtNAge.Text) && txtNAge.Text != hdnAge.Value)
                        objNeedy.AgeOn = DateTime.Now;
                    else if (!string.IsNullOrEmpty(hdnAgeOn.Value))
                        objNeedy.AgeOn = Convert.ToDateTime(hdnAgeOn.Value);
                }
                if (!string.IsNullOrEmpty(txtNAge.Text))
                    objNeedy.Age = Convert.ToInt32(txtNAge.Text);

                if ((cmbPrimaryLaguage.SelectedIndex > 0 || cmbPrimaryLaguage.SelectedIndex != -1) && cmbPrimaryLaguage.SelectedItem.Text != "")
                {
                    if (!cmbPrimaryLaguage.SelectedItem.Text.Contains("Select/Type"))
                        objNeedy.PrimaryLanguage = cmbPrimaryLaguage.SelectedItem.Text;
                }
                objNeedy.Address = AntiXssEncoder.HtmlEncode(string.IsNullOrEmpty(txtNAddress.Text) ? null : txtNAddress.Text, true);

                // Set needy person City
                if (hdnIsTakeNDCityFromHidden.Value == "1")
                    objNeedy.CityName = hdnNdCity.Value;
                else
                {
                    if ((cmbNCity.SelectedIndex > 0 || cmbNCity.SelectedIndex != -1) && cmbNCity.SelectedItem.Text != "")
                    {
                        if (!cmbNCity.SelectedItem.Text.Contains("Select"))
                            objNeedy.CityName = cmbNCity.SelectedItem.Text;
                    }
                }
                // Set needy person County
                if (hdnIsTakeNDCountyFromHidden.Value == "1")
                    objNeedy.CountyName = hdnNdCounty.Value;
                else
                {
                    if ((cmbNCounty.SelectedIndex > 0 || cmbNCounty.SelectedIndex != -1) && cmbNCounty.SelectedItem.Text != "")
                    {
                        if (!cmbNCounty.SelectedItem.Text.Contains("Select"))
                            objNeedy.CountyName = cmbNCounty.SelectedItem.Text;
                    }
                }

                // Set needy person Township : Added by GK on 10Apr19 : SOW-563
                if (ddlTownship.SelectedValue != "-1")
                {
                    objNeedy.TownshipCode = ddlTownship.SelectedValue;
                }

                // Set needy person CustomField : Added by GK on 15Apr19 : SOW-563
                if (!string.IsNullOrWhiteSpace(Request.Form[ddlCustomField.UniqueID]) && Request.Form[ddlCustomField.UniqueID].ToString() != "-1")
                    objNeedy.CustomCode = Convert.ToInt32(Request.Form[ddlCustomField.UniqueID]);

                objNeedy.State = string.IsNullOrEmpty(txtNState.Text.Trim()) ? null : txtNState.Text.Trim();
                objNeedy.Zip = string.IsNullOrEmpty(txtNZip.Text.Trim()) ? null : txtNZip.Text.Trim();
                objNeedy.ContactPreferencePhone = chkNPhone.Checked;
                objNeedy.ContactPreferenceEmail = chkNEmail.Checked;
                objNeedy.ContactPreferenceSMS = chkNSMS.Checked;
                objNeedy.ContactPreferenceMail = chkNMail.Checked;

                ////Added By Kuldeep Rathore Date:05-13-2015
                //objNeedy.IsPreferredContactNOther = chkNOther.Checked;
                //objNeedy.PreferredContactNOther = string.IsNullOrEmpty(txtOtherNContact.Text.Trim()) ? null : txtOtherNContact.Text.Trim();
                ////Added Section End Here By Kuldeep Rathore

                if (ddlGender.SelectedIndex > 0)
                    objNeedy.Gender = ddlGender.SelectedValue;
                else
                    objNeedy.Gender = null;

                if (ddlMaritalStatus.SelectedIndex > 0)
                    objNeedy.MarriageStatusID = Convert.ToInt32(ddlMaritalStatus.SelectedValue);


                if (ddlRace.SelectedIndex > 0)
                    objNeedy.RaceID = Convert.ToInt32(ddlRace.SelectedValue);

                if (ddlEthnicity.SelectedIndex > 0)
                    objNeedy.EthnicityID = Convert.ToInt32(ddlEthnicity.SelectedValue);
                if (ddlVetStatus.SelectedIndex > 0)
                    objNeedy.VeteranStatusID = Convert.ToInt32(ddlVetStatus.SelectedValue);
                if (ddlFollowUp.SelectedIndex > 0)
                    objNeedy.FollowUp = Convert.ToInt32(ddlFollowUp.SelectedValue);

                if (!string.IsNullOrEmpty(txtFollowupDate.Text))
                    objNeedy.FollowupDate = txtFollowupDate.Text;
                else
                    objNeedy.FollowupDate = null;

                // Added by SA on 10-11-2014. SOW-335
                if (ddlOCFollowUp.SelectedIndex > 0)
                    objNeedy.OCFollowUp = Convert.ToInt32(ddlOCFollowUp.SelectedValue);

                if (!string.IsNullOrEmpty(txtOCFollowupnotes.Text))
                    objNeedy.OCFollowupNotes = AntiXssEncoder.HtmlEncode(txtOCFollowupnotes.Text, true);
                else
                    objNeedy.OCFollowupNotes = null;

                if (!string.IsNullOrEmpty(txtOCfollowupdate.Text))
                    objNeedy.OCFollowupDate = txtOCfollowupdate.Text;
                else
                    objNeedy.OCFollowupDate = null;

                objNeedy.ReferredForOC = chkreferredforoc.Checked;
                // Added by SA on 21st Aug, 2015. SOW-379
                if (!string.IsNullOrEmpty(txtreferredforocdate.Text))
                    objNeedy.ReferredForOCDate = txtreferredforocdate.Text;
                else
                    objNeedy.ReferredForOCDate = null;
                //addition ends here
                objNeedy.OtherServiceRequested = string.IsNullOrEmpty(txtServReqOther.Text) ? null : txtServReqOther.Text;

                if (ddlServiceNeedMet.SelectedIndex > 0)
                    objNeedy.ServiceNeedsMet = Convert.ToInt32(ddlServiceNeedMet.SelectedValue);

                //if (hdnRefBy.Value != "")
                //    objNeedy.ReferredByAgencyID = Convert.ToInt32(hdnRefBy.Value);
                if (ddlRefBy.SelectedIndex > 0)
                    objNeedy.ReferredByAgencyID = Convert.ToInt32(ddlRefBy.SelectedValue);
                else
                    objNeedy.ReferredByAgencyID = null;

                //if (hdnRefTo.Value != "")
                //   objNeedy.ReferredToAgencyID = Convert.ToInt32(hdnRefTo.Value);

                // Set reffered to 
                //if (ddlRefTo.SelectedIndex > 0)
                //{
                //    objNeedy.ReferredToAgencyID = Convert.ToInt32(ddlRefTo.SelectedValue);
                //    //Added By: SM, Date: 03 June 2014, Purpose: Set permission Granted value

                //}
                //else
                //{
                //    objNeedy.ReferredToAgencyID = null;

                //}
                //Added by SA on 3-11-2014. SOW-335
                if (ddlDisabilityTypes.SelectedIndex > 0 && chkDisabilityYes.Checked == true)
                    objNeedy.DisabilityTypes = Convert.ToInt32(ddlDisabilityTypes.SelectedValue);
                else
                    objNeedy.DisabilityTypes = null;

                if (!string.IsNullOrEmpty(txtOtherDisability.Text))
                    objNeedy.DisabilityTypesOther = txtOtherDisability.Text;
                else
                    objNeedy.DisabilityTypesOther = null;

                if (chkDisabilityYes.Checked == true)
                    objNeedy.IsDisability = "1";

                else if (chkDisabilityNo.Checked == true)
                    objNeedy.IsDisability = "0";

                else if (chkDisabilityUnknown.Checked == true)
                    objNeedy.IsDisability = "2";
                else
                    objNeedy.IsDisability = null;

                if (chkPermissionGranted.SelectedItem != null)
                {
                    if (chkPermissionGranted.SelectedItem.Value == "0")
                        objNeedy.IsPermissionGranted = false;
                    else
                        objNeedy.IsPermissionGranted = true;
                }



                // Referred to Service Providers
                //if (ddlRefToServiceProvider.SelectedIndex > 0)
                //    objNeedy.ReferredToServiceProvider = Convert.ToInt32(ddlRefToServiceProvider.SelectedValue);
                //else
                //    objNeedy.ReferredToServiceProvider = null;

                //objNeedy.ReferredToServiceProvider = 

                if (!string.IsNullOrEmpty(Session["ReferredToServiceProvider"].ToString()))
                {
                    objNeedy.ReferredToServiceProvider = Session["ReferredToServiceProvider"].ToString();
                    Session["ReferredToServiceProvider"] = null;
                }


                objNeedy.ReferredByOtherAgency = string.IsNullOrEmpty(txtRefByOther.Text.Trim()) ? null : txtRefByOther.Text.Trim();
                objNeedy.ReferredToOtherAgency = string.IsNullOrEmpty(txtRefToOther.Text.Trim()) ? null : txtRefToOther.Text.Trim();

                objNeedy.ReferredToOtherServiceProvider = string.IsNullOrEmpty(txtReferredToServiceProvider.Text.Trim()) ?
                    null : txtReferredToServiceProvider.Text.Trim(); // added By Kuldeep rathore on 05-12-2015

                objNeedy.Notes = AntiXssEncoder.HtmlEncode(string.IsNullOrEmpty(txtNotes.Text) ? null : txtNotes.Text, true);
                //objNeedy.Notes = string.IsNullOrEmpty(txtNotes.Text) ? null : txtNotes.Text;
                objNeedy.InfoRequested = string.IsNullOrEmpty(txtInfoReq.Text.Trim()) ? null : txtInfoReq.Text.Trim();

                // Modifed by GK on Feb09,2022 : Ticket #7935
                objNeedy.OtherNotes = !string.IsNullOrWhiteSpace(txtOtherNotes.Text) ? AntiXssEncoder.HtmlEncode(txtOtherNotes.Text.Trim(), true) : null;
                //objNeedy.OtherNotes = string.IsNullOrEmpty(txtOtherNotes.Text.Trim()) ? null : txtOtherNotes.Text.Trim();

                // Living Arrangment
                if (ddlLivingArrangement.SelectedIndex > 0)
                    objNeedy.LivingID = Convert.ToInt32(ddlLivingArrangement.SelectedValue);
                else
                    objNeedy.LivingID = null;
                // veteran applicable
                if (ddlVetApplicable.SelectedIndex > 0)
                    objNeedy.VeteranApplicable = ddlVetApplicable.SelectedItem.Text;
                else
                    objNeedy.VeteranApplicable = string.Empty;

                //Needy Contact Part 
                objNeedy.ContactDate = Convert.ToString(txtCDoC.Text);
                if (ddlContactType.SelectedIndex > 0)
                    objNeedy.ContactTypeID = Convert.ToInt32(ddlContactType.SelectedValue);
                //Contact Type Other
                if (ddlContactMethod.SelectedIndex > 0)
                    objNeedy.ContactMethodID = Convert.ToInt32(ddlContactMethod.SelectedValue);

                //if (ddlContactType.SelectedItem.Text.ToUpper() == "OTHER")
                if (IsContacTypeForReferringAgency)//For Professional, Other, Proxy and Family Type
                    objNeedy.ContactTypeOther = txtOtherContactType.Text.Trim();
                else
                    objNeedy.ContactTypeOther = string.Empty;

                //Contact Method Other
                if (ddlContactMethod.SelectedItem.Text.ToUpper() == "OTHER")
                    objNeedy.ContactMethodOther = txtOtherContactMethod.Text;                    
                else
                    objNeedy.ContactMethodOther = string.Empty;

                // set Info only
                objNeedy.IsInfoOnly = chkInfoOnly.Checked;
                objNeedy.IsADRC = chkADRC.Checked;
                if (!string.IsNullOrEmpty(txtCallDuration.Text))
                    objNeedy.CallDuration = txtCallDuration.Text;

                //StringBuilder sbServiceID = new StringBuilder();
                //for (int i = 0; i < lstServicesRequested.Items.Count; i++)
                //{
                //    if (sbServiceID.Length == 0)
                //        sbServiceID.Append(lstServicesRequested.Items[i].Value);
                //    else
                //        sbServiceID.Append("," + lstServicesRequested.Items[i].Value);
                //}

                objNeedy.ServiceRequested = hdnServReq.Value.ToString();
                // NK on 31 Oct 13
                if (hdnToDo.Value == "0")
                    objNeedy.IsToDo = false;
                if (hdnToDo.Value == "1")
                    objNeedy.IsToDo = true;
                else
                    objNeedy.IsToDo = false;

                //  Added by PA 3-April-2014
                //Purpose: Add 3)	Alternate Contact Info (under Person Needing Assistance tab)
                objNeedy.AltFirstName = txtAltFName.Text.Trim();
                objNeedy.AltMI = string.IsNullOrEmpty(txtAltMName.Text.Trim()) ? null : txtAltMName.Text.Trim();
                objNeedy.AltLastName = string.IsNullOrEmpty(txtAltLName.Text.Trim()) ? null : txtAltLName.Text.Trim();
                objNeedy.AltEmail = string.IsNullOrEmpty(txtAltEmailID.Text.Trim()) ? null : txtAltEmailID.Text.Trim();
                objNeedy.AltRelationship = string.IsNullOrEmpty(txtAltRelationShip.Text.Trim()) ? null : txtAltRelationShip.Text.Trim();
                objNeedy.FollowupCompleted = chkFollowupCompleted.Checked;
                objNeedy.FollowupNotes = AntiXssEncoder.HtmlEncode(txtFollowUpNotes.Text.Trim(), true);

                if (!string.IsNullOrEmpty(txtAltPhone.Text))
                    objNeedy.AltPhone = txtAltPhone.Text.Replace("-", "").Replace("(", "").Replace(")", "");

                objNeedy.AltPhoneExtn = string.IsNullOrEmpty(txtAltPhoneExtn.Text) ? null : txtAltPhoneExtn.Text;//Added By BS on 15-sep-2016

                if (!string.IsNullOrEmpty(txtNAltFax.Text))//Added By BS on 19-dec-2016
                    objNeedy.NAltFax = txtNAltFax.Text.Replace("-", "").Replace("(", "").Replace(")", "");

                if (!string.IsNullOrEmpty(txtFundProvided.Text))//Added By KR on 27 March 2017
                    objNeedy.FundsProvidedAmount = Convert.ToDecimal(txtFundProvided.Text);//Added By KR on 27 March 2017.
                else
                    objNeedy.FundsProvidedAmount = null;
                //Added By VK on 03 Aug 2017.
                if (chklistFundsUtilized.Items.Count > 0)
                {
                    for (int i = 0; i < chklistFundsUtilized.Items.Count; i++)
                    {
                        if (chklistFundsUtilized.Items[i].Selected)
                        {
                            hdnFundsUtilized.Value = Microsoft.Security.Application.Sanitizer.GetSafeHtmlFragment(hdnFundsUtilized.Value) + chklistFundsUtilized.Items[i].Value + ",";     //Modified by RK,01April2024,Task-ID: 24527,Purpose: Sanitization of data
                        }
                    }
                    objNeedy.FundsUtilizedIDs = hdnFundsUtilized.Value;
                }
                if (!string.IsNullOrEmpty(txtFundsUtilizedDate.Text))
                    objNeedy.FundsUtilizedDate = hdnFundsUtilizedDate.Value;
                else
                    objNeedy.FundsUtilizedDate = null;

                // Added by GK on 28June,2021 TicketID #2544
                if (!string.IsNullOrEmpty(txtFundsUtilizedForOther.Text))
                    objNeedy.FundsUtilizedForOther = txtFundsUtilizedForOther.Text;

                //---------------------- End of Needy Person Section------------------------------------

                //---------------------- Contact Person Section  ---------------------------------------
                PersonContact objPerson = new PersonContact();
                bool isSelfContactType = true;
                //Save contact person details only if contact type is not 'Self'
                if (ddlContactType.SelectedItem.Text.ToUpper() != "SELF" && Request.QueryString["IsNew"] == "1")
                {

                    isSelfContactType = false;
                    objPerson.FirstName = txtCFirstName.Text.Trim();
                    objPerson.MI = string.IsNullOrEmpty(txtCMI.Text.Trim()) ? null : txtCMI.Text.Trim();
                    objPerson.LastName = string.IsNullOrEmpty(txtCLastName.Text.Trim()) ? null : txtCLastName.Text.Trim();
                    objPerson.IsPrimaryContactPerson = chkIsPrimaryContactPesron.Checked;
                    if (!string.IsNullOrEmpty(txtCPhonePrimary.Text))
                        objPerson.PhonePrimary = txtCPhonePrimary.Text.Replace("-", "").Replace("(", "").Replace(")", "");
                    if (!string.IsNullOrEmpty(txtCPhoneAlt.Text))
                        objPerson.PhoneAlt = txtCPhoneAlt.Text.Replace("-", "").Replace("(", "").Replace(")", "");

                    objPerson.PhonePrimaryExtn = string.IsNullOrEmpty(txtcPhonePrimaryExtn.Text) ? null : txtcPhonePrimaryExtn.Text;//Added By BS on 15-sep-2016
                    objPerson.PhoneAltExtn = string.IsNullOrEmpty(txtCPhoneAltExtn.Text) ? null : txtCPhoneAltExtn.Text;//Added By BS on 15-sep-2016

                    if (!string.IsNullOrEmpty(txtCFax.Text))//Added By BS on 20-Dec-2016
                        objPerson.CFax = txtCFax.Text.Replace("-", "").Replace("(", "").Replace(")", "");

                    objPerson.Email = string.IsNullOrEmpty(txtCEmail.Text.Trim()) ? null : txtCEmail.Text.Trim();
                    objPerson.Address = string.IsNullOrEmpty(txtCAddress.Text.Trim()) ? null : txtCAddress.Text.Trim();

                    //Set city value
                    if (hdnIsTakeCPCityFromHidden.Value == "1")
                        objPerson.CityName = hdnCCity.Value;
                    else
                    {
                        if ((cmbCCity.SelectedIndex > 0 || cmbCCity.SelectedIndex != -1) && cmbCCity.SelectedItem.Text != "")
                        {
                            if (!cmbCCity.SelectedItem.Text.Contains("Select"))
                                objPerson.CityName = cmbCCity.SelectedItem.Text;
                        }
                    }

                    // Set county value
                    if (hdnIsTakeCPCountyFromHidden.Value == "1")
                        objPerson.CountyName = hdnCCounty.Value;
                    else
                    {
                        if ((cmbCCounty.SelectedIndex > 0 || cmbCCounty.SelectedIndex != -1) && cmbCCounty.SelectedItem.Text != "")
                        {
                            if (!cmbCCounty.SelectedItem.Text.Contains("Select"))
                                objPerson.CountyName = cmbCCounty.SelectedItem.Text;
                        }
                    }

                    objPerson.State = string.IsNullOrEmpty(txtCState.Text.Trim()) ? null : txtCState.Text.Trim();
                    objPerson.Zip = string.IsNullOrEmpty(txtCZip.Text.Trim()) ? null : txtCZip.Text.Trim();

                    objPerson.ContactPreferencePhone = chkCPhone.Checked;
                    objPerson.ContactPreferenceEmail = chkCEmail.Checked;
                    objPerson.ContactPreferenceSMS = ChkCSMS.Checked;
                    objPerson.ContactPreferenceMail = ChkCMail.Checked;

                    //Added By KR on  05/12/2015
                    objPerson.ContactPreferenceOthers = ChkContactPreferenceInPersonOther.Checked;
                    objPerson.ContactPreferenceOthersInPerson = string.IsNullOrEmpty(txtContactPreferenceInPersonOther.Text.Trim()) ? null : txtContactPreferenceInPersonOther.Text.Trim();

                    //Added ContactCaregiver BY VK on 03 Aug,2017.Comment 27 Sep,2017 Requirement change: not need this.  
                    //if (chkContactCaregiverYes.Checked == true)
                    //    objPerson.IsContactCaregiver = true;
                    //else if (chkContactCaregiverNo.Checked)
                    //    objPerson.IsContactCaregiver = false;
                    //else
                    //    objPerson.IsContactCaregiver = null;

                }


                //======== Save Contact Details and Pesron needing assistance details ==================================            
                bool isNewContact = false;

                //Modified by KP on 12th June 2020(SOW-577), Manage this block to work as proper with diffrent-2 contact type and contact person, 
                //either self,caregiver, select etc. is selected from contact type and/or not any contact person.
                if (Request.QueryString["IsNew"] == "0")
                {
                    objNeedy.NeedyPersonID = Convert.ToInt32(Request.QueryString["NdID"]);

                    if (ddlContactType.SelectedItem.Text.ToUpper() != "SELF")
                    {
                        isSelfContactType = false;
                        if (Session["ContactPersonID"] != null && !string.IsNullOrEmpty(Session["ContactPersonID"].ToString()))
                            objPerson.ContactPersonID = Convert.ToInt32(Session["ContactPersonID"]);

                        if (ddlContactPerson.SelectedValue == "-1" || ddlContactPerson.SelectedValue == "")
                        {
                            Session["ContactPersonID"] = null;
                            objPerson.ContactPersonID = null;
                        }
                        else
                        {
                            Session["ContactPersonID"] = ddlContactPerson.SelectedValue;
                            objPerson.ContactPersonID = Convert.ToInt32(ddlContactPerson.SelectedValue);

                        }
                    }
                    else
                    {
                        Session["ContactPersonID"] = null;
                        objPerson.ContactPersonID = null;
                    }
                }
                else
                {
                    isNewContact = true;

                    //Here, if contact type is other than self type and Contact person name(F/M/L) are blank 
                    //then set isSelfContactType = true to do not insert contact perion record into contact person table, 
                    //if Contact person name(F/M/L) are not blank then insert contact perion record into contact person table.
                    if (ddlContactType.SelectedItem.Text.ToUpper() != "SELF"
                        && string.IsNullOrWhiteSpace(txtCFirstName.Text.Trim() + txtCMI.Text.Trim() + txtCLastName.Text.Trim()))
                        isSelfContactType = true;
                }


                //**************************************************** Call function for Save records ***********************
                // set in value of session only if followup level call
                if (hdnFlwpSelected.Value == "1" || hdnUpdateCall.Value == "1")
                {
                    if (Request.QueryString["CLID"] != null)
                        Session["CurrentHistoryID"] = Convert.ToInt32(Request.QueryString["CLID"]);
                    else
                        Session["CurrentHistoryID"] = null;
                }

                objPerson.Relationship = string.IsNullOrEmpty(txtRelationship.Text) ? null : txtRelationship.Text;

                objNeedy.IsFundsProvided = chkFundProvided.Checked; //Added By KR on 27 March 2017.
                objNeedy.IsDemographics = !ChkNoDemographics.Checked; //Added by KP on 28-Sep-2017 - SOW-485             


                //Added by KP on 18th Dec 2019(SOW-577), To set Referring Agency detail's properties
                //-1 value of hdnSelectedRefDetailID is used for new entry of Referring Agency detail.
                objNeedy.RefAgencyDetailID = hdnSelectedRefDetailID.Value == "-1" ? 0 :
                                            ((hdnSelectedRefDetailID.Value == "" || hdnSelectedRefDetailID.Value == "0") ? Convert.ToInt32(Session["ReferringAgencyDetailID"] ?? 0) : Convert.ToInt32(hdnSelectedRefDetailID.Value));
                objNeedy.RefContactInfo = txtOtherContactType.Text.Trim();
                objNeedy.RefAgencyName = txtRefAgencyName.Text.Trim();
                objNeedy.RefContactName = txtRefContactName.Text.Trim();
                objNeedy.RefPhoneNumber = txtRefPhoneNumber.Text.Trim();
                objNeedy.RefEmail = txtRefEmailID.Text.Trim();
                objNeedy.IsContacTypeForReferringAgency = IsContacTypeForReferringAgency;

                //Added by KP on 28th Feb 2020(SOW-577), To set IsManualCallDuration properties of CallDuration
                objNeedy.IsManualCallDuration = Convert.ToBoolean(Session["IsManualCallDuration"] ?? false)
                                               || !string.IsNullOrEmpty(HidIsManualCallDuration.Value) && HidIsManualCallDuration.Value == "1" ? true : false;
                //end (SOW-577)


                // Save Needy and contact persons details 
                if (ADRCIABAL.SaveData(objNeedy, objPerson, isSelfContactType, isNewContact))
                {
                    BulkInsertToDataBase(Convert.ToInt32(Session["NeedyPersonID"]));
                    BulkInsertDoc(Convert.ToInt32(Session["NeedyPersonID"]));

                    //Added by KP on 5th Dec 2019(SOW-577), To display saved message at once(message was displaying multiple time on page refresh).                    
                    if (Request.QueryString["IsNew"] == "1")
                    {
                        Session["NeedySaved"] = "2";//2 is for new record is saved.
                        Session["NeedyFirstName"] = objNeedy.FirstName;
                        Session["NeedyLastName"] = objNeedy.LastName;
                    }
                    else
                        Session["NeedySaved"] = "1";//1 is for old record is updated/modified.
                                                    //end here 

                    objNeedy = null;
                    if (!isSaveAndClose)
                    {
                        //Modified by KP on 12th June 2020(SOW-577), Replace the Request.QueryString["CPID"] to (objPerson.ContactPersonID ?? 0).
                        if (hdnFlwpSelected.Value == "1" && hdnUpdateCall.Value == "0")
                            Response.Redirect("~/NeedyPerson.aspx?NdID=" + Session["NeedyPersonID"].ToString() + "&IsNew=0&Saved=1&FLWP=1&CPID=" + Microsoft.Security.Application.Sanitizer.GetSafeHtmlFragment((objPerson.ContactPersonID ?? 0).ToString()) + "&CLID=" + Microsoft.Security.Application.Sanitizer.GetSafeHtmlFragment(Request.QueryString["CLID"]) + "", true);  //Modified by RK,27March2024,Task-ID: 24527,Purpose: Sanitization of data                            
                        else if (hdnUpdateCall.Value == "1")
                            Response.Redirect("~/NeedyPerson.aspx?NdID=" + Session["NeedyPersonID"].ToString() + "&IsNew=0&Saved=1&CPID=" + Microsoft.Security.Application.Sanitizer.GetSafeHtmlFragment((objPerson.ContactPersonID ?? 0).ToString()) + "&CLID=" + Microsoft.Security.Application.Sanitizer.GetSafeHtmlFragment(Request.QueryString["CLID"]) + "&UC=1", true);  //Modified by RK,27March2024,Task-ID: 24527,Purpose: Sanitization of data                           
                        else
                            Response.Redirect("~/NeedyPerson.aspx?NdID=" + Session["NeedyPersonID"].ToString() + "&IsNew=0&Saved=1", true);//Added &CPID=" + Request.QueryString["CPID"]+" SA

                    }
                    else
                    {
                        // navigate to  osa admin search page   if user have osa Admin Page
                        if (MySession.blnADRCIAOSAAdmin)
                        {
                            // check  if followup selected
                            if (hdnUpdateCall.Value == "1")
                                Response.Redirect("~/admin/AdminNeedyPersonSearch.aspx?UC=1&Saved=1", true);
                            else
                                Response.Redirect("~/admin/AdminNeedyPersonSearch.aspx?UC=0&Saved=1", true);
                        }
                        else
                        {
                            // check  if followup selected
                            if (hdnUpdateCall.Value == "1")
                                Response.Redirect("~/NeedyPersonSearch.aspx?UC=1&Saved=1", true);
                            else
                                Response.Redirect("~/NeedyPersonSearch.aspx?UC=0&Saved=1", true);
                        }
                    }
                }
                else
                {
                    objPerson = null;
                    objNeedy = null;
                    System.Web.UI.ScriptManager.RegisterStartupScript(this, this.GetType(), "error", " ShowAlert('Person needing assistance not saved. Please try again.!','E')", true);//Added By BS on 6-Feb-2018 Task ID-10142

                }
                //*******************************************************************************************************************
            }
        }

        catch (Exception ex)
        {
            throw ex;
            //System.Web.UI.ScriptManager.RegisterStartupScript(this, this.GetType(), "error", " ShowAlert('Person needing assistance not saved. Please try again.!','e')", true);//Added By BS on 6-Feb-2018 Task ID-10142
        }

    }
    /// <summary>
    /// Created By: SM
    /// Date:03/11/2013
    /// Purpose: Display all  contact person list with respect to select person needing assistance in grid
    /// </summary>
    void BindContacPersontDetailsGird()
    {
        hdnExistsContactPID.Value = "-1";
        DataTable dtContact = ADRCIA.ADRCIADAL.GetContactDetails(Convert.ToInt32(Request.QueryString["NdID"]));

        //Added by AR, 10-April-2024 | T#24525 | Desanitization of Data
        foreach (DataRow row in dtContact.Rows)
        {
            foreach (DataColumn col in dtContact.Columns)
            {
                if(col.ColumnName == "FirstName" || col.ColumnName == "LastName"|| col.ColumnName == "Name")
                {
                    string decodedValue = HttpUtility.HtmlDecode(row[col].ToString());
                    row[col] = decodedValue;
                }                
            }
        }
        //END
        grdContactDetails.DataSource = dtContact;
        grdContactDetails.DataBind();


        //bind ContactPerson drop down 
        if (dtContact.Rows.Count > 0)
        {
            hdnContactPersonCount.Value = dtContact.Rows.Count.ToString();
            ddlContactPerson.Items.Clear();

            DataView objDV = new DataView(dtContact);
            objDV.RowFilter = "name <>''";
            ddlContactPerson.DataSource = objDV;
            ddlContactPerson.DataValueField = "ContactPersonDetailID";
            ddlContactPerson.DataTextField = "Name";
            ddlContactPerson.DataBind();
            ddlContactPerson.Items.Insert(0, new ListItem("--Select--", "-1"));

            hdnRelationshipValue.Value = "";
            foreach (DataRow row in dtContact.Rows)
            {

                hdnRelationshipValue.Value = hdnRelationshipValue.Value + HttpUtility.HtmlDecode(row["ContactPersonDetailID"].ToString()) + "," + HttpUtility.HtmlDecode(row["Relationship"].ToString()) + "|";      //Modified by AR, 10-April-2024 |T#24525 | Desanitization of Data

            }
            int index1 = hdnRelationshipValue.Value.LastIndexOf('|');
            if (index1 != -1)
            {

                hdnRelationshipValue.Value = hdnRelationshipValue.Value.Substring(0, index1);
            }

            ddlContactPerson.ClearSelection();
            if (Session["ContactPersonID"] != null)
            {
                try
                {

                    ddlContactPerson.Items.FindByValue(Session["ContactPersonID"].ToString()).Selected = true;

                    DataRow[] result = dtContact.Select("ContactPersonDetailID =" + ddlContactPerson.SelectedValue);
                    foreach (DataRow row in result)
                    {
                        lblRelationship.Text = row["Relationship"].ToString();

                    }

                }
                catch
                {
                    ddlContactPerson.Items.FindByValue("-1").Selected = true;
                    Session["ContactPersonID"] = null;
                }
            }
            else
                ddlContactPerson.Items.FindByText("--Select--").Selected = true;
        }

        else
        {
            hdnContactPersonCount.Value = "0";
            ddlContactPerson.Items.Clear();
            lblContactPerson.Attributes.Add("style", "display:none");
            ddlContactPerson.Attributes.Add("style", "display:none");
            // lblRelationLabel.Attributes.Add("style", "display:none");
            lblRelationship.Text = "";
            //Session["ContactPersonID"] = null; //Commented - SA 27th Jan, 2015.
        }

    }
    /// <summary>
    /// Created By: SM
    /// date:03/14/2013
    /// Purpose: Save newly added contact person details form Popup
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSaveContact_Click(object sender, EventArgs e)
    {
        try
        {
            //if (hdnIsStop.Value != "True")
            //{
            //Session["TimerLimit"] = hdnTimerLimit.Value;
            //}
            //else
            //{
            //    Session["TimerLimit"] = 0;
            //}
            AssignNeedyID();
            SetTimerSession(true);

            if (hdnAddcontact.Value == "True")
                ViewState["ContactPID"] = null;

            PersonContact objPerson = new PersonContact();
            if (ViewState["ContactPID"] != null)

                objPerson.ContactPersonID = Convert.ToInt32(ViewState["ContactPID"]);
            else
                objPerson.ContactPersonID = 0;

            objPerson.NeedyPersonID = Convert.ToInt32(Request.QueryString["NdID"].ToString());
            objPerson.IsPrimaryContactPerson = chkIsPrimaryContactPesron.Checked;
            objPerson.FirstName = txtCFirstName.Text.Trim();
            objPerson.MI = string.IsNullOrEmpty(txtCMI.Text.Trim()) ? null : txtCMI.Text.Trim();
            objPerson.LastName = string.IsNullOrEmpty(txtCLastName.Text) ? null : txtCLastName.Text;
            if (!string.IsNullOrEmpty(txtCPhonePrimary.Text))
                objPerson.PhonePrimary = txtCPhonePrimary.Text.Replace("-", "").Replace("(", "").Replace(")", "");

            objPerson.PhonePrimaryExtn = string.IsNullOrEmpty(txtcPhonePrimaryExtn.Text) ? null : txtcPhonePrimaryExtn.Text;//Added By BS on 15-sep-2016

            if (!string.IsNullOrEmpty(txtCPhoneAlt.Text))
                objPerson.PhoneAlt = txtCPhoneAlt.Text.Replace("-", "").Replace("(", "").Replace(")", "");

            objPerson.PhoneAltExtn = string.IsNullOrEmpty(txtCPhoneAltExtn.Text) ? null : txtCPhoneAltExtn.Text;//Added By BS on 15-sep-2016

            if (!string.IsNullOrEmpty(txtCFax.Text))
                objPerson.CFax = txtCFax.Text.Replace("-", "").Replace("(", "").Replace(")", "");//Added By BS on 19-Dec-2016

            objPerson.Email = string.IsNullOrEmpty(txtCEmail.Text.Trim()) ? null : txtCEmail.Text.Trim();
            objPerson.Address = string.IsNullOrEmpty(txtCAddress.Text.Trim()) ? null : txtCAddress.Text.Trim();
            // set Contact person City
            if (hdnIsTakeCPCityFromHidden.Value == "1")
                objPerson.CityName = hdnCCity.Value;
            else
            {
                if ((cmbCCity.SelectedIndex > 0 || cmbCCity.SelectedIndex != -1) && cmbCCity.SelectedItem.Text != "")
                {
                    if (!cmbCCity.SelectedItem.Text.Contains("Select"))
                        objPerson.CityName = cmbCCity.SelectedItem.Text;
                }
            }
            // set contact person county
            if (hdnIsTakeCPCountyFromHidden.Value == "1")
                objPerson.CountyName = hdnCCounty.Value;
            else
            {
                if ((cmbCCounty.SelectedIndex > 0 || cmbCCounty.SelectedIndex != -1) && cmbCCounty.SelectedItem.Text != "")
                {
                    if (!cmbCCounty.SelectedItem.Text.Contains("Select"))
                        objPerson.CountyName = cmbCCounty.SelectedItem.Text;
                }
            }

            objPerson.State = string.IsNullOrEmpty(txtCState.Text.Trim()) ? null : txtCState.Text.Trim();
            objPerson.Zip = string.IsNullOrEmpty(txtCZip.Text.Trim()) ? null : txtCZip.Text.Trim();

            objPerson.ContactPreferencePhone = chkCPhone.Checked;
            objPerson.ContactPreferenceEmail = chkCEmail.Checked;
            objPerson.ContactPreferenceSMS = ChkCSMS.Checked;
            objPerson.ContactPreferenceMail = ChkCMail.Checked;

            //Added By Kuldeep Rathore on  05/12/2015
            objPerson.ContactPreferenceOthers = ChkContactPreferenceInPersonOther.Checked;
            objPerson.ContactPreferenceOthersInPerson = string.IsNullOrEmpty(txtContactPreferenceInPersonOther.Text.Trim()) ? null : txtContactPreferenceInPersonOther.Text.Trim();

            //Added By VK on  03 Aug,2017.Comment 27 Sep,2017 Requirement change: not need this. 
            //if (chkContactCaregiverYes.Checked == true)
            //    objPerson.IsContactCaregiver = true;
            //else if (chkContactCaregiverNo.Checked)
            //    objPerson.IsContactCaregiver = false;
            //else
            //    objPerson.IsContactCaregiver = null;

            objPerson.Relationship = string.IsNullOrEmpty(txtRelationship.Text.Trim()) ? null : txtRelationship.Text.Trim();



            int ContactPersonID = ADRCIADAL.SaveContactPerson(objPerson);
            if (ContactPersonID > 0)
            {
                Session["ContactPersonID"] = ContactPersonID;
                BindContacPersontDetailsGird();

                //  ddlContactPerson.Items.FindByValue(ContactPersonID.ToString()).Selected = true;

                if (ddlContactType.SelectedItem.Text.ToUpper() == "SELF")
                {
                    lblContactPerson.Attributes.Add("style", "display:none");
                    ddlContactPerson.Attributes.Add("style", "display:none");
                    //reqPerson.Enabled = false;
                }
                else
                {
                    lblContactPerson.Attributes.Add("style", "display:inline");
                    ddlContactPerson.Attributes.Add("style", "display:inline");
                    // reqPerson.Enabled = true;
                }

                ScriptManager.RegisterStartupScript(this, this.GetType(), "saveCD", "ShowAlert('Contact person saved successfully.','S');", true);

                showHideDiv.Attributes.Add("class", "");


                divPopUpContent.Attributes.Add("class", "");
                divpnlContact.Attributes.Add("style", "display:none");
                rwContactSave.Attributes.Add("style", "display:none");


                divpopupHeading.Attributes.Add("style", "display:none");
                btnClose.Attributes.Add("style", "display:none");



                txtCFirstName.Text = string.Empty;
                txtCMI.Text = string.Empty;
                txtCLastName.Text = string.Empty;
                txtCPhonePrimary.Text = string.Empty;
                txtCAddress.Text = string.Empty;
                txtCZip.Text = string.Empty;
                txtCEmail.Text = string.Empty;
                txtCState.Text = "MI";
                chkIsPrimaryContactPesron.Checked = false;
                chkCPhone.Checked = false;
                chkCEmail.Checked = false;
                ChkCMail.Checked = false;
                ChkCSMS.Checked = false;
                txtcPhonePrimaryExtn.Text = string.Empty;
                txtCPhoneAltExtn.Text = string.Empty;
                cmbCCity.Items.FindByText("--Select--").Selected = true;
                cmbCCounty.Items.FindByText("--Select--").Selected = true;

                hyprAddContact.Attributes.Add("style", "display:block");

                ViewState["ContactPID"] = null;
                txtRelationship.Text = string.Empty;
                //Added By VK on  03 Aug,2017.
                //chkContactCaregiverYes.Checked = false;
                //chkContactCaregiverNo.Checked = false;
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }

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
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        List<PersonNeedAssistance> list = new List<PersonNeedAssistance>();
        DataTable dt = ADRCIA.ADRCIADAL.GetCallHistory(NeedyID);
        foreach (DataRow row in dt.Rows)
        {
            PersonNeedAssistance objNeedy = new PersonNeedAssistance();
            objNeedy.HistoryID = Convert.ToInt32(row["ContactHistoryID"]);
            objNeedy.PersonID = Convert.ToString(row["FKContactPersonDetailID"]);
            objNeedy.NeedyPersonID = NeedyID;
            //objNeedy.FirstName = Convert.ToString(row["Name"]);// Commented by SA on 20th Aug, 2015. SOW-379
            //Added by SA on 20th Aug, 2015. SOW-379
            objNeedy.FirstName = Convert.ToString(row["FirstName"]);
            objNeedy.LastName = Convert.ToString(row["LastName"]);
            //addition ends here
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

    /// <summary>
    /// Created By: SM
    /// Date:03/18/2013
    /// Perpose:get Person Id and Contact Id for newly Needy Person
    /// </summary>

    void GetPersonAndContactId()
    {
        lblPersonIdValue.Text = lblContactIdValue.Text = "---";//Added by KP on 5th Dec 2019(SOW-577), display default value when new person gonna add.

        //Commented by KP on 5th Dec 2019(SOW-577)
        //SqlDataReader objRdr = ADRCIADAL.GetPersonAndContactID();
        //if (objRdr.HasRows)
        //{
        //    objRdr.Read();
        //    lblPersonIdValue.Text = objRdr["NeedyPersonID"].ToString();
        //    objRdr.NextResult();
        //    objRdr.Read();
        //    lblContactIdValue.Text = objRdr["ContactID"].ToString();
        //}
        //objRdr.Dispose();
    }

    ///// <summary>
    ///// Created By: SM
    ///// Date:03/18/2013
    ///// Date: Get ADRC Agency list 
    ///// </summary>
    ///// <returns></returns>
    //[System.Web.Services.WebMethod(CacheDuration = 0)]
    //public static clsDDL[] GetADRCAgencyList()
    //{
    //    List<clsDDL> listADRCAgency = new List<clsDDL>();
    //    DataTable dt = ADRCIA.ADRCIADAL.GetADRCAgencyList();
    //    foreach (DataRow row in dt.Rows)
    //    {
    //        clsDDL objAgency = new clsDDL();
    //        objAgency.ValueField=row["ADRCSiteIDADRC"].ToString();
    //        objAgency.TextField = row["ADRCName1ADRC"].ToString();
    //        listADRCAgency.Add(objAgency);
    //    }
    //    return listADRCAgency.ToArray();
    //}


    protected void grdContactDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[1].Attributes.Add("style", "word-break:break-all;word-wrap:break-word");
            e.Row.Cells[2].Attributes.Add("style", "word-break:break-all;word-wrap:break-word");
            e.Row.Cells[3].Attributes.Add("style", "word-break:break-all;word-wrap:break-word");
            e.Row.Cells[4].Attributes.Add("style", "word-break:break-all;word-wrap:break-word");
            e.Row.Cells[5].Attributes.Add("style", "word-break:break-all;word-wrap:break-word");
            e.Row.Cells[6].Attributes.Add("style", "word-break:break-all;word-wrap:break-word");


            IsPrimary = Convert.ToBoolean(DataBinder.Eval(e.Row.DataItem, "IsPrimaryContactPerson"));
            //Relationship = Convert.ToBoolean(DataBinder.Eval(e.Row.DataItem, "Relationship"));

            Image imgPrimary = (Image)e.Row.FindControl("imgPrimary");
            // Checked for primary Person 
            if (IsPrimary)
            {  //if person if primary type then set checked mark with that person

                imgPrimary.ImageUrl = "~/images/saved.png";
                imgPrimary.ToolTip = "Primary Person";
                hdnExistsContactPID.Value = DataBinder.Eval(e.Row.DataItem, "ContactPersonDetailID").ToString();
            }
            else
            { //if person if other type then set  un checked mark with that person
                imgPrimary.ImageUrl = "~/images/blank.gif";
                imgPrimary.ToolTip = "";

            }
        }
        // create gridview header in <tHead> seection  show that jquery tablesorter can sort     
        if (this.grdContactDetails.Rows.Count > 0)
        {
            grdContactDetails.UseAccessibleHeader = true;
            grdContactDetails.HeaderRow.TableSection = TableRowSection.TableHeader;

        }
    }

    protected void btnSaveAndClose_Click(object sender, EventArgs e)
    {

        SaveRecord(true);
    }

    protected void grdContactDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        AssignNeedyID();
        //check command type
        if (e.CommandName == "rowedit")
        {   //  edit  contact person    

            hdnAddcontact.Value = "False";

            //showHideDiv.Attributes.Add("class", "main_popup");
            //divPopUpContent.Attributes.Add("class", "popup");
            //divpnlContact.Attributes.Add("style", "display:block;width:98.5%");//Added width:98.5% By BS on 27-sep-2016
            //rwContactSave.Attributes.Add("style", "display:block");
            //divpopupHeading.Attributes.Add("style", "display:block;width:99%");//Added width:99% By BS on 27-sep-2016
            //btnClose.Attributes.Add("style", "display:block");



            //// ScriptManager.reRegisterStartupScript(this.GetType(), "callCityCountyvalidate", "pagepostback();", true);

            //btnRowCommand.Attributes.Add("onclick", "gv1RowCommand('" + ID + "');"); 
            int iContactPID = Convert.ToInt32(e.CommandArgument);
            SqlDataReader Rdr = (SqlDataReader)ADRCIADAL.GetContactPersonDetailByPersonID(iContactPID);


            if (Rdr.HasRows)
            {
                Rdr.Read();

                chkIsPrimaryContactPesron.Checked = Convert.ToBoolean(Rdr["IsPrimaryContactPerson"]);
                txtCFirstName.Text = HttpUtility.HtmlDecode(Convert.ToString(Rdr["FirstName"])); //Modified by AR, 09-April-2024 | Desanitization of Data
                txtCMI.Text = HttpUtility.HtmlDecode(Convert.ToString(Rdr["MI"])); //Modified by AR, 09-April-2024 | Desanitization of Data
                txtCLastName.Text = HttpUtility.HtmlDecode(Convert.ToString(Rdr["LastName"])); //Modified by AR, 09-April-2024 | Desanitization of Data
                txtCPhonePrimary.Text = HttpUtility.HtmlDecode(Convert.ToString(Rdr["PhonePrimary"])); //Modified by AR, 09-April-2024 | Desanitization of Data
                txtCPhoneAlt.Text = Convert.ToString(Rdr["PhoneAlt"]);
                txtCEmail.Text = Convert.ToString(Rdr["Email"]);
                txtCAddress.Text = HttpUtility.HtmlDecode(Convert.ToString(Rdr["Address"])); //Modified by AR, 09-April-2024 | Desanitization of Data
                txtCEmail.Text = Convert.ToString(Rdr["Email"]);
                txtCState.Text = HttpUtility.HtmlDecode(Convert.ToString(Rdr["State"])); //Modified by AR, 09-April-2024 | Desanitization of Data
                txtCZip.Text = Convert.ToString(Rdr["Zip"]);
                chkCPhone.Checked = Convert.ToBoolean(Rdr["IsContactPreferencePhone"]);
                chkCEmail.Checked = Convert.ToBoolean(Rdr["IsContactPreferenceEmail"]);
                ChkCSMS.Checked = Convert.ToBoolean(Rdr["IsContactPreferenceSMS"]);
                ChkCMail.Checked = Convert.ToBoolean(Rdr["IsContactPreferenceMail"]);
                ChkContactPreferenceInPersonOther.Checked = Convert.ToBoolean(Rdr["IsContactPreferenceOther"]); // Added By: Kuldeep rathore, Date:05-12-2015
                txtContactPreferenceInPersonOther.Text = HttpUtility.HtmlDecode(Convert.ToString(Rdr["OtherInPersonContact"])); //Added By Kuldeep Rathore on 12th May, 2015  //Modified by AR, 09-April-2024 | Desanitization of Data
                txtcPhonePrimaryExtn.Text = Convert.ToString(Rdr["PhonePrimaryExtn"]);//Added By:BS on 14-sep-2016
                txtCPhoneAltExtn.Text = Convert.ToString(Rdr["PhoneAltExtn"]);//Added By:BS on 14-sep-2016
                txtCFax.Text = Convert.ToString(Rdr["Fax"]);//Added By:BS on 14-sep-2016
                //Added By VK on  03 Aug,2017.Comment 27 Sep,2017 Requirement change: not need this. 
                //chkContactCaregiverYes.Checked = false;
                //chkContactCaregiverNo.Checked = false;
                //if (Rdr["IsCaregiver"] != DBNull.Value)
                //{
                //    if (Convert.ToBoolean(Rdr["IsCaregiver"]) == true)
                //        chkContactCaregiverYes.Checked = true;
                //    else
                //        chkContactCaregiverNo.Checked = true;
                //}
                hdnCPID.Value = iContactPID.ToString();
                ViewState["ContactPID"] = iContactPID;

                txtRelationship.Text = HttpUtility.HtmlDecode(Convert.ToString(Rdr["Relationship"])); //Modified by AR, 09-April-2024 | Desanitization of Data


                try
                {
                    cmbCCity.ClearSelection();//added by SA on 12th June, 2015. SOW-362
                    if (Convert.ToString(Rdr["CityName"]).Trim() != "")
                    {
                        TextBox txtcmbCCity = (TextBox)cmbCCity.FindControl("cmbCCity_TextBox");
                        if (txtcmbCCity != null)
                            txtcmbCCity.Text = Convert.ToString(Rdr["CityName"]).Trim();


                        cmbCCity.Items.FindByText(Convert.ToString(Rdr["CityName"])).Selected = true;
                    }
                    else
                        cmbCCity.Items.FindByText("--Select--").Selected = true;

                }
                catch
                {
                    cmbCCity.Items.Insert(cmbCCity.Items.Count, Convert.ToString(Rdr["CityName"]));

                    cmbCCity.Items.FindByText(Convert.ToString(Rdr["CityName"])).Selected = true;

                }

                try
                {
                    cmbCCounty.ClearSelection();//added by SA on 12th June, 2015. SOW-362
                    if (Convert.ToString(Rdr["CountyName"]).Trim() != "")
                    {
                        TextBox txtcmbCCounty = (TextBox)cmbCCounty.FindControl("cmbCCounty_TextBox");
                        if (txtcmbCCounty != null)
                            txtcmbCCounty.Text = Convert.ToString(Rdr["CountyName"]).Trim();

                        cmbCCounty.Items.FindByText(Convert.ToString(Rdr["CountyName"])).Selected = true;
                    }
                    else
                        cmbCCounty.Items.FindByText("--Select--").Selected = true;
                }
                catch
                {
                    cmbCCounty.Items.Insert(cmbCCounty.Items.Count, Convert.ToString(Rdr["CountyName"]));
                    cmbCCounty.Items.FindByText(Convert.ToString(Rdr["CountyName"])).Selected = true;
                }
            }
            Rdr.Dispose();
            ScriptManager.RegisterStartupScript(Page, typeof(Page), "Script", "openContactPopup();InputValidationPostback();", true);
        }
        else if (e.CommandName == "rowdelete")
        {
            // delete contact person
            int iContactPID = Convert.ToInt32(e.CommandArgument);
            
            if (ADRCIADAL.DeleteContactPerson(iContactPID) > 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "deleteCP", "ShowAlert('Contact person deleted successfully.','S');", true);

                showHideDiv.Attributes.Add("class", "");


                divPopUpContent.Attributes.Add("class", "");
                divpnlContact.Attributes.Add("style", "display:none");
                rwContactSave.Attributes.Add("style", "display:none");


                divpopupHeading.Attributes.Add("style", "display:none");
                btnClose.Attributes.Add("style", "display:none");

                if (Session["ContactPersonID"] != null)
                {
                    if (Convert.ToInt32(Session["ContactPersonID"]) == iContactPID)
                    {
                        Session["ContactPersonID"] = null;
                    }

                }
                BindContacPersontDetailsGird();

                lblContactPerson.Attributes.Add("style", "display:none");
                ddlContactPerson.Attributes.Add("style", "display:none");
                lblRelationship.Attributes.Add("style", "display:none");

                if (Convert.ToInt16(hdnContactPersonCount.Value) > 0)
                {
                    if (ddlContactType.SelectedItem.Text.ToUpper() != "SELF")
                    {
                        ddlContactPerson.ClearSelection();
                        ddlContactPerson.Items.FindByText("--Select--").Selected = true;
                        lblContactPerson.Attributes.Add("style", "display:inline");
                        ddlContactPerson.Attributes.Add("style", "display:inline");
                    }
                }
            }
            else
                ScriptManager.RegisterStartupScript(this, GetType(), "deleteCPfail", "ShowAlert('Contact person not deleted.');", true);


        }

        if (grdContactDetails.Rows.Count > 0)
        {  // create gridview header in <tHead> seection  show that jquery tablesorter can sort after partial post back   
            grdContactDetails.UseAccessibleHeader = true;
            grdContactDetails.HeaderRow.TableSection = TableRowSection.TableHeader;
        }


        hyprAddContact.Attributes.Add("style", "display:block");
        
    }


    protected void grdContactDetails_RowEditing(object sender, GridViewEditEventArgs e)
    {

    }

    [System.Web.Services.WebMethod(CacheDuration = 0)]
    public static PersonNeedAssistance[] GetCallHistoryDetails(int HistoryID, int NeedyID)
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        List<PersonNeedAssistance> list = new List<PersonNeedAssistance>();
        DataTable dt = ADRCIA.ADRCIADAL.GetCallHistoryDetails(HistoryID, NeedyID);
        foreach (DataRow row in dt.Rows)
        {
            PersonNeedAssistance objNeedy = new PersonNeedAssistance();
            objNeedy.HistoryID = Convert.ToInt32(row["ContactHistoryID"]);

            //--commented and added by SA on 20th Aug, 2015
            //objNeedy.FirstName = Convert.ToString(row["Name"]);
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


    /// <summary>
    /// Created BY: SM
    /// Date:07/22/2013
    /// Purpose:Set Attributes to contol of this page.
    /// </summary>
    /// <param name="parent"></param>
    private void SetAttributesToControl(Control parent)
    {

        foreach (Control c in parent.Controls)
        {
            if (c is TextBox)
            {
                //Added By VK on  03 Aug,2017.
                if (c.ID == "txtFundsUtilizedDate")
                {
                    ((TextBox)c).Attributes.Add("onchange", "CheckControlValueChange(); ValidateFundsUtilizedDate(this)");
                }
                if (c.ID == "txtNDOB")
                {
                    ((TextBox)c).Attributes.Add("onchange", "CheckControlValueChange();");//ValidateNeedyDOBDate(this)
                    ((TextBox)c).Attributes.Add("onkeyup", "DisableAgeOrDOBControl('DOB');");
                }
                if (c.ID == "txtNAge")
                {
                    ((TextBox)c).Attributes.Add("onchange", "CheckControlValueChange();");
                    ((TextBox)c).Attributes.Add("onkeyup", "DisableAgeOrDOBControl('AGE');");
                }
                //else
                //{
                //    ((TextBox)c).Attributes.Add("onchange", "CheckControlValueChange();");
                //}

            }

            if (c is CheckBox)
            {
                ((CheckBox)c).Attributes.Add("OnClick", "CheckControlValueChange();");
            }

            if (c is DropDownList)
            {
                if (c.ID == "ddlContactType")
                    ((DropDownList)c).Attributes.Add("onChange", "CheckControlValueChange();ShowHideContactDetails(this);");
                else
                    ((DropDownList)c).Attributes.Add("onChange", "CheckControlValueChange();");
            }
            if (c is AjaxControlToolkit.ComboBox)
            {
                ((AjaxControlToolkit.ComboBox)c).Attributes.Add("SelectedIndexChanged", "CheckControlValueChange();");
            }

            if (c.Controls.Count > 0)
            {
                SetAttributesToControl(c);
            }
        }
    }





    protected void ddlMaritalStatus_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void ddlRace_SelectedIndexChanged(object sender, EventArgs e)
    {

    }


    /// <summary>
    /// Created By: SM
    /// Date:08/22/2013
    /// Purpose: Get City county by zip code
    /// </summary>
    /// <param name="strZipCode"></param>
    /// <returns></returns>

    [System.Web.Services.WebMethod(CacheDuration = 0)]
    public static List<string> GetCityCountyByZip(string strZipCode)
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        DataTable dtlist = new DataTable();
        //check for input text length
        if (strZipCode.Length > 0)
            dtlist = ADRCIADAL.GetCityCountyByZip(strZipCode);

        List<string> list = new List<string>();

        foreach (DataRow row in dtlist.Rows)
        {
            list.Add(row["zipcitycounty"].ToString());
        }
        return list;
    }

    [System.Web.Services.WebMethod(CacheDuration = 0)]
    public static clsFollowupReminderList[] GetFollowupList(string callHistoryID)
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        DataTable dtlist = new DataTable();
        //check for input text length
        List<clsFollowupReminderList> list = new List<clsFollowupReminderList>();


        DataTable dt = ADRCIADAL.GeFollowupList(Convert.ToInt32(callHistoryID));
        foreach (DataRow row in dt.Rows)
        {
            clsFollowupReminderList objFolloup = new clsFollowupReminderList();
            objFolloup.FollowupID = Convert.ToInt32(row["FKContactHistoryID"]);
            objFolloup.CallHistoryID = Convert.ToInt32(row["FKContactHistoryID"]);
            objFolloup.ContactDateTime = Convert.ToString(row["ContactDateTime"]);
            objFolloup.CallDuration = Convert.ToString(row["CallDurationMin"]);
            objFolloup.FollowupCreatedBy = Convert.ToString(row["CreatedBy"]);
            list.Add(objFolloup);
        }
        return list.ToArray();

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

    // NK on 31 Oct 13
    [System.Web.Services.WebMethod(CacheDuration = 0)]
    public static bool CheckDuplicateNeedy(string strFName, string strLName, int NeedyID)
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return false; 

        return ADRCIA.ADRCIADAL.CheckDuplicateNeedy(strFName.Trim(), strLName.Trim(), NeedyID);

    }
    /// <summary>
    /// Created BY: SM
    /// Date:12/23/2013
    /// Purpose: Convert Time in to Second.
    /// </summary>
    /// <param name="strCallDuration">Must be in HH:MM:SS</param>
    /// <returns>Time duration in Second</returns>
    private string ConvertTimeToSecond(string strCallDuration)
    {
        string[] strTimer = strCallDuration.Split(':');
        int iTotalHrsInSecond = 0, iTotalMinutsInSecond = 0;
        iTotalHrsInSecond = Convert.ToInt32(strTimer[0]) * 3600;
        iTotalMinutsInSecond = Convert.ToInt32(strTimer[1]) * 60;
        return (Convert.ToInt32(strTimer[2]) + iTotalMinutsInSecond + iTotalHrsInSecond).ToString();// return to  time in second
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        if (MySession.blnADRCIAOSAAdmin)
            Response.Redirect("~/admin/AdminNeedyPersonSearch.aspx?UC=0", true);
        else
            Response.Redirect("~/NeedyPersonSearch.aspx?UC=0", true);

    }


    /// <summary>
    /// Created By: SM
    /// Date: 07 April 2014
    /// Purpose: get Agency List 
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod(CacheDuration = 0)]
    public static string GetServiceProviderAgency(string strServiceId)
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        DataTable dtlist = ADRCIADAL.GetServiceProviderAgency(strServiceId);
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



    //private static MailMessage CreateMail(string from,
    //    string to,
    //    string subject,
    //    string body,
    //    string attname,
    //    Stream tableStream)
    //{
    //    // using System.Net.Mail
    //    var mailMsg = new MailMessage(from, to, subject, body);

    //    tableStream.Position = 0;
    //    mailMsg.Attachments.Add(
    //        new Attachment(tableStream, attname, CsvContentType));
    //    return mailMsg;
    //}

    //private const string CsvContentType = "application/excel";


    //[System.Web.Services.WebMethod(CacheDuration = 0)]
    //public static void SendEmailWithAttachment(string strEmailTo, string strSubject,string strBody, string ServiceID)
    //{
    //    DataTable dtlist = ADRCIADAL.GetServiceProviderAgency(ServiceID);
    //    string name = "Report.xls";
    //    var stream = ADRCIA.ADRCIABAL.DataTableToStream(dtlist);
    //    dtlist.Dispose();

    //    var mailMsg = CreateMail(System.Configuration.ConfigurationManager.AppSettings["EmailFromID"],
    //       strEmailTo,
    //       strSubject,
    //       strBody,  
    //        name,
    //        stream);

    //     //send the mailMsg with SmtpClient (config in your web.config)
    //    var smtp = new SmtpClient(System.Configuration.ConfigurationManager.AppSettings["SMTPClient"]);
    //    smtp.Send(mailMsg);
    //}





    protected void btnPrintPage_Click(object sender, EventArgs e)
    {

        if (Convert.ToInt16(IsNew) == 1)
            ScriptManager.RegisterStartupScript(this, GetType(), "savefirst", "ShowAlert('Please save record first then proceed for print.');", true);
        else
        {
            using (CrystalDecisions.CrystalReports.Engine.ReportDocument Report = new CrystalDecisions.CrystalReports.Engine.ReportDocument())
            {
                ReportSettings.SetParametersForExport(Report).ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "PersonNeedingAssistance");
            }
        }
    }
    /// <summary>
    /// Added by SA on 10-11-2014. SOW-335.
    /// Purpose: Get reffered to.
    /// </summary>
    /// <returns></returns>
    [WebMethod(CacheDuration = 0)]
    public static string GetRefferedTo()
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        DataTable ds = ADRCIA.ADRCIADAL.GetAAACILAgency();//ADRCIADAL.GetADRCAgencyList();
        return GetJson(ds);

        //ADRCIA.ADRCIADAL.GetAAACILAgency();
        //ddlRefBy.DataValueField = "AAACILSiteID";
        //ddlRefBy.DataTextField = "AAACILSiteName";

    }
    /// <summary>
    /// Added by SA on 19-11-2014. SOW-335.
    /// Purpose: Get OC Triggers
    /// </summary>
    /// <returns></returns>
    [WebMethod(CacheDuration = 0)]
    public static string getOCTriggers()
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        DataSet ds = ADRCIADAL.GetCommonData();
        return GetJson(ds.Tables[7]);
    }
    /// <summary>
    /// Created by SA. SOW-335
    /// Purpose: Assign checked OC Trigger values in session.
    /// </summary>
    /// <param name="Trigger"></param>
    [WebMethod]
    public static void getMultiSelectionValues(PersonNeedAssistance MultiValues)
    {
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return;

        HttpContext.Current.Session["TriggerValues"] = MultiValues.OCTriggers;
        HttpContext.Current.Session["RefToADRCIDs"] = MultiValues.getRefToADRCIDs;
        HttpContext.Current.Session["ReferredToServiceProvider"] = MultiValues.ReferredToServiceProvider;
        HttpContext.Current.Session["InsuranceTypes"] = MultiValues.InsuranceTypes;
    }
    /// <summary>
    /// Created by SA on 24-11-2014. SOW-335
    /// Purpose: Bind Referred to service providers.
    /// </summary>
    /// <returns></returns>
    [WebMethod]
    public static string getReferredToServiceProvider()
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        DataTable dt = ADRCIADAL.GetServiceProvider();
        return GetJson(dt);
    }
    void BindTimeSpent(int? NeedyPersonID = null)
    {
        DataTable dt = ADRCIADAL.getTimeSpent(NeedyPersonID);

        if (((DataTable)ViewState["TimeSpent"]).Rows.Count > 0)
        {
            dt = (DataTable)ViewState["TimeSpent"];
        }
        else
            if (dt.Rows.Count > 0)
            ViewState["TimeSpent"] = dt;

        lstViewTimeSpent.DataSource = dt;
        lstViewTimeSpent.DataBind();
    }
    protected void lstViewTimeSpent_ItemCommand(object sender, ListViewCommandEventArgs e)
    {

        try
        {
            if (e.CommandName == "Insert")
            {

                TextBox txtTravelDate = (TextBox)e.Item.FindControl("txtTravelDate");
                TextBox txtTravelTime = (TextBox)e.Item.FindControl("txtTravelTime");
                TextBox txtReason = (TextBox)e.Item.FindControl("txtReason");

                AddNewRecordTimeSpent(txtTravelDate.Text, txtTravelTime.Text != "" ? (int?)Convert.ToInt32(txtTravelTime.Text) : null, txtReason.Text.Trim());

                if (Request.QueryString["NdID"] != "0")
                {
                    //Commented by SA on 19th May, 2015. SOW-362
                    //BulkInsertToDataBase(Convert.ToInt32(Request.QueryString["NdID"]));
                    //BindTimeSpent(Convert.ToInt32(Request.QueryString["NdID"]));

                    NeedyID = Convert.ToString(Request.QueryString["NdID"]);
                }
                // ScriptManager.RegisterClientScriptBlock(this.Page, GetType(), "Scriptload", "javascript:CallMultiFunctions();", true);

            }
        }
        catch
        { }
    }
    protected void btnUpload_Click(object sender, EventArgs e)
    {

        try
        {
            if (txtDescription.Text == string.Empty)
            { lblDecsription.Text = "Please enter document description."; return; }
            if (FUDocuments.HasFile)
            {
                if (!ValidateSize(FUDocuments.PostedFile.ContentLength))
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, GetType(), "MaxSize", "ShowAlert('You can not upload files more than 6 MB of size.');", true);
                }
                else
                {
                    if (ValidateFile())
                    {
                        //string extension = Path.GetExtension(FUDocuments.PostedFile.FileName);
                        string UpFileName = Path.GetFileName(FUDocuments.PostedFile.FileName);
                        if (FiliPathValidation.IsValidFilename(Path.GetFileName(UpFileName)))    //Added by AP on March 27, 2024, regarding Ticket #24572 to handle the path traversal issue.
                        {
                            string extension = Path.GetExtension(FUDocuments.PostedFile.FileName);
                            //string UpFileName = Path.GetFileName(FUDocuments.PostedFile.FileName);
                            if (FiliPathValidation.IsValidPath(Path.GetFileName(UpFileName))) {  //Added by AP on March 27, 2024, regarding Ticket #24572 to handle the path traversal issue.
                                string[] NameNExt = UpFileName.Split('.');
                                string GUID = Guid.NewGuid().ToString();
                                AddDocs(txtDescription.Text.Trim(), NameNExt[0], extension, GUID);

                                string GUfileName = GUID + extension;
                                FUDocuments.PostedFile.SaveAs(Server.MapPath("~/Documents/") + GUfileName);

                                if (Request.QueryString["NdID"] != "0")
                                {
                                    BulkInsertDoc(Convert.ToInt32(Request.QueryString["NdID"]));
                                    BindDocuments(Convert.ToInt32(Request.QueryString["NdID"]));

                                    NeedyID = Convert.ToString(Request.QueryString["NdID"]);
                                }
                                txtDescription.Text = string.Empty;
                                lblMessage.Text = "File uploaded successfully.";
                            }
                        }

                    }
                }
            }
            else
            {
                lblUploadDoc.Text = "Please select document to upload.";
            }
        }
        catch (Exception ex)
        { }
    }
    private bool ValidateSize(int TotalattachFileSize)
    {

        bool ValidSize = true;
        int FileMaxSize = Convert.ToInt32(ConfigurationManager.AppSettings["FileUploadSizeLimit"].ToString());

        if (TotalattachFileSize > FileMaxSize)
        {
            ValidSize = false;
        }

        return ValidSize;
    }
    protected void gvDocuments_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int index = e.RowIndex;
        string GUID = gvDocuments.DataKeys[e.RowIndex].Value.ToString();
        if (Request.QueryString["NdID"] == "0")
        {
            DataTable dt = (DataTable)ViewState["tblNeedyPersonDocs"];
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (dt.Rows[i]["FileFuid"].ToString() == GUID)
                {
                    dt.Rows[i].Delete();
                    dt.AcceptChanges();
                }
            }
            ViewState["tblNeedyPersonDocs"] = dt;
            gvDocuments.DataSource = dt;
            gvDocuments.DataBind();
        }

        if (Request.QueryString["NdID"] != "0")
        {
            ADRCIADAL.DeleteNeedypersonDocsDetails(GUID);
            BindDocuments(Convert.ToInt32(Request.QueryString["NdID"]));
            NeedyID = Convert.ToString(Request.QueryString["NdID"]);
        }
    }
    void BindDocuments(int? NeedyPersonID = null)
    {
        DataTable dt = ADRCIADAL.GetNeedypersonDocsDetails(NeedyPersonID);
        gvDocuments.DataSource = dt;
        gvDocuments.DataBind();
    }
    protected void gvDocuments_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.RowState == DataControlRowState.Normal || e.Row.RowState == DataControlRowState.Alternate)
            {
                ImageButton Delete = (ImageButton)e.Row.Cells[4].FindControl("lnkDelete");
                Delete.Attributes.Add("onclick", "return ConfirmOnDelete();");

                HtmlAnchor hypFilename = (HtmlAnchor)e.Row.FindControl("hypFilename");
                HiddenField HFExtension = (HiddenField)e.Row.FindControl("HFExtension");
                string GUID = gvDocuments.DataKeys[e.Row.RowIndex].Value.ToString();
                string path = Page.ResolveClientUrl("~/Documents/" + GUID + HFExtension.Value.ToLower());

                hypFilename.Attributes.Add("onclick", "OpenDocumentPopup('" + path + "');");

                Image imgFiletype = (Image)e.Row.FindControl("imgFiletype");

                switch (HFExtension.Value.ToLower())
                {
                    case (".doc"):
                    case (".docx"):
                    case (".rtf"):
                        {
                            imgFiletype.ImageUrl = "~/images/doc32.gif";
                            break;
                        }
                    case (".pdf"):
                        {
                            imgFiletype.ImageUrl = "~/images/pdf32.gif";
                            break;
                        }
                    case (".txt"):
                        {
                            imgFiletype.ImageUrl = "~/images/txt32.gif";
                            break;
                        }
                    case (".xls"):
                    case (".csv"):
                    case (".xlsx"):
                        {
                            imgFiletype.ImageUrl = "~/images/xls32.gif";
                            break;
                        }
                    case (".gif"):
                    case (".jpg"):
                    case (".jpeg"):
                    case (".png"):
                    case (".bmp"):
                        {
                            imgFiletype.ImageUrl = "~/images/Img.png";
                            break;
                        }
                    default:
                        imgFiletype.ImageUrl = "~/images/default.gif";
                        break;

                }
            }
        }
    }
    protected void lstViewTimeSpent_ItemInserting(object sender, ListViewInsertEventArgs e)
    {

    }
    private void AddNewRecordTimeSpent(string TravelDate, int? TravelTime, string TimeSpentReason)
    {
        if (Request.QueryString["NdID"] != "0" && ViewState["TimeSpent"] == null)
            AddDefaultFirstRecordTimeSpent();
        if (ViewState["TimeSpent"] != null)
        {

            DataTable dtCurrentTable = (DataTable)ViewState["TimeSpent"];


            DataRow drCurrentRow = null;
            //if (Request.QueryString["NdID"] == "0")// Commented by SA on 9th June, 2015.
            //{
            if (dtCurrentTable.Rows.Count == 0)
            {
                drCurrentRow = dtCurrentTable.NewRow();
                dtCurrentTable.Rows.Add(drCurrentRow);
            }
            //}

            if (dtCurrentTable.Rows.Count > 0)
            {

                for (int i = 1; i <= dtCurrentTable.Rows.Count; i++)
                {

                    //Creating new row and assigning values  
                    drCurrentRow = dtCurrentTable.NewRow();
                    drCurrentRow["TravelDate"] = TravelDate;
                    if (TravelTime != null)
                        drCurrentRow["TravelTime"] = TravelTime;
                    else
                        drCurrentRow["TravelTime"] = DBNull.Value;

                    drCurrentRow["FKNeedyPersonID"] = DBNull.Value;

                    if (TimeSpentReason.Length > 500)
                        TimeSpentReason = TimeSpentReason.Substring(0, 500);

                    drCurrentRow["TimeSpentReason"] = TimeSpentReason;

                    //Common
                    drCurrentRow["GUID"] = Guid.NewGuid().ToString();
                    //if (Request.QueryString["NdID"] == "0")
                    //{
                    //    drCurrentRow["GUID"] = Guid.NewGuid().ToString();
                    //}
                    //else
                    //    drCurrentRow["IsDeleted"] = DBNull.Value;//Temp Added
                    if (Request.QueryString["NdID"] != "0")
                        drCurrentRow["IsDeleted"] = true;//to delete temp rows in the list. its a check only from database as from DB it is always false.

                    drCurrentRow["Time"] = DateTime.Now.TimeOfDay.ToString();

                }
                //Removing initial blank row  
                if (dtCurrentTable.Rows[0][0].ToString() == "")
                {
                    dtCurrentTable.Rows[0].Delete();
                    dtCurrentTable.AcceptChanges();
                }

                //Added New Record to the DataTable  
                dtCurrentTable.Rows.Add(drCurrentRow);
                //storing DataTable to ViewState
                DataView dv = dtCurrentTable.DefaultView;
                dv.Sort = "Time desc";
                DataTable revData = dv.ToTable();
                ViewState["TimeSpent"] = revData;
                //binding Gridview with New Row  
                lstViewTimeSpent.DataSource = revData;
                lstViewTimeSpent.DataBind();

                // Added by SA on 12th June.
                //Purpose to count newly added rows.                
                if (ViewState["TimeSpent"] != null)
                {
                    if (dtCurrentTable.Rows[0][0].ToString() != "")
                    {
                        if (((DataTable)ViewState["TimeSpent"]).Rows.Count > 0)
                        {
                            if (Request.QueryString["NdID"] != "0")
                                numberOfRecords = ((DataTable)ViewState["TimeSpent"]).AsEnumerable().Where(r => r.Field<bool>("IsDeleted") == true).CopyToDataTable().Rows.Count;
                            else
                                numberOfRecords = ((DataTable)ViewState["TimeSpent"]).Rows.Count;
                        }
                    }
                }
                if (numberOfRecords > 0)
                    msgTimeSpent.Visible = true;

                //Added By Kuldeep Rathore on  21th May, 2015 
                if (Request.QueryString["UC"] == "1")
                {


                    lblmsgdesc.Text = @"Time Spent record has been added/updated in the temporary list, please click on 'Update & Close' or 'Update' button to save the records in database.";
                }
                else if (Request.QueryString["IsNew"] == "1")
                {

                    lblmsgdesc.Text = @"Time Spent record has been added/updated in the temporary list, please click on 'Save & Close' or 'Save' button to save the records in database.";
                }
                else if (Request.QueryString["UC"] == "0" && Request.QueryString["IsNew"] == "0")
                {

                    lblmsgdesc.Text = @"Time Spent record has been added/updated in the temporary list, please click on 'Save & Close' or 'Save' button to save the records in database.";
                }
                else
                    lblmsgdesc.Text = @"Time Spent record has been added/updated in the temporary list, please click on 'Update & Close' or 'Update' button to save the records in database.";
            }
        }
    }
    private void AddDefaultFirstRecordTimeSpent()
    {
        //creating DataTable  
        DataTable dt = new DataTable();
        DataRow dr;
        dt.TableName = "TimeSpent";
        //creating columns for DataTable  

        dt.Columns.Add(new DataColumn("TravelDate", typeof(string)));
        dt.Columns.Add(new DataColumn("TravelTime", typeof(int)));
        dt.Columns.Add(new DataColumn("FKNeedyPersonID", typeof(int)));
        dt.Columns.Add(new DataColumn("TimeSpentReason", typeof(string)));
        dt.Columns.Add(new DataColumn("TimeSpentID", typeof(int)));
        dt.Columns.Add(new DataColumn("Time", typeof(string)));
        dt.Columns.Add(new DataColumn("GUID", typeof(string)));
        if (Request.QueryString["NdID"] == "0")
        {
            lstViewTimeSpent.DataKeyNames = new string[] { "TimeSpentID", "GUID" };

        }
        else//Temp Editing.
        {
            lstViewTimeSpent.DataKeyNames = new string[] { "TimeSpentID", "IsDeleted", "GUID" };
            dt.Columns.Add(new DataColumn("IsDeleted", typeof(bool)));
        }

        dr = dt.NewRow();
        dt.Rows.Add(dr);

        //if (Request.QueryString["NdID"] == "0")
        //{
        if (dt.Rows[0][0].ToString() == "" && dt.Rows.Count == 1)
        {
            dt.Rows[0].Delete();
            dt.AcceptChanges();
        }
        //}

        ViewState["TimeSpent"] = dt;
        lstViewTimeSpent.DataSource = dt;
        lstViewTimeSpent.DataBind();
    }
    void AddDocs(string FileDescription, string FileName, string FileExtension, string GUID)
    {
        DataTable dt = new DataTable();
        DataRow dr = null;
        dt.TableName = "tblNeedyPersonDocs";
        //creating columns for DataTable  
        dt.Columns.Add(new DataColumn("FileFuid", typeof(string)));
        dt.Columns.Add(new DataColumn("FKSiteID", typeof(int)));
        dt.Columns.Add(new DataColumn("FKNeedyPersonID", typeof(int)));
        dt.Columns.Add(new DataColumn("FilesName", typeof(string)));
        dt.Columns.Add(new DataColumn("FileDescription", typeof(string)));
        dt.Columns.Add(new DataColumn("FileExtension", typeof(string)));
        dt.Columns.Add(new DataColumn("CreatedBy", typeof(string)));


        if (Request.QueryString["NdID"] != "0")
        {
            ViewState["tblNeedyPersonDocs"] = null;
        }

        if (ViewState["tblNeedyPersonDocs"] != null)
            dt = (DataTable)ViewState["tblNeedyPersonDocs"];

        if (FileDescription.Length > 255)
            FileDescription = FileDescription.Substring(0, 255);

        if (dt.Rows.Count == 0)
        {
            dr = dt.NewRow();
            dr["FileFuid"] = GUID;
            //dr["FKSiteID"] = MySession.SiteId;
            dr["FKSiteID"] = Session["CurrentSiteId"].ToString(); // Added by GK on 26July18
            dr["FKNeedyPersonID"] = DBNull.Value;
            dr["FilesName"] = FileName;
            dr["FileDescription"] = FileDescription.TrimEnd();
            dr["FileExtension"] = FileExtension;
            dr["CreatedBy"] = MySession.strUserName;
        }
        else
        {
            for (int i = 1; i <= dt.Rows.Count; i++)
            {
                dr = dt.NewRow();
                dr["FileFuid"] = GUID;
                //dr["FKSiteID"] = MySession.SiteId;
                dr["FKSiteID"] = Session["CurrentSiteId"].ToString(); // Added by GK on 26July18
                dr["FKNeedyPersonID"] = DBNull.Value;
                dr["FilesName"] = FileName;
                dr["FileDescription"] = FileDescription;
                dr["FileExtension"] = FileExtension;
                dr["CreatedBy"] = MySession.strUserName;
            }
        }
        dt.Rows.Add(dr);
        ViewState["tblNeedyPersonDocs"] = dt;

        gvDocuments.DataSource = dt;
        gvDocuments.DataBind();
    }
    private void BulkInsertToDataBase(int NeedyPersonID)
    {
        if (ViewState["TimeSpent"] != null)
        {
            DataTable dtTemp = (DataTable)ViewState["TimeSpent"];

            bool NewEntry = false;//variable to use as flag to whether save new data or not. SA on 10th June, 2015.
            if (dtTemp.Rows.Count > 0)
            {
                //added
                if (Request.QueryString["NdID"] != "0")
                {
                    DataRow[] result = dtTemp.Select("IsDeleted =" + true);
                    if (result.Length > 0)
                    {
                        NewEntry = true;
                        dtTemp = dtTemp.AsEnumerable()
                                    .Where(r => r.Field<bool>("IsDeleted") == true)
                                    .CopyToDataTable();
                    }
                }
                if (Request.QueryString["NdID"] == "0")
                {

                    NewEntry = true;
                    if (dtTemp.Rows[0][0].ToString() == "" && dtTemp.Rows.Count == 1)
                    {
                        dtTemp.Rows[0].Delete();
                        dtTemp.AcceptChanges();
                        return;
                    }
                }


                if (NewEntry)//Only save new entry. As existing data if updated will directly be reflected in to DB from Updating event. SA on 10th June, 2015.
                {
                    foreach (DataRow dr in dtTemp.Rows)
                    {
                        dr["FKNeedyPersonID"] = NeedyPersonID;
                    }

                    //creating object of SqlBulkCopy  
                    SqlBulkCopy objbulk = new SqlBulkCopy(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString);
                    //assigning Destination table name  
                    objbulk.DestinationTableName = "tblTimeSpent";
                    //Mapping Table column  

                    objbulk.ColumnMappings.Add("TravelDate", "TravelDate");
                    objbulk.ColumnMappings.Add("TravelTime", "TravelTime");
                    objbulk.ColumnMappings.Add("FKNeedyPersonID", "FKNeedyPersonID");
                    objbulk.ColumnMappings.Add("TimeSpentReason", "TimeSpentReason");

                    //inserting bulk Records into DataBase   
                    objbulk.WriteToServer(dtTemp);
                    ViewState["TimeSpent"] = null;
                }
                //}

            }
        }
    }
    private void BulkInsertDoc(int NeedyPersonID)
    {
        if (ViewState["tblNeedyPersonDocs"] != null)
        {
            DataTable dtDoc = (DataTable)ViewState["tblNeedyPersonDocs"];

            foreach (DataRow dr in dtDoc.Rows)
            {
                dr["FKNeedyPersonID"] = NeedyPersonID;
            }

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings[MySession.strAppDB].ConnectionString);
            SqlCommand cmd = new SqlCommand("pssetNeedypersonDocsDetails", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param = cmd.Parameters.AddWithValue("@DocTable", dtDoc);
            param.SqlDbType = SqlDbType.Structured;
            con.Open();
            cmd.ExecuteNonQuery();
            ViewState["tblNeedyPersonDocs"] = null;
        }
    }
    bool ValidateFile()
    {
        string[] validFileTypes = { "bmp", "gif", "png", "jpg", "jpeg", "doc", "docx", "xls", "xlsx", "pdf", "rtf", "txt", "csv" };
        string ext = System.IO.Path.GetExtension(FUDocuments.PostedFile.FileName);
        bool isValidFile = false;
        for (int i = 0; i < validFileTypes.Length; i++)
        {
            if (ext.ToLower() == "." + validFileTypes[i])
            {
                isValidFile = true;
                break;
            }
        }
        if (!isValidFile)
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Validate", "ShowAlert('Invalid File. Please upload a File with extension'" + string.Join(",", validFileTypes) + ")", true);
        }
        return isValidFile;
    }
    protected void lstViewTimeSpent_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        if (lstViewTimeSpent.EditIndex == (e.Item as ListViewDataItem).DataItemIndex)
        {

            TextBox txtEditTravelDate = (e.Item.FindControl("txtEditTravelDate") as TextBox);
            TextBox txtEditTravelTime = (e.Item.FindControl("txtEditTravelTime") as TextBox);
            TextBox txtEditReason = (e.Item.FindControl("txtEditReason") as TextBox);
            ImageButton btnlstUpdate = (e.Item.FindControl("btnlstUpdate") as ImageButton);

            btnlstUpdate.Attributes.Add("onclick", "Javascript:return ValidateInputDate('" + txtEditTravelDate.ClientID + "', '" + txtEditTravelTime.ClientID + "','" + txtEditReason.ClientID + "');");
        }
    }
    protected void lstViewTimeSpent_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {
        int TimeID = 0;
        DataTable dt = null;
        string TravelDate = (lstViewTimeSpent.Items[e.ItemIndex].FindControl("txtEditTravelDate") as TextBox).Text;
        string TravelTime = (lstViewTimeSpent.Items[e.ItemIndex].FindControl("txtEditTravelTime") as TextBox).Text;
        string TravelReason = (lstViewTimeSpent.Items[e.ItemIndex].FindControl("txtEditReason") as TextBox).Text;

        if (TravelReason.Length > 500)
            TravelReason = TravelReason.Substring(0, 500);

        if (Request.QueryString["NdID"] != "0")
        {
            //TimeID = Convert.ToInt32(lstViewTimeSpent.DataKeys[e.ItemIndex]["TimeSpentID"].ToString());
            //ADRCIADAL.UpdateTimeSpent(TimeID, Convert.ToInt32(TravelTime), TravelReason, TravelDate);
            //lstViewTimeSpent.EditIndex = -1;
            ////BindTimeSpent(Convert.ToInt32(Request.QueryString["NdID"]) != 0 ? (int?)Convert.ToInt32(Request.QueryString["NdID"]) : null);
            //DataTable dt = (DataTable)ViewState["TimeSpent"];
            //for (int i = 0; i < dt.Rows.Count; i++)
            //{
            //    if (dt.Rows[i]["TimeSpentID"].ToString() == TimeID.ToString())
            //    {
            //        dt.Rows[i]["TravelDate"] = TravelDate;
            //        dt.Rows[i]["TravelTime"] = TravelTime;
            //        dt.Rows[i]["TimeSpentReason"] = TravelReason;

            //        dt.AcceptChanges();
            //    }
            //}
            //ViewState["TimeSpent"] = dt;//added
            //lstViewTimeSpent.EditIndex = -1;
            //lstViewTimeSpent.DataSource = dt;
            //lstViewTimeSpent.DataBind();

            string IsDeleted = lstViewTimeSpent.DataKeys[e.ItemIndex]["IsDeleted"].ToString();
            if (IsDeleted.ToLower() == "false")
            {
                TimeID = Convert.ToInt32(lstViewTimeSpent.DataKeys[e.ItemIndex]["TimeSpentID"].ToString());
                ADRCIADAL.UpdateTimeSpent(TimeID, Convert.ToInt32(TravelTime), TravelReason, TravelDate);
                lstViewTimeSpent.EditIndex = -1;

                dt = (DataTable)ViewState["TimeSpent"];
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (dt.Rows[i]["TimeSpentID"].ToString() == TimeID.ToString())
                    {
                        dt.Rows[i]["TravelDate"] = TravelDate;
                        dt.Rows[i]["TravelTime"] = TravelTime;
                        dt.Rows[i]["TimeSpentReason"] = TravelReason;

                        dt.AcceptChanges();
                    }
                }
                ViewState["TimeSpent"] = dt;//added
                lstViewTimeSpent.EditIndex = -1;
                lstViewTimeSpent.DataSource = dt;
                lstViewTimeSpent.DataBind();
            }
            else
            {
                string GUID = lstViewTimeSpent.DataKeys[e.ItemIndex]["GUID"].ToString();
                dt = (DataTable)ViewState["TimeSpent"];
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (dt.Rows[i]["GUID"].ToString() == GUID)
                    {
                        dt.Rows[i]["TravelDate"] = TravelDate;
                        dt.Rows[i]["TravelTime"] = TravelTime;
                        dt.Rows[i]["TimeSpentReason"] = TravelReason;

                        dt.AcceptChanges();
                    }
                }
                ViewState["TimeSpent"] = dt;//added
                lstViewTimeSpent.EditIndex = -1;
                lstViewTimeSpent.DataSource = dt;
                lstViewTimeSpent.DataBind();
            }

            NeedyID = Convert.ToString(Request.QueryString["NdID"]);
        }

        # region Start
        if (Request.QueryString["NdID"] == "0")
        {
            string UpGUID = lstViewTimeSpent.DataKeys[e.ItemIndex]["GUID"].ToString();
            dt = (DataTable)ViewState["TimeSpent"];
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (dt.Rows[i]["GUID"].ToString() == UpGUID)
                {
                    dt.Rows[i]["TravelDate"] = TravelDate;
                    dt.Rows[i]["TravelTime"] = TravelTime;
                    dt.Rows[i]["TimeSpentReason"] = TravelReason;

                    dt.AcceptChanges();
                }
            }
            ViewState["TimeSpent"] = dt;//added
            lstViewTimeSpent.EditIndex = -1;
            lstViewTimeSpent.DataSource = dt;
            lstViewTimeSpent.DataBind();
        }
        #endregion

    }
    protected void lstViewTimeSpent_ItemCanceling(object sender, ListViewCancelEventArgs e)
    {
        lstViewTimeSpent.EditIndex = -1;
        DataTable dt = (DataTable)ViewState["TimeSpent"];
        if (Request.QueryString["NdID"] == "0")
        {
            lstViewTimeSpent.DataSource = dt;
            lstViewTimeSpent.DataBind();
        }
        if (Request.QueryString["NdID"] != "0")
        {
            NeedyID = Convert.ToString(Request.QueryString["NdID"]);
            BindTimeSpent(Convert.ToInt32(Request.QueryString["NdID"]) != 0 ? (int?)Convert.ToInt32(Request.QueryString["NdID"]) : null);
        }
    }
    protected void lstViewTimeSpent_ItemEditing(object sender, ListViewEditEventArgs e)
    {
        //Added By Kuldeep Rathore on 22nd May, 2015
        msgTimeSpent.Visible = false;

        lstViewTimeSpent.EditIndex = e.NewEditIndex;


        if (Request.QueryString["NdID"] != "0")
        {
            NeedyID = Convert.ToString(Request.QueryString["NdID"]);
            BindTimeSpent(Convert.ToInt32(Request.QueryString["NdID"]) != 0 ? (int?)Convert.ToInt32(Request.QueryString["NdID"]) : null);
        }

        if (Request.QueryString["NdID"] == "0")
        {

            DataTable dt = (DataTable)ViewState["TimeSpent"];

            lstViewTimeSpent.DataSource = dt;
            lstViewTimeSpent.DataBind();
        }


    }
    protected void lstViewTimeSpent_ItemDeleting(object sender, ListViewDeleteEventArgs e)
    {

        DataTable dt = null;
        if (Request.QueryString["NdID"] != "0")
        {
            NeedyID = Convert.ToString(Request.QueryString["NdID"]);

            string IsDeleted = lstViewTimeSpent.DataKeys[e.ItemIndex]["IsDeleted"].ToString();
            if (IsDeleted.ToLower() == "false")
            {
                int TimeIDDel = Convert.ToInt32(lstViewTimeSpent.DataKeys[e.ItemIndex]["TimeSpentID"].ToString());
                ADRCIADAL.DeleteTimeSpent(TimeIDDel);

                dt = (DataTable)ViewState["TimeSpent"];
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (dt.Rows[i]["TimeSpentID"].ToString() == TimeIDDel.ToString())
                    {
                        dt.Rows[i].Delete();
                        dt.AcceptChanges();
                    }
                }
                ViewState["TimeSpent"] = dt;
                lstViewTimeSpent.DataSource = dt;
                lstViewTimeSpent.DataBind();
            }
            else
            {
                string GUID = lstViewTimeSpent.DataKeys[e.ItemIndex]["GUID"].ToString();
                dt = (DataTable)ViewState["TimeSpent"];
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (dt.Rows[i]["GUID"].ToString() == GUID)
                    {
                        dt.Rows[i].Delete();
                        dt.AcceptChanges();
                    }
                }
                ViewState["TimeSpent"] = dt;
                lstViewTimeSpent.DataSource = dt;
                lstViewTimeSpent.DataBind();
            }
            //int TimeIDDel = Convert.ToInt32(lstViewTimeSpent.DataKeys[e.ItemIndex]["TimeSpentID"].ToString());
            //ADRCIADAL.DeleteTimeSpent(TimeIDDel);
            //BindTimeSpent(Convert.ToInt32(Request.QueryString["NdID"]) != 0 ? (int?)Convert.ToInt32(Request.QueryString["NdID"]) : null);

        }

        if (Request.QueryString["NdID"] == "0")
        {
            string GUID = lstViewTimeSpent.DataKeys[e.ItemIndex]["GUID"].ToString();
            dt = (DataTable)ViewState["TimeSpent"];
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (dt.Rows[i]["GUID"].ToString() == GUID)
                {
                    dt.Rows[i].Delete();
                    dt.AcceptChanges();
                }
            }
            ViewState["TimeSpent"] = dt;
            lstViewTimeSpent.DataSource = dt;
            lstViewTimeSpent.DataBind();

        }
        //added by SA on 12th June, 2015. SOW-362
        if (ViewState["TimeSpent"] != null)
        {

            if (((DataTable)ViewState["TimeSpent"]).Rows.Count > 0)
            {
                if (Request.QueryString["NdID"] != "0")
                {
                    DataRow[] dr = ((DataTable)ViewState["TimeSpent"]).Select("IsDeleted=true");
                    if (dr.Length > 0)
                        numberOfRecords = ((DataTable)ViewState["TimeSpent"]).AsEnumerable().Where(r => r.Field<bool>("IsDeleted") == true).CopyToDataTable().Rows.Count;
                }
                else
                    numberOfRecords = ((DataTable)ViewState["TimeSpent"]).Rows.Count;
            }

        }
        if (numberOfRecords > 0)
            msgTimeSpent.Visible = true;
        else
            msgTimeSpent.Visible = false;
    }
    /// <summary>
    /// Created by SA on 9th March, 2015. Task ID:2695
    /// Purpose: Bind Insurance Types.
    /// </summary>
    /// <returns></returns>
    [WebMethod]
    public static string GetInsurance()
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        DataTable dt = ADRCIADAL.GetInsuranceTypes();
        return GetJson(dt);
    }

    /// <summary>
    /// Created by GK on 30April, 2019 SOW-563
    /// Bind CustomField Dropdownlist
    /// </summary>
    /// <returns></returns>
    [WebMethod]
    public static string GetCustomField()
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        DataTable dList = ADRCIADAL.GetCustomFieldList();

        if (dList != null)
        {
            return GetJson(dList);
        }
        else
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            return serializer.Serialize(string.Empty);
        }
    }

    // Added by GK on 11May2019 : SOW-563
    [WebMethod]
    public static bool SubmitCustomField(string AddedCodeList, string AddedNameList, string DeletedList)
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return false;

        bool InsertData = false;
        if (AddedNameList != "" || DeletedList != "")
        {
            int result = ADRCIADAL.SaveCustomField(AddedCodeList, AddedNameList, DeletedList);
            if (result > 0) InsertData = true;
        }
        return InsertData;
    }
    // Added by GK on 11May2019 : SOW-563
    [WebMethod]
    public static string IsUsedCustomField(string CustomCodeList)
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        var returnValue = "";
        int? NeedyPersonID = null;
        if (HttpContext.Current.Session["CurrentHistoryID"] != null)
            NeedyPersonID = Convert.ToInt32(HttpContext.Current.Session["CurrentHistoryID"]);
        DataTable dt = null;
        if (CustomCodeList != "")
            dt = ADRCIADAL.IsUsedCustomField(CustomCodeList, NeedyPersonID);

        if (dt != null && dt.Rows.Count > 0)
        {
            var list = new List<int>();
            foreach (DataRow row in dt.Rows) list.Add((int)row["FKCustomCode"]);
            returnValue = string.Join(",", list);
        }
        return returnValue;
    }

    //Added by KP on 20th Dec 2019(SOW-577), Referring Agency -- Block
    #region [Referring Agency -- Block]

    void BindReferringAgencyDetails()
    {
        DataTable dt = ADRCIADAL.GetReferringAgencyDetails(Convert.ToInt32((Request.QueryString["NdID"] ?? "0")));
        if (dt.Rows.Count > 0)
        {
            divNorRecordRefAgency.Visible = false;
            grdRefrringAgency.Visible = true;
            grdRefrringAgency.DataSource = dt;
            grdRefrringAgency.DataBind();
        }
        else
        {
            divNorRecordRefAgency.Visible = true;
            grdRefrringAgency.Visible = false;
        }
    }
    protected void grdRefrringAgency_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        grdRefrringAgency.EditIndex = -1;
        AssignNeedyID();
        BindReferringAgencyDetails();
    }

    protected void grdRefrringAgency_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {   
            AssignNeedyID();
            int ContactHistoryID = Convert.ToInt32(grdRefrringAgency.DataKeys[e.RowIndex].Values["ContactHistoryID"]);
            
            if (ContactHistoryID > 0)
            {
                ADRCIADAL.DeleteReferringAgency(Convert.ToInt32(Request.QueryString["NdID"] ?? "0"), ContactHistoryID);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "refDelete", " ShowAlert('Referring agency detail deleted successfully.','S')", true);

            }
        }
        catch (Exception)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "error1", " ShowAlert('Referring agency detail not deleted. Please try again.!','E')", true);
        }
        
        BindReferringAgencyDetails();
    }

    protected void grdRefrringAgency_RowEditing(object sender, GridViewEditEventArgs e)
    {
        grdRefrringAgency.EditIndex = e.NewEditIndex;
        AssignNeedyID();
        BindReferringAgencyDetails();
    }

    protected void grdRefrringAgency_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {
            AssignNeedyID();
            int ReferringAgencyDetailID = Convert.ToInt32(grdRefrringAgency.DataKeys[e.RowIndex].Values["ReferringAgencyDetailID"]);

            if (ReferringAgencyDetailID > 0)//!string.IsNullOrEmpty(ContactInfo)
            {
                int ContactHistoryID = Convert.ToInt32(grdRefrringAgency.DataKeys[e.RowIndex].Values["ContactHistoryID"]);
                string ContactInfo = grdRefrringAgency.DataKeys[e.RowIndex].Values["ContactInfo"].ToString();
                TextBox txtAgencyName = (TextBox)grdRefrringAgency.Rows[e.RowIndex].FindControl("txtAgencyName");
                TextBox txtContactName = (TextBox)grdRefrringAgency.Rows[e.RowIndex].FindControl("txtContactName");
                TextBox txtPhoneNumber = (TextBox)grdRefrringAgency.Rows[e.RowIndex].FindControl("txtPhoneNumber");
                TextBox txtEmail = (TextBox)grdRefrringAgency.Rows[e.RowIndex].FindControl("txtEmail");

                PersonNeedAssistance objNeedy = new PersonNeedAssistance();

                objNeedy.NeedyPersonID = Convert.ToInt32(Request.QueryString["NdID"] ?? "0");
                objNeedy.RefAgencyDetailID = ReferringAgencyDetailID;
                objNeedy.RefContactInfo = ContactInfo;
                objNeedy.RefAgencyName = txtAgencyName.Text.Trim();
                objNeedy.RefContactName = txtContactName.Text.Trim();
                objNeedy.RefPhoneNumber = txtPhoneNumber.Text.Trim() != "(___)___-____" ? txtPhoneNumber.Text.Trim() : "";
                objNeedy.RefEmail = txtEmail.Text.Trim();

                if (ADRCIABAL.UpdateReferringAgency(objNeedy, ContactHistoryID))
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "refUpdate", " ShowAlert('Referring agency detail saved successfully.','S');", true);
                else
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error1", " ShowAlert('Referring agency detail not saved. Please try again.!','E');", true);
            }
        }
        catch (Exception)
        {
            //Trim().Replace('\r', ' ').Replace('\n', ' ').Replace('\t', ' ')
            ScriptManager.RegisterStartupScript(this, this.GetType(), "error2", " ShowAlert('Referring agency detail not saved. Please try again.!','E')", true);
        }

        grdRefrringAgency.EditIndex = -1;
        BindReferringAgencyDetails();
    }

    protected void grdRefrringAgency_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (Session["ReferringAgencyDetailID"] != null
                && grdRefrringAgency.DataKeys[e.Row.RowIndex].Values["ReferringAgencyDetailID"].ToString() == Session["ReferringAgencyDetailID"].ToString())
            {
                ImageButton imgbtnEdit = (ImageButton)e.Row.FindControl("imgbtnEdit");
                ImageButton imgbtnDelete = (ImageButton)e.Row.FindControl("imgbtnDelete");
                imgbtnEdit.Visible = imgbtnDelete.Visible = false;
            }
        }
    }


    /// <summary>
    /// Added by KP on 7th Jan 2020(SOW-577)
    /// Get Conatct info list based on Contact info text and SiteID.
    /// </summary>
    /// <param name="ContactInfo"></param>
    /// <returns></returns>
    [WebMethod]
    public static string[] GetContactInfo(string ContactInfo, int ContactTypeID, int NeedyPersonID)
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        List<string> items = new List<string>();
        //if (ContactInfo != "")
        DataTable dt = ADRCIADAL.GetContactTypeInfoByInfo(ContactInfo, ContactTypeID, NeedyPersonID);
        for (int i = 0; dt.Rows.Count > i; i++)
        {
            items.Insert(i, dt.Rows[i]["ReferringAgencyDetailID"].ToString() + "|~|" + dt.Rows[i]["ContactInfo"].ToString() + "|~|" + dt.Rows[i]["AgencyName"].ToString() + "|~|" + dt.Rows[i]["ContactName"].ToString() + "|~|" + dt.Rows[i]["PhoneNumber"].ToString() + "|~|" + dt.Rows[i]["Email"].ToString());
        }

        return items.ToArray();
    }
    [WebMethod]
    public static string GetContactInfoJSON(string ContactInfo, int ContactTypeID, int NeedyPersonID)
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        DataTable dt = ADRCIADAL.GetContactTypeInfoByInfo(ContactInfo, ContactTypeID, NeedyPersonID);
        return GetJson(dt);
    }

    #endregion //End Referring Agency --Grid Block

    //Added by KP on 27th Feb 2020(SOW-577), Return call duration in second and set this value in session based on HoldInSession.
    string SetTimerSession(bool HoldInSession)
    {
        string CallDuration = "";
        if (HidIsTimerPause.Value == "true" && !string.IsNullOrEmpty(HidHoldDuration.Value))
            CallDuration = ConvertTimeToSecond(HidHoldDuration.Value);
        else
            CallDuration = !string.IsNullOrEmpty(txtCallDuration.Text) ? ConvertTimeToSecond(txtCallDuration.Text) : hdnTimerLimit.Value;

        if (HoldInSession)
            Session["TimerLimit"] = CallDuration;

        return CallDuration;
    }

    #region Html String
    //Added by PC on 19 May 2022, Purpose: Cross-site scripting(DOM-based) 
    [WebMethod]
    public static string GetExportFormString(string serviceID, int exportType)
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return null;

        serviceID = AntiXssEncoder.HtmlEncode(serviceID, true);
        return "<form method='post' action='exportPage.aspx' style='top:-3333333333px;' id='tempForm'><input type='hidden' name='serviceID' value='" + serviceID + "' ><input type='hidden' name='ExportType' value='" + exportType + "' ></form>";
    }

    //End
    #endregion
}
