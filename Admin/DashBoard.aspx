<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site.master" AutoEventWireup="true"
    CodeFile="DashBoard.aspx.cs" Inherits="DashBoard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <%--<script src="../Scripts/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.tablesorter.min.js" type="text/javascript"></script>--%>
    <%-- <script src="../Scripts/json2.js" type="text/javascript"></script>--%>

    <script type="text/javascript" language="javascript">
        $(document).ready(function () {



            GetPersonCountByAgency();
            GetPersonCountByService();
            GetPersonCountByUser();

            //Set Cursor position
            $(document).mousemove(function (e) {
                mouseX = e.pageX;
                mouseY = e.pageY;
                //To Get the relative position
                if (this.offsetLeft != undefined)
                    mouseX = e.pageX - this.offsetLeft;
                if (this.offsetTop != undefined)
                    mouseY = e.pageY; -this.offsetTop;

                if (mouseX < 0)
                    mouseX = 0;
                if (mouseY < 0)
                    mouseY = 0;

                windowWidth = $(window).width() + $(window).scrollLeft();
                windowHeight = $(window).height() + $(window).scrollTop();
            });




        });




        function SetPopupOpenPosition(divpnlContact) {
            var popupWidth = $(divpnlContact).outerWidth();
            var popupHeight = $(divpnlContact).outerHeight();
            if (mouseX + popupWidth > windowWidth)
                popupLeft = mouseX - popupWidth;
            else
                popupLeft = mouseX;
            if (mouseY + popupHeight > windowHeight)
                popupTop = mouseY - popupHeight;
            else
                popupTop = mouseY;
            if (popupLeft < $(window).scrollLeft()) {
                popupLeft = $(window).scrollLeft();
            }
            if (popupTop < $(window).scrollTop()) {
                popupTop = $(window).scrollTop();
            }
            if (popupLeft < 0 || popupLeft == undefined)
                popupLeft = 0;
            if (popupTop < 0 || popupTop == undefined)
                popupTop = 0;
            $(divpnlContact).offset({ top: popupTop });// remove left offset  so that popup will show in center
            //$(divpnlContact).offset({ top: popupTop, left: popupLeft });
        }


        //Get  Needy Person count in each Agency
        function GetPersonCountByAgency() {
            $.ajax({
                type: "POST",
                url: "DashBoard.aspx/GetPersonCountByAgency",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",

                success: function (data) {

                    var Result = JSON.parse(data.d);
                    if (Result.length > 0) {
                        $('#lblPersonCount').html('(' + Result.length + ')');
                        $('#tblPersonByAgency').tablesorter();
                        $('#tblPersonByAgency tbody').empty();
                        for (var i = 0; i < Result.length; i++) {
                            if (i % 2 == 0) {
                                //<a class='view_call_history_More' style='color:blue'  onclick='ShowMoreCallDetails(" + data.d[i].CallHistoryID + "," + data.d[i].NeedyPersonID + ");'> " + data.d[i].NeedyPersonName + "</a>

                                $("#tblPersonByAgency").append("<tr  class='gridview_rowstyle' valign='top'><td align='left' style='word-break:break-all;word-wrap:break-word' >" + Result[i].SiteName + " </td>" +
                                                               "<td align='left'><a class='view_call_history_More' title='Click to view all person' style='color:blue; text-decoration:underline' onclick='ShowNeedyPersonList(" + Result[i].SiteID + ",0,0," + Result[i].TotalPerson + ",null);'> " + Result[i].TotalPerson + "</a></td> </tr>");
                            }
                            else {

                                $("#tblPersonByAgency").append("<tr  class='gridview_alternaterow' valign='top'><td align='left' style='word-break:break-all;word-wrap:break-word' >" + Result[i].SiteName + " </td>" +
                                                               "<td align='left'><a class='view_call_history_More' title='Click to view all person' style='color:blue; text-decoration:underline'  onclick='ShowNeedyPersonList(" + Result[i].SiteID + ",0,0," + Result[i].TotalPerson + ",null);'> " + Result[i].TotalPerson + "</a></td> </tr>");


                            }
                        }
                        $('.tablesorter').trigger('update');
                    }
                    else {
                        $('#lblPersonCount').html('');
                    }
                    //Bind Person Service met
                    if (Result.length > 0) {

                        $('#tblPersonServiceMet').tablesorter();
                        $('#tblPersonServiceMet tbody').empty();
                        for (var i = 0; i < Result.length; i++) {
                            if (i % 2 == 0) {
                                $("#tblPersonServiceMet").append("<tr  class='gridview_rowstyle' valign='top'><td align='left' style='word-break:break-all;word-wrap:break-word' >" + Result[i].SiteName + " </td>" +
                                                               "<td align='left' width='10%'> <a class='view_call_history_More' title='Click to view all person' style='color:blue; text-decoration:underline' onclick='ShowNeedyPersonList(" + Result[i].SiteID + ",0,1," + Result[i].TotalPersonServMet + ",null);'> " + Result[i].TotalPersonServMet + "</a> / <a class='view_call_history_More' title='Click to view all person' style='color:blue; text-decoration:underline' onclick='ShowNeedyPersonList(" + Result[i].SiteID + ",0,0," + Result[i].TotalPerson + ",null);'> " + Result[i].TotalPerson + "</a></td> </tr>");
                            }
                            else {
                                $("#tblPersonServiceMet").append("<tr  class='gridview_alternaterow' valign='top'><td align='left' style='word-break:break-all;word-wrap:break-word' >" + Result[i].SiteName + " </td>" +
                                                               "<td align='left' width='10%'> <a class='view_call_history_More' title='Click to view all person' style='color:blue; text-decoration:underline' onclick='ShowNeedyPersonList(" + Result[i].SiteID + ",0,1," + Result[i].TotalPersonServMet + ",null);'> " + Result[i].TotalPersonServMet + "</a> / <a class='view_call_history_More'  title='Click to view all person'style='color:blue; text-decoration:underline' onclick='ShowNeedyPersonList(" + Result[i].SiteID + ",0,0," + Result[i].TotalPerson + ",null);'> " + Result[i].TotalPerson + "</a></td> </tr>");
                            }
                        }
                        $('.tablesorter').trigger('update');
                    }
                }

            });



        }
        //Get Service count 
        function GetPersonCountByService() {

            $.ajax({
                type: "POST",
                url: "DashBoard.aspx/GetNeedyPersonCountByService",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",

                success: function (data) {

                    var Result = JSON.parse(data.d);
                    //Bind Person Count by Agency
                    if (Result.length > 0) {
                        $('#lblServiceCount').html('(' + Result.length + ')');
                        $('#tblPersonCountByService').tablesorter();
                        $('#tblPersonCountByService tbody').empty();
                        for (var i = 0; i < Result.length; i++) {
                            if (i % 2 == 0) {
                                $("#tblPersonCountByService").append("<tr  class='gridview_rowstyle' valign='top'><td align='left' style='word-break:break-all;word-wrap:break-word' >" + Result[i].ServiceName + " </td>" +
                                                               "<td align='left'><a class='view_call_history_More' title='Click to view all person' style='color:blue; text-decoration:underline' onclick='ShowNeedyPersonList(null," + Result[i].ServiceId + ",0," + Result[i].NeedyPersonCount + ",null);'> " + Result[i].NeedyPersonCount + "</a></td> </tr>");
                            }
                            else {
                                $("#tblPersonCountByService").append("<tr  class='gridview_alternaterow' valign='top'><td align='left' style='word-break:break-all;word-wrap:break-word' >" + Result[i].ServiceName + " </td>" +
                                                               "<td align='left'><a class='view_call_history_More' title='Click to view all person' style='color:blue; text-decoration:underline' onclick='ShowNeedyPersonList(null," + Result[i].ServiceId + ",0," + Result[i].NeedyPersonCount + ",null);'>" + Result[i].NeedyPersonCount + "</a></td> </tr>");
                            }
                        }
                        $('.tablesorter').trigger('update');
                    }
                    else {
                        $('#lblServiceCount').html('');
                    }
                }
            });
        }


        //Get  Needy Person count in each Agency
        function GetPersonCountByUser() {
            $.ajax({
                type: "POST",
                url: "DashBoard.aspx/GetPersonCountByUser",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",

                success: function (data) {

                    var Result = JSON.parse(data.d);
                    if (Result.length > 0) {
                        $('#lblPersonCountbyuser').html('(' + Result.length + ')');
                        $('#tblPersonCountByUser').tablesorter();
                        $('#tblPersonCountByUser tbody').empty();
                        for (var i = 0; i < Result.length; i++) {

                            if (i % 2 == 0) {
                                //<a class='view_call_history_More' style='color:blue'  onclick='ShowMoreCallDetails(" + data.d[i].CallHistoryID + "," + data.d[i].NeedyPersonID + ");'> " + data.d[i].NeedyPersonName + "</a>

                                $("#tblPersonCountByUser").append("<tr  class='gridview_rowstyle' valign='top'><td align='left' style='word-break:break-all;word-wrap:break-word' >" + Result[i].PersonName + " </td>" +
                                                               "<td align='left'><a class='view_call_history_More' title='Click to view all person' style='color:blue; text-decoration:underline' onclick='ShowNeedyPersonList(null,0,0," + Result[i].TotalPerson + "," + Result[i].UserID + ");'> " + Result[i].TotalPerson + "</a></td> </tr>");
                            }
                            else {

                                $("#tblPersonCountByUser").append("<tr  class='gridview_alternaterow' valign='top'><td align='left' style='word-break:break-all;word-wrap:break-word' >" + Result[i].PersonName + " </td>" +
                                                               "<td align='left'><a class='view_call_history_More' title='Click to view all person' style='color:blue; text-decoration:underline'  onclick='ShowNeedyPersonList(null,0,0," + Result[i].TotalPerson + "," + Result[i].UserID + ");'> " + Result[i].TotalPerson + "</a></td> </tr>");


                            }

                        }
                        $('.tablesorter').trigger('update');
                    }
                    else {
                        $('#lblPersonCountbyuser').html('');
                    }
                }

            });

        }

        function ShowNeedyPersonList(SiteID, ServiceID, IsReqServiceMetNd, PersonCount, username) {


            if (PersonCount == 0) {

                alert('Person needing assistance does not found.');
                return false;
            }
          
            $('#grdNeedyPersonList tbody').empty();

            $.ajax({
                type: "POST",
                url: "DashBoard.aspx/GetNdPersonBySiteIdOrServiceid",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                data: "{'SiteID':" + SiteID + ",'ServiceID':" + ServiceID + ",'IsReqServiceMetNd':" + IsReqServiceMetNd + ",'UserID':" + username + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                asyn: false,
                success: function (data) {
                    var Result = JSON.parse(data.d);
                    //Bind Person Count by Agency 
                    if (Result.length > 0) {
                    if($('#grdNeedyPersonList thead tr').length == 0){
                        //  $('#lblServiceCount').html('(' + Result.length + ')');
                        //added by SA on 31st Aug, 2015. SOW-379. Remove header to readd to resolve sorting issue
                        $('#grdNeedyPersonList thead').remove();
                       
                        //addedby SA on 31st Aug, 2015 SOW-379 to add thead and tbody dynamically to handle sorting issue.
                        $("#grdNeedyPersonList").append("<thead><tr><th width='11%'>First Name</th><th width='10%'>Last Name</th><th width='6%'>DOB</th>" +
                            "<th width='7%'>Gender</th><th width='11%'>Phone Primary</th><th>Email</th><th width='11%'>Marital Status</th><th width='6%'>City</th>" +
                            "<th width='7%'>County</th><th width='7%'>State</th><th width='5%'>Zip</th><th width='10%'>Address</th></tr></thead>" +
                            "<tbody><tr><td colspan='12'></td></tr></tbody>");
                        }       
                       //$('#grdNeedyPersonList tbody').empty();
                        $('#grdNeedyPersonList').tablesorter();

                        
                        for (var i = 0; i < Result.length; i++) {
                            if (i % 2 == 0) {
                                $("#grdNeedyPersonList").append("<tr  class='gridview_rowstyle' valign='top'><td align='left' style='word-break:break-all;word-wrap:break-word' >" + Result[i].FirstName + " </td><td align='left' style='word-break:break-all;word-wrap:break-word' >" + Result[i].LastName + " </td><td align='left'>" + Result[i].DoB + "</td><td align='left'>" + Result[i].Gender + "</td>" +
                                                               "<td align='left'>" + Result[i].PhonePrimary + "</td> <td align='left'>" + Result[i].Email + "</td><td align='left'>" + Result[i].MaritalStatus + "</td><td align='left'>" + Result[i].CityName + "</td> " +

                                                               "<td align='left'>" + Result[i].CountyName + "</td><td align='left'>" + Result[i].State + "</td><td align='left'>" + Result[i].Zip + "</td><td align='left' style='word-wrap:break-word'>" + Result[i].Address + "</td>" +
                                                               "</tr>");
                            }
                            else {
                                $("#grdNeedyPersonList").append("<tr  class='gridview_alternaterow' valign='top'><td align='left' style='word-break:break-all;word-wrap:break-word' >" + Result[i].FirstName + " </td><td align='left' style='word-break:break-all;word-wrap:break-word' >" + Result[i].LastName + " </td><td align='left'>" + Result[i].DoB + "</td><td align='left'>" + Result[i].Gender + "</td>" +
                                                               "<td align='left'>" + Result[i].PhonePrimary + "</td>  <td align='left'>" + Result[i].Email + "</td><td align='left'>" + Result[i].MaritalStatus + "</td><td align='left'>" + Result[i].CityName + "</td> " +

                                                               "<td align='left'>" + Result[i].CountyName + "</td><td align='left'>" + Result[i].State + "</td><td align='left'>" + Result[i].Zip + "</td><td align='left' style='word-wrap:break-word'>" + Result[i].Address + "</td>" +
                                                               "</tr>");
                            }
                        }
                        $('.tablesorter').trigger('update');                      

                    }
                    else {
                        $('#lblServiceCount').html('');

                    }
                    //Bind Person Count  by agency that have service met 
                }

            });
            ShowHideNeedyPersonPopup()
        }

        function ShowHideNeedyPersonPopup() {

            var divpnlContact = document.getElementById("<%=divpnlContactND.ClientID %>");
            var showHideDiv = document.getElementById("<%=showHideDivND.ClientID %>");
            var divPopUpContent = document.getElementById("<%=divPopUpContentND.ClientID %>");
            var divpopupHeading = document.getElementById("<%=divpopupHeadingND.ClientID %>");
            var btnClose = document.getElementById("<%=btnCloseND.ClientID %>");
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
                SetPopupOpenPosition(divpnlContact);
            }
        }



    </script>

    <div class="main_search" style="border: 0; padding: 0;">
        <table style="width: 100%; border: 3px" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 50%" valign="top">
                    <div class="dashboard_box user">
                        <div class="box-header">
                            <h3>Person By Agency
                              <label id="lblPersonCount" style="font-size: 13px">
                              </label>
                            </h3>
                        </div>
                        <div class="box-content">
                            <div id="div2">
                                <table id="tblPersonByAgency" border="1" cellpadding="0" cellspacing="0" class="tablesorter gridview_home">
                                    <thead>
                                        <tr>
                                            <th>Agency Name
                                            </th>
                                            <th width="15%">Count
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
                    </div>

                </td>
                <td style="width: 50%" valign="top">
                    <div class="dashboard_box user">
                        <div class="box-header">
                            <h3>Person Count By Service
                                <label id="lblServiceCount" style="font-size: 13px">
                                </label>
                            </h3>
                        </div>
                        <div class="box-content">
                            <div id="divCallHistory">
                                <table id="tblPersonCountByService" border="1" cellpadding="0" cellspacing="0" class="tablesorter gridview_home">
                                    <thead>
                                        <tr>
                                            <th>Service Name
                                            </th>
                                            <th width="15%">Count
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
                    </div>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <div class="dashboard_box user">
                        <div class="box-header">
                            <h3>Service met by Agency
                            </h3>
                        </div>
                        <div class="box-content_bottom" style="height: 130px;">
                            <table id="tblPersonServiceMet" border="1" cellpadding="0" cellspacing="0" class="tablesorter gridview_home">

                                <thead>
                                    <tr>
                                        <th>Agency Name
                                        </th>
                                        <th width="30%">Service Met/Total
                                        </th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <tr>
                                        <td colspan="2"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </td>
                <td valign="top">
                    <div class="dashboard_box user">
                        <div class="box-header">
                            <h3>Person Count By Users
                                <label id="lblPersonCountbyuser" style="font-size: 13px">
                                </label>
                            </h3>
                        </div>
                        <div class="box-content_bottom" style="height: 130px;">
                            <table id="tblPersonCountByUser" border="1" cellpadding="0" cellspacing="0" class="tablesorter gridview_home">
                                <thead>
                                    <tr>
                                        <th>Person Name
                                        </th>
                                        <th width="15%">Count
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
                </td>
            </tr>
        </table>
    </div>
    <div id="showHideDivND" runat="server" style="z-index: 9999;">
        <div id="divPopUpContentND" runat="server">
            <div class="form_block_popup" id="divpnlContactND" style="display: none;" runat="server">
                <div id="divpopupHeadingND" class="popup_form_heading_history_CPPopup"
                    runat="server">
                    Person needing Assistance Details
                    <input id="btnCloseND" type="button" value="" runat="server" class="close_popmore"
                        onclick="return ShowHideNeedyPersonPopup();" style="display: none; right: 10px;" />
                </div>
                <div style="padding: 0; margin: 0 0 0 0; height: 200px !important; width: 100%;"
                    class="grid_scroll">
                    <table width="100%" align="center" border="1" cellpadding="0" cellspacing="0" class="tablesorter contact_gridview"
                        id="grdNeedyPersonList" style="border-collapse: collapse;">
                    </table>
                </div>
            </div>
        </div>

    </div>





</asp:Content>
