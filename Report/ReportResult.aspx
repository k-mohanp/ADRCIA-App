<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportResult.aspx.cs" EnableEventValidation="false"
    Inherits="Report_ReportResult" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../Scripts/jquery-3.6.0.min.js"></script>
    <%--<script src="../Scripts/jquery-1.11.1.min.js" type="text/javascript"></script>--%>

    <style type="text/css">
        .Title {
            font-weight: bold;
        }

        .Anchor {
            color: Blue;
            font-size: 12px;
            cursor: pointer;
            text-decoration: underline;
            background-color: transparent;
            text-decoration: underline;
            border: none;
        }

        .WordBreak {
            -ms-word-break: break-word;
            word-break: break-word;
            -ms-word-wrap: break-word;
            word-wrap: break-word;
        }
        .rptBase tbody tr td
        {
            width:200px;
        }
        .rptBase tr td input[type="checkbox"] {
            float:left;
        }
        .rptBase tr td label {
            float:left;
            width:158px;
            margin-top:3px;
        }
        .chkAll input[type="checkbox"] {
            float:left
        }
        .chkAll label{
            float:left;
            display:inline-block;
            margin-top:3px;
        }
        .Norecord{
            display:inline !important;
            text-align: center;
        }
    </style>

    <script type="text/javascript">
        var clickCommand = '';
        var DupServiceCountClickId = '';
        var DupOtherServiceCountClickId = '';

        //Added by KP on 13th March 2020(SOW-577)
        $(document).ready(function () {  
            $("#trReportSelectionField").hide();//by defualt hide.   
        });

        //Added by KP on 21st Apr 2020(SOW-577), Check All checkbox filter items including individual section 
        //like Contact Person Details, Personal Details etc.checkbox. 
        function CheckUncheckAllFilters(chkId) {
            $(".chkAllFilters input:checkbox").prop('checked', $('#' + chkId).is(":checked"));
        }
        
        //Added by KP on 13th March 2020(SOW-577), Check/Uncheck the list items, when click for All selection.  
        function CheckUncheckItemsBox(chkAllBoxId, chkItemsBoxId) {

            if ($('#' + chkAllBoxId).is(":checked")) {
                $("[id*=" + chkItemsBoxId + "] input").prop("checked", true);
            } else {
                $("[id*=" + chkItemsBoxId + "] input").prop("checked", false);
            }

            //Check/Uncheck the 'Check ALL', whenever filter checkbox is Checked/Unchecked.
            if($(".chkAllFilters input:checkbox").length == $(".chkAllFilters input:checked").length)
                $("[id*=chkAllFilter]").prop("checked", true);
            else
                $("[id*=chkAllFilter]").prop("checked", false);
        }
        //Added by KP on 13th March 2020(SOW-577), Check/Uncheck the all box, when click for items selection.  
        function CheckUncheckAllBox(chkAllBoxId, chkItemsBoxId) {

            if ($("[id*=" + chkItemsBoxId + "] input:checked").length == $("[id*=" + chkItemsBoxId + "] input").length) {
                $("[id*=" + chkAllBoxId + "]").prop("checked", true);
            } else {
                $("[id*=" + chkAllBoxId + "]").prop("checked", false);
            }

            //Check/Uncheck the 'Check ALL', whenever filter checkbox is Checked/Unchecked.
            if($(".chkAllFilters input:checkbox").length == $(".chkAllFilters input:checked").length)
                $("[id*=chkAllFilter]").prop("checked", true);
            else
                $("[id*=chkAllFilter]").prop("checked", false);

        }

        //Added by KP on 13th March 2020(SOW-577), Validate and then click the event to generate excel.
        function Validate()
        {
            //debugger;
            if ($(".rptBase input:checked").length == 0) {
                alert('Please select Person Needy Assistance details column to view.');                
            }
            else if (clickCommand == 'commonType') {
                    $("#TRecords").click();
            }            
            else if (clickCommand == 'Duplicate') {
                $("#btnDuplicate").click();
            }
            else if (clickCommand == 'UnDupeClient') {
                $("#btnUnDupeClient").click();
            } 
            else if (clickCommand == 'TotalContacts') {
                $("#btnTotalContacts").click();
            }
            else if (clickCommand == 'UnDuplicateNPService') {
                $("#btnUnDuplicateNPService").click();
            } 
            else if (clickCommand == 'DuplicateNPService') {
                $("#" + DupServiceCountClickId).click();
            }
            else if (clickCommand == 'DuplicateNPOtherService') {
                $("#" + DupOtherServiceCountClickId).click();
            }
            
            return false;
        }

        //Added by KP on 13th March 2020(SOW-577), Onclick of report selection link, show/hide the report selection field section.
        function OpenHideReportSelection(cmd, closePopup, thisObj)
        {
            //debugger;
            DupServiceCountClickId = DupOtherServiceCountClickId = '';

            if (closePopup && (clickCommand != cmd || cmd =="DuplicateNPService" || cmd =="DuplicateNPOtherService")) {
                $("#trReportSelectionField").hide();
                clearFilterSelection();
            }            
            //clickCommand = cmd;
            if (cmd == 'Duplicate') {
                var $el = $("#trReportSelectionField").clone();
                $("#trReportSelectionField").remove();
                $('#tblDuplicateFilter').append($el);
                $('#trDuplicateFilter').show();
            }
            else if (cmd == 'UnDupeClient') {
                var $el = $("#trReportSelectionField").clone();
                $("#trReportSelectionField").remove();
                $('#tblUnDupeClientFilter').append($el);
                $('#trUnDupeClientFilter').show();
            }
            else if (cmd == 'TotalContacts') {
                var $el = $("#trReportSelectionField").clone();
                $("#trReportSelectionField").remove();
                $('#tblTotalContactsFilter').append($el);
                $('#trTotalContactsFilter').show();
            }
            else if (cmd == 'UnDuplicateNPService') {
                var $el = $("#trReportSelectionField").clone();
                $("#trReportSelectionField").remove();
                $('#tblUnDuplicateNPServiceFilter').append($el);
                $('#trUnDuplicateNPServiceFilter').show();
            }
            else if (cmd == 'DuplicateNPService') {                
                if (clickCommand != cmd) {//clickCommand != "" && 
                    var $el = $("#trReportSelectionField").clone();
                    $("#trReportSelectionField").remove();
                    $('#tblDuplicateNPServiceFilter').append($el);
                }
                $('#trDuplicateNPServiceFilter').show();
                DupServiceCountClickId = thisObj.id.replace('aDupePersonCount', 'ancDupePersonCount');
            }
            else if (cmd == 'DuplicateNPOtherService') {                
                if (clickCommand != cmd) {//clickCommand != "" && 
                    var $el = $("#trReportSelectionField").clone();
                    $("#trReportSelectionField").remove();
                    $('#tblDuplicateNPOtherServiceFilter').append($el);
                }
                $('#trDuplicateNPOtherServiceFilter').show();
                DupOtherServiceCountClickId = thisObj.id.replace('aOtherServiceDupePersonCount', 'ancOtherServiceDupePersonCount');
            }

            if ($("#trReportSelectionField").is(':visible'))
                $("#trReportSelectionField").hide();
            else
                $("#trReportSelectionField").show();

            clickCommand = cmd;

        }

        //Added by KP on 13th March 2020(SOW-577)
        function CloseFilterSelection() {
             if ($("#trReportSelectionField").is(':visible'))
                $("#trReportSelectionField").hide();
        }

        //Added by KP on 13th March 2020(SOW-577)
        function clearFilterSelection()
        {
            $(".chkAll input:checked").prop("checked", false);
            $(".rptBase input:checked").prop("checked", false);    
            $("[id*=chkAllFilter]").prop("checked", false);
        }

    </script>

    <script type="text/javascript">
        /*
        Created by SA on 25th July, 2K14.
        Purpose: To Show/Hide Details.
        Parameters: id : Anchor ID & sid : Div ID
        */

        function ShowHide(id, sid) {
            $('#' + sid + '').toggle(function (e) {

                if ($(this).is(":visible")) {
                    $('#' + sid + '').show("slow");
                    $('#' + id + '').text("Hide Details");
                }
                else {
                    $('#' + sid + '').hide("slow");
                    $('#' + id + '').text("View Details");
                };
            });
        }
        //Simply Hide the Div...
        function Hide(id, sid) {

            $('#' + sid + '').hide("slow");
            $('#' + id + '').text("View Details");
        }        
    </script>
</head>
<body>
    <form id="form1" runat="server">

        <table width="100%" style="font-family: Verdana; font-size: 10px;">
            <tr>
                <td style="padding-left: 50px;">

                    <table width="100%">
                        <tr>
                            <td>
                                <div id="ExcelData" runat="server">
                                    <table width="100%" id="tblInfo">
                                        <tr>
                                            <td width="18%" class="Title">
                                                <span>Report Type</span>
                                            </td>
                                            <td width="2%">
                                                <strong>:</strong>
                                            </td>
                                            <td width="40%" colspan="2">
                                                <asp:Label ID="lblReportType" runat="server"></asp:Label>
                                                <asp:Label ID="lbldupundup" runat="server"></asp:Label>
                                            </td>
                                            <td width="40%" align="right">
                                                <%--<b>Date Report Run : </b>--%>
                                                <%--<asp:Label ID="lblDateReportRun" runat="server"></asp:Label>--%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="Title" colspan="5" style="background-color: Gray; color: White;">Filter Conditions:
                                            </td>
                                        </tr>
                                        <tr id="Agency" runat="server">
                                            <td class="Title" align="left" valign="top">Agency&nbsp;
                                            </td>
                                            <td valign="top">
                                                <strong>:</strong>
                                            </td>
                                            <td colspan="3">&nbsp;<asp:Label ID="lblAgency" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="Title" align="left">County&nbsp;
                                            </td>
                                            <td>
                                                <b>:</b>
                                            </td>
                                            <td colspan="3">&nbsp;<asp:Label ID="lblCounty1" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="Title" align="left">City&nbsp;
                                            </td>
                                            <td>
                                                <b>:</b>
                                            </td>
                                            <td colspan="3">&nbsp;<asp:Label ID="lblCity1" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="Title" align="left">Township&nbsp;
                                            </td>
                                            <td>
                                                <b>:</b>
                                            </td>
                                            <td colspan="3">&nbsp;<asp:Label ID="lblTownship" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="Title" align="left">Custom Field&nbsp;
                                            </td>
                                            <td>
                                                <b>:</b>
                                            </td>
                                            <td colspan="3">&nbsp;<asp:Label ID="lblCustomField" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="Title" align="left" valign="top">Service&nbsp;
                                            </td>
                                            <td valign="top">
                                                <b>:</b>
                                            </td>
                                            <td colspan="3">&nbsp;<asp:Label ID="lblService1" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                         <tr>
                                            <td class="Title" align="left" valign="top">Other Service&nbsp;
                                            </td>
                                            <td valign="top">
                                                <b>:</b>
                                            </td>
                                            <td colspan="3">&nbsp;<asp:Label ID="lblOtherService1" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="Title" align="left" valign="top">Referred By&nbsp;</td>
                                            <td valign="top"><b>:</b></td>
                                            <td colspan="3">&nbsp;<asp:Label ID="lblReferredBy" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td class="Title" align="left" valign="top">Referred To&nbsp;
                                            </td>
                                            <td valign="top">
                                                <b>:</b>
                                            </td>
                                            <td colspan="3">&nbsp;<asp:Label ID="lblRefferedTo" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="Title" align="left">Staff&nbsp;
                                            </td>
                                            <td>
                                                <b>:</b>
                                            </td>
                                            <td colspan="3">&nbsp;<asp:Label ID="lblStaff1" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="Title">
                                                <span>Report Period</span>
                                            </td>
                                            <td>
                                                <strong>:</strong>
                                            </td>
                                            <td colspan="3">&nbsp;<asp:Label ID="lblReportPeriod" runat="server"></asp:Label>&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="Title">Date Report Run
                                            </td>
                                            <td>
                                                <b>:</b>
                                            </td>
                                            <td colspan="3">&nbsp;<asp:Label ID="lblDateReportRun" runat="server"></asp:Label>&nbsp;
                                            </td>
                                        </tr>
                                        <tr id="trDuplicate" runat="server" visible="false">
                                            <td class="Title">Duplicated Client Count
                                            </td>
                                            <td>
                                                <b>:</b>
                                            </td>
                                            <td colspan="3">
                                                <table style="width:100%">
                                                    <tr>
                                                        <td style="width:20px">
                                                            &nbsp;<asp:Label ID="lblDuplicateCount" runat="server">0</asp:Label>&nbsp;
                                                        </td>
                                                        <td style="width:90%">
                                                            <a id="aDuplicate" href="javascript:void(0);" onclick="OpenHideReportSelection('Duplicate',true);" runat="server" style="font-size:12px"></a>                                                  
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>                                            
                                        </tr>

                                        <%--Added by KP on 18th March 2020(SOW-577), Do not remove this block, as this is used to display report selection filter dynamically for 'Duplicated Client Count'--%> 
                                        <tr id="trDuplicateFilter" style="display:none">
                                            <td colspan="5" width="100%">
                                                <table id="tblDuplicateFilter" width="100%">
                                                </table>
                                            </td>
                                        </tr> <%-- End(SOW-577)--%>
                                       
                                        <tr id="trUnDupeClient" runat="server" visible="false">
                                            <td class="Title">Unduplicated Client Count
                                            </td>
                                            <td>
                                                <b>:</b>
                                            </td>
                                            <td colspan="3">
                                                <table style="width:100%">
                                                    <tr>
                                                        <td style="width:20px">
                                                           &nbsp;<asp:Label ID="lblUnDupeClient" runat="server">0</asp:Label>&nbsp;
                                                        </td>
                                                        <td style="width:90%">
                                                            <a id="aUnDupeClient" href="javascript:void(0);" onclick="OpenHideReportSelection('UnDupeClient',true);" runat="server" style="font-size:12px"></a>                                                  
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>   
                                        </tr>
                                        
                                        <%--Added by KP on 18th March 2020(SOW-577), Do not remove this block, as this is used to display report selection filter dynamically for 'Unduplicated Client Count'--%> 
                                        <tr id="trUnDupeClientFilter" style="display:none">
                                            <td colspan="5" width="100%">
                                                <table id="tblUnDupeClientFilter" width="100%">
                                                </table>
                                            </td>
                                        </tr> <%-- End(SOW-577)--%>

                                         <%-- //added by BS on 9-9-2016 --%>
                                        <tr id="trTotalContacts" runat="server" visible="false">
                                             <td class="Title">Total Contacts
                                            </td>
                                            <td>
                                                <b>:</b>
                                            </td>
                                            <td colspan="3">
                                                <table style="width:100%">
                                                    <tr>
                                                        <td style="width:20px">
                                                           &nbsp;<asp:Label ID="lblTotalContacts" runat="server">0</asp:Label>&nbsp;
                                                        </td>
                                                        <td style="width:90%">
                                                            <a id="aTotalContacts" href="javascript:void(0);" onclick="OpenHideReportSelection('TotalContacts',true);" runat="server" style="font-size:12px"></a>                                                
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td> 
                                        </tr>
                                        <%--Added by KP on 23rd March 2020(SOW-577), Do not remove this block, as this is used to display report selection filter dynamically for 'Total Contacts'--%> 
                                        <tr id="trTotalContactsFilter" style="display:none">
                                            <td colspan="5" width="100%">
                                                <table id="tblTotalContactsFilter" width="100%">
                                                </table>
                                            </td>
                                        </tr> <%-- End(SOW-577)--%>

                                        <%-- //added by SA on 8th Dec, 2015 SOW-401 --%>
                                        <tr id="trUnDuplicateNPService" runat="server" visible="false">
                                            <td class="Title">Unduplicated Service Count
                                            </td>
                                            <td>
                                                <b>:</b>
                                            </td>
                                            <td colspan="3">
                                                <table style="width:100%">
                                                    <tr>
                                                        <td style="width:20px">
                                                           &nbsp;<asp:Label ID="lblUnDuplicateNPService" runat="server">0</asp:Label>&nbsp;
                                                        </td>
                                                        <td style="width:90%">
                                                            <a id="aUnDuplicateNPService" href="javascript:void(0);" onclick="OpenHideReportSelection('UnDuplicateNPService',true);" runat="server" style="font-size:12px"></a>                                                
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <%--Added by KP on 23rd March 2020(SOW-577), Do not remove this block, as this is used to display report selection filter dynamically for 'Unduplicated Service Count'--%> 
                                        <tr id="trUnDuplicateNPServiceFilter" style="display:none">
                                            <td colspan="5" width="100%">
                                                <table id="tblUnDuplicateNPServiceFilter" width="100%">
                                                </table>
                                            </td>
                                        </tr> <%-- End(SOW-577)--%>
                                        
                                        <%-- //added by SA on 8th Dec, 2015 SOW-401 --%>
                                        <tr id="trDuplicateNPService" runat="server" visible="false">
                                            <td class="Title" style="line-height:20px">Duplicated Service Count
                                            </td>
                                            <td>
                                                <b>:</b>
                                            </td>
                                            <td>&nbsp;<asp:Label ID="lblDuplicateNPService" runat="server">0</asp:Label>&nbsp;
                                            </td>
                                            <td colspan="2">
                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="5">
                                                <div id="divDupeService" runat="server" style="text-align: left; display: block;">
                                                    <asp:GridView ID="DLDupeService" Width="75%" DataKeyNames="NeedyPersonId,ContactHistoryId" runat="server" AutoGenerateColumns="false">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Service Name">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblServiceName" runat="server" Text='<%# Eval("ServiceName") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Duplicate Person Count">
                                                                <ItemTemplate>
                                                                    <a id="aDupePersonCount" href="javascript:void(0);" onclick="OpenHideReportSelection('DuplicateNPService',true,this);" 
                                                                        runat="server" title='<%# filterLinkText %>' ><%# Eval("NeedyPersonCount") %></a>
                                                                    <input id="ancDupePersonCount" type="button" class="Anchor" onserverclick="ancDupePersonCount_ServerClick"
                                                                        runat="server" value="" />
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                        </Columns>

                                                    </asp:GridView>                                                    
                                                </div>
                                            </td>
                                        </tr>
                                        <%--Added by KP on 23rd March 2020(SOW-577), Do not remove this block, as this is used to display report selection filter dynamically for 'Duplicated Service Count'--%> 
                                        <tr id="trDuplicateNPServiceFilter" style="display:none">
                                            <td colspan="5" width="100%">
                                                <table id="tblDuplicateNPServiceFilter" width="100%">
                                                </table>
                                            </td>
                                        </tr> 
                                        
                                        <%-- Added by KP on 15th April 2020(SOW-577), Other Service & Needy Person Count --%>
                                        
                                        <tr id="trDuplicateNPOtherService" runat="server" visible="false" style="padding:6px 0;">
                                            <td class="Title" style="line-height:26px">Other Service Count
                                            </td>
                                            <td><b>:</b></td>
                                            <td>&nbsp;<asp:Label ID="lblDuplicateNPOtherService" runat="server">0</asp:Label>&nbsp;
                                            </td>
                                            <td colspan="2"></td>
                                        </tr>
                                        
                                        <tr>
                                            <td colspan="5">
                                                <div id="divDupeOtherService" runat="server" style="text-align: left; display: block;">
                                                    <asp:GridView ID="DLDupeOtherService" Width="75%" DataKeyNames="NeedyPersonId,ContactHistoryId" runat="server" AutoGenerateColumns="false">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Other Service Name">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblOtherServiceName" runat="server" Text='<%# Eval("OtherServiceName") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Person Count">
                                                                <ItemTemplate>
                                                                    <a id="aOtherServiceDupePersonCount" href="javascript:void(0);" onclick="OpenHideReportSelection('DuplicateNPOtherService',true,this);" 
                                                                        runat="server" title='<%# filterLinkText %>' ><%# Eval("NeedyPersonCount") %></a>
                                                                    <input id="ancOtherServiceDupePersonCount" type="button" class="Anchor" onserverclick="ancOtherServiceDupePersonCount_ServerClick"
                                                                        runat="server" value="" />
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>                                                    
                                                </div>
                                            </td>
                                        </tr>
                                        <%--Added by KP on 15th April 2020(SOW-577), Do not remove this block, as this is used to display report selection filter dynamically for 'Duplicated Other Service Count'--%> 
                                        <tr id="trDuplicateNPOtherServiceFilter" style="display:none">
                                            <td colspan="5" width="100%">
                                                <table id="tblDuplicateNPOtherServiceFilter" width="100%">
                                                </table>
                                            </td>
                                        </tr> 
                                        <%-- End(SOW-577)--%>

                                    </table>

                                    <table id="tblAdvanceFilter" runat="server" visible="false" width="100%" cellpadding="0"
                                        cellspacing="0" border="1">
                                        <tr>
                                            <td colspan="2" align="center" style="background-color: Gray; color: White;" class="Title">
                                                <b>Advance Filter</b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="50%">
                                                <table width="100%">                                                    
                                                    <tr>
                                                        <td width="30%" class="Title" valign="top">Contact Method
                                                        </td>
                                                        <td width="2%" class="Title" valign="top">:
                                                        </td>
                                                        <td width="68%">
                                                            <asp:Label ID="lblContactMethod" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="Title" valign="top">Age as of
                                                        </td>
                                                        <td class="Title" valign="top">:
                                                        </td>
                                                        <td >
                                                            <div>
                                                                <span class="Title">Date: </span>
                                                                <asp:Label ID="lblDate" runat="server"></asp:Label>
                                                            </div>
                                                            <div>
                                                                <span class="Title">Age Range: </span>
                                                                <asp:Label ID="lblAgeRange" runat="server"></asp:Label>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="Title">Gender
                                                        </td>
                                                        <td class="Title">:
                                                        </td>
                                                        <td >
                                                            <asp:Label ID="lblGender" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="15%" class="Title" valign="top">Marital Status
                                                        </td>
                                                        <td width="2%" class="Title" valign="top">:
                                                        </td>
                                                        <td width="83%">
                                                            <asp:Label ID="lblMaritalStatus" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="15%" class="Title" valign="top">Living Arrangement
                                                        </td>
                                                        <td width="2%" class="Title" valign="top">:
                                                        </td>
                                                        <td width="83%">
                                                            <asp:Label ID="lblLivingArrangement" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td width="15%" class="Title" valign="top">Referred for OC
                                                        </td>
                                                        <td width="2%" class="Title" valign="top">:
                                                        </td>
                                                        <td width="83%">
                                                            <asp:Label ID="lblReferredforOC" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>

                                                     <tr>
                                                        <td width="15%" class="Title" valign="top">Funds Provided
                                                        </td>
                                                        <td width="2%" class="Title" valign="top">:
                                                        </td>
                                                        <td width="83%">
                                                            <asp:Label ID="lblIsFundProvided" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                     <tr>
                                                        <td width="15%" class="Title" valign="top">Funds Utilized for
                                                        </td>
                                                        <td width="2%" class="Title" valign="top">:
                                                        </td>
                                                        <td width="83%">
                                                            <asp:Label ID="lblFundsUtilizedfor" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="15%" class="Title" valign="top">Funds Provided Amount
                                                        </td>
                                                        <td width="2%" class="Title" valign="top">:
                                                        </td>
                                                        <td width="83%">
                                                            <asp:Label ID="lblFundsAmount" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                     <tr>
                                                        <td width="15%" class="Title" valign="top">Funds Provided Date
                                                        </td>
                                                        <td width="2%" class="Title" valign="top">:
                                                        </td>
                                                        <td width="83%">
                                                            <asp:Label ID="lblFundsDate" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="50%" valign="top">
                                                <table width="100%">
                                                    <tr>
                                                        <td width="30%" class="Title" valign="top">Demographics
                                                        </td>
                                                        <td width="2%" class="Title" valign="top">:
                                                        </td>
                                                        <td width="68%">
                                                            <asp:Label ID="lblNoDemographics" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="30%" class="Title" valign="top">Race
                                                        </td>
                                                        <td width="2%" class="Title" valign="top">:
                                                        </td>
                                                        <td width="68%">
                                                            <asp:Label ID="lblRace" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="30%" class="Title" valign="top">Primary Language</td>
                                                        <td width="2%" class="Title" valign="top">:</td>
                                                        <td width="68%">
                                                            <asp:Label ID="lblPrimaryLanguage" CssClass="WordBreak" runat="server"></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <td width="15%" class="Title">Ethnicity
                                                        </td>
                                                        <td width="2%" class="Title">:
                                                        </td>
                                                        <td width="83%">
                                                            <asp:Label ID="lblEthnicity" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="15%" class="Title">Veteran Applicable
                                                        </td>
                                                        <td width="2%" class="Title">:
                                                        </td>
                                                        <td width="83%">
                                                            <asp:Label ID="lblVeteranApplicable" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="15%" class="Title" valign="top">Veteran
                                                        </td>
                                                        <td width="2%" class="Title" valign="top">:
                                                        </td>
                                                        <td width="83%">
                                                            <asp:Label ID="lblVeteranStatus" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="15%" class="Title" valign="top">Caregiver Status
                                                        </td>
                                                        <td width="2%" class="Title" valign="top">:
                                                        </td>
                                                        <td width="83%">
                                                            <asp:Label ID="lblCaregiverNeedyPerson" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="15%" class="Title">Service Need Met
                                                        </td>
                                                        <td width="2%" class="Title">:
                                                        </td>
                                                        <td width="83%">
                                                            <asp:Label ID="lblServiceNeedMet" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="15%" class="Title">Follow Up
                                                        </td>
                                                        <td width="2%" class="Title">:
                                                        </td>
                                                        <td width="83%">
                                                            <asp:Label ID="lblFollowUp" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="15%" class="Title">Referred for OC Date
                                                        </td>
                                                        <td width="2%" class="Title">:
                                                        </td>
                                                        <td width="83%">
                                                            <asp:Label ID="lblReferredforOCDate" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    
                                                </table>
                                            </td>                                            
                                        </tr>
                                        <tr>
                                            <td colspan="2" width="100%">
                                                <table width="100%">
                                                    <tr>
                                                        <td width="15%" class="Title" valign="top">Contact Type
                                                        </td>
                                                        <td width="2%" class="Title" valign="top">:
                                                        </td>
                                                        <td width="83%">
                                                            <asp:Label ID="lblContactType" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="Title" valign="top">Caregiver Info
                                                        </td>
                                                        <td class="Title" valign="top">:
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblCaregiverInfoText" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="Title" valign="top">Professional Info
                                                        </td>
                                                        <td class="Title" valign="top">:
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblProfInfo" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="Title" valign="top">Proxy Info
                                                        </td>
                                                        <td class="Title" valign="top">:
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblProxyInfo" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="Title" valign="top">Family Info
                                                        </td>
                                                        <td class="Title" valign="top">:
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblFamilyInfo" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="Title" valign="top">Other Info
                                                        </td>
                                                        <td class="Title" valign="top">:
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblOtherInfo" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                    
                                    <table width="100%">
                                        <tr id="trTotalRecords" runat="server">
                                            <td class="Title" width="15%">
                                                <span>Total Records</span>
                                            </td>
                                            <td width="2%">
                                                <strong>:</strong>
                                            </td>
                                            <td width="3%">&nbsp;<asp:Label ID="lblTotalRecords" runat="server">0</asp:Label>&nbsp;
                                            </td>
                                            <td width="80%">
                                                <a id="aReportSelection" href="javascript:void(0);" onclick="OpenHideReportSelection('commonType',false);" runat="server" style="font-size:12px"></a>                                                  
                                            </td>
                                        </tr>
                                    </table>                                                                     

                                </div>
                            </td>
                        </tr>
                         
                        <%--Added by KP on 13th March 2020(SOW-577)--%> 
                        <tr id="trReportSelectionField">
                            <td>                                                           
                                <table style="width:100%; background-color: rgba(237, 249, 255, 1); border: 1px solid grey;">
                                    <tr>
                                        <td>
                                            <asp:CheckBox ID="chkAllFilter" runat="server" Text="Check All" onchange="CheckUncheckAllFilters('chkAllFilter');"
                                                style="font-weight:bold;font-size:10px;padding-left:8px;line-height:20px;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>  
                                            <fieldset>
						                        <legend>
                                                    <asp:CheckBox ID="chkCPDetailsAll" runat="server" Text="Contact Person Details" Font-Bold="true" 
                                                       CssClass="chkAll chkAllFilters" onchange="CheckUncheckItemsBox('chkCPDetailsAll','chkCPDetails');" />
						                        </legend>
                                                <asp:CheckBoxList ID="chkCPDetails" RepeatDirection="Horizontal" RepeatColumns="5" Width="100%"
                                                    CssClass="rptBase chkAllFilters" runat="server" onchange="CheckUncheckAllBox('chkCPDetailsAll','chkCPDetails');">
                                                </asp:CheckBoxList>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>  
                                            <fieldset>
						                        <legend>
                                                    <asp:CheckBox ID="chkPersonalAll" runat="server" Text="Personal Details" Font-Bold="true" 
                                                        CssClass="chkAll chkAllFilters" onchange="CheckUncheckItemsBox('chkPersonalAll','chkPersonal');"/>
						                        </legend>
                                                <asp:CheckBoxList ID="chkPersonal" RepeatDirection="Horizontal" RepeatColumns="5" Width="100%"
                                                    CssClass="rptBase chkAllFilters" runat="server" onchange="CheckUncheckAllBox('chkPersonalAll','chkPersonal');">
                                                </asp:CheckBoxList>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>  
                                            <fieldset>
						                        <legend>
                                                    <asp:CheckBox ID="chkAltContactInfoAll" runat="server" Text="Alternate Contact Info" Font-Bold="true" 
                                                        CssClass="chkAll chkAllFilters" onchange="CheckUncheckItemsBox('chkAltContactInfoAll','chkAltContactInfo');"/>
						                        </legend>
                                                <asp:CheckBoxList ID="chkAltContactInfo" RepeatDirection="Horizontal" RepeatColumns="5" Width="100%"
                                                    CssClass="rptBase chkAllFilters" runat="server" onchange="CheckUncheckAllBox('chkAltContactInfoAll','chkAltContactInfo');">
                                                </asp:CheckBoxList>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>  
                                            <fieldset>
						                        <legend>
                                                    <asp:CheckBox ID="chkOtherDetailsAll" runat="server" Text="Other Details" Font-Bold="true" 
                                                        CssClass="chkAll chkAllFilters" onchange="CheckUncheckItemsBox('chkOtherDetailsAll','chkOtherDetails');"/>
						                        </legend>
                                                <asp:CheckBoxList ID="chkOtherDetails" RepeatDirection="Horizontal" RepeatColumns="5" Width="100%"
                                                    CssClass="rptBase chkAllFilters" runat="server" onchange="CheckUncheckAllBox('chkOtherDetailsAll','chkOtherDetails');">
                                                </asp:CheckBoxList>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>  
                                            <fieldset>
						                        <legend>
                                                    <asp:CheckBox ID="chkAddressInfoAll" runat="server" Text="Address Information" Font-Bold="true" 
                                                        CssClass="chkAll chkAllFilters" onchange="CheckUncheckItemsBox('chkAddressInfoAll','chkAddressInfo');"/>
						                        </legend>
                                                <asp:CheckBoxList ID="chkAddressInfo" RepeatDirection="Horizontal" RepeatColumns="5" Width="100%"
                                                    CssClass="rptBase chkAllFilters" runat="server" onchange="CheckUncheckAllBox('chkAddressInfoAll','chkAddressInfo');">
                                                </asp:CheckBoxList>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>  
                                            <fieldset>
						                        <legend>
                                                    <asp:CheckBox ID="chkServiceAll" runat="server" Text="Service Available/Requested" Font-Bold="true" 
                                                        CssClass="chkAll chkAllFilters" onchange="CheckUncheckItemsBox('chkServiceAll','chkService');"/>
						                        </legend>
                                                <asp:CheckBoxList ID="chkService" RepeatDirection="Horizontal" RepeatColumns="5" Width="100%"
                                                    CssClass="rptBase chkAllFilters" runat="server" onchange="CheckUncheckAllBox('chkServiceAll','chkService');">
                                                </asp:CheckBoxList>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>  
                                            <fieldset>
						                        <legend>
                                                    <asp:CheckBox ID="chkReferredByToAll" runat="server" Text="Referred By/To" Font-Bold="true" 
                                                        CssClass="chkAll chkAllFilters" onchange="CheckUncheckItemsBox('chkReferredByToAll','chkReferredByTo');"/>
						                        </legend>
                                                <asp:CheckBoxList ID="chkReferredByTo" RepeatDirection="Horizontal" RepeatColumns="5" Width="100%"
                                                    CssClass="rptBase chkAllFilters" runat="server" onchange="CheckUncheckAllBox('chkReferredByToAll','chkReferredByTo');">
                                                </asp:CheckBoxList>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>  
                                            <fieldset>
						                        <legend>
                                                    <asp:CheckBox ID="chkCallHistoryAll" runat="server" Text="Call History" Font-Bold="true" 
                                                        CssClass="chkAll chkAllFilters" onchange="CheckUncheckItemsBox('chkCallHistoryAll','chkCallHistory');"/>
						                        </legend>
                                                <asp:CheckBoxList ID="chkCallHistory" RepeatDirection="Horizontal" RepeatColumns="5" Width="100%"
                                                    CssClass="rptBase chkAllFilters" runat="server" onchange="CheckUncheckAllBox('chkCallHistoryAll','chkCallHistory');">
                                                </asp:CheckBoxList>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>  
                                            <fieldset>
						                        <legend>
                                                    <asp:CheckBox ID="chkFollowUpOCAll" runat="server" Text="Follow Up & Option Counseling" Font-Bold="true" 
                                                        CssClass="chkAll chkAllFilters" onchange="CheckUncheckItemsBox('chkFollowUpOCAll','chkFollowUpOC');"/>
						                        </legend>
                                                <asp:CheckBoxList ID="chkFollowUpOC" RepeatDirection="Horizontal" RepeatColumns="5" Width="100%"
                                                    CssClass="rptBase chkAllFilters" runat="server" onchange="CheckUncheckAllBox('chkFollowUpOCAll','chkFollowUpOC');">
                                                </asp:CheckBoxList>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>  
                                            <fieldset>
						                        <legend>
                                                    <asp:CheckBox ID="chkOptionCounselingAll" runat="server" Text="Option Counseling & Time Spent" Font-Bold="true" 
                                                        CssClass="chkAll chkAllFilters" onchange="CheckUncheckItemsBox('chkOptionCounselingAll','chkOptionCounseling');"/>
						                        </legend>
                                                <asp:CheckBoxList ID="chkOptionCounseling" RepeatDirection="Horizontal" RepeatColumns="5" Width="100%"
                                                    CssClass="rptBase chkAllFilters" runat="server" onchange="CheckUncheckAllBox('chkOptionCounselingAll','chkOptionCounseling');">
                                                </asp:CheckBoxList>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>  
                                            <fieldset>
						                        <legend>
                                                    <asp:CheckBox ID="chkRefAgencyDetailsAll" runat="server" Text="Referring Agency Details" Font-Bold="true" 
                                                        CssClass="chkAll chkAllFilters" onchange="CheckUncheckItemsBox('chkRefAgencyDetailsAll','chkRefAgencyDetails');"/>
						                        </legend>
                                                <asp:CheckBoxList ID="chkRefAgencyDetails" RepeatDirection="Horizontal" RepeatColumns="5" Width="100%"
                                                    CssClass="rptBase chkAllFilters" runat="server" onchange="CheckUncheckAllBox('chkRefAgencyDetailsAll','chkRefAgencyDetails');">
                                                </asp:CheckBoxList>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>                       
                                            <%--onclick="if (!Validate()) return false;"--%>
                                            <input id="btnCommonDownload" type="button" class="Anchor" onclick="return Validate();" value="Download in Excel" />
                                            <a href="javascript:void(0)" style="font-size:12px;" onclick="CloseFilterSelection()">Close</a>

                                            <div style="display:none;">
                                                <input id="TRecords" type="button" class="Anchor" onserverclick="A_Click" runat="server" value="Download in Excel" />
                                                <input id="btnUnDupeClient" type="button" class="Anchor" onserverclick="btnUnDupeClient_ServerClick"
                                                    runat="server" value="Download in Excel" />
                                                <input id="btnDuplicate" type="button" class="Anchor" onserverclick="btnDuplicate_Click"
                                                    runat="server" value="Download in Excel" />
                                                <input id="btnTotalContacts" type="button" class="Anchor"  onserverclick="btnTotalContacts_ServerClick"
                                                    runat="server" value="Download in Excel" />
                                                <input id="btnUnDuplicateNPService" type="button" class="Anchor" onserverclick="btnUnDuplicateNPService_ServerClick"
                                                    runat="server" value="Download in Excel" />
                                                
                                            </div>

                                        </td>
                                    </tr>
                                </table>     
                            </td>
                        </tr>
                        <%-- End(SOW-577)--%>

                        <tr id="trDetails" runat="server" visible="false">
                            <td>
                                <div id="DetailedReport" runat="server">
                                    <table width="100%">
                                        <tr>
                                            <td width="15%" class="Title">Contact Type
                                            </td>
                                            <td width="1%">
                                                <b>:</b>
                                            </td>
                                            <td width="84%">
                                                <asp:DataList ID="DLContactType" Width="70%" runat="server" RepeatDirection="Horizontal">
                                                    <ItemTemplate>
                                                        <table width="100%">
                                                            <tr>
                                                                <td width="100%">
                                                                    <%# Eval("ContactTypeName") %>&nbsp;<b>:</b>&nbsp;&nbsp;<%# Eval("CMPerson Count") %></td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <div style="height: 2px;">
                                                    &nbsp;
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="15%" class="Title">Contact Method
                                            </td>
                                            <td width="1%">
                                                <b>:</b>
                                            </td>
                                            <td width="84%">
                                                <asp:DataList ID="DLContactMethod" Width="75%" runat="server" RepeatDirection="Horizontal">
                                                    <ItemTemplate>
                                                        <table width="100%">
                                                            <tr>
                                                                <td width="80%">
                                                                    <%# Eval("ContactMethodName") %>&nbsp;<b>:</b>&nbsp;&nbsp;<%# Eval("Person Count") %></td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <div style="height: 2px;">
                                                    &nbsp;
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="15%" class="Title" valign="top">Age as of
                                            </td>
                                            <td width="1%" valign="top">
                                                <b>:</b>
                                            </td>
                                            <td width="84%">
                                                <asp:DataList ID="DLAge" Width="100%" runat="server" RepeatColumns="8" RepeatDirection="Horizontal">
                                                    <ItemTemplate>
                                                        <table width="100%">
                                                            <tr>
                                                                <td width="80%">
                                                                    <%# Eval("AgeGroup") %>&nbsp;<b>:</b>&nbsp;&nbsp;<%# Eval("PersonCount") %></td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <div style="height: 2px;">
                                                    &nbsp;
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="15%" class="Title">Gender
                                            </td>
                                            <td width="1%">
                                                <b>:</b>
                                            </td>
                                            <td width="84%">
                                                <asp:DataList ID="DLGender" Width="50%" runat="server" RepeatDirection="Horizontal">
                                                    <ItemTemplate>
                                                        <table width="100%">
                                                            <tr>
                                                                <td width="100%">
                                                                    <%# Eval("Gender") %>&nbsp;<b>:</b>&nbsp;&nbsp;<%# Eval("Person Count") %></td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <div style="height: 2px;">
                                                    &nbsp;
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="15%" class="Title" valign="top">Marital Status
                                            </td>
                                            <td width="1%" valign="top">
                                                <b>:</b>
                                            </td>
                                            <td width="84%" valign="top">
                                                <asp:DataList ID="DLMaritalStatus" Width="100%" runat="server" RepeatColumns="4"
                                                    RepeatDirection="Horizontal">
                                                    <ItemTemplate>
                                                        <table width="100%">
                                                            <tr>
                                                                <td width="80%">
                                                                    <%# Eval("MaritalStatus") %>&nbsp;<b>:</b>&nbsp;&nbsp;<%# Eval("PersonCount") %></td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <div style="height: 2px;">
                                                    &nbsp;
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="15%" class="Title" valign="top">Living Arrangement
                                            </td>
                                            <td width="1%" valign="top">
                                                <b>:</b>
                                            </td>
                                            <td width="84%" valign="top">
                                                <asp:DataList ID="DLLivingArrangement" Width="100%" RepeatLayout="Table" runat="server"
                                                    RepeatColumns="3" RepeatDirection="Horizontal">
                                                    <ItemTemplate>
                                                        <table width="100%">
                                                            <tr>
                                                                <td width="80%">
                                                                    <%# Eval("LivingArrangement") %>&nbsp;<b>:</b>&nbsp;&nbsp;<%# Eval("PersonCount") %></td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <div style="height: 2px;">
                                                    &nbsp;
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="15%" class="Title">Demographics
                                            </td>
                                            <td width="1%">
                                                <b>:</b>
                                            </td>
                                            <td width="84%">
                                                <asp:DataList ID="DlNoDemographics" Width="30%" runat="server" RepeatDirection="Horizontal">
                                                    <ItemTemplate>
                                                        <table width="100%">
                                                            <tr>
                                                                <td width="80%">
                                                                    <%# Eval("IsDemographics") %>&nbsp;<b>:</b>&nbsp;&nbsp;<%# Eval("PersonCount") %></td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <div style="height: 2px;">
                                                    &nbsp;
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="15%" class="Title">Race
                                            </td>
                                            <td width="1%">
                                                <b>:</b>
                                            </td>
                                            <td width="84%">
                                                <asp:DataList ID="DLRace" Width="100%" runat="server" RepeatDirection="Horizontal">
                                                    <ItemTemplate>
                                                        <table width="100%">
                                                            <tr>
                                                                <td width="80%">
                                                                    <%# Eval("Race") %>&nbsp;<b>:</b>&nbsp;&nbsp;<%# Eval("PersonCount") %></td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <div style="height: 2px;">
                                                    &nbsp;
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="15%" class="Title">Primary Language
                                            </td>
                                            <td width="1%">
                                                <b>:</b>
                                            </td>
                                            <td width="84%">
                                                <asp:DataList ID="DLPrimaryLanguage" Width="100%" runat="server" RepeatDirection="Horizontal">
                                                    <ItemTemplate>
                                                        <table width="100%">
                                                            <tr>
                                                                <td width="80%">
                                                                    <%# Eval("PrimaryLanguage") %>&nbsp;<b>:</b>&nbsp;&nbsp;<%# Eval("PersonCount") %></td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <div style="height: 2px;">
                                                    &nbsp;
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="15%" class="Title">Ethnicity
                                            </td>
                                            <td width="1%">
                                                <b>:</b>
                                            </td>
                                            <td width="84%">
                                                <asp:DataList ID="DLEthnicity" Width="50%" runat="server" RepeatDirection="Horizontal">
                                                    <ItemTemplate>
                                                        <table width="100%">
                                                            <tr>
                                                                <td width="100%">
                                                                    <%# Eval("Ethnicity") %>&nbsp;<b>:</b>&nbsp;&nbsp;<%# Eval("PersonCount") %></td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <div style="height: 2px;">
                                                    &nbsp;
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="15%" class="Title">Veteran Applicable
                                            </td>
                                            <td width="1%">
                                                <b>:</b>
                                            </td>
                                            <td width="84%">
                                                <asp:DataList ID="DLVeteranApplicable" Width="50%" runat="server" RepeatDirection="Horizontal">
                                                    <ItemTemplate>
                                                        <table width="100%">
                                                            <tr>
                                                                <td width="100%">
                                                                    <%# Eval("VeteranApplicable") %>&nbsp;<b>:</b>&nbsp;&nbsp;<%# Eval("PersonCount") %></td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <div style="height: 2px;">
                                                    &nbsp;
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="15%" class="Title">Veteran
                                            </td>
                                            <td width="1%">
                                                <b>:</b>
                                            </td>
                                            <td width="84%">
                                                <asp:DataList ID="DLVeteranStatus" Width="100%" runat="server" RepeatDirection="Horizontal">
                                                    <ItemTemplate>
                                                        <table width="100%">
                                                            <tr>
                                                                <td width="80%">
                                                                    <%# Eval("VeteranStatus")%>&nbsp;<b>:</b>&nbsp;&nbsp;<%# Eval("PersonCount") %></td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <div style="height: 2px;">
                                                    &nbsp;
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="17%" class="Title">Caregiver Status
                                            </td>
                                            <td width="1%">
                                                <b>:</b>
                                            </td>
                                            <td width="84%">
                                                <asp:DataList ID="DLCaregiverNeedyPerson" Width="30%" runat="server" RepeatDirection="Horizontal">
                                                    <ItemTemplate>
                                                        <table width="100%">
                                                            <tr>
                                                                <td width="100%">
                                                                    <%# Eval("CaregiverStatus")%>&nbsp;<b>:</b>&nbsp;&nbsp;<%# Eval("PersonCount") %></td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                            </td>
                                        </tr>
                                       
                                        <tr>
                                            <td colspan="3">
                                                <div style="height: 2px;">
                                                    &nbsp;
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="15%" class="Title">Service Need Met
                                            </td>
                                            <td width="1%">
                                                <b>:</b>
                                            </td>
                                            <td width="84%">
                                                <asp:DataList ID="DLServiceNeedMet" Width="30%" runat="server" RepeatDirection="Horizontal">
                                                    <ItemTemplate>
                                                        <table width="100%">
                                                            <tr>
                                                                <td width="100%">
                                                                    <%# Eval("ServiceNetMet")%>&nbsp;<b>:</b>&nbsp;&nbsp;<%# Eval("PersonCount") %></td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <div style="height: 2px;">
                                                    &nbsp;
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="15%" class="Title">Follow Up
                                            </td>
                                            <td width="1%">
                                                <b>:</b>
                                            </td>
                                            <td width="84%">
                                                <asp:DataList ID="DLFollowUp" Width="40%" runat="server" RepeatDirection="Horizontal">
                                                    <ItemTemplate>
                                                        <table width="100%">
                                                            <tr>
                                                                <td width="100%">
                                                                    <%# Eval("FollowupCompleted") %>&nbsp;<b>:</b>&nbsp;&nbsp;<%# Eval("PersonCount") %></td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <div style="height: 2px;">
                                                    &nbsp;
                                                </div>
                                            </td>
                                        </tr>
                                        <%-- Added by SA on 21st Aug, 2015. SOW-379 --%>
                                        <tr>
                                            <td width="15%" class="Title">Referred for OC
                                            </td>
                                            <td width="1%">
                                                <b>:</b>
                                            </td>
                                            <td width="84%">
                                                <asp:DataList ID="DLReferredforOC" Width="40%" runat="server" RepeatDirection="Horizontal">
                                                    <ItemTemplate>
                                                        <table width="100%">
                                                            <tr>
                                                                <td width="100%">
                                                                    <%# Eval("IsReferredOC") %>&nbsp;<b>:</b>&nbsp;&nbsp;<%# Eval("PersonCount") %></td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                            </td>
                                        </tr>
                                        <%-- Added By KR on 27 March 2017. --%>
                                        <tr>
                                            <td width="15%" class="Title">Funds Provided
                                            </td>
                                            <td width="1%">
                                                <b>:</b>
                                            </td>
                                            <td width="84%">
                                                <asp:DataList ID="DLFundsProvided" Width="40%" runat="server" RepeatDirection="Horizontal">
                                                    <ItemTemplate>
                                                        <table width="100%">
                                                            <tr>
                                                                <td width="100%">
                                                                    <%# Eval("IsFundsProvided") %>&nbsp;<b>:</b>&nbsp;&nbsp;<%# Eval("PersonCount") %></td>
                                                            </tr>
                                                           
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <div style="height: 2px;">
                                                    &nbsp;
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="15%" class="Title">Funds Provided Amount
                                            </td>
                                            <td width="1%">
                                                <b>:</b>
                                            </td>
                                            <td><asp:Label ID="lblFundsProvidedAmount"  runat="server"></asp:Label></td>
                                        </tr>
                                         <tr>
                                            <td colspan="3">
                                                <div style="height: 2px;">
                                                    &nbsp;
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="15%" class="Title" valign="top">Funds Utilized for
                                            </td>
                                            <td width="1%" valign="top">
                                                <b>:</b>
                                            </td>
                                            <td width="84%" valign="top">
                                                <asp:DataList ID="DLFundsUtilizedfor" Width="50%" RepeatLayout="Table" runat="server"
                                                    RepeatColumns="3" RepeatDirection="Horizontal">
                                                    <ItemTemplate>
                                                        <table width="100%">
                                                            <tr>
                                                                <td width="80%">
                                                                    <%# Eval("FundsUtilized") %>&nbsp;<b>:</b>&nbsp;&nbsp;<%# Eval("PersonCount") %></td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <div style="height: 2px;">
                                                    &nbsp;
                                                </div>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td width="15%" class="Title">County
                                            </td>
                                            <td width="1%">
                                                <b>:</b>
                                            </td>
                                            <td width="84%">
                                                <asp:Label ID="lblCounty" runat="server"></asp:Label>&nbsp; <a id="acounty" class="Anchor"
                                                    runat="server" onclick="return ShowHide('acounty', 'County');">Hide Details</a>
                                            </td>
                                        </tr>
                                        <tr id="trCounty" runat="server">
                                            <td width="15%"></td>
                                            <td width="1%"></td>
                                            <td width="84%">
                                                <div id="County" runat="server" style="text-align: left; width: 100%; display: block;">
                                                    <asp:DataList ID="DLCounty" Width="30%" runat="server">
                                                        <HeaderTemplate>
                                                            <table width="100%">
                                                                <tr>
                                                                    <td>
                                                                        <b>County Name</b>
                                                                    </td>
                                                                    <td>
                                                                        <b>Person Count</b>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table width="80%">
                                                                <tr>
                                                                    <td align="left" width="70%">
                                                                        <%# Eval("CountyName") %>
                                                                    </td>
                                                                    <td align="left" width="10%">
                                                                        <%# Eval("PersonCount") %>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:DataList>
                                                    <div style="padding-left: 70px;">
                                                        <a class="Anchor" onclick="Hide('acounty', 'County');">Close</a>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="15%" class="Title">City
                                            </td>
                                            <td width="1%">
                                                <b>:</b>
                                            </td>
                                            <td width="84%">
                                                <asp:Label ID="lblCity" runat="server"></asp:Label>&nbsp; <a id="acity" class="Anchor"
                                                    runat="server" onclick="return ShowHide('acity', 'City');">Hide Details</a>
                                            </td>
                                        </tr>
                                        <tr id="trCity" runat="server">
                                            <td width="15%"></td>
                                            <td width="1%"></td>
                                            <td width="84%">
                                                <div id="City" runat="server" style="text-align: left; display: block;">
                                                    <asp:DataList ID="DLCity" Width="30%" runat="server" RepeatDirection="Vertical">
                                                        <HeaderTemplate>
                                                            <table width="100%">
                                                                <tr>
                                                                    <td>
                                                                        <b>City Name</b>
                                                                    </td>
                                                                    <td>
                                                                        <b>Person Count</b>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table width="75%">
                                                                <tr>
                                                                    <td align="left" width="65%">
                                                                        <%# Eval("CityName") %>
                                                                    </td>
                                                                    <td align="left" width="10%">
                                                                        <%# Eval("PersonCount") %>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:DataList>
                                                    <div style="padding-left: 70px;">
                                                        <a class="Anchor" onclick="Hide('acity', 'City');">Close</a>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>

                                        <%--Added by GK on 25Apr19--%>
                                        <tr>
                                            <td colspan="3">&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="15%" class="Title">Township
                                            </td>
                                            <td width="1%">
                                                <b>:</b>
                                            </td>
                                            <td width="84%">
                                                <asp:Label ID="lblTownship1" runat="server"></asp:Label>&nbsp; <a id="atownship" class="Anchor"
                                                    runat="server" onclick="return ShowHide('atownship', 'Township');">Hide Details</a>
                                            </td>
                                        </tr>
                                        <tr id="trTownship" runat="server">
                                            <td width="15%"></td>
                                            <td width="1%"></td>
                                            <td width="84%">
                                                <div id="Township" runat="server" style="text-align: left; display: block;">
                                                    <asp:DataList ID="DLTownship" Width="30%" runat="server" RepeatDirection="Vertical">
                                                        <HeaderTemplate>
                                                            <table width="100%">
                                                                <tr>
                                                                    <td>
                                                                        <b>Township Name</b>
                                                                    </td>
                                                                    <td>
                                                                        <b>Person Count</b>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table width="75%">
                                                                <tr>
                                                                    <td align="left" width="65%">
                                                                        <%# Eval("TownshipName") %>
                                                                    </td>
                                                                    <td align="left" width="10%">
                                                                        <%# Eval("PersonCount") %>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:DataList>
                                                    <div style="padding-left: 70px;">
                                                        <a class="Anchor" onclick="Hide('atownship', 'Township');">Close</a>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
										<tr>
                                            <td colspan="3">&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="15%" class="Title">Custom Field
                                            </td>
                                            <td width="1%">
                                                <b>:</b>
                                            </td>
                                            <td width="84%">
                                                <asp:Label ID="lblCustomField1" runat="server"></asp:Label>&nbsp; <a id="aCustomField" class="Anchor"
                                                    runat="server" onclick="return ShowHide('aCustomField', 'CustomField');">Hide Details</a>
                                            </td>
                                        </tr>
                                        <tr id="trCustomField" runat="server">
                                            <td width="15%"></td>
                                            <td width="1%"></td>
                                            <td width="84%">
                                                <div id="CustomField" runat="server" style="text-align: left; display: block;">
                                                    <asp:DataList ID="DLCustomField" Width="30%" runat="server" RepeatDirection="Vertical">
                                                        <HeaderTemplate>
                                                            <table width="100%">
                                                                <tr>
                                                                    <td>
                                                                        <b>Custom Field Name</b>
                                                                    </td>
                                                                    <td>
                                                                        <b>Person Count</b>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table width="75%">
                                                                <tr>
                                                                    <td align="left" width="65%">
                                                                        <%# Eval("CustomName") %>
                                                                    </td>
                                                                    <td align="left" width="10%">
                                                                        <%# Eval("PersonCount") %>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:DataList>
                                                    <div style="padding-left: 70px;">
                                                        <a class="Anchor" onclick="Hide('aCustomField', 'CustomField');">Close</a>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <%--Ends--%>

                                        <tr>
                                            <td colspan="3">&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="15%" class="Title" valign="top">Service
                                            </td>
                                            <td width="1%" valign="top">
                                                <b>:</b>
                                            </td>
                                            <td width="84%">
                                                <asp:Label ID="lblService" runat="server"></asp:Label>&nbsp; <a id="aservice" class="Anchor"
                                                    runat="server" onclick="return ShowHide('aservice', 'Service');">Hide Details</a>
                                            </td>
                                        </tr>
                                        <tr id="trService" runat="server">
                                            <td width="15%"></td>
                                            <td width="1%"></td>
                                            <td width="84%">
                                                <div id="Service" runat="server" style="text-align: left; display: block;">
                                                    <asp:DataList ID="DLService" Width="30%" runat="server" RepeatDirection="Vertical">
                                                        <HeaderTemplate>
                                                            <table width="100%">
                                                                <tr>
                                                                    <td>
                                                                        <b>Service Name</b>
                                                                    </td>
                                                                    <td>
                                                                        <b>Person Count</b>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table width="100%">
                                                                <tr>
                                                                    <td align="left" width="80%">
                                                                        <%# Eval("ServiceName") %>
                                                                    </td>
                                                                    <td align="left" width="20%">
                                                                        <%# Eval("PersonCount") %>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:DataList>
                                                    <div style="padding-left: 70px;">
                                                        <a class="Anchor" onclick="Hide('aservice', 'Service');">Close</a>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="15%" class="Title" valign="top">Other Service
                                            </td>
                                            <td width="1%" valign="top">
                                                <b>:</b>
                                            </td>
                                            <td width="84%">
                                                <asp:Label ID="lblOtherService" runat="server"></asp:Label>&nbsp; <a id="aotherservice" class="Anchor"
                                                    runat="server" onclick="return ShowHide('aotherservice', 'OtherService');">Hide Details</a>
                                            </td>
                                        </tr>
                                        <tr id="trOtherService" runat="server">
                                            <td width="15%"></td>
                                            <td width="1%"></td>
                                            <td width="84%">
                                                <div id="OtherService" runat="server" style="text-align: left; display: block;">
                                                    <asp:DataList ID="DLOtherService" Width="30%" runat="server" RepeatDirection="Vertical">
                                                        <HeaderTemplate>
                                                            <table width="100%">
                                                                <tr>
                                                                    <td>
                                                                        <b>Other Service Name</b>
                                                                    </td>
                                                                    <td>
                                                                        <b>Person Count</b>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table width="100%">
                                                                <tr>
                                                                    <td align="left" width="80%">
                                                                        <%# Eval("OtherServiceName") %>
                                                                    </td>
                                                                    <td align="left" width="20%">
                                                                        <%# Eval("PersonCount") %>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:DataList>
                                                    <div style="padding-left: 70px;">
                                                        <a class="Anchor" onclick="Hide('aotherservice', 'OtherService');">Close</a>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="15%" class="Title" valign="top">Staff
                                            </td>
                                            <td width="1%" valign="top">
                                                <b>:</b>
                                            </td>
                                            <td width="84%">
                                                <asp:Label ID="lblStaffCount" runat="server"></asp:Label>&nbsp; <a id="astaff" class="Anchor"
                                                    runat="server" onclick="return ShowHide('astaff', 'Staff');">Hide Details</a>
                                            </td>
                                        </tr>
                                        <tr id="trStaff" runat="server">
                                            <td width="15%"></td>
                                            <td width="1%"></td>
                                            <td width="84%">
                                                <div id="Staff" runat="server" style="text-align: left; display: block;">
                                                    <asp:DataList ID="DLStaff" Width="30%" runat="server" RepeatDirection="Vertical">
                                                        <HeaderTemplate>
                                                            <table width="100%">
                                                                <tr>
                                                                    <td>
                                                                        <b>Staff Name</b>
                                                                    </td>
                                                                    <td>
                                                                        <b>Person Count</b>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table width="100%">
                                                                <tr>
                                                                    <td align="left" width="80%">
                                                                        <%# Eval("StaffName") %>
                                                                    </td>
                                                                    <td align="left" width="20%">
                                                                        <%# Eval("PersonCount") %>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:DataList>
                                                    <div style="padding-left: 70px;">
                                                        <a class="Anchor" onclick="Hide('astaff', 'Staff');">Close</a>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" colspan="3"></td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr id="trCountyReport" runat="server" visible="false">
                            <td style="border: 0px solid black;">
                                <div id="CountyReport" runat="server">
                                    <div style="margin:10px 0;">
                                        <b>County wide Services Requested: </b>
                                    </div>
                                    <div id="divNoRecords" runat="server" style="display: none;">
                                        No Records Found for Services Requested.
                                    </div>
                                    <asp:GridView ID="GVCountyReport" AllowPaging="false" BorderWidth="1" EmptyDataText="<center><b>No Records Found</b></center>"
                                        ShowHeader="true" ShowFooter="false" AutoGenerateColumns="false" runat="server"
                                        Width="100%">
                                        <Columns>
                                            <asp:TemplateField HeaderText="County">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCounty" runat="server" Text='<%# Eval("CountyName") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Left" />
                                                <ItemStyle Width="20%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="City">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCity" runat="server" Text='<%# Eval("CityName") %>'></asp:Label>
                                                    <itemstyle width="20%" />
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Left" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="servicename" HeaderText="Services Requested">
                                                <ItemStyle Width="20%" />
                                                <HeaderStyle HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="TotalPerson_CountyCityService" HeaderText="Person Count"  HtmlEncode="false">
                                                <ItemStyle Width="20%" HorizontalAlign="Center" />
                                                <HeaderStyle HorizontalAlign="Center" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Service Need Met">
                                                <ItemTemplate>
                                                    <%# Eval("ServiceNeedMetYes_No") %>
                                                </ItemTemplate>
                                                <ItemStyle Width="20%" />
                                                <HeaderStyle HorizontalAlign="Left" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle BorderStyle="Solid" />
                                        <PagerSettings Mode="NumericFirstLast" />
                                    </asp:GridView>

                                    <%--Added by KP on 27th April 2020(SOW-577), Other Service--%>
                                    <div style="margin-top:15px;margin-bottom:10px;">
                                        <div style="margin-bottom:10px;">
                                            <b>County wide Other Services:</b>
                                        </div>
                                        <div id="divNoRecordsOS" runat="server" style="display: none;">
                                            No Records Found for Other Services.
                                        </div>
                                        <asp:GridView ID="GVCountyReportOS" AllowPaging="false" BorderWidth="1" EmptyDataText="<center><b>No Records Found</b></center>"
                                        ShowHeader="true" ShowFooter="false" AutoGenerateColumns="false" runat="server"
                                        Width="100%">
                                        <Columns>
                                            <asp:TemplateField HeaderText="County">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCounty" runat="server" Text='<%# Eval("CountyName") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Left" />
                                                <ItemStyle Width="20%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="City">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCity" runat="server" Text='<%# Eval("CityName") %>'></asp:Label>
                                                    <itemstyle width="20%" />
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Left" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="OtherServiceName" HeaderText="Other Services">
                                                <ItemStyle Width="20%" />
                                                <HeaderStyle HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="TotalPerson_CountyCityService" HeaderText="Person Count" HtmlEncode="false">
                                                <ItemStyle Width="20%" HorizontalAlign="Center" />
                                                <HeaderStyle HorizontalAlign="Center" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Service Need Met">
                                                <ItemTemplate>
                                                    <%# Eval("ServiceNeedMetYes_No") %>
                                                </ItemTemplate>
                                                <ItemStyle Width="20%" />
                                                <HeaderStyle HorizontalAlign="Left" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle BorderStyle="Solid" />
                                        <PagerSettings Mode="NumericFirstLast" />
                                    </asp:GridView>
                                    </div>
                                    <%--End (SOW-577), Other Service--%>
                                    
                                    
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <asp:Button ID="btnExport" runat="server" CssClass="Anchor" OnClick="btnExport_Click"
                                    Text="Export to Excel" />
                                &nbsp;|&nbsp;
                                <asp:Button ID="btnExporttoPDF" runat="server" CssClass="Anchor" OnClick="btnExporttoPDF_Click"
                                    Text="Export to PDF" />                               
                            </td>
                        </tr>
                    </table>

                </td>
            </tr>
        </table>

    </form>
</body>
</html>
