<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Home.aspx.cs" Inherits="Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
   <%-- <script src="Scripts/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script src="Scripts/jquery.tablesorter.min.js" type="text/javascript"></script>--%>

    <script type="text/javascript" language="javascript">

        $(document).ready(function () {
            BindFollowupList();
            BindToDoList();
          
            $("#tblFollowUplist").tablesorter();
            //GetLastCallDetailsOfAgency();
           
            BindLast7DaysCallHistory();//Call to bind the grid of Call History (Last 7 Days).     

        });

        /* 
        Created By: SM
        Date:07/19/2013
        Purpose: after partial page post back call jquery tablesorter again to sort
        */
        function pageLoad(sender, args) {
            if (args.get_isPartialLoad()) {
                                         
                $("#tblFollowUplist").tablesorter();

                $("#tblToDoList").tablesorter();

            }
        }

        //Commented by KP on 24th Jan 2020(SOW-577)
        //// Created By: SM
        //// Date:07/03/2013
        ////Purpose: Show last details of needy
        //function ShowLastCallDetails(callid, NeedyID) {
        //    $.ajax({
        //        type: "POST",
        //        url: "Home.aspx/GetFollowupNeedyDetails",
        //        data: "{'HistoryID':" + callid + ",'NeedyID':" + NeedyID + "}",
        //        contentType: "application/json",
        //        dataType: "json",
        //        success: function (data) {
        //            if (data.d.length > 0) {
        //                //                          $('#grdHistoryDetails').tablesorter();
        //                $('#tblLastCallDetails tbody').remove();
        //                $('#tblLastCallDetails').show();
        //                for (var i = 0; i < data.d.length; i++) {

        //                    $("#tblLastCallDetails").append(

        //                                "<tr><td valign='top' ><span class='QuickView_lable'>First Name</span></td>" +
        //                                    "<td valign='top'  style='word-break:break-all;word-wrap:break-word'  >" + data.d[i].FirstName + "</td>" +
        //                                    "<td valign='top' ><span class='QuickView_lable'>Last Name</span></td>" +
        //                                    "<td valign='top'  style='word-break:break-all;word-wrap:break-word'  >" + data.d[i].LastName + "</td>" +

        //                                   "<td valign='top'    ><span class='QuickView_lable'>Contact Type</span></td>" +
        //                                    "<td valign='top'  > " + data.d[i].ContactTypeName + "</td>" +
        //                                    "</tr>" +
        //                                "<tr> " +
        //                                      "<td valign='top' ><span class='QuickView_lable'>Primary Phone</span></td>" +
        //                                    "<td valign='top' colspan='3' >" + data.d[i].PhonePrimary + "</td>" +

        //                                    "<td valign='top' ><span class='QuickView_lable'>Contact Method</span></td>" +
        //                                    "<td valign='top' >" + data.d[i].ContactMethodName + "</td>" +
        //                                    " </tr> " +

        //                                   "<tr>" +
        //                                   "<td valign='top' width='19%'><span class='QuickView_lable'>ADRC?</span></td>" +
        //                                    "<td valign='top' width='17%'>" + data.d[i].IsADRCYesNo + "</td>" +
        //                                    "<td valign='top' width='11%'><span class='QuickView_lable'>Info Only?</span></td>" +
        //                                    "<td valign='top' width='12%'>" + data.d[i].IsInfoOnlyYesNo + "</td>" +
        //                                    "<td valign='top' width='20%'><span class='QuickView_lable'>Call Duration</span></td>" +
        //                                    "<td valign='top' >" + data.d[i].CallDuration + "</td> " +
        //                                   " </tr>" +
        //                                  "<tr> " +
        //                                    "<td valign='top'><span class='QuickView_lable'>Follow-up</span></td>" +
        //                                    "<td valign='top' >" + data.d[i].FollowUpYesNo + "</td>" +
        //                                     "<td valign='top'><span class='QuickView_lable'>Date</span></td>" +
        //                                    "<td valign='top' >" + data.d[i].FollowupDate + "</td>" +
        //                                    "<td valign='top'  ><span class='QuickView_lable'>Service Need Met</span></td>" +
        //                                    "<td valign='top' >" + data.d[i].ServiceNeedsMetYesNo + "</td>" +
        //                                   " </tr>" +


        //                                     "<tr> " +
        //                                       "<td valign='top'><span class='QuickView_lable'>Contact Date/Time</span></td>" +
        //                                    "<td valign='top' colspan='3'>" + data.d[i].ContactDate + " " + data.d[i].ContactTime + "</td>" +
        //                                    "<td valign='top' colspan='2' align='right'><span class='QuickView_lable'><a href='#' onclick='ShowMoreCallDetails(" + data.d[i].HistoryID + "," + data.d[i].NeedyPersonID + ")'>More...</a> </span>  </td>" +

        //                                   " </tr>"


        //                                   );





        //                }
        //                //                       $('.tablesorter').trigger('update');
        //            }

        //        }
        //    });

        //}


        //// Created By: SM
        //// Date:07/18/2013
        ////Purpose: Show last details of current Agency
        //function GetLastCallDetailsOfAgency() {
        //    $.ajax({
        //        type: "POST",
        //        url: "Home.aspx/GetLastCallDetailOfAgency",
        //        data: "{}",
        //        contentType: "application/json",
        //        dataType: "json",
        //        success: function (data) {
        //            if (data.d.length > 0) {
        //                //                          $('#grdHistoryDetails').tablesorter();
        //                $('#tblAgencyLastCall tbody').remove();
        //                $('#tblAgencyLastCall').show();

        //                for (var i = 0; i < data.d.length; i++) {

        //                    $("#tblAgencyLastCall").append(

        //                               "<tr><td valign='top' ><span class='QuickView_lable'>First Name</span></td>" +
        //                                    "<td valign='top'  style='word-break:break-all;word-wrap:break-word' >" + data.d[i].FirstName + "</td>" +
        //                                    "<td valign='top' ><span class='QuickView_lable'>Last Name</span></td>" +
        //                                    "<td valign='top'  style='word-break:break-all;word-wrap:break-word'>" + data.d[i].LastName + "</td>" +
        //                                   "<td valign='top'   ><span class='QuickView_lable'>Contact Type</span></td>" +
        //                                    "<td valign='top'  > " + data.d[i].ContactTypeName + "</td>" +
        //                                    "</tr>" +
        //                                "<tr> " +
        //                                      "<td valign='top' ><span class='QuickView_lable'>Primary Phone</span></td>" +
        //                                    "<td valign='top' colspan='3' >" + data.d[i].PhonePrimary + "</td>" +

        //                                    "<td valign='top' width='15%'><span class='QuickView_lable'>Contact Method</span></td>" +
        //                                    "<td valign='top' colspan='3'>" + data.d[i].ContactMethodName + "</td>" +
        //                                    " </tr> " +

        //                                   "<tr>" +
        //                                   "<td valign='top' width='19%'><span class='QuickView_lable'>ADRC?</span></td>" +
        //                                    "<td valign='top' width='17%'>" + data.d[i].IsADRCYesNo + "</td>" +
        //                                    "<td valign='top' width='11%'><span class='QuickView_lable'>Info Only?</span></td>" +
        //                                    "<td valign='top' width='12%'>" + data.d[i].IsInfoOnlyYesNo + "</td>" +
        //                                    "<td valign='top' width='20%'><span class='QuickView_lable'>Call Duration</span></td>" +
        //                                    "<td valign='top' >" + data.d[i].CallDuration + "</td> " +
        //                                   " </tr>" +
        //                                  "<tr> " +
        //                                    "<td valign='top'><span class='QuickView_lable'>Follow-up</span></td>" +
        //                                    "<td valign='top' >" + data.d[i].FollowUpYesNo + "</td>" +
        //                                     "<td valign='top'><span class='QuickView_lable'>Date</span></td>" +
        //                                    "<td valign='top' >" + data.d[i].FollowupDate + "</td>" +
        //                                    "<td valign='top'  ><span class='QuickView_lable'>Service Need Met</span></td>" +
        //                                    "<td valign='top' >" + data.d[i].ServiceNeedsMetYesNo + "</td>" +
        //                                   " </tr>" +

        //                                     "<tr> " +
        //                                       "<td valign='top'><span class='QuickView_lable'>Contact Date/Time</span></td>" +
        //                                    "<td valign='top' colspan='3'>" + data.d[i].ContactDate + " " + data.d[i].ContactTime + "</td>" +
        //                                    "<td valign='top' colspan='2' align='right'><span class='QuickView_lable'><a href='#' onclick='ShowMoreCallDetails(" + data.d[i].HistoryID + "," + data.d[i].NeedyPersonID + ")'>More...</a> </span>  </td>" +

        //                                   " </tr>"

        //                                   );

        //                }
        //                //                       $('.tablesorter').trigger('update');
        //            }

        //        }
        //    });

        //}


        // Created By: SM
        // Date: 07/08/2013
        //Purpose: Show followup Needy person Details in popup
        function ShowFollowUpNeedyDetails(callid, NeedyID) {
            $.ajax({
                type: "POST",
                url: "Home.aspx/GetFollowupNeedyDetails",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                data: "{'HistoryID':" + callid + ",'NeedyID':" + NeedyID + "}",
                contentType: "application/json",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        //                          $('#grdHistoryDetails').tablesorter();
                        $('#tblNDPerson tbody').empty();

                        var ContactTypePhone;
                        var ContactTypeEmail;
                        var ContactTypeSMS;
                        var ContactTypeMail;
                        for (var i = 0; i < data.d.length; i++) {


                            ContactTypePhone = (data.d[i].ContactPreferencePhone == true) ? "checked" : "";
                            ContactTypeEmail = (data.d[i].ContactPreferenceEmail == true) ? "checked" : "";
                            ContactTypeSMS = (data.d[i].ContactPreferenceSMS == true) ? "checked" : "";
                            ContactTypeMail = (data.d[i].ContactPreferenceMail == true) ? "checked" : "";


                            $("#tblNDPerson").append(

                                            "<tr><td valign='top' width='8%'><span class='call_hist_lable'>First Name</span></td>" +
                                            "<td valign='top' width='24%' style='word-break:break-all;word-wrap:break-word' >" + data.d[i].FirstName + "</td>" +
                                            "<td valign='top' ><span class='QuickView_lable'>Last Name</span></td>" +
                                            "<td valign='top'  style='word-break:break-all;word-wrap:break-word'  width='15%'>" + data.d[i].LastName + "</td>" +
                                             "<td valign='top'  width='10%' ><span class='call_hist_lable'>Phone-Primary</span></td>" +

                                            "<td valign='top' width='12%'> " + data.d[i].PhonePrimary + "</td>" +
                                             "<td valign='top' ><span class='call_hist_lable'>Phone-Alternate</span></td>" +

                                            "<td valign='top' >" + data.d[i].PhoneAlt + "</td>" +
                                            "</tr>" +
                                        "<tr>" +
                                            "<td valign='top' ><span class='call_hist_lable'>Address</span></td>" +
                                            "<td valign='top'   style='word-break:break-all;word-wrap:break-word'>" + data.d[i].Address + "</td>" +

                                             "<td valign='top'><span class='call_hist_lable'>City</span></td>" +
                                             "<td valign='top'>" + data.d[i].CityName + "</td>" +

                                             "<td valign='top'><span class='call_hist_lable'>State</span></td>" +
                                            "<td valign='top'>" + data.d[i].State + "</td>" +

                                            "<td valign='top'><span class='call_hist_lable'>Zip</span></td>" +
                                            "<td valign='top'>" + data.d[i].Zip + "</td>" +

                                            "</tr>" +
                                        "<tr>" +
                                           "<td valign='top'  ><span class='call_hist_lable'>Email</span></td>" +
                                            "<td valign='top'> " + data.d[i].Email + "</td>" +

                                             "<td valign='top'><span class='call_hist_lable'>Gender</span></td>" +
                                            "<td valign='top'>" + data.d[i].Gender + "</td>" +

                                            "<td valign='top'><span class='call_hist_lable'>DOB</span></td>" +
                                            "<td valign='top'>" + data.d[i].DOB + "</td>" +

                                            "<td valign='top'><span class='call_hist_lable'>Age</span></td>" +
                                            "<td valign='top'>" + (data.d[i].Age != null ? data.d[i].Age : '') + "</td>" +

                                            "</tr>" +
                                         "<tr>" +

                                           "<td valign='top'><span class='call_hist_lable'>Marital Status</span></td>" +
                                            "<td valign='top'>" + data.d[i].MarriageStatus + "</td>" +

                                             "<td valign='top'><span class='call_hist_lable'>Living Arrangement</span></td>" +
                                            "<td valign='top'>" + data.d[i].LivingArrangement + "</td>" +

                                             "<td valign='top' colspan='2'><span class='call_hist_lable'>Veteran Status</span></td>" +
                                            "<td valign='top' colspan='2'>" + data.d[i].VeteranStatus + "</td>" +

                                         " </tr>" +
                                          "<tr>" +

                                            "<td valign='top'><span class='call_hist_lable'>Race</span></td>" +
                                            "<td valign='top'>" + data.d[i].Race + "</td>" +

                                            "<td valign='top'><span class='call_hist_lable'>Ethnicity</span></td>" +
                                            "<td valign='top'>" + data.d[i].Ethnicity + "</td>" +

                                             "<td valign='top' '  colspan='2' ><span class='call_hist_lable'>Method of contact</span></td>" +
                                            "<td  colspan='2'> <input type='checkbox' name='Phone'  value='Phone' " + ContactTypePhone + "/> Phone &nbsp;" +
                                            "<input type='checkbox' name='Email' value='Email' " + ContactTypeEmail + "/> Email &nbsp;" +
                                            "<input type='checkbox' name='SMStext' value='SMS' " + ContactTypeSMS + "/> SMS Text &nbsp;" +
                                            "<input type='checkbox' name='Mail' value='Mail' " + ContactTypeMail + "/> Mail &nbsp; </td> </tr>");


                        }
                        //                       $('.tablesorter').trigger('update');
                    }

                }
            });

            ShowHideNeedyDetailPopup();
        }


        // Created By: SM
        // Date:07/03/2013
        //Purpose: Show/Hide Needy person popup  
        function ShowHideNeedyDetailPopup() {
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





        /*
        Created By: SM
        Date:03/20/2013
        Purpose:This function will call when user clicked on call history to view more details.
        */

        function ShowMoreCallDetails(callid, NeedyID) {
            $.ajax({
                type: "POST",
                url: "Home.aspx/GetFollowupNeedyDetails",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                data: "{'HistoryID':" + callid + ",'NeedyID':" + NeedyID + "}",
                contentType: "application/json",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        //                          $('#grdHistoryDetails').tablesorter();
                        $('#grdMoreCallDetails tbody').empty();

                        for (var i = 0; i < data.d.length; i++) {

                            //Added by KP on 29th Jan 2020(SOW-577), Get Referring Agency fields and then display them, when RefAgencyDetailID > 0
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

                            $("#grdMoreCallDetails").append(

                                        "<tr><td valign='top'><span class='call_hist_lable'>First Name</span></td>" +
                                            "<td valign='top' style='word-break:break-all;word-wrap:break-word' >" + data.d[i].FirstName + "</td>" +
                                            "<td valign='top'><span class='call_hist_lable'>Last Name</span></td>" +
                                            "<td valign='top' style='word-break:break-all;word-wrap:break-word' >" + data.d[i].LastName + "</td>" +

                                             "<td valign='top'><span class='call_hist_lable'>Relationship</span></td>" +
                                            "<td valign='top' width='10%' style='word-break:break-all;word-wrap:break-word' >" + data.d[i].Relationship + "</td>" +

                                            "<td valign='top'><span class='call_hist_lable'>Contact Date/Time</span></td>" +
                                            "<td valign='top'>" + data.d[i].ContactDate + " " + data.d[i].ContactTime + "</td></tr>" +
                                        "<tr> " +

                                            " <td valign='top' width='10%' ><span class='call_hist_lable'>Primary Phone</span></td>" +
                                            "<td valign='top'  width='13%' style='word-break:break-all;word-wrap:break-word'>" + data.d[i].PhonePrimary + "</td>" +


                                          "<td valign='top'  width='13%' ><span class='call_hist_lable'>Contact Type</span></td>" +
                                            "<td valign='top' width='13%'> " + data.d[i].ContactTypeName + "</td>   " +
                                            "<td valign='top' width='15%'><span class='call_hist_lable'>Contact Method</span></td>" +
                                            "<td valign='top' colspan='3'>" + data.d[i].ContactMethodName + "</td>" +

                                            "</tr>" +


                                        "<tr> <td valign='top'><span class='call_hist_lable'>ADRC?</span></td>" +
                                            "<td valign='top'>" + data.d[i].IsADRCYesNo + "</td>" +

                                            "<td valign='top'><span class='call_hist_lable'>Info Only?</span></td>" +
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
                                +refAgencyDetails);
                            

                        }
                        //                       $('.tablesorter').trigger('update');
                    }

                }
            });
            ShowHideMoreCallDetailsPopup();
        }


        // Created By: SM
        // Date:07/18/2013
        //Purpose: Show/Hide More call details popup 
        function ShowHideMoreCallDetailsPopup() {
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
                showHideDiv.className = "main_popup_moreHistory ";
                divPopUpContent.className = "popup_moreHistory ";
                divpnlContact.style.display = "block";
                btnClose.style.display = "block";
                divpopupHeading.style.display = "block";
            }
        }


        function BindFollowupList() {

            $.ajax({
                type: "POST",
                url: "Home.aspx/GetFollowUpReminderList",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                data: "{}",
                contentType: "application/json",
                dataType: "json",
                success: function (data) {

                    if (data.d.length > 0) {
                        $('#lblCallCount').html('(' + data.d.length + ')');


                        $('#tblFollowupList').tablesorter();
                        $('#tblFollowupList tbody').empty();

                        for (var i = 0; i < data.d.length; i++) {


                            if (i % 2 == 0) {
                                $("#tblFollowupList").append("<tr  class='gridview_rowstyle' valign='top'><td align='left' style='word-break:break-all;word-wrap:break-word' > <a class='view_call_history_More' style='color:blue' title='Click here to view the Person Needing Assistance Details' onclick='ShowFollowUpNeedyDetails(" + data.d[i].CallHistoryID + "," + data.d[i].NeedyPersonID + ");'> " + data.d[i].NeedyPersonName + "</a></td>" +
                                    //"<td align='left'><a class='view_call_history_More' style='color:blue'  onclick='ShowLastCallDetails(" + data.d[i].CallHistoryID + "," + data.d[i].NeedyPersonID + ");'> " + data.d[i].LastCallAndTime + "</a></td>" +
                                    "<td align='left'><a class='view_call_history_More' style='color:blue' title='Click here to view the Call Details' href='javascript:void(0);' onclick='ShowMoreCallDetails(" + data.d[i].CallHistoryID + "," + data.d[i].NeedyPersonID + ")'>" + data.d[i].LastCallAndTime + "</a></td>"+
                                    "<td> <a class='view_call_history_More' style='color:blue' title='Click here to do Follow Up'  href='NeedyPerson.aspx?NdID=" + data.d[i].NeedyPersonID + "&IsNew=0&FLWP=1&CPID=" + data.d[i].ContactPersonID + "&CLID=" + data.d[i].CallHistoryID + "'>" + data.d[i].FollowupDate + "</a></td>" +
                                    "<td>" + data.d[i].FollowupCreatedModifedBy + "</td></tr > ");
                            }
                            else {
                                $("#tblFollowupList").append("<tr  class='gridview_alternaterow' valign='top'><td align='left' style='word-break:break-all;word-wrap:break-word' > <a class='view_call_history_More' style='color:blue' title='Click here to view the Person Needing Assistance Details' onclick='ShowFollowUpNeedyDetails(" + data.d[i].CallHistoryID + "," + data.d[i].NeedyPersonID + ");'> " + data.d[i].NeedyPersonName + "</a></td>" +
                                    //"<td align='left'><a class='view_call_history_More' style='color:blue'  onclick='ShowLastCallDetails(" + data.d[i].CallHistoryID + "," + data.d[i].NeedyPersonID + ");'> " + data.d[i].LastCallAndTime + "</a></td>" +
                                    "<td align='left'><a class='view_call_history_More' style='color:blue' title='Click here to view the Call Details' href='javascript:void(0);' onclick='ShowMoreCallDetails(" + data.d[i].CallHistoryID + "," + data.d[i].NeedyPersonID + ")'>" + data.d[i].LastCallAndTime + "</a></td>" +
                                    "<td> <a class='view_call_history_More' style='color:blue' title='Click here to do Follow Up' href='NeedyPerson.aspx?NdID=" + data.d[i].NeedyPersonID + "&IsNew=0&FLWP=1&CPID=" + data.d[i].ContactPersonID + "&CLID=" + data.d[i].CallHistoryID + "'>" + data.d[i].FollowupDate + "</a></td>" +
                                    "<td>" + data.d[i].FollowupCreatedModifedBy + "</td></tr > ");
                            }
                        }
                        $('.tablesorter').trigger('update');
                    }
                    else { $('#lblCallCount').html(''); }
                }

            });


        }

        function BindToDoList() {

          $.ajax({
                type: "POST",
                url: "Home.aspx/GetToDoList",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                data: "{}",
                contentType: "application/json",
                dataType: "json",
                success: function (data) {

                    if (data.d.length > 0) {
                        $('#ToDoCallCount').html('(' + data.d.length + ')');
                        $("#tblToDoList").tablesorter({ headers: { 2: {sorter: false}} });
                        $('#tblToDoList tbody').empty();

                        for (var i = 0; i < data.d.length; i++) {
                          if (i % 2 == 0) {
                              $("#tblToDoList").append("<tr  class='gridview_rowstyle' valign='top'><td align='left' style='word-break:break-all;word-wrap:break-word' > <a class='view_call_history_More' style='color:blue' title='Click here to view the Call Details'  onclick='ShowMoreCallDetails(" + data.d[i].CallHistoryID + "," + data.d[i].NeedyPersonID + ");'> " + data.d[i].NeedyPersonName + "</a></td>" +
                      "<td align='left'><a class=''  > " + data.d[i].LastCallAndTime + "</a></td> <td> <img src='images/ToDoFlag_Red.png'  onclick='SetToDo(this," + data.d[i].CallHistoryID + "," + data.d[i].NeedyPersonID + ")'/> </td><td>" + data.d[i].UserName + "</td></tr>");
                            }
                            else {
                              $("#tblToDoList").append("<tr  class='gridview_alternaterow' valign='top'><td align='left' style='word-break:break-all;word-wrap:break-word' > <a class='view_call_history_More' style='color:blue' title='Click here to view the Call Details' onclick='ShowMoreCallDetails(" + data.d[i].CallHistoryID + "," + data.d[i].NeedyPersonID + ");'> " + data.d[i].NeedyPersonName + "</a></td>" +
                                 "<td align='left'><a class=''  > " + data.d[i].LastCallAndTime + "</a></td> <td> <img src='images/ToDoFlag_Red.png'  onclick='SetToDo(this," + data.d[i].CallHistoryID + "," + data.d[i].NeedyPersonID + ")'/> </td><td>" + data.d[i].UserName + "</td></tr>");
                            }

                        }
                       
                        $('.tablesorter').trigger('update');
                    }
                     else {
                              $('#ToDoCallCount').html('');         
                        }
                }

            });
              

            }
        
        function SetToDo(ctrl, callid, NeedyID) {
            var Flagtodo;
            if (ctrl.src.indexOf("ToDoFlag_Red.png") !== -1)
                Flagtodo = 0;
            else if (ctrl.src.indexOf("ToDoFlag_Done.png") !== -1)
                Flagtodo = 1;
            $.ajax({
                type: "POST",
                url: "Home.aspx/SetToDo",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                data: "{'HistoryID':" + callid + ",'NeedyID':" + NeedyID + ",'ToDoFlag':" + Flagtodo + "}",
                contentType: "application/json",
                dataType: "json",
                success: function (data) {
                    if (data.d) {
                        if (ctrl.src.indexOf("ToDoFlag_Red.png") !== -1) {
                            ctrl.src = 'images/ToDoFlag_Done.png';
                        }
                        else if (ctrl.src.indexOf("ToDoFlag_Done.png") !== -1) {
                            ctrl.src = 'images/ToDoFlag_Red.png';
                        }
                    }
                }

            });
        }

        //Created By: KP on 24th Dec 2019(SOW-577), Bind the grid of Call History (Last 7 Days).
        function BindLast7DaysCallHistory() {

            $('#grvLast7DaysCallHistory').tablesorter({ headers: { 13: { sorter: false } } });
            $('#grvLast7DaysCallHistory').hide();
            $("#lblNoRecord").hide();   
            $('#Progressbar').show();            

            // call method using jquery-json and bind records
            $.ajax({
                type: "POST",
                url: "Home.aspx/GetLast7DaysCallHistory",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                data: "{}",
                contentType: "application/json",
                dataType: "json",
                success: function (data) {
                    $('#grvLast7DaysCallHistory').show();
                    $('#grvLast7DaysCallHistory tbody').empty();

                    if (data.d.length > 0) {
                        $('#lblNoRecord').hide();

                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 == 0) {
                                $("#grvLast7DaysCallHistory").append("<tr class='gridview_rowstyle' style='word-break:break-all;word-wrap:break-word' ><td >" + data.d[i].NeedyPersonFirstName + "</td><td>" + data.d[i].NeedyPersonLastName + "</td>" +
                                    "<td>" + data.d[i].NeedyPersonDOB + "</td><td>" + data.d[i].NeedyPersonPhonePri + "</td><td>" + data.d[i].NeedyPersonPhoneAlt + "</td> <td>" + data.d[i].ContactDateTime + "</td><td>" + data.d[i].UserName + "</td>" +
                                    "<td>" + data.d[i].ContactPersonFirstName + "</td><td >" + data.d[i].ContactPersonLastName + "</td><td>" + data.d[i].ContactPersonPhonePri + "</td><td>" + data.d[i].ContactPersonPhoneAlt + "</td>" +
                                    "<td valign='top' align='center'><span class='QuickView_lable'><a title='Click here to view the Call Details' href='javascript:void(0);' onclick='ShowMoreCallDetails(" + data.d[i].CallHistoryID + "," + data.d[i].NeedyPersonID + ")'>View</a> </span> </td></tr>");
                                    
                            }
                            else {
                                $("#grvLast7DaysCallHistory").append("<tr class='gridview_alternaterow' style='word-break:break-all;word-wrap:break-word' ><td >" + data.d[i].NeedyPersonFirstName + "</td><td>" + data.d[i].NeedyPersonLastName + "</td>" +
                                    "<td>" + data.d[i].NeedyPersonDOB + "</td><td>" + data.d[i].NeedyPersonPhonePri + "</td><td>" + data.d[i].NeedyPersonPhoneAlt + "</td> <td>" + data.d[i].ContactDateTime + "</td><td>" + data.d[i].UserName + "</td>" +
                                    "<td>" + data.d[i].ContactPersonFirstName + "</td><td >" + data.d[i].ContactPersonLastName + "</td><td>" + data.d[i].ContactPersonPhonePri + "</td><td>" + data.d[i].ContactPersonPhoneAlt + "</td>" +
                                   "<td valign='top' align='center'><span class='QuickView_lable'><a title='Click here to view the Call Details' href='javascript:void(0);' onclick='ShowMoreCallDetails(" + data.d[i].CallHistoryID + "," + data.d[i].NeedyPersonID + ")'>View</a> </span> </td></tr>");
                            }
                        }
                        
                       $('.tablesorter').trigger('update');
                       
                    }
                    else {
                        $('#grvLast7DaysCallHistory').hide();
                        $('#lblNoRecord').show();

                    }
                },
                complete: function () {
                    $('#Progressbar').hide();
                }
            });
            
        }
        
    </script>
    <div class="main_search" style="border: 0; padding: 0;">
        <table style="width: 100%; border: 3px" cellpadding="0" cellspacing="0">
            <tr>
                 <td colspan ="2" valign="top">
                     <div class="dashboard_box message">
                         <div class="box-header">
                            <h3>
                                Message Board</h3>
                        </div>
                        <div class="box-content" style="height:auto;">
                            <asp:Repeater ID="rptrMessages" runat="server">
                                <ItemTemplate>
                                    <%# 
			                            "<div style='word-wrap:break-word'  " + ((DataBinder.Eval(Container.DataItem, "Critical").ToString() == "True") ? "class=red" : "class=messagestyle") + ">" + 			                                                          
                                       Server.HtmlDecode( DataBinder.Eval(Container.DataItem, "MessageText").ToString())
			                            + "</div>"
                                    %>
                                </ItemTemplate>
                                <SeparatorTemplate>
                                    <hr />
                                </SeparatorTemplate>
                            </asp:Repeater>
                        </div>
                    
                    </div>
                 </td>
            </tr>
            <tr>
                <td style="width: 50%" valign="top">
                    
                    <div class="dashboard_box todo">
                        <div class="box-header">
                            <h3>
                                To-Do Notifications
                                <label id="ToDoCallCount" style="font-size: 13px">
                                </label>
                            </h3>
                        </div>
                        <div class="box-content">
                            <div id="div2">
                                <table id="tblToDoList" border="0" cellpadding="0" cellspacing="0" class="tablesorter gridview_home">
                                    <thead>
                                        <tr>
                                            <th width="43%">
                                                Person Needing Assistance
                                            </th>
                                            <th width="25%">
                                                Last Call On
                                            </th>
                                            <th>
                                                To-Do
                                            </th>
                                             <th>
                                                User Name
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td colspan="3" valign="top">
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                   
                </td>
                <td style="width: 50%" valign="top">
                    <div class="dashboard_box notifications">
                        <div class="box-header">
                            <h3>
                                Upcoming Follow-up Notifications
                                <label id="lblCallCount" style="font-size: 13px">
                                </label>
                            </h3>
                        </div>
                        <div class="box-content">
                            <div id="divCallHistory">
                                <table id="tblFollowupList" border="0" cellpadding="0" cellspacing="0" class="tablesorter gridview_home" width="100%">
                                    <thead>
                                        <tr>
                                            <th width="40%">
                                                Person Needing Assistance
                                            </th>
                                            <th width="23%">
                                                Last Call On
                                            </th>
                                            <th width="20%">
                                                Follow-up Date
                                            </th>
                                             <th>
                                               User Name
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td colspan="3" valign="top">
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
            <%--<tr>
                <td valign="top">
                    <div class="dashboard_box last-call">
                        <div class="box-header">
                            <h3>
                                Last Call Information
                            </h3>
                        </div>
                        <div class="box-content_bottom" style="height: 130px;">
                            <table width="99%" border="1" cellpadding="1" cellspacing="1" id="tblAgencyLastCall"
                                style="display: none; border-collapse: collapse;" align="center">
                                <tbody>
                                    <tr>
                                        <td colspan="8">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </td>
                <td valign="top">
                    <div class="dashboard_box user">
                        <div class="box-header">
                            <h3>
                                Call Details
                            </h3>
                        </div>
                        <div class="box-content_bottom" style="height: 130px;">
                            <table width="99%" border="1" cellpadding="1" cellspacing="1" id="tblLastCallDetails"
                                style="display: none; border-collapse: collapse; overflow: hidden" align="center">
                                <tbody>
                                    <tr>
                                        <td colspan="6">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </td>
            </tr>--%>

            <%--Added by KP on 24th Dec 2019(SOW-577), Call History (Last 7 Days) --%>
            <tr id="tr7DaysCallHistory">
                <td valign="top" colspan="2">
                    <div class="dashboard_box last-call">
                        <div class="box-header">
                            <h3>
                                Call History (Last 7 Days) 
                            </h3>
                        </div>
                        <div class="box-content_bottom" style="min-height:130px !important; height:auto;">
                           
                            <div class="no-found">
                                <label id="lblNoRecord">No Record Found.</label>
                            </div>

                            <table border="1" cellpadding="0" cellspacing="0" class="sub_hearder tablesorter"
                                id="grvLast7DaysCallHistory" width="99%" style="margin: 0px auto; border-collapse: collapse;">
                                <thead id="tableHead">

                                    <tr class="gridview_main_header">                    
                                        <td colspan="7" align="center">Person Needing Assistance</td>
                                        <td colspan="5" align="center">Contact Person</td>                                       
                                    </tr>

                                    <tr id="rwSecond">
                                        <th width="8%">First Name</th>
                                        <th width="8%">Last Name</th>
                                        <th width="6%">DOB</th>
                                        <th width="9%">Phone-Primary</th>
                                        <th width="9%">Phone-Alt</th>
                                        <th width="11%">Contact Date & Time<!--Last Call On --></th>                                       
                                        <th width="9%">User Name</th>                                        
                                        <th width="8%">First Name</th>
                                        <th width="8%">Last Name</th>
                                        <th width="9%">Phone-Primary</th>
                                        <th width="9%">Phone-Alt</th>
                                        <th width="6%" style="background-image:none !important">View Call</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>                                       
                                        <td colspan="12"></td>                                        
                                    </tr>
                                </tbody>
                            </table>

                        </div>
                    </div>
                </td>
            </tr>
            <%--End here, Call History (Last 7 Days) --%>
        </table>
    </div>
    <div id="showHideDiv2" runat="server">
        <div id="divPopUpContent2" runat="server">
            <input id="btnClose2" type="button" value="" runat="server" class="close_popmore"
                onclick="return ShowHideNeedyDetailPopup();" style="display: none" />
            <div id="divpopupHeading2" style="display: none; margin: 0 auto; width: 91%;" class="popup_form_heading_history"
                runat="server">
                Person Needing Assistance Details</div>
            <div class="form_block_popup" id="divpnlContact2" runat="server" style="padding: 0 !important;">
                <div style="padding: 0; margin: 0 0 0 0; min-height: 150px; max-height: 350px; width: 100%;">
                    <table width="98%" border="1" cellpadding="0" cellspacing="0" class="contact_gridview"
                        id="tblNDPerson" style="border-collapse: collapse;">
                        <tbody>
                            <tr>
                                <td colspan="8">
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div id="showHideDiv3" runat="server">
        <div id="divPopUpContent3" runat="server">
            <input id="btnClose3" type="button" value="" runat="server" class="close_popmore"
                onclick="return ShowHideMoreCallDetailsPopup();" style="display: none" />
            <div id="divpopupHeading3" style="display: none; margin: 0 auto; width: 91%;" class="popup_form_heading_history"
                runat="server">
                Call Details</div>
            <div class="form_block_popup" id="divpnlContact3" runat="server" style="padding: 0 !important;">
                <div style="padding: 0; margin: 0 0 0 0; min-height: 150px; max-height: 350px; width: 100%;
                    overflow-y: scroll;">
                    <table width="98%" align="center" border="1" cellpadding="0" cellspacing="0" class="contact_gridview"
                        id="grdMoreCallDetails" style="border-collapse: collapse;">
                        <tbody>
                            <tr>
                                <td colspan="8">
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Added By KP on 24th Dec 2019(SOW-577) -->
    <div id="Progressbar" style="display: none;">
        <div class="loader_bg">
        </div>
        <div class="preloader">
            <p>
                Please wait...
            </p>
        </div>
    </div>
</asp:Content>
