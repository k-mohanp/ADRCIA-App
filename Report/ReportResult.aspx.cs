using ADRCIA;
using ExpertPdf.HtmlToPdf;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class Report_ReportResult : System.Web.UI.Page
{
    protected string IsADRCORInfoOnly = string.Empty;
    public string filterLinkText = "Click here to select Person Needy Assistance details column to view";

    #region [Page cycle methods]
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            aDuplicate.InnerHtml = aUnDupeClient.InnerHtml = aTotalContacts.InnerHtml = aUnDuplicateNPService.InnerHtml = aReportSelection.InnerHtml = filterLinkText;

            BindDetails();
            BindReportSelectionFields();

            // Restriction for mobile users for excel exporting
            if (MySession.blnIsMobileAgent)
            {
                btnExport.Enabled = false;
                TRecords.Disabled = true;
                //btnUnDuplicate.Disabled = true;
                btnDuplicate.Disabled = true;
            }
        }
    }
    #endregion

    #region [Other Methods]

    //Added by KP on 13th March 2020(SOW-577), Get and bind the report selection fields from DB.
    void BindReportSelectionFields()
    {
        DataSet ds = ADRCIADAL.GetReportSelectionFields();

        BindCheckBoxList(chkCPDetails, ds.Tables[0]);
        BindCheckBoxList(chkPersonal, ds.Tables[1]);
        BindCheckBoxList(chkAltContactInfo, ds.Tables[2]);
        BindCheckBoxList(chkOtherDetails, ds.Tables[3]);
        BindCheckBoxList(chkAddressInfo, ds.Tables[4]);
        BindCheckBoxList(chkService, ds.Tables[5]);
        BindCheckBoxList(chkReferredByTo, ds.Tables[6]);
        BindCheckBoxList(chkCallHistory, ds.Tables[7]);
        BindCheckBoxList(chkFollowUpOC, ds.Tables[8]);
        BindCheckBoxList(chkOptionCounseling, ds.Tables[9]);
        BindCheckBoxList(chkRefAgencyDetails, ds.Tables[10]);
    }

    //Added by KP on 13th March 2020(SOW-577), Bind the checkboxlist by datatable data.
    void BindCheckBoxList(CheckBoxList chkList, DataTable dt)
    {
        chkList.DataSource = dt;
        chkList.DataValueField = "ID";
        chkList.DataTextField = "UIDisplayField";
        chkList.DataBind();
    }

    //Added by KP on 16th March 2020(SOW-577), Get selected value with comma seperated from checkboxlist.
    string GetCheckBoxLisSelectedValue(CheckBoxList chkList)
    {
        return String.Join(",", chkList.Items.OfType<ListItem>().Where(r => r.Selected)
                                .Select(r => r.Value));
    }

    //Added by KP on 16th March 2020(SOW-577), Set Report Selection Properties from checkboxlist.
    ReportSelectionFilter SetReportSelectionProp()
    {
        bool IsNeedyReuested = false;
        bool IsCallHistoryReuested = false;
        bool IsContactPersonReuested = false;
        bool IsOptionCounsReuested = false;

        //Set flag and selected value for Contact Person Details.
        string CPDetails = GetCheckBoxLisSelectedValue(chkCPDetails);
        IsContactPersonReuested = !string.IsNullOrEmpty(CPDetails);

        //Set flag and selected value for Needy Personal Details
        string Personal = GetCheckBoxLisSelectedValue(chkPersonal);
        IsNeedyReuested = IsNeedyReuested || !string.IsNullOrEmpty(Personal);

        //Set flag and selected value for Needy Alternate Contact Info
        string AltContactInfo = GetCheckBoxLisSelectedValue(chkAltContactInfo);
        IsNeedyReuested = IsNeedyReuested || !string.IsNullOrEmpty(AltContactInfo);

        //Set flag and selected value for Needy Other Details or Option Counseling & Time Spent(CaregiverStatus field is inside this section).
        string OtherDetails = GetCheckBoxLisSelectedValue(chkOtherDetails);
        IsOptionCounsReuested = !string.IsNullOrEmpty(OtherDetails);

        //Set flag and selected value for Needy Address Information
        string AddressInfo = GetCheckBoxLisSelectedValue(chkAddressInfo);
        IsNeedyReuested = IsNeedyReuested || !string.IsNullOrEmpty(AddressInfo);

        //Set flag and selected value for Needy Service Available/Requested
        string Service = GetCheckBoxLisSelectedValue(chkService);
        IsCallHistoryReuested = !string.IsNullOrEmpty(Service);

        //Set flag and selected value for Needy Referred By/To
        string ReferredByTo = GetCheckBoxLisSelectedValue(chkReferredByTo);
        IsCallHistoryReuested = IsCallHistoryReuested || !string.IsNullOrEmpty(ReferredByTo);

        //Set flag and selected value for Call History
        string CallHistory = GetCheckBoxLisSelectedValue(chkCallHistory);
        IsCallHistoryReuested = IsCallHistoryReuested || !string.IsNullOrEmpty(CallHistory);

        //Set flag and selected value for Needy Follow Up & Option Counseling
        string FollowUpOC = GetCheckBoxLisSelectedValue(chkFollowUpOC);
        IsCallHistoryReuested = IsCallHistoryReuested || !string.IsNullOrEmpty(FollowUpOC);

        //Set flag and selected value for Option Counseling & Time Spent.
        string OptionCounseling = GetCheckBoxLisSelectedValue(chkOptionCounseling);
        IsOptionCounsReuested = IsOptionCounsReuested || !string.IsNullOrEmpty(OptionCounseling);

        //Set flag and selected value for Referring Agency Details
        string RefAgencyDetails = GetCheckBoxLisSelectedValue(chkRefAgencyDetails);
        IsCallHistoryReuested = IsCallHistoryReuested || !string.IsNullOrEmpty(RefAgencyDetails);

        if (IsOptionCounsReuested || IsCallHistoryReuested)
            IsNeedyReuested = true;

        ReportSelectionFilter obj = new ReportSelectionFilter();
        obj.ReuestedIDs = string.Join(",", CPDetails, Personal, AltContactInfo, OtherDetails, AddressInfo, Service, ReferredByTo, CallHistory, FollowUpOC, OptionCounseling, RefAgencyDetails);//.Replace(",,", "");
        obj.IsNeedyReuested = IsNeedyReuested;
        obj.IsCallHistoryReuested = IsCallHistoryReuested;
        obj.IsContactPersonReuested = IsContactPersonReuested;
        obj.IsOptionCounsReuested = IsOptionCounsReuested;

        return obj;
    }

    /// <summary>
    /// Created by SA.
    /// Section to bind all the details of the page.
    /// </summary>
    public void BindDetails()
    {

        ADRCReport objReport = (ADRCReport)Session["ObjReport"];

        DataSet ds = (DataSet)Session["ReportData"];

        lblReportType.Text = objReport.ReportTypeText;
        //string ToDate = (objReport.DateRangeTo == string.Empty) ? DateTime.UtcNow.AddMinutes(330).ToShortDateString() : objReport.DateRangeTo;

        lblReportPeriod.Text = objReport.DateRangeFrom + " - " + objReport.DateRangeTo;

        DateTime date = DateTime.Now;
        lblDateReportRun.Text = string.Format("{0:g}", date);
        // Conditions for different Agencies
        if (MySession.blnADRCIAOSAAdmin == false)
        {
            lblAgency.Text = MySession.AAAAgencyName;
        }
        else
        {
            if (objReport.AgencyLength != "0")
            {
                lblAgency.Text = (objReport.AgencyLength == string.Empty) ? objReport.AgencyText : "All";
            }
            else
            {
                lblAgency.Text = "N/A";
            }
        }

        if (objReport.CountyLength != "0")
        {
            lblCounty1.Text = (objReport.CountyLength == string.Empty) ? objReport.County : "All";
        }
        else
        {
            lblCounty1.Text = "N/A";
        }
        if (objReport.CityLength != "0")
        {
            lblCity1.Text = (objReport.CityLength == string.Empty) ? objReport.City : "All";
        }
        else
        {
            lblCity1.Text = "N/A";
        }

        // Added by GK on 22May19 : SOW-563
        if (objReport.TownshipLength != "0")
        {
            lblTownship.Text = (objReport.TownshipLength == string.Empty) ? objReport.TownshipText : "All";
        }
        else
        {
            lblTownship.Text = "N/A";
        }
        if (objReport.CustomFieldLength != "0")
        {
            lblCustomField.Text = (objReport.CustomFieldLength == string.Empty) ? objReport.CustomFieldText : "All";
        }
        else
        {
            lblCustomField.Text = "N/A";
        }
        // Ends

        lblReferredBy.Text = (objReport.RefByLength == string.Empty) ? objReport.ReferredByText : "All";//Added on 26-11-2014. SOW-335. SA.

        if (objReport.ServiceLength != "0")
        {
            lblService1.Text = (objReport.ServiceLength == string.Empty) ? objReport.ServiceText : "All";
        }
        else
        {
            lblService1.Text = "N/A";
        }

        //Added by KP on 7th Apr 2020(SOW-577), Displya Other Service selected filters.
        if (objReport.OtherServiceLength != "0")
        {
            lblOtherService1.Text = (objReport.OtherServiceLength == string.Empty) ? objReport.OtherService : "All";
        }
        else
        {
            lblOtherService1.Text = "N/A";
        }
        //End (SOW-577)

        lblRefferedTo.Text = (objReport.RefLength == string.Empty) ? objReport.ReferredToText : "All";
        if (objReport.StaffLength != "0")
        {
            lblStaff1.Text = (objReport.StaffLength == string.Empty) ? objReport.StaffName : "All";
        }
        else
        {
            lblStaff1.Text = "N/A";
        }

        if (ds == null)
        {
            TRecords.Attributes.Add("style", "display:none;");
            return;
        }

        if (objReport.ReportingStyle == "0")
        {
            trDetails.Visible = false;
        }
        if (objReport.ReportingStyle == "1")
        {
            trDetails.Visible = true;
        }
        if (objReport.ReportType == "4")
        {
            trTotalRecords.Visible = false;
            trDuplicate.Visible = true;
            //trUnDuplicate.Visible = true;
            //added by SA on 8th Dec, 2015 SOW-401
            trDuplicateNPService.Visible = true;
            trUnDuplicateNPService.Visible = true;
            trDuplicateNPOtherService.Visible = true;

            //trDupeClient.Visible = true;
            trUnDupeClient.Visible = true;
            trTotalContacts.Visible = true;//Added by BS on 9-9-2016

            if (objReport.IsADRC && objReport.IsInfoOnly)
            {
                lbldupundup.Text = "(Info Only & ADRC Both)";
            }
            else if (objReport.IsADRC)
            {
                lbldupundup.Text = "(ADRC)";
            }
            else if (objReport.IsInfoOnly)
            {
                lbldupundup.Text = "(Info Only)";
            }
            else
            {
                lbldupundup.Text = string.Empty;
            }

            if (Convert.ToInt32(ds.Tables[0].Rows[0]["DuplicateNeedyPerson"]) == 0)
            {
                btnDuplicate.Attributes.Add("style", "display:none;");
            }

            //if (Convert.ToInt32(ds.Tables[2].Rows[0]["UnduplicateNeedyPerson"]) == 0)
            //{
            //    btnUnDuplicate.Attributes.Add("style", "display:none;");
            //}

            lblDuplicateCount.Text = ds.Tables[0].Rows[0]["DuplicateNeedyPerson"].ToString();
            //lblUnDuplicateCount.Text = ds.Tables[2].Rows[0]["UnduplicateNeedyPerson"].ToString();

            ViewState["DuplicateNeedyPersonID"] = ds.Tables[1].Rows[0]["DuplicateNeedyPersonID"].ToString();
            ViewState["DuplicateCallIDList"] = ds.Tables[1].Rows[0]["DuplicateCallIDList"].ToString();//added
            //Added by VK on 03 AUG, 2017. Set AllCallIDList in ViewState["AllCallIDList"].
            ViewState["AllCallIDList"] = Convert.ToString(ds.Tables[1].Rows[0]["AllCallIDList"]);
            // ViewState["UnduplicateNeedyPersonID"] = ds.Tables[3].Rows[0]["UnduplicateNeedyPersonID"].ToString();
            //ViewState["UnduplicateCallIDList"] = ds.Tables[3].Rows[0]["UnduplicateCallIDList"].ToString();//added

            //added by SA on 8th Dec, 2015 SOW-401

            if (Convert.ToInt32(ds.Tables[2].Rows[0]["DuplicateNPService"]) == 0)
            {
                divDupeService.Attributes.Add("style", "display:none;");
            }
            else
            {
                DLDupeService.DataSource = ds.Tables[3];
                DLDupeService.DataBind();
            }



            if (Convert.ToInt32(ds.Tables[4].Rows[0]["UnDuplicateNPService"]) == 0)
            {
                btnUnDuplicateNPService.Attributes.Add("style", "display:none;");
            }
            lblDuplicateNPService.Text = Convert.ToString(ds.Tables[2].Rows[0]["DuplicateNPService"]);
            lblUnDuplicateNPService.Text = Convert.ToString(ds.Tables[4].Rows[0]["UnDuplicateNPService"]);


            ViewState["UnDuplicateNDIDByService"] = Convert.ToString(ds.Tables[5].Rows[0]["UnDuplicateNDIDByService"]);
            ViewState["UnDuplicateCallIDListByService"] = Convert.ToString(ds.Tables[5].Rows[0]["UnDuplicateCallIDListByService"]);
            //Added by VK on 03 AUG, 2017. Set AllCallIDList in ViewState["AllCallIDList"].
            ViewState["AllCallIDList"] = Convert.ToString(ds.Tables[5].Rows[0]["AllCallIDList"]);
            //added by SA on 10th Dec, 2015. SOW-401


            if (Convert.ToInt32(ds.Tables[6].Rows[0]["UnDuplicateClientCount"]) == 0)
            {
                btnUnDupeClient.Attributes.Add("style", "display:none;");
            }

            //if (Convert.ToInt32(ds.Tables[10].Rows[0]["DuplicateClientCount"]) == 0)
            //{
            //    btnDupeClient.Attributes.Add("style", "display:none;");
            //}
            lblUnDupeClient.Text = Convert.ToString(ds.Tables[6].Rows[0]["UnDuplicateClientCount"]);
            //lblDupeClient.Text = Convert.ToString(ds.Tables[10].Rows[0]["DuplicateClientCount"]);

            //ViewState["DupeClientNDID"] = Convert.ToString(ds.Tables[11].Rows[0]["DupeClientNDID"]);
            //ViewState["DupeClientCallID"] = Convert.ToString(ds.Tables[11].Rows[0]["DupeClientCallID"]);

            ViewState["UnDupeClientNDID"] = Convert.ToString(ds.Tables[7].Rows[0]["UnDupeClientNDID"]);
            ViewState["UnDupeClientCallID"] = Convert.ToString(ds.Tables[7].Rows[0]["UnDupeClientCallID"]);
            //Added by VK on 03 AUG, 2017. Set AllCallIDList in ViewState["AllCallIDList"].
            ViewState["AllCallIDList"] = Convert.ToString(ds.Tables[7].Rows[0]["AllCallIDList"]);
            //Added by:BS on 13-Sep-2016
            if (Convert.ToInt32(ds.Tables[8].Rows[0]["TotalContactCount"]) == 0)
            {
                btnTotalContacts.Attributes.Add("style", "display:none;");
            }
            lblTotalContacts.Text = Convert.ToString(ds.Tables[8].Rows[0]["TotalContactCount"]);
            ViewState["NeedyID"] = Convert.ToString(ds.Tables[9].Rows[0]["NeedyID"]);
            ViewState["CallID"] = Convert.ToString(ds.Tables[9].Rows[0]["CallID"]);
            //Added by VK on 03 AUG, 2017. Set AllCallIDList in ViewState["AllCallIDList"].
            ViewState["AllCallIDList"] = Convert.ToString(ds.Tables[9].Rows[0]["AllCallIDList"]);

            //Added by KP on 15th April 2020(SOW-577), Display Other Service count and Needy person count based on Other service.
            if (Convert.ToInt32(ds.Tables[10].Rows[0]["DuplicateNPOtherService"]) == 0)
                divDupeOtherService.Attributes.Add("style", "display:none;");
            else
            {
                DLDupeOtherService.DataSource = ds.Tables[11];
                DLDupeOtherService.DataBind();
            }
            lblDuplicateNPOtherService.Text = Convert.ToString(ds.Tables[10].Rows[0]["DuplicateNPOtherService"]);
            //End (SOW-577)
        }

        if (objReport.ReportType == "5")
        {
            trTotalRecords.Visible = false;
            trCountyReport.Visible = true;
            if (ds.Tables[0].Rows.Count > 0)
            {
                BindGVCountyReport(ds.Tables[0]);
            }
            else
            {
                GVCountyReport.Visible = false;
                divNoRecords.Attributes.Add("class", "Norecord");
            }

            //Added by KP on 28th April 2020(SOW-577), Other Service
            if (ds.Tables[1].Rows.Count > 0)
                BindGVCountyReportOS(ds.Tables[1]);
            else
            {
                GVCountyReportOS.Visible = false;
                divNoRecordsOS.Attributes.Add("class", "Norecord");
            }
            //End (SOW-577)

        }

        if (objReport.ReportType != "4" && objReport.ReportType != "5")
        {
            lblTotalRecords.Text = Convert.ToString(ds.Tables[0].Rows[0]["PersonCount"]);
            ViewState["NeedyList"] = ds.Tables[1].Rows[0]["NeedyIDList"].ToString();
            ViewState["CallIDList"] = ds.Tables[1].Rows[0]["CallIDList"].ToString();
            //Added by VK on 03 AUG, 2017. Set AllCallIDList in ViewState["AllCallIDList"].
            ViewState["AllCallIDList"] = Convert.ToString(ds.Tables[1].Rows[0]["AllCallIDList"]);
            if (ds.Tables[0].Rows[0]["PersonCount"].ToString() == "0")
            {
                TRecords.Attributes.Add("style", "display:none;");
            }

            //Detailed report binding section..
            if (ds.Tables.Count > 2)
            {

                DLContactType.DataSource = ds.Tables[2];
                DLContactType.DataBind();

                DLContactMethod.DataSource = ds.Tables[3];
                DLContactMethod.DataBind();

                DLAge.DataSource = ds.Tables[4];
                DLAge.DataBind();

                DLGender.DataSource = ds.Tables[5];
                DLGender.DataBind();

                DLMaritalStatus.DataSource = ds.Tables[6];
                DLMaritalStatus.DataBind();

                DLLivingArrangement.DataSource = ds.Tables[7];
                DLLivingArrangement.DataBind();

                DLRace.DataSource = ds.Tables[8];
                DLRace.DataBind();

                DLVeteranApplicable.DataSource = ds.Tables[9];
                DLVeteranApplicable.DataBind();

                DLVeteranStatus.DataSource = ds.Tables[10];
                DLVeteranStatus.DataBind();

                DLCounty.DataSource = ds.Tables[13];
                DLCounty.DataBind();

                DLCity.DataSource = ds.Tables[14];
                DLCity.DataBind();

                DLService.DataSource = ds.Tables[16];
                DLService.DataBind();

                DLFollowUp.DataSource = ds.Tables[17];
                DLFollowUp.DataBind();

                DLServiceNeedMet.DataSource = ds.Tables[18];
                DLServiceNeedMet.DataBind();

                DLEthnicity.DataSource = ds.Tables[19];
                DLEthnicity.DataBind();

                DLStaff.DataSource = ds.Tables[21];
                DLStaff.DataBind();


                DLPrimaryLanguage.DataSource = ds.Tables[22];
                DLPrimaryLanguage.DataBind();
                //added by SA on 21st aug, 2015. sow-379
                DLReferredforOC.DataSource = ds.Tables[23];
                DLReferredforOC.DataBind();

                //Display of Counts

                DLFundsProvided.DataSource = ds.Tables[24];
                DLFundsProvided.DataBind();
                //Added by VK on 03 Aug, 2017.
                lblFundsProvidedAmount.Text = ds.Tables[25].Rows[0]["FundsProvidedAmount"].ToString();
                //DLCaregiver.DataSource = ds.Tables[26];
                //DLCaregiver.DataBind();
                //Added by VK on 03 Aug, 2017.
                DLFundsUtilizedfor.DataSource = ds.Tables[26];
                DLFundsUtilizedfor.DataBind();
                //Added by VK on 03 Aug, 2017.
                DLCaregiverNeedyPerson.DataSource = ds.Tables[27];
                DLCaregiverNeedyPerson.DataBind();

                //Added by KP on 29-Sep-2017 - SOW-485   
                DlNoDemographics.DataSource = ds.Tables[28];
                DlNoDemographics.DataBind();



                lblCounty.Text = ds.Tables[11].Rows[0]["County"].ToString();
                lblCity.Text = ds.Tables[12].Rows[0]["City"].ToString();

                //Added by GK on 251Apr19 : SOW-563
                DLTownship.DataSource = ds.Tables[29];
                DLTownship.DataBind();
                lblTownship1.Text = ds.Tables[30].Rows[0]["TownshipCount"].ToString();
                DLCustomField.DataSource = ds.Tables[31];
                DLCustomField.DataBind();
                lblCustomField1.Text = ds.Tables[32].Rows[0]["CustomCount"].ToString();

                lblService.Text = ds.Tables[15].Rows[0]["ServiceCount"].ToString();
                lblStaffCount.Text = ds.Tables[20].Rows[0]["StaffCount"].ToString();

                //Validations whether to render values <= 0 in excel reporting

                if (ds.Tables[11].Rows.Count <= 0)
                {
                    trCounty.Attributes.Add("style", "display:none;");
                    acounty.Attributes.Add("style", "display:none;");
                }

                if (ds.Tables[12].Rows.Count <= 0)
                {
                    trCity.Attributes.Add("style", "display:none;");
                    acity.Attributes.Add("style", "display:none;");
                }

                // Added by GK on 22May2019 : SOW-563
                if (ds.Tables[29].Rows.Count <= 0)
                {
                    trTownship.Attributes.Add("style", "display:none;");
                    atownship.Attributes.Add("style", "display:none;");
                }
                if (ds.Tables[29].Rows.Count <= 0)
                {
                    trCustomField.Attributes.Add("style", "display:none;");
                    aCustomField.Attributes.Add("style", "display:none;");
                }
                // End

                if (ds.Tables[16].Rows.Count <= 0)
                {
                    trService.Attributes.Add("style", "display:none;");
                    aservice.Attributes.Add("style", "display:none;");
                }

                if (ds.Tables[20].Rows.Count > 0)
                {
                    if (ds.Tables[20].Rows[0]["StaffCount"].ToString() == "0")// Added on 5th Feb, 2015. for Staff functionality change. SA
                    {
                        trStaff.Attributes.Add("style", "display:none;");
                        astaff.Attributes.Add("style", "display:none;");
                    }
                }

                //Added By KP on 8th April 2020(SOW-577), Display Other Service count and PersonCount group by Other Service.
                lblOtherService.Text = ds.Tables[33].Rows[0]["OtherServiceCount"].ToString();
                if (ds.Tables[34].Rows.Count <= 0)
                {
                    trOtherService.Attributes.Add("style", "display:none;");
                    aotherservice.Attributes.Add("style", "display:none;");
                }
                DLOtherService.DataSource = ds.Tables[34];
                DLOtherService.DataBind();
                //End (SOW-577)
            }
            else
            {
                trDetails.Visible = false;
            }
        }
        //Advance filter section..
        if (Convert.ToBoolean(objReport.AdvanceFilter))
        {
            tblAdvanceFilter.Visible = true;
            lblContactMethod.Text = (objReport.ContactMethodText != "") ? objReport.ContactMethodText : "N/A";
            lblDate.Text = (objReport.DateText != "") ? objReport.DateText : DateTime.Now.ToShortDateString();
            lblAgeRange.Text = (objReport.AgeAsOfText != "") ? objReport.AgeAsOfText : "N/A";
            lblContactType.Text = (objReport.ContactTypeText != "") ? objReport.ContactTypeText : "N/A";
            lblGender.Text = (objReport.GenderText != "") ? objReport.GenderText : "N/A";
            lblMaritalStatus.Text = (objReport.MaritalStatusText != "") ? objReport.MaritalStatusText : "N/A";
            lblLivingArrangement.Text = (objReport.LivingArrangementText != "") ? objReport.LivingArrangementText : "N/A";
            lblRace.Text = (objReport.RaceText != "") ? objReport.RaceText : "N/A";
            lblNoDemographics.Text = (objReport.IsDemographicsText != "") ? objReport.IsDemographicsText : "N/A";

            lblPrimaryLanguage.Text = (objReport.PrimaryLanguage != "") ? objReport.PrimaryLanguage : "N/A";

            lblEthnicity.Text = (objReport.EthnicityText != "") ? objReport.EthnicityText : "N/A";
            lblVeteranApplicable.Text = (objReport.VeteranApplicableText != "") ? objReport.VeteranApplicableText : "N/A";
            lblVeteranStatus.Text = (objReport.VeteranStatusText != "") ? objReport.VeteranStatusText : "N/A";
            lblServiceNeedMet.Text = (objReport.ServiceNeedMetText != "") ? objReport.ServiceNeedMetText : "N/A";
            lblFollowUp.Text = (objReport.FollowUpText != "") ? objReport.FollowUpText : "N/A";
            //added on 21st Aug, 2015. SOW-379
            lblReferredforOC.Text = (objReport.IsReferredForOCText != "") ? objReport.IsReferredForOCText : "N/A";
            lblReferredforOCDate.Text = (objReport.IsReferredForOCDate != "") ? objReport.IsReferredForOCDate + " - " + objReport.IsReferredForOCDateTo : "N/A";

            //Added By KR on 27 March 2017.
            lblIsFundProvided.Text = (objReport.IsFundProvidedText != "") ? objReport.IsFundProvidedText : "N/A";
            if (objReport.IsFundProvidedText == "Yes")
            {
                if (objReport.IsFromAmount == "" && objReport.IsToAmount != "")
                {
                    lblFundsAmount.Text = "$" + "0" + " - " + Convert.ToDecimal(objReport.IsToAmount);
                }
                else if (objReport.IsFromAmount != "" && objReport.IsToAmount == "")
                {
                    lblFundsAmount.Text = "$" + Convert.ToDecimal(objReport.IsFromAmount) + " - " + "999";
                }
                else if (objReport.IsFromAmount == "" && objReport.IsToAmount == "")
                {
                    lblFundsAmount.Text = "$" + "0" + " - " + "999";
                }
                else
                    lblFundsAmount.Text = (objReport.IsFromAmount != "" && objReport.IsToAmount != "") ? "$" + " " + Convert.ToDecimal(objReport.IsFromAmount) + " - " + Convert.ToDecimal(objReport.IsToAmount) : "N/A";
            }
            else
                lblFundsAmount.Text = "N/A";
            //Added By VK on 03 Aug 2017.
            lblFundsDate.Text = (objReport.FundsProvidedDateFrom != "") ? objReport.FundsProvidedDateFrom + " - " + objReport.FundsProvidedDateTo : "N/A";
            lblCaregiverNeedyPerson.Text = (objReport.CaregiverNeedyPersonText != "") ? objReport.CaregiverNeedyPersonText : "N/A";
            lblFundsUtilizedfor.Text = (objReport.FundsUtilizedforText != "") ? objReport.FundsUtilizedforText : "N/A";

            //Added by KP on 3rd Jan 2019(SOW-577), To set text value to Contact Info labels. 
            lblProfInfo.Text = !string.IsNullOrEmpty(objReport.ProfessionalInfoText) ? objReport.ProfessionalInfoText : "N/A";
            lblProxyInfo.Text = !string.IsNullOrEmpty(objReport.ProxyInfoText) ? objReport.ProxyInfoText : "N/A";
            lblFamilyInfo.Text = !string.IsNullOrEmpty(objReport.FamilyInfoText) ? objReport.FamilyInfoText : "N/A";
            lblOtherInfo.Text = !string.IsNullOrEmpty(objReport.OtherInfoText) ? objReport.OtherInfoText : "N/A";
            lblCaregiverInfoText.Text = !string.IsNullOrEmpty(objReport.CaregiverInfoText) ? objReport.CaregiverInfoText : "N/A";
            //End (SOW-577)
        }


        ds.Dispose();


    }
    /// <summary>
    /// Created by SA on 8th August, 2014.
    /// Purpose: To eliminate duplicate values from the gridview.
    /// Modified By KP on 28th April 2020(SOW-577), Make this function to work as common for multiple grid view.
    /// </summary>
    /// <param name="Type"></param>
    private void GenerateUniqueData(GridView GridViewCountyReport)
    {
        //Logic for unique names

        int count = 0;
        string county = GridViewCountyReport.Rows[0].Cells[0].Text;
        for (int i = 0; i < GridViewCountyReport.Rows.Count; i++)
        {

            Label lblCounty = (Label)GridViewCountyReport.Rows[i].Cells[0].FindControl("lblCounty");
            if (lblCounty.Text == county)
            {
                lblCounty.Text = string.Empty;
                count = 0;
            }
            else
            {
                if (i > 0)
                {
                    count++;
                    if (count == 1)
                    {
                        GridViewCountyReport.Rows[i].Font.Bold = true;
                    }
                }

                county = lblCounty.Text;
            }

            if (i == GridViewCountyReport.Rows.Count - 1)
            {
                GridViewCountyReport.Rows[i].Font.Bold = true;
            }
        }

        int CityFlag = 0;
        string city = GridViewCountyReport.Rows[0].Cells[1].Text;
        for (int i = 0; i < GridViewCountyReport.Rows.Count; i++)
        {

            Label lblCity2 = (Label)GridViewCountyReport.Rows[i].Cells[1].FindControl("lblCity");
            if (lblCity2.Text == city)
            {
                lblCity2.Text = string.Empty;
                CityFlag = 0;
            }
            else
            {

                if (i > 0)
                {
                    CityFlag++;
                    if (CityFlag == 1)
                    {
                        GridViewCountyReport.Rows[i].Font.Bold = true;
                    }
                }
                city = lblCity2.Text;
            }

            if (i == GridViewCountyReport.Rows.Count - 1)
            {
                GridViewCountyReport.Rows[i].Font.Bold = true;
            }
        }

    }
    /// <summary> 
    /// Created by SA on 22th July, 2K14.
    /// Purpose: Reporting in Excel format for every reporting style.
    /// </summary>
    /// <param name="ID"></param>
    public void ExportToExcel(HtmlControl ID)
    {
        DataSet ds = (DataSet)Session["ReportData"];
        ADRCReport objReport = (ADRCReport)Session["ObjReport"];

        string FileName = string.Empty, s = string.Empty, style = string.Empty;

        FileName = (objReport.ReportingStyle == "0") ? "Summary Report" : "Detailed Report";

        Response.AppendHeader("content-disposition", "attachment;filename=" + FileName + ".xls");
        Response.Charset = "";
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.ContentType = "application/vnd.ms-excel";

        this.EnableViewState = false;
        //added by SA on 12th Jan, 2016.
        if (objReport.ReportType == "4")
        {
            RemoveLinksFRomExcelPDF(DLDupeService);
            RemoveLinksFRomExcelPDF(DLDupeOtherService);//Added by KP on 15th April 2020(SOW-577), Remove hyperlink.
        }
        StringWriter SWSummary = new StringWriter();
        HtmlTextWriter TWSummary = new HtmlTextWriter(SWSummary);
        ExcelData.RenderControl(TWSummary);

        StringWriter SWDetailed = new StringWriter();
        HtmlTextWriter TWDetailed = new HtmlTextWriter(SWDetailed);
        ID.RenderControl(TWDetailed);

        string Summary = SWSummary.GetStringBuilder().ToString().Replace("Download in Excel", " ").Replace(filterLinkText, "");

        if (objReport.ReportingStyle == "0")
        {
            s = "<br/> <span style='font-size:13pt; font-weight:bold; text-align:center;'>" + FileName + "</span> <br/><br/>" + Summary + "<br/><br/><hr style='border:1px double Gray;' />";
        }
        else if (ds.Tables.Count > 2)
        {
            s = "<br/> <span style='font-size:13pt; font-weight:bold; text-align:center;'>" + FileName + "</span> <br/><br/>" + Summary + "<br/><br/><hr style='border:1px double Gray;' />" + SWDetailed.GetStringBuilder().ToString().Replace("Hide Details", " ").Replace("Close", " ");
        }
        else
        {
            s = "<br/> <span style='font-size:13pt; font-weight:bold; text-align:center;'>" + FileName + "</span> <br/><br/>" + Summary + "<br/><br/><hr style='border:1px double Gray;' />";
        }
        if (objReport.ReportType == "5")
        {
            //To Export all pages
            GVCountyReport.AllowPaging = false;
            GVCountyReportOS.AllowPaging = false;
            StringWriter SWCounty = new StringWriter();
            HtmlTextWriter TWCounty = new HtmlTextWriter(SWCounty);
            CountyReport.RenderControl(TWCounty);

            s = "<br/> <span style='font-size:13pt; font-weight:bold; text-align:center;'>" + FileName + "</span> <br/><br/>" + Summary + "<br/><br/><hr style='border:1px double Gray;' />" + SWCounty.GetStringBuilder().ToString().Replace("No Records Found", null).Replace("for Services Requested.", "").Replace("for Other Services.", "");

            if (GVCountyReport.Rows.Count == 0)
                s = s.Replace("County wide Services Requested:", "");

            if (GVCountyReportOS.Rows.Count == 0)
                s = s.Replace("County wide Other Services:", "");

        }

        Response.Write(s);
        Response.End();
        SWSummary.Dispose();
        TWSummary.Dispose();
        SWDetailed.Dispose();
        TWDetailed.Dispose();
    }
    /// <summary>
    /// Created by SA on 19th May, 2K15.
    /// Purpose: Reporting in PDF format for every reporting style.
    /// </summary>
    /// <param name="ID"></param>
    public void ExportToPDF(HtmlControl ID)
    {
        DataSet ds = (DataSet)Session["ReportData"];
        ADRCReport objReport = (ADRCReport)Session["ObjReport"];

        string FileName = string.Empty, s = string.Empty, style = string.Empty;

        FileName = (objReport.ReportingStyle == "0") ? "Summary Report" : "Detailed Report";

        Response.AppendHeader("content-disposition", "attachment;filename=" + FileName + ".pdf");
        Response.Charset = "";
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.ContentType = "application/pdf";

        this.EnableViewState = false;

        if (objReport.ReportType == "4")//To not show in PDF
        {
            btnDuplicate.Attributes.Add("style", "display:none;"); //btnUnDuplicate.Attributes.Add("style", "display:none;");
            btnUnDupeClient.Attributes.Add("style", "display:none;");
            //added by SA on 8th Dec, 2015 SOW-401
            //btnDuplicateNPService.Attributes.Add("style", "display:none;");
            btnUnDuplicateNPService.Attributes.Add("style", "display:none;");
            btnTotalContacts.Attributes.Add("style", "display:none;");//Added by BS on 3-oct-2016 to fix button displaying issue in pdf

            //added by SA on 12th Jan, 2016.
            RemoveLinksFRomExcelPDF(DLDupeService);
            RemoveLinksFRomExcelPDF(DLDupeOtherService);//Added by KP on 15th April 2020(SOW-577), Remove hyperlink.
        }

        if (objReport.ReportingStyle == "1" || objReport.ReportingStyle == "0")//To not show in PDF
        {
            TRecords.Attributes.Add("style", "display:none;"); //btnUnDuplicate.Attributes.Add("style", "display:none;"); 
        }

        StringWriter SWSummary = new StringWriter();
        HtmlTextWriter TWSummary = new HtmlTextWriter(SWSummary);
        ExcelData.RenderControl(TWSummary);

        StringWriter SWDetailed = new StringWriter();
        HtmlTextWriter TWDetailed = new HtmlTextWriter(SWDetailed);
        ID.RenderControl(TWDetailed);

        StringWriter SWCounty = new StringWriter();
        HtmlTextWriter TWCounty = new HtmlTextWriter(SWCounty);

        string Summary = SWSummary.GetStringBuilder().ToString().Replace("Download in Excel", " ").Replace(filterLinkText, "");

        if (objReport.ReportingStyle == "0")
        {
            s = "<br/> <span style='font-size:13pt; font-weight:bold; text-align:center;'>" + FileName + "</span> <br/><br/>" + Summary + "<br/><br/><hr style='border:1px double Gray;' />";
        }
        else if (ds.Tables.Count > 2)
        {
            s = "<br/> <span style='font-size:13pt; font-weight:bold; text-align:center;'>" + FileName + "</span> <br/><br/>" + Summary + "<br/><br/><hr style='border:1px double Gray;' />" + SWDetailed.GetStringBuilder().ToString().Replace("Hide Details", " ").Replace("Close", " ");
        }
        else
        {
            s = "<br/> <span style='font-size:13pt; font-weight:bold; text-align:center;'>" + FileName + "</span> <br/><br/>" + Summary + "<br/><br/><hr style='border:1px double Gray;' />";
        }
        if (objReport.ReportType == "5")
        {
            //To not show in PDF
            btnExport.Attributes.Add("style", "display:none;");
            btnExporttoPDF.Attributes.Add("style", "display:none;");
            GVCountyReport.AllowPaging = false;
            GVCountyReportOS.AllowPaging = false;

            CountyReport.RenderControl(TWCounty);
            s += SWCounty.GetStringBuilder().ToString().Replace("No Records Found", null).Replace("for Services Requested.", "").Replace("for Other Services.", "");

            if (GVCountyReport.Rows.Count == 0)
                s = s.Replace("County wide Services Requested:", "");

            if (GVCountyReportOS.Rows.Count == 0)
                s = s.Replace("County wide Other Services:", "");

        }

        ConvertToPDF(s, "ADRC Report");

    }
    /// <summary>
    /// Created by SA
    /// Remove links from excel/pdf from being rendered as.
    /// </summary>
    /// <param name="gridview"></param>
    private void RemoveLinksFRomExcelPDF(GridView gridview)
    {
        foreach (GridViewRow row in gridview.Rows)
        {

            foreach (TableCell cell in row.Cells)
            {

                List<Control> controls = new List<Control>();

                //Add controls to be removed to Generic List
                foreach (Control control in cell.Controls)
                {
                    controls.Add(control);
                }

                //Loop through the controls to be removed and replace then with Literal
                foreach (Control control in controls)
                {
                    switch (control.GetType().Name)
                    {
                        case "HtmlAnchor":
                            cell.Controls.Add(new Literal { Text = (control as HtmlAnchor).InnerHtml });
                            break;
                        case "Label":
                            cell.Controls.Add(new Literal { Text = (control as Label).Text });
                            break;
                    }
                    cell.Controls.Remove(control);
                }
            }
        }
    }
    /// <summary>
    /// Created by SA.
    /// Purpose: To export needy details in the excel format for duplicate/unduplicate/ OR without these.
    /// </summary>
    /// <param name="ds"></param>
    /// <param name="CountType"></param>
    public void ExportNeedyDetailsToExcel(DataTable ds, string CountType)
    {
        ADRCReport objReport = (ADRCReport)Session["ObjReport"];
        string s = string.Empty, FileName, NeedyDetailsCountType = string.Empty;
        FileName = (objReport.ReportingStyle == "0") ? "Summary Report" : "Detailed Report";
        Response.AppendHeader("content-disposition", "attachment;filename=Client_Details.xls");
        Response.Charset = "";
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.ContentType = "application/vnd.ms-excel";
        this.EnableViewState = false;

        RemoveLinksFRomExcelPDF(DLDupeService);
        RemoveLinksFRomExcelPDF(DLDupeOtherService);//Added by KP on 15th April 2020(SOW-577), Remove hyperlink.

        StringWriter SWSummary = new StringWriter();
        HtmlTextWriter TWSummary = new HtmlTextWriter(SWSummary);
        ExcelData.RenderControl(TWSummary);

        StringWriter SNeedyDetails = new StringWriter();
        HtmlTextWriter TWNeedyDetails = new HtmlTextWriter(SNeedyDetails);
        DataGrid DG = new DataGrid();
        DG.DataSource = ds;
        DG.DataBind();
        DG.HeaderStyle.Font.Bold = true;
        DG.RenderControl(TWNeedyDetails);

        if (CountType == "D")
        {
            NeedyDetailsCountType = "Duplicate client details with latest call information.";
        }
        else if (CountType == "U")
        {
            NeedyDetailsCountType = "Unduplicate client details with latest call information.";
        }
        else if (CountType == "C")
        {
            NeedyDetailsCountType = "Client details with contacts information.";
        }
        else
        {
            NeedyDetailsCountType = "Client details with latest call information.";
        }

        string Summary = SWSummary.GetStringBuilder().ToString().Replace("Download in Excel", " ").Replace(filterLinkText, "");
        s = "<br/> <span style='font-size:13pt; font-weight:bold; text-align:center;'>" + FileName + "</span> <br/><br/>" + Summary + "<hr style='border:1px double Gray;' /><span style='font-size:13pt; background-color: Gray; font-weight:bold;'>" + NeedyDetailsCountType + "</span>" + "<br/>" + SNeedyDetails.GetStringBuilder();

        Response.Write(s);
        Response.End();
        SWSummary.Dispose();
        TWSummary.Dispose();
        SNeedyDetails.Dispose();
        TWNeedyDetails.Dispose();
    }
    /// <summary>
    /// Created by: SA on 12th Aug, 2K14.
    /// Purpose: To generate dynamic Totals according to the County & City in the DataSet and then bind to the GridView.
    /// </summary>
    private void BindGVCountyReport(DataTable dt)
    {
        GVCountyReport.DataSource = GenerateCountyReport(dt);
        GVCountyReport.DataBind();
        GenerateUniqueData(GVCountyReport);
    }

    /// <summary>
    /// Created by SA on 13th August, 2014
    /// Purpose:  Verifies that the control is rendered.
    /// </summary>
    /// <param name="control"></param>
    public override void VerifyRenderingInServerForm(Control control)
    { }
    public void ConvertToPDF(string exportPdfExcel, string FileName)
    {

        string printcontant = exportPdfExcel;
        try
        {
            string data = @"<html><head><style type='text/css'>

  Div.header
        {
         text-align: center; font-weight: bold;
        }
.text-right
{
text-align:right;}
        table
        {
            font-family: verdana,arial,sans-serif;
            font-size: 10px;
            color: #333333;
            border-width: 1px;
            border-color: #666666;
            border-collapse: collapse;
            width:100% !important;
        }
        
        table th
        {
            color: #666666;
            border-width: 1px;
            padding: 5px;
            border-style: solid;
            border-color: #666666;
                 
        }
        
        table td
        {
          /*  border-width: 1px;
            padding: 5px;
            border-style: solid;
            border-color: #666666;
            font-weight:bold;*/
            text-align:left;
            
        }
    </style></head><body>" + HttpUtility.UrlDecode(printcontant) + "</body></html>";

            TakeScreenShotOfPage(exportPdfExcel, FileName);
        }
        catch (Exception p)
        {
        }
    }
    private void TakeScreenShotOfPage(string strHtmlSource, string tempFileName)
    {
        if ((string.IsNullOrEmpty(strHtmlSource) | strHtmlSource == string.Empty))
        {
            return;
        }
        PdfConverter pdfConverter = new PdfConverter();
        pdfConverter.PdfDocumentOptions.LeftMargin = 10;
        pdfConverter.PdfDocumentOptions.RightMargin = 10;
        pdfConverter.PdfDocumentOptions.TopMargin = 5;
        pdfConverter.PdfDocumentOptions.BottomMargin = 5;
        pdfConverter.PdfFooterOptions.DrawFooterLine = true;



        pdfConverter.PdfDocumentOptions.InternalLinksEnabled = false;
        pdfConverter.PdfDocumentOptions.LiveUrlsEnabled = false;
        pdfConverter.PdfFooterOptions.FooterText = System.DateTime.Now.ToString("dd-MMM-yyyy");
        pdfConverter.PdfFooterOptions.PageNumberText = "Page";
        pdfConverter.PdfFooterOptions.ShowPageNumber = true;
        pdfConverter.PdfDocumentOptions.PdfCompressionLevel = PdfCompressionLevel.Best;
        pdfConverter.PdfHeaderOptions.HeaderText = tempFileName;
        pdfConverter.PdfHeaderOptions.HeaderTextColor = System.Drawing.Color.Black;
        pdfConverter.PdfDocumentOptions.ShowHeader = true;
        pdfConverter.PdfDocumentOptions.ShowFooter = true;
        pdfConverter.PdfDocumentOptions.AutoSizePdfPage = true;
        pdfConverter.OptimizePdfPageBreaks = true;
        //pdfConverter.PageWidth = 0;
        // set the demo license key
        pdfConverter.LicenseKey = "2fLo+eH56Onp7Pnh9+n56uj36Ov34ODg4A==";

        // get the base url for string conversion which is the url from where the html code was retrieved
        // the base url is a hint for the converter to find the external CSS and images referenced by relative URLs

        string baseUrl = HttpContext.Current.Request.Url.AbsoluteUri;

        // get the pdf bytes from html string
        if (File.Exists("~/PDFReport/" + tempFileName + ".pdf"))
            File.Delete("~/PDFReport/" + tempFileName + ".pdf");

        byte[] downloadBytes = pdfConverter.GetPdfBytesFromHtmlString(strHtmlSource, baseUrl);
        if ((!Directory.Exists((Server.MapPath("~\\PDFReport")))))
        {
            Directory.CreateDirectory((Server.MapPath("~\\PDFReport")));
        }

        tempFileName = Convert.ToString((Server.MapPath("~\\PDFReport") + "\\" + tempFileName + ".pdf"));
        FileStream oFileStream = default(FileStream);
        oFileStream = new FileStream(tempFileName, FileMode.Create);
        oFileStream.Write(downloadBytes, 0, downloadBytes.Length);
        oFileStream.Close();

        System.Web.HttpResponse response = System.Web.HttpContext.Current.Response;
        response.Clear();
        //response.AddHeader("Content-Type", "binary/octet-stream");
        //response.AddHeader("Content-Disposition", "attachment; filename=" + tempFileName + ".pdf; " + downloadBytes.Length.ToString());
        //response.Flush();
        response.BinaryWrite(downloadBytes);
        response.Flush();
        response.End();

    }

    /// <summary>
    /// Created by: KP on 28th April 2020(SOW-577)
    /// Purpose: To generate dynamic Totals according to the County & City in the DataSet and then bind to the Other Service GridView.
    /// </summary>
    void BindGVCountyReportOS(DataTable dt)
    {
        GVCountyReportOS.DataSource = GenerateCountyReport(dt);
        GVCountyReportOS.DataBind();
        GenerateUniqueData(GVCountyReportOS);
    }

    /// <summary>
    /// Created by: KP on 27th April 2020(SOW-577)
    /// Purpose: To generate dynamic Totals according to the County & City in the DataTable.
    /// and fix the issues of displaying wrong Total for City and County.
    /// </summary>
    DataTable GenerateCountyReport(DataTable dt)
    {
        string TotalYes = string.Empty, TotalNo = string.Empty;
        string CurrentCounty = string.Empty, CurrentCity = string.Empty, NextCounty = string.Empty, NextCity = string.Empty;

        if (dt.Rows.Count > 0)
        {
            CurrentCounty = dt.Rows[0]["CountyName"].ToString();
            CurrentCity = dt.Rows[0]["CityName"].ToString();

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (i < dt.Rows.Count - 1)
                {
                    NextCounty = dt.Rows[i + 1]["CountyName"].ToString();
                    NextCity = dt.Rows[i + 1]["CityName"].ToString();

                    if (CurrentCity != NextCity || CurrentCounty != NextCounty)//Add CurrentCounty != NextCounty codition to include city wide total, whenever cities are equal in diffrent counties.
                    {
                        CurrentCity = NextCity;

                        DataRow newrow = dt.NewRow();
                        newrow["CountyName"] = CurrentCounty;
                        newrow["CityName"] = "<b>Total</b>";
                        newrow["TotalPerson_CountyCityService"] = "<b>" + dt.Rows[i]["TotalPerson_City"].ToString() + "</b>";
                        TotalYes = dt.Rows[i]["TotalPersonServiceNeedMet_Yes_City"].ToString();
                        TotalNo = dt.Rows[i]["TotalPersonServiceNeedMet_No_City"].ToString();
                        newrow["ServiceNeedMetYes_No"] = "<b>Yes: " + TotalYes + " No:   " + TotalNo + "</b>";
                        dt.Rows.InsertAt(newrow, i + 1);

                        dt.AcceptChanges();
                        i++;
                    }

                    if (CurrentCounty != NextCounty)
                    {
                        CurrentCounty = NextCounty;

                        DataRow newrow = dt.NewRow();
                        newrow["CountyName"] = "<b>Total</b>";
                        newrow["TotalPerson_CountyCityService"] = "<b>" + dt.Rows[i - 1]["TotalPerson_County"].ToString() + "</b>";
                        TotalYes = dt.Rows[i - 1]["TotalPersonServiceNeedMet_YES_County"].ToString();
                        TotalNo = dt.Rows[i - 1]["TotalPersonServiceNeedMet_No_County"].ToString();
                        newrow["ServiceNeedMetYes_No"] = "<b>Yes: " + TotalYes + " No:   " + TotalNo + "</b>";
                        dt.Rows.InsertAt(newrow, i + 1);

                        dt.AcceptChanges();
                        i++;
                    }
                }
                else //last row
                {
                    DataRow TotalCity = dt.NewRow();
                    //TotalCity["CountyName"] = CurrentCounty;
                    TotalCity["CityName"] = "<b>Total</b>";
                    TotalCity["TotalPerson_CountyCityService"] = "<b>" + dt.Rows[i]["TotalPerson_City"].ToString() + "</b>";
                    TotalYes = dt.Rows[i]["TotalPersonServiceNeedMet_Yes_City"].ToString();
                    TotalNo = dt.Rows[i]["TotalPersonServiceNeedMet_No_City"].ToString();
                    TotalCity["ServiceNeedMetYes_No"] = "<b>Yes: " + TotalYes + " No: " + TotalNo + "</b>";
                    dt.Rows.InsertAt(TotalCity, i + 1);
                    i++;

                    DataRow totalCounty = dt.NewRow();
                    totalCounty["CountyName"] = "<b>Total</b>";
                    totalCounty["TotalPerson_CountyCityService"] = "<b>" + dt.Rows[i - 1]["TotalPerson_County"].ToString() + "</b>";
                    TotalYes = dt.Rows[i - 1]["TotalPersonServiceNeedMet_YES_County"].ToString();
                    TotalNo = dt.Rows[i - 1]["TotalPersonServiceNeedMet_No_County"].ToString();
                    totalCounty["ServiceNeedMetYes_No"] = "<b>Yes: " + TotalYes + " No: " + TotalNo + "</b>";
                    dt.Rows.InsertAt(totalCounty, i + 2);

                    dt.AcceptChanges();

                    i = dt.Rows.Count;
                }
            }
        }

        return dt;
    }



    //Added by KP on 8th May 2020(TaskID-12017), To prepare a dataset of datatables to generate filter report.
    DataSet CommonFilter(out string FileName)
    {
        ADRCReport objReport = (ADRCReport)Session["ObjReport"];
        DataSet ds = (DataSet)Session["ReportData"];

        DataSet ReportDS = new DataSet("ReportDS");

        DataTable tblCommon = new DataTable("CommonFilter");
        tblCommon.Columns.Add("FileName", Type.GetType("System.String"));
        tblCommon.Columns.Add("ReportPeriod", Type.GetType("System.String"));
        tblCommon.Columns.Add("ReportRunOn", Type.GetType("System.String"));
        tblCommon.Columns.Add("ReportType", Type.GetType("System.String"));
        tblCommon.Columns.Add("ReportTypeText", Type.GetType("System.String"));
        tblCommon.Columns.Add("ReportingStyle", Type.GetType("System.String"));
        tblCommon.Columns.Add("AdvanceFilter", Type.GetType("System.Boolean"));
        tblCommon.Columns.Add("Agency", Type.GetType("System.String"));
        tblCommon.Columns.Add("County", Type.GetType("System.String"));
        tblCommon.Columns.Add("City", Type.GetType("System.String"));
        tblCommon.Columns.Add("Township", Type.GetType("System.String"));
        tblCommon.Columns.Add("CustomField", Type.GetType("System.String"));
        tblCommon.Columns.Add("Service", Type.GetType("System.String"));
        tblCommon.Columns.Add("OtherService", Type.GetType("System.String"));
        tblCommon.Columns.Add("ReferredBy", Type.GetType("System.String"));
        tblCommon.Columns.Add("ReferredTo", Type.GetType("System.String"));
        tblCommon.Columns.Add("StaffName", Type.GetType("System.String"));
        tblCommon.Columns.Add("TotalRecords", Type.GetType("System.Int32"));
        tblCommon.Columns.Add("IsDetailReportAllowed", Type.GetType("System.Boolean"));
        tblCommon.Columns.Add("FundsProvidedAmount", Type.GetType("System.Decimal"));

        string Agency = "", County = "", City = "", Township = "", CustomField = "", ServiceName = "", OtherServiceName = "",
            ReferredBy = "", ReferredTo = "", StaffName = "", FundsAmount = "";
        bool IsDetailReportAllowed = false;
        int TotalRecords = 0;
        decimal? FundsProvidedAmount = null;

        #region Common filter

        FileName = (objReport.ReportingStyle == "0") ? "Summary Report" : "Detailed Report";

        if (MySession.blnADRCIAOSAAdmin == false)
            Agency = MySession.AAAAgencyName;
        else
        {
            if (objReport.AgencyLength != "0")
                Agency = (objReport.AgencyLength == string.Empty) ? objReport.AgencyText : "All";
            else
                Agency = "N/A";
        }

        if (objReport.CountyLength != "0")
            County = (objReport.CountyLength == string.Empty) ? objReport.County : "All";
        else
            County = "N/A";

        if (objReport.CityLength != "0")
            City = (objReport.CityLength == string.Empty) ? objReport.City : "All";
        else
            City = "N/A";

        if (objReport.TownshipLength != "0")
        {
            Township = (objReport.TownshipLength == string.Empty) ? objReport.TownshipText : "All";
        }
        else
        {
            Township = "N/A";
        }
        if (objReport.CustomFieldLength != "0")
        {
            CustomField = (objReport.CustomFieldLength == string.Empty) ? objReport.CustomFieldText : "All";
        }
        else
        {
            CustomField = "N/A";
        }

        ReferredBy = (objReport.RefByLength == string.Empty) ? objReport.ReferredByText : "All";

        if (objReport.ServiceLength != "0")
        {
            ServiceName = (objReport.ServiceLength == string.Empty) ? objReport.ServiceText : "All";
        }
        else
        {
            ServiceName = "N/A";
        }

        if (objReport.OtherServiceLength != "0")
        {
            OtherServiceName = (objReport.OtherServiceLength == string.Empty) ? objReport.OtherService : "All";
        }
        else
        {
            OtherServiceName = "N/A";
        }

        ReferredTo = (objReport.RefLength == string.Empty) ? objReport.ReferredToText : "All";
        if (objReport.StaffLength != "0")
        {
            StaffName = (objReport.StaffLength == string.Empty) ? objReport.StaffName : "All";
        }
        else
        {
            StaffName = "N/A";
        }

        tblCommon.Rows.Add(new Object[] { FileName, objReport.DateRangeFrom + " - " + objReport.DateRangeTo, string.Format("{0:g}", DateTime.Now),
            objReport.ReportType, objReport.ReportTypeText, objReport.ReportingStyle, Convert.ToBoolean(objReport.AdvanceFilter),
            Agency, County, City, Township, CustomField, ServiceName, OtherServiceName, ReferredBy, ReferredTo, StaffName});

        #endregion

        #region ReportType = 4

        if (objReport.ReportType == "4")
        {
            DataTable tblReportFourCommon = new DataTable("ReportFourCommon");
            tblReportFourCommon.Columns.Add("DuplicatedClientCount", Type.GetType("System.Int32"));
            tblReportFourCommon.Columns.Add("UnduplicatedClientCount", Type.GetType("System.Int32"));
            tblReportFourCommon.Columns.Add("TotalContacts", Type.GetType("System.Int32"));
            tblReportFourCommon.Columns.Add("UnduplicatedServiceCount", Type.GetType("System.Int32"));

            DataRow dr = tblReportFourCommon.NewRow();
            dr["DuplicatedClientCount"] = Convert.ToInt32(ds.Tables[0].Rows[0]["DuplicateNeedyPerson"]);
            dr["UnduplicatedClientCount"] = Convert.ToInt32(ds.Tables[6].Rows[0]["UnDuplicateClientCount"]);
            dr["TotalContacts"] = Convert.ToInt32(ds.Tables[8].Rows[0]["TotalContactCount"]);
            dr["UnduplicatedServiceCount"] = Convert.ToInt32(ds.Tables[4].Rows[0]["UnDuplicateNPService"]);
            tblReportFourCommon.Rows.Add(dr);
            ReportDS.Tables.Add(tblReportFourCommon);

            DataTable tblReportFourService = ds.Tables[3].Copy();
            tblReportFourService.TableName = "ReportFourService";
            DataColumn colDuplicatedServiceCount = new DataColumn("DuplicatedServiceCount", typeof(System.Int32));
            colDuplicatedServiceCount.DefaultValue = Convert.ToInt32(ds.Tables[2].Rows[0]["DuplicateNPService"]);
            tblReportFourService.Columns.Add(colDuplicatedServiceCount);
            ReportDS.Tables.Add(tblReportFourService);

            DataTable tblReportFourOtherService = ds.Tables[11].Copy();
            tblReportFourOtherService.TableName = "ReportFourOtherService";
            DataColumn colOtherServiceCount = new DataColumn("OtherServiceCount", typeof(System.Int32));
            colOtherServiceCount.DefaultValue = Convert.ToInt32(ds.Tables[10].Rows[0]["DuplicateNPOtherService"]);
            tblReportFourOtherService.Columns.Add(colOtherServiceCount);
            ReportDS.Tables.Add(tblReportFourOtherService);

        }

        #endregion

        #region ReportType = 5

        if (objReport.ReportType == "5")
        {
            DataTable tblReportFiveService = FormatUniqueData(ds.Tables[0].Copy());
            tblReportFiveService.TableName = "ReportFiveService";
            ReportDS.Tables.Add(tblReportFiveService);

            DataTable tblReportFiveOtherService = FormatUniqueData(ds.Tables[1].Copy());
            tblReportFiveOtherService.TableName = "ReportFiveOtherService";
            ReportDS.Tables.Add(tblReportFiveOtherService);

        }

        #endregion

        #region ReportType 0 - 3 

        if (objReport.ReportType != "4" && objReport.ReportType != "5")
        {
            TotalRecords = Convert.ToInt32(ds.Tables[0].Rows[0]["PersonCount"]);

            //Detailed report binding section..
            if (ds.Tables.Count > 2)
            {
                IsDetailReportAllowed = true;

                DataTable tblContactType = new DataTable("ContactType");
                tblContactType.Columns.Add("ContactTypeName", Type.GetType("System.String"));

                DataTable tblContactMethod = new DataTable("ContactMethod");
                tblContactMethod.Columns.Add("ContactMethodName", Type.GetType("System.String"));

                DataTable tblAge = new DataTable("Age");
                tblAge.Columns.Add("AgeGroup", Type.GetType("System.String"));

                DataTable tblGender = new DataTable("Gender");
                tblGender.Columns.Add("Gender", Type.GetType("System.String"));

                DataTable tblMaritalStatus = new DataTable("MaritalStatus");
                tblMaritalStatus.Columns.Add("MaritalStatus", Type.GetType("System.String"));

                DataTable tblLivingArrangement = new DataTable("LivingArrangement");
                tblLivingArrangement.Columns.Add("LivingArrangement", Type.GetType("System.String"));

                DataTable tblDemographics = new DataTable("Demographics");
                tblDemographics.Columns.Add("IsDemographics", Type.GetType("System.String"));

                DataTable tblRace = new DataTable("Race");
                tblRace.Columns.Add("Race", Type.GetType("System.String"));

                DataTable tblPrimaryLanguage = new DataTable("PrimaryLanguage");
                tblPrimaryLanguage.Columns.Add("PrimaryLanguage", Type.GetType("System.String"));

                DataTable tblEthnicity = new DataTable("Ethnicity");
                tblEthnicity.Columns.Add("Ethnicity", Type.GetType("System.String"));

                DataTable tblVeteranApplicable = new DataTable("VeteranApplicable");
                tblVeteranApplicable.Columns.Add("VeteranApplicable", Type.GetType("System.String"));

                DataTable tblVeteranStatus = new DataTable("VeteranStatus");
                tblVeteranStatus.Columns.Add("VeteranStatus", Type.GetType("System.String"));

                DataTable tblCaregiverStatus = new DataTable("CaregiverStatus");
                tblCaregiverStatus.Columns.Add("CaregiverStatus", Type.GetType("System.String"));

                DataTable tblServiceNetMet = new DataTable("ServiceNetMet");
                tblServiceNetMet.Columns.Add("ServiceNetMet", Type.GetType("System.String"));

                DataTable tblFollowupCompleted = new DataTable("FollowupCompleted");
                tblFollowupCompleted.Columns.Add("FollowupCompleted", Type.GetType("System.String"));

                DataTable tblReferredOC = new DataTable("ReferredOC");
                tblReferredOC.Columns.Add("IsReferredOC", Type.GetType("System.String"));

                DataTable tblFundsProvided = new DataTable("FundsProvided");
                tblFundsProvided.Columns.Add("IsFundsProvided", Type.GetType("System.String"));

                DataTable tblFundsUtilized = new DataTable("FundsUtilized");
                tblFundsUtilized.Columns.Add("FundsUtilized", Type.GetType("System.String"));

                if (ds.Tables[2].Rows.Count > 0)
                {
                    var result = (from dataRows1 in ds.Tables[2].AsEnumerable()
                                  select tblContactType.LoadDataRow(new object[]
                                  {
                                     dataRows1.Field<string>("ContactTypeName") + " <b>:</b> "+ Convert.ToString(dataRows1.Field<int>("CMPerson Count"))
                                  }, false));

                    result.CopyToDataTable();
                }

                if (ds.Tables[3].Rows.Count > 0)
                {
                    var result = (from dataRows1 in ds.Tables[3].AsEnumerable()
                                  select tblContactMethod.LoadDataRow(new object[]
                                  {
                                     dataRows1.Field<string>("ContactMethodName") + " <b>:</b> "+ Convert.ToString(dataRows1.Field<int>("Person Count"))
                                  }, false));

                    result.CopyToDataTable();
                }

                if (ds.Tables[4].Rows.Count > 0)
                {
                    var result = (from dataRows1 in ds.Tables[4].AsEnumerable()
                                  select tblAge.LoadDataRow(new object[]
                                  {
                                     dataRows1.Field<string>("AgeGroup") + " <b>:</b> "+ Convert.ToString(dataRows1.Field<int>("PersonCount"))
                                  }, false));

                    result.CopyToDataTable();
                }

                if (ds.Tables[5].Rows.Count > 0)
                {
                    var result = (from dataRows1 in ds.Tables[5].AsEnumerable()
                                  select tblGender.LoadDataRow(new object[]
                                  {
                                     dataRows1.Field<string>("Gender") + " <b>:</b> "+ Convert.ToString(dataRows1.Field<int>("Person Count"))
                                  }, false));

                    result.CopyToDataTable();
                }

                if (ds.Tables[6].Rows.Count > 0)
                {
                    var result = (from dataRows1 in ds.Tables[6].AsEnumerable()
                                  select tblMaritalStatus.LoadDataRow(new object[]
                                  {
                                     dataRows1.Field<string>("MaritalStatus") + " <b>:</b> "+ Convert.ToString(dataRows1.Field<int>("PersonCount"))
                                  }, false));

                    result.CopyToDataTable();
                }

                if (ds.Tables[7].Rows.Count > 0)
                {
                    var result = (from dataRows1 in ds.Tables[7].AsEnumerable()
                                  select tblLivingArrangement.LoadDataRow(new object[]
                                  {
                                     dataRows1.Field<string>("LivingArrangement") + " <b>:</b> "+ Convert.ToString(dataRows1.Field<int>("PersonCount"))
                                  }, false));

                    result.CopyToDataTable();
                }

                if (ds.Tables[8].Rows.Count > 0)
                {
                    var result = (from dataRows1 in ds.Tables[8].AsEnumerable()
                                  select tblRace.LoadDataRow(new object[]
                                  {
                                     dataRows1.Field<string>("Race") + " <b>:</b> "+ Convert.ToString(dataRows1.Field<int>("PersonCount"))
                                  }, false));

                    result.CopyToDataTable();
                }

                if (ds.Tables[9].Rows.Count > 0)
                {
                    var result = (from dataRows1 in ds.Tables[9].AsEnumerable()
                                  select tblVeteranApplicable.LoadDataRow(new object[]
                                  {
                                     dataRows1.Field<string>("VeteranApplicable") + " <b>:</b> "+ Convert.ToString(dataRows1.Field<int>("PersonCount"))
                                  }, false));

                    result.CopyToDataTable();
                }

                if (ds.Tables[10].Rows.Count > 0)
                {
                    var result = (from dataRows1 in ds.Tables[10].AsEnumerable()
                                  select tblVeteranStatus.LoadDataRow(new object[]
                                  {
                                     dataRows1.Field<string>("VeteranStatus") + " <b>:</b> "+ Convert.ToString(dataRows1.Field<int>("PersonCount"))
                                  }, false));

                    result.CopyToDataTable();
                }

                if (ds.Tables[17].Rows.Count > 0)
                {
                    var result = (from dataRows1 in ds.Tables[17].AsEnumerable()
                                  select tblFollowupCompleted.LoadDataRow(new object[]
                                  {
                                     dataRows1.Field<string>("FollowupCompleted") + " <b>:</b> "+ Convert.ToString(dataRows1.Field<int>("PersonCount"))
                                  }, false));

                    result.CopyToDataTable();
                }

                if (ds.Tables[18].Rows.Count > 0)
                {
                    var result = (from dataRows1 in ds.Tables[18].AsEnumerable()
                                  select tblServiceNetMet.LoadDataRow(new object[]
                                  {
                                     dataRows1.Field<string>("ServiceNetMet") + " <b>:</b> "+ Convert.ToString(dataRows1.Field<int>("PersonCount"))
                                  }, false));

                    result.CopyToDataTable();
                }

                if (ds.Tables[19].Rows.Count > 0)
                {
                    var result = (from dataRows1 in ds.Tables[19].AsEnumerable()
                                  select tblEthnicity.LoadDataRow(new object[]
                                  {
                                     dataRows1.Field<string>("Ethnicity") + " <b>:</b> "+ Convert.ToString(dataRows1.Field<int>("PersonCount"))
                                  }, false));

                    result.CopyToDataTable();
                }

                if (ds.Tables[22].Rows.Count > 0)
                {
                    var result = (from dataRows1 in ds.Tables[22].AsEnumerable()
                                  select tblPrimaryLanguage.LoadDataRow(new object[]
                                  {
                                     dataRows1.Field<string>("PrimaryLanguage") + " <b>:</b> "+ Convert.ToString(dataRows1.Field<int>("PersonCount"))
                                  }, false));

                    result.CopyToDataTable();
                }

                if (ds.Tables[23].Rows.Count > 0)
                {
                    var result = (from dataRows1 in ds.Tables[23].AsEnumerable()
                                  select tblReferredOC.LoadDataRow(new object[]
                                  {
                                     dataRows1.Field<string>("IsReferredOC") + " <b>:</b> "+ Convert.ToString(dataRows1.Field<int>("PersonCount"))
                                  }, false));

                    result.CopyToDataTable();
                }
                if (ds.Tables[24].Rows.Count > 0)
                {
                    var result = (from dataRows1 in ds.Tables[24].AsEnumerable()
                                  select tblFundsProvided.LoadDataRow(new object[]
                                  {
                                     dataRows1.Field<string>("IsFundsProvided") + " <b>:</b> "+ Convert.ToString(dataRows1.Field<int>("PersonCount"))
                                  }, false));

                    result.CopyToDataTable();
                }

                FundsProvidedAmount = !string.IsNullOrEmpty(ds.Tables[25].Rows[0]["FundsProvidedAmount"].ToString()) ? Convert.ToDecimal(ds.Tables[25].Rows[0]["FundsProvidedAmount"]) : (decimal?)null;

                if (ds.Tables[26].Rows.Count > 0)
                {
                    var result = (from dataRows1 in ds.Tables[26].AsEnumerable()
                                  select tblFundsUtilized.LoadDataRow(new object[]
                                  {
                                     dataRows1.Field<string>("FundsUtilized") + " <b>:</b> "+ Convert.ToString(dataRows1.Field<int>("PersonCount"))
                                  }, false));

                    result.CopyToDataTable();
                }

                if (ds.Tables[27].Rows.Count > 0)
                {
                    var result = (from dataRows1 in ds.Tables[27].AsEnumerable()
                                  select tblCaregiverStatus.LoadDataRow(new object[]
                                  {
                                     dataRows1.Field<string>("CaregiverStatus") + " <b>:</b> "+ Convert.ToString(dataRows1.Field<int>("PersonCount"))
                                  }, false));

                    result.CopyToDataTable();
                }

                if (ds.Tables[28].Rows.Count > 0)
                {
                    var result = (from dataRows1 in ds.Tables[28].AsEnumerable()
                                  select tblDemographics.LoadDataRow(new object[]
                                  {
                                     dataRows1.Field<string>("IsDemographics") + " <b>:</b> "+ Convert.ToString(dataRows1.Field<int>("PersonCount"))
                                  }, false));

                    result.CopyToDataTable();
                }


                //Details Filter
                ReportDS.Tables.Add(tblContactType);
                ReportDS.Tables.Add(tblContactMethod);
                ReportDS.Tables.Add(tblAge);
                ReportDS.Tables.Add(tblGender);
                ReportDS.Tables.Add(tblMaritalStatus);
                ReportDS.Tables.Add(tblLivingArrangement);

                ReportDS.Tables.Add(tblDemographics);
                ReportDS.Tables.Add(tblRace);
                ReportDS.Tables.Add(tblPrimaryLanguage);
                ReportDS.Tables.Add(tblEthnicity);
                ReportDS.Tables.Add(tblVeteranApplicable);
                ReportDS.Tables.Add(tblVeteranStatus);
                ReportDS.Tables.Add(tblCaregiverStatus);
                ReportDS.Tables.Add(tblServiceNetMet);
                ReportDS.Tables.Add(tblFollowupCompleted);
                ReportDS.Tables.Add(tblReferredOC);
                ReportDS.Tables.Add(tblFundsProvided);
                ReportDS.Tables.Add(tblFundsUtilized);

                DataTable tblCounty = ds.Tables[13].Copy();
                tblCounty.TableName = "County";
                DataColumn colTotalCounty = new DataColumn("TotalCounty", typeof(System.Int32));
                colTotalCounty.DefaultValue = Convert.ToInt32(ds.Tables[11].Rows[0]["County"]);
                tblCounty.Columns.Add(colTotalCounty);
                ReportDS.Tables.Add(tblCounty);

                DataTable tblCity = ds.Tables[14].Copy();
                tblCity.TableName = "City";
                DataColumn colTotalCity = new DataColumn("TotalCity", typeof(System.Int32));
                colTotalCity.DefaultValue = Convert.ToInt32(ds.Tables[12].Rows[0]["City"]);
                tblCity.Columns.Add(colTotalCity);
                ReportDS.Tables.Add(tblCity);

                DataTable tblTownship = ds.Tables[29].Copy();
                tblTownship.TableName = "Township";
                DataColumn colTotalTownship = new DataColumn("TotalTownship", typeof(System.Int32));
                colTotalTownship.DefaultValue = Convert.ToInt32(ds.Tables[30].Rows[0]["TownshipCount"]);
                tblTownship.Columns.Add(colTotalTownship);
                ReportDS.Tables.Add(tblTownship);

                DataTable tblCustomField = ds.Tables[31].Copy();
                tblCustomField.TableName = "CustomField";
                DataColumn colTotalCustomField = new DataColumn("TotalCustomField", typeof(System.Int32));
                colTotalCustomField.DefaultValue = Convert.ToInt32(ds.Tables[32].Rows[0]["CustomCount"]);
                tblCustomField.Columns.Add(colTotalCustomField);
                ReportDS.Tables.Add(tblCustomField);

                DataTable tblService = ds.Tables[16].Copy();
                tblService.TableName = "Service";
                DataColumn colTotalService = new DataColumn("TotalService", typeof(System.Int32));
                colTotalService.DefaultValue = Convert.ToInt32(ds.Tables[15].Rows[0]["ServiceCount"]);
                tblService.Columns.Add(colTotalService);
                ReportDS.Tables.Add(tblService);

                DataTable tblOtherService = ds.Tables[34].Copy();
                tblOtherService.TableName = "OtherService";
                DataColumn colTotalOtherService = new DataColumn("TotalOtherService", typeof(System.Int32));
                colTotalOtherService.DefaultValue = Convert.ToInt32(ds.Tables[33].Rows[0]["OtherServiceCount"]);
                tblOtherService.Columns.Add(colTotalOtherService);
                ReportDS.Tables.Add(tblOtherService);

                DataTable tblStaff = ds.Tables[21].Copy();
                tblStaff.TableName = "Staff";
                DataColumn colTotalStaff = new DataColumn("TotalStaff", typeof(System.Int32));
                colTotalStaff.DefaultValue = Convert.ToInt32(ds.Tables[20].Rows[0]["StaffCount"]);
                tblStaff.Columns.Add(colTotalStaff);
                ReportDS.Tables.Add(tblStaff);


            }

        }

        #endregion

        #region Advance filter

        if (Convert.ToBoolean(objReport.AdvanceFilter))
        {
            DataTable tblAdvance = new DataTable("AdvanceFilter");
            tblAdvance.Columns.Add("ContactMethod", Type.GetType("System.String"));
            tblAdvance.Columns.Add("Date", Type.GetType("System.String"));
            tblAdvance.Columns.Add("AgeRange", Type.GetType("System.String"));
            tblAdvance.Columns.Add("ContactType", Type.GetType("System.String"));
            tblAdvance.Columns.Add("Gender", Type.GetType("System.String"));
            tblAdvance.Columns.Add("MaritalStatus", Type.GetType("System.String"));
            tblAdvance.Columns.Add("LivingArrangement", Type.GetType("System.String"));
            tblAdvance.Columns.Add("Race", Type.GetType("System.String"));
            tblAdvance.Columns.Add("NoDemographics", Type.GetType("System.String"));
            tblAdvance.Columns.Add("PrimaryLanguage", Type.GetType("System.String"));
            tblAdvance.Columns.Add("Ethnicity", Type.GetType("System.String"));
            tblAdvance.Columns.Add("VeteranApplicable", Type.GetType("System.String"));
            tblAdvance.Columns.Add("VeteranStatus", Type.GetType("System.String"));
            tblAdvance.Columns.Add("ServiceNeedMet", Type.GetType("System.String"));
            tblAdvance.Columns.Add("FollowUp", Type.GetType("System.String"));
            tblAdvance.Columns.Add("ReferredforOC", Type.GetType("System.String"));
            tblAdvance.Columns.Add("ReferredforOCDate", Type.GetType("System.String"));
            tblAdvance.Columns.Add("IsFundProvided", Type.GetType("System.String"));
            tblAdvance.Columns.Add("FundsAmount", Type.GetType("System.String"));
            tblAdvance.Columns.Add("FundsDate", Type.GetType("System.String"));
            tblAdvance.Columns.Add("CaregiverNeedyPerson", Type.GetType("System.String"));
            tblAdvance.Columns.Add("FundsUtilizedfor", Type.GetType("System.String"));
            tblAdvance.Columns.Add("ProfInfo", Type.GetType("System.String"));
            tblAdvance.Columns.Add("ProxyInfo", Type.GetType("System.String"));
            tblAdvance.Columns.Add("FamilyInfo", Type.GetType("System.String"));
            tblAdvance.Columns.Add("OtherInfo", Type.GetType("System.String"));
            tblAdvance.Columns.Add("CaregiverInfo", Type.GetType("System.String"));

            DataRow dr = tblAdvance.NewRow();
            dr["ContactMethod"] = (objReport.ContactMethodText != "") ? objReport.ContactMethodText : "N/A";
            dr["Date"] = (objReport.DateText != "") ? objReport.DateText : DateTime.Now.ToShortDateString();
            dr["AgeRange"] = (objReport.AgeAsOfText != "") ? objReport.AgeAsOfText : "N/A";
            dr["ContactType"] = (objReport.ContactTypeText != "") ? objReport.ContactTypeText : "N/A";
            dr["Gender"] = (objReport.GenderText != "") ? objReport.GenderText : "N/A";
            dr["MaritalStatus"] = (objReport.MaritalStatusText != "") ? objReport.MaritalStatusText : "N/A";
            dr["LivingArrangement"] = (objReport.LivingArrangementText != "") ? objReport.LivingArrangementText : "N/A";
            dr["Race"] = (objReport.RaceText != "") ? objReport.RaceText : "N/A";
            dr["NoDemographics"] = (objReport.IsDemographicsText != "") ? objReport.IsDemographicsText : "N/A";
            dr["PrimaryLanguage"] = (objReport.PrimaryLanguage != "") ? objReport.PrimaryLanguage : "N/A";
            dr["Ethnicity"] = (objReport.EthnicityText != "") ? objReport.EthnicityText : "N/A";
            dr["VeteranApplicable"] = (objReport.VeteranApplicableText != "") ? objReport.VeteranApplicableText : "N/A";
            dr["VeteranStatus"] = (objReport.VeteranStatusText != "") ? objReport.VeteranStatusText : "N/A";
            dr["ServiceNeedMet"] = (objReport.ServiceNeedMetText != "") ? objReport.ServiceNeedMetText : "N/A";
            dr["FollowUp"] = (objReport.FollowUpText != "") ? objReport.FollowUpText : "N/A";
            dr["ReferredforOC"] = (objReport.IsReferredForOCText != "") ? objReport.IsReferredForOCText : "N/A";
            dr["ReferredforOCDate"] = (objReport.IsReferredForOCDate != "") ? objReport.IsReferredForOCDate + " - " + objReport.IsReferredForOCDateTo : "N/A";
            dr["IsFundProvided"] = (objReport.IsFundProvidedText != "") ? objReport.IsFundProvidedText : "N/A";

            if (objReport.IsFundProvidedText == "Yes")
            {
                if (objReport.IsFromAmount == "" && objReport.IsToAmount != "")
                {
                    FundsAmount = "$" + "0" + " - " + Convert.ToDecimal(objReport.IsToAmount);
                }
                else if (objReport.IsFromAmount != "" && objReport.IsToAmount == "")
                {
                    FundsAmount = "$" + Convert.ToDecimal(objReport.IsFromAmount) + " - " + "999";
                }
                else if (objReport.IsFromAmount == "" && objReport.IsToAmount == "")
                {
                    FundsAmount = "$" + "0" + " - " + "999";
                }
                else
                    FundsAmount = (objReport.IsFromAmount != "" && objReport.IsToAmount != "") ? "$" + " " + Convert.ToDecimal(objReport.IsFromAmount) + " - " + Convert.ToDecimal(objReport.IsToAmount) : "N/A";
            }
            else
                FundsAmount = "N/A";

            dr["FundsAmount"] = FundsAmount;
            dr["FundsDate"] = (objReport.FundsProvidedDateFrom != "") ? objReport.FundsProvidedDateFrom + " - " + objReport.FundsProvidedDateTo : "N/A";
            dr["CaregiverNeedyPerson"] = (objReport.CaregiverNeedyPersonText != "") ? objReport.CaregiverNeedyPersonText : "N/A";
            dr["FundsUtilizedfor"] = (objReport.FundsUtilizedforText != "") ? objReport.FundsUtilizedforText : "N/A";
            dr["ProfInfo"] = !string.IsNullOrEmpty(objReport.ProfessionalInfoText) ? objReport.ProfessionalInfoText : "N/A";
            dr["ProxyInfo"] = !string.IsNullOrEmpty(objReport.ProxyInfoText) ? objReport.ProxyInfoText : "N/A";
            dr["FamilyInfo"] = !string.IsNullOrEmpty(objReport.FamilyInfoText) ? objReport.FamilyInfoText : "N/A";
            dr["OtherInfo"] = !string.IsNullOrEmpty(objReport.OtherInfoText) ? objReport.OtherInfoText : "N/A";
            dr["CaregiverInfo"] = !string.IsNullOrEmpty(objReport.CaregiverInfoText) ? objReport.CaregiverInfoText : "N/A";

            tblAdvance.Rows.Add(dr);

            ReportDS.Tables.Add(tblAdvance);//Advance Filter.
        }

        #endregion

        tblCommon.Rows[0]["TotalRecords"] = TotalRecords;
        tblCommon.Rows[0]["IsDetailReportAllowed"] = IsDetailReportAllowed;
        if (FundsProvidedAmount != null)
            tblCommon.Rows[0]["FundsProvidedAmount"] = FundsProvidedAmount;

        ds.Dispose();

        ReportDS.Tables.Add(tblCommon);

        return ReportDS;
    }

    //Added by KP on 25th May 2020(TaskID-12017), To formate the County wide Services datatable.
    DataTable FormatUniqueData(DataTable dt)
    {
        //Logic for unique names
        string county = "", city = "";
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            string CurrCounty = Convert.ToString(dt.Rows[i]["CountyName"]);
            if (CurrCounty == county)
                dt.Rows[i]["CountyName"] = string.Empty;
            else
                county = CurrCounty;

            //City
            string CurrCity = Convert.ToString(dt.Rows[i]["CityName"]);
            if (CurrCity == city)
                dt.Rows[i]["CityName"] = string.Empty;
            else
                city = CurrCity;

            dt.Rows[i]["TotalPerson_CountyCityService"] = Convert.ToString(dt.Rows[i]["TotalPerson_CountyCityService"]).Replace("<b>", "").Replace("</b>", "");

        }

        return dt;

    }

    //Added by KP on 14th May 2020(TaskID-12017), To generate the report in PDF or Excel.
    void ExportToExcelPDF(string Type)
    {
        using (CrystalDecisions.CrystalReports.Engine.ReportDocument Report = new CrystalDecisions.CrystalReports.Engine.ReportDocument())
        {
            string FileName = "";
            DataSet ds = CommonFilter(out FileName);
            FileName = FileName.Trim().Replace(" ", "_");
            Report.Load(HttpContext.Current.Server.MapPath("~/Report/FilterReport.rpt"));
            Report.SetDataSource(ds);

            if (Type == "PDF")
                Report.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, FileName);
            else
                Report.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.Excel, Response, true, FileName);

        }
    }

    #endregion

    #region [WebMethod]

    [WebMethod(CacheDuration = 0)]
    public static void GenADRCReport(ADRCReport objReport)
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (!ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            return;

        string strSiteID = "";
        if (MySession.blnADRCIAOSAAdmin == false)
        {
            strSiteID = MySession.SiteId.ToString();
            objReport.Agency = strSiteID;

        }



        HttpContext.Current.Session["ReportData"] = null;
        HttpContext.Current.Session["ObjReport"] = null;
        // try// try catch commmeted to handle exception from client side
        //{
        HttpContext.Current.Session["ObjReport"] = objReport;
        HttpContext.Current.Session["ReportData"] = ADRCIADAL.GenerateADRCReport(objReport);
        // }
        //catch (Exception ex)
        //{ }
    }

    #endregion

    #region [Control Events]

    protected void btnExport_Click(object sender, EventArgs e)
    {
        //ExportToExcel(DetailedReport);
        ExportToExcelPDF("Excel");
    }
    protected void btnExporttoPDF_Click(object sender, EventArgs e)
    {
        //ExportToPDF(DetailedReport);
        ExportToExcelPDF("PDF");
    }

    protected void A_Click(object sender, EventArgs e)
    {
        if (ViewState["NeedyList"] != null)
        {
            try
            {
                //Added by VK on 03 AUG, 2017. ViewState["AllCallIDList"].ToString().
                DataSet ds = ADRCIADAL.getNeedyPersonDetails(ViewState["NeedyList"].ToString(), ViewState["CallIDList"].ToString(), ViewState["AllCallIDList"].ToString(), 1, SetReportSelectionProp());

                ExportNeedyDetailsToExcel(ds.Tables[0], "N");

            }
            catch (Exception ex) { }
        }
    }

    protected void btnDuplicate_Click(object sender, EventArgs e)
    {
        if (ViewState["DuplicateNeedyPersonID"] != null)
        {
            try
            {
                //Added by VK on 03 AUG, 2017. ViewState["AllCallIDList"].ToString().
                DataSet ds = ADRCIADAL.getNeedyPersonDetails(ViewState["DuplicateNeedyPersonID"].ToString(), ViewState["DuplicateCallIDList"].ToString(), ViewState["AllCallIDList"].ToString(), 1, SetReportSelectionProp());//added by SA on 22nd July, 2015. ViewState["DuplicateCallIDList"].ToString()
                ExportNeedyDetailsToExcel(ds.Tables[0], "D");
            }
            catch (Exception ex) { }
        }
    }

    //added by SA on 8th Dec, 2015 SOW-401
    protected void btnUnDuplicateNPService_ServerClick(object sender, EventArgs e)
    {
        if (ViewState["UnDuplicateNDIDByService"] != null)
        {
            try
            {
                //Added by VK on 03 AUG, 2017. ViewState["AllCallIDList"].ToString().
                DataSet ds = ADRCIADAL.getNeedyPersonDetails(Convert.ToString(ViewState["UnDuplicateNDIDByService"]), Convert.ToString(ViewState["UnDuplicateCallIDListByService"]), ViewState["AllCallIDList"].ToString(), 1, SetReportSelectionProp());
                ExportNeedyDetailsToExcel(ds.Tables[0], "D");
            }
            catch (Exception ex) { throw ex; }
        }
    }

    //Added by:BS on 13-Sep-2016
    //Purpose:To display link to toal contacts
    protected void btnTotalContacts_ServerClick(object sender, EventArgs e)
    {
        if (ViewState["NeedyID"] != null)
        {
            try
            {
                //Added by VK on 03 AUG, 2017. ViewState["AllCallIDList"].ToString().
                DataSet ds = ADRCIADAL.getNeedyPersonDetails(Convert.ToString(ViewState["NeedyID"]), Convert.ToString(ViewState["CallID"]), ViewState["AllCallIDList"].ToString(), 0, SetReportSelectionProp());
                ExportNeedyDetailsToExcel(ds.Tables[0], "C");
            }
            catch (Exception ex) { throw ex; }
        }
    }
    protected void btnUnDupeClient_ServerClick(object sender, EventArgs e)
    {
        if (ViewState["UnDupeClientNDID"] != null)
        {
            try
            {
                //Added by VK on 03 AUG, 2017. ViewState["AllCallIDList"].ToString().
                DataSet ds = ADRCIADAL.getNeedyPersonDetails(Convert.ToString(ViewState["UnDupeClientNDID"]), Convert.ToString(ViewState["UnDupeClientCallID"]), ViewState["AllCallIDList"].ToString(), 1, SetReportSelectionProp());

                ExportNeedyDetailsToExcel(ds.Tables[0], "U");
            }
            catch (Exception ex) { throw ex; }
        }
    }
    protected void ancDupePersonCount_ServerClick(object sender, EventArgs e)
    {
        //HtmlAnchor btn = sender as HtmlAnchor;
        HtmlInputButton btn = sender as HtmlInputButton;
        GridViewRow row = btn.NamingContainer as GridViewRow;
        string NeedyPersonID = Convert.ToString(DLDupeService.DataKeys[row.RowIndex].Values[0]);
        string ContactHistoryId = Convert.ToString(DLDupeService.DataKeys[row.RowIndex].Values[1]);
        try
        {
            //Added by VK on 03 AUG, 2017. ViewState["AllCallIDList"].ToString().
            DataSet ds = ADRCIADAL.getNeedyPersonDetails(NeedyPersonID, ContactHistoryId, ViewState["AllCallIDList"].ToString(), 0, SetReportSelectionProp());
            ExportNeedyDetailsToExcel(ds.Tables[0], "D");
        }
        catch (Exception ex) { throw ex; }
    }

    //Added by KP on 15th April 2020(SOW-577)
    protected void ancOtherServiceDupePersonCount_ServerClick(object sender, EventArgs e)
    {
        HtmlInputButton btn = sender as HtmlInputButton;
        GridViewRow row = btn.NamingContainer as GridViewRow;
        string NeedyPersonID = Convert.ToString(DLDupeOtherService.DataKeys[row.RowIndex].Values[0]);
        string ContactHistoryId = Convert.ToString(DLDupeOtherService.DataKeys[row.RowIndex].Values[1]);
        try
        {
            DataSet ds = ADRCIADAL.getNeedyPersonDetails(NeedyPersonID, ContactHistoryId, ViewState["AllCallIDList"].ToString(), 0, SetReportSelectionProp());
            ExportNeedyDetailsToExcel(ds.Tables[0], "D");
        }
        catch (Exception ex) { throw ex; }
    }

    #endregion

}