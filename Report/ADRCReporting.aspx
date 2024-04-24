<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="ADRCReporting.aspx.cs" Inherits="Report_ADRCReporting" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <link href="../assets/jQueryUI.css" rel="stylesheet" type="text/css" />
    <link href="../assets/jquery.multiselect.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../assets/jquery.multiselect.filter.css" />
    <link rel="stylesheet" type="text/css" href="../assets/style.css" />
    <link rel="stylesheet" type="text/css" href="../assets/prettify.css" />
    <asp:PlaceHolder runat="server">
        <%: System.Web.Optimization.Scripts.Render("~/Scripts/NeedPerson") %>
    </asp:PlaceHolder>
    <script type="text/javascript" src="../Scripts/jquery.multiselect.js"></script>
    <script type="text/javascript" src="../Scripts/jquery.multiselect.filter.js"></script>
    <%--<script src="../Scripts/jquery-1.9.1.min.js" type="text/javascript"></script>--%>
   <%-- <script src="../Scripts/jqueryUI.1.9.2.js" type="text/javascript"></script>--%>
    <%--<script src="../Scripts/progressbar_mini.js" type="text/javascript"></script>--%>
    <%--<script src="../Scripts/ModalPopupWindow.js" type="text/javascript"></script>--%>
    <%--<script src="../Scripts/DateValidation.js" type="text/javascript"></script>--%>
    <%--<script src="../Scripts/MaskedEditFix.js" type="text/javascript"></script>--%>
    <%--<script src="../Scripts/json2.js" type="text/javascript"></script>--%>
    <%--<script type="text/javascript" src="../Scripts/jquery.multiselect.js"></script>
    <script type="text/javascript" src="../Scripts/jquery.multiselect.filter.js"></script>
    <script src="../Scripts/CommonValidator.js" type="text/javascript"></script>--%>
    <style type="text/css">
        label {
            font-size: 12px;
        }		
		.adrcReportWpr select{
               width:400px !important;
        }

        .input-symbol-euro {
            position: relative;
        }

            .input-symbol-euro input {
                padding-left: 18px;
            }

            .input-symbol-euro span.symbol {
                position: absolute;
                top: 0;
                left: 5px;
            }
            .tdPadding td{
                padding:2px 0;
            }
            .ContactTypeInfo tr{
                padding:0px !important;
                margin:0px !important;
            }
            .ContactType tr{
                padding:0px !important;
                margin:0px !important;
            }
            .ContactTypeInfo td{
                height:18px !important;
                padding:0px !important;
                margin:0px !important;
                line-height:13px !important;
            }
            .ContactType td{
                height:18px !important;
                padding:0px !important;
                margin:0px !important;
                line-height:13px !important;
            }

    </style>
    <script type="text/javascript">

        var isFirstTimeRequest = true;//Global variable is used for multiselection dropdown

        /*
        This Script is for some functions to be called on page load..
        */
        $(document).ready(function () {            
            //debugger;            
            $("#<%=txtFromAmount.ClientID%>").CommonValidator();
            $("#<%=txtToAmount.ClientID%>").CommonValidator();
            if (!myAjaxHandler()) { //Added by Abhinav, 12-Feb-2024 | SOW-654
                GetCounty();
                GetTownship();
                GetCustomField();
                getServicesbyAgency();
                getOtherServicesbyAgency();//Added by KP on 26th March 2020(SOW-577)
                getStaffbyAgency();
            }
            //16th Sep change by SA
            document.getElementById('chkIsInfoOnly').style.display = 'none';
            document.getElementById('chkIsADRC').style.display = 'none';
            document.getElementById('lblIsADRC').style.display = 'none';
            document.getElementById('lblIsInfoOnly').style.display = 'none';
            //================================================
            document.getElementById('MainContent_txtAge').style.display = "none";

            document.getElementById('rdoSummary').checked = true;


            $('input[name=Today]').not(':checked').prop("checked", true);
            $('input[name=Summary]').not(':checked').prop("checked", true);

            $(function () {
                var radios = $('input:radio[name=Summary]');
                radios.filter('[value=0]').prop('checked', true);

                var radios1 = $('input:radio[name=Today]');
                radios1.filter('[value=Today]').prop('checked', true);

            });
            
            //Added by KP on 6th Jan 2020(SOW-577), By deafult(at first load) disable the Conatct Type info.
            $("#chkProfInfo").attr("disabled", "disabled");
            $("#chkProxyInfo").attr("disabled", "disabled");
            $("#chkFamilyInfo").attr("disabled", "disabled");
            $("#chkOtherInfo").attr("disabled", "disabled");
            $("#chkCaregiverInfo").attr("disabled", "disabled");
            
            //To enable/ disable the Conatct Type info, when click on an item.
            $("#<%=chkContactType.ClientID %>").find('input[type="checkbox"]').click(function () {    
                if (this.value == '3') {
                    if (this.checked)
                        $("#chkProfInfo").multiselect('enable');
                    else
                        $('#chkProfInfo').multiselect("disable");
                }
                else if (this.value == '5') {
                    if (this.checked)
                        $('#chkProxyInfo').multiselect('enable');
                    else
                        $('#chkProxyInfo').multiselect("disable");
                }
                else if (this.value == '6') {
                    if (this.checked)
                        $('#chkFamilyInfo').multiselect('enable');
                    else
                        $('#chkFamilyInfo').multiselect("disable");
                }
                else if (this.value == '4') {
                    if (this.checked)
                        $('#chkOtherInfo').multiselect('enable');
                    else
                        $('#chkOtherInfo').multiselect("disable");
                }
                else if (this.value == '2') {
                    if (this.checked)
                        $('#chkCaregiverInfo').multiselect('enable');
                    else
                        $('#chkCaregiverInfo').multiselect("disable");
                }
            });
            //End (SOW-577)
            myAjaxHandler();            
        });

        //function to rebind county, services & staff on any change in their 'TO' listboxes

        function ReverseBind() {
            GetTownship();
            GetCustomField();
            GetCounty();
            getServicesbyAgency();
            getOtherServicesbyAgency();//Added by KP on 26th March 2020(SOW-577)
            getStaffbyAgency();
        }
        //Created By: SA on 1st August, 2K14. Function to convert name or string to Title Case.
        function toTitleCase(str) {
            return str.replace(/\w\S*/g, function (txt) { return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase(); });
        }

    </script>
    <script type="text/javascript">

        /*
        Created By: SA on 16th July, 2K14.
        Purpose: Get All the Details of the page and pass them to the stored procedure through Ajax Web Method Call for reporting purpose.
        */


        var ReportType;
        var ReportTypeText;
        var ReportingStyle;
        var AdvanceFilter;

        /*Common Filter*/
        var Agency;
        var AgencyText;
        var County;
        var City;
        var Service;
        var ReferredBy; //Added on 26-11-2014. SOW-335. SA.
        var ReferredByText; //Added on 26-11-2014. SOW-335. SA.
        var RefByLength; //Added on 26-11-2014. SOW-335. SA.
        var ReferredTo;
        var ReferredByOther; //Added on 7-11-2014 - SA - SOW-335
        var ReferredToOther; //Added on 12-30-2014 - SA - SOW-335
        var Staff;
        var DateRangeFrom;
        var DateRangeTo;

        /*Details */
        var GroupBy;
        var ContactMethod;
        var AgeFromToday;
        var AgeFromDate;
        var ContactType;
        var Gender;
        var MaritalStatus;
        var LivingArrangement;
        var Race;
        var PrimaryLanguage;// Added on 30-12-2014. SOW-335
        var VeteranApplicable;
        var VeteranStatus;
        var ServiceNeedMet;
        var FollowUpStatus;
        var Ethnicity;
        var IsDemographics, IsDemographicsText;//Added by KP on 28-Sep-2017 - SOW-485 
        //Added By GK on 28 May 2019,SOW-563.
        var Township;
        var TownshipText;
        var CustomField;
        var CustomFieldText;
        /*
        Done by SA.
        Change in Age List as to parameterised each age list.
        24th July, 2K14.
        */

        var A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, AUnknown, ServiceText, ReferredToText, AgencyLength, CountyLength, CityLength, TownshipLength, CustomFieldLength, ServiceLength,
            RefLength, StaffLength;

        //30th July Change to get Text of each Checkbox
        var ContactMethodText, AgeAsOfText, ContactTypeText, GenderText, MaritalStatusText, LivingArrangementText, RaceText, EthnicityText, VeteranApplicableText,
            VeteranStatusText, ServiceNeedMetText, FollowUpText, DateText, StaffName;

        //16th Sep change by SA for duplicate/unduplicate reporting condition.

        var IsInfoOnly, IsADRC;

        //20th Aug change by SA for Referred for OC addition in advance report - sow-379.
        var IsReferredForOC, IsReferredForOCText, IsReferredForOCDate, IsReferredForOCDateTo;
        //Changes end here............................

        //Added by KR on 22 March 2017.
        var IsFundProvided, IsFundProvidedText, IsFromAmount, IsToAmount;
        //Added by VK on 03 Aug 2017.
        var CaregiverNeedyPerson, CaregiverNeedyPersonText, FundsUtilizedfor, FundsUtilizedforText, FundsProvidedDateFrom, FundsProvidedDateTo;

        //Added By KP on 3rd Jan 2020(SOW-577), To hold the Contact Type Info.
        var ContactInfo;
        var ProfessionalInfoText, ProxyInfoText, FamilyInfoText, OtherInfoText, CaregiverInfoText;
                
        var OtherServiceLength, OtherService;//Added By KP on 25th March 2020(SOW-577)

        function ADRCReportProperties() {

            this.ReportTypeText = ReportTypeText;
            this.ReportType = ReportType;
            this.Agency = Agency;
            this.AgencyText = AgencyText;
            this.County = County;
            this.City = City;
            this.Service = Service;
            this.ReferredBy = ReferredBy; //Added on 26-11-2014. SOW-335. SA.
            this.ReferredByText = ReferredByText; //Added on 26-11-2014. SOW-335. SA.
            this.RefByLength = RefByLength; //Added on 26-11-2014. SOW-335. SA.
            this.ReferredTo = ReferredTo;
            this.ReferredByOther = ReferredByOther; //Added on 7-11-2014 - SA - SOW-335
            this.ReferredToOther = ReferredToOther; //Added on 12-30-2014 - SA - SOW-335
            this.Staff = Staff;
            this.DateRangeFrom = DateRangeFrom;
            this.DateRangeTo = DateRangeTo;
            this.ReportingStyle = ReportingStyle;
            this.GroupBy = GroupBy;
            this.AdvanceFilter = AdvanceFilter;
            this.ContactMethod = ContactMethod;
            this.AgeFromToday = AgeFromToday;
            this.AgeFromDate = AgeFromDate;
            this.ContactType = ContactType;
            this.Gender = Gender;
            this.MaritalStatus = MaritalStatus;
            this.LivingArrangement = LivingArrangement;
            this.Race = Race; this.PrimaryLanguage = PrimaryLanguage;// Added on 30-12-2014. SOW-335
            this.VeteranApplicable = VeteranApplicable;
            this.VeteranStatus = VeteranStatus;
            this.ServiceNeedMet = ServiceNeedMet;
            this.FollowUpStatus = FollowUpStatus;
            this.Ethnicity = Ethnicity;
            this.IsDemographics = IsDemographics;//Added by KP on 28-Sep-2017 - SOW-485
            this.IsDemographicsText = IsDemographicsText;//Added by KP on 29-Sep-2017 - SOW-485
            //Added By VK on 28 May 2019,SOW-563.
            this.Township = Township;
            this.TownshipText = TownshipText;
            this.CustomField = CustomField;
            this.CustomFieldText = CustomFieldText;
            /*
            Done by SA.
            Change in Age List as to parameterised each age list.
            24th July, 2K14.
            */

            this.A1 = A1; this.A2 = A2; this.A3 = A3; this.A4 = A4; this.A5 = A5; this.A6 = A6; this.A7 = A7; this.A8 = A8;
            this.A9 = A9; this.A10 = A10; this.A11 = A11; this.A12 = A12; this.A13 = A13; this.A14 = A14; this.AUnknown = AUnknown;
            this.ServiceText = ServiceText; this.ReferredToText = ReferredToText; this.AgencyLength = AgencyLength; this.CountyLength = CountyLength;
            this.CityLength = CityLength; this.ServiceLength = ServiceLength; this.RefLength = RefLength; this.StaffLength = StaffLength;
             //Added By GK on 28 May 2019,SOW-563.
            this.TownshipLength = TownshipLength; this.CustomFieldLength = CustomFieldLength;

            //30th July Change to get Text of each Checkbox

            this.ContactMethodText = ContactMethodText; this.AgeAsOfText = AgeAsOfText; this.ContactTypeText = ContactTypeText; this.GenderText = GenderText;
            this.MaritalStatusText = MaritalStatusText; this.LivingArrangementText = LivingArrangementText; this.RaceText = RaceText;
            this.EthnicityText = EthnicityText; this.VeteranApplicableText = VeteranApplicableText; this.VeteranStatusText = VeteranStatusText;
            this.ServiceNeedMetText = ServiceNeedMetText; this.FollowUpText = FollowUpText; this.DateText = DateText; this.StaffName = StaffName;

            //16th Sep change by SA for duplicate/unduplicate reporting condition.

            this.IsInfoOnly = IsInfoOnly; this.IsADRC = IsADRC;
            //20th Aug change by SA for Referred for OC addition in advance report - sow-379.
            this.IsReferredForOC = IsReferredForOC; this.IsReferredForOCText = IsReferredForOCText; this.IsReferredForOCDate = IsReferredForOCDate;
            this.IsReferredForOCDateTo = IsReferredForOCDateTo;
            //Changes end here............................

            //Added By KR on 22 March 2017
            this.IsFundProvided = IsFundProvided;
            this.IsFundProvidedText = IsFundProvidedText;
            this.IsFromAmount = IsFromAmount;
            this.IsToAmount = IsToAmount;
            //Added By VK on 03 Aug 2017.
            this.FundsProvidedDateFrom = FundsProvidedDateFrom;
            this.FundsProvidedDateTo = FundsProvidedDateTo;
            this.CaregiverNeedyPerson = CaregiverNeedyPerson;
            this.CaregiverNeedyPersonText = CaregiverNeedyPersonText;
            this.FundsUtilizedfor = FundsUtilizedfor;
            this.IsFundProvidedText = IsFundProvidedText;


            //Added By KP on 3rd Jan 2020(SOW-577), To hold the Contact Type Info.
            this.ContactInfo = ContactInfo;            
            this.ProfessionalInfoText = ProfessionalInfoText;
            this.ProxyInfoText = ProxyInfoText ;
            this.FamilyInfoText = FamilyInfoText ;
            this.OtherInfoText = OtherInfoText;
            this.CaregiverInfoText = CaregiverInfoText;

            //Added By KP on 25th March 2020(SOW-577)
            this.OtherServiceLength = OtherServiceLength;
            this.OtherService = OtherService;
            //////end (SOW-577)//////

        }
        // function to get comma separated checkbox values
        function GetCheckboxValues(id) {

            var chkValues = $('#' + id + ' :checked').map(function () { return this.value; }).get().join(',');

            return chkValues;
        }
        // function to get comma separated checkbox text
        function GetCheckboxValuesText(id) {

            var chkValues = $('#' + id + ' :checked').map(function () { return $(this).next().html(); }).get().join(', ');

            return chkValues;
        }

        function GetvetApplicableText(id) {

            var chkValues = $('#' + id + ' :checked').map(function () { return $(this).next().html(); }).get().join(',');

            return chkValues;
        }

        // function to get comma separated checkbox text of AgeRange
        function GetAgeRangeText() {

            var chkValues = $('input[name=AgeRange]:checked').map(function () { return $(this).next().html(); }).get().join(', ');

            return chkValues;
        }

        // function to get comma separated checkbox text of Referred for OC - SA on 21st Aug, 2015 SOW-379
        function GetReferredforOCText() {

            var chkValues = $('input[name=ReferredforOC]:checked').map(function () { return $(this).next().html(); }).get().join(', ');

            return chkValues;
        }

        // function to get comma separated checkbox text of Referred for OC - SA on 21st Aug, 2015 SOW-379
        function GetReferredforOCVal() {

            var chkValues = $('input[name=ReferredforOC]:checked').map(function () { return $(this).val(); }).get().join(',');

            return chkValues;
        }
        //Added By KR on 27 march 2017.
        function GetFundProvidedText() {

            var chkValues = $('input[name=FundProvided]:checked').map(function () { return $(this).next().html(); }).get().join(', ');

            return chkValues;
        }

        function GetFundProvidedVal() {
            var chkValues = $('input[name=FundProvided]:checked').map(function () { return $(this).val(); }).get().join(',');
            return chkValues;
        }

        function AgeRadioCheck() {
            document.getElementById('MainContent_txtAge').style.display = "none";
            document.getElementById('MainContent_txtAge').value = "";
            var Check = $('input[value=Today]').is(":checked");
            if (Check == true) {

                document.getElementById('MainContent_txtAge').style.display = "none";
                return false;
            }

            var Check = $('input[value=RadioText]').is(":checked");
            if (Check == true) {
                document.getElementById('MainContent_txtAge').style.display = "inline";
                $('#MainContent_txtAge').focus();
                document.getElementById('MainContent_txtAge').title = "Enter Desired Age";
                return false;
            }

        }
        function getDateText() {
            var DateText = "";
            var Check = $('input[value=RadioText]').is(":checked");
            if (Check == true) {
                DateText = document.getElementById('<%= txtAge.ClientID %>').value;
            }
            return DateText;
        }

        /*  Created by SA on : 9th August, 2K14.
        Purpose: Future Date Validation
        */

        function futureDateValidation(id) {

            var date = document.getElementById(id).value;
            if (date != "") {
                var fdate = new Date(date);
                var cdate = new Date();

                if (fdate > cdate) {
                    alert("Date can not be future date.");
                    document.getElementById(id).value = "";

                    return false;
                }
                else {
                    return true;
                }
            }
        }

        function InitADRCReportProperties() {

            var obj = new ADRCReportProperties();

            obj.ReportTypeText = $('#<%=ddlReportType.ClientID %> option:selected').text();
            obj.ReportType = $('#<%=ddlReportType.ClientID %>').val();
            obj.Agency = GetIDString($("#<%=lstAgencyto.ClientID %>"));
            obj.AgencyText = GetTextString($("#<%=lstAgencyto.ClientID %>"));
            obj.County = GetIDString($("#<%=lstCountyto.ClientID %>"));
            obj.City = GetIDString($("#<%=lstCityto.ClientID %>"));
             //Added By GK on 28 May 2019,SOW-563.
            obj.Township = GetIDString($("#<%=lstTownshipTo.ClientID %>"));
            obj.TownshipText = GetTextString($("#<%=lstTownshipTo.ClientID %>"));
            obj.CustomField = GetIDString($("#<%=lstCustomFieldTo.ClientID %>"));
            obj.CustomFieldText = GetTextString($("#<%=lstCustomFieldTo.ClientID %>"));
            <%--var customTextArray = [];
            $("#<%=lstCustomFieldTo.ClientID %> option").each(function () {
                customTextArray.push($(this).text());
            });
            obj.CustomFieldName = customTextArray.join();--%>
            obj.Service = GetIDStringService($("#<%=lstServiceto.ClientID %>"));
            obj.ServiceText = GetTextString($("#<%=lstServiceto.ClientID %>"));
            obj.ReferredBy = GetIDString($("#<%= lstReferredByTo.ClientID%>")); //Added on 26-11-2014. SOW-335. SA
            obj.ReferredByText = GetTextString($("#<%= lstReferredByTo.ClientID%>")); //Added on 26-11-2014. SOW-335. SA
            obj.ReferredTo = GetIDString($("#<%=lstRefferedto.ClientID %>"));
            obj.ReferredToText = GetTextString($("#<%=lstRefferedto.ClientID %>"));
            obj.ReferredByOther = GetTextRefOther($("#<%=lstReferredByTo.ClientID %>"));

            obj.ReferredToOther = GetTextRefOther($("#<%=lstRefferedto.ClientID %>"));

            obj.Staff = GetIDString($("#<%=lstStaffto.ClientID %>"));
            obj.DateRangeFrom = $('#<%= txtdateFrom.ClientID %>').val();
            obj.DateRangeTo = $('#<%= txtdateto.ClientID %>').val();
            obj.ReportingStyle = $('input:radio[name=Summary]:checked').val();
            obj.AdvanceFilter = $('input[name=AdvFilter]').is(":checked");
            obj.GroupBy = $('#<%=ddlAdvFilter.ClientID %>').val();
            obj.ContactMethod = GetCheckboxValues('MainContent_chkContactMethod');
            obj.AgeFromToday = $('input[value=Today]').is(":checked");
            obj.AgeFromDate = document.getElementById('MainContent_txtAge').value;
            obj.ContactType = GetCheckboxValues('MainContent_chkContactType');
            obj.Gender = GetCheckboxValues('MainContent_chkGender');
            obj.MaritalStatus = GetCheckboxValues('MainContent_chkMaritalStatus');
            obj.LivingArrangement = GetCheckboxValues('MainContent_chkLivingArrangement');
            obj.Race = GetCheckboxValues('MainContent_chkRace');
            obj.IsDemographics = GetCheckboxValues('MainContent_ChkNoDemographics');//Added by KP on 28-Sep-2017 - SOW-485 
            obj.IsDemographicsText = GetCheckboxValuesText('MainContent_ChkNoDemographics');//Added by KP on 29-Sep-2017 - SOW-485

            obj.PrimaryLanguage = GetCheckboxValuesM('chkPrimaryLanguage'); // Added on 30-12-2014. SOW-335. SA.

            obj.VeteranApplicable = GetCheckboxValues('MainContent_chkVeteranApplicable');
            obj.VeteranStatus = GetCheckboxValues('MainContent_chkVeteranStatus');
            obj.ServiceNeedMet = GetCheckboxValues('MainContent_chkServiceNeedMet');
            obj.FollowUpStatus = GetCheckboxValues('MainContent_chkFollowUpStatus');
            obj.Ethnicity = GetCheckboxValues('MainContent_chkEthnicity');
            //16th Sep change by SA for duplicate/unduplicate reporting condition.
            if ($("#<%=ddlReportType.ClientID%>").val() == "4") {

                obj.IsInfoOnly = $('input[name=IsInfoOnly]').is(":checked");
                obj.IsADRC = $('input[name=IsADRC]').is(":checked");
            }
            //==========================================================================

            /*
            Done by SA.
            Change in Age List as to parameterise each age list.
            24th July, 2K14.
            */

            obj.A1 = $('input[value=A1]').is(":checked"); obj.A2 = $('input[value=A2]').is(":checked"); obj.A3 = $('input[value=A3]').is(":checked");
            obj.A4 = $('input[value=A4]').is(":checked"); obj.A5 = $('input[value=A5]').is(":checked"); obj.A6 = $('input[value=A6]').is(":checked");
            obj.A7 = $('input[value=A7]').is(":checked"); obj.A8 = $('input[value=A8]').is(":checked"); obj.A9 = $('input[value=A9]').is(":checked");
            obj.A10 = $('input[value=A10]').is(":checked"); obj.A11 = $('input[value=A11]').is(":checked"); obj.A12 = $('input[value=A12]').is(":checked");
            obj.A13 = $('input[value=A13]').is(":checked"); obj.A14 = $('input[value=A14]').is(":checked"); obj.AUnknown = $('input[value=A15]').is(":checked");

            obj.AgencyLength = getListboxLength($("#<%=lstAgencyFrom.ClientID %> option"), $("#<%=lstAgencyto.ClientID %> option"));
            obj.CountyLength = getListboxLength($("#<%=lstCountyFrom.ClientID %> option"), $("#<%=lstCountyto.ClientID %> option"));
            obj.CityLength = getListboxLength($("#<%=lstCityFrom.ClientID %> option"), $("#<%=lstCityto.ClientID %> option"));
            obj.ServiceLength = getListboxLength($("#<%=lstServiceFrom.ClientID %> option"), $("#<%=lstServiceto.ClientID %> option"));

            obj.OtherServiceLength = getListboxLength($("#<%=lstOtherServiceFrom.ClientID %> option"), $("#<%=lstOtherServiceTo.ClientID %> option"));//Added by KP on 25th March 2020(SOW-577)

            obj.RefByLength = getListboxLength($("#<%=lstReferredByFrom.ClientID %> option"), $("#<%=lstReferredByTo.ClientID %> option")); //Added on 26-11-2014. SOW-335. SA.

            obj.RefLength = getListboxLength($("#<%=lstRefferedtoFrom.ClientID %> option"), $("#<%=lstRefferedto.ClientID %> option"));
            obj.StaffLength = getListboxLength($("#<%=lstStaffFrom.ClientID %> option"), $("#<%=lstStaffto.ClientID %> option"));

            //30th July Change to get Text of each Checkbox

            obj.ContactMethodText = GetCheckboxValuesText('MainContent_chkContactMethod'); obj.AgeAsOfText = GetAgeRangeText();
            obj.ContactTypeText = GetCheckboxValuesText('MainContent_chkContactType'); obj.GenderText = GetCheckboxValuesText('MainContent_chkGender');
            obj.MaritalStatusText = GetCheckboxValuesText('MainContent_chkMaritalStatus'); obj.LivingArrangementText = GetCheckboxValuesText('MainContent_chkLivingArrangement');
            obj.RaceText = GetCheckboxValuesText('MainContent_chkRace');
            obj.EthnicityText = GetCheckboxValuesText('MainContent_chkEthnicity');
            obj.VeteranApplicableText = GetvetApplicableText('MainContent_chkVeteranApplicable'); obj.VeteranStatusText = GetCheckboxValuesText('MainContent_chkVeteranStatus');
            obj.ServiceNeedMetText = GetCheckboxValuesText('MainContent_chkServiceNeedMet'); obj.FollowUpText = GetCheckboxValuesText('MainContent_chkFollowUpStatus');
            obj.DateText = getDateText(); obj.StaffName = getStaffName();

            //20th Aug change by SA for Referred for OC addition in advance report - sow-379.
            obj.IsReferredForOC = GetReferredforOCVal();
            obj.IsReferredForOCText = GetReferredforOCText();
            obj.IsReferredForOCDate = $('#MainContent_txtReferredforOCdate').val();
            obj.IsReferredForOCDateTo = $('#MainContent_txtReferredforOCdateTo').val();
            //Changes end here............................

            //Added By KR on 22 March 2017
            obj.IsFundProvided = GetFundProvidedVal();
            obj.IsFundProvidedText = GetFundProvidedText();
            obj.IsFromAmount = $('#MainContent_txtFromAmount').val();
            obj.IsToAmount = $('#MainContent_txtToAmount').val();
            //Added By Vk on 03 Aug 2017.
            obj.FundsProvidedDateFrom = $('#MainContent_txtFundProvidedDateFrom').val();
            obj.FundsProvidedDateTo = $('#MainContent_txtFundProvidedDateTo').val();
            obj.CaregiverNeedyPerson = GetCheckboxValues('MainContent_chkCaregiverNeedyPerson');
            obj.CaregiverNeedyPersonText = GetCheckboxValuesText('MainContent_chkCaregiverNeedyPerson');
            obj.FundsUtilizedfor = GetCheckboxValues('MainContent_chklistFundsUtilized');
            obj.FundsUtilizedforText = GetCheckboxValuesText('MainContent_chklistFundsUtilized');

           //Added By VK on 28 May 2019,SOW-563.
            obj.TownshipLength = getListboxLength($("#<%=lstTownshipFrom.ClientID %> option"), $("#<%=lstTownshipTo.ClientID %> option"));
            obj.CustomFieldLength = getListboxLength($("#<%=lstCustomFieldFrom.ClientID %> option"), $("#<%=lstCustomFieldTo.ClientID %> option"));

            //Added By KP on 3rd Jan 2020(SOW-577), Set Contact Type Info.
            var ContactInfo = '';
            if (obj.ContactType.indexOf('3') != -1) {
                ContactInfo = (ContactInfo.length > 0 ? ContactInfo + ',' : '' ) + GetCheckboxValuesM('chkProfInfo');
                obj.ProfessionalInfoText = GetCheckboxTextM('chkProfInfo');
            }
            if (obj.ContactType.indexOf('5') != -1) {
                ContactInfo = (ContactInfo.length > 0 ? ContactInfo + ',' : '') + GetCheckboxValuesM('chkProxyInfo');
                obj.ProxyInfoText = GetCheckboxTextM('chkProxyInfo');
            }
            if (obj.ContactType.indexOf('6') != -1) {
                ContactInfo = (ContactInfo.length > 0 ? ContactInfo + ',' : '') + GetCheckboxValuesM('chkFamilyInfo');
                obj.FamilyInfoText = GetCheckboxTextM('chkFamilyInfo');
            }
            if (obj.ContactType.indexOf('4') != -1) {
                ContactInfo = (ContactInfo.length > 0 ? ContactInfo + ',' : '') + GetCheckboxValuesM('chkOtherInfo');
                obj.OtherInfoText = GetCheckboxTextM('chkOtherInfo'); 
            }   
            if (obj.ContactType.indexOf('2') != -1) {
                ContactInfo = (ContactInfo.length > 0 ? ContactInfo + ',' : '') + GetCheckboxValuesM('chkCaregiverInfo');
                obj.CaregiverInfoText = GetCheckboxTextM('chkCaregiverInfo'); 
            } 
            
            obj.ContactInfo = ContactInfo;  
            obj.OtherService = GetIDStringService($("#<%=lstOtherServiceTo.ClientID %>"));
            //End (SOW-577)
            
            ADRCReportingDetails(obj);
        }

        function ADRCReportingDetails(ADRCDetails) {
            $('#Progressbar').show();
            $.ajax({
                type: "POST",
                url: "ReportResult.aspx/GenADRCReport",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{objReport:" + JSON.stringify(ADRCDetails) + "}",
                async: false,
                success: function (data) {
                        $('#Progressbar').hide();
                        ShowNewPage();                   
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    var responseText;
                    responseText = jQuery.parseJSON(XMLHttpRequest.responseText);
                    var errMsg = 'Please try again!' + '\n\nError: ' + responseText.Message;
                    $('#Progressbar').hide();
                    alert(errMsg);
                }
            });
        }
    </script>
    <script type="text/javascript">

        /*
        Created by SA.
        Purpose: To implement Add, Add All, Remove and Remove All functions
        */

        // Common function to get all the listbox length for validation & reporting purpose.
        function getListboxLength(FromID, ToID) {

            var FLength = FromID.length;
            var TLength = ToID.length;
            var Result;
            if (!FLength == 0) {


                if (FLength == TLength || TLength == 0) {

                    Result = "ALL";
                }
                else {
                    Result = "";
                }
            }
            else {
                Result = 0;
            }
            return Result;
        }

        function AddAgency() {

            var selectedOptions = $('#<%=lstAgencyFrom.ClientID %> option:selected');
            var selectedOptionsFrom = $('#<%=lstAgencyFrom.ClientID %> option');
            if (selectedOptionsFrom.length == 0) {
                alert("Nothing to add.");
                return false;
            }
            if (selectedOptions.length == 0) {
                alert("Please select option to move.");
                return false;
            }

            var length = getSpecificListboxLength($("#<%=lstAgencyFrom.ClientID %> option"), $("#<%=lstAgencyto.ClientID %> option"));

            if (length == "ALL") {
                return false;
            }


            if (selectedOptions.length == 1) {
                if ($("#<%=lstAgencyto.ClientID %> option[value='" + selectedOptions.val() + "']").length > 0) {
                }
                else {
                    $('#<%=lstAgencyto.ClientID %>').append($(selectedOptions).clone());
                }
            }
            else if (selectedOptions.length > 1) { $(selectedOptions).each(function () { if ($("#<%=lstAgencyto.ClientID %> option[value='" + this.value + "']").length > 0) { } else { $('#<%=lstAgencyto.ClientID %>').append($(this).clone()); } }); }
            $('#<%=lstAgencyFrom.ClientID %>')[0].selectedIndex = -1;

            $('#<%= lstCountyto.ClientID %>').empty();
            $('#<%= lstCityto.ClientID %>').empty();
            $('#<%= lstTownshipTo.ClientID %>').empty();
            $('#<%= lstCustomFieldTo.ClientID %>').empty();
            $('#<%= lstServiceto.ClientID %>').empty();
            $('#<%= lstOtherServiceTo.ClientID %>').empty();
            $('#<%= lstStaffto.ClientID %>').empty();
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            if (!myAjaxHandler()) {
                GetTownship(); GetCustomField(); GetCounty(); getServicesbyAgency();
                getOtherServicesbyAgency();//Added by KP on 26th March 2020(SOW-577)
                getStaffbyAgency();
                getContactTypeInfo();
            }            
            return false;
        }

        //function to get ListBox length for enforcing validation of AddAgencyAll function

        function getSpecificListboxLength(FromID, ToID) {

            var FLength = FromID.length;
            var TLength = ToID.length;
            var Result;

            if (FLength == TLength) {

                Result = "ALL";
            }
            else {
                Result = "";
            }
            return Result;
        }


        function AddAgencyAll() {

            var length = getSpecificListboxLength($("#<%=lstAgencyFrom.ClientID %> option"), $("#<%=lstAgencyto.ClientID %> option"));

            if (length == "ALL") {
                return false;
            }

            var selectedOptions = $('#<%=lstAgencyFrom.ClientID %> option');
             if (selectedOptions.length == 0) {
                alert("Nothing to add.");
                return false;
            }
            if (selectedOptions.length == 1) {
                if ($("#<%=lstAgencyto.ClientID %> option[value='" + selectedOptions.val() + "']").length > 0) {

                }
                else {
                    $('#<%=lstAgencyto.ClientID %>').append($(selectedOptions).clone());
                }
            }
            else if (selectedOptions.length > 1) { $(selectedOptions).each(function () { if ($("#<%=lstAgencyto.ClientID %> option[value='" + this.value + "']").length > 0) { } else { $('#<%=lstAgencyto.ClientID %>').append($(this).clone()); } }); }
            $('#<%=lstAgencyFrom.ClientID %>')[0].selectedIndex = -1;

            $('#<%= lstCountyto.ClientID %>').empty();
            $('#<%= lstCityto.ClientID %>').empty();
            $('#<%= lstTownshipTo.ClientID %>').empty();
            $('#<%= lstCustomFieldTo.ClientID %>').empty();
            $('#<%= lstServiceto.ClientID %>').empty();
            $('#<%= lstOtherServiceTo.ClientID %>').empty();
            $('#<%= lstStaffto.ClientID %>').empty();
            if (!myAjaxHandler()) {
                GetCounty(); GetTownship(); GetCustomField(); getServicesbyAgency();
                getOtherServicesbyAgency();//Added by KP on 26th March 2020(SOW-577)
                getStaffbyAgency();
                getContactTypeInfo();
            }            

            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }
        function RemoveAgency() {
            var selectedOptions = $('#<%=lstAgencyto.ClientID %> option:selected');
             var selectedOptionsTo = $('#<%=lstAgencyto.ClientID %> option');
            if (selectedOptionsTo.length == 0) {
                alert("Nothing to remove.");
                return false;
            }
            if (selectedOptions.length == 0) {
                alert("Please select option to move.");
                return false;
            }

            $(selectedOptions).remove();
            $('#<%= lstCountyto.ClientID %>').empty();
            $('#<%= lstCityto.ClientID %>').empty();
            $('#<%= lstServiceto.ClientID %>').empty();
            $('#<%= lstOtherServiceTo.ClientID %>').empty();
            $('#<%= lstStaffto.ClientID %>').empty();
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            if (!myAjaxHandler()) {
                ReverseBind();
                getContactTypeInfo();
            }            

            return false;
        }
        function RemoveAgencyAll() {
            var selectedOptions = $('#<%=lstAgencyto.ClientID %> option');
            if (selectedOptions.length == 0) {
                alert("Nothing to remove.");
                return false;
            }
            $(selectedOptions).remove();
            $('#<%= lstCountyto.ClientID %>').empty();
            $('#<%= lstCityto.ClientID %>').empty();
            $('#<%= lstServiceto.ClientID %>').empty();
            $('#<%= lstOtherServiceTo.ClientID %>').empty();
            $('#<%= lstStaffto.ClientID %>').empty();

            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            if (!myAjaxHandler()) {
                ReverseBind();
                getContactTypeInfo();
            }            

            return false;
        }

        function AddCounty() {

            var selectedOptions = $('#<%=lstCountyFrom.ClientID %> option:selected');
            var selectedOptionsFrom = $('#<%=lstCountyFrom.ClientID %> option');
            if (selectedOptionsFrom.length == 0) {
                alert("Nothing to add.");
                return false;
            }
            if (selectedOptions.length == 0) {
                alert("Please select option to move.");
                return false;
            }
            var length = getSpecificListboxLength($("#<%=lstCountyFrom.ClientID %> option"), $("#<%=lstCountyto.ClientID %> option"));

            if (length == "ALL") {
                return false;
            }

            if (selectedOptions.length == 1) {
                if ($("#<%=lstCountyto.ClientID %> option[value='" + selectedOptions.val() + "']").length > 0) {
                }
                else {
                    $('#<%=lstCountyto.ClientID %>').append($(selectedOptions).clone());
                }
            }
            else if (selectedOptions.length > 1) { $(selectedOptions).each(function () { if ($("#<%=lstCountyto.ClientID %> option[value='" + this.value + "']").length > 0) { } else { $('#<%=lstCountyto.ClientID %>').append($(this).clone()); } }); }
            $('#<%=lstCountyFrom.ClientID %>')[0].selectedIndex = -1;

            $('#<%= lstCityto.ClientID %>').empty();

            GetCity();
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }
        function AddCountyAll() {
            var selectedOptionsFrom = $('#<%=lstCountyFrom.ClientID %> option');
            if (selectedOptionsFrom.length == 0) {
                alert("Nothing to add.");
                return false;
            }
            var length = getSpecificListboxLength($("#<%=lstCountyFrom.ClientID %> option"), $("#<%=lstCountyto.ClientID %> option"));

            if (length == "ALL") {
                return false;
            }

            var selectedOptions = $('#<%=lstCountyFrom.ClientID %> option');
            if (selectedOptions.length == 1) {
                if ($("#<%=lstCountyto.ClientID %> option[value='" + selectedOptions.val() + "']").length > 0) {

                }
                else {
                    $('#<%=lstCountyto.ClientID %>').append($(selectedOptions).clone());
                }
            }
            else if (selectedOptions.length > 1) { $(selectedOptions).each(function () { if ($("#<%=lstCountyto.ClientID %> option[value='" + this.value + "']").length > 0) { } else { $('#<%=lstCountyto.ClientID %>').append($(this).clone()); } }); }
            $('#<%=lstCountyFrom.ClientID %>')[0].selectedIndex = -1;

            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");
            $('#<%= lstCityto.ClientID %>').empty();
            GetCity();

            return false;
        }
        function RemoveCounty() {
            var selectedOptions = $('#<%=lstCountyto.ClientID %> option:selected');
            var selectedOptionsTo = $('#<%=lstCountyto.ClientID %> option');
            if (selectedOptionsTo.length == 0) {
                alert("Nothing to remove.");
                return false;
            }
            if (selectedOptions.length == 0) {
                alert("Please select option to move.");
                return false;
            }

            $(selectedOptions).remove();
            $('#<%= lstCityto.ClientID %>').empty();
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            ReverseBind();
            return false;
        }
        function RemoveCountyAll() {
            var selectedOptions = $('#<%=lstCountyto.ClientID %> option');
            if (selectedOptions.length == 0) {
                alert("Nothing to remove.");
                return false;
            }
            $(selectedOptions).remove();
            $('#<%= lstCityto.ClientID %>').empty();
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            ReverseBind();
            return false;
        }


        function AddCity() {

            var selectedOptions = $('#<%=lstCityFrom.ClientID %> option:selected');
            var selectedOptionsFrom = $('#<%=lstCityFrom.ClientID %> option');
            if (selectedOptionsFrom.length == 0) {
                alert("Nothing to add.");
                return false;
            }
            if (selectedOptions.length == 0) {
                alert("Please select option to move.");
                return false;
            }
            if (selectedOptions.length == 1) {
                if ($("#<%=lstCityto.ClientID %> option[value='" + selectedOptions.val() + "']").length > 0) {
                }
                else {
                    $('#<%=lstCityto.ClientID %>').append($(selectedOptions).clone());
                }
            }
            else if (selectedOptions.length > 1) { $(selectedOptions).each(function () { if ($("#<%=lstCityto.ClientID %> option[value='" + this.value + "']").length > 0) { } else { $('#<%=lstCityto.ClientID %>').append($(this).clone()); } }); }
            $('#<%=lstCityFrom.ClientID %>')[0].selectedIndex = -1;
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }
        function AddCityAll() {
            var selectedOptions = $('#<%=lstCityFrom.ClientID %> option');
            if (selectedOptions.length == 0) {
                alert("Nothing to add.");
                return false;
            }
            if (selectedOptions.length == 1) {
                if ($("#<%=lstCityto.ClientID %> option[value='" + selectedOptions.val() + "']").length > 0) {

                }
                else {
                    $('#<%=lstCityto.ClientID %>').append($(selectedOptions).clone());
                }
            }
            else if (selectedOptions.length > 1) { $(selectedOptions).each(function () { if ($("#<%=lstCityto.ClientID %> option[value='" + this.value + "']").length > 0) { } else { $('#<%=lstCityto.ClientID %>').append($(this).clone()); } }); }
            $('#<%=lstCityFrom.ClientID %>')[0].selectedIndex = -1;
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }
        function RemoveCity() {
            var selectedOptions = $('#<%=lstCityto.ClientID %> option:selected');
            var selectedOptionsTo = $('#<%=lstCityto.ClientID %> option');
            if (selectedOptionsTo.length == 0) {
                alert("Nothing to remove.");
                return false;
            }
            if (selectedOptions.length == 0) {
                alert("Please select option to move.");
                return false;
            }

            $(selectedOptions).remove();
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }
        function RemoveCityAll() {
            var selectedOptions = $('#<%=lstCityto.ClientID %> option');
            if (selectedOptions.length == 0) {
                alert("Nothing to remove.");
                return false;
            }
            $(selectedOptions).remove();
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }

        //Added by GK on 12Apr19 : SOW-563
        function AddTownship() {

            var selectedOptions = $('#<%=lstTownshipFrom.ClientID %> option:selected');
            var selectedOptionsFrom = $('#<%=lstTownshipFrom.ClientID %> option');
            if (selectedOptionsFrom.length == 0) {
                alert("Nothing to add.");
                return false;
            }
           if (selectedOptions.length == 0) {
                alert("Please select option to move.");
                return false;
            }
            if (selectedOptions.length == 1) {
                if ($("#<%=lstTownshipTo.ClientID %> option[value='" + selectedOptions.val() + "']").length > 0) {
                }
                else {
                    $('#<%=lstTownshipTo.ClientID %>').append($(selectedOptions).clone());
                }
            }
            else if (selectedOptions.length > 1) { $(selectedOptions).each(function () { if ($("#<%=lstTownshipTo.ClientID %> option[value='" + this.value + "']").length > 0) { } else { $('#<%=lstTownshipTo.ClientID %>').append($(this).clone()); } }); }
            $('#<%=lstTownshipFrom.ClientID %>')[0].selectedIndex = -1;
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }

        function AddTownshipAll() {
            var selectedOptions = $('#<%=lstTownshipFrom.ClientID %> option');
            if (selectedOptions.length == 0) {
                alert("Nothing to add.");
                return false;
            }
            if (selectedOptions.length == 1) {
                if ($("#<%=lstTownshipTo.ClientID %> option[value='" + selectedOptions.val() + "']").length > 0) {

                }
                else {
                    $('#<%=lstTownshipTo.ClientID %>').append($(selectedOptions).clone());
                }
            }
            else if (selectedOptions.length > 1) { $(selectedOptions).each(function () { if ($("#<%=lstTownshipTo.ClientID %> option[value='" + this.value + "']").length > 0) { } else { $('#<%=lstTownshipTo.ClientID %>').append($(this).clone()); } }); }
            $('#<%=lstTownshipFrom.ClientID %>')[0].selectedIndex = -1;
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }
        function RemoveTownship() {
            var selectedOptions = $('#<%=lstTownshipTo.ClientID %> option:selected');
              var selectedOptionsTo = $('#<%=lstTownshipTo.ClientID %> option');
            if (selectedOptionsTo.length == 0) {
                alert("Nothing to remove.");
                return false;
            }
            if (selectedOptions.length == 0) {
                alert("Please select option to move.");
                return false;
            }

            $(selectedOptions).remove();
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }
        function RemoveTownshipAll() {
            var selectedOptions = $('#<%=lstTownshipTo.ClientID %> option');
            if (selectedOptions.length == 0) {
                alert("Nothing to remove.");
                return false;
            }
            $(selectedOptions).remove();
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }

        function AddCustomField() {

            var selectedOptions = $('#<%=lstCustomFieldFrom.ClientID %> option:selected');
             var selectedOptionsFrom = $('#<%=lstCustomFieldFrom.ClientID %> option');
            if (selectedOptionsFrom.length == 0) {
                alert("Nothing to add.");
                return false;
            }
            if (selectedOptions.length == 0) {
                alert("Please select option to move.");
                return false;
            }
            if (selectedOptions.length == 1) {
                if ($("#<%=lstCustomFieldTo.ClientID %> option[value='" + selectedOptions.val() + "']").length > 0) {
                }
                else {
                    $('#<%=lstCustomFieldTo.ClientID %>').append($(selectedOptions).clone());
                }
            }
            else if (selectedOptions.length > 1) { $(selectedOptions).each(function () { if ($("#<%=lstCustomFieldTo.ClientID %> option[value='" + this.value + "']").length > 0) { } else { $('#<%=lstCustomFieldTo.ClientID %>').append($(this).clone()); } }); }
            $('#<%=lstCustomFieldFrom.ClientID %>')[0].selectedIndex = -1;
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }

        function AddCustomFieldAll() {
            var selectedOptions = $('#<%=lstCustomFieldFrom.ClientID %> option');
            if (selectedOptions.length == 0) {
                alert("Nothing to add.");
                return false;
            }
            else if (selectedOptions.length == 1) {
                if ($("#<%=lstCustomFieldTo.ClientID %> option[value='" + selectedOptions.val() + "']").length > 0) {

                }
                else {
                    $('#<%=lstCustomFieldTo.ClientID %>').append($(selectedOptions).clone());
                }
            }
            else if (selectedOptions.length > 1) { $(selectedOptions).each(function () { if ($("#<%=lstCustomFieldTo.ClientID %> option[value='" + this.value + "']").length > 0) { } else { $('#<%=lstCustomFieldTo.ClientID %>').append($(this).clone()); } }); }
            $('#<%=lstCustomFieldFrom.ClientID %>')[0].selectedIndex = -1;
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }
        function RemoveCustomField() {
            var selectedOptions = $('#<%=lstCustomFieldTo.ClientID %> option:selected');
             var selectedOptionsTo = $('#<%=lstCustomFieldTo.ClientID %> option');
            if (selectedOptionsTo.length == 0) {
                alert("Nothing to remove.");
                return false;
            }
            else if (selectedOptions.length == 0) {
                alert("Please select option to move.");
                return false;
            }

            $(selectedOptions).remove();
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }
        function RemoveCustomFieldAll() {
            var selectedOptions = $('#<%=lstCustomFieldTo.ClientID %> option');
            if (selectedOptions.length == 0) {
                alert("Nothing to remove.");
                return false;
            }
            $(selectedOptions).remove();
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }
        //Ends


        function AddService() {

            var selectedOptions = $('#<%=lstServiceFrom.ClientID %> option:selected');
              var selectedOptionsFrom = $('#<%=lstServiceFrom.ClientID %> option');
            if (selectedOptionsFrom.length == 0) {
                alert("Nothing to add.");
                return false;
            }
             if (selectedOptions.length == 0) {
                alert("Please select option to move.");
                return false;
            }
            if (selectedOptions.length == 1) {
                if ($("#<%=lstServiceto.ClientID %> option[value='" + selectedOptions.val() + "']").length > 0) {
                }
                else {
                    $('#<%=lstServiceto.ClientID %>').append($(selectedOptions).clone());
                }
            }
            else if (selectedOptions.length > 1) { $(selectedOptions).each(function () { if ($("#<%=lstServiceto.ClientID %> option[value='" + this.value + "']").length > 0) { } else { $('#<%=lstServiceto.ClientID %>').append($(this).clone()); } }); }
            $('#<%=lstServiceFrom.ClientID %>')[0].selectedIndex = -1;
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }
        function AddServiceAll() {
            var selectedOptions = $('#<%=lstServiceFrom.ClientID %> option');
             if (selectedOptions.length == 0) {
                alert("Nothing to add.");
                return false;
            }
            if (selectedOptions.length == 1) {
                if ($("#<%=lstServiceto.ClientID %> option[value='" + selectedOptions.val() + "']").length > 0) {

                }
                else {
                    $('#<%=lstServiceto.ClientID %>').append($(selectedOptions).clone());
                }
            }
            else if (selectedOptions.length > 1) { $(selectedOptions).each(function () { if ($("#<%=lstServiceto.ClientID %> option[value='" + this.value + "']").length > 0) { } else { $('#<%=lstServiceto.ClientID %>').append($(this).clone()); } }); }
            $('#<%=lstServiceFrom.ClientID %>')[0].selectedIndex = -1;
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }
        function RemoveService() {
            var selectedOptions = $('#<%=lstServiceto.ClientID %> option:selected');
             var selectedOptionsTo = $('#<%=lstServiceto.ClientID %> option');
            if (selectedOptionsTo.length == 0) {
                alert("Nothing to remove.");
                return false;
            }
            if (selectedOptions.length == 0) {
                alert("Please select option to move.");
                return false;
            }

            $(selectedOptions).remove();
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }
        function RemoveServiceAll() {
            var selectedOptions = $('#<%=lstServiceto.ClientID %> option');
            if (selectedOptions.length == 0) {
                alert("Nothing to remove.");
                return false;
            }
            $(selectedOptions).remove();
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }

        function AddRefferedto() {

            var selectedOptions = $('#<%=lstRefferedtoFrom.ClientID %> option:selected');
             var selectedOptionsFrom = $('#<%=lstRefferedtoFrom.ClientID %> option');
            if (selectedOptionsFrom.length == 0) {
                alert("Nothing to add.");
                return false;
            }
           if (selectedOptions.length == 0) {
                alert("Please select option to move.");
                return false;
            }
            if (selectedOptions.length == 1) {
                if ($("#<%=lstRefferedto.ClientID %> option[value='" + selectedOptions.val() + "']").length > 0) {
                }
                else {
                    $('#<%=lstRefferedto.ClientID %>').append($(selectedOptions).clone());
                }
            }
            else if (selectedOptions.length > 1) { $(selectedOptions).each(function () { if ($("#<%=lstRefferedto.ClientID %> option[value='" + this.value + "']").length > 0) { } else { $('#<%=lstRefferedto.ClientID %>').append($(this).clone()); } }); }
            $('#<%=lstRefferedtoFrom.ClientID %>')[0].selectedIndex = -1;

            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }
        function AddRefferedtoAll() {

            var selectedOptions = $('#<%=lstRefferedtoFrom.ClientID %> option');
            if (selectedOptions.length == 0) {
                alert("Nothing to add.");
                return false;
            }
            if (selectedOptions.length == 1) {
                if ($("#<%=lstRefferedto.ClientID %> option[value='" + selectedOptions.val() + "']").length > 0) {

                }
                else {
                    $('#<%=lstRefferedto.ClientID %>').append($(selectedOptions).clone());
                }
            }
            else if (selectedOptions.length > 1) { $(selectedOptions).each(function () { if ($("#<%=lstRefferedto.ClientID %> option[value='" + this.value + "']").length > 0) { } else { $('#<%=lstRefferedto.ClientID %>').append($(this).clone()); } }); }
            $('#<%=lstRefferedtoFrom.ClientID %>')[0].selectedIndex = -1;

            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }
        function RemoveRefferedto() {
            var selectedOptions = $('#<%=lstRefferedto.ClientID %> option:selected');
            var selectedOptionsTo = $('#<%=lstRefferedto.ClientID %> option');
            if (selectedOptionsTo.length == 0) {
                alert("Nothing to remove.");
                return false;
            }
           if (selectedOptions.length == 0) {
                alert("Please select option to move.");
                return false;
            }

            $(selectedOptions).remove();
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }
        function RemoveRefferedtoAll() {
            var selectedOptions = $('#<%=lstRefferedto.ClientID %> option');
            if (selectedOptions.length == 0) {
                alert("Nothing to remove.");
                return false;
            }
            $(selectedOptions).remove();
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }


        function AddRefferedByto() {

            var selectedOptions = $('#<%=lstReferredByFrom.ClientID %> option:selected');
             var selectedOptionsFrom = $('#<%=lstReferredByFrom.ClientID %> option');
            if (selectedOptionsFrom.length == 0) {
                alert("Nothing to add.");
                return false;
            }
            if (selectedOptions.length == 0) {
                alert("Please select option to move.");
                return false;
            }
            if (selectedOptions.length == 1) {
                if ($("#<%=lstReferredByTo.ClientID %> option[value='" + selectedOptions.val() + "']").length > 0) {
                }
                else {
                    $('#<%=lstReferredByTo.ClientID %>').append($(selectedOptions).clone());
                }
            }
            else if (selectedOptions.length > 1)
            {
                //Modified by KP on 9th June 2020(SOW-577), Add 'title' option in validation to do not avoid to move into 'ToList' of same value items but have the diffrent text.
                $(selectedOptions).each(function () {
                    if ($("#<%=lstReferredByTo.ClientID %> option[value='" + this.value + "']").length > 0
                        && $("#<%=lstReferredByTo.ClientID %> option[title='" + this.title + "']").length > 0) { }
                    else { $('#<%=lstReferredByTo.ClientID %>').append($(this).clone()); }
                });
            }
            $('#<%=lstReferredByFrom.ClientID %>')[0].selectedIndex = -1;

            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }
        function AddRefferedBytoAll() {

            var selectedOptions = $('#<%=lstReferredByFrom.ClientID %> option');
            if (selectedOptions.length == 0) {
                alert("Nothing to add.");
                return false;
            }
            if (selectedOptions.length == 1) {
                if ($("#<%=lstReferredByTo.ClientID %> option[value='" + selectedOptions.val() + "']").length > 0) {

                }
                else {
                    $('#<%=lstReferredByTo.ClientID %>').append($(selectedOptions).clone());
                }
            }
            else if (selectedOptions.length > 1) {
                //Modified by KP on 9th June 2020(SOW-577), Add 'title' option in validation to do not avoid to move into 'ToList' of same value items but have the diffrent text.
                $(selectedOptions).each(function () {
                    if ($("#<%=lstReferredByTo.ClientID %> option[value='" + this.value + "']").length > 0
                        && $("#<%=lstReferredByTo.ClientID %> option[title='" + this.title + "']").length > 0) { }
                    else {
                        $('#<%=lstReferredByTo.ClientID %>').append($(this).clone());
                    }
                });
            }
            $('#<%=lstReferredByFrom.ClientID %>')[0].selectedIndex = -1;

            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }
        function RemoveRefferedByto() {
            var selectedOptions = $('#<%=lstReferredByTo.ClientID %> option:selected');
             var selectedOptionsTo = $('#<%=lstReferredByTo.ClientID %> option');
            if (selectedOptionsTo.length == 0) {
                alert("Nothing to remove.");
                return false;
            }
            if (selectedOptions.length == 0) {
                alert("Please select option to move.");
                return false;
            }

            $(selectedOptions).remove();
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }
        function RemoveRefferedBytoAll() {
            var selectedOptions = $('#<%=lstReferredByTo.ClientID %> option');
            if (selectedOptions.length == 0) {
                alert("Nothing to remove.");
                return false;
            }
            $(selectedOptions).remove();
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }



        function AddStaff() {

            var selectedOptions = $('#<%=lstStaffFrom.ClientID %> option:selected');
             var selectedOptionsFrom = $('#<%=lstStaffFrom.ClientID %> option');
            if (selectedOptionsFrom.length == 0) {
                alert("Nothing to add.");
                return false;
            }
            if (selectedOptions.length == 0) {
                alert("Please select option to move.");
                return false;
            }
            if (selectedOptions.length == 1) {
                if ($("#<%=lstStaffto.ClientID %> option[value='" + selectedOptions.val() + "']").length > 0) {
                }
                else {
                    $('#<%=lstStaffto.ClientID %>').append($(selectedOptions).clone());
                }
            }
            else if (selectedOptions.length > 1) { $(selectedOptions).each(function () { if ($("#<%=lstStaffto.ClientID %> option[value='" + this.value + "']").length > 0) { } else { $('#<%=lstStaffto.ClientID %>').append($(this).clone()); } }); }
            $('#<%=lstStaffFrom.ClientID %>')[0].selectedIndex = -1;

            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }

        function AddStaffAll() {

            var selectedOptions = $('#<%=lstStaffFrom.ClientID %> option');
            if (selectedOptions.length == 0) {
                alert("Nothing to add.");
                return false;
            }
            if (selectedOptions.length == 1) {
                if ($("#<%=lstStaffto.ClientID %> option[value='" + selectedOptions.val() + "']").length > 0) {

                }
                else {
                    $('#<%=lstStaffto.ClientID %>').append($(selectedOptions).clone());
                }
            }
            else if (selectedOptions.length > 1) { $(selectedOptions).each(function () { if ($("#<%=lstStaffto.ClientID %> option[value='" + this.value + "']").length > 0) { } else { $('#<%=lstStaffto.ClientID %>').append($(this).clone()); } }); }
            $('#<%=lstStaffFrom.ClientID %>')[0].selectedIndex = -1;

            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }


        function RemoveStaff() {
            var selectedOptions = $('#<%=lstStaffto.ClientID %> option:selected');
             var selectedOptionsTo = $('#<%=lstStaffto.ClientID %> option');
            if (selectedOptionsTo.length == 0) {
                alert("Nothing to remove.");
                return false;
            }
            if (selectedOptions.length == 0) {
                alert("Please select option to move.");
                return false;
            }

            $(selectedOptions).remove();
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }

        function RemoveStaffAll() {
            var selectedOptions = $('#<%=lstStaffto.ClientID %> option');
            if (selectedOptions.length == 0) {
                alert("Nothing to remove.");
                return false;
            }
            $(selectedOptions).remove();
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }

        //function to get Name of the Staff separated by |

        function GetStaffTextString(id) {
            var dest;
            var str = '';

            for (var count = 0; count < id[0].length; count++) {
                if (str == '') {

                    var option = id[0].options[count];
                    str = option.text;
                }
                else {

                    var option1 = id[0].options[count];
                    str = str + '|' + option1.text;
                }

            }
            return str;
        }

        //function to get the Name of Staff separated by '|'
        function getStaffName() {
            var SpliName = GetStaffTextString($("#<%=lstStaffto.ClientID %>"));
            var IndexName = SpliName.split('|');
            var Name = "";
            for (var i = 0; i < IndexName.length; i++) {

                var TempName = IndexName[i].split(',');

                if (Name == "") {

                    Name = TempName[1] + ' ' + TempName[0];
                }
                else {

                    Name = Name + ', ' + TempName[1] + ' ' + TempName[0];
                }
            }

            return toTitleCase(Name);
        }
        // function to get the text string separated by ','  
        function GetTextString(id) {
            var dest;
            var str = '';

            for (var count = 0; count < id[0].length; count++) {
                if (str == '') {

                    var option = id[0].options[count];
                    str = option.text;
                }
                else {

                    var option1 = id[0].options[count];
                    str = str + ',' + option1.text;
                }

            }
            return str;
        }
        // Created by SA on 10-11-2014. Purpose: To get comma separated text of Other referred By.SOW-335
        function GetTextRefOther(id) {
            var dest;
            var str = '';
            var items = '';
            var text = "(Other)";
            for (var count = 0; count < id[0].length; count++) {
                if (str == '') {
                    var option = id[0].options[count];
                    if (option.text.indexOf(text) != -1) {
                        //var text = option.text.replace('(Other)', '');
                        //str = text;

                        // Modified By GK on 18Sept,2019 Task ID #16715
                        str = option.text.replace('(Other)', '');
                    }
                }
                else {
                    var option1 = id[0].options[count];
                    if (option1.text.indexOf(text) != -1) {
                        //var text1 = option.text.replace('(Other)', '');

                        // Modified By GK on 18Sept,2019 Task ID #16715 
                        str = str + ',' + option1.text.replace('(Other)', '');
                    }
                }
            }
            return str;
        }

        // function to get the ID string separated by ','
        function GetIDString(id) {

            var dest;
            var str = '';
            var text = "(Other)";
            for (var count = 0; count < id[0].length; count++) {
                if (str == '') {

                    var option = id[0].options[count];
                    if (option.text.indexOf(text) == -1) {
                        str = option.value;
                    }
                }
                else {

                    var option1 = id[0].options[count];
                    if (option1.text.indexOf(text) == -1) {
                        str = str + ',' + option1.value;
                    }
                }

            }
            return str;
        }

        // function to get the ID string separated by ','
        //added by SA on 12th Jan, 2016. SOW-400 - Separate the logic of other filter
        function GetIDStringService(id) {

            var dest;
            var str = '';

            for (var count = 0; count < id[0].length; count++) {
                if (str == '') {

                    var option = id[0].options[count];
                    str = option.value;
                }
                else {

                    var option1 = id[0].options[count];
                    str = str + ',' + option1.value;
                }

            }
            return str;
        }
    </script>
    <script type="text/javascript">

        /*
        Created by SA.
        Purpose: All the Page Validation and Binding functions are here..
        */

        function CallADRC() {
            myAjaxHandler(); //Added By AR, 12-Jan-2024 | SOW-654
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            // var SelVal = $("#<%=ddlReportType.ClientID %> :selected").val();
            //  if (SelVal == "5") {
            //    alert('This report is under construction.');
            //      return false;
            //}

            if (RangeValidation()) {

                if (FiscalYearValidation()) { //Commented as per the requirement under ADRCIA Enhancement. SOW-335. SA on 25-11-2014.

                    InitADRCReportProperties();
                }
            }
        }
        // Function to validate Date format 'onchange' of the textbox.
        function ValidateInputDate(id) {
            if (!$("#chkReferredforOCYes").is(":checked")) {
                if (document.getElementById('<%=txtdateFrom.ClientID %>').value == "") {
                    alert("Date range from is mandatory");

                    document.getElementById('<%=txtdateFrom.ClientID %>').focus();

                    document.getElementById('<%=txtdateFrom.ClientID %>').value = "";
                    return false;
                }
            }



            var F = document.getElementById(id).value;
            var T = document.getElementById('<%=txtdateto.ClientID %>').value;
            var FromDate = new Date(F);
            //From Date Validation Section

            var FromSplit = F.split('/');

            var Month = Number(FromSplit[0]);
            var Day = Number(FromSplit[1]);
            var Year = Number(FromSplit[2]);

            if (Month < 1 || Month > 12) {
                alert(iMonth);

                document.getElementById(id).value = "";

                document.getElementById(id).focus();

                return false;
            }
            if (Day < 1 || Day > 31) {
                alert(iDay);
                document.getElementById(id).value = "";
                document.getElementById(id).focus();

                return false;
            }

            if (Year < 1900 || Year > 2078) {
                alert(iYear);
                document.getElementById(id).value = "";
                document.getElementById(id).focus();

                return false;

            }

            if (checkMonth(Month, true)) {


                if (!maxMonthDays(Month, Day, Year)) {

                    document.getElementById(id).value = "";
                    document.getElementById(id).focus();

                    return false;
                }

            }
            if (checkDay(Day, true)) {

                if (!maxMonthDays(Month, Day, Year)) {

                    document.getElementById(id).value = "";
                    document.getElementById(id).focus();

                    return false;
                }
            }
            if (checkYear(Year, true)) {

                if (!maxMonthDays(Month, Day, Year)) {

                    document.getElementById(id).value = "";
                    document.getElementById(id).focus();

                    return false;
                }
            }
            futureDateValidation('MainContent_txtdateFrom');

           <%-- if (!FiscalYearValidation()) {
                alert("Date range is out of calender year.");
                document.getElementById('<%=txtdateto.ClientID %>').focus();

                document.getElementById('<%=txtdateto.ClientID %>').value = "";
                return false;
            }--%>

            //if (T != "") {
            //    futureDateValidation('MainContent_txtdateto');
            //}
        }

        function CalenderYearValid(id) {

            var F = document.getElementById('<%=txtdateFrom.ClientID %>').value;
            //var T = document.getElementById('<%=txtdateto.ClientID %>').value;
            var T = document.getElementById(id).value;

            var FDate = new Date(F);
            var TDate = new Date(T);

            var FYear = FDate.getFullYear();
            var FMonth = FDate.getMonth() + 1;
            var FDay = FDate.getDay();
            var TYear = TDate.getFullYear();
            var TMonth = TDate.getMonth() + 1;
            var TDay = TDate.getDay();
            var diff = TYear - FYear;
            if (diff <= 1 && FMonth <= TMonth && FDay <= TDay) {
                return true;
            }
            else
                return false;

        }

        // Separate function to validate date format 'onchange' of the textbox.
        function ValidateAgeDate(id) {

            var F = document.getElementById(id).value;

            var FromDate = new Date(F);
            //From Date Validation Section

            var FromSplit = F.split('/');

            var Month = Number(FromSplit[0]);
            var Day = Number(FromSplit[1]);
            var Year = Number(FromSplit[2]);

            if (Month < 1 || Month > 12) {
                alert(iMonth);

                document.getElementById(id).value = "";

                document.getElementById(id).focus();

                return false;
            }
            if (Day < 1 || Day > 31) {
                alert(iDay);
                document.getElementById(id).value = "";
                document.getElementById(id).focus();

                return false;
            }

            if (Year < 1900 || Year > 2078) {
                alert(iYear);
                document.getElementById(id).value = "";
                document.getElementById(id).focus();

                return false;

            }

            if (checkMonth(Month, true)) {


                if (!maxMonthDays(Month, Day, Year)) {

                    document.getElementById(id).value = "";
                    document.getElementById(id).focus();

                    return false;
                }

            }
            if (checkDay(Day, true)) {

                if (!maxMonthDays(Month, Day, Year)) {

                    document.getElementById(id).value = "";
                    document.getElementById(id).focus();

                    return false;
                }
            }
            if (checkYear(Year, true)) {

                if (!maxMonthDays(Month, Day, Year)) {

                    document.getElementById(id).value = "";
                    document.getElementById(id).focus();

                    return false;
                }
            }
            futureDateValidation('MainContent_txtAge');
        }
        // function to validate date range.
        function RangeValidation() {

            //section From and To date range
            if (document.getElementById('<%=txtdateFrom.ClientID %>').value == "") {
                alert("Date range from is mandatory");
                document.getElementById('<%=txtdateFrom.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%=txtdateto.ClientID %>').value == "") {
                alert("Date range to is mandatory");
                document.getElementById('<%=txtdateto.ClientID %>').focus();
                return false;
            }

            var F = document.getElementById('<%=txtdateFrom.ClientID %>').value;
            var T = document.getElementById('<%=txtdateto.ClientID %>').value;
            var FromDate = new Date(F);
            var ToDate = new Date(T);
            if (FromDate != "" || ToDate != "") {


                if (FromDate > ToDate) {
                    alert("Date range from can not be greater than date range to date.");
                    document.getElementById('<%=txtdateFrom.ClientID %>').focus();
                    document.getElementById('<%=txtdateFrom.ClientID %>').value = '';
                    return false;
                }
                if (ToDate < FromDate) {
                    alert("Date range to date can not be less than date range from date.");
                    document.getElementById('<%=txtdateto.ClientID %>').focus();
                    document.getElementById('<%=txtdateto.ClientID %>').value = '';
                    return false;
                }
            }

            //section referred for OC date range section
            if ($("#chkAdvFilter").is(':checked')) {
                if ($("#chkReferredforOCYes").is(':checked')) {
                   <%-- if (document.getElementById('<%=txtReferredforOCdate.ClientID %>').value == "") {
                        alert("Date range from is mandatory");
                        document.getElementById('<%=txtReferredforOCdate.ClientID %>').focus();
                        return false;
                    }

                    if (document.getElementById('<%=txtReferredforOCdateTo.ClientID %>').value == "") {
                        alert("Date range to is mandatory");
                        document.getElementById('<%=txtReferredforOCdateTo.ClientID %>').focus();
                        return false;
                    }--%>

                    var F = document.getElementById('<%=txtReferredforOCdate.ClientID %>').value;
                    var T = document.getElementById('<%=txtReferredforOCdateTo.ClientID %>').value;
                    var FromDate = new Date(F);
                    var ToDate = new Date(T);
                    if (FromDate != "" || ToDate != "") {


                        if (FromDate > ToDate) {
                            alert("Referred for OC 'Date from' can not be greater than 'Date to' date.");
                            document.getElementById('<%=txtReferredforOCdate.ClientID %>').focus();
                            document.getElementById('<%=txtReferredforOCdate.ClientID %>').value = '';
                            return false;
                        }
                        if (ToDate < FromDate) {
                            alert("Referred for OC 'Date to' date can not be less than 'Date from' date.");
                            document.getElementById('<%=txtReferredforOCdateTo.ClientID %>').focus();
                            document.getElementById('<%=txtReferredforOCdateTo.ClientID %>').value = '';
                            return false;
                        }
                    }
                }

            }
            //===========================================

            //Script to validate age as of date when date radio selected under advance filter checkbox.
            var Check = $('input[name=AdvFilter]').is(":checked");
            if (Check == true) {

                var CheckRadio = $('input[value=RadioText]').is(":checked");
                if (CheckRadio == true) {

                    if (document.getElementById('<%=txtAge.ClientID %>').value == "") {
                        alert("Enter age as of date.");
                        document.getElementById('<%=txtAge.ClientID %>').focus();
                        return false;
                    }
                }
                var FundFrom = parseFloat($("#<%=txtFromAmount.ClientID%>").val());
                var FundTo = parseFloat($("#<%=txtToAmount.ClientID%>").val());
                if (FundTo != "") {
                    if (FundFrom > FundTo) {
                        alert("Funds Provided From must be less than To.");
                        document.getElementById('<%=txtFromAmount.ClientID%>').value = "";
                        document.getElementById('<%=txtToAmount.ClientID%>').value = "";
                        document.getElementById('<%=txtFromAmount.ClientID%>').focus();
                        return false;
                    }
                }
                if (FundTo > 9999.99) {
                    alert("Funds provided should be less than $10000 per calendar year.");
                    return false;
                }

            }




            return true;
        }
        /*
        Created by SA.
        Purpose: To validate US fiscal year.
        */
        function FiscalYearValidation() {
            $("#<%= txtdateto.ClientID %>").removeClass('ErrorControl');
            $("#<%= txtdateFrom.ClientID %>").removeClass('ErrorControl');
            var FromDate = document.getElementById('<%= txtdateFrom.ClientID %>').value;
            var ToDate = document.getElementById('<%= txtdateto.ClientID %>').value;

            var FDate = new Date(FromDate);
            var TDate = new Date(ToDate);

            var FYear = FDate.getFullYear();
            var FMonth = FDate.getMonth() + 1;

            var TYear = TDate.getFullYear();
            var TMonth = TDate.getMonth() + 1;

            var oneDay = 24 * 60 * 60 * 1000;
            var DDiff = Math.ceil((TDate.getTime() - FDate.getTime()) / oneDay);


            if (FDate <= TDate) {

                if (FYear == TYear) {
                    return true;
                }
                else {

                    if (FYear < TYear) {

                        var YDiff = TYear - FYear;
                        if (YDiff > 1) {
                            alert("Date range is out of calender year.");
                            document.getElementById('<%= txtdateto.ClientID %>').focus();
                            $("#<%= txtdateto.ClientID %>").addClass('ErrorControl');
                            $("#<%= txtdateFrom.ClientID %>").addClass('ErrorControl');
                            return false;

                        }
                        var TMDiff = (12 - FMonth) + TMonth;

                        if (TMDiff > 12) {

                            alert("Date range is out of calender year.");
                            document.getElementById('<%= txtdateto.ClientID %>').focus();
                            $("#<%= txtdateto.ClientID %>").addClass('ErrorControl');
                            $("#<%= txtdateFrom.ClientID %>").addClass('ErrorControl');
                            return false;
                        }
                        //Added by:BS on 26-9-2016 to check leap year validation
                        var isFyearIsLeapYear = ((FYear % 4 == 0) && (FYear % 100 != 0) || (FYear % 400 == 0));
                        var isTyearIsLeapYear = ((TYear % 4 == 0) && (TYear % 100 != 0) || (TYear % 400 == 0))

                        if (isFyearIsLeapYear || isTyearIsLeapYear)//check either from year or to year is a leap year
                        {

                            if (isFyearIsLeapYear) // if from year is a leap year 
                            {
                                if (FMonth <= 2)//if month is less than or equal to feb 
                                {
                                    if (DDiff > 365) {

                                        alert("Date range is out of calender year.");
                                        document.getElementById('<%= txtdateto.ClientID %>').focus();
                                        $("#<%= txtdateto.ClientID %>").addClass('ErrorControl');
                                        $("#<%= txtdateFrom.ClientID %>").addClass('ErrorControl');

                                        return false;
                                    }

                                }
                                else {
                                    if (DDiff > 364) {

                                        alert("Date range is out of calender year.");
                                        document.getElementById('<%= txtdateto.ClientID %>').focus();
                                        $("#<%= txtdateto.ClientID %>").addClass('ErrorControl');
                                        $("#<%= txtdateFrom.ClientID %>").addClass('ErrorControl');

                                        return false;
                                    }
                                }

                            }
                            if (isTyearIsLeapYear)// if to year is a leap year 
                            {
                                if (TMonth >= 2)//if month is greater than feb or equal to feb
                                {
                                    if (DDiff > 365) {

                                        alert("Date range is out of calender year.");
                                        document.getElementById('<%= txtdateto.ClientID %>').focus();
                                        $("#<%= txtdateto.ClientID %>").addClass('ErrorControl');
                                        $("#<%= txtdateFrom.ClientID %>").addClass('ErrorControl');

                                        return false;
                                    }

                                }
                                else {
                                    if (DDiff > 364) {

                                        alert("Date range is out of calender year.");
                                        document.getElementById('<%= txtdateto.ClientID %>').focus();
                                        $("#<%= txtdateto.ClientID %>").addClass('ErrorControl');
                                        $("#<%= txtdateFrom.ClientID %>").addClass('ErrorControl');

                                        return false;
                                    }
                                }


                            }

                        }
                        else {

                            //Change By : PA on 23-sep-2016
                            //Purpose difference of date will allow 365 days.
                            //Change Content: DDiff > 364
                            if (DDiff > 364) {

                                alert("Date range is out of calender year.");
                                document.getElementById('<%= txtdateto.ClientID %>').focus();
                                $("#<%= txtdateto.ClientID %>").addClass('ErrorControl');
                                $("#<%= txtdateFrom.ClientID %>").addClass('ErrorControl');

                                return false;
                            }
                        }
                    }

                }
            }
            else
                return false;
            return true;
        }

        /*
        Created by SA On: 29th July, 2K14
        Purpose: To Reset All the Controls.
        */

        function clearControls() {            
            $('input[type=checkbox]').each(function () {

                this.checked = false;

            });
            $('input[type=text]').each(function () {

                $(this).val('');

            });

            $("#chkPrimaryLanguage").next().html('Select Options');
            //16th Sep change by SA
            document.getElementById('chkIsInfoOnly').style.display = 'none';
            document.getElementById('chkIsADRC').style.display = 'none';
            document.getElementById('lblIsADRC').style.display = 'none';
            document.getElementById('lblIsInfoOnly').style.display = 'none';
            //================================================

            document.getElementById('Today').checked = true;
            document.getElementById('<%=pnlAdvFilter.ClientID %>').style.display = 'none';
            document.getElementById('rdoSummary').checked = true;

            document.getElementById('lblDetail').style.display = 'inline';
            document.getElementById('rdoDetail').style.display = 'inline';
            document.getElementById('chkAdvFilter').style.display = 'inline';
            document.getElementById('AdvFilter').style.display = 'inline';
            $('#chkAdvFilter').attr("checked", false);
            $('#rdoDetail').attr("checked", false);
            document.getElementById('rdoDetail').disabled = false;
            document.getElementById('chkAdvFilter').disabled = false;
            document.getElementById('<%=pnlAdvFilter.ClientID %>').style.display = 'none';

            $('#<%= lstAgencyto.ClientID %>').empty();
            $('#<%= lstCountyto.ClientID %>').empty();
            $('#<%= lstCityto.ClientID %>').empty();
            $('#<%= lstServiceto.ClientID %>').empty();
            $('#<%= lstOtherServiceTo.ClientID %>').empty();
            $('#<%= lstRefferedto.ClientID %>').empty();
            $('#<%= lstReferredByTo.ClientID %>').empty();
            $('#<%= lstStaffto.ClientID %>').empty();
            $('#<%= ddlReportType.ClientID %>').val('0');
            $('#<%= ddlAdvFilter.ClientID %>').val('AND');
            $("#<%= txtdateto.ClientID %>").removeClass('ErrorControl');
            $("#<%= txtdateFrom.ClientID %>").removeClass('ErrorControl');

            // Added by GK on 12Sept,2019 Task ID #16715
            $('#<%= lstTownshipTo.ClientID %>').empty();
            $('#<%= lstCustomFieldTo.ClientID %>').empty();

            //added on 21st aug, 2015. sow-379. SA
            //document.getElementById('divReferredforOCDate').style.display = 'none';
            document.getElementById('<%=txtReferredforOCdate.ClientID %>').disabled = true;
            document.getElementById('<%=txtReferredforOCdateTo.ClientID %>').disabled = true;

            document.getElementById('<%=txtReferredforOCdate.ClientID %>').style.backgroundColor = '#dbdbdb';
            document.getElementById('<%=txtReferredforOCdateTo.ClientID %>').style.backgroundColor = '#dbdbdb';

            document.getElementById('<%=txtReferredforOCdate.ClientID %>').value = '';
            document.getElementById('<%=txtReferredforOCdateTo.ClientID %>').value = '';

            //Added by KR on 28 march 2017.
            document.getElementById('<%=txtFromAmount.ClientID %>').disabled = true;
            document.getElementById('<%=txtToAmount.ClientID %>').disabled = true;

            document.getElementById('<%=txtFromAmount.ClientID %>').style.backgroundColor = '#dbdbdb';
            document.getElementById('<%=txtToAmount.ClientID %>').style.backgroundColor = '#dbdbdb';

            document.getElementById('<%=txtFromAmount.ClientID %>').value = '';
            document.getElementById('<%=txtToAmount.ClientID %>').value = '';

            if (!myAjaxHandler()) {                
                ReverseBind();
            }            
        }


        //Function to reset all the controls of the page according to the change in the report type drop down value.

        function Valid(id) {

            var ddl = document.getElementById("ddlReportType");
            var SelVal = id.options[id.selectedIndex].value;
            document.getElementById('rdoSummary').checked = true;
            document.getElementById('chkAdvFilter').checked = false;
            document.getElementById('rdoDetail').checked = false;
            $('#rdoSummary').attr("checked", true);
            document.getElementById('lblDetail').style.display = 'inline';
            document.getElementById('rdoDetail').style.display = 'inline';
            document.getElementById('chkAdvFilter').style.display = 'inline';
            document.getElementById('AdvFilter').style.display = 'inline';
            $('#chkAdvFilter').attr("checked", false);
            $('#rdoDetail').attr("checked", false);
            document.getElementById('rdoDetail').disabled = false;
            document.getElementById('chkAdvFilter').disabled = false;
            document.getElementById('<%=pnlAdvFilter.ClientID %>').style.display = 'none';
            //Changes Starts Here
            // Added on 16th Sep by SA for Duplicate/Unduplicate reporting condition.
            document.getElementById('chkIsInfoOnly').style.display = 'none';
            document.getElementById('chkIsADRC').style.display = 'none';
            document.getElementById('lblIsADRC').style.display = 'none';
            document.getElementById('lblIsInfoOnly').style.display = 'none';
            // Added on 16th Sep by SA for Duplicate/Unduplicate reporting condition.
            if (SelVal == "4") {

                document.getElementById('chkIsInfoOnly').style.display = 'inline';
                document.getElementById('chkIsADRC').style.display = 'inline';
                document.getElementById('lblIsADRC').style.display = 'inline';
                document.getElementById('lblIsInfoOnly').style.display = 'inline';
            }
            //Changes Ends Here

            if (SelVal == "4" || SelVal == "5") {
                document.getElementById('lblDetail').style.display = 'none';
                document.getElementById('rdoDetail').style.display = 'none';
                document.getElementById('chkAdvFilter').style.display = 'none';
                document.getElementById('AdvFilter').style.display = 'none';

            }

            if (SelVal == "0" || "1") {
                $('#rdoSummary').attr("checked", true);
            }
            if (SelVal == "2") {
                document.getElementById('rdoDetail').disabled = true;
                document.getElementById('chkAdvFilter').disabled = true;
                document.getElementById('<%=pnlAdvFilter.ClientID %>').style.display = 'none';
            }
            document.getElementById('<%=fundsProvided.ClientID %>').style.visibility = 'hidden';
            if (SelVal == "0" || SelVal == "1" || SelVal == "3") {
                document.getElementById('<%=fundsProvided.ClientID %>').style.visibility = 'visible';
            }
        }

        // Function to Show/Hide advanced filter section when Advanced filter checked.
        function hideshow(obj) {
            if (obj.checked) {
                document.getElementById('<%=txtReferredforOCdate.ClientID %>').disabled = true;
                document.getElementById('<%=txtReferredforOCdateTo.ClientID %>').disabled = true;
                document.getElementById('<%=txtReferredforOCdate.ClientID %>').style.backgroundColor = '#dbdbdb';
                document.getElementById('<%=txtReferredforOCdateTo.ClientID %>').style.backgroundColor = '#dbdbdb';
                document.getElementById('<%=txtReferredforOCdate.ClientID %>').value = '';
                document.getElementById('<%=txtReferredforOCdateTo.ClientID %>').value = '';
                document.getElementById('<%=txtFromAmount.ClientID %>').disabled = true;
                document.getElementById('<%=txtToAmount.ClientID %>').disabled = true;
                document.getElementById('<%=txtFromAmount.ClientID %>').style.backgroundColor = '#dbdbdb';
                document.getElementById('<%=txtToAmount.ClientID %>').style.backgroundColor = '#dbdbdb';
                document.getElementById('<%=txtFromAmount.ClientID %>').value = '';
                document.getElementById('<%=txtToAmount.ClientID %>').value = '';
                // Added by VK on 03 Aud,2017.
                document.getElementById('<%=txtFundProvidedDateFrom.ClientID %>').disabled = true;
                document.getElementById('<%=txtFundProvidedDateTo.ClientID %>').disabled = true;
                document.getElementById('<%=txtFundProvidedDateFrom.ClientID %>').style.backgroundColor = '#dbdbdb';
                document.getElementById('<%=txtFundProvidedDateTo.ClientID %>').style.backgroundColor = '#dbdbdb';
                document.getElementById('<%=txtFundProvidedDateFrom.ClientID %>').value = '';
                document.getElementById('<%=txtFundProvidedDateTo.ClientID %>').value = '';

                $('input[value=Today]').attr("checked", true);
                document.getElementById('Today').checked = true;
                document.getElementById('MainContent_txtAge').value = "";
                document.getElementById('MainContent_txtAge').style.display = "none";
                document.getElementById('MainContent_txtAge').value = "";
                document.getElementById('<%=pnlAdvFilter.ClientID %>').style.display = 'inline';
                $("#<%=pnlAdvFilter.ClientID %>").find('input[type=checkbox]:checked').removeAttr('checked');
                $('#<%= ddlAdvFilter.ClientID %>').val('AND');
                $('input[name=multiselect_chkPrimaryLanguage]').each(function () {
                    this.checked = false;
                });
                document.getElementById("txtSearchPL").value = "";
                $("#txtSearchPL").val('');
                // Added to display items after reset of check advance filter. SA.
                $('ul[class="ui-multiselect-checkboxes ui-helper-reset"] li').css({ 'display': 'list-item' });

                $("#chkPrimaryLanguage").next().html('Select Options');

                getContactTypeInfo();
            }
            else {
                document.getElementById('<%=pnlAdvFilter.ClientID %>').style.display = 'none';
            }
        }
        //Created by SA on 21st Aug, 2015. SOW-379
        function ShowHideReferredforOCDate(obj) {
            if (obj.checked) {
                document.getElementById('<%=txtReferredforOCdate.ClientID %>').disabled = false;
                document.getElementById('<%=txtReferredforOCdateTo.ClientID %>').disabled = false;
                document.getElementById('<%=txtReferredforOCdate.ClientID %>').style.backgroundColor = '';
                document.getElementById('<%=txtReferredforOCdateTo.ClientID %>').style.backgroundColor = '';
            }
            else {
                document.getElementById('<%=txtReferredforOCdate.ClientID %>').disabled = true;
                document.getElementById('<%=txtReferredforOCdateTo.ClientID %>').disabled = true;
                document.getElementById('<%=txtReferredforOCdate.ClientID %>').style.backgroundColor = '#dbdbdb';
                document.getElementById('<%=txtReferredforOCdateTo.ClientID %>').style.backgroundColor = '#dbdbdb';
                document.getElementById('<%=txtReferredforOCdate.ClientID %>').value = '';
                document.getElementById('<%=txtReferredforOCdateTo.ClientID %>').value = '';
            }

        }
        //added by SA on 10th sep, 2015. SOW-379
        function CheckYes() {

            var DisabilityYes = document.getElementById("chkReferredforOCYes");
            var DisabilityNo = document.getElementById("chkReferredforOCNo");

            if (DisabilityYes.checked == true) {
                DisabilityNo.checked = false;

            }
        }
        //added by SA on 10th sep, 2015. SOW-379
        function CheckNo() {

            var DisabilityYes = document.getElementById("chkReferredforOCYes");
            var DisabilityNo = document.getElementById("chkReferredforOCNo");

            if (DisabilityNo.checked == true) {
                DisabilityYes.checked = false;
                document.getElementById('<%=txtReferredforOCdate.ClientID %>').disabled = true;
                document.getElementById('<%=txtReferredforOCdateTo.ClientID %>').disabled = true;
                document.getElementById('<%=txtReferredforOCdate.ClientID %>').style.backgroundColor = '#dbdbdb';
                document.getElementById('<%=txtReferredforOCdateTo.ClientID %>').style.backgroundColor = '#dbdbdb';
                document.getElementById('<%=txtReferredforOCdate.ClientID %>').value = '';
                document.getElementById('<%=txtReferredforOCdateTo.ClientID %>').value = '';
            }
        }



        //added by KR on 24 march 2017
        function ShowHideFundAmount(obj) {
            if (obj.checked) {
                document.getElementById('<%=txtFromAmount.ClientID %>').disabled = false;
                document.getElementById('<%=txtToAmount.ClientID %>').disabled = false;
                document.getElementById('<%=txtFromAmount.ClientID %>').style.backgroundColor = '';
                document.getElementById('<%=txtToAmount.ClientID %>').style.backgroundColor = '';
                // Added by VK on 03 Aud,2017.
                document.getElementById('<%=txtFundProvidedDateFrom.ClientID %>').disabled = false;
                document.getElementById('<%=txtFundProvidedDateTo.ClientID %>').disabled = false;
                document.getElementById('<%=txtFundProvidedDateFrom.ClientID %>').style.backgroundColor = '';
                document.getElementById('<%=txtFundProvidedDateTo.ClientID %>').style.backgroundColor = '';
            }
            else {
                document.getElementById('<%=txtFromAmount.ClientID %>').disabled = true;
                document.getElementById('<%=txtToAmount.ClientID %>').disabled = true;
                document.getElementById('<%=txtFromAmount.ClientID %>').style.backgroundColor = '#dbdbdb';
                document.getElementById('<%=txtToAmount.ClientID %>').style.backgroundColor = '#dbdbdb';
                document.getElementById('<%=txtFromAmount.ClientID %>').value = '';
                document.getElementById('<%=txtToAmount.ClientID %>').value = '';
                // Added by VK on 03 Aud,2017.
                document.getElementById('<%=txtFundProvidedDateFrom.ClientID %>').disabled = true;
                document.getElementById('<%=txtFundProvidedDateTo.ClientID %>').disabled = true;
                document.getElementById('<%=txtFundProvidedDateFrom.ClientID %>').style.backgroundColor = '#dbdbdb';
                document.getElementById('<%=txtFundProvidedDateTo.ClientID %>').style.backgroundColor = '#dbdbdb';
                document.getElementById('<%=txtFundProvidedDateFrom.ClientID %>').value = '';
                document.getElementById('<%=txtFundProvidedDateTo.ClientID %>').value = '';
            }

        }
        function CheckYesFundProvided() {
            var DisabilityYes = document.getElementById("chkFundProvidedYes");
            var DisabilityNo = document.getElementById("chkFundProvidedNo");

            if (DisabilityYes.checked == true) {
                DisabilityNo.checked = false;
                document.getElementById('<%=txtFromAmount.ClientID %>').disabled = false;
                document.getElementById('<%=txtToAmount.ClientID %>').disabled = false;
                document.getElementById('<%=txtFromAmount.ClientID %>').style.backgroundColor = '';
                document.getElementById('<%=txtToAmount.ClientID %>').style.backgroundColor = '';
                // Added by VK on 03 Aud,2017.
                document.getElementById('<%=txtFundProvidedDateFrom.ClientID %>').disabled = false;
                document.getElementById('<%=txtFundProvidedDateTo.ClientID %>').disabled = false;
                document.getElementById('<%=txtFundProvidedDateFrom.ClientID %>').style.backgroundColor = '';
                document.getElementById('<%=txtFundProvidedDateTo.ClientID %>').style.backgroundColor = '';
            }
        }
        //added by KR on 24 march 2017
        function CheckNoFundProvided() {

            var DisabilityYes = document.getElementById("chkFundProvidedYes");
            var DisabilityNo = document.getElementById("chkFundProvidedNo");

            if (DisabilityNo.checked == true) {
                DisabilityYes.checked = false;
                document.getElementById('<%=txtFromAmount.ClientID %>').disabled = true;
                document.getElementById('<%=txtToAmount.ClientID %>').disabled = true;
                document.getElementById('<%=txtFromAmount.ClientID %>').style.backgroundColor = '#dbdbdb';
                document.getElementById('<%=txtToAmount.ClientID %>').style.backgroundColor = '#dbdbdb';
                document.getElementById('<%=txtFromAmount.ClientID %>').value = '';
                document.getElementById('<%=txtToAmount.ClientID %>').value = '';
                //Added by VK on 03 Aug 2017.
                document.getElementById('<%=txtFundProvidedDateFrom.ClientID %>').disabled = true;
                document.getElementById('<%=txtFundProvidedDateTo.ClientID %>').disabled = true;
                document.getElementById('<%=txtFundProvidedDateFrom.ClientID %>').style.backgroundColor = '#dbdbdb';
                document.getElementById('<%=txtFundProvidedDateTo.ClientID %>').style.backgroundColor = '#dbdbdb';
                document.getElementById('<%=txtFundProvidedDateFrom.ClientID %>').value = '';
                document.getElementById('<%=txtFundProvidedDateTo.ClientID %>').value = '';
            }
        }


        // Created by SA -- Get County by agency
        function GetCounty() {
            var SelectedAgencyID = GetIDString($("#<%=lstAgencyto.ClientID %>"));
            var lbxCtrl = $('#<%=lstCountyFrom.ClientID %>');
            lbxCtrl.attr('disabled', 'disabled');
            lbxCtrl.empty();
            //            lbxCtrl.append('<option value="0">< Loading Please Wait... ></option>');
            $('#divcounty').show();
            $.ajax({
                type: "POST",
                url: "ADRCReporting.aspx/GetCounty",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'SiteID':'" + SelectedAgencyID + "'}",
                async: false,
                success: function (data) { 
                        var Result = JSON.parse(data.d);
                        lbxCtrl.removeAttr('disabled');
                        lbxCtrl.empty();
                        if (Result == null) {
                            return;
                        }
                        $.each(Result, function (i, data) {
                            lbxCtrl.append('<option value="' + data.CountyName + '">' + data.CountyName + '</option>');
                        });                                                           
                },
                complete: function () {
                    $('#divcounty').hide();
                },
                error: function () {
                    lbxCtrl.empty();
                    lbxCtrl.append('<option value="0">< Error Loading Data ></option>');
                    alert('Failed to retrieve data.');
                }
            });

            GetCity();
        }

        //Created by SA -- Get City on conditional basis.
        function GetCity() {
            var CountyNameList;
            var SelectedAgencyID = GetIDString($("#<%=lstAgencyto.ClientID %>"));
            var lbxCtrl = $('#<%=lstCityFrom.ClientID %>');
            var count = $("#<%=lstCountyto.ClientID %>")[0].length;
            if (count > 0) {
                CountyNameList = GetIDString($("#<%=lstCountyto.ClientID %>"));

            }
            else {
                CountyNameList = GetIDString($("#<%=lstCountyFrom.ClientID %>"));
                lbxCtrl.empty();
            }
            lbxCtrl.attr('disabled', 'disabled');
            lbxCtrl.empty();
            //            lbxCtrl.append('<option value="0">< Loading Please Wait... ></option>');
            $('#divcity').show();
            $.ajax({
                type: "POST",
                url: "ADRCReporting.aspx/GetCity",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'County1':'" + CountyNameList + "','SiteID':'" + SelectedAgencyID + "'}",
                async: false,
                success: function (data) {
                        var Result = JSON.parse(data.d);
                        lbxCtrl.removeAttr('disabled');
                        lbxCtrl.empty();
                        if (Result == null) {
                            return;
                        }
                        $.each(Result, function (i, data) {
                            lbxCtrl.append('<option value="' + data.CityName + '">' + data.CityName + '</option>');
                        });                                     
                },
                complete: function () {
                    $('#divcity').hide();
                },
                error: function () {
                    lbxCtrl.empty();
                    lbxCtrl.append('<option value="0">< Error Loading Data ></option>');
                    alert('Failed to retrieve data.');
                }
            });
        }
        //Created by VK on 23 April,2019 -- Get Township on conditional basis.
        function GetTownship() {            
            var SelectedAgencyID = GetIDString($("#<%=lstAgencyto.ClientID %>"));
            var lbxCtrl = $('#<%=lstTownshipFrom.ClientID %>');
            lbxCtrl.attr('disabled', 'disabled');
            lbxCtrl.empty();
            //            lbxCtrl.append('<option value="0">< Loading Please Wait... ></option>');
            $('#divTownship').show();
            $.ajax({
                type: "POST",
                url: "ADRCReporting.aspx/GetTownship",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'SiteID':'" + SelectedAgencyID + "'}",
                async: false,
                success: function (data) {
                        var Result = JSON.parse(data.d);
                        lbxCtrl.removeAttr('disabled');
                        lbxCtrl.empty();
                        if (Result == null) {
                            return;
                        }
                        $.each(Result, function (i, data) {
                            lbxCtrl.append('<option value="' + data.TownshipCode + '">' + data.TownshipName + '</option>');
                        });                                       
                },
                complete: function () {
                    $('#divTownship').hide();
                },
                error: function () {
                    lbxCtrl.empty();
                    lbxCtrl.append('<option value="0">< Error Loading Data ></option>');
                    alert('Failed to retrieve data.');
                }
            });
        }
        //Created by VK on 23 April,2019 -- Get CustomField on conditional basis.
        function GetCustomField() {
            var SelectedAgencyID = GetIDString($("#<%=lstAgencyto.ClientID %>"));
            var lbxCtrl = $('#<%=lstCustomFieldFrom.ClientID %>');
            lbxCtrl.attr('disabled', 'disabled');
            lbxCtrl.empty();
            //            lbxCtrl.append('<option value="0">< Loading Please Wait... ></option>');
            $('#divCustomField').show();
            $.ajax({
                type: "POST",
                url: "ADRCReporting.aspx/GetCustomField",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'SiteID':'" + SelectedAgencyID + "'}",
                async: false,
                success: function (data) { 
                        var Result = JSON.parse(data.d);
                        lbxCtrl.removeAttr('disabled');
                        lbxCtrl.empty();
                        if (Result == null) {
                            return;
                        }
                        $.each(Result, function (i, data) {
                            lbxCtrl.append('<option value="' + data.CustomCode + '">' + data.CustomName + '</option>');
                        });                    
                },
                complete: function () {
                    $('#divCustomField').hide();
                },
                error: function () {
                    lbxCtrl.empty();
                    lbxCtrl.append('<option value="0">< Error Loading Data ></option>');
                    alert('Failed to retrieve data.');
                }
            });
        }


        var recursionCount = 0;  //Added by AR, 08-March-2024
        //Created by SA -- Services by Agency..
        function getServicesbyAgency() {

            // Increment recursion count each time the function is called
            recursionCount++; //Added by AR, 08-March-2024

            var SelectedAgencyID = GetIDString($("#<%=lstAgencyto.ClientID %>"));
            var lbxCtrl = $('#<%=lstServiceFrom.ClientID %>');
            lbxCtrl.attr('disabled', 'disabled');
            lbxCtrl.empty();
            //            lbxCtrl.append('<option value="0">< Loading Please Wait... ></option>');
            $('#divservice').show();
            $.ajax({
                type: "POST",
                url: "ADRCReporting.aspx/GetService",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'SiteID':'" + SelectedAgencyID + "'}",
                async: false,
                success: function (data) {
 
                        var Result = JSON.parse(data.d);
                        lbxCtrl.removeAttr('disabled');
                        lbxCtrl.empty();
                        if (Result == null) {
                            return;
                        }
                        //if (Result == "-2") { commented
                        //    $('#divservice').hide();
                        //    //alert('Connection Timed Out');
                        //    lbxCtrl.empty();
                        //    lbxCtrl.attr('disabled', 'disabled');
                        //    lbxCtrl.append('<option value="0">< Timed out while loading services. ></option>');
                        //    return;
                        //}
                        //$('#divservice').hide(); commented
                        $.each(Result, function (i, data) {
                            lbxCtrl.append('<option value="' + data.ServiceID + '">' + data.ServiceName + '</option>');
                        });                   
                },
                complete: function () {
                    $('#divservice').hide(); //uncommented
                },
                error: function () {
                    lbxCtrl.empty();
                    lbxCtrl.append('<option value="0">< Error Loading Data.. ></option>');

                    //Added by AR, 08-March-2024
                    // Check if recursion has occurred only once
                    if (recursionCount === 1) {
                        getServicesbyAgency(); // Call the function again
                    }
                }
            });
        }

        //Created by SA -- Get staff by agency..
        function getStaffbyAgency() {
            //debugger;
            var SelectedAgencyID = GetIDString($("#<%=lstAgencyto.ClientID %>"));
            var lbxCtrl = $('#<%=lstStaffFrom.ClientID %>');
            lbxCtrl.attr('disabled', 'disabled');
            lbxCtrl.empty();
            //lbxCtrl.append('<option value="0">< Loading Please Wait... ></option>');
            $('#divstaff').show();
            $.ajax({
                type: "POST",
                url: "ADRCReporting.aspx/GetStaff",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'SiteID':'" + SelectedAgencyID + "'}",
                async: false,
                success: function (data) {
                        var Result = JSON.parse(data.d);
                        lbxCtrl.removeAttr('disabled');
                        lbxCtrl.empty();
                        if (Result == null || Result=="") {
                            return;
                        }
                        $.each(Result, function (i, data) {
                            lbxCtrl.append('<option value="' + data.UserName + '">' + data.Name + '</option>');
                        });                    
                },
                complete: function () {
                    $('#divstaff').hide();
                },
                error: function () {
                    lbxCtrl.empty();
                    lbxCtrl.append('<option value="0"><Error Loading Data ></option>');
                    alert('Failed to retrieve data.');
                }
            });
        }


        var recursionCountOtherServices = 0;  //Added by AR, 08-March-2024
        //Created by KP on 25th March 2020(SOW-577), Get and bind the Other Services by Agency..
        function getOtherServicesbyAgency() {

            recursionCountOtherServices++;  //Added by AR, 08-March-2024

            var SelectedAgencyID = GetIDString($("#<%=lstAgencyto.ClientID %>"));
            var lbxCtrl = $('#<%=lstOtherServiceFrom.ClientID %>');
            lbxCtrl.attr('disabled', 'disabled');
            lbxCtrl.empty();
            $('#divOtherservice').show();

            $.ajax({
                type: "POST",
                url: "ADRCReporting.aspx/GetOtherService",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'SiteID':'" + SelectedAgencyID + "'}",
                async: false,
                success: function (data) {
                        var Result = JSON.parse(data.d);
                        lbxCtrl.removeAttr('disabled');
                        lbxCtrl.empty();
                        if (Result == null) {
                            return;
                        }
                        $.each(Result, function (i, data) {
                            lbxCtrl.append('<option value="' + data.ServiceReqOther + '">' + data.ServiceReqOther + '</option>');
                        });                
                },
                complete: function () {
                    $('#divOtherservice').hide(); //uncommented
                },
                error: function () {
                    lbxCtrl.empty();
                    lbxCtrl.append('<option value="0">< Error Loading Data.. ></option>');

                    //Added by AR, 08-March-2024
                    if (recursionCountOtherServices === 1) { 
                        getOtherServicesbyAgency();
                    }                    
                }
            });
        }

         //Created by KP on 26th March 2020(SOW-577), Add Other Services
         function AddOtherService() {
            var selectedOptions = $('#<%=lstOtherServiceFrom.ClientID %> option:selected');
            var selectedOptionsFrom = $('#<%=lstOtherServiceFrom.ClientID %> option');

            if (selectedOptionsFrom.length == 0) {
                alert("Nothing to add.");
                return false;
            }
            if (selectedOptions.length == 0) {
                alert("Please select option to move.");
                return false;
            }
            if (selectedOptions.length == 1) {
                if ($("#<%=lstOtherServiceTo.ClientID %> option[value='" + selectedOptions.val() + "']").length > 0) {
                }
                else {
                    $('#<%=lstOtherServiceTo.ClientID %>').append($(selectedOptions).clone());
                }
            }
            else if (selectedOptions.length > 1)
            {
                $(selectedOptions).each(function () {
                    if ($("#<%=lstOtherServiceTo.ClientID %> option[value='" + this.value + "']").length > 0) { }
                    else { $('#<%=lstOtherServiceTo.ClientID %>').append($(this).clone()); }
                });
            }
            $('#<%=lstOtherServiceFrom.ClientID %>')[0].selectedIndex = -1;
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }

        //Created by KP on 26th March 2020(SOW-577), Add all Other Services
        function AddOtherServiceAll() {
            var selectedOptions = $('#<%=lstOtherServiceFrom.ClientID %> option');

            if (selectedOptions.length == 0) {
                alert("Nothing to add.");
                return false;
            }
            if (selectedOptions.length == 1) {
                if ($("#<%=lstOtherServiceTo.ClientID %> option[value='" + selectedOptions.val() + "']").length > 0) {
                }
                else {
                    $('#<%=lstOtherServiceTo.ClientID %>').append($(selectedOptions).clone());
                }
            }
            else if (selectedOptions.length > 1)
            {
                $(selectedOptions).each(function () {
                    if ($("#<%=lstOtherServiceTo.ClientID %> option[value='" + this.value + "']").length > 0) { }
                    else { $('#<%=lstOtherServiceTo.ClientID %>').append($(this).clone()); }
                });
            }
            $('#<%=lstOtherServiceFrom.ClientID %>')[0].selectedIndex = -1;
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }

        //Created by KP on 26th March 2020(SOW-577), Remove Other Services
        function RemoveOtherService() {
            var selectedOptions = $('#<%=lstOtherServiceTo.ClientID %> option:selected');
            var selectedOptionsTo = $('#<%=lstOtherServiceTo.ClientID %> option');

            if (selectedOptionsTo.length == 0) {
                alert("Nothing to remove.");
                return false;
            }
            if (selectedOptions.length == 0) {
                alert("Please select option to move.");
                return false;
            }

            $(selectedOptions).remove();
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }

        //Created by KP on 26th March 2020(SOW-577), Remove all Other Services
        function RemoveOtherServiceAll() {
            var selectedOptions = $('#<%=lstOtherServiceTo.ClientID %> option');
            if (selectedOptions.length == 0) {
                alert("Nothing to remove.");
                return false;
            }
            $(selectedOptions).remove();
            this.intTimerLimit = parseInt("<%= Session.Timeout * 60 %>");

            return false;
        }

    </script>
    <script type="text/javascript">

        $(function () {

            getLanguages();
            $("#chkPrimaryLanguage").multiselect().multiselectfilter();

        });

        function setHeaderText() {
            $("#chkPrimaryLanguage").next().html(GetCheckboxText('chkPrimaryLanguage'));
        }
        function GetCheckboxText(id) {//id==> chkTriggers & chkList

            var chkValues = $('input[name=multiselect_' + id + ']:checked').map(function () { return $(this).next().html(); }).get().join(',');

            var len = $('input[name=multiselect_' + id + ']:checked').length;

            //chkValues = (len > 0) ? (len > 3) ? len : chkValues : chkValues;

            return (chkValues == "") ? "Select options" : len + " selected";
        }

        //Created by SA. SOW-335. Purpose: get checked values comma separated.
        function GetCheckboxValuesM(chkName) {// chkList & chlTriggers

            var chkValues = $('input[name=multiselect_' + chkName + ']:checked').map(function () { return $(this).val(); }).get().join(',');

            return chkValues;
        }

        //Created by SA. SOW-335. Purpose: Bind Primary and Other Languages
        function getLanguages() {

            $.ajax({
                type: "POST",
                url: "ADRCReporting.aspx/getLanguages",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{}",
                async: false,
                success: function (data) {
                        var Result = JSON.parse(data.d);
                        $.each(Result, function (key, value) {

                            $("#chkPrimaryLanguage").append("<option value=" + value.Language + ">" + " " + value.Language + "</option>");

                        });        
                },

                error: function () {

                    alert('Failed to retrieve data.');
                }
            });
        }

        //Created by KP on 31st Dec 2019(SOW-577), Purpose: Get ContactType info.
        function getContactTypeInfo() {
            //debugger;
            try {
                $('#Progressbar').show();

                //Destroy the multiselect and multiselectfilter every time from second request and onwards.
                if (!isFirstTimeRequest) {                    
                    $('#chkProfInfo option').remove();
                    $('#chkProxyInfo option').remove();
                    $('#chkFamilyInfo option').remove();
                    $('#chkOtherInfo option').remove();
                    $('#chkCaregiverInfo option').remove();
                    $("#chkProfInfo").multiselect('destroy').multiselectfilter("destroy");
                    $("#chkProxyInfo").multiselect('destroy').multiselectfilter("destroy");
                    $("#chkFamilyInfo").multiselect('destroy').multiselectfilter("destroy");
                    $("#chkOtherInfo").multiselect('destroy').multiselectfilter("destroy");    
                    $("#chkCaregiverInfo").multiselect('destroy').multiselectfilter("destroy");
                }

                isFirstTimeRequest = false;
                var SelectedAgencyID = GetIDString($("#<%=lstAgencyto.ClientID %>"));

                $.ajax({
                    type: "POST",
                    url: "ADRCReporting.aspx/GetContactTypeInfo",
                    headers: { 'X-Requested-With': 'XMLHttpRequest' },
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'SiteID':'" + SelectedAgencyID + "'}",
                    async: false,
                    success: function (data) {
                            BindContactTypeInfo(data);                                           
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        var responseText;
                        responseText = jQuery.parseJSON(XMLHttpRequest.responseText);
                        var errMsg = 'Please try again!' + '\n\nError: ' + responseText.Message;
                        $('#Progressbar').hide();
                        alert(errMsg);
                    },
                    complete: function () {
                        $('#Progressbar').hide();
                    }
                });
                
                $("#chkProfInfo").multiselect().multiselectfilter();
                $("#chkProxyInfo").multiselect().multiselectfilter();
                $("#chkFamilyInfo").multiselect().multiselectfilter();
                $("#chkOtherInfo").multiselect().multiselectfilter();
                $("#chkCaregiverInfo").multiselect().multiselectfilter();
                

            }
            catch (e){
                //alert('Error');
            }
        }

        //Created by KP on 31st Dec 2019(SOW-577), Purpose: Bind ContactType info.
        function BindContactTypeInfo(data) {
            //debugger;
            var tableValues = JSON.parse(data.d);  

            $.each(tableValues.Table, function (key, value) {
                $("#chkProfInfo").append("<option value=" + value.ReferringAgencyDetailID + ">" + " " + value.ContactInfo + "</option>");
            });

            $.each(tableValues.Table1, function (key, value) {
                $("#chkProxyInfo").append("<option value=" + value.ReferringAgencyDetailID + ">" + " " + value.ContactInfo + "</option>");
            });

            $.each(tableValues.Table2, function (key, value) {
                $("#chkFamilyInfo").append("<option value=" + value.ReferringAgencyDetailID + ">" + " " + value.ContactInfo + "</option>");
            });

            $.each(tableValues.Table3, function (key, value) {
                $("#chkOtherInfo").append("<option value=" + value.ReferringAgencyDetailID + ">" + " " + value.ContactInfo + "</option>");
            });

            $.each(tableValues.Table4, function (key, value) {
                $("#chkCaregiverInfo").append("<option value=" + value.ReferringAgencyDetailID + ">" + " " + value.ContactInfo + "</option>");
            });

        }
        function GetCheckboxTextM(id) {
            var chkValues = $('input[name=multiselect_' + id + ']:checked').map(function () { return $(this).next().html(); }).get().join(',');
            
            return chkValues;
        }
    </script>
    <div class="form_block">
        <table width="100%" class="adrcReportWpr">
            <tr>
                <td align="center">
                    <br />
                    <br />
                    <table width="90%">
                        <tr>
                            <td colspan="3">
                                <div style="border-bottom: 3px solid gray; text-align: center; font-weight: bold;">
                                    ADRC REPORTING REPORTS
                                </div>
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 12%; text-align: right;">
                                <b>Report Type</b>
                            </td>
                            <td width="2%">
                                <strong>:</strong>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlReportType" runat="server" onchange="return Valid(this);">
                                    <asp:ListItem Value="0" Selected="True">Info Only</asp:ListItem>
                                    <asp:ListItem Value="1">ADRC</asp:ListItem>
                                    <asp:ListItem Value="2">Unknown(Info only & ADRC both unchecked)</asp:ListItem>
                                    <asp:ListItem Value="3">Info only & ADRC (both checked)</asp:ListItem>
                                    <asp:ListItem Value="4">Duplicated/Unduplicated Report</asp:ListItem>
                                    <asp:ListItem Value="5">County wide Services Requested Report</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <br />
                                <table width="100%">
                                    <tr id="Agency" runat="server">
                                        <td width="10%" align="right" valign="top">
                                            <b>Agency</b>
                                        </td>
                                        <td width="2%" valign="top" style="padding-right:10px;">
                                            <strong>:</strong>
                                        </td>
                                        <td width="31%">
                                            <asp:ListBox ID="lstAgencyFrom" Width="100%" SelectionMode="Multiple" Height="100px"
                                                runat="server"></asp:ListBox>
                                        </td>
                                        <td width="15%" align="center">
                                            <div>
                                                <input type="button" id="Add" value="Add>>" onclick="AddAgency();" class="multiple_selecter_btn" />
                                            </div>
                                            <div style="height: 3px;">
                                                &nbsp;
                                            </div>
                                            <div>
                                                <input type="button" id="btnAddAll" onclick="AddAgencyAll();" class="multiple_selecter_btn"
                                                    value="Add All>>" />
                                            </div>
                                            <div style="height: 5px;">
                                                &nbsp;
                                            </div>
                                            <div>
                                                <input type="button" id="btnRemove" onclick="RemoveAgency();" class="multiple_selecter_btn"
                                                    value="<<Remove" />
                                            </div>
                                            <div style="height: 3px;">
                                                &nbsp;
                                            </div>
                                            <div>
                                                <input type="button" id="btnRemoveAll" onclick="RemoveAgencyAll();" class="multiple_selecter_btn"
                                                    value="<<Remove All" />
                                            </div>
                                        </td>
                                        <td width="32%">
                                            <asp:ListBox ID="lstAgencyto" Width="100%" SelectionMode="Multiple" Height="100px"
                                                runat="server"></asp:ListBox>
                                            <asp:HiddenField ID="HFAgency1" runat="server" />
                                        </td>
                                        <td width="5%"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px;">&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" width="10%" valign="top">
                                            <b>County</b>
                                        </td>
                                        <td valign="top" width="2%">
                                            <strong>:</strong>
                                        </td>
                                        <td width="31%">
                                            <div class="main-select">
                                                <asp:ListBox ID="lstCountyFrom" Width="100%" SelectionMode="Multiple" Height="100px"
                                                    runat="server"></asp:ListBox>
                                                <div id="divcounty" style="display: none;" class="select-loader">
                                                </div>
                                            </div>
                                        </td>
                                        <td align="center" width="15%">
                                            <div>
                                                <input type="button" id="County" onclick="AddCounty();" class="multiple_selecter_btn"
                                                    value="Add>>" />
                                            </div>
                                            <div style="height: 3px;">
                                                &nbsp;
                                            </div>
                                            <div>
                                                <input type="button" id="CountyAll" onclick="AddCountyAll();" class="multiple_selecter_btn"
                                                    value="Add All>>" />
                                            </div>
                                            <div style="height: 5px;">
                                                &nbsp;
                                            </div>
                                            <div>
                                                <input type="button" id="CountyR" onclick="RemoveCounty();" class="multiple_selecter_btn"
                                                    value="<<Remove" />
                                            </div>
                                            <div style="height: 3px;">
                                                &nbsp;
                                            </div>
                                            <div>
                                                <input type="button" id="CountyRAll" onclick="RemoveCountyAll();" class="multiple_selecter_btn"
                                                    value="<<Remove All" />
                                            </div>
                                        </td>
                                        <td width="32%">
                                            <asp:ListBox ID="lstCountyto" Width="100%" Height="100px" SelectionMode="Multiple"
                                                runat="server"></asp:ListBox>
                                            <asp:HiddenField ID="HFCounty1" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 5px;">&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" width="10%" valign="top">
                                            <b>City</b>
                                        </td>
                                        <td valign="top" width="2%">
                                            <strong>:</strong>
                                        </td>
                                        <td width="31%">
                                            <div class="main-select">
                                                <asp:ListBox ID="lstCityFrom" Width="100%" SelectionMode="Multiple" Height="100px"
                                                    runat="server"></asp:ListBox>
                                                <div id="divcity" style="display: none;" class="select-loader">
                                                </div>
                                            </div>
                                        </td>
                                        <td align="center" width="15%">
                                            <div>
                                                <input type="button" id="Button8" onclick="AddCity();" class="multiple_selecter_btn"
                                                    value="Add>>" />
                                            </div>
                                            <div style="height: 3px;">
                                                &nbsp;
                                            </div>
                                            <div>
                                                <input type="button" id="Button9" onclick="AddCityAll();" class="multiple_selecter_btn"
                                                    value="Add All>>" />
                                            </div>
                                            <div style="height: 5px;">
                                                &nbsp;
                                            </div>
                                            <div>
                                                <input type="button" id="Button10" onclick="RemoveCity();" class="multiple_selecter_btn"
                                                    value="<<Remove" />
                                            </div>
                                            <div style="height: 3px;">
                                                &nbsp;
                                            </div>
                                            <div>
                                                <input type="button" id="Button11" onclick="RemoveCityAll();" class="multiple_selecter_btn"
                                                    value="<<Remove All" />
                                            </div>
                                        </td>
                                        <td width="32%">
                                            <asp:ListBox ID="lstCityto" Width="100%" Height="100px" SelectionMode="Multiple"
                                                runat="server"></asp:ListBox>
                                            <asp:HiddenField ID="HFCity1" runat="server" />
                                        </td>
                                    </tr>

                                    <%--Added by GK on 10Apr19 : SOW-563--%>
                                    <%-- Search by Township --%>
                                    <tr>
                                        <td style="height: 5px;">&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" width="10%" valign="top">
                                            <b>Township</b>
                                        </td>
                                        <td valign="top" width="2%">
                                            <strong>:</strong>
                                        </td>
                                        <td width="31%">
                                            <div class="main-select">
                                                <asp:ListBox ID="lstTownshipFrom" Width="100%" SelectionMode="Multiple" Height="100px"
                                                    runat="server"></asp:ListBox>
                                                <div id="divTownship" style="display: none;" class="select-loader">
                                                </div>
                                            </div>
                                        </td>
                                        <td align="center" width="15%">
                                            <div>
                                                <input type="button" id="btnAddTownship" onclick="AddTownship();" class="multiple_selecter_btn"
                                                    value="Add>>" />
                                            </div>
                                            <div style="height: 3px;">
                                                &nbsp;
                                            </div>
                                            <div>
                                                <input type="button" id="btnAddAllTownship" onclick="AddTownshipAll();" class="multiple_selecter_btn"
                                                    value="Add All>>" />
                                            </div>
                                            <div style="height: 5px;">
                                                &nbsp;
                                            </div>
                                            <div>
                                                <input type="button" id="btnRemoveTownship" onclick="RemoveTownship();" class="multiple_selecter_btn"
                                                    value="<<Remove" />
                                            </div>
                                            <div style="height: 3px;">
                                                &nbsp;
                                            </div>
                                            <div>
                                                <input type="button" id="btnRemoveAllTownship" onclick="RemoveTownshipAll();" class="multiple_selecter_btn"
                                                    value="<<Remove All" />
                                            </div>
                                        </td>
                                        <td width="32%">
                                            <asp:ListBox ID="lstTownshipTo" Width="100%" Height="100px" SelectionMode="Multiple"
                                                runat="server"></asp:ListBox>
                                        </td>
                                    </tr>
                                    <%-- Search by CustomCode --%>
                                    <tr>
                                        <td style="height: 5px;">&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" width="10%" valign="top">
                                            <b>Custom Field</b>
                                        </td>
                                        <td valign="top" width="2%">
                                            <strong>:</strong>
                                        </td>
                                        <td width="31%">
                                            <div class="main-select">
                                                <asp:ListBox ID="lstCustomFieldFrom" Width="100%" SelectionMode="Multiple" Height="100px"
                                                    runat="server"></asp:ListBox>
                                                <div id="divCustomField" style="display: none;" class="select-loader">
                                                </div>
                                            </div>
                                        </td>
                                        <td align="center" width="15%">
                                            <div>
                                                <input type="button" id="btnAddCustomField" onclick="AddCustomField();" class="multiple_selecter_btn"
                                                    value="Add>>" />
                                            </div>
                                            <div style="height: 3px;">
                                                &nbsp;
                                            </div>
                                            <div>
                                                <input type="button" id="btnAddAllCustomField" onclick="AddCustomFieldAll();" class="multiple_selecter_btn"
                                                    value="Add All>>" />
                                            </div>
                                            <div style="height: 5px;">
                                                &nbsp;
                                            </div>
                                            <div>
                                                <input type="button" id="btnRemoveCustomField" onclick="RemoveCustomField();" class="multiple_selecter_btn"
                                                    value="<<Remove" />
                                            </div>
                                            <div style="height: 3px;">
                                                &nbsp;
                                            </div>
                                            <div>
                                                <input type="button" id="btnRemoveAllCustomField" onclick="RemoveCustomFieldAll();" class="multiple_selecter_btn"
                                                    value="<<Remove All" />
                                            </div>
                                        </td>
                                        <td width="32%">
                                            <asp:ListBox ID="lstCustomFieldTo" Width="100%" Height="100px" SelectionMode="Multiple"
                                                runat="server"></asp:ListBox>
                                        </td>
                                    </tr>

                                    <%--Ends--%>

                                    <tr>
                                        <td style="height: 5px;">&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" valign="top">
                                            <b>Service</b>
                                        </td>
                                        <td valign="top">
                                            <strong>:</strong>
                                        </td>
                                        <td>
                                            <div class="main-select">
                                                <asp:ListBox ID="lstServiceFrom" SelectionMode="Multiple" Width="100%" Height="100px"
                                                    runat="server"></asp:ListBox>
                                                <div id="divservice" style="display: none;" class="select-loader">
                                                </div>
                                            </div>
                                        </td>
                                        <td align="center">
                                            <div>
                                                <input type="button" id="Button12" onclick="AddService();" class="multiple_selecter_btn"
                                                    value="Add>>" />
                                            </div>
                                            <div style="height: 3px;">
                                                &nbsp;
                                            </div>
                                            <div>
                                                <input type="button" id="Button13" onclick="AddServiceAll();" class="multiple_selecter_btn"
                                                    value="Add All>>" />
                                            </div>
                                            <div style="height: 5px;">
                                                &nbsp;
                                            </div>
                                            <div>
                                                <input type="button" id="Button14" onclick="RemoveService();" class="multiple_selecter_btn"
                                                    value="<<Remove" />
                                            </div>
                                            <div style="height: 3px;">
                                                &nbsp;
                                            </div>
                                            <div>
                                                <input type="button" id="Button15" onclick="RemoveServiceAll();" class="multiple_selecter_btn"
                                                    value="<<Remove All" />
                                            </div>
                                        </td>
                                        <td>
                                            <asp:ListBox ID="lstServiceto" Width="100%" SelectionMode="Multiple" Height="100px"
                                                runat="server"></asp:ListBox>
                                            <asp:HiddenField ID="HFService1" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 5px;">&nbsp;
                                        </td>
                                    </tr>

                                    <%--Added by KP on 23rd March 2020(SOW-577), Other Service--%>
                                    <tr>
                                        <td align="right" valign="top">
                                            <b>Other Service</b>
                                        </td>
                                        <td valign="top">
                                            <strong>:</strong>
                                        </td>
                                        <td>
                                            <div class="main-select">
                                                <asp:ListBox ID="lstOtherServiceFrom" SelectionMode="Multiple" Width="100%" Height="100px"
                                                    runat="server"></asp:ListBox>
                                                <div id="divOtherservice" style="display: none;" class="select-loader">
                                                </div>
                                            </div>
                                        </td>
                                        <td align="center">
                                            <div>
                                                <input type="button" id="btnAddOtherService" onclick="AddOtherService();" class="multiple_selecter_btn"
                                                    value="Add>>" />
                                            </div>
                                            <div style="height: 3px;">
                                                &nbsp;
                                            </div>
                                            <div>
                                                <input type="button" id="btnAddAllOtherService" onclick="AddOtherServiceAll();" class="multiple_selecter_btn"
                                                    value="Add All>>" />
                                            </div>
                                            <div style="height: 5px;">
                                                &nbsp;
                                            </div>
                                            <div>
                                                <input type="button" id="btnRemoveOtherService" onclick="RemoveOtherService();" class="multiple_selecter_btn"
                                                    value="<<Remove" />
                                            </div>
                                            <div style="height: 3px;">
                                                &nbsp;
                                            </div>
                                            <div>
                                                <input type="button" id="btnRemoveAllOtherService" onclick="RemoveOtherServiceAll();" class="multiple_selecter_btn"
                                                    value="<<Remove All" />
                                            </div>
                                        </td>
                                        <td>
                                            <asp:ListBox ID="lstOtherServiceTo" Width="100%" SelectionMode="Multiple" Height="100px"
                                                runat="server"></asp:ListBox>
                                            <asp:HiddenField ID="HFOtherService1" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 5px;">&nbsp;
                                        </td>
                                    </tr>
                                    <%--END(SOW-577)--%>

                                    <tr>
                                        <td align="right" valign="top">
                                            <b>Referred By</b>
                                        </td>
                                        <td valign="top">
                                            <strong>:</strong>
                                        </td>
                                        <td>
                                            <asp:ListBox ID="lstReferredByFrom" SelectionMode="Multiple" Width="100%" Height="100px"
                                                runat="server"></asp:ListBox>
                                        </td>
                                        <td align="center">
                                            <div>
                                                <input type="button" id="btnAdd" onclick="AddRefferedByto();" class="multiple_selecter_btn"
                                                    value="Add>>" />
                                            </div>
                                            <div style="height: 3px;">
                                                &nbsp;
                                            </div>
                                            <div>
                                                <input type="button" id="btnAddALL" onclick="AddRefferedBytoAll();" class="multiple_selecter_btn"
                                                    value="Add All>>" />
                                            </div>
                                            <div style="height: 5px;">
                                                &nbsp;
                                            </div>
                                            <div>
                                                <input type="button" id="btnRemoveref" onclick="RemoveRefferedByto();" class="multiple_selecter_btn"
                                                    value="<<Remove" />
                                            </div>
                                            <div style="height: 3px;">
                                                &nbsp;
                                            </div>
                                            <div>
                                                <input type="button" id="btnremoveall" onclick="RemoveRefferedBytoAll();" class="multiple_selecter_btn"
                                                    value="<<Remove All" />
                                            </div>
                                        </td>
                                        <td>
                                            <asp:ListBox ID="lstReferredByTo" Width="100%" SelectionMode="Multiple" Height="100px"
                                                runat="server"></asp:ListBox>
                                            <asp:HiddenField ID="HiddenField1" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 5px;">&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" valign="top">
                                            <b>Referred To</b>
                                        </td>
                                        <td valign="top">
                                            <strong>:</strong>
                                        </td>
                                        <td>
                                            <asp:ListBox ID="lstRefferedtoFrom" SelectionMode="Multiple" Width="100%" Height="100px"
                                                runat="server"></asp:ListBox>
                                        </td>
                                        <td align="center">
                                            <div>
                                                <input type="button" id="Button16" onclick="AddRefferedto();" class="multiple_selecter_btn"
                                                    value="Add>>" />
                                            </div>
                                            <div style="height: 3px;">
                                                &nbsp;
                                            </div>
                                            <div>
                                                <input type="button" id="Button17" onclick="AddRefferedtoAll();" class="multiple_selecter_btn"
                                                    value="Add All>>" />
                                            </div>
                                            <div style="height: 5px;">
                                                &nbsp;
                                            </div>
                                            <div>
                                                <input type="button" id="Button18" onclick="RemoveRefferedto();" class="multiple_selecter_btn"
                                                    value="<<Remove" />
                                            </div>
                                            <div style="height: 3px;">
                                                &nbsp;
                                            </div>
                                            <div>
                                                <input type="button" id="Button19" onclick="RemoveRefferedtoAll();" class="multiple_selecter_btn"
                                                    value="<<Remove All" />
                                            </div>
                                        </td>
                                        <td>
                                            <asp:ListBox ID="lstRefferedto" Width="100%" SelectionMode="Multiple" Height="100px"
                                                runat="server"></asp:ListBox>
                                            <asp:HiddenField ID="HFRefto1" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 5px;">&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" valign="top">
                                            <b>Staff</b>
                                        </td>
                                        <td valign="top">
                                            <strong>:</strong>
                                        </td>
                                        <td>
                                            <div class="main-select">
                                                <asp:ListBox ID="lstStaffFrom" SelectionMode="Multiple" Width="100%" Height="100px"
                                                    runat="server"></asp:ListBox>
                                                <div id="divstaff" style="display: none;" class="select-loader">
                                                </div>
                                            </div>
                                        </td>
                                        <td align="center">
                                            <div>
                                                <input type="button" id="Button20" onclick="AddStaff();" class="multiple_selecter_btn"
                                                    value="Add>>" />
                                            </div>
                                            <div style="height: 3px;">
                                                &nbsp;
                                            </div>
                                            <div>
                                                <input type="button" id="Button1" onclick="AddStaffAll();" class="multiple_selecter_btn"
                                                    value="Add All>>" />
                                            </div>
                                            <div style="height: 5px;">
                                                &nbsp;
                                            </div>
                                            <div>
                                                <input type="button" id="Button22" onclick="RemoveStaff();" class="multiple_selecter_btn"
                                                    value="<<Remove" />
                                            </div>
                                            <div style="height: 3px;">
                                                &nbsp;
                                            </div>
                                            <div>
                                                <input type="button" id="Button2" onclick="RemoveStaffAll();" class="multiple_selecter_btn"
                                                    value="<<Remove All" />
                                            </div>
                                        </td>
                                        <td>
                                            <asp:ListBox ID="lstStaffto" SelectionMode="Multiple" Width="100%" Height="100px"
                                                runat="server"></asp:ListBox>
                                            <asp:HiddenField ID="HFStaff1" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <br />
                                <table width="100%">
                                    <tr>
                                        <td width="10%" align="left">
                                            <b>Date Range From</b>
                                        </td>
                                        <td width="2%" align="left">
                                            <strong>:</strong>
                                        </td>
                                        <td width="78%" align="left" colspan="2">
                                            <asp:TextBox ID="txtdateFrom" runat="server" MaxLength="10" onchange="ValidateInputDate('MainContent_txtdateFrom');" />
                                            <ajax:CalendarExtender ID="txtdateFrom_CalendarExtender" runat="server" CssClass="req"
                                                Enabled="True" TargetControlID="txtdateFrom">
                                            </ajax:CalendarExtender>
                                            <ajax:MaskedEditExtender ID="mskcalNDoB" runat="server" MaskType="date" Mask="99/99/9999"
                                                AcceptNegative="None" AutoComplete="false" ClearTextOnInvalid="true" UserDateFormat="MonthDayYear"
                                                TargetControlID="txtdateFrom">
                                            </ajax:MaskedEditExtender>
                                            &nbsp;&nbsp;<b>To:&nbsp;&nbsp;</b>
                                            <asp:TextBox ID="txtdateto" runat="server" MaxLength="10" onchange="ValidateInputDate('MainContent_txtdateto');" />
                                            <ajax:CalendarExtender ID="txtdateto_CalendarExtender" runat="server" CssClass="req"
                                                Enabled="True" TargetControlID="txtdateto">
                                            </ajax:CalendarExtender>
                                            <ajax:MaskedEditExtender ID="MaskedEditExtender1" runat="server" MaskType="date"
                                                AcceptNegative="None" AutoComplete="false" ClearTextOnInvalid="true" UserDateFormat="MonthDayYear"
                                                Mask="99/99/9999" TargetControlID="txtdateto">
                                            </ajax:MaskedEditExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <div style="height: 5px;">
                                                &nbsp;
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">&nbsp;
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                        <td width="15%" align="left">
                                            <input id="rdoSummary" style="font-size: 13px;" name="Summary" type="radio" value="0"
                                                checked="checked" />
                                            <label style="font-size: 11px;">
                                                Summary</label>
                                            <input id="rdoDetail" style="font-size: 13px;" type="radio" name="Summary" value="1" />
                                            <label id="lblDetail" style="font-size: 11px;">
                                                Detail</label>
                                        </td>
                                        <td align="left">
                                            <input id="chkAdvFilter" type="checkbox" name="AdvFilter" onclick="hideshow(this)"
                                                value="1" />
                                            <label id="AdvFilter" style="font-size: 11px;">
                                                Advance Filter</label>&nbsp;
                                            <input id="chkIsInfoOnly" type="checkbox" name="IsInfoOnly" />&nbsp;
                                            <label id="lblIsInfoOnly" style="font-size: 11px;">
                                                Info Only</label>
                                            <input id="chkIsADRC" type="checkbox" name="IsADRC" />&nbsp;
                                            <label id="lblIsADRC" style="font-size: 11px;">
                                                ADRC</label>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                            </td>
                        </tr>
                    </table>
                    <br />
                    <table width="80%">
                        <tr>
                            <td>
                                <asp:Panel ID="pnlAdvFilter" runat="server" GroupingText="Advance Filter" Style="display: none;">
                                    <%--Style="display: none;"--%>
                                    <table width="100%">
                                        <tr>
                                            <td align="left">
                                                <b>Group By: </b>
                                                <asp:DropDownList ID="ddlAdvFilter" runat="server">
                                                    <asp:ListItem Value="AND" Selected="True">AND</asp:ListItem>
                                                    <asp:ListItem Value="OR">OR</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div id="Checks">
                                                    <table width="100%">
                                                        <tr>
                                                            <td align="left" valign="top" width="15%">
                                                                <b>Contact Type</b>
                                                            </td>
                                                            <td valign="top" width="2%">
                                                                <strong>:</strong>
                                                            </td>
                                                            <td align="left" width="83%">                                                                
                                                                <table style="width:100%">
                                                                    <tr>
                                                                        <td style="width:140px;">
                                                                            <asp:CheckBoxList ID="chkContactType" CssClass="tdPadding ContactType" Font-Size="15px" RepeatDirection="Vertical"
                                                                                runat="server">
                                                                            </asp:CheckBoxList>
                                                                        </td>
                                                                        <td valign="top">
                                                                           <table style="width:100%" class="ContactTypeInfo">
                                                                               <tr>
                                                                                   <td style="width:140px;"></td>
                                                                                   <td></td>
                                                                               </tr>
                                                                               <tr>
                                                                                   <td>
                                                                                       <label><b>Caregiver Info</b></label>
                                                                                   </td>
                                                                                   <td>
                                                                                        <select id="chkCaregiverInfo" style="width: 400px;">
                                                                                        </select>
                                                                                   </td>
                                                                               </tr>
                                                                               <tr >
                                                                                   <td>
                                                                                       <label><b>Professional Info</b></label>
                                                                                   </td>
                                                                                   <td>
                                                                                        <select id="chkProfInfo" style="width: 400px;">
                                                                                        </select>
                                                                                   </td>
                                                                               </tr>
                                                                               <tr>
                                                                                   <td>
                                                                                       <label><b>Proxy Info</b></label>
                                                                                   </td>
                                                                                   <td>
                                                                                        <select id="chkProxyInfo" style="width: 400px;">
                                                                                        </select>
                                                                                   </td>
                                                                               </tr>
                                                                               <tr>
                                                                                   <td>
                                                                                       <label><b>Family Info</b></label>
                                                                                   </td>
                                                                                   <td>
                                                                                        <select id="chkFamilyInfo" style="width: 400px;">
                                                                                        </select>
                                                                                   </td>
                                                                               </tr>
                                                                               <tr>
                                                                                   <td>
                                                                                       <label><b>Other Info</b></label>
                                                                                   </td>
                                                                                   <td>
                                                                                        <select id="chkOtherInfo" style="width: 400px;">
                                                                                        </select>
                                                                                   </td>
                                                                               </tr>
                                                                           </table>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3">
                                                                <div style="height: 5px;">
                                                                    &nbsp;
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="15%" align="left">
                                                                <b>Contact Method</b>
                                                            </td>
                                                            <td width="2%">
                                                                <strong>:</strong>
                                                            </td>
                                                            <td width="83%" align="left">
                                                                <asp:CheckBoxList ID="chkContactMethod" Font-Size="15px" RepeatDirection="Horizontal"
                                                                    runat="server">
                                                                </asp:CheckBoxList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3">
                                                                <div style="height: 5px;">
                                                                    &nbsp;
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" width="15%" valign="top">
                                                                <b>Age as of</b>
                                                            </td>
                                                            <td width="2%" valign="top">
                                                                <strong>:</strong>
                                                            </td>
                                                            <td align="left" width="83%">
                                                                <div style="width: 100%; float: left;">
                                                                    <div id="toggler" style="float: left; width: 17%;">
                                                                        <input id="Today" onclick="AgeRadioCheck();" style="font-size: 13px;" name="Today"
                                                                            type="radio" value="Today" />&nbsp;<label>Today</label>&nbsp;&nbsp;
                                                                        <input id="RadioText" onclick="AgeRadioCheck();" style="font-size: 13px;" type="radio"
                                                                            name="Today" value="RadioText" />&nbsp;<label>Date</label>
                                                                    </div>
                                                                    <div style="float: right; width: 82%;">
                                                                        <asp:TextBox ID="txtAge" runat="server" onchange="ValidateAgeDate('MainContent_txtAge');"></asp:TextBox>
                                                                        <ajax:CalendarExtender ID="CalendarExtender1" runat="server" CssClass="req" Enabled="True"
                                                                            TargetControlID="txtAge">
                                                                        </ajax:CalendarExtender>
                                                                        <ajax:MaskedEditExtender ID="MaskedEditExtender2" runat="server" MaskType="date"
                                                                            AcceptNegative="None" AutoComplete="false" ClearTextOnInvalid="true" UserDateFormat="MonthDayYear"
                                                                            Mask="99/99/9999" TargetControlID="txtAge">
                                                                        </ajax:MaskedEditExtender>
                                                                    </div>
                                                                </div>
                                                                <div style="height: 10px;">
                                                                </div>
                                                                <br />
                                                                <div style="float: left;">
                                                                    <input type="checkbox" name="AgeRange" value="A1" />&nbsp;<label>0-5</label>
                                                                    <input type="checkbox" name="AgeRange" value="A2" />&nbsp;<label>6-10</label>
                                                                    <input type="checkbox" name="AgeRange" value="A3" />&nbsp;<label>11-15</label>
                                                                    <input type="checkbox" name="AgeRange" value="A4" />&nbsp;<label>16-20</label>
                                                                    <input type="checkbox" name="AgeRange" value="A5" />&nbsp;<label>21-25</label>
                                                                    <input type="checkbox" name="AgeRange" value="A6" />&nbsp;<label>26-30</label>
                                                                    <input type="checkbox" name="AgeRange" value="A7" />&nbsp;<label>31-35</label>
                                                                    <input type="checkbox" name="AgeRange" value="A8" />&nbsp;<label>36-40</label>
                                                                    <input type="checkbox" name="AgeRange" value="A9" />&nbsp;<label>41-45</label>
                                                                    <input type="checkbox" name="AgeRange" value="A10" />&nbsp;<label>46-50</label>
                                                                    <input type="checkbox" name="AgeRange" value="A11" />&nbsp;<label>51-55</label>
                                                                    <input type="checkbox" name="AgeRange" value="A12" />&nbsp;<label>56-60</label><br />
                                                                    <input type="checkbox" name="AgeRange" value="A13" />&nbsp;<label>61-65</label>
                                                                    <input type="checkbox" name="AgeRange" value="A14" />&nbsp;<label>> 65</label>
                                                                    <input type="checkbox" name="AgeRange" value="A15" />&nbsp;<label>Unknown</label>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3">
                                                                <div style="height: 5px;">
                                                                    &nbsp;
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" width="15%">
                                                                <b>Gender</b>
                                                            </td>
                                                            <td width="2%">
                                                                <strong>:</strong>
                                                            </td>
                                                            <td align="left" width="83%">
                                                                <asp:CheckBoxList ID="chkGender" Font-Size="15px" RepeatDirection="Horizontal" runat="server">
                                                                    <asp:ListItem Value="Male">Male</asp:ListItem>
                                                                    <asp:ListItem Value="Female">Female</asp:ListItem>
                                                                    <asp:ListItem Value="Not Listed">Not Listed</asp:ListItem>
                                                                    <asp:ListItem Value="Unknown">Unknown</asp:ListItem>
                                                                </asp:CheckBoxList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3">
                                                                <div style="height: 5px;">
                                                                    &nbsp;
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" width="15%">
                                                                <b>Marital Status</b>
                                                            </td>
                                                            <td width="2%">
                                                                <strong>:</strong>
                                                            </td>
                                                            <td align="left" width="83%">
                                                                <asp:CheckBoxList ID="chkMaritalStatus" Font-Size="15px" RepeatDirection="Horizontal"
                                                                    runat="server" RepeatLayout="Flow">
                                                                </asp:CheckBoxList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3">
                                                                <div style="height: 5px;">
                                                                    &nbsp;
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" width="15%" valign="top">
                                                                <b>Living Arrangement</b>
                                                            </td>
                                                            <td width="2%" valign="top">
                                                                <strong>:</strong>
                                                            </td>
                                                            <td align="left" width="83%">
                                                                <asp:CheckBoxList ID="chkLivingArrangement" RepeatColumns="4" Font-Size="15px" RepeatDirection="Horizontal"
                                                                    runat="server" RepeatLayout="Table">
                                                                </asp:CheckBoxList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3">
                                                                <div style="height: 5px;">
                                                                    &nbsp;
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" width="15%">
                                                                <b>Demographics</b>
                                                            </td>
                                                            <td width="2%">
                                                                <strong>:</strong>
                                                            </td>
                                                            <td align="left" width="83%">
                                                                <%--<asp:CheckBox ID="ChkNoDemographics" runat="server" Text=""  />--%>
                                                                <asp:CheckBoxList ID="ChkNoDemographics" Font-Size="15px" runat="server" RepeatDirection="Horizontal">
                                                                    <asp:ListItem Value="0">No</asp:ListItem>
                                                                    <asp:ListItem Value="1">Yes</asp:ListItem>
                                                                </asp:CheckBoxList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3">
                                                                <div style="height: 5px;">
                                                                    &nbsp;
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" width="15%">
                                                                <b>Race</b>
                                                            </td>
                                                            <td width="2%">
                                                                <strong>:</strong>
                                                            </td>
                                                            <td align="left" width="83%">
                                                                <asp:CheckBoxList ID="chkRace" RepeatDirection="Horizontal" RepeatColumns="5" runat="server" Font-Size="15px"
                                                                    RepeatLayout="Flow">
                                                                </asp:CheckBoxList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3">
                                                                <div style="height: 5px;">
                                                                    &nbsp;
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" width="15%">
                                                                <b>Primary Language</b>
                                                            </td>
                                                            <td width="2%">
                                                                <strong>:</strong>
                                                            </td>
                                                            <td align="left" width="83%">
                                                                <p>
                                                                    <select id="chkPrimaryLanguage" onchange="setHeaderText()" style="width: 400px;">
                                                                    </select>
                                                                </p>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3">
                                                                <div style="height: 5px;">
                                                                    &nbsp;
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" width="15%">
                                                                <b>Ethnicity</b>
                                                            </td>
                                                            <td width="2%">
                                                                <strong>:</strong>
                                                            </td>
                                                            <td align="left" width="83%">
                                                                <asp:CheckBoxList ID="chkEthnicity" Font-Size="15px" runat="server" RepeatDirection="Horizontal">
                                                                    <%--<asp:ListItem Value="0">Hispanic</asp:ListItem>
                                                                    <asp:ListItem Value="1">Non-Hispanic</asp:ListItem>
                                                                     <asp:ListItem Value="2">Prefer not to answer</asp:ListItem>
                                                                    <asp:ListItem Value="999">Unknown</asp:ListItem>--%>
                                                                </asp:CheckBoxList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3">
                                                                <div style="height: 5px;">
                                                                    &nbsp;
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" width="15%">
                                                                <b>Veteran Applicable</b>
                                                            </td>
                                                            <td width="2%">
                                                                <strong>:</strong>
                                                            </td>
                                                            <td align="left" width="83%">
                                                                <asp:CheckBoxList ID="chkVeteranApplicable" Font-Size="15px" RepeatDirection="Horizontal"
                                                                    runat="server" RepeatLayout="Flow">
                                                                    <asp:ListItem Value="1">No</asp:ListItem>
                                                                    <asp:ListItem Value="4">Yes</asp:ListItem>

                                                                    <%--<asp:ListItem Value="2">None</asp:ListItem>
                                                                    <asp:ListItem Value="3">N/A</asp:ListItem> SOW-335 - SA--%>
                                                                    <asp:ListItem Value="999">Unknown</asp:ListItem>
                                                                </asp:CheckBoxList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3">
                                                                <div style="height: 5px;">
                                                                    &nbsp;
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" width="15%">
                                                                <b>Veteran</b>
                                                            </td>
                                                            <td width="2%">
                                                                <strong>:</strong>
                                                            </td>
                                                            <td align="left" width="83%">
                                                                <asp:CheckBoxList ID="chkVeteranStatus" Font-Size="15px" RepeatDirection="Horizontal"
                                                                    runat="server" RepeatLayout="Flow">
                                                                </asp:CheckBoxList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3">
                                                                <div style="height: 5px;">
                                                                    &nbsp;
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" width="15%">
                                                                <b>Caregiver Status</b>
                                                            </td>
                                                            <td width="2%">
                                                                <strong>:</strong>
                                                            </td>
                                                            <td align="left" width="83%">
                                                                <asp:CheckBoxList ID="chkCaregiverNeedyPerson" Font-Size="15px" runat="server" RepeatDirection="Horizontal">
                                                                    <asp:ListItem Value="0">No</asp:ListItem>
                                                                    <asp:ListItem Value="1">Yes</asp:ListItem>
                                                                    <asp:ListItem Value="999">Unknown</asp:ListItem>
                                                                </asp:CheckBoxList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3">
                                                                <div style="height: 5px;">
                                                                    &nbsp;
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" width="15%">
                                                                <b>Service Need Met</b>
                                                            </td>
                                                            <td width="2%">
                                                                <strong>:</strong>
                                                            </td>
                                                            <td align="left" width="83%">
                                                                <asp:CheckBoxList ID="chkServiceNeedMet" Font-Size="15px" runat="server" RepeatDirection="Horizontal">
                                                                    <asp:ListItem Value="0">No</asp:ListItem>
                                                                    <asp:ListItem Value="1">Yes</asp:ListItem>
                                                                    <asp:ListItem Value="999">Unknown</asp:ListItem>
                                                                </asp:CheckBoxList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3">
                                                                <div style="height: 5px;">
                                                                    &nbsp;
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" width="15%">
                                                                <b>Follow Up</b>
                                                            </td>
                                                            <td width="2%">
                                                                <strong>:</strong>
                                                            </td>
                                                            <td align="left" width="83%">
                                                                <asp:CheckBoxList ID="chkFollowUpStatus" Font-Size="15px" runat="server" RepeatDirection="Horizontal">
                                                                    <asp:ListItem Value="0">Open</asp:ListItem>
                                                                    <asp:ListItem Value="1">Completed</asp:ListItem>
                                                                    <asp:ListItem Value="999">Unknown</asp:ListItem>
                                                                </asp:CheckBoxList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3">
                                                                <div style="height: 5px;">
                                                                    &nbsp;
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" width="15%">
                                                                <b>Referred for OC</b>
                                                            </td>
                                                            <td width="2%">
                                                                <strong>:</strong>
                                                            </td>
                                                            <td align="left" width="83%">

                                                                <input id="chkReferredforOCNo" onchange="return CheckNo()" type="checkbox" name="ReferredforOC" value="0" />&nbsp;<label>No</label>&nbsp;
                                                                <input id="chkReferredforOCYes" onchange="return CheckYes()" onclick="ShowHideReferredforOCDate(this);" type="checkbox" name="ReferredforOC" value="1" />&nbsp;<label>Yes</label>
                                                                &nbsp;&nbsp;
                                                                <div style="display: inline;" id="divReferredforOCDate">
                                                                    <b>From:&nbsp;&nbsp;</b>
                                                                    <asp:TextBox ID="txtReferredforOCdate" Width="75px" runat="server" MaxLength="10" onchange="ValidateInputDate('MainContent_txtReferredforOCdate');" />
                                                                    <ajax:CalendarExtender ID="CalendarExtender2" runat="server" CssClass="req"
                                                                        Enabled="True" TargetControlID="txtReferredforOCdate">
                                                                    </ajax:CalendarExtender>
                                                                    <ajax:MaskedEditExtender ID="MaskedEditExtender3" runat="server" MaskType="date" Mask="99/99/9999"
                                                                        AcceptNegative="None" AutoComplete="false" ClearTextOnInvalid="true" UserDateFormat="MonthDayYear"
                                                                        TargetControlID="txtReferredforOCdate">
                                                                    </ajax:MaskedEditExtender>

                                                                    &nbsp;&nbsp;<b>To:&nbsp;&nbsp;</b>
                                                                    <asp:TextBox ID="txtReferredforOCdateTo" Width="75px" runat="server" MaxLength="10" onchange="ValidateInputDate('MainContent_txtReferredforOCdateTo');" />
                                                                    <ajax:CalendarExtender ID="CalendarExtender3" runat="server" CssClass="req"
                                                                        Enabled="True" TargetControlID="txtReferredforOCdateTo">
                                                                    </ajax:CalendarExtender>
                                                                    <ajax:MaskedEditExtender ID="MaskedEditExtender4" runat="server" MaskType="date"
                                                                        AcceptNegative="None" AutoComplete="false" ClearTextOnInvalid="true" UserDateFormat="MonthDayYear"
                                                                        Mask="99/99/9999" TargetControlID="txtReferredforOCdateTo">
                                                                    </ajax:MaskedEditExtender>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3">
                                                                <div style="height: 5px;">
                                                                    &nbsp;
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr id="fundsProvided" runat="server">
                                                            <td align="left" width="15%">
                                                                <b>Funds Provided</b>
                                                            </td>
                                                            <td width="2%">
                                                                <strong>:</strong>
                                                            </td>
                                                            <td align="left" width="83%">

                                                                <input id="chkFundProvidedNo" onchange="return CheckNoFundProvided()" type="checkbox" name="FundProvided" value="0" />&nbsp;<label>No</label>&nbsp;
                                                                <input id="chkFundProvidedYes" onchange="return CheckYesFundProvided()" onclick="ShowHideFundAmount(this);" type="checkbox" name="FundProvided" value="1" />&nbsp;<label>Yes</label>
                                                                &nbsp;&nbsp;
                                                                <div style="display: inline;" id="divFundProvidedAmount">
                                                                    <b>Amount Range From:&nbsp;&nbsp;</b>
                                                                    <div class="input-symbol-euro" style="display: inline;">
                                                                        <span class="symbol">$</span>
                                                                        <asp:TextBox ID="txtFromAmount" Width="57px" runat="server" MaxLength="7" onpaste="return false;" />
                                                                    </div>
                                                                    &nbsp;&nbsp;<b>To:&nbsp;&nbsp;</b>
                                                                    <div class="input-symbol-euro" style="display: inline;">
                                                                        <span class="symbol">$</span>
                                                                        <asp:TextBox ID="txtToAmount" Width="57px" runat="server" MaxLength="7" onpaste="return false;" />
                                                                    </div>
                                                                </div>
                                                                <div style="display: inline;" id="divFundProvidedDate">
                                                                    <b>Date From:&nbsp;&nbsp;</b>
                                                                    <asp:TextBox ID="txtFundProvidedDateFrom" Width="75px" runat="server" MaxLength="10" onchange="ValidateInputDate('MainContent_txtFundProvidedDateFrom');" />
                                                                    <ajax:CalendarExtender ID="CalendarExtender4" runat="server" CssClass="req"
                                                                        Enabled="True" TargetControlID="txtFundProvidedDateFrom">
                                                                    </ajax:CalendarExtender>
                                                                    <ajax:MaskedEditExtender ID="MaskedEditExtender5" runat="server" MaskType="date" Mask="99/99/9999"
                                                                        AcceptNegative="None" AutoComplete="false" ClearTextOnInvalid="true" UserDateFormat="MonthDayYear"
                                                                        TargetControlID="txtFundProvidedDateFrom">
                                                                    </ajax:MaskedEditExtender>

                                                                    &nbsp;&nbsp;<b>To:&nbsp;&nbsp;</b>
                                                                    <asp:TextBox ID="txtFundProvidedDateTo" Width="75px" runat="server" MaxLength="10" onchange="ValidateInputDate('MainContent_txtFundProvidedDateTo');" />
                                                                    <ajax:CalendarExtender ID="CalendarExtender5" runat="server" CssClass="req"
                                                                        Enabled="True" TargetControlID="txtFundProvidedDateTo">
                                                                    </ajax:CalendarExtender>
                                                                    <ajax:MaskedEditExtender ID="MaskedEditExtender6" runat="server" MaskType="date"
                                                                        AcceptNegative="None" AutoComplete="false" ClearTextOnInvalid="true" UserDateFormat="MonthDayYear"
                                                                        Mask="99/99/9999" TargetControlID="txtFundProvidedDateTo">
                                                                    </ajax:MaskedEditExtender>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3">
                                                                <div style="height: 5px;">
                                                                    &nbsp;
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" width="15%" valign="top">
                                                                <b>Funds Utilized for</b>
                                                            </td>
                                                            <td width="2%" valign="top">
                                                                <strong>:</strong>
                                                            </td>
                                                            <td align="left" width="83%">
                                                                <asp:CheckBoxList ID="chklistFundsUtilized" RepeatColumns="5" Font-Size="15px" RepeatDirection="Horizontal"
                                                                    runat="server" RepeatLayout="Table">
                                                                </asp:CheckBoxList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3">
                                                                <div style="height: 5px;">
                                                                    &nbsp;
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" width="15%">&nbsp;
                                                            </td>
                                                            <td width="2%">&nbsp;
                                                            </td>
                                                            <td align="left" width="83%">&nbsp;
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <br />
                                <hr style="border: 2px solid gray;" />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" align="center">
                                <input id="btnRunReport" class="btn_style" onclick="CallADRC();" type="button" value="Run Report" />&nbsp;&nbsp;                                
                                <asp:Button ID="btnClose" CssClass="btn_style" runat="server" Text="Close" OnClick="btnClose_Click" />&nbsp;&nbsp;
                                <input id="btnReset" class="btn_style" type="button" onclick="clearControls();" value="Reset" />                                
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <!-- Added By Aman Bhatnagar on 16th Jul,  2015 -->
    <div id="Progressbar" style="display: none;">
        <div class="loader_bg">
        </div>
        <div class="preloader">
            <p>
                Please wait...
            </p>
        </div>
    </div>
    <script type="text/javascript" language="javascript">

        var modalWin = new CreateModalPopUpObject();
        modalWin.SetLoadingImagePath("../images/loading.gif");
        modalWin.SetCloseButtonImagePath("../images/remove.gif");

        //Uncomment below line to make look buttons as link
        //modalWin.SetButtonStyle("background:none;border:none;textDecoration:underline;cursor:pointer");

        function ShowNewPage() {

            // var callbackFunctionArray = new Array(EnrollNow, EnrollLater);                        
            modalWin.ShowURL('ReportResult.aspx', 550, 1050, 'ADRC Report', null, null);            
        }        


        //function ShowMessage() {
        //    modalWin.ShowMessage('This Modal Popup Window using Javascript', 200, 400, 'User Information');
        //}

        //function ShowMessageWithAction() {
        //    //ShowConfirmationMessage(message, height, width, title,onCloseCallBack, firstButtonText, onFirstButtonClick, secondButtonText, onSecondButtonClick);
        //    modalWin.ShowConfirmationMessage('This is confirmation window using Javascript', 200, 400, 'User Confirmation', null, 'Agree', Action1, 'Disagree', Action2);
        //}

        //function ShowMessageNoDragging() {
        //    modalWin.Draggable = false;
        //    modalWin.ShowMessage('You can not drag this window', 200, 400, 'User Information');

        //}

        //function Action1() {
        //    alert('Action1 is excuted');
        //    modalWin.HideModalPopUp();
        //}

        //function Action2() {
        //    alert('Action2 is excuted');
        //    modalWin.HideModalPopUp();
        //}

        //function EnrollNow(msg) {
        //    modalWin.HideModalPopUp();
        //    modalWin.ShowMessage(msg, 200, 400, 'User Information', null, null);
        //}

        //function EnrollLater() {
        //    modalWin.HideModalPopUp();
        //    modalWin.ShowMessage(msg, 200, 400, 'User Information', null, null);
        //}

        //function HideModalWindow() {
        //    modalWin.HideModalPopUp();
        //}

        //function ShowChildWindowValues(name, email, address, phone, zip) {
        //    var displayString = "<b>Values Of Child Window</b> <br><br>Name : " + name;
        //    displayString += "<br><br>Email : " + email;
        //    displayString += "<br><br>Address : " + address;
        //    displayString += "<br><br>Phone : " + phone;
        //    displayString += "<br><br>Zip : " + zip;
        //    var div = document.getElementById("divShowChildWindowValues");
        //    div.style.display = "";
        //    div.innerHTML = displayString;
        //}

    </script>
</asp:Content>
