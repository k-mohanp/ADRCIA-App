<%@ Page Language="C#" MasterPageFile="~/Site.master" EnableEventValidation="false" MaintainScrollPositionOnPostback="true"
    AutoEventWireup="true" CodeFile="NeedyPerson.aspx.cs" Inherits="NeedyPerson" %>

<%@ Import Namespace="ADRCIA" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<%@ Register TagPrefix="uc" TagName="MultilineTextbox" Src="~/Control/TextArea.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:PlaceHolder runat="server">
        <%: System.Web.Optimization.Styles.Render("~/Content/NeedPerson") %>
        <%: System.Web.Optimization.Scripts.Render("~/Scripts/NeedPerson") %>
    </asp:PlaceHolder>
    <script type="text/javascript" src="Scripts/jquery.multiselect.js"></script>
    <script type="text/javascript" src="Scripts/jquery.multiselect.filter.js"></script>
    <%--<link rel="stylesheet" href="Styles/print.css" type="text/css" media="print" />--%>

   <%-- <link href="assets/jQueryUI.css" rel="stylesheet" type="text/css" />
    <link href="assets/jquery.multiselect.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="assets/jquery.multiselect.filter.css" />
    <link rel="stylesheet" type="text/css" href="assets/style.css" />
    <link rel="stylesheet" type="text/css" href="assets/prettify.css" />--%>
   
    <%--<script type="text/javascript" src="Scripts/jquery.js"></script>
    <script type="text/javascript" src="Scripts/jquery-ui.min.js"></script>
    <script type="text/javascript" src="Scripts/jquery.textarearesizer.compressed.js"></script>
    <script src="Scripts/MaskedEditFix.js" type="text/javascript"></script>
    <script type="text/javascript" src="Scripts/jquery.multiselect.js"></script>
    <script type="text/javascript" src="Scripts/jquery.multiselect.filter.js"></script>
    <script src="Scripts/jquery.tablesorter.min.js" type="text/javascript"></script>
    <script src="Scripts/DateValidation.js" type="text/javascript"></script>
    <script src="Scripts/progressbar_mini.js" type="text/javascript"></script>
    <script type="text/javascript" src="assets/prettify.js"></script>
    <script type="text/javascript" src="Scripts/CommonValidator.js"></script>
    <script src="Scripts/jquery.mcautocomplete.js" type="text/javascript"></script>--%>

    <style type="text/css">
        /*Added by Rahul on 9th June 2020(SOW-577), To make design proper of multi column autocomplete*/
        .ui-menu-item {
            margin-top: -2px !important;
            border-bottom: solid 1px #9b9f92;
        }

        .ui-widget-header {
            height: 17px
        }

        .ui-autocomplete {
            width: 685px
        }

        .ui-menu-item a {
            display: table !important
        }

            .ui-menu-item a span:first-child {
                display: none !important
            }

            .ui-menu-item a span {
                display: table-cell !important;
                float: inherit !important
            }

        .ui-widget-header {
            border: 0px !important;
        }

        .ui-menu {
            padding: 0px !important;
        }

            .ui-menu .ui-menu-item a {
                padding: 0px !important;
            }

        .ui-widget-header span:nth-child(2) {
            border-left: solid 1px #fff;
        }

        .ui-widget-header span {
            border-right: solid 1px #fff;
            border-bottom: solid 1px #fff;
            font-size: 13px;
        }

        .ui-menu-item a span:nth-child(2) {
            border-left: solid 1px #9b9f92;
        }

        .ui-menu-item a span {
            border-right: solid 1px #9b9f92;
            font-size: 13px;
        }

        @media screen and (min-color-index:0) and (-webkit-min-device-pixel-ratio:0) {
            @media {

                .symbol {
                    margin-top: -12px !important
                }
            }
        }

        .ui-autocomplete-loading {
            background: white url('images/smallrotation.gif') right center no-repeat;
        }

        #tblAgencyDetails td {
            padding-left: 2px;
            padding-right: 2px;
        }

        ::-ms-clear {
            display: none;
        }

        #tblViewTimeSpent {
            font-family: Verdana;
            font-size: 12px;
            margin: 0 auto;
            width: 97%;
            margin: 0 0 5px 0;
            border: solid 1px #ccc;
        }

            #tblViewTimeSpent th {
                background-color: #1a3895;
                color: #fff;
                border-left: solid 1px #ccc;
                padding: 1px 0;
                text-align: left !important;
                font-size: 11px;
                font-weight: bold;
            }

            #tblViewTimeSpent td {
                border: solid 1px #ccc;
                /*padding: 0 5px;*/
                padding: 0;
            }

        .TextBackColor {
            background-color: lightgoldenrodyellow;
        }

        .edit-update-btn, .edit-cancel-btn {
            float: left;
            margin-top: 10px;
        }

        .edit-update-btn {
            margin-right: 5px;
        }

        .WordBreak {
            -ms-word-wrap: break-word;
            word-wrap: break-word;
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

            .input-symbol-euro span.symbolDollar {
                position: relative;
            }

        .gridview_home.center-table {
            margin: 0 auto;
        }

        .hdr_style th {
            padding: 3px 15px 3px 3px !important;
        }


        /*Rahul Designer style*/

        .fieldset-box-services-tab-first {
            margin: 0 0.5% 0 0;
        }

        .fieldset-box-services-tab-last {
            float: left;
        }

        .tab2-scroll {
            max-width: 739px;
            overflow: hidden;
            overflow-y: hidden;
        }

        .setfildsetheight > fieldset {
            min-height: 80px !important;
        }

        .label-checkbox input {
            margin: 0px 0px 0 4px !important;
            display: inline-block;
        }

        .label-checkbox label {
            margin: 0px 5px 0 5px;
            display: inline-block;
        }

        .multiple_selecter_btn:disabled {
            color: #999;
            cursor: default;
        }

        .inputSearchIcon {
            position: absolute;
            margin-left: -7px;
            margin-top: 1px;
            background: #2889d8;
            padding: 2px 4px;
            cursor: pointer;
        }

            .inputSearchIcon img {
                width: 12px;
            }

        .popup_form_heading_ContactInfo {
            height: 14px;
            font-weight: bold;
            padding: 4px 0 4px 5px;
            margin: 0;
            border-bottom: solid 5px #1A3592;
            width: 95%;
            background-color: rgba(242, 242, 230, 1);
        }

        .wordWrap {
            word-break: break-all;
            word-wrap: break-word;
        }

        .contactAdd {
            position: relative;
            top: 0px;
            left: 0px;
            width: 97.5% !important;
        }

        /*Added By KP on 31st March 2020(TaskID:18464)*/
        input[type="submit"]:disabled {
            background: #dddddd;
            cursor: default;
        }

        .light-box-body dl {
            margin-left: 10px;
            margin-top: 10px;
        }

        .light-box-body dd {
            margin-bottom: 10px;
            margin-left: 20px;
        }
    </style>

    <script type="text/javascript">
        //Sys.WebForms.PageRequestManager.getInstance()._origOnFormActiveElement = Sys.WebForms.PageRequestManager.getInstance()._onFormElementActive;
        //Sys.WebForms.PageRequestManager.getInstance()._onFormElementActive = function (element, offsetX, offsetY) {
        //    if (element.tagName.toUpperCase() === 'INPUT' && element.type === 'image') {
        //        offsetX = Math.floor(offsetX);
        //        offsetY = Math.floor(offsetY);
        //    }
        //    this._origOnFormActiveElement(element, offsetX, offsetY);
        //};
    </script>

    <script type="text/javascript">

        $(document).ready(function () {
            //approoturl = "<%=(Request.Url.GetLeftPart(UriPartial.Authority) + Request.ApplicationPath) %>"; //Added By AR, 9-Jan-2024 | SOW-654            
        });
        var ContactInfoJSON = '';//Created By KP on 4th June 2020(SOW-577),Global variables is used for ContactInfo search.


        $(function () {            
            ////Added by KP on 31st Jan 2020(SOW-577), Stop the enter key to do not generate other event for this page, because, after partial postback, 
            ////some register events(contact info onkeyup() event) was not working as expected and automatically fired any other button event.
            //$('html').bind('keypress', function (e) {
            //    if (e.keyCode == 13) {
            //        return false;
            //    }
            //});

            //Added by KP on 29th April 2020(SOW-577), Implement mutually exclusive behaviour for 'Permission granted to refer to ADRC partner'
            $("[id*=chkPermissionGranted] input").click(function () {
                $(this).closest("table").find("input").not(this).removeAttr("checked");
            });

        });

        $(document).keydown(function (e) {
            if (e.keyCode == 27 || e.which == 27) return false;
        });

        var validFilesTypes = ["bmp", "gif", "png", "jpg", "jpeg", "doc", "docx", "xls", "xlsx", "pdf", "rtf", "txt", "csv"];
        function ValidateFile() {

            var isValidFile = false;
            var file = document.getElementById("<%=FUDocuments.ClientID%>");

            if (document.getElementById("<%=txtDescription.ClientID%>").value == "") {//

                document.getElementById("<%=lblDecsription.ClientID%>").innerHTML = 'Please enter document description.';
                document.getElementById("<%=lblMessage.ClientID%>").innerHTML = '';
                document.getElementById("<%=txtDescription.ClientID%>").focus();
                return false;
            }
            else
                document.getElementById("<%=lblDecsription.ClientID%>").innerHTML = '';

            if (file.value == "") {

                document.getElementById("<%=lblUploadDoc.ClientID%>").innerHTML = 'Please select document to upload.';
                document.getElementById("<%=lblMessage.ClientID%>").innerHTML = '';
                file.focus();
                return false;

            }
            else
                document.getElementById("<%=lblUploadDoc.ClientID%>").innerHTML = '';

            if (file.value != "") {
                var fileSize = file.files[0].size;

                var MaxSize = <%= Convert.ToInt32(ConfigurationManager.AppSettings["FileUploadSizeLimit"].ToString())%>;

                if (fileSize > MaxSize) {
                    alert('You can not upload files more than 6 MB of size.');
                    document.getElementById("<%=lblMessage.ClientID%>").innerHTML = '';
                    return false;
                }

                var path = file.value;
                var ext = path.substring(path.lastIndexOf(".") + 1, path.length).toLowerCase();

                for (var i = 0; i < validFilesTypes.length; i++) {
                    if (ext == validFilesTypes[i]) {
                        isValidFile = true;
                        break;
                    }
                }
                if (!isValidFile) {
                    alert("Invalid File. Please upload a File with" +
                        " extension:\n\n" + validFilesTypes.join(", "));
                    file.focus();
                    document.getElementById("<%=lblMessage.ClientID%>").innerHTML = '';
                    return false;
                }
            }

            //return isValidFile;
        }
        /*
            Created by SA on 11th March, 2015.
            Purpose: To restrict amount value to its length and then format it.
        */
        function AssignValues(id) {
            var value = document.getElementById(id).value.replace(',', '');


            if (value.length > 6) {

                return false;
            }
            else {

                return true;
            }
        }



        function CommaFormatted(obj, evt) {

            var objval = obj.value.replace(',', '');
            if (obj.value.length > 6) {
                obj.value = objval.substring(objval.length - 6);
            }
            obj.value = obj.value.replace(',', '').replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            //Added by SA on 23rd March, 2015. Catch null exception 
            if (evt != null) {

                var e = window.event || evt;
                var targ = e.target || e.srcElement;
                if (! typeof targ.id == undefined) {
                    var key_code = e.keyCode || evt.which;
                    if (key_code == 9)
                        obj.select();
                }
            }

        }

        // Function to validate Date format 'onchange' of the textbox.
        function ValidateDate(id) {
            // var F = id.value;
            var F = document.getElementById(id).value;
            if (F != '') {
                var FromDate = new Date(F);
                //From Date Validation Section
                var FromSplit = F.split('/');
                var Month = Number(FromSplit[0]);
                var Day = Number(FromSplit[1]);
                var Year = Number(FromSplit[2]);

                if (Day < 1 || Day > 31) {
                    alert(iDay);
                    document.getElementById(id).value = "";
                    document.getElementById(id).focus();
                    return false;
                }
                if (Month < 1 || Month > 12) {
                    alert(iMonth);
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
            }
            return true;
        }


        // Function to validate Date format 'onchange' of the textbox.
        function ValidateInputDate(id, idTime, idReason) {//"MainContent_NeedyPersonTab_tabOptionCounselling_lstViewTimeSpent_txtTravelDate"

            var F = document.getElementById(id).value;
            if (F == "") {
                alert('Enter Travel Date.');
                document.getElementById(id).focus();
                return false;
            }
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

            var Time = document.getElementById(idTime);
            if (Time.value == "____" || Time.value == "") {
                alert("Enter Time Spent.");
                Time.focus();
                return false;
            }

            var TimeN = parseFloat(document.getElementById(idTime).value);
            if (isNaN(TimeN) && (TimeN === 0)) {
                alert("Enter time spent more than zero.");
                document.getElementById(idTime).focus();
                document.getElementById(idTime).value = "";
                return false;
            }
            //if(Time.value =="0"){
            //    alert("Enter time spent more than zero.");
            //    Time.focus();
            //    return false;
            //}

            var reason = document.getElementById(idReason);
            if (reason.value == "") {
                alert("Enter Reason.");
                reason.focus();
                return false;
            }

        }

    </script>

    <script type="text/javascript" language="javascript">



        $(function () {

            getRefferedTo();
            getOCTriggers();
            getReferredToServiceProvider();
            getInsuranceTypes();
            $("#chkList").multiselect().multiselectfilter();
            $("#chkTriggers").multiselect().multiselectfilter();
            $("#chkReferredtoServiceProvider").multiselect().multiselectfilter();
            $("#ddlInsuranceTypes").multiselect().multiselectfilter();
            $("input[name=multiselect_chkList]:eq(0)").prop("checked", false);
            multiSelectBinders();

            setHeaderText();

        });

        <%--function USFormatNumber(){

            $("#<%=txtAssetAmount.ClientID%>").blur(function () {
                var AssetAmount = $(this).formatNumber({ format: "#,###", locale: "us" }).val();      
                
                $("#<%=txtAssetAmount.ClientID%>").val(AssetAmount);
            });

            $("#<%=txtTotalHouseholdIncome.ClientID%>").blur(function () {
                var TotalHouseholdIncome = $(this).formatNumber({ format: "#,###", locale: "us" }).val();                
                $("#<%=txtTotalHouseholdIncome.ClientID%>").val(TotalHouseholdIncome);
            });

            $("#<%=txtSpouse.ClientID%>").blur(function () {
                var Spouse = $(this).formatNumber({ format: "#,###", locale: "us" }).val();                
                $("#<%=txtSpouse.ClientID%>").val(Spouse);
            });

            $("#<%=txtClient.ClientID%>").blur(function () {
                var Client = $(this).formatNumber({ format: "#,###", locale: "us" }).val();                
                $("#<%=txtClient.ClientID%>").val(Client);
            });
        }--%>


        function multiSelectBinders() {
            bindChkDropdowns('chkList', <%= getRefToIDs%>);
            bindChkDropdowns('chkTriggers', <%= TriggerValues%>);
            bindChkDropdowns('chkReferredtoServiceProvider', <%=ReferredToServiceProvider%>);
            bindChkDropdowns('ddlInsuranceTypes', <%=InsuranceTypes%>);

        }

        function CallMultiFunctions() {

            getRefferedTo();
            getOCTriggers();
            getReferredToServiceProvider();
            getInsuranceTypes();
            $('div.ui-multiselect-menu.ui-widget').remove();

            $("#chkList").multiselect().multiselectfilter();
            $("#chkTriggers").multiselect().multiselectfilter();
            $("#chkReferredtoServiceProvider").multiselect().multiselectfilter();
            $("#ddlInsuranceTypes").multiselect().multiselectfilter();

            $("input[name=multiselect_chkList]:eq(0)").prop("checked", false);//ddlInsuranceTypes
            $("input[name=multiselect_ddlInsuranceTypes]:eq(0)").prop("checked", false);
            $("input[name=multiselect_chkTriggers]:eq(0)").prop("checked", false);
            multiSelectBinders();

            setHeaderText();

        }

        //Created by SA. SOW-335. Purpose: Set Header Text of Checkbox dropdown control 
        function setHeaderText() {



            $('#<%=HFTriggers.ClientID%>').val('' + GetCheckboxValues('chkTriggers') + '');
            $('#<%=HFgetRefToIds.ClientID%>').val('' + GetCheckboxValues('chkList') + '');
            $('#<%=HFchkReferredtoServiceProvider.ClientID%>').val('' + GetCheckboxValues('chkReferredtoServiceProvider') + '');
            $('#<%=HFInsuranceTypes.ClientID%>').val('' + GetCheckboxValues('ddlInsuranceTypes') + '');



            $("#chkList").next().html(GetCheckboxText('chkList'));
            $("#chkTriggers").next().html(GetCheckboxText('chkTriggers'));
            $("#chkReferredtoServiceProvider").next().html(GetCheckboxText('chkReferredtoServiceProvider'));
            $("#ddlInsuranceTypes").next().html(GetCheckboxText('ddlInsuranceTypes'));



            $('input[name=multiselect_ddlInsuranceTypes]').change(function () {
                $("#<%= txtInsuranceOther.ClientID%>").hide();
                $("#<%= txtInsuranceOther.ClientID%>").val('');
                if ($(this).is(":checked")) {

                    if ($(this).next().html() == ' Other') {

                        $("#<%= txtInsuranceOther.ClientID%>").show();
                    }
                }

            });


            $('input[name=multiselect_ddlInsuranceTypes]').each(function () {

                $("#<%= txtInsuranceOther.ClientID%>").hide();
                if ($(this).is(":checked")) {

                    if ($(this).next().html() == ' Other') {

                        $("#<%= txtInsuranceOther.ClientID%>").show();
                    }
                }
            });


        }

        //Created by SA. SOW-335. Purpose: Bind Referred to control
        function getRefferedTo() {
            var SiteId = '<%= MySession.SiteId%>';
            $.ajax({
                type: "POST",
                url: "NeedyPerson.aspx/GetRefferedTo",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{}",
                async: false,
                success: function (data) {
                    var Result = JSON.parse(data.d);
                    $.each(Result, function (key, value) {
                        if (value.AAACILSiteID != '0' && value.AAACILSiteID != SiteId)//Added By KP on 12th Apr 2020(TaskID:18464), To exclude AASA and current loged-in Agency from list.
                            $("#chkList").append("<option value=" + value.AAACILSiteID + ">" + " " + value.AAACILSiteName + "</option>");
                    });
                },

                error: function () {

                    alert('Failed to retrieve data.');
                }
            });
        }
        //Created by SA. SOW-335. Purpose: Bind OC Triggers
        function getOCTriggers() {

            $.ajax({
                type: "POST",
                url: "NeedyPerson.aspx/getOCTriggers",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{}",
                async: false,
                success: function (data) {
                    var Result = JSON.parse(data.d);
                    $.each(Result, function (key, value) {

                        $("#chkTriggers").append("<option value=" + value.OCTriggerID + ">" + " " + value.OCTriggerPresent + "</option>");

                    });
                },

                error: function () {

                    alert('Failed to retrieve data.');
                }
            });
        }

        //Created by SA. SOW-335. Purpose: Bind OC Triggers
        function getReferredToServiceProvider() {

            $.ajax({
                type: "POST",
                url: "NeedyPerson.aspx/getReferredToServiceProvider",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{}",
                async: false,
                success: function (data) {
                    var Result = JSON.parse(data.d);
                    $.each(Result, function (key, value) {

                        $("#chkReferredtoServiceProvider").append("<option value=" + value.SiteID + ">" + " " + value.SiteName + "</option>");

                    });
                },

                error: function () {

                    alert('Failed to retrieve data.');
                }
            });
        }
        //Created by SA. SOW-335. Purpose: Bind Referred to control
        function getInsuranceTypes() {

            $.ajax({
                type: "POST",
                url: "NeedyPerson.aspx/GetInsurance",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{}",
                async: false,
                success: function (data) {
                    var Result = JSON.parse(data.d);
                    $.each(Result, function (key, value) {

                        $("#ddlInsuranceTypes").append("<option value=" + value.InsuranceTypeId + ">" + " " + value.InsuranceTypes + "</option>");

                    });
                },

                error: function () {

                    alert('Failed to retrieve data.');
                }
            });
        }

        //Created by SA. SOW-335. Purpose: Property to send comma separated trigger values to DB
        var OCTriggers;
        var getRefToADRCIDs;
        var ReferredToServiceProvider;
        var InsuranceTypes;
        function TriggerProperty() {
            this.OCTriggers = OCTriggers;
            this.getRefToADRCIDs = getRefToADRCIDs;
            this.ReferredToServiceProvider = ReferredToServiceProvider;
            this.InsuranceTypes = InsuranceTypes;
        }
        //Created by SA. SOW-335. Purpose: function to initialize property and invoke sendTrigger ajax function.
        function InitTrigger() {
            var obj = new TriggerProperty();
            obj.OCTriggers = GetCheckboxValues('chkTriggers');
            obj.getRefToADRCIDs = GetCheckboxValues('chkList');
            obj.ReferredToServiceProvider = GetCheckboxValues('chkReferredtoServiceProvider');

            obj.InsuranceTypes = GetCheckboxValues('ddlInsuranceTypes');
            sendTrigger(obj);
        }
        //Created by SA. SOW-335. Purpose: send triggers back to DB
        //Modify by vk on 07 oct,2021.Alert actual erromessage (Ticket-6368).
        function sendTrigger(data) {

            $.ajax({
                type: "POST",
                url: "NeedyPerson.aspx/getMultiSelectionValues",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{MultiValues:" + JSON.stringify(data) + "}",
                async: false,
                success: function (data) {

                },
                error: function (xhr, errorType, exception) {
                    var responseText;
                    var erromessage;
                    try {
                        responseText = jQuery.parseJSON(xhr.responseText);
                        erromessage = "" + errorType + " " + exception + "" + "Exception :" + responseText.ExceptionType + "Message:" + responseText.Message;
                        alert(erromessage);
                    }
                    catch (e) {
                    }
                }
            });
        }

        //Created by SA. SOW-335. Purpose: Property to send REferral Details for mailing purpose ... 17-12-2014
        var NeedyPersonName;
        // var DOB;
        var Gender;
        //var ReferredBy;
        var ReferredTo;
        function REfEmailProperty() {
            this.NeedyPersonName = NeedyPersonName;
            //this.DOB = DOB;
            this.Gender = Gender;
            //this.ReferredBy = ReferredBy;
            this.ReferredTo = ReferredTo;
        }
        //Created by SA. SOW-335. Purpose: function to initialize property and invoke sendRefEmailDetails ajax function...17-12-2014
        function InitRefEmail() {
            var obj = new REfEmailProperty();

            obj.NeedyPersonName = $('#<%=txtNFName.ClientID %>').val() + ' ' + $('#<%=txtNMi.ClientID %>').val() + ' ' + $('#<%=txtNLName.ClientID %>').val();

            //obj.DOB = $("#<%=txtNDOB.ClientID%>").val();//Commented on 14th April, 2015. Task ID-2959 - Removed DOB from mail.
            var gender = $('#<%=ddlGender.ClientID %> option:selected').text();
            obj.Gender = (gender == "--Select--") ? "" : gender;
            //var refBy = $('#<%=ddlRefBy.ClientID %> option:selected').text();//Commented on 14th April, 2015. Task ID-2959 - Managed from Session.
            //obj.ReferredBy = (refBy == "--Select--")? "":refBy;
            obj.ReferredTo = getSelectedText('chkList');
            if (obj.ReferredTo == "") {

                alert('Please select ADRC Partners to refer.');
                return false;
            }
            sendRefEmailDetails(obj);
        }
        //Created by SA. SOW-335. Purpose: send REferral Details for mailing purpose...17-12-2014
        //Modify by vk on 07 oct,2021.Alert actual erromessage (Ticket-6368).
        function sendRefEmailDetails(data) {

            $.ajax({
                type: "POST",
                url: "SendRefEmail.aspx/getRefEmailDetails",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{referredEmail:" + JSON.stringify(data) + "}",
                async: false,
                success: function (data) {
                    OpenRefEmailPopup();

                },
                error: function (xhr, errorType, exception) {
                    var responseText;
                    var erromessage;
                    try {
                        responseText = jQuery.parseJSON(xhr.responseText);
                        erromessage = "" + errorType + " " + exception + "" + "Exception :" + responseText.ExceptionType + "Message:" + responseText.Message;
                        alert(erromessage);
                    }
                    catch (e) {
                    }
                }
            });
        }



        //Created by SA. SOW-335. Purpose: get checked those saved in DB by user.
        function bindChkDropdowns(id, Values) {//ids==> chkList & chkTriggers && Values==> comma separated values to be passed here as variable from code behind.

            var items = Values;
            $('input[name=multiselect_' + id + ']').each(function (index) {
                var split = items.split(',');
                for (var i = 0; i < split.length; ++i) {
                    if (split[i] == $(this).val()) {
                        $(this).prop('checked', true);
                        $("label[for='" + $(this).attr("id") + "']").removeClass('ui-corner-all)').addClass('Highlight_Server');
                    }
                }
                //if (items.indexOf($(this).val()) != -1) {

                //    $(this).prop('checked', true);
                //    $("label[for='" + $(this).attr("id") + "']").removeClass('ui-corner-all)').addClass('Highlight_Server');
                //}
            });
        }

        //Created by SA. SOW-335. Purpose: get checked values comma separated.
        function GetCheckboxValues(chkName) {// chkList & chlTriggers

            var chkValues = $('input[name=multiselect_' + chkName + ']:checked').map(function () { return $(this).val(); }).get().join(',');
            return chkValues;
        }

        //Created by SA. SOW-335. Purpose: get checked Text comma separated.
        function getSelectedText(chkName) {// chkList & chlTriggers

            var chkValues = $('input[name=multiselect_' + chkName + ']:checked').map(function () { return $(this).next().html(); }).get().join(', ');

            return chkValues;
        }

        function GetCheckboxText(id) {//id==> chkTriggers & chkList

            var chkValues = $('input[name=multiselect_' + id + ']:checked').map(function () { return $(this).next().html(); }).get().join(',');
            var len = $('input[name=multiselect_' + id + ']:checked').length;

            $('input[name=multiselect_' + id + ']').change(function () {

                if ($(this).is(":checked")) {
                    if (!$("label[for='" + $(this).attr("id") + "']").hasClass('Highlight_Server'))
                        $("label[for='" + $(this).attr("id") + "']").removeClass('ui-corner-all').addClass('Highlight_Client');
                }
                else
                    $("label[for='" + $(this).attr("id") + "']").addClass('ui-corner-all').removeClass('Highlight_Client');
            });

            chkValues = (chkValues == "") ? "Select options" : len + " selected";
            return chkValues;
        }
    </script>
    <script language="javascript" type="text/javascript">
        //Created by SA on 3-11-2014. SOW-335
        //Purpose: To show/hide on selection of Disability.
        // Confirmation alert for Grid Delete link.
        function ConfirmOnDelete() {
            if (confirm("Are you sure you want to delete this record?")) {
                ShowLoader();
                return true;
            }
            else
                return false;
        }


        $(document).ready(function () {
            // DisabilityCheck();
            DisableEnterKeyOnInput();
            CheckUnknown();
            CheckNo();
            CheckYes();
            ShowOther();
        });



        function ShowOther() {

            //Created by SA. SOW-335. Purpose: In case of Other selection. Show/hide textbox
            $('#<%=ddlDisabilityTypes.ClientID %>').change(function () {
                $("#<%= txtOtherDisability.ClientID%>").hide();
                if ($('#<%=ddlDisabilityTypes.ClientID %> option:selected').text() == "Other") {
                    $("#<%= txtOtherDisability.ClientID%>").show();
                }

            });
            //Created by SA. SOW-335. Purpose: In case of Other selection. Show/hide textbox
            $('input[name=multiselect_ddlInsuranceTypes]').change(function () {
                $("#<%= txtInsuranceOther.ClientID%>").hide();
                if ($('input[name=multiselect_ddlInsuranceTypes]:checked').next().html() == "Other") {
                    $("#<%= txtInsuranceOther.ClientID%>").show();
                }

            });

        }

        //Created by SA. SOW-335. Purpose: Validating Other selection.
        function OtherDisabilityCheck() {
            if ($('#<%=ddlDisabilityTypes.ClientID %> option:selected').text() == "Other") {
                if ($("#<%= txtOtherDisability.ClientID%>").val() == "") {

                    alert("Please enter other disability type.");
                    return false;
                }

            }
            return true;
        }
        //Created by SA. SOW-335. Purpose: Validating Other Insurance.
        function OtherInsuranceCheck() {
            <%--if ($('input[name=multiselect_ddlInsuranceTypes]:checked').next().html() == "Other") {
                if ($("#<%= txtInsuranceOther.ClientID%>").val() == "") {

                    alert("Please enter other insurance type.");
                    return false;
                } --%>       
            if ($(this).is(":checked")) {

                if ($(this).next().html() == ' Other') {

                    $("#<%= txtInsuranceOther.ClientID%>").show();
                    if ($("#<%= txtInsuranceOther.ClientID%>").val() == "") {

                        alert("Please enter other insurance type.");
                        $("#<%= txtInsuranceOther.ClientID%>").focus();
                        return false;
                    }
                }
            }


            //}
            return true;
        }

        function CheckYes() {

            var DisabilityYes = document.getElementById("<%=chkDisabilityYes.ClientID%>");
            var DisabilityNo = document.getElementById("<%=chkDisabilityNo.ClientID%>");
            var DisabilityUnknown = document.getElementById("<%=chkDisabilityUnknown.ClientID%>");
            if (DisabilityYes.checked == true) {
                <%--document.getElementById('<%=trDisabilityTypes.ClientID%>').style.visibility = 'visible';--%>

                document.getElementById('<%=ddlDisabilityTypes.ClientID%>').disabled = false;
                DisabilityNo.checked = false;
                DisabilityUnknown.checked = false;
            }
            else {
                <%--document.getElementById('<%=trDisabilityTypes.ClientID%>').style.visibility = 'hidden';--%>
                $('#<%=ddlDisabilityTypes.ClientID %>').val('-1');
                document.getElementById('<%=ddlDisabilityTypes.ClientID%>').disabled = true;
                document.getElementById('<%=txtOtherDisability.ClientID%>').style.display = 'none';
                document.getElementById('<%=txtOtherDisability.ClientID%>').value = '';
            }
        }
        function CheckNo() {

            var DisabilityYes = document.getElementById("<%=chkDisabilityYes.ClientID%>");
            var DisabilityNo = document.getElementById("<%=chkDisabilityNo.ClientID%>");
            var DisabilityUnknown = document.getElementById("<%=chkDisabilityUnknown.ClientID%>");
            if (DisabilityNo.checked == true) {
                <%--document.getElementById('<%=trDisabilityTypes.ClientID%>').style.visibility = 'hidden';--%>
                $('#<%=ddlDisabilityTypes.ClientID %> ').val('-1');
                document.getElementById('<%=ddlDisabilityTypes.ClientID%>').disabled = true;
                document.getElementById('<%=txtOtherDisability.ClientID%>').style.display = 'none';
                document.getElementById('<%=txtOtherDisability.ClientID%>').value = '';
                DisabilityYes.checked = false;
                DisabilityUnknown.checked = false;
            }
        }
        function CheckUnknown() {

            var DisabilityYes = document.getElementById("<%=chkDisabilityYes.ClientID%>");
            var DisabilityNo = document.getElementById("<%=chkDisabilityNo.ClientID%>");
            var DisabilityUnknown = document.getElementById("<%=chkDisabilityUnknown.ClientID%>");
            if (DisabilityUnknown.checked == true) {
                <%--document.getElementById('<%=trDisabilityTypes.ClientID%>').style.visibility = 'hidden';--%>
                $('#<%=ddlDisabilityTypes.ClientID %> ').val('-1');
                document.getElementById('<%=ddlDisabilityTypes.ClientID%>').disabled = true;
                document.getElementById('<%=txtOtherDisability.ClientID%>').style.display = 'none';
                document.getElementById('<%=txtOtherDisability.ClientID%>').value = '';
                DisabilityYes.checked = false;
                DisabilityNo.checked = false;
            }
        }

        function DisabilityCheck() {

            var DisabilityYes = document.getElementById("<%=chkDisabilityYes.ClientID%>");//$("#<%=chkDisabilityYes.ClientID%>").is(":checked");
            var DisabilityNo = document.getElementById("<%=chkDisabilityNo.ClientID%>");
            var DisabilityUnknown = document.getElementById("<%=chkDisabilityUnknown.ClientID%>");


            if (DisabilityYes.checked == true) {
                document.getElementById('<%=trDisabilityTypes.ClientID%>').style.visibility = 'visible';
                DisabilityNo.checked = false;
                DisabilityUnknown.checked = false;
            }
            if (DisabilityNo.checked == true) {
                document.getElementById('<%=trDisabilityTypes.ClientID%>').style.visibility = 'hidden';
                DisabilityYes.checked = false;
                DisabilityUnknown.checked = false;
            }
            if (DisabilityUnknown.checked == true) {
                document.getElementById('<%=trDisabilityTypes.ClientID%>').style.visibility = 'hidden';
                DisabilityYes.checked = false;
                DisabilityNo.checked = false;
            }



        }

        function BindRelationshipLabel(ctrlId) {

            if (ctrlId != null) {
                if (ctrlId.selectedIndex != -1) {
                    var ddlvalue = ctrlId.options[ctrlId.selectedIndex].value;
                    var ddltext = ctrlId.options[ctrlId.selectedIndex].text;

                    var myString = document.getElementById('<%= this.hdnRelationshipValue.ClientID %>').value;
                    var lblRelationship = document.getElementById('<%= this.lblRelationship.ClientID %>');
                    if (lblRelationship != null)
                        lblRelationship.innerHTML = '';

                    var mySplitResult = myString.split("|");

                    for (i = 0; i < mySplitResult.length; i++) {
                        var SplitCommaResult = mySplitResult[i].split(",");

                        for (j = 0; j < SplitCommaResult.length; j++) {
                            if (ddlvalue == SplitCommaResult[j]) {
                                $('#<%=ddlContactPerson.ClientID %>').css('display', 'inline');
                                lblRelationship.innerHTML = SplitCommaResult[j + 1];// set relationship value in label
                                $('#<%=lblRelationLabel.ClientID %>').css('display', 'inline');
                                $('#<%=lblRelationship.ClientID %>').css('display', 'inline');
                                break;
                            }

                        } //inner for loop

                    }//outer for loop

                } // close of ctrlId.selectedIndex

            }// ctrlId
        } // main function

        // window.onbeforeunload = closeIt;

        var needyFName;
        var needyLName;

        /* Created By: Santosh Maurya
             Purpose: Clear masked of phone format */

        function ClearPhoneFormatLoad() {

            var frm = document.forms[0];
            for (i = 0; i < frm.elements.length; i++) {
                if (frm.elements[i].type == "text") {
                    if (frm.elements[i].value == '(___)___-____')
                        frm.elements[i].value = '';
                }
            }
        }
        /*
        Call some common method after DOM load
        */
        $(document).ready(function () {            
            try {
                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(BindCPCityCounty);
            }
            catch (err) { }
            try {
                BindCPCityCounty();
            }
            catch (err) { }
            try {
                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(BindNDCityCounty);
            }
            catch (err) { }
            try {
                BindNDCityCounty();
            }
            catch (err) { }
            
            try {
                /* Validation of Alpha Restriction  County and City
                   Created by SA on 29th Aug, 2014. 
                 */

                InputValidation($('#<%= cmbNCounty.ClientID %>_cmbNCounty_TextBox'));
                InputValidation($('#<%= cmbNCity.ClientID %>_cmbNCity_TextBox'));
                InputValidation($('#<%= cmbCCounty.ClientID %>_cmbCCounty_TextBox'));
                InputValidation($('#<%= cmbCCity.ClientID %>_cmbCCity_TextBox'));//cmbPrimaryLaguage
                InputValidation($('#<%= cmbPrimaryLaguage.ClientID %>_cmbPrimaryLaguage_TextBox'));
            }
            catch (err) { }
            try {
                NumericRestriction($('#<%= txtCZip.ClientID %>'));
                NumericRestriction($('#<%= txtNZip.ClientID %>'));
                NumericRestriction($('#<%= txtAssetAmount.ClientID %>'));
                NumericRestriction($('#<%= txtTotalHouseholdIncome.ClientID %>'));
                NumericRestriction($('#<%= txtSpouse.ClientID %>'));
                NumericRestriction($('#<%= txtClient.ClientID %>'));

            }
            catch (err) { }
            try {
                CommaFormatted(document.getElementById('<%= txtAssetAmount.ClientID %>'), null);
                CommaFormatted(document.getElementById('<%= txtTotalHouseholdIncome.ClientID %>'), null);
                CommaFormatted(document.getElementById('<%= txtSpouse.ClientID %>'), null);
                CommaFormatted(document.getElementById('<%= txtClient.ClientID %>'), null);
            } catch (err) { }


            //-----------------------------------------------------------------------------------------------------------------



            // Hold original needy person Name in  varible to check name has been changed or not before saving
            needyFName = $.trim($('#<%=txtNFName.ClientID %>').val()).toUpperCase();
            needyLName = $.trim($('#<%=txtNLName.ClientID %>').val()).toUpperCase();

            try {

                //Added by KP on 28th Feb 2020(SOW-577), Do not show the call duration, when time is manualy saved in DB.
                var IsManualCallDuration = '<%= Session["IsManualCallDuration"]%>';
                if (IsManualCallDuration.toUpperCase() == 'TRUE') {
                    $('#<%=HidIsTimerPause.ClientID %>').val('true');
                }
                else
                    startCalldurationClock();
            }
            catch (err) { }
            try {
                // jquery table sorter 
                $("#grdContactDetails").tablesorter({
                    headers:
                    {
                        0: { sorter: false },
                        5: { sorter: false },
                        6: { sorter: false },
                        7: { sorter: false },
                        8: { sorter: false },
                        sortList: [[1, 1]]
                    }
                });
            }
            catch (err) { }

            try {
                DisplayName();
            } catch (err) { }
            try {
                ActiveTab();
            } catch (err) { }
            try {
                BindCallHistory();
            } catch (err) { }




            //         $("#gridHistory").tablesorter({
            //                headers:
            //                         {
            //                             4: { sorter: false },
            //                             5: { sorter: false },
            //                              sortList: [[1, 1]]
            //                         }
            //                }); 

            try {
                $('#chkIsPrimaryContactPesron').change(function () {
                    CheckPPerson();

                });// End of Document Load

            }
            catch (err) { }


            $('#MainContent_cmbCCounty_cmbCCounty_OptionList').find('li').click(function () {
                $('#MainContent_cmbCCounty_cmbCCounty_OptionList').hide();

            });
            $('#MainContent_cmbCCity_cmbCCity_OptionList').find('li').click(function () {
                $('#MainContent_cmbCCity_cmbCCity_OptionList').hide();

            });

            $('#MainContent_NeedyPersonTab_tabPersonInfo_cmbPrimaryLaguage_cmbPrimaryLaguage_OptionList').find('li').click(function () {
                $('#MainContent_NeedyPersonTab_tabPersonInfo_cmbPrimaryLaguage_cmbPrimaryLaguage_OptionList').hide();

            });

            $('#MainContent_NeedyPersonTab_tabPersonInfo_cmbNCounty_cmbNCounty_OptionList').find('li').click(function () {
                $('#MainContent_NeedyPersonTab_tabPersonInfo_cmbNCounty_cmbNCounty_OptionList').hide();
            });

            $('#MainContent_NeedyPersonTab_tabPersonInfo_cmbNCity_cmbNCity_OptionList').find('li').click(function () {
                $('#MainContent_NeedyPersonTab_tabPersonInfo_cmbNCity_cmbNCity_OptionList').hide();

            });

            //Added by AV on 19 Feb 2024
            //Purpose- Check duplicate needy on blur of FirstName and LastName textfield            
            $('#<%= txtNFName.ClientID %>').blur((event) => {
                if (!CheckDuplicateNeedy()) {
                    let msg = 'A Person Needing Assistance with the name [' + $('#<%=txtNFName.ClientID %>').val() + ', ' + $('#<%=txtNLName.ClientID %>').val() + '] already exists. Would you like to proceed with creating a new one?';
                    ElementToFocus = $('#<%= txtNFName.ClientID %>');
                    ShowConfirmationBox(3, msg);
                }
            });
            $('#<%= txtNLName.ClientID %>').blur((event) => {
                if (!CheckDuplicateNeedy()) {
                    let msg = 'A Person Needing Assistance with the name [' + $('#<%=txtNFName.ClientID %>').val() + ', ' + $('#<%=txtNLName.ClientID %>').val() + '] already exists. Would you like to proceed with creating a new one?';
                    ElementToFocus = $('#<%= txtNLName.ClientID %>');
                    ShowConfirmationBox(3, msg);
                }
            });
            //end
        });
        var ElementToFocus = '';

        // allow user to enter numeric  - SA 
        function NumericRestriction(obj) {
            obj.bind("paste", function (e) { e.preventDefault(); });

            obj.keydown(function (e) {

                if (e.ctrlKey || e.altKey || (e.shiftKey && !((key >= 96 && key <= 105) || (key >= 48 && key <= 57) || (key == 8) || (key == 9) || (key == 46) || (key >= 35 && key <= 40)))) {
                    e.preventDefault();
                } else {

                    var key = e.keyCode != null ? e.keyCode : e.which;

                    if (!((key >= 96 && key <= 105) || (key >= 48 && key <= 57) || (key == 8) || (key == 9) || (key == 46) || (key >= 35 && key <= 40))) {
                        e.preventDefault();
                    }
                }
            });
        }

        // Restict user to enter numeric or special charecter 

        function InputValidation(obj) {
            obj.bind("paste", function (e) { e.preventDefault(); });


            obj.keydown(function (e) {

                if (e.ctrlKey || e.altKey) {
                    e.preventDefault();
                } else {

                    var key = e.keyCode != null ? e.keyCode : e.which;
                    if (!((key == 8) || (key == 9) || (key == 32) || (key == 46) || (key >= 35 && key <= 40) || (key >= 65 && key <= 90))) {
                        e.preventDefault();
                    }
                }
            });
        }

        // this method is called when postback occurs
        function InputValidationPostback() {
            InputValidation($('#<%= cmbCCounty.ClientID %>_cmbCCounty_TextBox'));
            InputValidation($('#<%= cmbCCity.ClientID %>_cmbCCity_TextBox'));
        }

        // Following global variables and function is used for timeout counter
        //var IsStop = false;       
        var intCallDurTimerLimit = 0;
        //var intCallDurMinutLimit = 0;
        var intCallDurTimerStep = 1;
        var CallDurMinutes;
        var CallDurHours = 0;
        var CallDuSseconds;
        //Timer clock function
        function startCalldurationClock() {
            var timerlmt = document.getElementById('<%=hdnTimerLimit.ClientID %>').value;
            if (timerlmt != '')
                intCallDurTimerLimit = parseInt(timerlmt);

            intCallDurTimerLimit = parseInt(intCallDurTimerLimit) + parseInt(intCallDurTimerStep);
            CallDurHours = Math.floor(intCallDurTimerLimit / 3600);
            CallDurMinutes = Math.floor((intCallDurTimerLimit - (CallDurHours * 3600)) / 60);
            CallDurSeconds = intCallDurTimerLimit - (CallDurHours * 3600) - (CallDurMinutes * 60);

            if (CallDurSeconds < 10) CallDurSeconds = new String('0' + CallDurSeconds);
            if (CallDurMinutes < 10) CallDurMinutes = new String('0' + CallDurMinutes);
            if (CallDurHours < 10) CallDurHours = new String('0' + CallDurHours);

            document.getElementById('<%=hdnTimerLimit.ClientID %>').value = intCallDurTimerLimit;

            //Added by KP on 28th Feb 2020(SOW-577)
            if ($('#<%=HidIsTimerPause.ClientID %>').val() == "true") //If timer is in pause mode then internallly hold the timer in hidden field.          
                $('#<%=HidHoldDuration.ClientID %>').val(new String(CallDurHours + ':' + CallDurMinutes + ':' + CallDurSeconds));
            else //If timer is not in pause mode then display timer.
                document.getElementById('<%=txtCallDuration.ClientID %>').value = new String(CallDurHours + ':' + CallDurMinutes + ':' + CallDurSeconds);
            //(SOW - 577)

            if (intCallDurTimerLimit > 0)
                setTimeout("startCalldurationClock()", 1000);

        }
        /*
            Created By: SM
            Date:04/08/2013
            Purpose:stop clock on click on textbox
        */
        function StopClock() {
            //debugger;
            //IsStop = true;
            //HidIsTimerPause = false;
            //HidHoldDuration = '';
            //PauseClock(true);
        }

        //Added by KP on 28th Feb 2020(SOW-577), Pause the timer and focus on call duration field. 
        function PauseClock() {
            //debugger;
            $('#<%=HidIsTimerPause.ClientID %>').val('true');
            document.getElementById('<%=txtCallDuration.ClientID %>').value = "";

            setTimeout(function () {
                document.getElementById('<%=txtCallDuration.ClientID %>').focus();
            }, 500);

        }

        //Added by KP on 28th Feb 2020(SOW-577), Restore timer, whenever call duration field is blank
        function RestoreClock() {
            //debugger;           
            var IsManualCallDuration = '<%= Session["IsManualCallDuration"]%>'.toUpperCase();
            var txtCallDuration = document.getElementById('<%=txtCallDuration.ClientID %>');
            var HidHoldDuration = $('#<%=HidHoldDuration.ClientID %>');
            var HidIsTimerPause = $('#<%=HidIsTimerPause.ClientID %>');

            if (txtCallDuration.value == '__:__:__' || txtCallDuration.value == '') {

                setTimeout(function () {
                    txtCallDuration.value = HidHoldDuration.val();
                }, 500);

                if (IsManualCallDuration == '' || IsManualCallDuration == 'FALSE') {
                    HidIsTimerPause.val('false');
                    HidHoldDuration.val('');
                    document.getElementById('<%=HidIsManualCallDuration.ClientID %>').value = '0';
                }
            }

            if (HidIsTimerPause.val() == 'true' || IsManualCallDuration == 'TRUE')
                document.getElementById('<%=HidIsManualCallDuration.ClientID %>').value = '1';

        }

        function checkDate(sender, args) {
            document.getElementById('<%= hdnIsAgeOn.ClientID%>').value = 0;
            if (sender._selectedDate > new Date()) {
                //show the alert message
                alert("Date of Birth of person needing assistance can not be future date.");
                document.getElementById('<%=txtNDOB.ClientID %>').value = '';
                document.getElementById('<%=txtNDOB.ClientID %>').focus();
            }
            ageCount();
        }
        function DisableAgeOrDOBControl(ControlName) {
            document.getElementById('<%=txtNDOB.ClientID %>').disabled = false;
            document.getElementById('<%= txtNAge.ClientID%>').disabled = false;
            document.getElementById('<%= hdnIsAgeOn.ClientID%>').value = 0;
            if (ControlName == 'AGE') {
                if (document.getElementById('<%= txtNAge.ClientID%>').value.trim().length > 0) {
                    document.getElementById('<%=txtNDOB.ClientID %>').value = "";
                    document.getElementById('<%=txtNDOB.ClientID %>').disabled = true;
                    document.getElementById('<%= hdnIsAgeOn.ClientID%>').value = 1;
                    if (parseInt(document.getElementById('<%= txtNAge.ClientID%>').value) > 255) {
                        alert("Age of person needing assistance can not be greater than 255.")
                        document.getElementById('<%= txtNAge.ClientID%>').value = '';
                        document.getElementById('<%= hdnIsAgeOn.ClientID%>').value = 0;
                        document.getElementById('<%=txtNDOB.ClientID %>').disabled = false;
                        document.getElementById('<%=txtNAge.ClientID %>').focus();
                        return false;
                    }
                }
            }
            else {
                var birth = document.getElementById('<%=txtNDOB.ClientID %>').value;
                var today = new Date();
                var nowyear = today.getFullYear();
                var nowmonth = today.getMonth() + 1;
                var nowday = today.getDate();
                var pattern = /^\d{1,2}\/\d{1,2}\/\d{4}$/; //Regex to validate date format (mm/dd/yyyy)  
                if (pattern.test(document.getElementById('<%=txtNDOB.ClientID %>').value)) {
                    if (!ValidateDate(document.getElementById('<%=txtNDOB.ClientID %>').id)) {
                        document.getElementById('<%=txtNDOB.ClientID %>').value = '';
                        document.getElementById('<%=txtNDOB.ClientID %>').focus();
                        document.getElementById('<%= txtNAge.ClientID%>').disabled = false;
                        document.getElementById('<%= txtNAge.ClientID%>').value = '';
                        return false;
                    } else {
                        if ((birth != "__/__/____" || birth != "") && pattern.test(birth)) {
                            var sDOBDate = new Date(birth);
                            if (sDOBDate > new Date()) {
                                //show the alert message
                                alert("Date of Birth of person needing assistance can not be future date.");
                                document.getElementById('<%=txtNDOB.ClientID %>').value = '';
                                document.getElementById('<%=txtNDOB.ClientID %>').focus();
                                return false;
                                //document.getElementById('<%=txtNDOB.ClientID %>').value = nowmonth + '/' + nowday + '/' + nowyear;
                            }
                            else {
                                document.getElementById('<%= txtNAge.ClientID%>').value = '';
                                var date2 = new Date(birth);
                                var birthyear = date2.getFullYear();
                                var birthmonth = date2.getMonth() + 1;
                                var birthday = date2.getDate();

                                var age = nowyear - birthyear;
                                var age_month = nowmonth - birthmonth;
                                var age_day = nowday - birthday;

                                if (age_month < 0 || (age_month == 0 && age_day < 0)) {
                                    age = parseInt(age) - 1;
                                }
                                if (age < 0)// if age count is -ve
                                    age = 0;
                                if (age >= 0) {
                                    document.getElementById('<%=txtNAge.ClientID%>').value = age;
                                    document.getElementById('<%=txtNAge.ClientID%>').disabled = true;
                                }
                                return true;
                            }

                        }
                    }
                }
                else {
                    document.getElementById('<%=txtNDOB.ClientID %>').focus();
                    document.getElementById('<%= txtNAge.ClientID%>').value = '';
                    document.getElementById('<%= txtNAge.ClientID%>').disabled = false;
                    //alert("Invalid date format. Please Input in (dd/mm/yyyy) format!");
                    return false;
                }
            }
        }
        function DateFormate() {
            var birth = document.getElementById('<%=txtNDOB.ClientID %>').value;
            var pattern = /^\d{1,2}\/\d{1,2}\/\d{4}$/; //Regex to validate date format (mm/dd/yyyy)  
            if (!pattern.test(birth) && birth.length > 0 && birth != "__/__/____") {
                document.getElementById('<%=txtNAge.ClientID%>').value = '';
                document.getElementById('<%=txtNAge.ClientID%>').disabled = false;
                alert("Invalid date format. Please Input in (mm/dd/yyyy) format!");
                setTimeout(function () {
                    document.getElementById('<%=txtNDOB.ClientID%>').value = '';
                    document.getElementById('<%=txtNDOB.ClientID %>').focus();
                }, 300);
                return false;
            }
        }
        function validateAge() {
            if (parseInt(document.getElementById('<%= txtNAge.ClientID%>').value) > 255 && document.getElementById('<%= txtNAge.ClientID%>').value.length > 0) {
                alert("Age of person needing assistance can not be greater than 255.")
                return false;
            }
        }
        /*
            Modifeid By: SM
            Date:03/08/2014
            Purpose:Calculate age based on date
        */
        function ageCount() {
            var birth = document.getElementById('<%=txtNDOB.ClientID %>').value;
            if (birth.length > 0 && birth != "__/__/____") {
                var today = new Date();
                var nowyear = today.getFullYear();
                var nowmonth = today.getMonth() + 1;
                var nowday = today.getDate();
                var pattern = /^\d{1,2}\/\d{1,2}\/\d{4}$/; //Regex to validate date format (mm/dd/yyyy)  
                if (!pattern.test(document.getElementById('<%=txtNDOB.ClientID %>').value)) {
                    document.getElementById('<%=txtNAge.ClientID%>').value = "";
                    document.getElementById('<%=txtNAge.ClientID%>').disabled = false;
                    alert("Invalid date format. Please Input in (mm/dd/yyyy) format!");
                    setTimeout(function () {
                        document.getElementById('<%=txtNDOB.ClientID%>').value = "";
                        document.getElementById('<%=txtNDOB.ClientID %>').focus();
                    }, 200);
                    return false;
                }
                else if (pattern.test(birth)) {
                    var sDOBDate = new Date(birth);
                    if (sDOBDate > new Date()) {
                        //show the alert message
                        alert("Date of Birth of person needing assistance can not be future date.");
                        document.getElementById('<%=txtNDOB.ClientID %>').value = '';
                        document.getElementById('<%=txtNDOB.ClientID %>').focus();
                        return false;
                    }
                    else {
                        document.getElementById('<%= txtNAge.ClientID%>').value = '';
                        var date2 = new Date(birth);
                        var birthyear = date2.getFullYear();
                        var birthmonth = date2.getMonth() + 1;
                        var birthday = date2.getDate();

                        var age = nowyear - birthyear;
                        var age_month = nowmonth - birthmonth;
                        var age_day = nowday - birthday;

                        if (age_month < 0 || (age_month == 0 && age_day < 0)) {
                            age = parseInt(age) - 1;
                        }
                        if (age < 0)// if age count is -ve
                            age = 0;
                        if (age >= 0) {
                            document.getElementById('<%= txtNAge.ClientID%>').value = age;
                            document.getElementById('<%= txtNAge.ClientID%>').disabled = true;
                        }
                        return true;
                    }
                }
            }
        }
        //added by SA on 12th June. 2015. Reset other options with checkbox
        function ResetOtherOptions(chkid, txtOther) {
            document.getElementById(txtOther).value = "";
            document.getElementById(txtOther).style.display = "none";
            document.getElementById(chkid).checked = false;
        }
        /*
            Created By: Santosh Maurya
            Date:03/11/2013
            Purpose:Close add contact popup on click of Cancel and Close button
        */
        function showHide() {
            //debugger;
            ResetOtherOptions('MainContent_ChkContactPreferenceInPersonOther', 'MainContent_txtContactPreferenceInPersonOther');//added by SA on 12th June. 2015. Reset other options with checkbox
            var divpnlContact = document.getElementById("<%=divpnlContact.ClientID %>");
            var rwContactSave = document.getElementById("<%=rwContactSave.ClientID %>");
            var showHideDiv = document.getElementById("<%=showHideDiv.ClientID %>");
            var divPopUpContent = document.getElementById("<%=divPopUpContent.ClientID %>");
            var divpopupHeading = document.getElementById("<%=divpopupHeading.ClientID %>"); // document.getElementById("divpopupHeading");
            var btnClose = document.getElementById("<%=btnClose.ClientID %>"); document.getElementById("btnClose");
            document.getElementById("<%=txtCFax.ClientID %>").value = ""; //Added by:BS on 19-dec-2016
            divpnlContact.style.width = "98.5%";//Added by BS on 27-sep-2016 
            divpopupHeading.style.width = "99%";//Added by BS on 27-sep-2016 
            document.getElementById('<%=hdnAddcontact.ClientID %>').value = "True";
            //divpnlContact.style.display = "none";// Added to display Contact Panel before showing popup SOW-335. SA - 27th Jan, 2015
            if (divpnlContact.style.display == "block") {
                //document.getElementById('MainContent_hdnAddcontact').value = "False";
                showHideDiv.className = "";
                divPopUpContent.className = "";

                divpnlContact.style.display = "none";
                rwContactSave.style.display = "none";

                btnClose.style.display = "none";
                divpopupHeading.style.display = "none";
                //make blank contorl value
                document.getElementById("<%=txtCFirstName.ClientID %>").value = "";
                document.getElementById("<%=txtCMI.ClientID %>").value = "";
                document.getElementById("<%=txtCLastName.ClientID %>").value = "";
                document.getElementById("<%=txtCPhonePrimary.ClientID %>").value = "";
                document.getElementById("<%=txtCPhoneAlt.ClientID %>").value = "";
                document.getElementById("<%=txtCEmail.ClientID %>").value = "";
                document.getElementById("<%=txtCAddress.ClientID %>").value = "";
                document.getElementById("<%=txtCState.ClientID %>").value = "MI";
                document.getElementById("<%=txtCZip.ClientID %>").value = "";

                document.getElementById("<%=chkCPhone.ClientID %>").checked = false;
                document.getElementById("<%=chkCEmail.ClientID %>").checked = false;
                document.getElementById("<%=ChkCSMS.ClientID %>").checked = false;
                document.getElementById("<%=ChkCMail.ClientID %>").checked = false;
                document.getElementById("<%=chkIsPrimaryContactPesron.ClientID %>").checked = false;

                var combo = $find('<%= cmbCCity.ClientID %>');
                combo.get_textBoxControl().value = "--Select--";
                var combo = $find('<%= cmbCCounty.ClientID %>');
                combo.get_textBoxControl().value = "--Select--";

                document.getElementById("<%=txtRelationship.ClientID %>").value = "";

                //Added by:BS on 14-sep-2016
                document.getElementById("<%=txtcPhonePrimaryExtn.ClientID %>").value = "";
                document.getElementById("<%=txtCPhoneAltExtn.ClientID %>").value = "";
                document.getElementById("<%=txtcPhonePrimaryExtn.ClientID %>").style.backgroundColor = "white";
                document.getElementById("<%=txtcPhonePrimaryExtn.ClientID %>").style.border = "1px solid #707070";
                document.getElementById("<%=txtCPhoneAltExtn.ClientID %>").style.backgroundColor = "white";
                document.getElementById("<%=txtCPhoneAltExtn.ClientID %>").style.border = "1px solid #707070";

                document.getElementById("<%=txtCFax.ClientID %>").value = ""; //Added by:BS on 19-dec-2016


            }
            else {
                showHideDiv.className = "main_popup";
                divPopUpContent.className = "popup";
                divpnlContact.style.display = "block";
                rwContactSave.style.display = "block";

                divpopupHeading.style.display = "block";
                btnClose.style.display = "block";

                var combo = $find('<%= cmbCCity.ClientID %>');
                combo.get_textBoxControl().value = "--Select--";
                var combo = $find('<%= cmbCCounty.ClientID %>');
                combo.get_textBoxControl().value = "--Select--";

                InputValidationPostback();
            }
        }
        function CommaNumbers(obj) {
            var isValid = false;
            var regex = /^[0-9 ,]*$/;
            isValid = regex.test(obj.val());

            return isValid;
        }
        /*
            Created by SA on 1st Sep, 2014.
            Purpose: Validation of only Alpha for county and city just for mozilla 20.
        */

        function Validate(obj) {
            var isValid = false;
            var regex = /^[a-zA-Z -]*$/;
            isValid = regex.test(obj.val());

            return isValid;
        }
        function MozillaValidation() {//cmbPrimaryLaguage


            var countyAlert = "Only alphabets are allowed in the county.";
            var cityAlert = "Only alphabets are allowed in the city.";
            var IsValid = true;

            IsValid = Validate($('#<%= cmbPrimaryLaguage.ClientID %>_cmbPrimaryLaguage_TextBox'));
            if (IsValid == false) {
                alert("Only alphabets are allowed in the primary language.");
                document.getElementById('<%= cmbPrimaryLaguage.ClientID %>_cmbPrimaryLaguage_TextBox').value = "";
                document.getElementById('<%= cmbPrimaryLaguage.ClientID %>_cmbPrimaryLaguage_TextBox').focus();
                return false;
            }

            IsValid = Validate($('#<%= cmbNCounty.ClientID %>_cmbNCounty_TextBox'));
            if (IsValid == false) {
                alert(countyAlert);
                document.getElementById('<%= cmbNCounty.ClientID %>_cmbNCounty_TextBox').value = "";
                document.getElementById('<%= cmbNCounty.ClientID %>_cmbNCounty_TextBox').focus();
                return false;
            }

            IsValid = Validate($('#<%= cmbNCity.ClientID %>_cmbNCity_TextBox'));
            if (IsValid == false) {
                alert(cityAlert);
                document.getElementById('<%= cmbNCity.ClientID %>_cmbNCity_TextBox').value = "";
                document.getElementById('<%= cmbNCity.ClientID %>_cmbNCity_TextBox').focus();
                return false;
            }

            IsValid = Validate($('#<%= cmbCCity.ClientID %>_cmbCCity_TextBox'));
            if (IsValid == false) {
                alert(cityAlert);
                document.getElementById('<%= cmbCCity.ClientID %>_cmbCCity_TextBox').value = "";
                document.getElementById('<%= cmbCCity.ClientID %>_cmbCCity_TextBox').focus();
                return false;
            }
            IsValid = Validate($('#<%= cmbCCounty.ClientID %>_cmbCCounty_TextBox'));
            if (IsValid == false) {
                alert(countyAlert);
                document.getElementById('<%= cmbCCounty.ClientID %>_cmbCCounty_TextBox').value = "";
                document.getElementById('<%= cmbCCounty.ClientID %>_cmbCCounty_TextBox').focus();
                return false;
            }

            return IsValid;
            //-------Mozilla Validation ends here------------------------------------------------------------------------------------

        }

        //Added by KP on 23rd Dec 2019(SOW-577), Validate the Referring Agency fields, whenever Professional, Other, Proxy and Family are selected.
        function ValidateRefAgenecy() {
            if (IsContacTypeForReferringAgency()) {
                var txtRefAgencyName = $('#<%=txtRefAgencyName.ClientID %>');
                var txtRefContactName = $('#<%=txtRefContactName.ClientID %>');
                var txtRefPhoneNumber = $('#<%=txtRefPhoneNumber.ClientID %>');
                var txtRefEmailID = $('#<%=txtRefEmailID.ClientID %>');
                var txtOtherContactType = $('#<%=txtOtherContactType.ClientID %>').val().trim();

                if (txtOtherContactType == '' && (txtRefAgencyName.val().trim() != '' || txtRefContactName.val().trim() != ''
                    || txtRefPhoneNumber.val().trim() != '' || txtRefEmailID.val().trim() != '')) {
                    var lblOtherContacType = $('#<%=lblOtherContacType.ClientID %>').html();
                    alert('To capture referring agency details, ' + lblOtherContacType + ' is required. Plesase enter ' + lblOtherContacType + '.');
                    $('#<%=txtOtherContactType.ClientID %>').focus();
                    return false;
                }
                else if (txtOtherContactType != '' && !ValidatePhone(txtRefPhoneNumber)) {
                    return false;
                }
                else if (txtOtherContactType != '' && !ValidateEmail(txtRefEmailID)) {
                    return false;
                }
            }
            return true;
        }

        //Added By AV 13 Feb 2024 Ticket-23892
        //Purpose - Search by Single quotes(') and backslash(\) generate 500 Internal Server Error
        function replaceString(str) {
            str = str.replace(/\\/g, "\\\\");
            str = str.replace(/'/g, "\\'");
            return str;
        }

        //Added by AV on 19 Feb 2024 to check duplicate
        function CheckDuplicateNeedy() {
            // Duplicate Needy person Name validation will work in both either ADRC and info only checkbox checked or not.
            var strReturn = true;
            // if  needy person First Name or Last Name has been changed then check for duplicate 
            if (needyFName != $.trim($('#<%=txtNFName.ClientID %>').val()).toUpperCase() || needyLName != $.trim($('#<%=txtNLName.ClientID %>').val()).toUpperCase()) {
                $.ajax({
                    type: "Post",
                    url: "NeedyPerson.aspx/CheckDuplicateNeedy",
                    headers: { 'X-Requested-With': 'XMLHttpRequest' },
                    data: "{'strFName':'" + replaceString($('#<%=txtNFName.ClientID %>').val()) + "','strLName':'" + replaceString($('#<%=txtNLName.ClientID %>').val()) + "','NeedyID':'" +<%=NeedyID %> +"' }",
                    contentType: "application/json",
                    dataType: "json",
                    success: function (data) {
                        if (data.d) {
                            strReturn = false;
                        }
                    },
                    async: false
                });
            }            
            return strReturn;
        }


        /*
            Created By: Santosh Maurya
            Date:03/15/2013
            Purpose:Validate all control on save person needing assistance button 
        */
        function ValidateNDCD() {

            //Added by KP on 23rd Dec 2019(SOW-577), To validate the Info only or ADRC field.
            if (document.getElementById("<%=chkInfoOnly.ClientID %>").checked == false && document.getElementById("<%=chkADRC.ClientID %>").checked == false) {
                alert('Info Only/ADRC is mandatory.');
                return false;
            }

            if (!MozillaValidation()) {
                return false;
            }
            //Added by KP on 5th Dec 2019(SOW-577), To validate the Date of Contact field.
            if (document.getElementById("<%=txtCDoC.ClientID %>").value.trim() == '' || document.getElementById("<%=txtCDoC.ClientID %>").value.trim() == '__/__/____') {
                alert("Date of Contact is mandatory.");
                document.getElementById('<%=txtCDoC.ClientID %>').focus();
                return false;
            }
            if (!ValidateDate('MainContent_txtCDoC')) {
                return false;
            }
            //end here


            if (!ValidateDate('MainContent_NeedyPersonTab_tabPersonInfo_txtNDOB')) {
                return false;
            }
                //if(!ValidateDate(document.getElementById("<%=txtreferredforocdate.ClientID %>")))
            if (!ValidateDate('MainContent_NeedyPersonTab_tabServices_txtreferredforocdate')) {
                return false;
            }
                // if(!ValidateDate(document.getElementById("<%=txtFundsUtilizedDate.ClientID %>")))
            if (!ValidateDate('MainContent_NeedyPersonTab_tabServices_txtFundsUtilizedDate')) {
                return false;
            }
            IsDataModified = 0;

            //Clear phone mask if phone value not filled            
            var IsNew = '<%=IsNew %>';
            var ContactPersonCount = parseInt(document.getElementById("<%=hdnContactPersonCount.ClientID %>").value);
            ClearPhoneFormatLoad();


                // Open brace - Validation 
                // Created by SA
                //if (document.getElementById("<%=chkInfoOnly.ClientID %>").checked == false && document.getElementById("<%=chkADRC.ClientID %>").checked == false) {


            if (document.getElementById("<%=chkADRC.ClientID %>").checked == true)//Added by KP on 23rd Dec 2019(SOW-577), Validate when ADRC is checked.
            {

                //contact type not selected
                if (($("#<%=ddlContactType.ClientID %> option:selected").text()) == '--Select--') {
                        alert('Please select contact type.');
                        $("#<%=ddlContactType.ClientID %>").focus();
                        return false;
                    }

                    if (!ValidateRefAgenecy())//Added by KP on 23rd Dec 2019(SOW-577)
                        return false;

                    var ItemText = $("#<%=ddlContactType.ClientID %> option:selected").text()

                <%--Commented by KP on 2nd June 2020(SOW-577), Contact Person validation is not required.
                if ($("#<%=ddlContactPerson.ClientID%>").css("display") != 'none') {
                    if (($("#<%=ddlContactPerson.ClientID %> option:selected").text()) == '--Select--') {
                        alert('Please select contact person.');
                        $("#<%=ddlContactPerson.ClientID %>").focus();
                        return false;
                    }
                }
                
                if (ContactPersonCount == 0 && (ItemText != 'Self' && IsNew == 0)) {
                    alert('No any contact person available. Please add contact person and then proceed.');
                    return false;
                }--%>


                    //Added By: Santosh Maurya , date: 03 June 2014 'input[name=multiselect_' + chkName + ']:checked'
                    //Purpose:Validation for checkbox 'Permission granted to refer to ADRC partner' needs to be a required field if the “Referred To” is filled in.

                    if (typeof $('input[name=multiselect_chkList]:checked').next().html() != "undefined" && $('#<%=chkPermissionGranted.ClientID %> :checkbox:checked').length == 0) {

                        alert('Please check Permission granted to refer to ADRC partner.');
                        return false;
                    }


                    if (IsNew == 1) {
                        if (ItemText != 'Self') {

                        <%--Commented by KP on 1st June 2020(SOW-577), Contact Person validation is not required.
                        if (($.trim($("#<%=txtNFName.ClientID %>").val())) == '' && ($.trim($("#<%=txtCFirstName.ClientID %>").val())) == '') {
                            alert("Enter first name of  contact person.\nEnter first name of person needing assistance.");
                            $("#<%=txtCFirstName.ClientID %>").val('');
                            $("#<%=txtCFirstName.ClientID %>").focus();
                            return false;
                        }
                        //  Needy first name entered but Contact person first name  did not entered.
                        else if (($.trim($("#<%=txtNFName.ClientID %>").val())) != '' && ($.trim($("#<%=txtCFirstName.ClientID %>").val())) == '') {
                            alert("Enter first name of contact person.");
                            $("#<%=txtCFirstName.ClientID %>").val('');
                            $("#<%=txtCFirstName.ClientID %>").focus();
                            return false;
                        }

                        //  Needy first name  din not entered but Contact person first name  entered.
                        if ((($.trim($("#<%=txtNFName.ClientID %>").val())) == '' && ($.trim($("#<%=txtCFirstName.ClientID %>").val())) != '') && IsNew == 1) {
                            alert("Enter first name of person needing assistance.");
                            $("#<%=txtNFName.ClientID %>").val('');
                            $("#<%=txtNFName.ClientID %>").focus();
                            return false;
                        }--%>

                            //Added by KP on 1st June 2020(SOW-577), Needy first name validation is required.
                            if (($.trim($("#<%=txtNFName.ClientID %>").val())) == '') {
                                alert("Enter first name of person needing assistance.");
                                $("#<%=txtNFName.ClientID %>").val('');
                                $("#<%=txtNFName.ClientID %>").focus();
                                return false;
                            }

                        }
                        else if (ItemText == 'Self') {
                            if (($.trim($("#<%=txtNFName.ClientID %>").val())) == '') {
                                alert("Enter first name of person needing assistance.");
                                $("#MainContent_txtNFName").val('');
                                $("#MainContent_txtNFName").focus();
                                return false;


                            }
                        }


                    }
                    else //if IsNew==0
                    {   //  Needy first name  din not entered for previous needy.
                        if (($.trim($("#<%=txtNFName.ClientID %>").val())) == '') {
                            alert("Enter first name of person needing assistance.");
                            $("#<%=txtNFName.ClientID %>").val('');
                            $("#<%=txtNFName.ClientID %>").focus();
                            return false;
                        }
                    }

                    //  follow-up date is required if follow-up is requested
                    if (($("#<%=ddlFollowUp.ClientID %> option:selected").val()) == '1') {
                        if (document.getElementById('<%= txtFollowupDate.ClientID %>').value == "") {
                            alert('Enter follow-up date.');
                            $("#<%=txtFollowupDate.ClientID %>").focus();
                            return false;
                        }
                        else {  // Added by Santosh on 13 Aug 2014. prevent past follow-up date.

                            var selectedDate = document.getElementById('<%= txtFollowupDate.ClientID %>').value
                            var refDate = new Date(selectedDate);
                            var now = new Date();
                            if (refDate < now) {
                                alert('Follow-up date must be future date.');
                                $("#<%=txtFollowupDate.ClientID %>").focus();
                                return false;
                            }
                        }
                    }

                    // Added by SA for OC. SOW-335. on 11-11-2014.
                    if (($("#<%=ddlOCFollowUp.ClientID %> option:selected").val()) == '1') {
                        if (document.getElementById('<%= txtOCfollowupdate.ClientID %>').value == "") {
                            alert('Enter OC follow-up date.');
                            $("#<%=txtOCfollowupdate.ClientID %>").focus();
                            return false;
                        }
                        else {  // Added by Santosh on 13 Aug 2014. prevent past follow-up date.

                            var selectedDate = document.getElementById('<%= txtOCfollowupdate.ClientID %>').value
                            var refDate = new Date(selectedDate);
                            var now = new Date();
                            if (refDate < now) {
                                alert('OC Follow-up date must be future date.');
                                $("#<%=txtOCfollowupdate.ClientID %>").focus();
                            return false;
                        }
                    }
                }


            }
            else //Added by KP on 23rd Dec 2019(SOW-577)
            {
                if (!ValidateRefAgenecy())
                    return false;
            }


            //Added by BS on 14-sep-2016 to validate extension no
            var extnFlag = true;
            var ControlToFocus = '';
            var ItemText = $("#<%=ddlContactType.ClientID %> option:selected").text();
            if (ItemText != 'Self' && IsNew == '1') {
                if ((document.getElementById("<%=txtcPhonePrimaryExtn.ClientID %>").value.trim() != '') && (document.getElementById("<%=txtcPhonePrimaryExtn.ClientID %>").value.length < 2)) {
                        var ID = document.getElementById("<%=txtcPhonePrimaryExtn.ClientID %>");
                        ID.style.backgroundColor = "#FBE3E4";//#FBE3E4
                        // ID.style.borderColor = "Red";
                        ID.style.border = "1px solid Red ";
                        ControlToFocus = ID;
                        extnFlag = false;
                    }
                    if ((document.getElementById("<%=txtCPhoneAltExtn.ClientID %>").value.trim() != '') && (document.getElementById("<%=txtCPhoneAltExtn.ClientID %>").value.length < 2)) {
                        var ID = document.getElementById("<%=txtCPhoneAltExtn.ClientID %>");
                    ID.style.backgroundColor = "#FBE3E4";//#FBE3E4
                    ID.style.border = "1px solid Red ";
                    extnFlag = false;
                    if (ControlToFocus == '')
                        ControlToFocus = ID;
                }
            }

            if ((document.getElementById("<%=txtNPhonePrimeExtn.ClientID %>").value.trim() != '') && (document.getElementById("<%=txtNPhonePrimeExtn.ClientID %>").value.length < 2)) {
                var ID = document.getElementById("<%=txtNPhonePrimeExtn.ClientID %>");
                ID.style.backgroundColor = "#FBE3E4";//#FBE3E4
                ID.style.border = "1px solid Red ";
                extnFlag = false;
                if (ControlToFocus == '')
                    ControlToFocus = ID;
            }
            if ((document.getElementById("<%=txtNPhoneAltExtn.ClientID %>").value.trim() != '') && (document.getElementById("<%=txtNPhoneAltExtn.ClientID %>").value.length < 2)) {
                var ID = document.getElementById("<%=txtNPhoneAltExtn.ClientID %>");
                ID.style.backgroundColor = "#FBE3E4";//#FBE3E4
                ID.style.border = "1px solid Red ";
                extnFlag = false;
                if (ControlToFocus == '')
                    ControlToFocus = ID;
            }
            if ((document.getElementById("<%=txtAltPhoneExtn.ClientID %>").value.trim() != '') && (document.getElementById("<%=txtAltPhoneExtn.ClientID %>").value.length < 2)) {
                var ID = document.getElementById("<%=txtAltPhoneExtn.ClientID %>");
                ID.style.backgroundColor = "#FBE3E4";//#FBE3E4
                ID.style.border = "1px solid Red ";
                extnFlag = false;
                if (ControlToFocus == '')
                    ControlToFocus = ID;
            }

            if (!extnFlag) {
                alert("Invalid extension number! Extension number must be minimum 2 digits.");
                ControlToFocus.focus();
                return false;
            }

            if ((document.getElementById("<%=txtcPhonePrimaryExtn.ClientID %>").value.length) > 0 && (document.getElementById("<%=txtCPhonePrimary.ClientID %>").value.length) == 0) {

                alert("Please enter Phone-Pri number");
                document.getElementById("<%=txtCPhonePrimary.ClientID %>").focus();
                return false;
            }
            if ((document.getElementById("<%=txtCPhoneAltExtn.ClientID %>").value.length) > 0 && (document.getElementById("<%=txtCPhoneAlt.ClientID %>").value.length) == 0) {

                alert("Please enter Phone-Alt number");
                document.getElementById("<%=txtCPhoneAlt.ClientID %>").focus();
                return false;
            }
            if ((document.getElementById("<%=txtNPhonePrimeExtn.ClientID %>").value.length) > 0 && (document.getElementById("<%=txtNPhonePrime.ClientID %>").value.length) == 0) {

                alert("Please enter Phone-Primary number");
                document.getElementById("<%=txtNPhonePrime.ClientID %>").focus();
                return false;
            }
            if ((document.getElementById("<%=txtNPhoneAltExtn.ClientID %>").value.length) > 0 && (document.getElementById("<%=txtNPhonAlt.ClientID %>").value.length) == 0) {

                alert("Please enter Phone-Alternate number");
                document.getElementById("<%=txtNPhonAlt.ClientID %>").focus();
                return false;
            }
            if ((document.getElementById("<%=txtAltPhoneExtn.ClientID %>").value.length) > 0 && (document.getElementById("<%=txtAltPhone.ClientID %>").value.length) == 0) {

                alert("Please enter Phone number");
                document.getElementById("<%=txtAltPhone.ClientID %>").focus();
                return false;
            }

            // closing brace - Validation
            if (!OtherDisabilityCheck()) {// Added by SA on 21-11-2014. SOW-335
                return false;
            }
            if (!OtherInsuranceCheck()) {// Added by SA on 21-11-2014.
                return false;
            }
            InitTrigger();

            
            <%--// Duplicate Needy person Name validation will work in both either ADRC and info only checkboc checked or not.
            var strReturn = true;
            // if  needy person First Name or Last Name has been changed then check for duplicate 
            if (needyFName != $.trim($('#<%=txtNFName.ClientID %>').val()).toUpperCase() || needyLName != $.trim($('#<%=txtNLName.ClientID %>').val()).toUpperCase()) {
                $.ajax({
                    type: "Post",
                    url: "NeedyPerson.aspx/CheckDuplicateNeedy",
                    headers: { 'X-Requested-With': 'XMLHttpRequest' },
                    data: "{'strFName':'" + replaceString($('#<%=txtNFName.ClientID %>').val()) + "','strLName':'" + replaceString($('#<%=txtNLName.ClientID %>').val()) + "','NeedyID':'" +<%=NeedyID %> +"' }",
                    contentType: "application/json",
                    dataType: "json",
                    success: function (data) {
                        if (data.d) {
                            strReturn = false;
                        }
                    },
                    async: false
                });
            }
            if (strReturn == false) {
                var msg = 'Person Needing Assistance with name [' + $('#<%=txtNFName.ClientID %>').val() + ', ' + $('#<%=txtNLName.ClientID %>').val() + '] already exists. Do you want to save?';
                var isconfirm = confirm(msg);
                if (!isconfirm)
                    return strReturn;
            }--%>
            //Added by AV on 19 Feb 2024 to check duplicate
            if (!CheckDuplicateNeedy()) {
                var msg = 'Person Needing Assistance with name [' + $('#<%=txtNFName.ClientID %>').val() + ', ' + $('#<%=txtNLName.ClientID %>').val() + '] already exists. Do you want to save?';
                var isconfirm = confirm(msg);
                if (!isconfirm)
                    return false;
            }

            if (document.getElementById('<%= chkFundProvided.ClientID %>').checked && document.getElementById('<%= txtFundProvided.ClientID %>').value == "") {
                alert("Please enter Funds Provided.");
                document.getElementById('<%= txtFundProvided.ClientID %>').focus();
                return false;
            }
            if (document.getElementById('<%= chkFundProvided.ClientID %>').checked && parseFloat(document.getElementById('<%= txtFundProvided.ClientID %>').value) <= 0) {
                alert("Funds Provided can not be 0.");
                document.getElementById('<%= txtFundProvided.ClientID %>').focus();
                return false;
            }
            //Added By:BS on 9-May-2018 TaskID-10462
            if (document.getElementById('<%= txtFundProvided.ClientID %>').value.trim() != "" && document.getElementById('<%= txtFundsUtilizedDate.ClientID %>').value.trim() == "") {
                alert("Please enter Funds Provided Date.");
                document.getElementById('<%= txtFundsUtilizedDate.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%= chkFundProvided.ClientID %>').checked && parseFloat(document.getElementById('<%= txtFundProvided.ClientID %>').value) > 0) {
                var chkBoxFundsUtilizedList = document.getElementById('<%=chklistFundsUtilized.ClientID%>');
                    var chkBoxFundsUtilizedCount = chkBoxFundsUtilizedList.getElementsByTagName("input");
                    var txtFundsOther = document.getElementById('<%=txtFundsUtilizedForOther.ClientID%>');
                    var IsChecked = false;
                    var isReqOtherFundsUtilized = false;
                    for (var i = 0; i < chkBoxFundsUtilizedCount.length; i++) {
                        if (chkBoxFundsUtilizedCount[i].checked && !IsChecked) {
                            IsChecked = true;
                        }

                        if (chkBoxFundsUtilizedCount[i].parentNode.getElementsByTagName("LABEL")[0].innerHTML == "Other"
                            && chkBoxFundsUtilizedCount[i].checked && txtFundsOther.value.trim() == "")
                            isReqOtherFundsUtilized = true;
                    }
                    if (!IsChecked) {
                        alert("Please select Funds Utilized for.");
                        return false;
                    }

                    if (isReqOtherFundsUtilized) {
                        alert("Please enter Other Funds Utilized for.");
                        document.getElementById('<%= txtFundsUtilizedForOther.ClientID %>').focus();
                    return false;
                }
            }

            CheckDateChanged('onSave');
            if ($("#divalertConfirm:visible").length > 0)
                return false;
            var isvalid = false;
            //validate by validation group
            var ele = document.getElementById("<%=divpnlContact.ClientID %>");
            if (ele.style.display == "block") {
                isvalid = Page_ClientValidate('CD');
            }
            if (isvalid == false && ele.style.display == "block")
                return isvalid;

            if (!Page_ClientValidate('ND'))
                return false;

            if (document.getElementById('<%= hdnServReq.ClientID %>').value == "") {

                ShowConfirmationBox(1, 'No service is selected. Would you like to select a service for this record?');
                return false;
            }

            return true;
            //return Page_ClientValidate('ND');
        }

        var type;

        //Added By KR on 30 March 2017.Task ID 9133.
        function ShowConfirmationBox(Type, msg) {
            type = Type;
            document.getElementById("btnNoPopupConfirm").removeEventListener('click', update, false);
            document.getElementById("btnNoPopupConfirm").removeEventListener('click', HideConfirmationBox, false);
            document.getElementById("btnYesPopupConfirm").removeEventListener('click', HideConfirmationBox, false);
            //Added by AV on 26 Feb 2024 to remove active event listenar
            document.getElementById("btnYesPopupConfirm").removeEventListener("click", confirmDuplicate, false);
            document.getElementById("btnNoPopupConfirm").removeEventListener("click", confirmDuplicate, false);

            $("#divalertConfirm").css("display", "block");
            $("#divoverlaysuccess").css("display", "block");
            $("#spnMessageConfirm").text(msg);
            if (Type == 1)// for service confirmation
            {
                document.getElementById("btnYesPopupConfirm").addEventListener("click", HideConfirmationBox, false);
                document.getElementById("btnNoPopupConfirm").addEventListener("click", update, false);
            }
            else if (Type == 3) //Added by AV on 26 Feb 2024 purpose: display confirmation on dupliacte (on blur)
            {
                document.getElementById("btnYesPopupConfirm").addEventListener("click", confirmDuplicate, false);
                document.getElementById("btnNoPopupConfirm").addEventListener("click", confirmDuplicate, false);
                
            }
            else // for fund utilized date confirmation
            {
                document.getElementById("btnYesPopupConfirm").addEventListener("click", HideConfirmationBox, false);
                document.getElementById("btnNoPopupConfirm").addEventListener("click", SetOriginalValue, false);
            }
            return false;
        }

        //Created By:Bs
        //Crated on:10-May-2018
        //Purpose: set origianal date is user does not want to change the date
        function SetOriginalValue() {

            $("#divalertConfirm").css("display", "none");
            $("#divoverlaysuccess").css("display", "none");
            var CurrentTab = $find('<%=NeedyPersonTab.ClientID%>');
            var i = CurrentTab._activeTabIndex;
            if (i != 1)
                CurrentTab.set_activeTabIndex(parseInt(1));
            var originalValue = document.getElementById("<%=txtFundsUtilizedDate.ClientID %>").defaultValue;
            var d = new Date(originalValue);
            originalValue = d.format("MM/dd/yyyy");
            document.getElementById("<%=txtFundsUtilizedDate.ClientID %>").value = originalValue;
            document.getElementById("<%=hdnFundsUtilizedDate.ClientID %>").value = document.getElementById("<%=txtFundsUtilizedDate.ClientID %>").value;
            $("[id*=btnUpdate]").click();
        }
        //Created By:Bs
        //Crated on:10-May-2018
        //Purpose: Hide confirmation box
        function HideConfirmationBox(Type) {
            $("#divalertConfirm").css("display", "none");
            $("#divoverlaysuccess").css("display", "none");
            var CurrentTab = $find('<%=NeedyPersonTab.ClientID%>');
            var i = CurrentTab._activeTabIndex;
            if (i != 1)
                CurrentTab.set_activeTabIndex(parseInt(1));
            if (type != 1) {
                document.getElementById("<%=hdnFundsUtilizedDate.ClientID %>").value = document.getElementById("<%=txtFundsUtilizedDate.ClientID %>").value.trim();
                $("[id*=btnUpdate]").click();
            }
        }
        function update() {
            $("#divalertConfirm").css("display", "none");
            $("#divoverlaysuccess").css("display", "none");
            CheckDateChanged('OnConfirmation');
            // $("[id*=btnUpdate]").click();

        };

        //Created By:AV
        //Crated on:26-Feb-2024
        //Purpose: Hide confirmation box for duplicate confirmation
        function confirmDuplicate(event) {
            if (event.target.value == 'No') {
                $find('<%=NeedyPersonTab.ClientID%>').set_activeTabIndex(parseInt(0));
                ElementToFocus.focus();
            }
            $("#divalertConfirm").css("display", "none");
            $("#divoverlaysuccess").css("display", "none");
        }

        //Added Section end here.
        /*Created By: Santosh Maurya
            Date:03/15/2013
            Purpose:Validate all control on save contact person popup button */
        function ValidateCD() {
            if (!MozillaValidation()) {
                return false;
            }
            ClearPhoneFormatLoad();
            //if (document.getElementById("<%=chkInfoOnly.ClientID %>").checked == false && document.getElementById("<%=chkADRC.ClientID %>").checked == false) {
            // if contact person first name not enterd txtCMI txtCLastName
            if ($.trim($("#<%=txtCFirstName.ClientID %>").val()) == '' && $.trim($("#<%=txtCMI.ClientID %>").val()) == ''
                && $.trim($("#<%=txtCLastName.ClientID %>").val()) == '') {
                alert('Enter name of contact person.');
                $("#<%=txtCFirstName.ClientID %>").val('');
                $("#<%=txtCFirstName.ClientID %>").focus();
                return false;
            }
            //}

            //Added by BS on 14-sep-2016 to validate extn
            var extnFlag = true;
            var ControlToFocus = '';
            if ((document.getElementById("<%=txtcPhonePrimaryExtn.ClientID %>").value.trim() != '') && (document.getElementById("<%=txtcPhonePrimaryExtn.ClientID %>").value.length < 2)) {
                var ID = document.getElementById("<%=txtcPhonePrimaryExtn.ClientID %>");
                ID.style.backgroundColor = "#FBE3E4";//#FBE3E4
                ID.style.border = "1px solid Red ";
                ControlToFocus = ID;
                extnFlag = false;
            }
            if ((document.getElementById("<%=txtCPhoneAltExtn.ClientID %>").value.trim() != '') && (document.getElementById("<%=txtCPhoneAltExtn.ClientID %>").value.length < 2)) {
                var ID = document.getElementById("<%=txtCPhoneAltExtn.ClientID %>");
                ID.style.backgroundColor = "#FBE3E4";//#FBE3E4
                ID.style.border = "1px solid Red ";
                extnFlag = false;
                if (ControlToFocus == '')
                    ControlToFocus = ID;
            }
            if (!extnFlag) {
                alert("Invalid extension number! Extension number must be minimum 2 digits.");
                ControlToFocus.focus();
                return false;
            }

            if ((document.getElementById("<%=txtcPhonePrimaryExtn.ClientID %>").value.length) > 0 && (document.getElementById("<%=txtCPhonePrimary.ClientID %>").value.length) == 0) {
                alert("Please enter Phone-Pri number");
                document.getElementById("<%=txtCPhonePrimary.ClientID %>").focus();
                return false;
            }

            if ((document.getElementById("<%=txtCPhoneAltExtn.ClientID %>").value.length) > 0 && (document.getElementById("<%=txtCPhoneAlt.ClientID %>").value.length) == 0) {
                alert("Please enter Phone-Alt number");
                document.getElementById("<%=txtCPhoneAlt.ClientID %>").focus();
                return false;
            }

            var retVal = Page_ClientValidate('CD');
            if (retVal)
                ShowLoader();

            return retVal;
        }

        /*
        Created By: Santosh Maurya
        Date:03/20/2013
        Purpose:Show call history 
        */
        function BindCallHistory() {
            
            var divCallHistory = document.getElementById("divCallHistory");
            if (divCallHistory.style.display == "none") {
                divCallHistory.style.display = "block";
                $.ajax({
                    type: "POST",
                    url: "NeedyPerson.aspx/GetCallHistory",
                    headers: { 'X-Requested-With': 'XMLHttpRequest' },
                    data: "{'NeedyID':'" +<%=NeedyID %> +"'}",
                    contentType: "application/json",
                    dataType: "json",
                    success: function (data) {

                        if (data.d.length > 0) {

                            $("#<%=btnPrintPage.ClientID %>").attr("disabled", false);//Added By KP on 31st March 2020(TaskID:18464), To enable Print button, when call history exist.
                            $('#lblCallCount').html('Total number of call : ' + data.d.length);

                            $('#gridHistory').tablesorter();
                            $('#gridHistory tbody').empty();

                            for (var i = 0; i < data.d.length; i++) {
                                var todoscr;
                                if (data.d[i].IsToDo == 1)
                                    todoscr = 'images/ToDoFlag_Red.png';
                                else
                                    todoscr = 'images/ToDoFlag_White.png';


                                if (i % 2 == 0) {
                                    $("#gridHistory").append("<tr  class='gridview_rowstyle' valign='top' id=" + data.d[i].HistoryID + "><td align='left' style='word-break:break-all;word-wrap:break-word' > <a title='Click to view details'  style='color:blue'  class='view_call_history_More' id=" + data.d[i].HistoryID + " onclick='ShowMoreHistory(" + data.d[i].HistoryID + ");'> " + data.d[i].FirstName + "</a></td>" +
                                        "<td align='left'>" + data.d[i].LastName + "</td> <td align='left'>" + data.d[i].Email + "</td> <td >" + data.d[i].ContactDate + " " + data.d[i].ContactTime + " </td><td>" + data.d[i].CallDuration + "</td><td align='left'>" + data.d[i].ServiceRequested + "</td>" + "<td align='left'>" + data.d[i].UserName + "</td>" + "<td align='left'>" + data.d[i].IsADRCYesNo + "</td>" + "<td align='left'>" + (data.d[i].IsInfoOnly == true ? "Yes" : "No") + "</td><td> <img src='" + todoscr + "'  onclick='SetToDo(this," + data.d[i].HistoryID + "," + data.d[i].NeedyPersonID + ")'/> </td> </tr>");
                                }
                                else {
                                    $("#gridHistory").append("<tr  class='gridview_alternaterow' valign='top' id=" + data.d[i].HistoryID + " ><td align='left' style='word-break:break-all;word-wrap:break-word' > <a title='Click to view details' style='color:blue' class='view_call_history_More' id=" + data.d[i].HistoryID + " onclick='ShowMoreHistory(" + data.d[i].HistoryID + ");'> " + data.d[i].FirstName + "</a></td>" +
                                        "<td align='left'>" + data.d[i].LastName + "</td> <td align='left'>" + data.d[i].Email + "</td><td >" + data.d[i].ContactDate + " " + data.d[i].ContactTime + "</td><td>" + data.d[i].CallDuration + "</td><td align='left'>" + data.d[i].ServiceRequested + "</td><td align='left'>" + data.d[i].UserName + "<td align='left'>" + data.d[i].IsADRCYesNo + "</td>" + "<td align='left'>" + (data.d[i].IsInfoOnly == true ? "Yes" : "No") + "</td><td> <img src='" + todoscr + "'  onclick='SetToDo(this," + data.d[i].HistoryID + "," + data.d[i].NeedyPersonID + ")'/> </td></tr>");
                                }
                            }
                            $('.tablesorter').trigger('update');
                        }
                        else {
                            $('#gridHistory').hide();
                            $('#lblCallCount').html('No record found.');
                            $("#<%=btnPrintPage.ClientID %>").attr("disabled", true);//Added By KP on 31st March 2020(TaskID:18464), To disable Print button, when no call history record.

                        }

                    }
                });
            }
            else {
                divCallHistory.style.display = "none";
            }
        }

        function SetToDo(ctrl, callid, NeedyID) {
            var Flagtodo;
            if (ctrl.src.indexOf("ToDoFlag_White.png") !== -1)
                Flagtodo = 1;
            else if (ctrl.src.indexOf("ToDoFlag_Red.png") !== -1)
                Flagtodo = 0;
            $.ajax({
                type: "POST",
                url: "NeedyPerson.aspx/SetToDo",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                data: "{'HistoryID':" + callid + ",'NeedyID':" + NeedyID + ",'ToDoFlag':" + Flagtodo + "}",
                contentType: "application/json",
                dataType: "json",
                success: function (data) {
                    if (data.d) {
                        if (ctrl.src.indexOf("ToDoFlag_White.png") !== -1) {
                            ctrl.src = 'images/ToDoFlag_Red.png';
                        }
                        else if (ctrl.src.indexOf("ToDoFlag_Red.png") !== -1) {
                            ctrl.src = 'images/ToDoFlag_White.png';
                        }
                    }
                }

            });
        }

        function SetToDoForCall(ctrl) {
            if (ctrl.src.indexOf("ToDoFlag_White.png") !== -1) {

                document.getElementById('hdnToDo').value = 1;
                ctrl.src = 'images/ToDoFlag_Red.png';
            }
            else {
                document.getElementById('hdnToDo').value = 0;
                ctrl.src = 'images/ToDoFlag_White.png';
            }
        }

        /* Created By: Santosh Maurya
           Date:03/20/2013
           Purpose:This function will call when user clicked on call history to view more details. */
        function ShowMoreHistory(callid) {
            $.ajax({
                type: "POST",
                url: "NeedyPerson.aspx/GetCallHistoryDetails",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                data: "{'HistoryID':" + callid + ",'NeedyID':'" +<%=NeedyID %> +"'}",
                contentType: "application/json",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        $('#grdHistoryDetails tbody').empty();
                        for (var i = 0; i < data.d.length; i++) {

                            //Added by KP on 30th Jan 2020(SOW-577), Get Referring Agency fields and then display them, when RefAgencyDetailID > 0
                            var refAgencyDetails = '';
                            if (data.d[i].RefAgencyDetailID > 0)
                                refAgencyDetails = "<tr><td valign='top' colspan='8'><h4>Referring Agency Details</h4></td></tr>" +
                                    "<tr><td valign='top'><span class='call_hist_lable'>" + data.d[i].ContactTypeName + " Info</span></td>" +
                                    "<td valign='top' style='word-break:break-all;word-wrap:break-word' >" + data.d[i].RefContactInfo + "</td>" +
                                    "<td valign='top'><span class='call_hist_lable'>Agency Name</span></td>" +
                                    "<td valign='top' style='word-break:break-all;word-wrap:break-word' >" + data.d[i].RefAgencyName + "</td>" +
                                    "<td valign='top'><span class='call_hist_lable'>Contact Name</span></td>" +
                                    "<td valign='top' colspan='3' style='word-break:break-all;word-wrap:break-word' >" + data.d[i].RefContactName + "</td>" +
                                    "</tr><tr><td valign='top'><span class='call_hist_lable'>Phone Number</span></td>" +
                                    "<td valign='top' >" + data.d[i].RefPhoneNumber + "</td>" +
                                    "<td valign='top' ><span class='call_hist_lable'>Email ID</span></td>" +
                                    "<td valign='top' colspan='5'>" + data.d[i].RefEmail + "</td></tr>";
                            //End (SOW-577)

                            $("#grdHistoryDetails").append(
                                "<tr><td valign='top'  width='10%' ><span class='call_hist_lable'>First Name</span></td>" +
                                "<td valign='top'  width='16%' style='word-break:break-all;word-wrap:break-word' >" + data.d[i].FirstName + "</td>" +
                                /*added by SA on 20th aug, 2015*/
                                "<td valign='top'  width='10%' ><span class='call_hist_lable'>Last Name</span></td>" +
                                "<td valign='top'  width='16%' style='word-break:break-all;word-wrap:break-word' >" + data.d[i].LastName + "</td>" +

                                "<td valign='top' width='10%'><span class='call_hist_lable'>Relationship</span></td>" +
                                "<td valign='top' width='15%' style='word-break:break-all;word-wrap:break-word' >" + data.d[i].Relationship + "</td>" +

                                "<td valign='top' width='10%' ><span class='call_hist_lable'>Contact Date/Time</span></td>" +
                                "<td valign='top' width='12%'>" + data.d[i].ContactDate + " " + data.d[i].ContactTime + "</td></tr>" +

                                "<tr> " +
                                " <td valign='top' width='10%' ><span class='call_hist_lable'>Primary Phone</span></td>" +
                                "<td valign='top'  width='15%' style='word-break:break-all;word-wrap:break-word'>" + data.d[i].PhonePrimary + "</td>" +

                                "<td valign='top'  width='10%' ><span class='call_hist_lable'>Contact Type</span></td>" +
                                "<td valign='top' width='15%'> " + data.d[i].ContactTypeName + "</td>   " +
                                "<td valign='top' width='15%'><span class='call_hist_lable'>Contact Method</span></td>" +
                                "<td valign='top' colspan='3' >" + data.d[i].ContactMethodName + "</td>" +

                                "</tr>" +
                                "<tr> <td valign='top'><span class='call_hist_lable'>ADRC</span></td>" +
                                "<td valign='top'>" + data.d[i].IsADRCYesNo + "</td>" +

                                "<td valign='top'><span class='call_hist_lable'>Info Only</span></td>" +
                                "<td valign='top'>" + data.d[i].IsInfoOnlyYesNo + "</td>" +

                                " <td valign='top'><span class='call_hist_lable'>Call Duration</span></td>" +
                                "<td valign='top' colspan='3'>" + data.d[i].CallDuration + "</td> </tr>" +

                                "<tr> <td valign='top'><span class='call_hist_lable'>Follow-up</span></td>" +
                                "<td valign='top'>" + data.d[i].FollowUpYesNo + "</td>" +

                                "<td valign='top'><span class='call_hist_lable'>Follow-up Date</span></td>" +
                                "<td valign='top'>" + data.d[i].FollowupDate + "</td>" +

                                " <td valign='top'><span class='call_hist_lable'>Service Need Met</span></td>" +
                                "<td valign='top' colspan='3'>" + data.d[i].ServiceNeedsMetYesNo + "</td> </tr>" +

                                "<tr><td valign='top' align='center' colspan='3'><span class='call_hist_lable'>Service(s) Requested</span></td>" +
                                "<td valign='top' align='center' colspan='5'><span class='call_hist_lable'>Notes</span></td>" +
                                "</tr>" +

                                "<tr><td valign='top'colspan='3' style='word-break:break-all;word-wrap:break-word'>" + data.d[i].ServiceRequested + "</td>" +
                                "<td valign='top'colspan='5' style='word-break:break-all;word-wrap:break-word'>" + data.d[i].Notes + "</td></tr>"
                                + refAgencyDetails);

                        }
                    }

                }
            });
            ShowHideMoreCallhistory();
        }


        //Showing all call details information
        function ShowHideMoreCallhistory() {
            var divpnlContact = document.getElementById("<%=divpnlContact2.ClientID %>");
            var showHideDiv = document.getElementById("<%=showHideDiv2.ClientID %>");
            var divPopUpContent = document.getElementById("<%=divPopUpContent2.ClientID %>");
            var divpopupHeading = document.getElementById("<%=divpopupHeading2.ClientID %>");
            var btnClose = document.getElementById("<%=btnClose2.ClientID %>");

            if (divpnlContact.style.display == "block") {
                showHideDiv.className = "";
                divPopUpContent.className = "";
                divpnlContact.style.display = "none";
                btnClose.style.display = "none";
                divpopupHeading.style.display = "none";
            }
            else {
                showHideDiv.className = "main_popup_moreHistory ";
                divPopUpContent.className = "popup_moreHistory ";
                divpnlContact.style.display = "block";
                btnClose.style.display = "block";
                divpopupHeading.style.display = "block";
            }
        }


        function NumericValidation(eventObj) {
            var keycode;

            if (eventObj.keyCode) //For IE
                keycode = eventObj.keyCode;
            else if (eventObj.Which)
                keycode = eventObj.Which;  // For FireFox
            else
                keycode = eventObj.charCode; // Other Browser

            if (keycode != 8) //if the key is the backspace key
            {
                if (keycode < 48 || keycode > 57) //if not a number 
                    return false; // disable key press
                else
                    return true; // enable key press
            }
        }

        /* only numeric value allowed */
        function OnlyNumeric() {

            var key_code = window.event.keyCode != null ? window.event.keyCode : window.event.which;
            var oElement = window.event.srcElement;
            if (!window.event.shiftKey && !window.event.ctrlKey && !window.event.altKey) {
                if ((key_code > 47 && key_code < 58) || (key_code > 95 && key_code < 106)) {
                    if (key_code > 95) key_code -= (95 - 47); oElement.value = oElement.value;
                    //bindCityCounty();
                }
                else if (key_code == 8) {
                    oElement.value = oElement.value;
                    //bindCityCounty();
                }
                else if (key_code != 9) {
                    event.returnValue = false;
                }
            }
        }


        function bindCityCounty(zipcode) {

            $(".autocmplt").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        url: "NeedyPerson.aspx/GetCityCountyByZip",
                        headers: { 'X-Requested-With': 'XMLHttpRequest' },
                        data: "{'strZipCode':'12'}",
                        contentType: "application/json",
                        dataType: "json",
                        success: function (data) {
                            response(data.d);
                        }
                    });
                },
                select: function (event, ui) {
                    //you can select here any control value i.e.$("#ContentPlaceHolder1_hdnSmart").val("Yes");
                }
            });

        }
        /*
            Created by SA on 20th Jan, 2015. SOW-335
            Purpose: To rebind listbox for selected values on page postback.
           modified by:BS on 5-March-2018 sow-512
        */

        function ReBindServReqOnPostBack() {
            //Added by vk on 30 aug,2018.for bind Contact Person on post back.
            var ContactPersonCount = parseInt(document.getElementById("<%=hdnContactPersonCount.ClientID %>").value);
            var ItemText = $("#<%=ddlContactType.ClientID %> option:selected").text()
            if (ContactPersonCount > 0) {
                if (ItemText != '--Select--') {
                    $('#<%=lblContactPerson.ClientID %>').css('display', 'inline');
                    $('#<%=ddlContactPerson.ClientID %>').css('display', 'inline');
                    $("span[id$='lblRelationship']").text('');
                    BindRelationshipLabel(document.getElementById("<%=ddlContactPerson.ClientID %>"));
                }
            }
            $("[id*=lstServicesAvailable] option").remove();
            //Rebind services available
            // Commented by GK on 4Feb 2021 : Ticket #925
            <%--var SplitVals = $('#<%=hdnServAvail.ClientID%>').val().split('~');
            if (SplitVals != '') {
                $.each(SplitVals, function (index, item) {
                    $('#<%=lstServicesAvailable.ClientID %>').append(item);
                });
            }--%>

            // Added by GK on 4Feb 2021 : Ticket #925
            var objServiceList = JSON.parse($('#<%=hdnServAvail.ClientID%>').val());
            $.each(objServiceList, function (index, item) {
                $('#<%=lstServicesAvailable.ClientID %>').append('<option value="' + item.Value + '" title="' + item.Text + '">' + item.Text + '</option>');
            });

            var OptionsRequested = $('#<%=lstServicesRequested.ClientID %> option');
            var strOptions = '';//Get inactive services Requested
            var strServiceIds = '';
            $(OptionsRequested).each(function (index, item) {
                if ($("#<%=lstServicesAvailable.ClientID %> option[value='" + this.value + "']").length == 0) {
                    if (index == 0) {
                        strOptions = '<option value=' + this.value + '>' + this.text + '</option>';

                    }
                    else {
                        strOptions += '~ ' + '<option value=' + this.value + '>' + this.text + '</option>';

                    }

                }
            });
            $("[id*=lstServicesRequested] option").remove();
            strServiceIds = $('#<%=hdnServReq.ClientID%>').val();
            if (strServiceIds != '') {//bind Active services Requested
                var SplitVals = $('#<%=hdnServReq.ClientID%>').val().split(',');
                $.each(SplitVals, function (index, item) {
                    if ($('#<%=lstServicesAvailable.ClientID %> option[value=' + item + ']').length > 0) {
                        $('#<%=lstServicesRequested.ClientID %>').append($('#<%=lstServicesAvailable.ClientID %> option[value=' + item + ']').clone());

                    }
                });
            }
            if (strOptions != '') {
                var Splits = strOptions.split('~');//bind Inactive services Requested
                $.each(Splits, function (index, item) {
                    $('#<%=lstServicesRequested.ClientID %>').append(item);
                });
            }
            var obj = $('#<%=lstServicesRequested.ClientID %>');
            var OptionsRequested = $('#<%=lstServicesRequested.ClientID %> option');
            $("[id*=lstServicesRequested] option").remove();
            if (OptionsRequested.length > 0)
                SortOptions(obj, OptionsRequested)
            ServiceIDString(strServiceIds);

            //check  for if value has changed 
            CheckControlValueChange();
            return false;
        }


        //Added By: BS
        //Added On:5-March-2018
        //Purpose:Sort options after appending from client side
        function SortOptions(Obj, options) {
            options.detach().sort(function (a, b) {
                var at = $(a).text();
                var bt = $(b).text();
                return (at > bt) ? 1 : ((at < bt) ? -1 : 0);
            });
            options.appendTo(Obj);
        }

        /* 
         Created By: Santosh Maurya
         Date:03/18/2013
         Purpose:Add Service
        */
        function AddService() {
            var selectedOptions = $('#<%=lstServicesAvailable.ClientID %> option:selected');
            if (selectedOptions.length == 0) {
                alert("Please select option to move");
                return false;
            }
            if (selectedOptions.length == 1) {
                if ($("#<%=lstServicesRequested.ClientID %> option[value='" + selectedOptions.val() + "']").length > 0) {
                }
                else {
                    $('#<%=lstServicesRequested.ClientID %>').append($(selectedOptions).clone());
                }
            }
            else if (selectedOptions.length > 1) {
                $(selectedOptions).each(function () {
                    if ($("#<%=lstServicesRequested.ClientID %> option[value='" + this.value + "']").length > 0) {
                    }
                    else {
                        $('#<%=lstServicesRequested.ClientID %>').append($(this).clone());
                    }
                });
            }

            $('#<%=lstServicesAvailable.ClientID %>')[0].selectedIndex = -1;

            var obj = $('#<%=lstServicesRequested.ClientID %>');
            var OptionsRequested = $('#<%=lstServicesRequested.ClientID %> option');
            if (OptionsRequested.length > 0)
                SortOptions(obj, OptionsRequested)
            // call method to get service id
            ServiceIDString('');
            //check  for if value has changed 
            CheckControlValueChange();
            return false;
        }

        /* 
            Created By: Santosh Maurya
            Date:03/18/2013
            Purpose:Remove Service 
        */

        function RemoveService() {
            var selectedOptionsRequested = $('#<%=lstServicesRequested.ClientID %> option:selected');
            if (selectedOptionsRequested.length == 0) {
                alert("Please select option to move");
                return false;
            }
            var hdnInactiveServ = document.getElementById('<%= hdnInactiveServ.ClientID %>');
            if (hdnInactiveServ.value.length == 0) {
                var OptionsRequested = $('#<%=lstServicesRequested.ClientID %> option');
                var inActiveServ = "";
                $(OptionsRequested).each(function (index, item) {
                    if ($("#<%=lstServicesAvailable.ClientID %> option[value='" + this.value + "']").length == 0) {
                        if (index == 0)
                            inActiveServ = item.value;
                        else
                            inActiveServ += "," + item.value;
                        hdnInactiveServ.value = inActiveServ;
                    }
                });
            }

            var isServiceInactive = 0;
            var ArrSelectedOptionsRequested = [];
            $(selectedOptionsRequested).each(function (i) {
                if ($("#<%=lstServicesAvailable.ClientID %> option[value='" + this.value + "']").length == 0) {
                    ArrSelectedOptionsRequested.push(selectedOptionsRequested[i]);
                }
            });
            var SplitVals = $('#<%=hdnInactiveServ.ClientID%>').val().split(',');
            $.each(SplitVals, function (index, item) {
                for (var j = 0; j < selectedOptionsRequested.length; j++) {
                    if (item === selectedOptionsRequested[j].value) {
                        isServiceInactive = 1;
                        break;
                    }
                    if (isServiceInactive == 1)
                        break;
                }
            });


            if ((isServiceInactive == 0) || (isServiceInactive == 1 && confirm('Some of the service(s) are inactive for this agency and these services may not be available to add again once the record is saved. Are you sure you want to remove these service(s)? '))) {
                $(selectedOptionsRequested).remove();
                $(ArrSelectedOptionsRequested).each(function (i) {
                    $('#<%=lstServicesAvailable.ClientID %>').append($(ArrSelectedOptionsRequested[i]).clone());
                });
                // call method to get service id
                ServiceIDString('');
                ResetAvailableServiceID();
                //check for if value has changed 
                CheckControlValueChange();
            }
            var obj = $('#<%=lstServicesAvailable.ClientID %>');
            var OptionsAvailable = $('#<%=lstServicesAvailable.ClientID %> option');
            if (isServiceInactive == 1 && OptionsAvailable.length > 0) {
                SortOptions(obj, OptionsAvailable)
            }
            return false;
        }

        /*
          Created By: Santosh Maurya
          Date:03/18/2013
          Purpose:get selected service id 
        */
        function ServiceIDString(strServiceIds) {
            if (strServiceIds == '') {
                var dest = document.getElementById('<%= lstServicesRequested.ClientID %>');
                var str = '';
                for (var count = 0; count < dest.options.length; count++) {
                    if (str == '') {

                        var option = dest.options[count];
                        str = option.value;
                    }
                    else {

                        var option1 = dest.options[count];
                        str = str + ',' + option1.value;
                    }
                }
                document.getElementById('<%= hdnServReq.ClientID %>').value = str;
            }
            //Added by vk 13 Aug,2018,on Post Back set serviceid.
            else {
                document.getElementById('<%= hdnServReq.ClientID %>').value = strServiceIds;

            }

        }

        /*
       Created By: BS
       Date:1-March-2018
       Purpose:Reset service available hidden field to maintain value on postback
     */
        function ResetAvailableServiceID() {
            var OptionsAvailable = $('#<%=lstServicesAvailable.ClientID %> option');
            // Commented by GK on 4Feb 2021 : Ticket #925
            <%--$(OptionsAvailable).each(function (index, item) {
                if (index == 0)
                    strOptions = '<option value=' + this.value + '>' + this.text + '</option>';
                else
                    strOptions += '~ ' + '<option value=' + this.value + '>' + this.text + '</option>';
            });

            document.getElementById('<%= hdnServAvail.ClientID %>').value = strOptions;--%>

            // Added by GK on 4Feb 2021 : Ticket #925
            var arr = [];
            $(OptionsAvailable).each(function (index, item) {
                arr.push({
                    Value: this.value,
                    Text: this.text
                });
            });
            document.getElementById('<%= hdnServAvail.ClientID %>').value = JSON.stringify(arr);
        }

        /* 
        Created By: Santosh Maurya
        date:03/18/2013
        Purpose:show  contact person section (or Add Contact link ) if contact type not 'Self' only 
        */
        function ShowHideContactDetails(ctrlId) {

            //debugger;
            var IsNew = '<%=IsNew %>';
            var ContactPersonCount = parseInt(document.getElementById("<%=hdnContactPersonCount.ClientID %>").value);

            var divpnlContact = document.getElementById("<%=divpnlContact.ClientID %>");
            var divContact = document.getElementById("<%=divContact.ClientID %>");
            var pnlContactPersonGrid = document.getElementById("<%=pnlContactPersonGrid.ClientID %>");
            var showHideDiv = document.getElementById("<%=showHideDiv.ClientID %>");
            var hyprAddContact = document.getElementById("<%=hyprAddContact.ClientID %>");
            var rwContactSave = document.getElementById("<%=rwContactSave.ClientID %>");
            var refringAgencyDiv = document.getElementById("<%=refringAgencyDiv.ClientID %>");

            // get Contact Type  select text
            var ItemText = $("#<%=ddlContactType.ClientID %> option:selected").text();

            if (ContactPersonCount == 0) {
                $('#<%=lblContactPerson.ClientID %>').css('display', 'none');
                $('#<%=ddlContactPerson.ClientID %>').css('display', 'none');
                $('#<%=lblRelationLabel.ClientID %>').css('display', 'none');
            }


            $("span[id$='lblRelationship']").text('');
            // if new person and contactType is 'Self' then hide contact person section          
            if (IsNew == '1' && ItemText == 'Self') {
                divpnlContact.style.display = "none";
                divContact.style.display = "none";
                pnlContactPersonGrid.style.display = "none";

                $('#<%=lblRelationLabel.ClientID %>').css('display', 'inline');
                $("span[id$='lblRelationship']").text('Self');
            }
            // if new person and contactType is not 'Self'   then show contact person section 
            else if (IsNew == '1' && ItemText != 'Self') {
                divpnlContact.style.display = "block";
                divContact.style.display = "block";
                pnlContactPersonGrid.style.display = "block";
                hyprAddContact.style.display = "none";
                pnlContactPersonGrid.style.display = "none";

                $("span[id$='lblRelationship']").text('');
                BindRelationshipLabel(document.getElementById("<%=ddlContactPerson.ClientID %>"));

            }
            // if old person and contactType is  'Self'   then hide contact person dropdown
            else if (ItemText == 'Self' && IsNew == "0") {
                hyprAddContact.style.display = "none";

                $('#<%=lblContactPerson.ClientID %>').css('display', 'none');
                $('#<%=ddlContactPerson.ClientID %>').css('display', 'none');
                $('#<%=lblRelationLabel.ClientID %>').css('display', 'inline');
                $("span[id$='lblRelationship']").text('Self');

            }
            // if old person and contactType is  not  'Self'   then show contact person dropdown
            else if (IsNew == '0' && ItemText != 'Self') {
                hyprAddContact.style.display = "block";
                divContact.style.display = "block";

                //divpnlContact.style.display = "block";// Added to display Contact Panel in case of update just after save needy person SOW-335. SA - 27th Jan, 2015
                if (ContactPersonCount > 0) {
                    if (ItemText != '--Select--') {
                        $('#<%=lblContactPerson.ClientID %>').css('display', 'inline');
                        $('#<%=ddlContactPerson.ClientID %>').css('display', 'inline');

                        $("span[id$='lblRelationship']").text('');
                        BindRelationshipLabel(document.getElementById("<%=ddlContactPerson.ClientID %>"));
                    }
                }

            }

            //Added By KP on 6th Jan 2020(SOW-577), Reset fields value and hide/show based on conditions.
            $('#<%=hdnSelectedRefDetailID.ClientID %>').val('0');
            if (IsContacTypeForReferringAgency())//For Professional, Other, Proxy and Family
            {
                LoadContactInfoJSON();
                <%--var other = $('#<%=hdnCTypeOther.ClientID %>').val();
                $('#<%=txtOtherContactType.ClientID %>').val(other);--%>
                $('#<%=lblOtherContacType.ClientID %>').css('display', 'inline');
                $('#<%=txtOtherContactType.ClientID %>').css('display', 'inline');
                $('#<%=lblOtherContacType.ClientID %>').html(ItemText + ' Info');
                refringAgencyDiv.style.display = "block";
                $('#<%=inputSearchSpan.ClientID %>').css('display', 'inline');

                $("span[id$='lblRelationship']").text('');
                BindRelationshipLabel(document.getElementById("<%=ddlContactPerson.ClientID %>"));
            }
            else {
                $('#<%=txtOtherContactType.ClientID %>').val('');
                $('#<%=txtRefAgencyName.ClientID %>').val('');
                $('#<%=txtRefContactName.ClientID %>').val('');
                $('#<%=txtRefPhoneNumber.ClientID %>').val('');
                $('#<%=txtRefEmailID.ClientID %>').val('');
                $('#<%=lblOtherContacType.ClientID %>').css('display', 'none');
                $('#<%=txtOtherContactType.ClientID %>').css('display', 'none');
                refringAgencyDiv.style.display = "none";
                $('#<%=inputSearchSpan.ClientID %>').css('display', 'none');
            }
            //End (SOW-577)
        }

        /*
        Created By: Santosh Maurya
        Date:04/29/2013
        Purpose:Show - hide Other text boxex  Based on contact type Mehtod
        */
        function ShowHideOther() {

            if (($("#<%=ddlContactMethod.ClientID %> option:selected").text()) == 'Other') {
                var other = $('#<%=hdnCMethodOther.ClientID %>').val();
                $('#<%=txtOtherContactMethod.ClientID %>').val(other);
                $('#<%=lblOtherContactMethod.ClientID %>').css('display', 'inline');
                $('#<%=txtOtherContactMethod.ClientID %>').css('display', 'inline');

            }
            else {

                $('#<%=txtOtherContactMethod.ClientID %>').val(other);
                $('#<%=lblOtherContactMethod.ClientID %>').css('display', 'none');
                $('#<%=txtOtherContactMethod.ClientID %>').css('display', 'none');
            }
        }



        /*
        Created By: Santosh Maurya
        Date:04/22/2013
        Purpose:Show proper message when 'Is primary Contact Person' ckeckbox clicked   
        */

        function CheckPPerson() {
            if (document.getElementById('<%=hdnExistsContactPID.ClientID %>').value != "-1") {    //if primary person exists  with respect to current needy.

                // if current person is primary person
                if ((document.getElementById('<%=hdnExistsContactPID.ClientID %>').value == document.getElementById('<%=hdnCPID.ClientID %>').value) && document.getElementById("<%=chkIsPrimaryContactPesron.ClientID %>").checked == false) {
                    var isYes = confirm("Are you sure you want to make this person as other contact person?");
                    if (!isYes)
                        document.getElementById("<%=chkIsPrimaryContactPesron.ClientID %>").checked = true;
                }
                // if current person is not primary person but checked on primary person ckeckbox (although already primary person exists)
                else if ((document.getElementById('<%=hdnExistsContactPID.ClientID %>').value != document.getElementById('<%=hdnCPID.ClientID %>').value) && document.getElementById("<%=chkIsPrimaryContactPesron.ClientID %>").checked == true) {
                    var isYes = confirm("Primary contact person already exists. Are you sure you want to make this person as primary contact person?");
                    if (!isYes)

                        document.getElementById("<%=chkIsPrimaryContactPesron.ClientID %>").checked = false;

                }
                // add new contact person and  checked on primary person ckeckbox (although already primary person exists)
                else if (document.getElementById("<%=chkIsPrimaryContactPesron.ClientID %>").checked == true) {

                    var isYes = confirm("Primary contact person already exists. Are you sure you want to make this person as primary contact person?");
                    if (!isYes)
                        document.getElementById("<%=chkIsPrimaryContactPesron.ClientID %>").checked = false;
                }
            }
        }

        /* 
         Created By: santosh Maurya
         Date:04/23/2013
         Purpose:Aafter partial page post back call jquery tablesorter again to sort  gridview
         */

        function pageLoad(sender, args) {

            //Added By KP on 4th June 2020(SOW-577), Sets up the multicolumn autocomplete widget.
            $('#<%=txtOtherContactType.ClientID %>').mcautocomplete({
                // These next two options are what this plugin adds to the autocomplete widget.
                showHeader: true,
                columns: [{ name: 'ID', minWidth: '20px', display: 'none' }, { name: 'Contact Info', minWidth: '130px', display: 'block' }, { name: 'Agency Name', minWidth: '160px', display: 'block' },
                { name: 'Contact Name', minWidth: '130px', display: 'block' }, { name: 'Phone Number', minWidth: '100px', display: 'block' }, { name: 'Email', minWidth: '130px', display: 'block' }],
                // Event handler for when a list item is selected.
                select: function (event, ui) {
                    //this.value = (ui.item ? ui.item[1] : '');
                    if (ui.item) {
                        this.value = ui.item[1];
                        fillSelectedContactInfo(ui.item[0], ui.item[1], ui.item[2], ui.item[3], ui.item[4], ui.item[5], 'false');
                    }
                    return false;
                },
                // The rest of the options are for configuring the ajax webservice call.
                minLength: 1,
                source: function (request, response) {
                    var result = '';
                    if (ContactInfoJSON != '') {
                        var jsonObj = [];
                        $.each(ContactInfoJSON, function (key, value) {
                            //debugger;
                            if (value.ContactInfo.toLowerCase().indexOf($('#<%=txtOtherContactType.ClientID %>').val().trim().toLowerCase()) != -1) {
                                var jsonObj2 = [value.ReferringAgencyDetailID, value.ContactInfo, value.AgencyName, value.ContactName, value.PhoneNumber, value.Email];
                                jsonObj.push(jsonObj2);
                            }
                        });
                        //response(ContactInfoJSON);
                        result = jsonObj;
                    }
                    response(result);
                }
            });


            //Added by KP on 24th Jan 2020(SOW-577), To bind the Contact Info grid table.
            $('.inputSearchIcon').click(function () {
                BindContactInfo($('#<%=txtOtherContactType.ClientID %>').val().trim());
            });

            if (args.get_isPartialLoad()) {

                try {
                    $("#grdContactDetails").tablesorter(
                        {
                            headers: {
                                0: { sorter: false },
                                5: { sorter: false },
                                6: { sorter: false },
                                7: { sorter: false },
                                8: { sorter: false }
                            }

                        });
                } catch (err) { }
                //  BindRefBYToAgency();
                try { BindCallHistory(); HideShow('MainContent_ChkContactPreferenceInPersonOther', 'MainContent_txtContactPreferenceInPersonOther'); } catch (err) { }

                //           $("#gridHistory").tablesorter({
                //                headers:
                //                         {
                //                             4: { sorter: false },
                //                              sortList: [[1, 1]]
                //                         }
                //             }); 

                try { DisplayName(); } catch (err) { }
                try {
                    $('#chkIsPrimaryContactPesron').change(function () {
                        CheckPPerson();
                    });
                } catch (err) { }

                try {
                    //DisabilityCheck();
                    CheckYes();
                    CheckNo();
                    CheckUnknown();
                    ShowOther();
                    NumericRestriction($('#<%= txtCZip.ClientID %>'));
                    NumericRestriction($('#<%= txtNZip.ClientID %>'));
                    NumericRestriction($('#<%= txtAssetAmount.ClientID %>'));
                    NumericRestriction($('#<%= txtTotalHouseholdIncome.ClientID %>'));
                    NumericRestriction($('#<%= txtSpouse.ClientID %>'));
                    NumericRestriction($('#<%= txtClient.ClientID %>'));
                    CallMultiFunctions();

                    ReBindServReqOnPostBack();
                } catch (err) { }

            }

            //Added By KP on 6th Jan 2020(SOW-577), After page postback, hide/show the div, label etc.
            try {
                //debugger;
                var IsNew = '<%=IsNew %>';
                var ContactPersonCount = parseInt(document.getElementById("<%=hdnContactPersonCount.ClientID %>").value);
                var divContact = document.getElementById("<%=divContact.ClientID %>");
                var hyprAddContact = document.getElementById("<%=hyprAddContact.ClientID %>");
                var ItemText = $("#<%=ddlContactType.ClientID %> option:selected").text();

                // if old person and contactType is  'Self' then hide contact person dropdown
                if (ItemText == 'Self' && IsNew == "0") {
                    divContact.style.display = "block";
                    hyprAddContact.style.display = "none";
                    $('#<%=lblContactPerson.ClientID %>').css('display', 'none');
                    $('#<%=ddlContactPerson.ClientID %>').css('display', 'none');
                    $('#<%=lblRelationLabel.ClientID %>').css('display', 'inline');
                    $("span[id$='lblRelationship']").text('Self');
                }
                // if old person and contactType is  not  'Self' then show contact person dropdown
                else if (IsNew == '0' && ItemText != 'Self') {
                    hyprAddContact.style.display = "block";
                    divContact.style.display = "block";
                }

                //Hide/Show the Contact Type info and Referring Agency Details section.
                if (IsContacTypeForReferringAgency())//For Professional, Other, Proxy and Family
                {
                    $('#<%=lblOtherContacType.ClientID %>').css('display', 'inline');
                    $('#<%=txtOtherContactType.ClientID %>').css('display', 'inline');
                    $('#<%=refringAgencyDiv.ClientID %>').css('display', 'block');
                    $('#<%=lblOtherContacType.ClientID %>').html(($("#<%=ddlContactType.ClientID %> option:selected").text()) + ' Info');
                    $('#<%=inputSearchSpan.ClientID %>').css('display', 'inline');
                    LoadContactInfoJSON();
                }
                else {
                    $('#<%=txtOtherContactType.ClientID %>').val('');
                    $('#<%=lblOtherContacType.ClientID %>').css('display', 'none');
                    $('#<%=txtOtherContactType.ClientID %>').css('display', 'none');
                    $('#<%=refringAgencyDiv.ClientID %>').css('display', 'none');
                    $('#<%=inputSearchSpan.ClientID %>').css('display', 'none');

                }
            } catch (err) { }
            //End(SOW-577)

        }



        function ismaxlengthTxtBox(obj, mlength) {
            if (obj.value.length > mlength)
                obj.value = obj.value.substring(0, mlength)
        }


        var IsDataModified = 0;
        function CheckControlValueChange() {

            if (IsDataModified == 0)
                IsDataModified = 1;

        }


        // Create By: Santosh Maurya
        // Purpose: Display alert message if user has change records and going to navigate without save them.
        //function closeIt() {
        //    if ((IsDataModified == 1 && window.isSessionPopupOpen == false) && isServiceProviderPopupOpen == 0) {
        //        return "Data has been modified. Stay on this tab? All the changes will be lost if you click Ok."
        //    }
        //    else {
        //        true;
        //    }
        //}

        //Created By: Santosh Maurya
        // Date:21/08/2013
        // Purpose: Select followup tab when select from followup
        function ActiveTab() {

            var FlwpUpActive = document.getElementById('<%=hdnFlwpSelected.ClientID %>').value;
            var IsUpdateCall = document.getElementById('<%=hdnUpdateCall.ClientID %>').value;

            if (FlwpUpActive == "1") {
                // add  and Remove service buttion shuld not be disabled when search in update call mode
                if (IsUpdateCall == "0") {
                    $('#btnAdd').attr("disabled", true);
                    $('#btnRemove').attr("disabled", true);
                    $('#chkList').attr("disabled", true);
                    $('#chkReferredtoServiceProvider').attr("disabled", true);
                }
                getFollowupList();
            }
            else {

                $('#btnAdd').attr("disabled", false);
                $('#btnRemove').attr("disabled", false);
                $('#chkList').attr("disabled", false);
                $('#chkReferredtoServiceProvider').attr("disabled", false);
                $("#tblFollowupList").hide();
                $("#divFollowupList").hide();

            }
        }

        // bind city county for Needy person 
        function BindNDCityCounty() {
            var zipValue;
            zipValue = $('#<%=txtNZip.ClientID %>').val();
            $(".autocmplt").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        url: "NeedyPerson.aspx/GetCityCountyByZip",
                        headers: { 'X-Requested-With': 'XMLHttpRequest' },
                        data: "{'strZipCode':'" + zipValue + "'}",
                        contentType: "application/json",
                        dataType: "json",
                        success: function (data) {
                            response(data.d);
                        }
                    });
                },
                select: function (event, ui) {
                    var substr = ui.item.value.split('---');
                    $('#<%=txtNZip.ClientID %>').val('');
                    $('#<%=txtNZip.ClientID %>').val(substr[0]);

                    var comboCity = $find('<%=cmbNCity.ClientID%>');
                    comboCity.get_textBoxControl().value = substr[1];

                    var comboCounty = $find('<%=cmbNCounty.ClientID%>');
                    comboCounty.get_textBoxControl().value = substr[2];

                    $('#<%=hdnNdCity.ClientID %>').val(substr[1]);
                    $('#<%=hdnNdCounty.ClientID %>').val(substr[2]);
                    $('#<%=hdnIsTakeNDCityFromHidden.ClientID %>').val('1');
                    $('#<%=hdnIsTakeNDCountyFromHidden.ClientID %>').val('1');
                    return false;

                }
            });
        }


        // Bind city  county for Contact person
        function BindCPCityCounty() {
            var zipValue;
            zipValue = $('#<%=txtCZip.ClientID %>').val();
            $(".autocmplt").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        url: "NeedyPerson.aspx/GetCityCountyByZip",
                        headers: { 'X-Requested-With': 'XMLHttpRequest' },
                        data: "{'strZipCode':'" + zipValue + "'}",
                        contentType: "application/json",
                        dataType: "json",
                        success: function (data) {
                            response(data.d);

                        }
                    });
                },
                select: function (event, ui) {
                    var substr = ui.item.value.split('---');
                    $('#<%=txtCZip.ClientID %>').val('');
                    $('#<%=txtCZip.ClientID %>').val(substr[0]);

                    var comboCity = $find('<%=cmbCCity.ClientID%>');
                    comboCity.get_textBoxControl().value = substr[1];
                    var comboCounty = $find('<%=cmbCCounty.ClientID%>');
                    comboCounty.get_textBoxControl().value = substr[2];
                    $('#<%=cmbCCity.ClientID %>').val(substr[1]);
                    $('#<%=cmbCCounty.ClientID %>').val(substr[2]);

                    $('#<%=hdnCCity.ClientID %>').val(substr[1]);
                    $('#<%=hdnCCounty.ClientID %>').val(substr[2]);

                    $('#<%=hdnIsTakeCPCityFromHidden.ClientID %>').val('1');
                    $('#<%=hdnIsTakeCPCountyFromHidden.ClientID %>').val('1');
                    return false;
                    //you can select here any control value i.e.$("#ContentPlaceHolder1_hdnSmart").val("Yes");
                }
            });

        }

        //Created By santosh Maurya
        function SetFlageForCityCounty(controltype) {
            // set flage for  Needy Person County & City 
            if (controltype == 'NdCity')
                $('#<%=hdnIsTakeNDCityFromHidden.ClientID %>').val('0');
            if (controltype == 'NdCounty')
                $('#<%=hdnIsTakeNDCountyFromHidden.ClientID %>').val('0');

            // set flage for  contact Person  County & City 

            if (controltype == 'CPCity')
                $('#<%=hdnIsTakeCPCityFromHidden.ClientID %>').val('0');
            if (controltype == 'CPCounty')
                $('#<%=hdnIsTakeCPCountyFromHidden.ClientID %>').val('0');

        }


        function getFollowupList() {
            $.ajax({
                type: "POST",
                url: "NeedyPerson.aspx/GetFollowupList",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                data: "{'callHistoryID':'" + <%=CallHistoryID %> +"'}",
                contentType: "application/json",
                dataType: "json",
                success: function (data) {

                    if (data.d.length > 0) {
                        $("#divFollowupList").show();
                        $('#lblFollowupCount').html('Total number of follow-up calls: ' + data.d.length);
                        $('#tblFollowupList').show();
                        $('#tblFollowupList').tablesorter();
                        $('#tblFollowupList tbody').empty();

                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 == 0) {
                                $("#tblFollowupList").append("<tr  class='gridview_rowstyle' valign='top' id=" + data.d[i].FollowupID + "><td align='left' nowrap='nowrap'>" + data.d[i].ContactDateTime + "</td> <td  nowrap='nowrap' align='centre'>" + data.d[i].CallDuration + " </td> <td nowrap='nowrap'>" + data.d[i].FollowupCreatedBy + "</td></tr>");
                            }
                            else {
                                $("#tblFollowupList").append("<tr  class='gridview_alternaterow' valign='top' id=" + data.d[i].FollowupID + " ><td align='left' nowrap='nowrap'>" + data.d[i].ContactDateTime + "</td> <td nowrap='nowrap' align='centre'>" + data.d[i].CallDuration + " </td><td nowrap='nowrap'>" + data.d[i].FollowupCreatedBy + "</td></tr>");
                            }
                        }
                        $('.tablesorter').trigger('update');
                    }
                    else {
                        $("#divFollowupList").hide();
                        $('#tblFollowupList').hide();

                    }

                }
            });

        }
        
        function DisplayName() {
            var fname = $('#<%=txtNFName.ClientID %>').val();
            var MName = $('#<%=txtNMi.ClientID %>').val();
            var LName = $('#<%=txtNLName.ClientID %>').val();
            var FullName = fname + ' ' + MName + ' ' + LName;


            //Added by PC on 19 May 2022, Purpose: Cross-site scripting(reflected)- solution apply for QA test
            $('#lblFirstLastName').text('');
            $('#lblFirstLastName').text(FullName);
            //End

            //$('#lblFirstLastName').html('');
            //$('#lblFirstLastName').html(FullName);


        }

        ///********************************************************* Get Agency Search Result By Service Providers ************************************************///
        var isServiceProviderPopupOpen = 0;//Flag to handle window close message  that should not appear when clicked on Export to Excel or Doc or print Buttion        
        function GetServiceProviderAgency() {


            var SelectedServiceID = document.getElementById('<%= hdnServReq.ClientID %>').value;
            if (SelectedServiceID == "") {

                alert('Please select service.');
                return false;

            }
    
            $("#divTableDataHolder").hide();
            $("#divButton").hide();
            $("#tempid").show();
            $("#lblAgencyCount").html("");
            var AgencyLink = '';
            $.ajax({
                type: "POST",
                url: "NeedyPerson.aspx/GetServiceProviderAgency",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                data: "{'strServiceId':'" + SelectedServiceID + "'}",
                contentType: "application/json",
                dataType: "json",
                success: function (data) {

                    var Result = JSON.parse(data.d);

                    if (Result.length > 0) {
                        $("#lblAgencyCount").html("Total number of Agency :" + Result.length);
                        $("#tblAgencyDetails").show();
                        $('#tblAgencyDetails tbody').empty();

                        for (var i = 0; i < Result.length; i++) {

                            var ShowonMap = "";

                            var Showlink = "http://maps.google.com/?q=" + Result[i].AddressLine1 + " +" + Result[i].City + " +" + Result[i].State + " +" + Result[i].Zip;
                            ShowonMap = "<br/><a  href='" + Showlink + "' target='_blank' >Show on Map</a>";


                            WebAddressLink = '';
                            if (Result[i].WebAddress != '')
                                WebAddressLink = "<br/>Website:<a  href=" + Result[i].WebAddress + "  target='_blank' >" + Result[i].WebAddress + "</a>";

                            var EmailLink = "";

                            if (Result[i].GenEmailAddress != '')
                                EmailLink = "<br/>Email:" + Result[i].GenEmailAddress;


                            if (i % 2 == 0) {
                                $("#tblAgencyDetails").append("<tr  class='gridview_rowstyle' valign='top' ><td align='left'>" + Result[i].SiteName + "</td>  <td align='left' nowrap='nowrap'>" + Result[i].AgencyServices + "</td><td  nowrap='nowrap' align='centre'>" + Result[i].AddressLine1 + ", " + Result[i].AddressLine2 + "<br/>" + Result[i].City + ", " + Result[i].State + ", " + Result[i].Zip + " " + ShowonMap + " </td> <td  style='word-break:break-all;word-wrap:break-word'>" + Result[i].Contact.toString() + "" + EmailLink + "" + WebAddressLink + "&nbsp;</td></tr>");
                            }
                            else {
                                $("#tblAgencyDetails").append("<tr  class='gridview_alternaterow' valign='top' ><td align='left'>" + Result[i].SiteName + "</td> <td align='left' nowrap='nowrap'>" + Result[i].AgencyServices + "</td><td  nowrap='nowrap' align='centre'>" + Result[i].AddressLine1 + ", " + Result[i].AddressLine2 + "<br/>" + Result[i].City + ", " + Result[i].State + ", " + Result[i].Zip + " " + ShowonMap + " </td> <td style='word-break:break-all;word-wrap:break-word'>" + Result[i].Contact.toString() + "" + EmailLink + "" + WebAddressLink + "&nbsp;</td></tr>");
                            }
                        }

                        $("#tempid").hide();
                        $("#divTableDataHolder").show();
                        $("#divButton").show();
                    }
                    else {
                        $("#tempid").hide();
                        $('#tblAgencyDetails').hide();
                        $("#lblAgencyCount").html("No record found.");
                    }

                },
                error: function (thrownError) {
                    alert(thrownError.value);

                }

            });


            ShowHideProviderPopup();
        }


        // Created By: Santosh Maurya
        // Date: 10 april 2014
        // Purpose:O Service provider Popup 
        function ShowHideProviderPopup() {
            var divpnlContact = document.getElementById("<%=divpnlContactCP.ClientID %>");
            var showHideDiv = document.getElementById("<%=showHideDivCP.ClientID %>");
            var divPopUpContent = document.getElementById("<%=divPopUpContentCP.ClientID %>");
            var divpopupHeading = document.getElementById("<%=divpopupHeadingCP.ClientID %>");
            var btnClose = document.getElementById("<%=btnCloseCP.ClientID %>");
            if (divpnlContact.style.display == "block") {
                showHideDiv.className = "";
                divPopUpContent.className = "";
                divpnlContact.style.display = "none";
                btnClose.style.display = "none";
                divpopupHeading.style.display = "none";

                isServiceProviderPopupOpen = 0;
                $('#tblAgencyDetails tbody').empty();
                $("#lblAgencyCount").html("");

            }
            else {
                isServiceProviderPopupOpen = 1;
                showHideDiv.className = "main_popup_moreHistory ";
                divPopUpContent.className = "popup_moreHistory ";


                divpnlContact.style.display = "block";
                btnClose.style.display = "block";
                divpopupHeading.style.display = "block";

            }
        }

        //Created By: Santosh Maurya
        // Date: 11 April 2014
        // Purpose:Export To Excel file
        function ExportToExcel() {
            var serviceID = document.getElementById('<%= hdnServReq.ClientID %>').value;
            //Added by PC on 13 Sep 2022, Purpose: Cross-site scripting(DOM-based) 
            $.ajax({
                type: "POST",
                url: "NeedyPerson.aspx/GetExportFormString",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                data: "{'serviceID':'" + serviceID + "','exportType':'" + 0 + "'}",
                contentType: "application/json",
                dataType: "json",
                success: function (data) {
                    $('body').prepend(data.d);
                    $('#tempForm').submit();
                    $("tempForm").remove();
                }
            });
            //End
           
            //$('body').prepend("<form method='post' action='exportPage.aspx' style='top:-3333333333px;' id='tempForm'><input type='hidden' name='serviceID' value='" + serviceID + "' ><input type='hidden' name='ExportType' value='0' ></form>");
            //$('#tempForm').submit();
            //$("tempForm").remove();
            return false;

            //    window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('#divTableDataHolder').html())); // or
            //    var url='data:application/vnd.ms-excel,' + encodeURIComponent($('#divTableDataHolder').html()); 
            //    location.href=url;
            //    return false;

            // by passing DIV HTML Data through hidden field. This logic din not used  because  hidden field have fixed sized.
            //        var data = $("#divTableDataHolder").html();
            //        data = escape(data);
            //        $('body').prepend("<form method='post' action='exportPage.aspx' style='top:-3333333333px;' id='tempForm'><input type='hidden' name='data' value='" + data + "' ><input type='hidden' name='ExportType' value='0' ></form>");
            //        $('#tempForm').submit();
            //        $("tempForm").remove();
            //       return false;

        }

        //Created By: Santosh Maurya
        // Date: 11 April 2014
        // Purpose:Export To MSWord Document file
        function ExportToDoc() {
            var serviceID = document.getElementById('<%= hdnServReq.ClientID %>').value;
            //$('body').prepend("<form method='post' action='exportPage.aspx' style='top:-3333333333px;' id='tempForm'><input type='hidden' name='serviceID' value='" + serviceID + "' ><input type='hidden' name='ExportType' value='1' ></form>");
            //$('#tempForm').submit();
            //$("tempForm").remove();
            //Added by PC on 13 Sep 2022, Purpose: Cross-site scripting(DOM-based) 
            $.ajax({
                type: "POST",
                url: "NeedyPerson.aspx/GetExportFormString",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                data: "{'serviceID':'" + serviceID + "','exportType':'" + 1 + "'}",
                contentType: "application/json",
                dataType: "json",
                success: function (data) {
                    $('body').prepend(data.d);
                    $('#tempForm').submit();
                    $("tempForm").remove();
                }
            });
            //End
            return false;
        }

        //Created By: Santosh Maurya
        // Date: 09 April 2014
        // Purpose: Print  Html table data 
        function PrintFile() {
            var disp_setting = "toolbar=yes,location=no,directories=yes,menubar=yes,";
            disp_setting += "scrollbars=yes,width=900px, height=780px, left=100, top=25";

            var docprint = window.open("about:blank", "_blank", disp_setting);
            var oTable = document.getElementById("tblAgencyDetails");
            var rowCount = 0;
            rowCount = $("#tblAgencyDetails tr").length;

            docprint.document.open();
            docprint.document.write('<html><head><title>Service provider</title>');
            docprint.document.write('</head><body><center>');
            docprint.document.write('<table> <tr> <td >');
            docprint.document.write('<label>Total number of Agency: </label>' + (rowCount - 1));
            docprint.document.write('</td> </tr>  </table>');
            docprint.document.write(oTable.parentNode.innerHTML);
            docprint.document.write('</center></body></html>');
            docprint.document.close();
            docprint.print();
            docprint.close();
        }

        // ========================================== Send Email Section==========================================//
        //Created By: Santosh Maurya
        // Date: 09 April 2014
        // Purpose: Send Email With attachment 
        function OpenEmailPopup() {
            var serviceID = document.getElementById('<%= hdnServReq.ClientID %>').value;

            ShowHideProviderPopup();
            window.open("SendEmail.aspx?serviceID=" + serviceID + "", "PopupWindow", "width=600,height=400,scrollbars=yes,resizable=no");
        }

        function OpenRefEmailPopup() {

            //ShowHideProviderPopup();
            window.open("SendRefEmail.aspx", "PopupWindow", "width=600,height=400,scrollbars=yes,resizable=no");
        }

        function OpenDocumentPopup(url) {
            if (!myAjaxHandler()) {
                window.open("" + url + "", "PopupWindow", "width=600,height=500,scrollbars=yes,resizable=no");
            }            
        }



        function MutExChkList(chk) {
            var chkList = chk.parentNode.parentNode.parentNode;
            var chks = chkList.getElementsByTagName("input");
            for (var i = 0; i < chks.length; i++) {
                if (chks[i] != chk && chk.checked) {
                    chks[i].checked = false;
                }
            }
        }
        //Author: Kuldeep Rathore
        //Date:05/12/2015
        //Purpose: Show, Hide TextBox on checked & unchecked Others CheckBox In Contact Person respectively.
        function HideShow(chkId, othertextid) {
            document.getElementById(othertextid).style.display = "none";
            //

            if (document.getElementById(chkId).checked) {
                document.getElementById(othertextid).style.display = "inline";
            }
            else
                document.getElementById(othertextid).value = "";


        }
        //Author: Kuldeep Rathore
        //Date:08/19/2015
        //Purpose: Show, Hide TextBox on checked & unchecked chkreferredforoc.
        function ShowHideReferredforOCDate(chkid) {

            if (document.getElementById(chkid).checked) {
                document.getElementById('<%=referredforocdate.ClientID%>').style.display = "inline";

            }
            else {
                document.getElementById('<%=referredforocdate.ClientID%>').style.display = "none";

                document.getElementById('<%=txtreferredforocdate.ClientID %>').value = '';
            }

        }

        //Added by:BS 
        //Added Date:14-Sep-2016
        //Purpose:To allow only integer 0-9 and remove the highlighted color
        $(document).ready(function () {
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(ValidateExtn);
            // Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EnableDisableTextFundProvided);
            //  EnableDisableTextFundProvided();//Commented By:BS on 6-Feb-2017 Task ID-10142
            ValidateExtn();
            validateFundProvided();
            EnableDisablechkFundUtilized();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(validateFundProvided);
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EnableDisablechkFundUtilized);

        });


        //Added by:BS 
        //Added Date:14-Sep-2016
        //Purpose:To allow only integer 0-9 and remove the highlighted color
        function ValidateExtn() {
            var keyDown = false, ctrl = 17, vKey = 86, Vkey = 118;

            $(document).keydown(function (e) {
                if (e.keyCode == ctrl) keyDown = true;
            }).keyup(function (e) {
                if (e.keyCode == ctrl) keyDown = false;
            });

            $('.Number').on('keypress', function (e) {
                if (!e) var e = window.event;
                if (e.keyCode > 0 && e.which == 0) return true;
                if (e.keyCode) code = e.keyCode;
                else if (e.which) code = e.which;
                var character = String.fromCharCode(code);
                if (character == '\b' || character == ' ' || character == '\t') return true;
                if (keyDown && (code == vKey || code == Vkey)) return (character);
                else return (/[0-9]$/.test(character));
            }).on('focusout', function (e) {
                var $this = $(this);
                $this.val($this.val().replace(/[^0-9]/g, ''));
            }).on('paste', function (e) {
                var $this = $(this);
                setTimeout(function () {
                    $this.val($this.val().replace(/[^0-9]/g, ''));
                }, 5);
            });

            $(".Number").keyup(function (e) {
                var PressedTxtBoxID = $(this).attr('id');
                if ($(this).val().length >= 2 || $(this).val().length == 0) {
                    $(this).css("background-color", "white");
                    $(this).css("border", "1px solid #707070");
                }

            });


        }

        //Added By KR on 21 March 2017.
        function EnableDisableTextFundProvided() {
            var chkFundID = document.getElementById('<%=chkFundProvided.ClientID%>');
            var txtFundID = document.getElementById('<%=txtFundProvided.ClientID%>');
            var txttxtFundsUtilizedDateID = document.getElementById('<%=txtFundsUtilizedDate.ClientID%>');
            var chkBoxFundsUtilizedList = document.getElementById('<%=chklistFundsUtilized.ClientID%>');
            var chkBoxFundsUtilizedCount = chkBoxFundsUtilizedList.getElementsByTagName("input");
            var split_str = document.getElementById('<%=hdnFundsUtilized.ClientID%>').value.split(",");

            if (chkFundID.checked) {
                for (var i = 0; i < chkBoxFundsUtilizedCount.length; i++) {
                    chkBoxFundsUtilizedCount[i].disabled = false;
                    if (split_str.indexOf(chkBoxFundsUtilizedCount[i].value) !== -1) {
                        chkBoxFundsUtilizedCount[i].checked = true;
                    }
                }
                txtFundID.disabled = false;
                txttxtFundsUtilizedDateID.disabled = false;
                txtFundID.value = document.getElementById('<%=hdnFundProvided.ClientID%>').value;
                txttxtFundsUtilizedDateID.value = document.getElementById('<%=hdnFundsUtilizedDate.ClientID%>').value;

                // Added by GK on 25June,2021 : TicketID #2419
                EnableDisableTextFundProvidedOther();

                return false;
            }
            else {
                for (var i = 0; i < chkBoxFundsUtilizedCount.length; i++) {
                    chkBoxFundsUtilizedCount[i].disabled = true;
                    chkBoxFundsUtilizedCount[i].checked = false;
                }
                txtFundID.value = "";
                txttxtFundsUtilizedDateID.value = "";
                txtFundID.disabled = true;
                txttxtFundsUtilizedDateID.disabled = true;

                // Added by GK on 25June,2021 : TicketID #2419
                var txtFundsOther = document.getElementById('<%=txtFundsUtilizedForOther.ClientID%>');
                txtFundsOther.disabled = true;
                txtFundsOther.value = "";
            }
        }

        function EnableDisableTextFundProvidedOther() {
            var chkFundID = document.getElementById('<%=chkFundProvided.ClientID%>');
            var chkBoxFundsUtilizedList = document.getElementById('<%=chklistFundsUtilized.ClientID%>');
            var txtFundsOther = document.getElementById('<%=txtFundsUtilizedForOther.ClientID%>');

            if (chkFundID.checked) {
                var checkBoxes = chkBoxFundsUtilizedList.getElementsByTagName("INPUT");
                for (var i = 0; i < checkBoxes.length; i++) {
                    if (checkBoxes[i].parentNode.getElementsByTagName("LABEL")[0].innerHTML == "Other") {
                        if (checkBoxes[i].checked) {
                            txtFundsOther.disabled = false;
                            txtFundsOther.value = document.getElementById('<%=hdnFundsUtilizedForOther.ClientID%>').value;
                        }
                        else {
                            txtFundsOther.disabled = true;
                            txtFundsOther.value = "";
                        }
                    }
                }

            }
        }

        function validateFundProvided() {
            $("#<%=txtFundProvided.ClientID%>").CommonValidator({

            });
        }

        function EnableDisablechkFundUtilized() {
            var chkFundID = document.getElementById('<%=chkFundProvided.ClientID%>');
            var chkBoxFundsUtilizedList = document.getElementById('<%=chklistFundsUtilized.ClientID%>');
            var chkBoxFundsUtilizedCount = chkBoxFundsUtilizedList.getElementsByTagName("input");
            if (chkFundID.checked) {
                for (var i = 0; i < chkBoxFundsUtilizedCount.length; i++) {
                    chkBoxFundsUtilizedCount[i].disabled = false;
                }
            }
            else {
                for (var i = 0; i < chkBoxFundsUtilizedCount.length; i++) {
                    chkBoxFundsUtilizedCount[i].disabled = true;
                }
            }
        }



        function ValidateFundsUtilizedDate(obj) {
            if (!ValidateDate(obj.id)) {
                return false;
            }
        }

        function ValidateNeedyDOBDate(obj) {
            if (!ValidateDate(obj.id)) {
                document.getElementById(obj.id).value = "__/__/____";
                document.getElementById(obj.id).focus();
                return false;
            } else
                return true;
        }

        //Created By:BS
        //Created On:10-May-2018
        //Purpose:check if fund provided date is changed
        function CheckDateChanged(btn) {
            var DateFundUtilized = document.getElementById('<%= txtFundsUtilizedDate.ClientID %>').value.trim();

            var hdnDateFundUtilized = document.getElementById('<%= hdnFundsUtilizedDate.ClientID %>').value;
            if (DateFundUtilized != "" && DateFundUtilized != '__/__/____' && hdnDateFundUtilized != "") {
                if (DateFundUtilized != hdnDateFundUtilized) {
                    ShowConfirmationBox(2, 'Are you sure you want to change the Funds Provided Date?');
                }
                else {
                    document.getElementById("<%=hdnFundsUtilizedDate.ClientID %>").value = document.getElementById("<%=txtFundsUtilizedDate.ClientID %>").value.trim();

                    if (btn != 'onSave')//Added by vk on 08 aug,2018.
                        $("[id*=btnUpdate]").click();
                }

            }
            else {
                document.getElementById("<%=hdnFundsUtilizedDate.ClientID %>").value = document.getElementById("<%=txtFundsUtilizedDate.ClientID %>").value.trim();
                if (btn != 'onSave')//Added by vk on 08 aug,2018.
                    $("[id*=btnUpdate]").click();
            }

        }
        //Created By KP on 23rd Dec 2019(SOW-577)
        //Purpose: check and return as true, if ContactType is selected as Caregiver, Professional, Proxy, Family, or Other.
        function IsContacTypeForReferringAgency() {
            var ItemVal = $("#<%=ddlContactType.ClientID %> option:selected").val()
            if (ItemVal == '2' || ItemVal == '3' || ItemVal == '4' || ItemVal == '5' || ItemVal == '6')
                return true;
            else
                return false;
        }
        //Created By KP on 23rd Dec 2019(SOW-577)
        //Purpose: Validate email
        function ValidateEmail(txtEmailID) {
            var emailReg = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            if (txtEmailID.val().trim() != '' && !emailReg.test(txtEmailID.val().trim())) {
                alert('Invalid Email ID of Referring Agency.');
                txtEmailID.focus();
                return false;
            }
            return true;
        }
        //Created By KP on 23rd Dec 2019(SOW-577)
        //Purpose: Validate phone
        function ValidatePhone(txtPhoneNumber) {
            var phoneReg = /^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/;
            if (txtPhoneNumber.val().trim() != '' && txtPhoneNumber.val().trim() != '(___)___-____' && !txtPhoneNumber.val().trim().match(phoneReg)) {
                alert('Invalid Phone Number of Referring Agency.');
                txtPhoneNumber.focus();
                return false;
            }
            return true;
        }
        //Created By KP on 23rd Dec 2019(SOW-577)
        //Purpose: Validate Phone and Email from Referring Agency grid on Update action.
        function ValidateRefAgencyFields(lnkUpdate) {
            //Find the GridView Row using the LinkButton reference.
            var row = $(lnkUpdate).closest("tr");

            var txtPhoneNumber = row.find("[id*=txtPhoneNumber]");
            var txtEmail = row.find("[id*=txtEmail]");

            if (!ValidatePhone(txtPhoneNumber)) {
                return false;
            }
            else if (!ValidateEmail(txtEmail)) {
                return false;
            }
            ShowLoader();
            return true;
        }

        ////Created By KP on 22nd Jan 2020(SOW-577)
        ////Purpose: Get Conatct info list.
        //function GetContactInfo(id,e) {
        //    var code = e.which; // recommended to use e.which, it's normalized across browsers
        //    if (code == 13) //If enter key is pressed.
        //    {
        //        //e.preventDefault();
        //        BindContactInfo(document.getElementById(id.id).value.trim());
        //    }
        //} 


        //Created By KP on 22nd Jan 2020(SOW-577)
        //Purpose: Get Conatct info list and bind it to grid table.
        function BindContactInfo(ContactInfo) {
            $('#ContactTypeResultsTable tbody').empty();

            //if (ContactInfo != "") {//Commented by KP on 1st June 2020(SOW-577), Allow to get all contactInfo when contactInfo is blank.
            var obj = {};
            obj.ContactInfo = ContactInfo;
            obj.ContactTypeID = parseInt($("#<%=ddlContactType.ClientID %> option:selected").val());
            obj.NeedyPersonID = <%=NeedyID %>;

            $.ajax({
                type: "POST",
                url: "NeedyPerson.aspx/GetContactInfo",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var contactInfos = response.d;
                    if (contactInfos == "") {
                        $("#ContactTypeResultsTable").hide();
                        $('#lblNoRecordContactInfo').html('No record found.');
                    }
                    else {
                        $("#ContactTypeResultsTable").show();
                        $('#lblNoRecordContactInfo').html('');
                        $.each(contactInfos, function (index, contactInfo) {
                            var strPro = String(contactInfo).split('|~|');

                            $("#ContactTypeResultsTable").append(
                                "<tr onclick=\"fillSelectedContactInfo('" + strPro[0] + "','" + strPro[1] + "','" + strPro[2] + "','" + strPro[3] + "','" + strPro[4] + "','" + strPro[5] + "','" + 'true' + "');\" >" +
                                "<td  valign='top' style='word-break:break-all;word-wrap:break-word' width=\"24%\">" + strPro[1] + "</td><td  valign='top' style='word-break:break-all;word-wrap:break-word' width=\"24%\">" + strPro[2] + "</td>" +
                                "<td  valign='top' style='word-break:break-all;word-wrap:break-word' width=\"20%\">" + strPro[3] + "</td><td  valign='top' width=\"12%\">" + strPro[4] + "</td>" +
                                "<td valign='top' style='word-break:break-all;word-wrap:break-word' width=\"20%\">" + strPro[5] + "</td></tr>"
                            );

                        });
                    }
                },
                error: function (xhr, errorType, exception) {
                    var responseText;
                    var erromessage;
                    try {
                        responseText = jQuery.parseJSON(xhr.responseText);
                        erromessage = "" + errorType + " " + exception + "" + "Exception :" + responseText.ExceptionType + "Message:" + responseText.Message;
                        alert(erromessage);
                    }
                    catch (e) {

                    }
                }
            });
            ShowHideContactInfoPopup();
            //}
        }
        //Created By KP on 22nd Jan 2020(SOW-577)
        //Purpose: Set fileds of Referring Agency Details section.
        function fillSelectedContactInfo(RefDetailID, ContactInfo, AgencyName, ContactName, PhoneNumber, Email, displayPop) {
            //alert(RefDetailID + ':' + ContactInfo);  
            $('#<%=hdnSelectedRefDetailID.ClientID %>').val(RefDetailID);
            $('#<%=txtOtherContactType.ClientID %>').val(ContactInfo);
            $('#<%=txtRefAgencyName.ClientID %>').val(AgencyName);
            $('#<%=txtRefContactName.ClientID %>').val(ContactName);
            $('#<%=txtRefPhoneNumber.ClientID %>').val(PhoneNumber);
            $('#<%=txtRefEmailID.ClientID %>').val(Email);
            if (displayPop == 'true')
                ShowHideContactInfoPopup();
        }
        //Created By KP on 22nd Jan 2020(SOW-577)
        //Purpose: Show/Hide ContactInfo popup
        function ShowHideContactInfoPopup() {
            var divpnContactInfo = document.getElementById("<%=divpnContactInfo.ClientID %>");
            var divContactInfoParent = document.getElementById("<%=divContactInfoParent.ClientID %>");
            var divPopUpContactInfo = document.getElementById("<%=divPopUpContactInfo.ClientID %>");
            var divpopupHeadingContactInfo = document.getElementById("<%=divpopupHeadingContactInfo.ClientID %>");
            var btnClose = document.getElementById("<%=btnCloseContactInfo.ClientID %>");
            if (divpnContactInfo.style.display == "block") {
                divContactInfoParent.className = "";
                divPopUpContactInfo.className = "";
                divpnContactInfo.style.display = "none";
                btnClose.style.display = "none";
                divpopupHeadingContactInfo.style.display = "none";
            }
            else {
                divContactInfoParent.className = "main_popup_moreHistory ";
                divPopUpContactInfo.className = "popup_moreHistory ";
                divpnContactInfo.style.display = "block";
                btnClose.style.display = "block";
                divpopupHeadingContactInfo.style.display = "block";
                btnClose.focus();
            }
        }
        function openContactPopup() {
            var divpnlContact = document.getElementById("<%=divpnlContact.ClientID %>");
            var rwContactSave = document.getElementById("<%=rwContactSave.ClientID %>");
            var showHideDiv = document.getElementById("<%=showHideDiv.ClientID %>");
            var divPopUpContent = document.getElementById("<%=divPopUpContent.ClientID %>");
            var divpopupHeading = document.getElementById("<%=divpopupHeading.ClientID %>");
            var btnClose = document.getElementById("<%=btnClose.ClientID %>");

            divpnlContact.style.width = "98.5%";
            divpopupHeading.style.width = "99%";
            showHideDiv.className = "main_popup";
            divPopUpContent.className = "popup";
            divpnlContact.style.display = "block";
            rwContactSave.style.display = "block";
            divpopupHeading.style.display = "block";
            btnClose.style.display = "block";
        }
        //Created By KP on 5th March 2020(SOW-577)
        //Purpose: Clear the Referring Agency Details and Contact Info fields
        function ClearRefAgency() {
            $('#<%=hdnSelectedRefDetailID.ClientID %>').val('-1');//-1 value is used for new entry
            $('#<%=txtOtherContactType.ClientID %>').val('');
            $('#<%=txtRefAgencyName.ClientID %>').val('');
            $('#<%=txtRefContactName.ClientID %>').val('');
            $('#<%=txtRefPhoneNumber.ClientID %>').val('');
            $('#<%=txtRefEmailID.ClientID %>').val('');
        }
        //Created By KP on 5th March 2020(SOW-577)
        //Purpose: If Referring Agency Details and Contact Info fields are empty then set hdnSelectedRefDetailID by -1(create a new ref. agency).
        function ValidateRefFieldsOnClear() {
            if ($('#<%=txtOtherContactType.ClientID %>').val().trim() == ''
                && $('#<%=txtRefAgencyName.ClientID %>').val().trim() == ''
                && $('#<%=txtRefContactName.ClientID %>').val().trim() == ''
                && ($('#<%=txtRefPhoneNumber.ClientID %>').val().trim() == '' || $('#<%=txtRefPhoneNumber.ClientID %>').val().trim() == '(___)___-____')
                && $('#<%=txtRefEmailID.ClientID %>').val().trim() == '') {
                $('#<%=hdnSelectedRefDetailID.ClientID %>').val('-1');//-1 value is used for new entry

            }
        }
    </script>
    <script type="text/javascript">




        //Created By KP on 4th June 2020(SOW-577), Load ContactInfo JSON format data into global variable whenever ContactType selection is changed.
        function LoadContactInfoJSON() {
            var obj = {};
            obj.ContactInfo = "";
            obj.ContactTypeID = parseInt($("#<%=ddlContactType.ClientID %> option:selected").val());
            obj.NeedyPersonID = <%=NeedyID %>;

            $.ajax({
                type: "POST",
                url: "NeedyPerson.aspx/GetContactInfoJSON",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify(obj),
                //async: false,
                success: function (data) {
                    var result = '';
                    if (!data || data.length === 0 || !data.d || data.d.length === 0) {
                        //result = [{ label: 'No match found.' }];
                        result = '';
                    } else {
                        result = JSON.parse(data.d);
                    }
                    ContactInfoJSON = result;
                },
                error: function (xhr, errorType, exception) {
                    var responseText;
                    var erromessage;
                    try {
                        responseText = jQuery.parseJSON(xhr.responseText);
                        erromessage = "" + errorType + " " + exception + "" + "Exception :" + responseText.ExceptionType + "Message:" + responseText.Message;
                        alert(erromessage);
                    }
                    catch (e) {
                    }
                }
            });
        }

        //Added by KP on 5th Sep 2023(T20745), Display Loader
        function ShowLoader() {              
            $("#divLoading").show();
        }

        //Added by KP on 5th Sep 2023(T20745), Hide Loader
        function HideLoader() {
            $("#divLoading").hide();
        }

        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(HideLoader);//Added by KP on 5th Sep 2023(T20745), Hide Loader at the end of request.

        ////Added by KP on 5th Sep 2023(T20745), Hide Loader at the end of request.
        //document.onreadystatechange = () => {          
        //    if (document.readyState === 'complete') {//Alternative to load event
        //        HideLoader();               
        //    }
        //}
        
    </script>

    <div id="divLoading" style="display: none;">        
        <div class="loader_bg">
        </div>
        <div class="preloader">
            <p>
                Please wait...
            </p>
        </div>
     </div>

    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="true"
        ShowSummary="false" ValidationGroup="ND" />
    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="true"
        ShowSummary="false" ValidationGroup="CD" />
    <asp:HiddenField ID="hdnTimerLimit" runat="server" />
    <asp:UpdatePanel ID="upPnlMain" runat="server" UpdateMode="Conditional">
        <ContentTemplate>


            <%--Added by KP on 8th Sep 2020(TaskID:19505), after partial postback from Contact Person Details, 
                avoid to generate click event for image button, whenever enter key is pressed in input control.--%>
            <asp:ImageButton ID="imgStopPostback" AlternateText="." ImageUrl="~/images/01.png" runat="server" OnClientClick="return false;" Width="0px" Height="0px" Style="color: white;" />

            <div class="form_block" style="padding: 2px 10px;">
                <table border="0" cellpadding="0" cellspacing="0" width="100%" class="table_space">
                    <tr>
                        <td nowrap="nowrap" width="15%">
                            <label>
                                Person ID:</label>
                            <asp:Label ID="lblPersonIdValue" runat="server"></asp:Label>
                        </td>
                        <td colspan="2" nowrap="nowrap" width="30%">
                            <label>
                                Contact ID:</label>
                            <asp:Label ID="lblContactIdValue" runat="server"></asp:Label>
                        </td>
                        <td nowrap="nowrap" width="20%">
                            <label>
                                Last Call On:</label>
                            <asp:Label ID="lblLastCallValue" runat="Server"></asp:Label>
                        </td>
                        <td nowrap="nowrap" width="20%">
                            <label>
                                Last Call By:</label>
                            <asp:Label ID="lblLastCallBy" runat="Server"></asp:Label>
                        </td>
                        <td nowrap="nowrap" width="15%" align="left">
                            <fieldset>
                                <legend style="font-weight: bold; font-size: 80%;">Call Purpose</legend>
                                <div style="text-align: center">
                                    <asp:CheckBox ID="chkInfoOnly" Text="Info Only" runat="server" />
                                    <asp:CheckBox ID="chkADRC" Text="ADRC" runat="server" />
                                </div>
                            </fieldset>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>Date of Contact <span style="color: red">*</span></label>
                            <asp:TextBox ID="txtCDoC" class="dob_ctrl" runat="server" MaxLength="10"></asp:TextBox>
                            <ajax:CalendarExtender ID="txtCDoC_CalendarExtender" runat="server" CssClass="req"
                                Enabled="True" TargetControlID="txtCDoC"></ajax:CalendarExtender>
                            <ajax:MaskedEditExtender ID="txtCDoC_MaskedEditExtender" runat="server" MaskType="date"
                                Mask="99/99/9999" TargetControlID="txtCDoC"></ajax:MaskedEditExtender>
                            <asp:RequiredFieldValidator ID="ReqDOC" runat="server" ControlToValidate="txtCDoC"
                                Display="None" ValidationGroup="ND" ErrorMessage="Please Enter Date of contact"
                                ForeColor="Red" CssClass="req"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="cmpValDoC" runat="server" ValueToCompare="1/1/1900" Display="None"
                                ValidationGroup="ND" Type="date" Operator="GreaterThanEqual" ErrorMessage="Date should be greater than or equal to 1/1/1900 and format should be mm/dd/yyyy"
                                ControlToValidate="txtCDoC" CssClass="req"></asp:CompareValidator>
                            <asp:RangeValidator ID="rngeDoC" runat="server" ControlToValidate="txtCDoC" ValidationGroup="ND"
                                ErrorMessage="Date of contact can not be future date." Display="None" SetFocusOnError="true"
                                Type="Date"></asp:RangeValidator>
                        </td>
                        <td>
                            <label>
                                Contact Type
                            </label>
                            <asp:DropDownList ID="ddlContactType" runat="server" CssClass="city_ctrl">
                            </asp:DropDownList>
                            <%--   <asp:RequiredFieldValidator ID="reqContactType" runat="server" EnableClientScript="true"
                                SetFocusOnError="true" InitialValue="-1" ErrorMessage="Please Select Contact Type."
                                ForeColor="Red" ControlToValidate="ddlContactType" Display="None" ValidationGroup="ND"></asp:RequiredFieldValidator>--%>
                        </td>
                        <td>
                            <label id="lblContactPerson" runat="server">
                                Contact Person</label>
                            <asp:DropDownList ID="ddlContactPerson" runat="server" CssClass="city_ctrl">
                            </asp:DropDownList>
                            <asp:HiddenField ID="hdnRelationshipValue" runat="server" />
                        </td>
                        <td colspan="2">
                            <label id="lblRelationLabel" runat="server">
                                Relationship :
                            </label>
                            <asp:Label ID="lblRelationship" runat="server"></asp:Label>
                            <asp:HiddenField ID="hdnGetRelationship" runat="server" />
                        </td>
                        <td align="right">
                            <label>
                                Contact Method</label>
                            <asp:DropDownList ID="ddlContactMethod" runat="server" CssClass="city_ctrl" Width="75px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td align="left" colspan="2">
                            <div style="padding: 0 11px 0 0;">
                                <label id="lblOtherContacType" runat="server">Other</label>
                                <asp:TextBox ID="txtOtherContactType" runat="server" MaxLength="100" Width="63%"
                                    onchange="ValidateRefFieldsOnClear();"></asp:TextBox>
                                <span id="inputSearchSpan" runat="server" class="inputSearchIcon">
                                    <img src="images/search-icon.png" alt="Search" />
                                </span>
                                <%--onkeyup="GetContactInfo(this,event);"--%>
                            </div>
                        </td>
                        <td colspan="2"></td>
                        <td align="right">
                            <label id="lblOtherContactMethod" runat="server">
                                Other</label>
                            <asp:TextBox ID="txtOtherContactMethod" runat="server" MaxLength="25"></asp:TextBox>
                            <asp:HiddenField ID="hdnCMethodOther" runat="server" />
                        </td>
                    </tr>
                </table>
            </div>

            <!--Refring Agency div-->
            <div id="refringAgencyDiv" runat="server" style="display: none;">
                <asp:HiddenField ID="hdnSelectedRefDetailID" runat="server" />

                <div class="form_heading" style="position: relative; top: 0px; left: 0px; width: 97.5%;">
                    Referring Agency Details
                </div>
                <div id="divPopUpRefAgency" style="background: #f2f2e6; display: table; width: 100%; margin-bottom: 7px;">
                    <%--<div class="form_block" id="innerDivRefAgency" runat="server" style="width: 100%; float: left;">--%>
                    <div style="width: 100%; float: left; background: #fff !important; clear: both; padding: 4px; padding-left: 19px">
                        <div style="width: auto; float: left; margin: 3px">
                            <label>Agency Name</label>
                            <asp:TextBox ID="txtRefAgencyName" runat="server" Width="200px" MaxLength="200" CssClass="fname_ctrl"
                                AutoCompleteType="Disabled" onchange="ValidateRefFieldsOnClear();"></asp:TextBox>
                        </div>
                        <div style="width: auto; float: left; margin: 3px">
                            <label>Contact Name</label>
                            <asp:TextBox ID="txtRefContactName" runat="server" MaxLength="100" CssClass="address_ctrl"
                                Width="150px" AutoCompleteType="Disabled" onchange="ValidateRefFieldsOnClear();"></asp:TextBox>

                        </div>
                        <div style="width: auto; float: left; margin: 3px">
                            <label>Phone Number</label>
                            <asp:TextBox ID="txtRefPhoneNumber" Width="150px" runat="server" CssClass="phone_ctrl"
                                MaxLength="13" autocomplete="off" onchange="ValidateRefFieldsOnClear();"></asp:TextBox>
                            <ajax:MaskedEditExtender ID="MaskedEditExtender9" runat="server"
                                TargetControlID="txtRefPhoneNumber"
                                MaskType="None" Mask="(999)999-9999" MessageValidatorTip="true"
                                ClearMaskOnLostFocus="false"
                                InputDirection="LeftToRight" ErrorTooltipEnabled="True"></ajax:MaskedEditExtender>

                        </div>

                        <div style="width: auto; float: left; margin: 3px">
                            <label>Email ID</label>
                            <asp:TextBox ID="txtRefEmailID" runat="server" MaxLength="100" CssClass="email_ctrl"
                                Width="200px" AutoCompleteType="Disabled" onchange="ValidateRefFieldsOnClear();"></asp:TextBox>
                        </div>
                        <div style="width: auto; float: left; margin: 3px">
                            <a style="color: blue; text-decoration: underline; cursor: pointer; font-size: 85%" onclick="ClearRefAgency();">Clear Referring Details</a>
                        </div>


                    </div>
                    <%--</div>--%>
                </div>
                <div style="width: 97.5%; margin: auto; border-bottom: 1px solid #999"></div>
            </div>
            <!-- End Refring Agency div-->

            <div class="form_heading contactAdd" runat="server" id="divContact">
                Contact Person Details <a href="javascript:void(0);" class="add_link" onclick="return showHide();"
                    id="hyprAddContact" runat="server">Add Contact</a>
                <asp:HiddenField ID="hdnAddcontact" runat="server" />
            </div>
            <div id="showHideDiv" runat="server" style="z-index: 99 !important;">
                <div id="divPopUpContent" runat="server" style="background: #fff; display: table;">
                    <input id="btnClose" type="button" value="" runat="server" class="close"
                        onclick="return showHide();"
                        style="display: none" />
                    <div id="divpopupHeading" style="display: none;" class="popup_form_heading"
                        runat="server">
                        Contact Person Details
                    </div>
                    <div class="form_block" id="divpnlContact" runat="server" style="width: 100%; float: left;">
                        <div style="width: 100%; float: left; background: #fff !important; clear: both; padding: 4px;">
                            <div style="width: auto; float: left; margin: 3px">
                                <label>
                                    Name (F/M/L)</label>
                                <asp:TextBox ID="txtCFirstName" runat="server" Width="75px"
                                    MaxLength="50" CssClass="fname_ctrl"
                                    AutoCompleteType="Disabled"></asp:TextBox>
                                <asp:TextBox ID="txtCMI" runat="server" Width="34px" MaxLength="10"
                                    CssClass="mname_ctrl" AutoCompleteType="Disabled"></asp:TextBox>
                                <asp:TextBox ID="txtCLastName" runat="server" Width="75px"
                                    MaxLength="50" CssClass="lname_ctrl"
                                    AutoCompleteType="Disabled"></asp:TextBox>
                            </div>
                            <div style="width: auto; float: left; margin: 3px">
                                <label>
                                    Phone-Pri</label>
                                <asp:TextBox ID="txtCPhonePrimary" runat="server" MaxLength="13"
                                    CssClass="phone_ctrl" Width="100px"
                                    AutoCompleteType="Disabled"></asp:TextBox><%--onblur="ClearPhoneFormat(this);"--%>
                                <ajax:MaskedEditExtender ID="MaskedEditExtender1" runat="server"
                                    TargetControlID="txtCPhonePrimary"
                                    BehaviorID="MEE" MaskType="None" Mask="(999)999-9999"
                                    MessageValidatorTip="true"
                                    ClearMaskOnLostFocus="false" InputDirection="LeftToRight"
                                    ErrorTooltipEnabled="True"></ajax:MaskedEditExtender>
                                <ajax:MaskedEditValidator ID="MaskedEditValidator1" runat="server"
                                    ControlToValidate="txtCPhonePrimary"
                                    ValidationGroup="CD" ControlExtender="MaskedEditExtender1"
                                    Display="None" ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}"
                                    IsValidEmpty="false" InvalidValueMessage="Invalid contact person phone-primary number."
                                    InitialValue="(___)___-____"
                                    ForeColor="Red"></ajax:MaskedEditValidator>
                            </div>
                            <div style="width: auto; float: left; margin: 3px">
                                <label>Extn</label>
                                <asp:TextBox ID="txtcPhonePrimaryExtn" Width="65" runat="server"
                                    MaxLength="8" CssClass="Number" onDrag="return false" onDrop="return false"
                                    autocomplete="off"></asp:TextBox>
                            </div>
                            <div style="width: auto; float: left; margin: 3px">
                                <label>
                                    Phone-Alt</label>
                                <asp:TextBox ID="txtCPhoneAlt" runat="server" MaxLength="13"
                                    CssClass="phone_ctrl" Width="100px"
                                    AutoCompleteType="Disabled"></asp:TextBox><%--onblur="ClearPhoneFormat(this);"--%>
                                <ajax:MaskedEditExtender ID="MaskedEditExtender2" runat="server"
                                    TargetControlID="txtCPhoneAlt"
                                    MaskType="None" Mask="(999)999-9999" MessageValidatorTip="true"
                                    ClearMaskOnLostFocus="false"
                                    InputDirection="LeftToRight" ErrorTooltipEnabled="True"></ajax:MaskedEditExtender>
                                <ajax:MaskedEditValidator ID="MaskedEditValidator2" runat="server"
                                    ControlToValidate="txtCPhoneAlt"
                                    ValidationGroup="CD" ControlExtender="MaskedEditExtender1"
                                    Display="None" ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}"
                                    IsValidEmpty="false" InvalidValueMessage="Invalid contact person Phone-Alt number."
                                    InitialValue="(___)___-____"
                                    ForeColor="Red"></ajax:MaskedEditValidator>
                            </div>
                            <div style="width: auto; float: left; margin: 3px">
                                <label>Extn</label>
                                <asp:TextBox ID="txtCPhoneAltExtn" runat="server" CssClass="Number"
                                    Width="65px" MaxLength="8" onDrag="return false" onDrop="return false"
                                    autocomplete="off"></asp:TextBox>
                            </div>
                            <div style="width: auto; float: left; margin: 3px">
                                <label>
                                    Fax</label>
                                <asp:TextBox ID="txtCFax" runat="server" MaxLength="13" Width="100px"
                                    AutoCompleteType="Disabled"></asp:TextBox><%--onblur="ClearPhoneFormat(this);"--%>
                                <ajax:MaskedEditExtender ID="MaskedEditExtender8" runat="server"
                                    TargetControlID="txtCFax"
                                    MaskType="None" Mask="(999)999-9999" MessageValidatorTip="true"
                                    ClearMaskOnLostFocus="false"
                                    InputDirection="LeftToRight" ErrorTooltipEnabled="True"></ajax:MaskedEditExtender>
                                <ajax:MaskedEditValidator ID="MaskedEditValidator6" runat="server"
                                    ControlToValidate="txtCFax"
                                    ValidationGroup="CD" ControlExtender="MaskedEditExtender1"
                                    Display="None" ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}"
                                    IsValidEmpty="false" InvalidValueMessage="Invalid contact person details Fax number."
                                    InitialValue="(___)___-____"
                                    ForeColor="Red"></ajax:MaskedEditValidator>
                            </div>

                            <div style="width: auto; float: left; margin: 3px">
                                <label>
                                    Email ID</label>
                                <asp:TextBox ID="txtCEmail" runat="server" MaxLength="50"
                                    Width="280px" CssClass="email_ctrl" AutoCompleteType="Disabled"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="regCEmail" runat="server"
                                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                    ControlToValidate="txtCEmail" ErrorMessage="Invalid email id of contact person "
                                    ValidationGroup="CD" Display="None">  
                                </asp:RegularExpressionValidator>
                            </div>
                            <div style="width: auto; float: left; margin: 3px">
                                <label>
                                    Address</label>
                                <asp:TextBox ID="txtCAddress" runat="server" MaxLength="300"
                                    CssClass="address_ctrl"
                                    AutoCompleteType="Disabled" Width="230px"></asp:TextBox>
                            </div>
                            <div style="width: auto; float: left; margin: 3px">
                                <label>
                                    Zip</label>
                                <asp:TextBox ID="txtCZip" class="zip_ctrl" Width="50" runat="server"
                                    MaxLength="5"
                                    CssClass="autocmplt" onkeydown="OnlyNumeric();"
                                    onkeyup="BindCPCityCounty();"></asp:TextBox>
                            </div>
                            <div style="width: auto; float: left; margin: -2px 3px 5px 3px">
                                <label>
                                    City</label>
                                <span class="ul-dropdown">
                                    <ajax:ComboBox ID="cmbCCity" runat="server"
                                        AutoCompleteMode="SuggestAppend" MaxLength="50"
                                        DropDownStyle="Simple" CssClass="postion-over" Width="225px">
                                    </ajax:ComboBox>
                                    <asp:HiddenField ID="hdnCCity" runat="server" />
                                    <asp:HiddenField ID="hdnIsTakeCPCityFromHidden" runat="server" />
                                </span>
                            </div>
                            <div style="width: auto; float: left; margin: -2px 3px 5px 3px">
                                <label>
                                    County</label>
                                <span class="ul-dropdown">
                                    <ajax:ComboBox ID="cmbCCounty" runat="server" MaxLength="25"
                                        CssClass="postion-over"
                                        DropDownStyle="Simple" AutoCompleteMode="SuggestAppend"
                                        Width="125">
                                    </ajax:ComboBox>
                                    <asp:HiddenField ID="hdnCCounty" runat="server" />
                                    <asp:HiddenField ID="hdnIsTakeCPCountyFromHidden" runat="server" />
                                </span>
                            </div>
                            <div style="width: auto; float: left; margin: 3px 3px 5px">
                                <label>
                                    State</label>
                                <asp:TextBox ID="txtCState" runat="server" CssClass="state_ctrl"
                                    Text="MI" AutoCompleteType="Disabled"></asp:TextBox>
                            </div>
                            <div style="width: 100%; float: left">
                                <table style="width: auto; float: left">
                                    <tr id="Tr1" runat="server" valign="top">
                                        <td valign="top" style="padding-top: 4px">
                                            <div style="width: auto; float: left; margin: 3px; vertical-align: top">

                                                <asp:CheckBox ID="chkIsPrimaryContactPesron"
                                                    runat="server" Text=" Is Primary Contact Person"
                                                    ClientIDMode="Static" />
                                                <asp:HiddenField ID="hdnExistsContactPID"
                                                    runat="server" />
                                                <asp:HiddenField ID="hdnCPID" runat="server" />
                                            </div>
                                            <div style="width: auto; float: left; margin: 3px; width: 250px">
                                                <label>
                                                    Relationship</label>
                                                <asp:TextBox ID="txtRelationship" runat="server"
                                                    MaxLength="50" CssClass="address_ctrl"
                                                    AutoCompleteType="Disabled"> </asp:TextBox>
                                            </div>
                                        </td>

                                        <td>
                                            <fieldset>
                                                <label>
                                                    Preferred Method of Contact</label>
                                                <span>
                                                    <asp:CheckBox ID="chkCPhone" Text=" Phone " CssClass=""
                                                        runat="server" />
                                                    <asp:CheckBox ID="chkCEmail" Text=" Email " CssClass=""
                                                        runat="server" />
                                                    <asp:CheckBox ID="ChkCSMS" Text=" SMS Text " CssClass=""
                                                        runat="server" />
                                                    <asp:CheckBox ID="ChkCMail" Text=" Mail " CssClass=""
                                                        runat="server" />
                                                    <!-- Added by kuldeep rathore on 12th May, 2015 -->
                                                    <asp:CheckBox ID="ChkContactPreferenceInPersonOther" Text=" Other "
                                                        CssClass="" runat="server" onchange="javascript:HideShow('MainContent_ChkContactPreferenceInPersonOther','MainContent_txtContactPreferenceInPersonOther');" />

                                                    <asp:TextBox ID="txtContactPreferenceInPersonOther"
                                                        runat="server" MaxLength="30" Style="display: none;"></asp:TextBox>
                                                    <!-- Added section ends here by Kuldeep Rathore -->
                                                </span>
                                            </fieldset>
                                        </td>
                                    </tr>
                                </table>
                            </div>

                            <div style="width: auto; float: left; margin: 3px">
                            </div>
                            <div style="width: auto; float: left; margin: 3px">
                            </div>
                            <div style="width: 100%; margin: 3px; float: left">
                                <div id="rwContactSave" runat="server" align="center">
                                    <input id="btnContactCancel" type="button" value="Cancel"
                                        class="btn_style" onclick="return showHide();" />
                                    <asp:Button ID="btnSaveContact" Text="Save" runat="server"
                                        CssClass="btn_style" OnClick="btnSaveContact_Click"
                                        OnClientClick="return ValidateCD();" />
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <asp:Panel ID="pnlContactPersonGrid" runat="server">
                <div class="form_block" style="padding-left: 0; padding-right: 0; width: 98%;">
                    <div class="grid_scroll" style="margin: -7px 0 0 0;">

                        <asp:GridView ID="grdContactDetails" runat="server" EmptyDataText="No Contact Person Found."
                            ClientIDMode="Static" EmptyDataRowStyle-HorizontalAlign="Center" AutoGenerateColumns="False"
                            Width="100%" AllowPaging="false" DataKeyNames="ContactPersonDetailID" CssClass="tablesorter contact_gridview"
                            OnRowDataBound="grdContactDetails_RowDataBound" OnRowCommand="grdContactDetails_RowCommand"
                            OnRowEditing="grdContactDetails_RowEditing">
                            <EmptyDataRowStyle HorizontalAlign="Center" />
                            <RowStyle CssClass="gridview_rowstyle" />
                            <AlternatingRowStyle CssClass="gridview_alternaterow" />
                            <HeaderStyle CssClass="hdr_style" />
                            <Columns>

                                <asp:TemplateField ItemStyle-VerticalAlign="Middle" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Image ID="imgPrimary" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%-- Commented by SA on 20th Aug, 2015. SOW-379 --%>
                                <%--<asp:BoundField DataField="Name" HeaderText="Name" HeaderStyle-HorizontalAlign="Center"
                                    ItemStyle-Width="14%" ItemStyle-VerticalAlign="Top" ItemStyle-CssClass="input_default "
                                    SortExpression="FirstName" />--%>
                                <%-- Below added first and last name as required = SA on 20th aug, SOW-379 --%>
                                <asp:BoundField DataField="FirstName" HeaderText="First Name" HeaderStyle-HorizontalAlign="Center"
                                    ItemStyle-Width="9%" ItemStyle-VerticalAlign="Top" ItemStyle-CssClass="input_default "
                                    SortExpression="FirstName" />
                                <asp:BoundField DataField="LastName" HeaderText="Last Name" HeaderStyle-HorizontalAlign="Center"
                                    ItemStyle-Width="11%" ItemStyle-VerticalAlign="Top" ItemStyle-CssClass="input_default "
                                    SortExpression="LastName" />

                                <asp:TemplateField ItemStyle-CssClass="input_default" HeaderText="Phone" HeaderStyle-HorizontalAlign="Center"
                                    ItemStyle-Width="10%" ItemStyle-VerticalAlign="Top">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPhoneprimary" Text='<%#Eval("PhonePrimary") %>' runat="server"></asp:Label><br />
                                        <asp:Label ID="lblPhoneAlt" Text='<%#Eval("PhoneAlt") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-CssClass="input_default" HeaderText="Fax" HeaderStyle-HorizontalAlign="Center"
                                    ItemStyle-Width="9%" ItemStyle-VerticalAlign="Top">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFax" Text='<%#Eval("Fax") %>' runat="server"></asp:Label><br />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Email" HeaderText="Email" HeaderStyle-HorizontalAlign="Center"
                                    ItemStyle-VerticalAlign="Top" ItemStyle-CssClass="input_default" ItemStyle-Width="18%"
                                    ItemStyle-HorizontalAlign="Left" />
                                <asp:TemplateField ItemStyle-CssClass="input_default" HeaderText="Address" HeaderStyle-HorizontalAlign="Center"
                                    ItemStyle-Width="17%" ItemStyle-VerticalAlign="Top" HeaderStyle-Width="17%">
                                    <ItemTemplate>
                                        <asp:Label ID="lblAddress" Text='<%# Eval("Address") + " " + Eval("CountyName") + " " + Eval("CityName") + " " + Eval("State") + " " + Eval("Zip")%>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-CssClass="input_default" HeaderText="Relationship" HeaderStyle-HorizontalAlign="Center"
                                    ItemStyle-Width="10%" ItemStyle-VerticalAlign="Top" HeaderStyle-Width="10%">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRel" Text='<%#Eval("Relationship") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Preferred Method of Contact" ItemStyle-Width="28%"
                                    ItemStyle-CssClass="label_normal" ItemStyle-VerticalAlign="Top" HeaderStyle-HorizontalAlign="Center"
                                    ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkPhone" runat="server" Text="Phone" Enabled="false" Checked='<%#Eval("IsContactPreferencePhone") %>' />
                                        <asp:CheckBox ID="chkEmail" runat="server" Text="Email" Enabled="false" Checked='<%#Eval("IsContactPreferenceEmail") %>' />
                                        <asp:CheckBox ID="chkSMS" runat="server" Text="SMS Text" Enabled="false" Checked='<%#Eval("IsContactPreferenceSMS") %>' />
                                        <asp:CheckBox ID="chkMail" runat="server" Text="Mail" Enabled="false" Checked='<%#Eval("IsContactPreferenceMail") %>' />

                                        <!-- Added by kuldeep rathore on 12th May, 2015 -->
                                        <asp:CheckBox ID="ChkContactOtherInPersonContact" runat="server" Text="Other" Enabled="false" Checked='<%#Eval("IsContactPreferenceOther") %>' />
                                        <!-- Added section ends here by Kuldeep Rathore -->


                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-VerticalAlign="Top" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>

                                        <asp:ImageButton ID="imgbtnEdit1" runat="server" ImageUrl="~/images/editicon.jpg" OnClientClick ="ShowLoader();"
                                            ImageAlign="Middle" ToolTip="Edit" CommandName="rowedit" CommandArgument='<%#Eval("ContactPersonDetailID") %>' />
                                        <%--<asp:LinkButton ID="imgbtnEdit1" CommandName="rowedit" runat="server" ToolTip="Edit" Text="Edit" 
                                            CommandArgument='<%#Eval("ContactPersonDetailID") %>'></asp:LinkButton>--%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-VerticalAlign="Top" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgbtnDelete" runat="server" ImageUrl="~/images/trash_can.gif"
                                            OnClientClick="var retVal = confirm('Are you sure you want to delete?'); if (retVal) ShowLoader(); return retVal"
                                            ImageAlign="Middle" ToolTip="Delete" CommandName="rowdelete" CommandArgument='<%#Eval("ContactPersonDetailID") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>

                            </Columns>
                        </asp:GridView>
                        <asp:HiddenField ID="hdnContactPersonCount" runat="server" Value="0" />

                    </div>
                </div>
            </asp:Panel>
            <div class="form_heading" style="height: 20px;">
                <span style="float: left;">Person Needing Assistance</span> <span style="float: right; margin: 0 5px 0 0;">
                    <label class="clock_label" title="Edit Call Duration text box for manual time entry">
                        Call Duration (hh:mm:ss)
                        <a onclick="PauseClock();" style="text-decoration: underline; color: blue; cursor: pointer;">Edit</a>
                    </label>
                    <asp:HiddenField ID="HidIsTimerPause" runat="server" />
                    <asp:HiddenField ID="HidIsManualCallDuration" runat="server" />
                    <asp:HiddenField ID="HidHoldDuration" runat="server" />
                    <asp:TextBox ID="txtCallDuration" CssClass="clock" runat="server" MaxLength="8" ValidationGroup="ND"
                        onblur="Javascript:RestoreClock();" autocomplete="off"></asp:TextBox><%--onclick="Javascript:StopClock();"--%>
                    <ajax:MaskedEditExtender ID="mskextimer" runat="server" InputDirection="LeftToRight"
                        Mask="99:99:99" MaskType="Time" UserTimeFormat="None" AutoComplete="False" AcceptAMPM="false"
                        TargetControlID="txtCallDuration"></ajax:MaskedEditExtender>
                    <%--ClearMaskOnLostFocus="false"--%>
                    <asp:RegularExpressionValidator ID="regtimeValidator" ValidationExpression="([0-1][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])"
                        runat="server" ErrorMessage="Invalid Call Duration." Display="None" ValidationGroup="ND"
                        ControlToValidate="txtCallDuration">                            
                    </asp:RegularExpressionValidator>
                </span>
            </div>
            <div style="margin-left: 10px;">
                <table width="98%" border="0" cellpadding="0" cellspacing="1" align="center">
                    <tr>
                        <td width="40%">
                            <label id="lblFirstLastName" style="font-size: 15px; font-family: Verdana; font-weight: 700;">
                            </label>
                        </td>
                        <td align="right" width="53%">
                            <label style="font-weight: bold; color: red;">
                                Quick Notes
                            </label>
                            <asp:TextBox ID="txtOtherNotes" runat="server" ValidateRequestMode="Disabled" Width="85%" MaxLength="100" Font-Bold="true" ForeColor="Red"></asp:TextBox>
                        </td>
                        <td align="right">
                            <label>
                                To-Do</label>
                            <img alt="To-Do" id="imgToDo" runat="server" src="~/images/ToDoFlag_White.png" onmousedown="javascript:SetToDoForCall(this);" />
                            <asp:HiddenField ID="hdnToDo" ClientIDMode="Static" runat="server" />
                        </td>
                    </tr>
                </table>
            </div>
            <div class="form_block">
                <ajax:TabContainer ID="NeedyPersonTab" runat="server" Width="100%" CssClass="fancy fancy-green"
                    ActiveTabIndex="0">
                    <ajax:TabPanel ID="tabPersonInfo" runat="server">
                        <HeaderTemplate>
                            Personal Information
                        
                        </HeaderTemplate>




                        <ContentTemplate>
                            <asp:Panel ID="pnl1" runat="server">
                                <div class="fieldset-box-first" style="width: 33%;">
                                    <fieldset>
                                        <legend>Personal Details </legend>
                                        <table width="98%">
                                            <tr>
                                                <td width="25%">
                                                    <label>First Name</label>
                                                </td>
                                                <td colspan="3">
                                                    <asp:TextBox ID="txtNFName" runat="server" MaxLength="50" CssClass="fname_ctrl" ValidationGroup="ND"
                                                        onkeyup="DisplayName()" onchange="DisplayName()" AutoCompleteType="Disabled"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>
                                                        Middle Name</label>
                                                </td>
                                                <td colspan="3">
                                                    <asp:TextBox ID="txtNMi" runat="server" MaxLength="10" CssClass="mname_ctrl" AutoCompleteType="Disabled"
                                                        onkeyup="DisplayName()"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>
                                                        Last Name</label>
                                                </td>
                                                <td colspan="3">
                                                    <asp:TextBox ID="txtNLName" runat="server" MaxLength="50" CssClass="lname_ctrl" AutoCompleteType="Disabled"
                                                        onkeyup="DisplayName()"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>Suffix</label>
                                                </td>
                                                <td colspan="3">
                                                    <ajax:ComboBox ID="cmbTitle" runat="server" AutoCompleteMode="SuggestAppend" CssClass="postion-over"
                                                        MaxLength="5" Width="50px" DropDownStyle="Simple">
                                                    </ajax:ComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>
                                                        Date of Birth</label>
                                                </td>
                                                <td colspan="3">
                                                    <asp:TextBox ID="txtNDOB" onblur="DateFormate()" autocomplete="off" CssClass="dob_ctrl" runat="server"
                                                        Width="75px" MaxLength="12"></asp:TextBox>
                                                    <ajax:CalendarExtender ID="calNDoB" runat="server" OnClientDateSelectionChanged="checkDate" TargetControlID="txtNDOB" CssClass="req" BehaviorID="_content_calNDoB"></ajax:CalendarExtender>
                                                    <ajax:MaskedEditExtender ID="mskcalNDoB" runat="server" MaskType="Date" Mask="99/99/9999"
                                                        TargetControlID="txtNDOB" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="" BehaviorID="_content_mskcalNDoB" Century="2000"></ajax:MaskedEditExtender>
                                                    <asp:CompareValidator ID="cmpNDOB" runat="server" ValueToCompare="1/1/1900" Display="None"
                                                        Type="Date" Operator="GreaterThanEqual" ErrorMessage="Date should be greater than or equal to 1/1/1900 and format should be mm/dd/yyyy"
                                                        ControlToValidate="txtNDOB" CssClass="req"></asp:CompareValidator><asp:RangeValidator
                                                            ID="rngeDOBValidator" runat="server" ControlToValidate="txtNDOB" ValidationGroup="ND"
                                                            ErrorMessage="Date of birth of person needing assistance can not be future date."
                                                            Display="None" SetFocusOnError="True" Type="Date"></asp:RangeValidator><label style="margin: 0 0 0 10px;">Age</label>
                                                    <asp:TextBox ID="txtNAge" CssClass="dob_ctrl Number" runat="server" MaxLength="3" Width="25px"
                                                        onkeydown="OnlyNumeric();"></asp:TextBox>
                                                    <asp:HiddenField ID="hdnAge" runat="server" />
                                                    <asp:HiddenField ID="hdnAgeOn" runat="server" />
                                                    <asp:HiddenField ID="hdnIsAgeOn" runat="server" Value="0" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>
                                                        Gender</label>
                                                </td>
                                                <td colspan="3">
                                                    <asp:DropDownList ID="ddlGender" runat="server" CssClass="gender_ctrl">
                                                        <asp:ListItem Text="--Select--" Value="-1"></asp:ListItem>
                                                        <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                                                        <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                                                        <asp:ListItem Text="Not Listed" Value="Not Listed"></asp:ListItem>
                                                        <asp:ListItem Text="Unknown" Value="Unknown"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td nowrap="nowrap">
                                                    <label>
                                                        Marital Status</label>
                                                </td>
                                                <td colspan="3">
                                                    <asp:DropDownList ID="ddlMaritalStatus" runat="server" CssClass="marital_ctrl" OnSelectedIndexChanged="ddlMaritalStatus_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </div>
                                <div class="fieldset-box-middle" style="width: 31%;">
                                    <fieldset>
                                        <legend>Contact Details </legend>
                                        <table width="98%">
                                            <tr>
                                                <td width="25%">
                                                    <label>
                                                        Phone-Primary</label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtNPhonePrime" runat="server" MaxLength="13" CssClass="phone_ctrl"
                                                        Width="80%"></asp:TextBox><ajax:MaskedEditExtender
                                                            ID="ndPriPhoneExt" runat="server" TargetControlID="txtNPhonePrime"
                                                            Mask="(999)999-9999" ClearMaskOnLostFocus="False" ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="" BehaviorID="_content_ndPriPhoneExt" Century="2000"></ajax:MaskedEditExtender>
                                                    <ajax:MaskedEditValidator ID="MaskedEditValidator3" runat="server" ControlToValidate="txtNPhonePrime"
                                                        ValidationGroup="ND" ControlExtender="ndPriPhoneExt" Display="None" ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}"
                                                        IsValidEmpty="False" InvalidValueMessage="Invalid Phone-Primary number of person needing assistance."
                                                        InitialValue="(___)___-____" ForeColor="Red" ErrorMessage="MaskedEditValidator3"></ajax:MaskedEditValidator>
                                                </td>
                                                <td>
                                                    <label style="float: right;">Extn</label>
                                                </td>
                                                <td style="text-align: right;">

                                                    <asp:TextBox ID="txtNPhonePrimeExtn" Width="65px" runat="server" MaxLength="8" CssClass="Number" onDrag="return false" onDrop="return false" autocomplete="off"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td nowrap="nowrap">
                                                    <label>
                                                        Phone-Alternate</label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtNPhonAlt" runat="server" MaxLength="13" CssClass="phone_ctrl"
                                                        Width="80%"></asp:TextBox>
                                                    <ajax:MaskedEditExtender
                                                        ID="mskNDAltPhoneExt" runat="server" TargetControlID="txtNPhonAlt"
                                                        Mask="(999)999-9999" ClearMaskOnLostFocus="False" ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="" BehaviorID="_content_mskNDAltPhoneExt" Century="2000"></ajax:MaskedEditExtender>
                                                    <ajax:MaskedEditValidator ID="MaskedEditValidator4" runat="server" ControlToValidate="txtNPhonAlt"
                                                        ValidationGroup="ND" ControlExtender="mskNDAltPhoneExt" Display="None" ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}"
                                                        IsValidEmpty="False" InvalidValueMessage="Invalid Phone-Alternate number of person needing assistance."
                                                        InitialValue="(___)___-____" ForeColor="Red" ErrorMessage="MaskedEditValidator4"></ajax:MaskedEditValidator>
                                                </td>
                                                <td>
                                                    <label style="float: right;">Extn</label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:TextBox ID="txtNPhoneAltExtn" Width="65px" runat="server" MaxLength="8" CssClass="Number" onDrag="return false" onDrop="return false" autocomplete="off"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td nowrap="nowrap">
                                                    <label>
                                                        Fax</label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtNPriFax" runat="server" MaxLength="13"
                                                        Width="80%"></asp:TextBox>
                                                    <ajax:MaskedEditExtender ID="mskNDFax" runat="server" TargetControlID="txtNPriFax" Mask="(999)999-9999" ClearMaskOnLostFocus="False" ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="" BehaviorID="_content_mskNDFax" Century="2000"></ajax:MaskedEditExtender>
                                                    <ajax:MaskedEditValidator ID="MaskedEditValidator7" runat="server" ControlToValidate="txtNPriFax"
                                                        ValidationGroup="ND" ControlExtender="mskNDFax" Display="None" ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}"
                                                        IsValidEmpty="False" InvalidValueMessage="Invalid Fax number of person needing assistance."
                                                        InitialValue="(___)___-____" ForeColor="Red" ErrorMessage="MaskedEditValidator7"></ajax:MaskedEditValidator>
                                                </td>

                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>
                                                        Email ID</label>
                                                </td>
                                                <td colspan="3">
                                                    <asp:TextBox ID="txtNEmail" runat="server" MaxLength="50" CssClass="email_ctrl emailsize"></asp:TextBox><asp:RegularExpressionValidator ID="regNEmail" runat="server"
                                                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txtNEmail"
                                                        ErrorMessage="Invalid email Id of person needing assistance. " ValidationGroup="ND"
                                                        Display="None"></asp:RegularExpressionValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4">
                                                    <label>
                                                        Preferred Method of Contact</label>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td colspan="4">
                                                    <div style="float: right; width: auto;">
                                                        <span style="width: auto; float: left; padding: 0 5px;">
                                                            <asp:CheckBox ID="chkNPhone" Text=" Phone " runat="server" /></span><span
                                                                style="width: auto; float: left; padding: 0 5px;">
                                                                <asp:CheckBox ID="chkNEmail" Text=" Email "
                                                                    runat="server" /></span>
                                                        <span style="width: auto; float: left; padding: 0 5px;">
                                                            <asp:CheckBox ID="chkNSMS" Text=" SMS Text" runat="server" /></span><span
                                                                style="width: auto; float: left; padding: 0 5px;"><asp:CheckBox ID="chkNMail" Text=" Mail "
                                                                    runat="server" /></span>
                                                    </div>

                                                </td>
                                            </tr>


                                        </table>
                                    </fieldset>
                                </div>
                                <div class="fieldset-box-middle fieldset-box-first" style="width: 33%">
                                    <fieldset>
                                        <legend>Alternate Contact Info</legend>
                                        <table width="98%">
                                            <tr>
                                                <td width="25%">
                                                    <label>
                                                        First Name</label>
                                                </td>
                                                <td colspan="3">
                                                    <asp:TextBox ID="txtAltFName" runat="server" MaxLength="50" CssClass="fname_ctrl"
                                                        ValidationGroup="ND" onkeyup="DisplayName()" AutoCompleteType="Disabled"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>
                                                        Middle Name</label>
                                                </td>
                                                <td colspan="3">
                                                    <asp:TextBox ID="txtAltMName" runat="server" MaxLength="10" CssClass="mname_ctrl"
                                                        AutoCompleteType="Disabled" onkeyup="DisplayName()"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>
                                                        Last Name</label>
                                                </td>
                                                <td colspan="3">
                                                    <asp:TextBox ID="txtAltLName" runat="server" MaxLength="50" CssClass="lname_ctrl"
                                                        AutoCompleteType="Disabled" onkeyup="DisplayName()"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="25%">
                                                    <label>
                                                        Phone</label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtAltPhone" runat="server" MaxLength="13" CssClass="phone_ctrl"
                                                        Width="80%"></asp:TextBox><ajax:MaskedEditExtender
                                                            ID="MaskedEditExtender3" runat="server" TargetControlID="txtAltPhone"
                                                            Mask="(999)999-9999" ClearMaskOnLostFocus="False" ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="" BehaviorID="_content_MaskedEditExtender3" Century="2000"></ajax:MaskedEditExtender>
                                                    <ajax:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlToValidate="txtAltPhone"
                                                        ValidationGroup="ND" ControlExtender="ndPriPhoneExt" Display="None" ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}"
                                                        IsValidEmpty="False" InvalidValueMessage="Invalid Phone number of person needing assistance."
                                                        InitialValue="(___)___-____" ForeColor="Red" ErrorMessage="MaskedEditValidator5"></ajax:MaskedEditValidator>
                                                </td>
                                                <td>
                                                    <label style="float: right;">Extn</label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:TextBox ID="txtAltPhoneExtn" Width="65px" runat="server" MaxLength="8" CssClass="Number" onDrag="return false" onDrop="return false" autocomplete="off"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="25%">
                                                    <label>
                                                        Fax</label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtNAltFax" runat="server" MaxLength="13" CssClass="phone_ctrl"
                                                        Width="80%"></asp:TextBox><ajax:MaskedEditExtender
                                                            ID="MaskedEditExtender5" runat="server" TargetControlID="txtNAltFax"
                                                            Mask="(999)999-9999" ClearMaskOnLostFocus="False" ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="" BehaviorID="_content_MaskedEditExtender5" Century="2000"></ajax:MaskedEditExtender>
                                                    <ajax:MaskedEditValidator ID="MaskedEditValidator8" runat="server" ControlToValidate="txtNAltFax"
                                                        ValidationGroup="ND" ControlExtender="ndPriPhoneExt" Display="None" ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}"
                                                        IsValidEmpty="False" InvalidValueMessage="Invalid Alternate Fax number of person needing assistance."
                                                        InitialValue="(___)___-____" ForeColor="Red" ErrorMessage="MaskedEditValidator5"></ajax:MaskedEditValidator>
                                                </td>

                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>
                                                        Email ID</label>
                                                </td>
                                                <td colspan="3">
                                                    <asp:TextBox ID="txtAltEmailID" runat="server" MaxLength="50" CssClass="email_ctrl"></asp:TextBox><asp:RegularExpressionValidator
                                                        ID="RegularExpressionValidator1" runat="server" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                        ControlToValidate="txtAltEmailID" ErrorMessage="Invalid email Id of person needing assistance. "
                                                        ValidationGroup="ND" Display="None"></asp:RegularExpressionValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>
                                                        Relationship</label>
                                                </td>
                                                <td colspan="3">
                                                    <asp:TextBox ID="txtAltRelationShip" runat="server" MaxLength="50" CssClass="mname_ctrl"
                                                        AutoCompleteType="Disabled"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </div>
                                <div class="clear_01">
                                </div>
                                <div class="fieldset-box-last" style="float: left; margin-right: 1%;">
                                    <fieldset>
                                        <legend>Other Details </legend>
                                        <div class="address-bar" style="min-height: 145px;">
                                            <table width="100%">
                                                <tr>
                                                    <td>
                                                        <label>No Demographics</label>
                                                    </td>
                                                    <td>
                                                        <asp:CheckBox ID="ChkNoDemographics" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label>
                                                            Race</label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlRace" runat="server" CssClass="race_ctrl" OnSelectedIndexChanged="ddlRace_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="15%">
                                                        <label style="padding-top: 10px">
                                                            Primary Language</label>
                                                    </td>
                                                    <td>
                                                        <ajax:ComboBox ID="cmbPrimaryLaguage" runat="server" AutoCompleteMode="SuggestAppend"
                                                            MaxLength="25" CssClass="postion-over" DropDownStyle="Simple" Width="93px">
                                                            <asp:ListItem Value="-1" Text="--Select/Type--"></asp:ListItem>
                                                            <asp:ListItem Value="0" Text="English"></asp:ListItem>
                                                            <asp:ListItem Value="1" Text="Spanish"></asp:ListItem>
                                                            <asp:ListItem Value="2" Text="Arabic"></asp:ListItem>
                                                        </ajax:ComboBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label>
                                                            Ethnicity</label>
                                                        <td>
                                                            <asp:DropDownList ID="ddlEthnicity" runat="server" CssClass="ethnicity_ctrl">
                                                            </asp:DropDownList>
                                                        </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label>
                                                            Veteran</label>
                                                    </td>
                                                    <td>
                                                        <span style="float: left;">
                                                            <asp:DropDownList ID="ddlVetApplicable" runat="server">
                                                                <asp:ListItem Value="0" Text="--Select--"></asp:ListItem>
                                                                <asp:ListItem Value="1" Text="No"></asp:ListItem>
                                                                <asp:ListItem Value="4" Text="Yes"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </span><span style="float: right">
                                                            <asp:DropDownList ID="ddlVetStatus" runat="server" CssClass="status_ctrl">
                                                            </asp:DropDownList>
                                                        </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td nowrap="nowrap">
                                                        <label>
                                                            Living Arrangement</label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlLivingArrangement" runat="server" CssClass="LivArr_ctrl">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label>
                                                            Disability</label>
                                                    </td>
                                                    <td>
                                                        <asp:CheckBox ID="chkDisabilityYes" runat="server" Text=" Yes "
                                                            onchange="return CheckYes()" /><asp:CheckBox ID="chkDisabilityNo" runat="server" onchange="return CheckNo()"
                                                                Text=" No " /><asp:CheckBox ID="chkDisabilityUnknown" onchange="return CheckUnknown()" runat="server" Text=" Unknown" />
                                                    </td>
                                                </tr>
                                                <tr id="trDisabilityTypes" runat="server">
                                                    <td runat="server">
                                                        <label>
                                                            Disability Types</label>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:DropDownList ID="ddlDisabilityTypes" runat="server">
                                                        </asp:DropDownList>

                                                        <asp:TextBox ID="txtOtherDisability" MaxLength="75" runat="server" Style="display: none;"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 22%">
                                                        <label>
                                                            Caregiver Status
                                                        </label>
                                                    </td>
                                                    <td>
                                                        <asp:CheckBox ID="chkCaregiverYes" runat="server" Text=" Yes" />
                                                        <ajax:MutuallyExclusiveCheckBoxExtender ID="MEtxtCaregiverYes" runat="server" TargetControlID="chkCaregiverYes"
                                                            Key="Caregiver" BehaviorID="_content_MEtxtCaregiverYes"></ajax:MutuallyExclusiveCheckBoxExtender>
                                                        <asp:CheckBox ID="chkCaregiverNo" runat="server" Text=" No" />
                                                        <ajax:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender7" runat="server"
                                                            TargetControlID="chkCaregiverNo" Key="Caregiver" BehaviorID="_content_MutuallyExclusiveCheckBoxExtender7"></ajax:MutuallyExclusiveCheckBoxExtender>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label>Custom Field</label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlCustomField" runat="server" Width="200px"></asp:DropDownList>
                                                        &nbsp;&nbsp;<a href="javascript:void(0);" onclick="ShowHideCustomField();">
                                                            <img src="images/admin.gif" alt="Click to manage options" runat="server" id="adminTwp" />&nbsp;&nbsp;</a></td>

                                                    <asp:HiddenField ID="hdnAddedCFCode" runat="server" />
                                                    <asp:HiddenField ID="hdnAddedCFName" runat="server" />
                                                    <asp:HiddenField ID="hdnDeletedCF" runat="server" />
                                                    <asp:HiddenField ID="hdnModifyCF" runat="server" />
                                                    <asp:HiddenField ID="hdnModifyCFText" runat="server" />
                                                </tr>
                                            </table>
                                            <div class="clear_01">
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                                <div style="float: left; width: 55%;">
                                    <fieldset>
                                        <legend>Address Information </legend>
                                        <div class="address-bar" style="min-height: 145px;">
                                            <table border="0" width="100%">
                                                <tr>
                                                    <td width="5%">
                                                        <label style="width: 74px; float: left;">
                                                            Address</label>
                                                    </td>
                                                    <td colspan="3" align="left">
                                                        <asp:TextBox ID="txtNAddress" runat="server" MaxLength="300" ValidateRequestMode="Disabled" onkeydown="ismaxlengthTxtBox(this,'300')" CssClass="textarea_ctrl"
                                                            AutoCompleteType="Disabled" TextMode="MultiLine"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label>
                                                            Zip</label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtNZip" runat="server" MaxLength="5" CssClass="autocmplt" onkeydown="OnlyNumeric();"
                                                            onkeyup="BindNDCityCounty();"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <label>
                                                            City</label>
                                                    </td>
                                                    <td>
                                                        <ajax:ComboBox ID="cmbNCity" runat="server" AutoCompleteMode="SuggestAppend" CssClass="postion-over"
                                                            MaxLength="50" DropDownStyle="Simple" Width="225px">
                                                        </ajax:ComboBox>
                                                        <asp:HiddenField ID="hdnNdCity" runat="server" />
                                                        <asp:HiddenField ID="hdnIsTakeNDCityFromHidden" runat="server" Value="0" />
                                                        <asp:HiddenField ID="hdnIsDuplicate" runat="server" Value="0" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label>
                                                            County</label>
                                                    </td>
                                                    <td>
                                                        <ajax:ComboBox ID="cmbNCounty" runat="server" AutoCompleteMode="SuggestAppend" CssClass="postion-over county-ctrl"
                                                            MaxLength="25" Width="118px" DropDownStyle="Simple">
                                                        </ajax:ComboBox>
                                                        <asp:HiddenField ID="hdnNdCounty" runat="server" />
                                                        <asp:HiddenField ID="hdnIsTakeNDCountyFromHidden" runat="server" Value="0" />
                                                    </td>
                                                    <td>
                                                        <label>
                                                            State</label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtNState" runat="server" MaxLength="2" CssClass="state_ctrl" Text="MI"
                                                            AutoCompleteType="Disabled"></asp:TextBox>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <label>Township</label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlTownship" runat="server"></asp:DropDownList>
                                                    </td>
                                                </tr>
                                            </table>

                                            <div id="showHideDiv3" runat="server">
                                                <div id="divPopUpContent3" runat="server">
                                                    <div style="width: 70%; margin: auto; position: relative;">
                                                        <input id="btnClose3" type="button" runat="server" class="close_popmore" onclick="return ShowHideCustomField();" style="display: none" />
                                                        &nbsp;&nbsp;<div id="divpopupHeading3" style="display: none; margin: 0 auto; width: 90%;" class="popup_form_heading_history"
                                                            runat="server">
                                                            Custom Fields
                                                        </div>
                                                        <div class="form_block_popup" id="divpnlContact3" runat="server" style="padding: 0 !important; display: none;">
                                                            <div style="padding: 10px; margin: 0 0 0 0; min-height: 210px; max-height: 500px; background-color: white;">
                                                                <div style="width: 43.5%; margin-top: 62px; float: left;">
                                                                    <div style="margin-bottom: 10px;">
                                                                        <div><b>New Custom Option</b></div>
                                                                        <input type='text' id="txtCustomField" size="45" maxlength="50" oncopy="return false" onpaste="return false" oncut="return false" style="height: 18px; font-size: 12px;" onpaste='return false;' ondrop='return false;' autocomplete='off' />
                                                                    </div>
                                                                </div>
                                                                <div style="padding: 7% 0% 3% 0%; width: 20%; float: left;">
                                                                    <input type="button" id="btnAddCF" value="Add" onclick="ShowConfirmBox('AddCF');" class="multiple_selecter_btn" size="28" />
                                                                    <input type="button" id="btnModifyCF" value="Modify" onclick="ModifyCustomField();" class="multiple_selecter_btn" />
                                                                    <input type="button" id="btnRemoveCF" value="Remove" onclick="ShowConfirmBox('RemoveCF');" class="multiple_selecter_btn" />
                                                                    <% if (MySession.blnADRCIAOSAAdmin)
                                                                        { %>
                                                                    <input type="button" id="btnRemoveAllCF" name="btnRemoveAllCF" value="Remove All" onclick="ShowConfirmBox('RemoveAllCF');" class="multiple_selecter_btn" />
                                                                    <%}%>
                                                                </div>
                                                                <div style="width: 35%; float: left;">
                                                                    <div><b>Custom List Options</b></div>
                                                                    <select name="lstAllCustomField" id="lstAllCustomField" style="width: 28em; padding: 5px;" size="11">
                                                                    </select>
                                                                </div>
                                                                <div style="clear: both; float: left; width: 100%; text-align: center">
                                                                    <input type="button" value="Submit" class="btn" onclick="return SubmitCustomField();" />
                                                                    <input type="button" value="Cancel" class="btn" onclick="return ShowHideCustomField();" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="clear_01">
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                            </asp:Panel>

                        </ContentTemplate>




                    </ajax:TabPanel>
                    <ajax:TabPanel ID="tabServices" runat="server">
                        <HeaderTemplate>
                            Services Available/Requested                        
                        </HeaderTemplate>
                        <ContentTemplate>
                            <div id="printServiceInfo">
                                <div class="fieldset-box-services-tab-first  serv-tab-1">
                                    <fieldset>
                                        <legend>Services Available/Requested</legend>
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td align="left" width="47%">
                                                    <label class="multiple_selecter_heading ">
                                                        Services Available</label>
                                                    <asp:ListBox ID="lstServicesAvailable" runat="server" SelectionMode="Multiple" Rows="10" CssClass="requested_textarea"></asp:ListBox>
                                                    <asp:HiddenField ID="hdnServAvail" runat="server" />
                                                    <asp:HiddenField ID="hdnInactiveServ" runat="server" />
                                                </td>
                                                <td align="center" width="5%">
                                                    <input type="button" id="btnAdd" name="Add" value=">>" onclick="AddService();"
                                                        class="multiple_selecter_btn btn-style" /><br />
                                                    <input type="button" id="btnRemove" name="Remove" value="<<" onclick="RemoveService();"
                                                        class="multiple_selecter_btn btn-style" />
                                                </td>
                                                <td align="left">
                                                    <div id="printServRequested">
                                                        <label class="multiple_selecter_heading">
                                                            Service(s) Requested</label>
                                                        <asp:ListBox ID="lstServicesRequested" runat="server" SelectionMode="Multiple" Rows="10" CssClass="requested_textarea"></asp:ListBox>
                                                        <asp:HiddenField ID="hdnServReq" runat="server" />
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>

                                                <td colspan="2" valign="top">
                                                    <label>
                                                        Other Service</label>
                                                    <asp:TextBox ID="txtServReqOther" CssClass="other_opt_ctrl" runat="server" MaxLength="100"
                                                        AutoCompleteType="Disabled" Width="257px"></asp:TextBox>
                                                </td>
                                                <td valign="bottom">
                                                    <input type="button" id="btnSearchProviders" name="btnSearchProviders" value="Search Providers"
                                                        onclick="GetServiceProviderAgency();" class="service_provider_btn" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" width="47%">
                                                    <asp:CheckBox ID="chkServicesAlreadyinPlace" runat="server" Text=" Services Already in Place" /></td>
                                                <td align="left" width="5%"></td>
                                                <td align="left">
                                                    <div style="float: left">
                                                        <asp:CheckBox ID="chkFundProvided" runat="server" Text=" Funds Provided" onchange="EnableDisableTextFundProvided();" />
                                                        <div class="input-symbol-euro" style="display: inline;">
                                                            <span class="symbolDollar">$</span>
                                                            <asp:TextBox ID="txtFundProvided" runat="server" MaxLength="7" Width="50" Style="margin-left: -15px" onpaste="return false;" autocomplete="off"></asp:TextBox>
                                                            <asp:HiddenField ID="hdnFundProvided" runat="server" />
                                                        </div>
                                                    </div>
                                                    <div style="float: left; margin-left: 10px">
                                                        <label>
                                                            On</label>
                                                        <asp:TextBox ID="txtFundsUtilizedDate" class="dob_ctrl" runat="server" MaxLength="10"
                                                            Width="70px"></asp:TextBox><ajax:CalendarExtender ID="CalendarExtender3" runat="server"
                                                                CssClass="req" Enabled="True" TargetControlID="txtFundsUtilizedDate"></ajax:CalendarExtender>
                                                        <ajax:MaskedEditExtender ID="MaskedEditExtender7" runat="server" MaskType="Date" Mask="99/99/9999"
                                                            TargetControlID="txtFundsUtilizedDate" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder=""
                                                            CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                            CultureTimePlaceholder="" Enabled="True"></ajax:MaskedEditExtender>
                                                        <asp:CompareValidator ID="CompareValidator2" runat="server" ValueToCompare="1/1/1900"
                                                            Display="None" ValidationGroup="ND" Type="Date" Operator="GreaterThanEqual" ErrorMessage="Date should be greater than or equal to 1/1/1900 and format should be mm/dd/yyyy"
                                                            ControlToValidate="txtFundsUtilizedDate" CssClass="req"></asp:CompareValidator>
                                                        <asp:HiddenField ID="hdnFundsUtilizedDate" runat="server" />
                                                    </div>

                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" width="47%"></td>
                                                <td align="left" width="5%"></td>
                                                <td align="left" style="padding-top: 10px;">
                                                    <fieldset style="min-height: 42px; width: 96%;">
                                                        <legend style="font-weight: bold;">Funds Utilized for</legend>
                                                        <div>
                                                            <asp:CheckBoxList ID="chklistFundsUtilized" CssClass="label-checkbox" RepeatColumns="3" RepeatDirection="Horizontal" runat="server"></asp:CheckBoxList>
                                                            <asp:HiddenField ID="hdnFundsUtilized" runat="server" />
                                                        </div>
                                                        <div style="margin-left: 76px !important; margin-top: -20px;">
                                                            <asp:TextBox ID="txtFundsUtilizedForOther" runat="server" MaxLength="50" Width="226" Enabled="false" autocomplete="off"></asp:TextBox>
                                                            <asp:HiddenField ID="hdnFundsUtilizedForOther" runat="server" />
                                                        </div>
                                                    </fieldset>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td colspan="3" style="padding-top: 5px;">
                                                    <label>
                                                        Notes</label>
                                                    <asp:TextBox ID="txtAlreadyServiceNotes" ValidateRequestMode="Disabled" MaxLength="1000" Width="100%" runat="server" TextMode="MultiLine"
                                                        onkeydown="ismaxlengthTxtBox(this,'1000')" Height="50px"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </div>
                                <div class="fieldset-box-services-tab-last serv-tab-2" id="printReferral">
                                    <fieldset>
                                        <legend>Referred By/To</legend>
                                        <div class="tab2-scroll">
                                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <div id="divRefByTo">
                                                            <label style="margin: 15px 0 0 0;">
                                                                Referred By</label>
                                                            <asp:DropDownList ID="ddlRefBy" runat="server" CssClass="dropdown-auto">
                                                            </asp:DropDownList>
                                                            <div style="margin: 0 0 10px 0;">
                                                                <label>
                                                                    Other</label>
                                                                <asp:TextBox ID="txtRefByOther" runat="server" CssClass="other_opt_ctrl" AutoCompleteType="Disabled"
                                                                    MaxLength="100" Width="72%"></asp:TextBox>
                                                            </div>
                                                            <div>
                                                                <label>
                                                                    Referred to ADRC Partner</label>
                                                                <p>
                                                                    <select id="chkList" onchange="setHeaderText()" style="width: 400px;">
                                                                </p>
                                                                <asp:HiddenField ID="HFgetRefToIds" runat="server" />
                                                            </div>
                                                            <div>
                                                                <label>
                                                                    Other</label>
                                                                <asp:TextBox ID="txtRefToOther" runat="server" CssClass="other_opt_ctrl" AutoCompleteType="Disabled"
                                                                    MaxLength="100" Width="72%"></asp:TextBox>
                                                            </div>
                                                            <div style="height: 8px;">
                                                            </div>
                                                            <div>
                                                                <label>
                                                                    Referred to Service Provider</label>
                                                                <p>
                                                                    <select id="chkReferredtoServiceProvider" onchange="setHeaderText()" style="width: 400px;">
                                                                </p>
                                                                <asp:HiddenField ID="HFchkReferredtoServiceProvider" runat="server" />
                                                            </div>
                                                            <div>
                                                                <label>Other </label>
                                                                <asp:TextBox ID="txtReferredToServiceProvider" runat="server" MaxLength="50" Width="72%"
                                                                    CssClass="other_opt_ctrl" AutoCompleteType="Disabled"></asp:TextBox>
                                                            </div>
                                                            <div style="height: 8px;">
                                                            </div>
                                                            <label style="margin: 15px 0 0 0;">
                                                                Permission granted to refer to ADRC partner</label>
                                                            <asp:CheckBoxList ID="chkPermissionGranted" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text=" Yes" Value="1"></asp:ListItem>
                                                                <asp:ListItem Text=" No" Value="0"></asp:ListItem>
                                                            </asp:CheckBoxList>
                                                            <asp:CheckBox ID="chkreferredforoc" runat="server" Text=" Referred for OC" onchange="javascript:ShowHideReferredforOCDate('MainContent_NeedyPersonTab_tabServices_chkreferredforoc');" />
                                                            <div id="referredforocdate" runat="server" style="display: none;">
                                                                <label>Date</label>
                                                                <asp:TextBox ID="txtreferredforocdate" runat="server" MaxLength="10" Width="75px"></asp:TextBox>
                                                                <ajax:CalendarExtender ID="txtdateFrom_CalendarExtender" runat="server" CssClass="req"
                                                                    Enabled="True" TargetControlID="txtreferredforocdate"></ajax:CalendarExtender>
                                                                <ajax:MaskedEditExtender ID="mskcalreferredforoc" runat="server" MaskType="Date" Mask="99/99/9999"
                                                                    TargetControlID="txtreferredforocdate" ClearTextOnInvalid="True" Enabled="True" UserDateFormat="MonthDayYear" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""></ajax:MaskedEditExtender>
                                                            </div>
                                                        </div>
                                                        <div style="text-align: right;">
                                                            <input type="button" value="Send Email" class="multiple_selecter_btn" onclick="InitRefEmail();" />
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>

                                        </div>
                                    </fieldset>
                                </div>
                            </div>

                        </ContentTemplate>




                    </ajax:TabPanel>
                    <ajax:TabPanel ID="tabCallInfo" runat="server">
                        <HeaderTemplate>
                            Call Info
                        
                        </HeaderTemplate>




                        <ContentTemplate>
                            <div id="printCallInfo">
                                <table width="100%">
                                    <tr>
                                        <td>
                                            <label>
                                                Previous Call Notes:</label><br />
                                            <%--<asp:TextBox ID="txtAllPrevousNotes" CssClass="textarea_ctrl" AutoCompleteType="Disabled"
                                                runat="server" TextMode="MultiLine" Height="150px" Width="100%"></asp:TextBox>--%>
                                            <div id="up_container1" style="background-color: #FFFFFF; height: 200px; border: 1px solid; padding: 10px; overflow: auto">
                                                <asp:Label ID="txtAllPrevousNotes" runat="server"></asp:Label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 10px 0 0 0;">
                                            <label>
                                                Notes:</label>
                                            <br />
                                            <%--<uc:MultilineTextbox ID="txtNotes" class="textarea_ctrl" runat="server" MaxLength="2000" Height="150px" />--%>
                                            <asp:TextBox ID="txtNotes" ValidateRequestMode="Disabled" MaxLength="8000" CssClass="textarea_ctrl" onkeydown="ismaxlengthTxtBox(this,'8000')" AutoCompleteType="Disabled"
                                                runat="server" TextMode="MultiLine" Height="150px" Width="100%"></asp:TextBox>
                                            <asp:TextBox ID="txtInfoReq" runat="server" TextMode="MultiLine" MaxLength="500"
                                                Visible="False" CssClass="textarea_big" onkeydown="ismaxlengthTxtBox(this,'500')"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </div>

                        </ContentTemplate>




                    </ajax:TabPanel>
                    <ajax:TabPanel ID="tabCallHistory" runat="server">
                        <HeaderTemplate>
                            Call History
                        
                        </HeaderTemplate>




                        <ContentTemplate>
                            <div id="printCallHistory">
                                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td align="center" valign="top">
                                            <a name="view_call_history"></a>
                                            <div id="divCallHistory" class="grid_scroll" style="display: none; max-height: 280px">
                                                <div id="printHistory">
                                                    <div align="left">
                                                        <label id="lblCallCount">
                                                        </label>
                                                    </div>
                                                    <table border="0" cellpadding="0" cellspacing="0" class="gridview tablesorter" id="gridHistory"
                                                        width="99.8%" style="border-collapse: collapse;">
                                                        <thead>
                                                            <tr>
                                                                <th style="width: 10%; padding: 5px 15px 5px 5px">First Name
                                                                </th>
                                                                <th style="width: 10%; padding: 5px 15px 5px 5px">Last Name
                                                                </th>
                                                                <th style="width: 6%; padding: 5px 15px 5px 5px">Email
                                                                </th>
                                                                <th style="width: 14%; padding: 5px 15px 5px 5px">Contact Date/Time
                                                                </th>
                                                                <th style="width: 10%; padding: 5px 15px 5px 5px">Call Duration
                                                                </th>
                                                                <th style="width: 16%; padding: 5px 15px 5px 5px;">Services Requested
                                                                </th>
                                                                <th style="width: 10%; padding: 5px 15px 5px 5px">User Name
                                                                </th>
                                                                <th style="width: 7%; padding: 5px 15px 5px 5px;">ADRC
                                                                </th>
                                                                <th style="width: 8%; padding: 5px 15px 5px 5px;">Info Only
                                                                </th>
                                                                <th style="width: 7%; padding: 5px 15px 5px 5px;">To-Do
                                                                </th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <td colspan="8"></td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>

                        </ContentTemplate>




                    </ajax:TabPanel>
                    <ajax:TabPanel ID="tabFollowup" runat="server">
                        <HeaderTemplate>
                            Follow Up
                        
                        </HeaderTemplate>




                        <ContentTemplate>
                            <table width="100%">
                                <tr>
                                    <td style="width: 50%;">
                                        <fieldset>
                                            <legend>I&A Follow Up</legend>
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <label>
                                                            I&A Follow Up</label>
                                                        <asp:DropDownList ID="ddlFollowUp" runat="server" CssClass="followup_ctrl">
                                                            <asp:ListItem Text="--Select--" Value="-1"></asp:ListItem>
                                                            <asp:ListItem Text="Requested" Value="1"></asp:ListItem>
                                                            <asp:ListItem Text="Declined" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="N/A" Value="2"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <label>
                                                            Date</label>
                                                        <asp:TextBox ID="txtFollowupDate" class="dob_ctrl" runat="server" MaxLength="10"
                                                            Width="80px"></asp:TextBox><ajax:CalendarExtender ID="CalendarExtender1" runat="server"
                                                                CssClass="req" Enabled="True" TargetControlID="txtFollowupDate"></ajax:CalendarExtender>
                                                        <ajax:MaskedEditExtender ID="mskFollowupExt" runat="server" MaskType="Date" Mask="99/99/9999"
                                                            TargetControlID="txtFollowupDate" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder=""
                                                            CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                            CultureTimePlaceholder="" Enabled="True"></ajax:MaskedEditExtender>
                                                        <asp:CompareValidator ID="CompareValidator1" runat="server" ValueToCompare="1/1/1900"
                                                            Display="None" ValidationGroup="ND" Type="Date" Operator="GreaterThanEqual" ErrorMessage="Date should be greater than or equal to 1/1/1900 and format should be mm/dd/yyyy"
                                                            ControlToValidate="txtFollowupDate" CssClass="req"></asp:CompareValidator>
                                                    </td>
                                                    <td>
                                                        <label>
                                                            Service Need Met</label>
                                                        <asp:DropDownList ID="ddlServiceNeedMet" runat="server" Width="100px" CssClass="serviceneed_ctrl">
                                                            <asp:ListItem Value="-1" Text="--Select--"></asp:ListItem>
                                                            <asp:ListItem Value="1" Text="Yes"></asp:ListItem>
                                                            <asp:ListItem Value="0" Text="No"></asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:HiddenField ID="hdnFlwpSelected" runat="server" Value="0" />
                                                        <asp:HiddenField ID="hdnUpdateCall" runat="server" Value="0" />
                                                    </td>
                                                    <td>
                                                        <asp:CheckBox ID="chkFollowupCompleted" runat="server" Text=" Completed" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4"></td>
                                                </tr>
                                                <tr>
                                                    <td valign="top" colspan="4">
                                                        <label>
                                                            Follow-up Notes:</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4">
                                                        <uc:MultilineTextbox ID="txtFollowUpNotes" ValidateRequestMode="Disabled" runat="server" Height="150px" MaxLength="1000" />
                                                    </td>
                                            </table>
                                            <div align="left" id="divFollowupList" style="display: none; margin: 10px 0 0 0;">
                                                <label id="lblFollowupCount">
                                                </label>
                                            </div>
                                            <table border="0" cellpadding="0" cellspacing="0" align="left" class="gridview tablesorter"
                                                id="tblFollowupList" style="border-collapse: collapse; display: none; margin: 0; width: 99%">
                                                <thead>
                                                    <tr>
                                                        <th nowrap="nowrap">Follow-up Date/Time
                                                        </th>
                                                        <th nowrap="nowrap">Call Duration
                                                        </th>
                                                        <th nowrap="nowrap">User Name
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td colspan="3"></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </fieldset>
                                    </td>
                                    <td style="width: 2%;"></td>
                                    <td style="width: 50%;" valign="top">
                                        <fieldset>
                                            <legend>Option Counseling</legend>
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <label>
                                                            OC Follow Up</label>
                                                        <asp:DropDownList ID="ddlOCFollowUp" runat="server" CssClass="followup_ctrl">
                                                            <asp:ListItem Text="--Select--" Value="-1"></asp:ListItem>
                                                            <asp:ListItem Text="Requested" Value="1"></asp:ListItem>
                                                            <asp:ListItem Text="Declined" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="N/A" Value="2"></asp:ListItem>
                                                        </asp:DropDownList>

                                                        <label>
                                                            Date</label>
                                                        <asp:TextBox ID="txtOCfollowupdate" class="dob_ctrl" runat="server" MaxLength="10"
                                                            Width="80px"></asp:TextBox><ajax:CalendarExtender ID="CalendarExtender4" runat="server"
                                                                CssClass="req" Enabled="True" TargetControlID="txtOCfollowupdate"></ajax:CalendarExtender>
                                                        <ajax:MaskedEditExtender ID="MaskedEditExtender6" runat="server" MaskType="Date"
                                                            Mask="99/99/9999" TargetControlID="txtOCfollowupdate" Enabled="True" CultureAMPMPlaceholder=""
                                                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""></ajax:MaskedEditExtender>
                                                        <asp:CompareValidator ID="CompareValidator4" runat="server" ValueToCompare="1/1/1900"
                                                            Display="None" ValidationGroup="ND" Type="Date" Operator="GreaterThanEqual" ErrorMessage="Date should be greater than or equal to 1/1/1900 and format should be mm/dd/yyyy"
                                                            ControlToValidate="txtOCfollowupdate" CssClass="req"></asp:CompareValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td valign="top">
                                                        <label>
                                                            Follow-up Notes:</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <uc:MultilineTextbox ID="txtOCFollowupnotes" ValidateRequestMode="Disabled" runat="server" MaxLength="1000" Height="150px" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                            </table>

                        </ContentTemplate>




                    </ajax:TabPanel>
                    <ajax:TabPanel ID="tabOptionCounselling" runat="server">
                        <HeaderTemplate>
                            Option Counseling
                        
                        </HeaderTemplate>




                        <ContentTemplate>
                            <table width="100%">
                                <tr>
                                    <td style="width: 49%;" valign="top">
                                        <fieldset>
                                            <legend>Option Counseling</legend>
                                            <table width="100%">
                                                <tr>
                                                    <td style="width: 40%;" valign="top">
                                                        <label>
                                                            Insurance Types</label>
                                                    </td>
                                                    <td style="width: 60%;">

                                                        <select id="ddlInsuranceTypes" onchange="setHeaderText();" style="width: 400px;">
                                                            <asp:HiddenField ID="HFInsuranceTypes" runat="server" />
                                                            <br />
                                                            <br />
                                                            <asp:TextBox ID="txtInsuranceOther" MaxLength="75" runat="server" Style="display: none;"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <div style="height: 3px;">
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:CheckBox ID="chkOCTriggerPresent" runat="server" Text="  OC Trigger Present" />
                                                    </td>
                                                    <td>
                                                        <p>
                                                            <select id="chkTriggers" onchange="setHeaderText();" style="width: 400px;">
                                                        </p>
                                                        <asp:HiddenField ID="HFTriggers" runat="server" />
                                                    </td>
                                                    <tr>
                                                        <td colspan="2">
                                                            <div style="height: 3px;">
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <label class="WordBreak">
                                                                Lacks memory or cognitive skills for daily decision making</label>
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="chkLMYes" runat="server" Text=" Yes" />
                                                            <asp:CheckBox ID="chkLMNo" runat="server" Text=" No" />
                                                            <ajax:MutuallyExclusiveCheckBoxExtender ID="MEchkLMYes" runat="server" Enabled="True" Key="LMSkills" TargetControlID="chkLMYes"></ajax:MutuallyExclusiveCheckBoxExtender>
                                                            <ajax:MutuallyExclusiveCheckBoxExtender ID="MEchkLMNo" runat="server" Enabled="True" Key="LMSkills" TargetControlID="chkLMNo"></ajax:MutuallyExclusiveCheckBoxExtender>

                                                            <asp:DropDownList ID="ddlLMReportedDiagnosed" runat="server">
                                                                <asp:ListItem Text="--Select--" Value="-1"></asp:ListItem>
                                                                <asp:ListItem Text="Reported" Value="0"></asp:ListItem>
                                                                <asp:ListItem Text="Diagnosed" Value="1"></asp:ListItem>
                                                            </asp:DropDownList>

                                                            <asp:DropDownList ID="ddlLacksMemory" runat="server">
                                                                <asp:ListItem Text="--Select--" Value="-1"></asp:ListItem>
                                                                <asp:ListItem Text="Minimal Impairment" Value="1"></asp:ListItem>
                                                                <asp:ListItem Text="Moderate Impairment" Value="2"></asp:ListItem>
                                                                <asp:ListItem Text="Severe" Value="3"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <div style="height: 3px;">
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <label>
                                                                Total Countable Asset Amount</label>
                                                        </td>
                                                        <td>

                                                            <div class="input-symbol-euro" style="display: inline;">
                                                                <span class="symbolDollar">$</span>
                                                                <asp:TextBox ID="txtAssetAmount" onkeypress="return AssignValues(this.id);" onkeyup="return CommaFormatted(this, event)" Style="margin-left: -15px;" Width="25%" runat="server" MaxLength="7"></asp:TextBox>
                                                            </div>

                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <div style="height: 3px;">
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <fieldset style="width: 98%;">
                                                                <legend>Household Income</legend>
                                                                <table width="100%">
                                                                    <tr>
                                                                        <td style="width: 40%">
                                                                            <label>
                                                                                Total Monthly Gross Household Income</label>
                                                                        </td>
                                                                        <td>
                                                                            <div class="input-symbol-euro" style="display: inline;">
                                                                                <span class="symbolDollar">$</span>
                                                                                <asp:TextBox ID="txtTotalHouseholdIncome" Style="margin-left: -15px;" Width="25%" runat="server" onkeypress="return AssignValues(this.id);" onkeyup="return CommaFormatted(this, event)" MaxLength="7"></asp:TextBox>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <div style="height: 3px;">
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <label>
                                                                                Spouse Income</label>
                                                                        </td>
                                                                        <td>
                                                                            <div class="input-symbol-euro" style="display: inline;">
                                                                                <span class="symbolDollar">$</span>
                                                                                <asp:TextBox ID="txtSpouse" Style="margin-left: -15px;" Width="25%" runat="server" onkeypress="return AssignValues(this.id);" onkeyup="return CommaFormatted(this, event)" MaxLength="7"></asp:TextBox>
                                                                            </div>

                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <div style="height: 3px;">
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <label>
                                                                                Client Income</label>
                                                                        </td>
                                                                        <td>
                                                                            <div class="input-symbol-euro" style="display: inline;">
                                                                                <span class="symbolDollar">$</span>
                                                                                <asp:TextBox ID="txtClient" Style="margin-left: -15px;" Width="25%" runat="server" onkeypress="return AssignValues(this.id);" onkeyup="return CommaFormatted(this, event)" MaxLength="7"></asp:TextBox>
                                                                            </div>

                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <div style="height: 3px;">
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <label>
                                                                                Financial Notes:</label><br />
                                                                            <asp:TextBox ID="txtFinancialNotes" runat="server" ValidateRequestMode="Disabled" MaxLength="255" onkeydown="ismaxlengthTxtBox(this,'255')" TextMode="MultiLine" Width="100%"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </fieldset>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <div style="height: 3px;">
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <asp:CheckBox ID="chkNottoDevelop" runat="server" Text=" I am choosing not to develop a person centered plan at this time. I may change my
                                                            mind at any time." />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <div style="height: 3px;">
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <asp:CheckBox ID="chkDevelopPlan" runat="server" Text=" I choose to develop a written centered plan at this time." />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <div style="height: 3px;">
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <asp:CheckBox ID="chkPermissiotoCall" runat="server" Text=" I give my permission for someone to call me about my experience with the Options
                                                            Counselor." />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <div style="height: 3px;">
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2"></td>
                                                    </tr>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                    <td style="width: 1%;"></td>
                                    <td style="width: 50%;" valign="top">
                                        <fieldset style="height: 360px;">
                                            <legend>Time Spent</legend>
                                            <div class="box-contentlstGrid">
                                                <table width="100%">
                                                    <tr>
                                                        <td style="padding-left: 15px; width: 100%;">
                                                            <asp:UpdatePanel ID="upMore" runat="server">
                                                                <ContentTemplate>

                                                                    <asp:ListView ID="lstViewTimeSpent" runat="server" OnItemInserting="lstViewTimeSpent_ItemInserting"
                                                                        InsertItemPosition="FirstItem" OnItemDataBound="lstViewTimeSpent_ItemDataBound"
                                                                        OnItemCommand="lstViewTimeSpent_ItemCommand" OnItemUpdating="lstViewTimeSpent_ItemUpdating" OnItemCanceling="lstViewTimeSpent_ItemCanceling"
                                                                        OnItemEditing="lstViewTimeSpent_ItemEditing" OnItemDeleting="lstViewTimeSpent_ItemDeleting">
                                                                        <LayoutTemplate>
                                                                            <table width="100%" id="tblViewTimeSpent" cellpadding="0" cellspacing="0">
                                                                                <tr>
                                                                                    <th align="left" style="width: 10%;">Date
                                                                                    </th>
                                                                                    <th align="left" style="width: 16%;">Time Spent (Minutes)
                                                                                    </th>
                                                                                    <th align="left" style="width: 29%;">Reason
                                                                                    </th>
                                                                                    <th align="left" style="width: 6%;"></th>
                                                                                </tr>
                                                                                <tr id="itemplaceholder" runat="server">
                                                                                </tr>
                                                                            </table>
                                                                        </LayoutTemplate>
                                                                        <ItemTemplate>
                                                                            <tr>
                                                                                <td align="left" valign="top">
                                                                                    <asp:Label ID="lblTravelDate" runat="server" Text='<%# Eval("TravelDate") %>'></asp:Label>
                                                                                    <%-- <label>
                                                                                        <%# Eval("TravelDate") %></label>--%>
                                                                                </td>
                                                                                <td align="left" valign="top">
                                                                                    <asp:Label ID="lblTravelTime" runat="server" Text='<%# Eval("TravelTime") %>'></asp:Label>
                                                                                    <%--<label>
                                                                                        <%# Eval("TravelTime") %></label>--%>
                                                                                </td>
                                                                                <td align="left" valign="top">
                                                                                    <asp:Panel ID="pnlTimeSpentA" runat="server" Height="40px" Direction="LeftToRight" ScrollBars="Auto">
                                                                                        <asp:Label ID="lblTSReason" runat="server" Text='<%# HttpUtility.HtmlEncode(Eval("TimeSpentReason")) %>'></asp:Label> <%-- Modified by AR, 12-April-2024 | To Encode the Html attributes --%>
                                                                                        <%--<label>
                                                                                            <%# Eval("TimeSpentReason")%></label>--%>
                                                                                    </asp:Panel>

                                                                                </td>
                                                                                <td>
                                                                                    <asp:UpdatePanel ID="upEdirDelete" runat="server">
                                                                                        <Triggers>
                                                                                            <asp:PostBackTrigger ControlID="btnEdit" />
                                                                                            <asp:PostBackTrigger ControlID="btnDelete" />
                                                                                        </Triggers>
                                                                                        <ContentTemplate>

                                                                                            <div style="width: 100%; text-align: center;">

                                                                                                <div style="width: 30%; float: left;">
                                                                                                    <asp:ImageButton ID="btnEdit"
                                                                                                        runat="server" ImageUrl="~/images/editicon.jpg" CommandName="Edit" ToolTip="Edit"></asp:ImageButton>
                                                                                                </div>
                                                                                                <div style="width: 10%"></div>
                                                                                                <div style="width: 40%; float: right;">
                                                                                                    <asp:ImageButton ID="btnDelete"
                                                                                                        runat="server" ImageUrl="~/images/trash_can.gif" Height="20px" OnClientClick="return ConfirmOnDelete();" CommandName="Delete" ToolTip="Delete"></asp:ImageButton>
                                                                                                </div>
                                                                                            </div>
                                                                                        </ContentTemplate>
                                                                                    </asp:UpdatePanel>
                                                                                </td>
                                                                            </tr>
                                                                            <%--<tr>
                                                                            <td colspan="4">
                                                                                <div style="height: 5px;"></div>
                                                                            </td>
                                                                        </tr>--%>
                                                                        </ItemTemplate>
                                                                        <AlternatingItemTemplate>
                                                                            <tr style="background-color: #EFEFEF">
                                                                                <td align="left" valign="top">
                                                                                    <asp:Label ID="lblTravelDate" runat="server" Text='<%# Eval("TravelDate") %>'></asp:Label>
                                                                                    <%--<label>
                                                                                        <%# Eval("TravelDate") %></label>--%>
                                                                                </td>
                                                                                <td align="left" valign="top">
                                                                                    <asp:Label ID="lblTravelTime" runat="server" Text='<%# Eval("TravelTime") %>'></asp:Label>
                                                                                    <%--<label>
                                                                                        <%# Eval("TravelTime") %></label>--%>
                                                                                </td>
                                                                                <td align="left" valign="top">
                                                                                    <asp:Panel ID="pnlTimeSpentB" runat="server" Height="40px" Wrap="true" Direction="LeftToRight" ScrollBars="Auto">
                                                                                        <asp:Label ID="lblTSReason" runat="server" Text='<%# Eval("TimeSpentReason") %>'></asp:Label>
                                                                                        <%--<label>
                                                                                            <%# Eval("TimeSpentReason")%></label>--%>
                                                                                    </asp:Panel>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:UpdatePanel ID="upEdirDelete1" runat="server">
                                                                                        <Triggers>
                                                                                            <asp:PostBackTrigger ControlID="btnEdit1" />
                                                                                            <asp:PostBackTrigger ControlID="btnDelete1" />
                                                                                        </Triggers>
                                                                                        <ContentTemplate>

                                                                                            <div style="width: 100%; text-align: center;">

                                                                                                <div style="width: 30%; float: left;">
                                                                                                    <asp:ImageButton ID="btnEdit1"
                                                                                                        runat="server" ImageUrl="~/images/editicon.jpg" CommandName="Edit" ToolTip="Edit"></asp:ImageButton>
                                                                                                </div>
                                                                                                <div style="width: 10%"></div>
                                                                                                <div style="width: 40%; float: right;">
                                                                                                    <asp:ImageButton ID="btnDelete1"
                                                                                                        runat="server" OnClientClick="return ConfirmOnDelete();" ImageUrl="~/images/trash_can.gif" Height="20px" CommandName="Delete" ToolTip="Delete"></asp:ImageButton>
                                                                                                </div>
                                                                                            </div>
                                                                                        </ContentTemplate>
                                                                                    </asp:UpdatePanel>

                                                                                </td>
                                                                            </tr>
                                                                        </AlternatingItemTemplate>
                                                                        <InsertItemTemplate>
                                                                            <tr>
                                                                                <td colspan="4" style="border: none;">
                                                                                    <div style="height: 5px;"></div>
                                                                                </td>
                                                                            </tr>
                                                                            <tr runat="server">
                                                                                <td valign="top">
                                                                                    <asp:TextBox ID="txtTravelDate" CssClass="TextBackColor" class="dob_ctrl"
                                                                                        runat="server" MaxLength="10" Width="100%"></asp:TextBox>

                                                                                    <ajax:CalendarExtender ID="CalendarExtender2" runat="server" CssClass="req" Enabled="True"
                                                                                        TargetControlID="txtTravelDate"></ajax:CalendarExtender>
                                                                                    <ajax:MaskedEditExtender ID="MaskedEditExtender4" runat="server" MaskType="Date"
                                                                                        Mask="99/99/9999" TargetControlID="txtTravelDate" Enabled="True" CultureAMPMPlaceholder=""
                                                                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                                                        CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""></ajax:MaskedEditExtender>
                                                                                </td>
                                                                                <td valign="top">
                                                                                    <asp:TextBox ID="txtTravelTime" CssClass="TextBackColor" Width="100%" runat="server"></asp:TextBox>


                                                                                    <ajax:MaskedEditExtender ID="MENumeric" runat="server" TargetControlID="txtTravelTime"
                                                                                        ClearMaskOnLostFocus="true" Mask="9999" MaskType="Number" AutoComplete="false"></ajax:MaskedEditExtender>
                                                                                </td>
                                                                                <td align="center" valign="top">
                                                                                    <asp:TextBox ID="txtReason" ValidateRequestMode="Disabled" MaxLength="500" CssClass="TextBackColor" onkeydown="ismaxlengthTxtBox(this,'500')" Width="100%" Height="35px" runat="server" TextMode="MultiLine"></asp:TextBox>

                                                                                </td>
                                                                                <td valign="middle" style="padding-left: 17px; padding-top: 2px;">
                                                                                    <asp:UpdatePanel ID="upAddMore" runat="server">
                                                                                        <Triggers>
                                                                                            <asp:PostBackTrigger ControlID="InsertButton" />
                                                                                        </Triggers>
                                                                                        <ContentTemplate>

                                                                                            <asp:ImageButton ID="InsertButton"
                                                                                                runat="server" ImageUrl="~/images/add_icon.png" ToolTip="Add to list" OnClientClick="Javascript:return ValidateInputDate('MainContent_NeedyPersonTab_tabOptionCounselling_lstViewTimeSpent_txtTravelDate','MainContent_NeedyPersonTab_tabOptionCounselling_lstViewTimeSpent_txtTravelTime','MainContent_NeedyPersonTab_tabOptionCounselling_lstViewTimeSpent_txtReason');" CommandName="Insert" ValidationGroup="req" AlternateText="Add More"></asp:ImageButton>
                                                                                        </ContentTemplate>
                                                                                    </asp:UpdatePanel>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td colspan="4">
                                                                                    <div style="height: 3px;"></div>
                                                                                </td>
                                                                            </tr>
                                                                        </InsertItemTemplate>

                                                                        <EditItemTemplate>
                                                                            <tr>
                                                                                <td align="left" valign="top">


                                                                                    <asp:TextBox ID="txtEditTravelDate" class="dob_ctrl"
                                                                                        runat="server" MaxLength="10" Width="100%" Text='<%# Eval("TravelDate") %>'></asp:TextBox>

                                                                                    <ajax:CalendarExtender ID="CalendarExtender2" runat="server" CssClass="req" Enabled="True"
                                                                                        TargetControlID="txtEditTravelDate"></ajax:CalendarExtender>
                                                                                    <ajax:MaskedEditExtender ID="MaskedEditExtender4" runat="server" MaskType="Date"
                                                                                        Mask="99/99/9999" TargetControlID="txtEditTravelDate" Enabled="True" AcceptNegative="None" AutoComplete="false" ClearTextOnInvalid="true" UserDateFormat="MonthDayYear"></ajax:MaskedEditExtender>
                                                                                </td>
                                                                                <td align="left" valign="top">


                                                                                    <asp:TextBox ID="txtEditTravelTime" Width="100%" runat="server" Text='<%# Eval("TravelTime") %>'></asp:TextBox>


                                                                                    <ajax:MaskedEditExtender ID="MENumeric" runat="server" TargetControlID="txtEditTravelTime"
                                                                                        ClearMaskOnLostFocus="true" Mask="9999" MaskType="Number" AutoComplete="false"></ajax:MaskedEditExtender>
                                                                                </td>
                                                                                <td align="left" valign="top">

                                                                                    <asp:Panel ID="Panel1" runat="server" Height="40px" Direction="LeftToRight" ScrollBars="Auto">
                                                                                        <asp:TextBox ID="txtEditReason" onkeydown="ismaxlengthTxtBox(this,'500')" Width="99%" Text='<%# Eval("TimeSpentReason") %>' Height="35px" runat="server" TextMode="MultiLine"></asp:TextBox>


                                                                                    </asp:Panel>
                                                                                </td>
                                                                                <td align="left" valign="top" class="test">
                                                                                    <asp:UpdatePanel ID="upUpdateCancel" runat="server">
                                                                                        <Triggers>
                                                                                            <asp:PostBackTrigger ControlID="btnlstUpdate" />
                                                                                            <asp:PostBackTrigger ControlID="btnlstCancel" />
                                                                                        </Triggers>
                                                                                        <ContentTemplate>

                                                                                            <asp:ImageButton ID="btnlstUpdate"
                                                                                                runat="server" ImageUrl="~/images/updateicon.png" Height="18px" CssClass="edit-update-btn" CommandName="Update" ToolTip="Update"></asp:ImageButton>
                                                                                            <asp:ImageButton ID="btnlstCancel"
                                                                                                runat="server" ImageUrl="~/images/Cancel.png" Height="15px" CssClass="edit-cancel-btn" ToolTip="Cancel" CommandName="Cancel"></asp:ImageButton>
                                                                                        </ContentTemplate>
                                                                                    </asp:UpdatePanel>
                                                                                </td>
                                                                            </tr>
                                                                        </EditItemTemplate>

                                                                    </asp:ListView>

                                                                </ContentTemplate>

                                                            </asp:UpdatePanel>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div style="height: 10px;">
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <br />
                                            <div id="msgTimeSpent" runat="server" visible="False">
                                                <!-- Added By Kuldeep Rathore on 21th May, 2015-->
                                                <asp:Label ID="lblmsg" runat="server" Text="Message" Font-Bold="True"></asp:Label><br />
                                                <hr id="hrtimspent" runat="server" style="height: 2px; border: none; color: #333; background-color: #333;" />
                                                <br />
                                                <asp:Label ID="lblmsgdesc" runat="server" ForeColor="Red"></asp:Label>
                                            </div>
                                        </fieldset>

                                    </td>
                                </tr>
                            </table>

                        </ContentTemplate>




                    </ajax:TabPanel>
                    <ajax:TabPanel ID="tabDocuments" runat="server">
                        <HeaderTemplate>
                            Documents
                        
                        </HeaderTemplate>




                        <ContentTemplate>


                            <fieldset>
                                <legend>Documents</legend>

                                <table width="100%">
                                    <tr>
                                        <td style="width: 30%; text-align: right;">
                                            <label>
                                                Description</label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtDescription" Width="50%" runat="server" ValidateRequestMode="Disabled" MaxLength="255" onkeydown="ismaxlengthTxtBox(this,'255')" TextMode="MultiLine"></asp:TextBox>
                                            <asp:Label ID="lblDecsription" runat="server" EnableViewState="False" ForeColor="Red"></asp:Label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan="2"></td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right;">
                                            <label>
                                                Upload Document</label>
                                        </td>
                                        <td>
                                            <asp:UpdatePanel ID="upAddDoc" runat="server" UpdateMode="Conditional">
                                                <ContentTemplate>
                                                    <asp:FileUpload ID="FUDocuments" Height="20px" runat="server" />
                                                    <asp:Button ID="btnUpload" OnClick="btnUpload_Click"
                                                        Width="100px" Height="25px" runat="server" Text="Upload" OnClientClick="return ValidateFile()" />

                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:PostBackTrigger ControlID="btnUpload" />
                                                </Triggers>
                                            </asp:UpdatePanel>




                                        </td>
                                        <tr>
                                            <td></td>
                                            <td>
                                                <asp:Label ID="lblUploadDoc" runat="server" EnableViewState="False" ForeColor="Red"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" colspan="2">
                                                <asp:Label ID="lblMessage" runat="server" EnableViewState="False" Font-Bold="True" ForeColor="Green"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2"></td>
                                        </tr>
                                    </tr>
                                </table>
                                <table width="100%">
                                    <tr>
                                        <td>
                                            <div class="box-contentlstGrid">
                                                <asp:GridView ID="gvDocuments" runat="server" AutoGenerateColumns="False" CssClass="gridview_home center-table" DataKeyNames="FileFuid" OnRowDataBound="gvDocuments_RowDataBound" OnRowDeleting="gvDocuments_RowDeleting" Width="75%">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Delete">
                                                            <ItemTemplate>
                                                                <asp:ImageButton ID="lnkDelete" runat="server" ToolTip="Delete" CommandName="Delete" Height="20px" ImageUrl="~/images/trash_can.gif" Text="Delete" />
                                                            </ItemTemplate>
                                                            <ItemStyle Width="7%" HorizontalAlign="Center" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="S. No.">
                                                            <ItemTemplate>
                                                                <%# Container.DataItemIndex+1 %>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="7%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="File Type">
                                                            <ItemTemplate>
                                                                <asp:Image ID="imgFiletype" runat="server" />
                                                                <asp:HiddenField ID="HFExtension" runat="server" Value='<%# Eval("FileExtension") %>' />
                                                            </ItemTemplate>
                                                            <ItemStyle Width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="File Name">
                                                            <ItemTemplate>
                                                                <a id="hypFilename" runat="server" style="cursor: pointer; color: darkblue; text-decoration: underline;"><%# Eval("FilesName") %></a>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="30%" />
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="FileDescription" HeaderText="Description">
                                                            <ItemStyle Width="100%" CssClass="WordBreak" />
                                                        </asp:BoundField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </ContentTemplate>
                    </ajax:TabPanel>
                    <%--Added By KP on 23rd Dec 2019(SOW-577), Referring Agency Details Tab--%>
                    <ajax:TabPanel ID="tabRefrringAgency" runat="server">
                        <HeaderTemplate>
                            Referring Agency Details                        
                        </HeaderTemplate>
                        <ContentTemplate>
                            <div id="divNorRecordRefAgency" runat="server" visible="false">
                                <center>No record found.</center>
                            </div>
                            <asp:GridView ID="grdRefrringAgency" DataKeyNames="ReferringAgencyDetailID,ContactInfo,ContactHistoryID" runat="server" Style="margin-top: 10px;"
                                AutoGenerateColumns="false" CssClass="contact_gridview" AllowPaging="false" Width="99%"
                                ShowFooter="false" HeaderStyle-Font-Bold="true" HeaderStyle-ForeColor="White"
                                RowStyle-VerticalAlign="Top" OnRowCancelingEdit="grdRefrringAgency_RowCancelingEdit"
                                OnRowDeleting="grdRefrringAgency_RowDeleting" OnRowEditing="grdRefrringAgency_RowEditing"
                                OnRowUpdating="grdRefrringAgency_RowUpdating" OnRowDataBound="grdRefrringAgency_RowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderText="Contact Info" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="18%">
                                        <EditItemTemplate>
                                            <%--<asp:TextBox ID="txtContactInfo" runat="server" Width="200px" MaxLength="100" Text='<%#Eval("ContactInfo") %>' />--%>
                                            <asp:Label ID="lblContactInfo2" runat="server" Text='<%#Eval("ContactInfo") %>' />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblContactInfo" runat="server" Text='<%#Eval("ContactInfo") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Agency Name" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="25%">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtAgencyName" runat="server" Text='<%#Eval("AgencyName") %>' Width="98%" MaxLength="200" />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblAgencyName" runat="server" Text='<%#Eval("AgencyName") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Contact Name" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="18%">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtContactName" runat="server" Text='<%#Eval("ContactName") %>' Width="98%" MaxLength="100" />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblContactName" runat="server" Text='<%#Eval("ContactName") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Phone Number" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="12%">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtPhoneNumber" runat="server" Text='<%#Eval("PhoneNumber") %>' CssClass="phone_ctrl" Width="98%" MaxLength="13" />
                                            <ajax:MaskedEditExtender ID="MaskedEditExtender9" runat="server"
                                                TargetControlID="txtPhoneNumber" MaskType="None" Mask="(999)999-9999" MessageValidatorTip="true"
                                                ClearMaskOnLostFocus="false" InputDirection="LeftToRight" ErrorTooltipEnabled="True"></ajax:MaskedEditExtender>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblPhoneNumber" runat="server" Text='<%#Eval("PhoneNumber") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Email ID" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="wordWrap" ItemStyle-Width="18%">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtEmail" runat="server" Text='<%#Eval("Email") %>' Width="98%" MaxLength="100" />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblEmail" runat="server" Text='<%#Eval("Email") %>' Style="word-break: break-all; word-wrap: break-word;" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="8%">
                                        <EditItemTemplate>
                                            <asp:ImageButton ID="imgbtnUpdate" CommandName="Update" runat="server" CssClass="edit-update-btn" ImageUrl="~/images/saved.png" ToolTip="Update"
                                                Height="17px" OnClientClick="return ValidateRefAgencyFields(this);" />
                                            <asp:ImageButton ID="imgbtnCancel" runat="server" CommandName="Cancel" CssClass="edit-cancel-btn" Style="margin-left: 10px" ImageUrl="~/images/cancelnew.png" ToolTip="Cancel" Height="13px" OnClientClick ="ShowLoader();" />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgbtnEdit" CommandName="Edit" runat="server" ImageUrl="~/images/editicon.jpg" ToolTip="Edit" Height="20px" Width="20px"  OnClientClick ="ShowLoader();" />
                                            <asp:ImageButton ID="imgbtnDelete" CommandName="Delete" Text="Edit" Style="margin-left: 10px" runat="server" ImageUrl="~/images/trash_can.gif" ToolTip="Delete"
                                                Height="20px" OnClientClick="return ConfirmOnDelete();" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>

                        </ContentTemplate>
                    </ajax:TabPanel>

                </ajax:TabContainer>
                <div id="showHideDiv2" runat="server">
                    <div id="divPopUpContent2" runat="server">
                        <input id="btnClose2" type="button" value="" runat="server" class="close_popmore"
                            onclick="return ShowHideMoreCallhistory();" style="display: none" />
                        <div id="divpopupHeading2" style="display: none; margin: 0 auto; width: 91%;" class="popup_form_heading_history"
                            runat="server">
                            Call History Details
                        </div>
                        <div class="form_block_popup" id="divpnlContact2" runat="server" style="padding: 0 !important;">
                            <div style="padding: 0; margin: 0 0 0 0; min-height: 150px; max-height: 350px; width: 100%; overflow-y: scroll;">
                                <table width="98%" border="1" cellpadding="0" cellspacing="0" class="contact_gridview"
                                    id="grdHistoryDetails" style="border-collapse: collapse;">
                                    <tbody>
                                        <tr>
                                            <td colspan="8"></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="button_bar">
                <table width="100%">
                    <tr>
                        <td align="center" valign="middle">
                            <asp:Button ID="btnCancel" Text="Cancel" runat="server" CssClass="btn_style  " CausesValidation="false"
                                OnClick="btnCancel_Click" />
                            <asp:Button ID="btnSaveAndClose" Text="Save & Close" runat="server" CssClass="btn_style"
                                OnClientClick="return ValidateNDCD();" OnClick="btnSaveAndClose_Click" />
                            <asp:Button ID="btnSave" Text="Save" runat="server" OnClick="btnSave_Click" CssClass="btn_style SaveDirty"
                                OnClientClick="return ValidateNDCD();" />
                            <asp:Button ID="btnPrintPage" runat="server" Text="Print" CssClass="btn_style" CausesValidation="false"
                                OnClick="btnPrintPage_Click" />
                        </td>
                    </tr>
                </table>
            </div>
            <div id="showHideDivCP" runat="server" style="z-index: 9999;">
                <div id="divPopUpContentCP" runat="server">
                    <div class="form_block_popup_ServiceProviderPopup" id="divpnlContactCP" runat="server">
                        <div id="divpopupHeadingCP" style="display: none;" class="popup_form_heading_history_CPPopup"
                            runat="server">
                            Service Providers
                            <input id="btnCloseCP" type="button" value="" runat="server" class="close_popmore"
                                onclick="return ShowHideProviderPopup();" style="display: none; right: 10px;" />
                        </div>
                        <span id="tempid" style="display: none" class="preloader">
                            <p>
                                Please wait...
                            </p>
                        </span>
                        <div style="padding: 0; margin: 0 0 0 0; min-height: 300px; max-height: 500px; width: 100%;"
                            id="containPopup" class="grid_scroll_SearchPop">
                            <label id="lblAgencyCount" style="font-size: 13px">
                            </label>
                            <div id="divTableDataHolder">
                                <table id="tblAgencyDetails" border="1" cellpadding="0" cellspacing="0" style="background-color: #ffffff; border-color: #000000; font-size: 11.0pt; font-family: 'Calibri'; background: white;"
                                    width="100%">
                                    <thead>
                                        <tr>
                                            <th style="color: White; background-color: #1a3895;" width="25%">Agency Name
                                            </th>
                                            <th style="color: White; background-color: #1a3895;" width="25%">Services
                                            </th>
                                            <th style="color: White; background-color: #1a3895;" width="20%">Address
                                            </th>
                                            <th style="color: White; background-color: #1a3895;" width="30%">Contact
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td colspan="2" valign="top"></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div align="center" id="divButton">
                            <br />
                            <input type="button" id="btnExportToExcel" name="btnExportToExcel" onclick="ExportToExcel();"
                                value="Export to Excel" class="multiple_selecter_btn" />
                            <input type="button" id="btnExportToDoc" name="btnExportToDoc" onclick="ExportToDoc();"
                                value="Export to Word" class="multiple_selecter_btn" />
                            <input type="button" id="btnSendEmail" name="btnSendEmail" value="Send Email" onclick="OpenEmailPopup();"
                                class="multiple_selecter_btn" />
                            <input type="button" id="btnPrint" name="btnPrint" value="Print" onclick="PrintFile();"
                                class="multiple_selecter_btn">
                        </div>
                    </div>
                </div>
            </div>

            <%--Added by KP on 22nd Jan 2020(SOW-577), Contact Info Popup--%>
            <div id="divContactInfoParent" runat="server">
                <div id="divPopUpContactInfo" runat="server">
                    <input id="btnCloseContactInfo" type="button" value="" runat="server" class="close_popmore"
                        onclick="return ShowHideContactInfoPopup();" style="display: none" />
                    <div id="divpopupHeadingContactInfo" style="display: none; margin: 0 auto; width: 91%;" runat="server" class="popup_form_heading_ContactInfo">
                        Please select row to fill Referring Agency Details
                    </div>
                    <%--class="popup_form_heading_history"--%>
                    <div class="form_block_popup" id="divpnContactInfo" runat="server" style="padding: 0 !important;">
                        <div style="padding: 0; margin: 0 0 0 0; min-height: 150px; max-height: 350px; width: 100%; overflow-y: scroll;">
                            <table width="99%" align="center" border="1" cellpadding="0" cellspacing="0" class="contact_gridview"
                                id="ContactTypeResultsTable" style="border-collapse: collapse;">
                                <thead>
                                    <tr>
                                        <th style="width: 24%">Contact Info</th>
                                        <th style="width: 24%">Agency Name</th>
                                        <th style="width: 20%">Contact Name</th>
                                        <th style="width: 12%">Phone Number</th>
                                        <th style="width: 20%">Email ID</th>
                                    </tr>
                                </thead>
                            </table>
                            <label id="lblNoRecordContactInfo"></label>
                        </div>
                    </div>
                </div>
            </div>

            <button id="btnUpdate" type="submit" style="display: none;"></button>
        </ContentTemplate>
        <Triggers>

            <asp:PostBackTrigger ControlID="btnCancel" />
            <asp:PostBackTrigger ControlID="btnPrintPage" />
            <asp:PostBackTrigger ControlID="btnSaveContact" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:UpdateProgress AssociatedUpdatePanelID="upPnlMain" ID="updateProgress" runat="server"
        DisplayAfter="0" DynamicLayout="true">
        <ProgressTemplate>
            <div class="loader_bg">
            </div>
            <div class="preloader">
                <p>
                    Please wait...
                </p>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
     
    <%--Added by GK on 26Apr19 : SOW-563--%>
    <script type="text/javascript">

        function BindPopupCustomList() {
            $('#lstAllCustomField').empty();
            if ($("#<%=ddlCustomField.ClientID%> option").length > 1) {
                DisableCustomAction(false);
                $("#<%=ddlCustomField.ClientID%> option").each(function () {
                    if ($(this).val() != "-1")
                        $("#lstAllCustomField").append($('<option></option>').val($(this).val()).html($(this).text()));
                });
            }
            else {
                DisableCustomAction(true);
            }

        }
        function BindCustomDDL() {
            var ddlCustomField = $("#<%=ddlCustomField.ClientID%>");

            $.ajax({
                type: "POST",
                url: "NeedyPerson.aspx/GetCustomField",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{}",
                async: false,
                success: function (data) {
                    var selectedValue = $('#<%=ddlCustomField.ClientID%> option:selected').val();
                    ddlCustomField.empty();
                    ddlCustomField.append($('<option></option>').val("-1").html("--Select--"));
                    $.each(JSON.parse(data.d), function (key, value) {
                        ddlCustomField.append($('<option></option>').val(value.CustomCode).html(value.CustomName));
                    });

                    if ($("#<%=ddlCustomField.ClientID%> option[value='" + selectedValue + "']").length != 0)
                        ddlCustomField.val(selectedValue);
                    //$('#lstAllCustomField').empty();
                },
                error: function (xhr, errorType, exception) {
                    var responseText;
                    var erromessage;
                    try {
                        responseText = jQuery.parseJSON(xhr.responseText);
                        erromessage = "" + errorType + " " + exception + "" + "Exception :" + responseText.ExceptionType + "Message:" + responseText.Message;
                        alert(erromessage);
                    }
                    catch (e) {

                    }
                }
            });
        }

        //Showing custom field information
        function ShowHideCustomField() {
            $("#txtCustomField").val("");
            $("#<%=hdnModifyCF.ClientID %>").val(""); // Remove all from hdnModifyCF
            $("#<%=hdnAddedCFCode.ClientID %>").val(""); // Remove all from hdnAddedCFCode
            $("#<%=hdnAddedCFName.ClientID %>").val(""); // Remove all from hdnAddedCFName
            $("#<%=hdnDeletedCF.ClientID %>").val(""); // Remove all from hdnDeletedCF
            DisableCustomAction(false);

            var divpnlContact = document.getElementById("<%=divpnlContact3.ClientID %>");
            var showHideDiv = document.getElementById("<%=showHideDiv3.ClientID %>");
            var divPopUpContent = document.getElementById("<%=divPopUpContent3.ClientID %>");
            var divpopupHeading = document.getElementById("<%=divpopupHeading3.ClientID %>");
            var btnClose = document.getElementById("<%=btnClose3.ClientID %>");

            if (divpnlContact.style.display == "block") {
                showHideDiv.className = "";
                divPopUpContent.className = "";
                divpnlContact.style.display = "none";
                btnClose.style.display = "none";
                divpopupHeading.style.display = "none";
            }
            else {
                showHideDiv.className = "main_popup_moreHistory";
                divPopUpContent.className = "popup_moreHistory ";
                divpnlContact.style.display = "block";
                btnClose.style.display = "block";
                divpopupHeading.style.display = "block";

                BindPopupCustomList();
            }
        }

        function AddCustomField() {
            HideConfirmBox();
            var txtCustomField = $("#txtCustomField");
            var hdnAddedCFCode = $("#<%=hdnAddedCFCode.ClientID %>");
            var hdnAddedCFName = $("#<%=hdnAddedCFName.ClientID %>");
            var hdnModifyCF = $("#<%=hdnModifyCF.ClientID %>");
            var tempCode = []; var tempName = [];
            if (hdnAddedCFName.val() != "") {
                tempCode = hdnAddedCFCode.val().split(",");
                tempName = hdnAddedCFName.val().split(",");
            }

            var code = "0"; // "0"=newly added custom field
            if (hdnModifyCF.val() != '' && hdnModifyCF.val() != "0") // for update custom field
                code = hdnModifyCF.val();

            $("#lstAllCustomField").append($('<option></option>').val(code).html(txtCustomField.val()));
            tempCode.push(code);
            tempName.push(txtCustomField.val());
            hdnAddedCFCode.val(tempCode.join());
            hdnAddedCFName.val(tempName.join());
            txtCustomField.val("");
            hdnModifyCF.val("");
            DisableCustomAction(false);
        }

        function ModifyCustomField() {
            var hdnModifyCF = $("#<%=hdnModifyCF.ClientID %>");
            var hdnModifyCFText = $("#<%=hdnModifyCFText.ClientID %>");
            var selectedItem = $("#lstAllCustomField option:selected");

            if (selectedItem.val() == undefined) {
                ShowAlert('Please select an option to modify.');
                return;
            }
            else {
                $("#txtCustomField").val(selectedItem.text());
                hdnModifyCFText.val(selectedItem.text());
                hdnModifyCF.val(selectedItem.val());
                //selectedItem.remove();
                RemoveCustomField();
                DisableCustomAction(true);
            }
        }

        function IsUsedCustomField(CustomCodeList) {
            var IsUsed = false;
            var obj = {};
            obj.CustomCodeList = CustomCodeList;

            $.ajax({
                type: "POST",
                url: "NeedyPerson.aspx/IsUsedCustomField",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify(obj),
                async: false,
                success: function (data) {
                    if (data.d != "")
                        IsUsed = true;
                },
                error: function (xhr, errorType, exception) {
                    var responseText;
                    var erromessage;
                    try {
                        responseText = jQuery.parseJSON(xhr.responseText);
                        erromessage = "" + errorType + " " + exception + "" + "Exception :" + responseText.ExceptionType + "Message:" + responseText.Message;
                        alert(erromessage);
                    }
                    catch (e) {

                    }
                }
            });
            return IsUsed;
        }

        function RemoveCustomField() {
            HideConfirmBox();
            var lstAllCustomField = $("#lstAllCustomField");
            var selectedItem = $("#lstAllCustomField option:selected");
            var temp = [];
            var hdnDeletedCF = $("#<%=hdnDeletedCF.ClientID %>");
            if (hdnDeletedCF.val() != "") temp = hdnDeletedCF.val().split(",");
            if (selectedItem.val() != "0") // if existing item removed
            {
                var obj = {};
                obj.CustomCodeList = selectedItem.val();
                $.ajax({
                    type: "POST",
                    url: "NeedyPerson.aspx/IsUsedCustomField",
                    headers: { 'X-Requested-With': 'XMLHttpRequest' },
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: JSON.stringify(obj),
                    success: function (data) {
                        if (data.d != "" && $("#<%=hdnModifyCF.ClientID %>").val() == "") {
                            ShowAlert("Sorry, cannot be removed! The custom name is being used by one or more Person Needing Assistance. If you would like to remove, then please disassociate from all the Person Needing Assistance first.");
                            return;
                        }
                        else {
                            var hdnModifyCF = $("#<%=hdnModifyCF.ClientID %>");
                            if (hdnModifyCF.val() != selectedItem.val()) {
                                temp.push(selectedItem.val());
                                hdnDeletedCF.val(temp.join());
                            }
                            selectedItem.remove();
                            lstAllCustomField.selectedIndex = -1;
                        }
                    },
                    error: function (xhr, errorType, exception) {
                        var responseText;
                        var erromessage;
                        try {
                            responseText = jQuery.parseJSON(xhr.responseText);
                            erromessage = "" + errorType + " " + exception + "" + "Exception :" + responseText.ExceptionType + "Message:" + responseText.Message;
                            alert(erromessage);
                        }
                        catch (e) {

                        }
                    }
                });
            }
            else // if newly added item removed
            {
                var hdnAddedCFCode = $("#<%=hdnAddedCFCode.ClientID %>");
                var hdnAddedCFName = $("#<%=hdnAddedCFName.ClientID %>");
                if (hdnAddedCFName.val() != "") {
                    var tempCode = hdnAddedCFCode.val().split(",");
                    var tempName = hdnAddedCFName.val().split(",");
                    for (var i = 0; i < tempName.length; i++) {
                        if (tempName[i] === selectedItem.text()) {
                            tempCode.splice(i, 1);
                            tempName.splice(i, 1);
                        }
                    }
                    hdnAddedCFCode.val(tempCode.join());
                    hdnAddedCFName.val(tempName.join());
                }
                selectedItem.remove();
                lstAllCustomField.selectedIndex = -1;
            }
            if ($("#lstAllCustomField option").length > 0) {
                DisableCustomAction(false);
            } else {
                DisableCustomAction(true);
            }
        }

        function RemoveAllCustomField() {
            HideConfirmBox();
            var pData = [];
            $("#lstAllCustomField option").each(function () {
                if ($(this).val() != "0") // if existing item removed
                    pData.push($(this).val());
            });
            var obj = {};
            obj.CustomCodeList = pData.join();
            $.ajax({
                type: "POST",
                url: "NeedyPerson.aspx/IsUsedCustomField",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                data: JSON.stringify(obj),
                success: function (data) {
                    pData = data.d.split(',');
                    var temp = [];
                    var hdnDeletedCF = $("#<%=hdnDeletedCF.ClientID %>");
                    if (hdnDeletedCF.val() != "") temp = hdnDeletedCF.val().split(",");
                    $("#lstAllCustomField option[value='0']").remove(); // Remove all newly added items first.
                    $("#lstAllCustomField option").each(function () {
                        if ($(this).val() != "0" && pData.indexOf($(this).val()) == -1) // if existing item removed && this custom field not in use
                        {
                            temp.push($(this).val());
                            $("#lstAllCustomField option[value='" + $(this).val() + "']").remove();
                        }
                    });
                    $("#<%=hdnAddedCFCode.ClientID %>").val(""); // Remove all from hdnAddedCFCode
                    $("#<%=hdnAddedCFName.ClientID %>").val(""); // Remove all from hdnAddedCFName
                    hdnDeletedCF.val(temp.join());
                },
                error: function (xhr, errorType, exception) {
                    var responseText;
                    var erromessage;
                    try {
                        responseText = jQuery.parseJSON(xhr.responseText);
                        erromessage = "" + errorType + " " + exception + "" + "Exception :" + responseText.ExceptionType + "Message:" + responseText.Message;
                        alert(erromessage);
                    }
                    catch (e) {

                    }
                }
            });
            if ($("#lstAllCustomField option").length > 0) {
                DisableCustomAction(false);
            } else {
                DisableCustomAction(true);
            }
        }

        function DisableCustomAction(isEnable) {
            $("#btnModifyCF").attr("disabled", isEnable);
            $("#btnRemoveCF").attr("disabled", isEnable);
            $("#btnRemoveAllCF").attr("disabled", isEnable);
        }

        function SubmitCustomField() {
            var hdnAddedCFCode = $("#<%=hdnAddedCFCode.ClientID %>");
            var hdnAddedCFName = $("#<%=hdnAddedCFName.ClientID %>");
            var hdnModifyCF = $("#<%=hdnModifyCF.ClientID %>");
            var hdnDeletedCF = $("#<%=hdnDeletedCF.ClientID %>");

            if (hdnAddedCFName.val() == "" && hdnDeletedCF.val() == "") {
                // alert("Can't Submit! No Action performed.");
                ShowAlert("Can't Submit! No Action performed.");
            }

            var obj = {};
            obj.AddedCodeList = hdnAddedCFCode.val();
            obj.AddedNameList = hdnAddedCFName.val();
            obj.DeletedList = hdnDeletedCF.val()

            $.ajax({
                type: "POST",
                url: "NeedyPerson.aspx/SubmitCustomField",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                data: JSON.stringify(obj),
                async: true,
                success: function (data) {
                    if (data.d == true) {
                        $("#<%=hdnAddedCFName.ClientID %>").val(""); // Remove all from hdnAddedCFName
                        $("#<%=hdnDeletedCF.ClientID %>").val(""); // Remove all from hdnDeletedCF
                        ShowHideCustomField();
                        BindCustomDDL();
                    }
                },
                error: function (xhr, errorType, exception) {
                    var responseText;
                    var erromessage;
                    try {
                        responseText = jQuery.parseJSON(xhr.responseText);
                        erromessage = "" + errorType + " " + exception + "" + "Exception :" + responseText.ExceptionType + "Message:" + responseText.Message;
                        alert(erromessage);
                    }
                    catch (e) {

                    }
                }
            });
        }
        function ShowConfirmBox(Type) {
            document.getElementById("btnYesPopupConfirm").removeEventListener("click", RemoveCustomField, false);
            document.getElementById("btnYesPopupConfirm").removeEventListener("click", RemoveAllCustomField, false);
            document.getElementById("btnYesPopupConfirm").removeEventListener("click", AddCustomField, false);
            if (Type == "RemoveAllCF") {
                if ($("#lstAllCustomField option").length < 1) {
                    ShowAlert("No items in Custom List Options to remove.");
                    return;
                }
                $("#divalertConfirm").css("display", "block");
                $("#divoverlaysuccess").css("display", "block");
                $("#spnMessageConfirm").html("Are you sure you want to remove all the custom fields?<br/><br/>The custom names used by one or more Person Needing Assistance will not be removed.");
                document.getElementById("btnYesPopupConfirm").addEventListener("click", RemoveAllCustomField, false);
                document.getElementById("btnNoPopupConfirm").addEventListener("click", HideConfirmBox, false);
            }
            if (Type == "RemoveCF") {
                var selectedItem = $("#lstAllCustomField option:selected");
                if (selectedItem.val() == undefined) {
                    ShowAlert("Please select an option to remove.");
                    return;
                }
                $("#divalertConfirm").css("display", "block");
                $("#divoverlaysuccess").css("display", "block");
                $("#spnMessageConfirm").text("Are you sure you want to remove the selected custom field?");
                document.getElementById("btnYesPopupConfirm").addEventListener("click", RemoveCustomField, false);
                document.getElementById("btnNoPopupConfirm").addEventListener("click", HideConfirmBox, false);
            }
            if (Type == "AddCF") {
                var txtCustomField = $("#txtCustomField");
                var hdnModifyCF = $("#<%=hdnModifyCF.ClientID %>");
                var hdnModifyCFText = $("#<%=hdnModifyCFText.ClientID %>");
                if (txtCustomField.val().trim() == "") {
                    ShowAlert("You cannot add a blank entry -- please enter a custom name.");
                    txtCustomField.focus();
                    return;
                }
                if (txtCustomField.val().trim().indexOf(",") != -1) {
                    ShowAlert("Comma not allowed!");
                    return;
                }
                // block adding duplicate custom field
                var alreadyExist = false;
                $("#lstAllCustomField option").each(function () {
                    if (txtCustomField.val().toLowerCase() == $(this).text().toLowerCase()) alreadyExist = true;
                });
                if (alreadyExist) {
                    ShowAlert(txtCustomField.val() + ' is already in the options list. Please add a different name.');
                    return;
                }
                if (IsUsedCustomField(hdnModifyCF.val()) && hdnModifyCFText.val() != txtCustomField.val()) {
                    $("#divalertConfirm").css("display", "block");
                    $("#divoverlaysuccess").css("display", "block");
                    $("#spnMessageConfirm").html("This custom name may be associated with one or more Person Needing Assistance and the new custom name will reflect to all the associated Person Needing Assistance.</br></br>Are you sure you want to modify this custom name?");
                    document.getElementById("btnYesPopupConfirm").addEventListener("click", AddCustomField, false);
                    document.getElementById("btnNoPopupConfirm").addEventListener("click", HideConfirmBox, false);
                }
                else {
                    AddCustomField();
                }
            }
        }
        function HideConfirmBox() {
            $("[id*=lblMsgConfirm]").text();
            $("#divalertConfirm").css("display", "none");
            $("#divoverlaysuccess").css("display", "none");
        }
        function DisableEnterKeyOnInput() {
            $("input").keypress(function (evt) {
                //create a variable to hold the number of the key that was pressed      
                var key;
                //if the users browser is internet explorer 
                if (window.event) {
                    //store the key code (Key number) of the pressed key 
                    key = window.event.keyCode;
                    //otherwise, it is firefox 
                } else {
                    //store the key code (Key number) of the pressed key 
                    key = e.which;
                }
                //if key 13 is pressed (the enter key) 
                if (key == 13) {
                    //do nothing 
                    return false;
                    //otherwise 
                } else {
                    //continue as normal (allow the key press for keys other than "enter") 
                    return true;
                }
                //and don't forget to close the function     
            });
        }
    </script>  
   
</asp:Content>
