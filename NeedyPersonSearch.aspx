<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="NeedyPersonSearch.aspx.cs" Inherits="NeedyPersonSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <%--<script src="Scripts/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script src="Scripts/jquery.tablesorter.min.js" type="text/javascript"></script>--%>
    <script src="Scripts/underscore.js" type="text/javascript"></script>
      
    <style type="text/css">
        input.watermark {
            color: #999;
            font-family: Verdana, Helvetica, sans-serif;
            font-style: italic;
            font-size: 11px;
        }
        ::-ms-clear {
            display: none;
         }
    </style>
     <script type="text/javascript">

         //Commented By KP on 26th Dec 2019(SOW-577), Filtering of data on each key press feature will be disable from Advance Search.
         //$(function () {
         //    //Created by SA on 27th May, 2015. SOW-362. To invoke search functions.
         //    //Logic: feature that if user type fast then it should not go for search for every key press.(Delay: 500 ms)      
         //    $("#txtNeedyFirstName").keyup(_.debounce(NeedyPersonName_PhoneSearch, 500));
         //    $("#txtNeedyLastName").keyup(_.debounce(NeedyPersonName_PhoneSearch, 500));
         //    $("#txtNeedyPhone").keyup(_.debounce(NeedyPersonName_PhoneSearch, 500));
         //    $("#txtContactPersonFirstName").keyup(_.debounce(ContactPersonName_PhoneSearch, 500));
         //    $("#txtContactPersonLastName").keyup(_.debounce(ContactPersonName_PhoneSearch, 500));
         //    $("#txtContactPhone").keyup(_.debounce(ContactPersonName_PhoneSearch, 500));
         //});
         //// Created by SA on 27th May, 2015. SOW-362. To pass this function as parameter to _.debounce function
         //function NeedyPersonName_PhoneSearch() {
         //    //ClearValues('B');//N
         //    BindGridView('B', 'Keyup');
         //}

         //// Created by SA on 27th May, 2015. SOW-362. To pass this function as parameter to _.debounce function
         //function ContactPersonName_PhoneSearch() {
         //    //ClearValues('B');//N
         //    BindGridView('B', 'Keyup');
         //}

    </script>

    <script type="text/javascript">

        var watermarkSmartSearch = 'Search by Name/Phone/DOB of Person Needing Assistance or Name/Phone of Contact Person';
        //Added by kuldeep Rathore on 20th Aug 2015.
        var watermarkFirstName = 'First Name (like Adam) ';
        var watermarkLastName = 'Last Name (like Smith)'
        var watermarkPhone = 'Phone Number';
        
        //Modified by KP on 26th Dec 2019(SOW-577), Smart search is added, Advance search and watermarks are modified.
        $(document).ready(function () {

            var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            var IsUpdateCall = url[0].split('=')[1];
            if (IsUpdateCall == 0) {
                $('#colUpdateCall').css('background-color', '#1A8AD8');
                $('#lblUpdateMessage').html('Search Person Needing Assistance for New Call');  
            }
            else {
                $('#colUpdateCall').css('background-color', 'green');
                $('#lblUpdateMessage').html('Search Person Needing Assistance for Update Call');
            }
            
            $('#txtSmartSearch').val(watermarkSmartSearch).addClass('watermark');

            //if keyup/blur and no value inside, set watermark text and class again. 
            $('#txtSmartSearch').on('keyup', function (e) {  
                AddWaterMark('#txtSmartSearch', watermarkSmartSearch, true);                
            });
            $('#txtSmartSearch').on('blur', function (e) {
                AddWaterMark('#txtSmartSearch', watermarkSmartSearch, false);
            });

            //if keydown or drop event is raised and text is watermrk or paste event through Context menu, set it to empty and remove the watermark class
            $("#txtSmartSearch").bind('keydown paste drop', function (e) {               
                if ($('#txtSmartSearch').val() == watermarkSmartSearch) {
                    $('#txtSmartSearch').val('').removeClass('watermark');
                }
            });
            //if focus/click and text is watermrk, then move cursor at first position.
            $('#txtSmartSearch').on('focus click', function () {
                if ($('#txtSmartSearch').val() == watermarkSmartSearch) {
                    //$(this)[0].setSelectionRange(0, 0);
                    $('#txtSmartSearch').setCursorPosition(0);
                }
            })
            
            //Display Advance Search panel on click event
            $("#aASearch").click(function () {
                $("#divSmartSearch").hide();
                $("#divAdvanceSearch").show();
                $('#grvNeedy').hide();
                $('#txtNeedyFirstName').focus();
                $('#txtNeedyFirstName').setCursorPosition(0);
            });

            //Display Smart Search panel on click event
            $("#aSSearch").click(function () {
                $("#divSmartSearch").show();
                $("#divAdvanceSearch").hide();
                $('#grvNeedy').hide();
                $('#txtSmartSearch').focus();
                $('#txtSmartSearch').setCursorPosition(0);
            });            
            $("#divSmartSearch").show();
            $("#divAdvanceSearch").hide();           

            $('#lblNoRecord').hide();
            $('#grvNeedy').tablesorter();
            $('#grvNeedy').hide();
            
            //init, set watermark text and class            
            $('#txtNeedyFirstName').val(watermarkFirstName).addClass('watermark');
            $('#txtNeedyLastName').val(watermarkLastName).addClass('watermark');
            $('#txtNeedyPhone').val(watermarkPhone).addClass('watermark');
                      
            //if keyup/blur and no value inside, set watermark text and class again.
            $('#txtNeedyFirstName').on('keyup', function (e) {
                AddWaterMark('#txtNeedyFirstName', watermarkFirstName, true);  
            });
            $('#txtNeedyFirstName').on('blur', function (e) {
                AddWaterMark('#txtNeedyFirstName', watermarkFirstName, false);
            });

            //if keydown or drop event is raised and text is watermrk or paste event through Context menu, set it to empty and remove the watermark class
            $("#txtNeedyFirstName").bind('keydown paste drop', function (e) {   
                if ($('#txtNeedyFirstName').val() == watermarkFirstName) {
                    $('#txtNeedyFirstName').val('').removeClass('watermark');
                }
            });
            //if focus/click and text is watermrk, then move cursor at first position.
            $('#txtNeedyFirstName').on('focus click', function () {
                if ($('#txtNeedyFirstName').val() == watermarkFirstName) {
                    //$(this)[0].setSelectionRange(0, 0);
                    $('#txtNeedyFirstName').setCursorPosition(0);
                }
            })
            
            //if keyup/blur and no value inside, set watermark text and class again.
            $('#txtNeedyLastName').on('keyup', function (e) {
                AddWaterMark('#txtNeedyLastName', watermarkLastName, true);                  
            });
            $('#txtNeedyLastName').on('blur', function (e) {
                AddWaterMark('#txtNeedyLastName', watermarkLastName, false);
            });

            //if keydown or drop event is raised and text is watermrk or paste event through Context menu, set it to empty and remove the watermark class
            $("#txtNeedyLastName").bind('keydown paste drop', function (e) { 
                if ($('#txtNeedyLastName').val() == watermarkLastName) {
                    $('#txtNeedyLastName').val('').removeClass('watermark');
                }
            });
            //if focus/click and text is watermrk, then move cursor at first position.
            $('#txtNeedyLastName').on('focus click', function () {
                if ($('#txtNeedyLastName').val() == watermarkLastName) {
                    //$(this)[0].setSelectionRange(0, 0);
                    $('#txtNeedyLastName').setCursorPosition(0);
                }
            })

            //if keyup/blur and no value inside, set watermark text and class again.
            $('#txtNeedyPhone').on('keyup', function (e) {
                AddWaterMark('#txtNeedyPhone', watermarkPhone, true);                 
            });
            $('#txtNeedyPhone').on('blur', function (e) {
                AddWaterMark('#txtNeedyPhone', watermarkPhone, false);
            });
            //if keydown or drop event is raised and text is watermrk or paste event through Context menu, set it to empty and remove the watermark class
            $("#txtNeedyPhone").bind('keydown paste drop', function (e) {  
                if ($('#txtNeedyPhone').val() == watermarkPhone) {
                    $('#txtNeedyPhone').val('').removeClass('watermark');
                }
            });
            //if focus/click and text is watermrk, then move cursor at first position.
            $('#txtNeedyPhone').on('focus click', function () {
                if ($('#txtNeedyPhone').val() == watermarkPhone) {
                    //$(this)[0].setSelectionRange(0, 0);
                    $('#txtNeedyPhone').setCursorPosition(0);
                }
            })
            
            
            //Contact person -- init, set watermark text and class 
            $('#txtContactPersonFirstName').val(watermarkFirstName).addClass('watermark');
            $('#txtContactPersonLastName').val(watermarkLastName).addClass('watermark');
            $('#txtContactPhone').val(watermarkPhone).addClass('watermark');
            
            //if keyup/blur and no value inside, set watermark text and class again.
            $('#txtContactPersonFirstName').on('keyup', function (e) {
                AddWaterMark('#txtContactPersonFirstName', watermarkFirstName, true);                
            });
            $('#txtContactPersonFirstName').on('blur', function (e) {
                AddWaterMark('#txtContactPersonFirstName', watermarkFirstName, false);
            });

            //if keydown or drop event is raised and text is watermrk or paste event through Context menu, set it to empty and remove the watermark class
            $("#txtContactPersonFirstName").bind('keydown paste drop', function (e) {  
                if ($('#txtContactPersonFirstName').val() == watermarkFirstName) {
                    $('#txtContactPersonFirstName').val('').removeClass('watermark');
                }
            });
            //if focus/click and text is watermrk, then move cursor at first position.
            $('#txtContactPersonFirstName').on('focus click', function () {
                if ($('#txtContactPersonFirstName').val() == watermarkFirstName) {
                    //$(this)[0].setSelectionRange(0, 0);
                    $('#txtContactPersonFirstName').setCursorPosition(0);
                }
            })
            
            //if keyup/blur and no value inside, set watermark text and class again.
            $('#txtContactPersonLastName').on('keyup', function (e) {
                AddWaterMark('#txtContactPersonLastName', watermarkLastName, true);   
            });
            $('#txtContactPersonLastName').on('blur', function (e) {
                AddWaterMark('#txtContactPersonLastName', watermarkLastName, false);
            });

            //if keydown or drop event is raised and text is watermrk or paste event through Context menu, set it to empty and remove the watermark class
            $("#txtContactPersonLastName").bind('keydown paste drop', function (e) { 
                if ($('#txtContactPersonLastName').val() == watermarkLastName) {
                    $('#txtContactPersonLastName').val('').removeClass('watermark');
                }
            });
            //if focus/click and text is watermrk, then move cursor at first position.
            $('#txtContactPersonLastName').on('focus click', function () {
                if ($('#txtContactPersonLastName').val() == watermarkLastName) {
                    //$(this)[0].setSelectionRange(0, 0);
                    $('#txtContactPersonLastName').setCursorPosition(0);
                }
            })
            
            //if keyup/blur and no value inside, set watermark text and class again.
            $('#txtContactPhone').on('keyup', function (e) {
                AddWaterMark('#txtContactPhone', watermarkPhone, true);                  
            });
            $('#txtContactPhone').on('blur', function (e) {
                AddWaterMark('#txtContactPhone', watermarkPhone, false);
            });

            //if keydown or drop event is raised and text is watermrk or paste event through Context menu, set it to empty and remove the watermark class
            $("#txtContactPhone").bind('keydown paste drop', function (e) { 
                if ($('#txtContactPhone').val() == watermarkPhone) {
                    $('#txtContactPhone').val('').removeClass('watermark');
                }
            });
            //if focus/click and text is watermrk, then move cursor at first position.
            $('#txtContactPhone').on('focus click', function () {
                if ($('#txtContactPhone').val() == watermarkPhone) {
                    //$(this)[0].setSelectionRange(0, 0);
                    $('#txtContactPhone').setCursorPosition(0);
                }
            })
            
            $('#txtSmartSearch').focus();
            $('#txtSmartSearch').setCursorPosition(0);

            //Added by KP on 30th Jan 2020(SOW-577), To search/filter the data when enter key is pressed. 
            $(":text").keyup(function (event) { // or keypress, keydown
                //debugger;
                if (event.keyCode == 13) {
                    if ($("#divSmartSearch").is(":visible"))
                        ValidateSmartSearch();
                    else
                        BindGridView('B', 'Click');
                }
            });

        });

        //Added by KP on 12th Feb 2020(SOW-577),SET CURSOR POSITION
        $.fn.setCursorPosition = function (pos) {
            this.each(function (index, elem) {
                if (elem.setSelectionRange) {
                    elem.setSelectionRange(pos, pos);
                } else if (elem.createTextRange) {
                    var range = elem.createTextRange();
                    range.collapse(true);
                    range.moveEnd('character', pos);
                    range.moveStart('character', pos);
                    range.select();
                }
            });
            return this;
        };
         //Added by KP on 12th Feb 2020(SOW-577)
        function AddWaterMark(ctrId, watermarkSearch, SetPosition) {
            if ($(ctrId).val().length == 0) {
                $(ctrId).val(watermarkSearch).addClass('watermark');
                if (SetPosition)
                    $(ctrId).setCursorPosition(0);//move cursor at first position.
            }
        }

        //Added by KP on 3rd Feb 2020(SOW-577), To validate the smart search.
        function ValidateSmartSearch()
        {
            if ($('#txtSmartSearch').val() == watermarkSmartSearch || $('#txtSmartSearch').val().trim() == '') {
                ShowAlert('Smart Search field is mandatory.', 'E');
                return false;
            }
            GetSmartSearchData();
        }
        
        var CurrentActiveTextBox;

        function SetFocus(currentCtrl) {
            CurrentActiveTextBox = currentCtrl.id
        }

        //Created By: SM    
        //Purpose:  bind searched record  in table using jquery-json  to 
        function BindGridView(SearchType, EventType) {
            var IsAllFieldsEmpty = false;
            var FirstName = '';
            var LastName = '';
            var Phone = '';
            //var NeedyName = '';
            var NeedyPhone = '';
            //var ContactName = '';
            var ContactPhone = '';
            //Added by kuldeep rathore on 21th Aug, 2015
            var NeedyFirstName = '';
            var NeedyLastName = '';
            var ContactFirstName = '';
            var ContactLastName = '';
            $("#lblNoRecord").hide();
            var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            var IsUpdateCall = url[0].split('=')[1];
        
            // checked for search  Needy type
            if (SearchType == 'N') {                
                //Added by kuldeep rathore on 21th Aug, 2015
                if ($('#txtNeedyFirstName').val() != watermarkFirstName)
                    FirstName = document.getElementById('txtNeedyFirstName').value;
                if ($('#txtNeedyLastName').val() != watermarkLastName)
                    LastName = document.getElementById('txtNeedyLastName').value;

                if ($('#txtNeedyPhone').val() != watermarkPhone)
                    Phone = document.getElementById('txtNeedyPhone').value;

                if (FirstName == '' && LastName =='' && Phone == '') {

                    $('#grvNeedy').hide();
                    $('#lblNoRecord').show();
                    return;
                }
            }
              // checked for search by click on Search button
            else {
                
                //Added By Kuldeep Rathore on 21th Aug,2015. SOW-379
                if ($('#txtNeedyFirstName').val() != watermarkFirstName)
                    NeedyFirstName = document.getElementById('txtNeedyFirstName').value;
                if ($('#txtNeedyLastName').val() != watermarkLastName)
                    NeedyLastName = document.getElementById('txtNeedyLastName').value;

                if ($('#txtNeedyPhone').val() != watermarkPhone)
                    NeedyPhone = document.getElementById('txtNeedyPhone').value;

                //Added By Kuldeep Rathore on 21th Aug,2015. sow-379
                if ($('#txtContactPersonFirstName').val() != watermarkFirstName)
                   ContactFirstName = document.getElementById('txtContactPersonFirstName').value;
                if ($('#txtContactPersonLastName').val() != watermarkLastName)
                    ContactLastName = document.getElementById('txtContactPersonLastName').value;

                //get Contact Person phone
                if ($('#txtContactPhone').val() != watermarkPhone)
                    ContactPhone = document.getElementById('txtContactPhone').value;
               
                //Added by KP on 22 Sept 2017, To set SearchType based on Needy and Contact person
                if ((NeedyFirstName != '' || NeedyLastName != '' || NeedyPhone != '') && ContactFirstName == '' && ContactLastName == '' && ContactPhone == '') {
                    SearchType = 'N';
                }
                else if (NeedyFirstName == '' && NeedyLastName == '' && NeedyPhone == '' && ContactFirstName == '' && ContactLastName == '' && ContactPhone == '') {
                    IsAllFieldsEmpty = true;
                    SearchType = 'N';
                }
                
                if (EventType == 'Keyup' && IsAllFieldsEmpty == true) {
                    $('#grvNeedy').hide();
                    $('#lblNoRecord').show();
                    return;
                }
            }
            
            var isUpdatetrigger = false;
            //Created By:Kuldeep rathore
            //Date:05/20/2015
            //purpose:To show the progress Bar
            $('#Progressbar').show();

            //Added by KP on 21 Sept 2017, Set fields of Needy and Contact
            var obj = {};
            obj.strFirstName = NeedyFirstName.replace(/'/g, "''");
            obj.strLastName = NeedyLastName.replace(/'/g, "''");
            obj.strPhone = NeedyPhone.replace(/'/g, "''");
            obj.strSearchType = SearchType;
            obj.IsUpdateCall = IsUpdateCall;
            obj.ContactFirstName = ContactFirstName.replace(/'/g, "''");
            obj.ContactLastName = ContactLastName.replace(/'/g, "''");
            obj.ContactPhone = ContactPhone.replace(/'/g, "''");

            // call method using jquery-json and bind records
            $.ajax({
                type: "POST",
                url: "NeedyPersonSearch.aspx/GetPersonDetails",                
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                data: JSON.stringify(obj),
                contentType: "application/json",
                dataType: "json",
                success: function (data) {
                    BindGrid(data, IsUpdateCall);                    
                },
                //Authore:Kuldeep Rathore
                //Date:05/20/2015
                //Purpose:Hide the Progress Bar
                complete: function () {
                    $('#Progressbar').hide();
                }
            });
            if (CurrentActiveTextBox != null)
                $('#' + CurrentActiveTextBox).focus();
            else
                $('#txtNeedyFirstName').focus();

            // SetFocus(currentCtrl);

        }
        function BindGrid(data, IsUpdateCall)
        {
            $('#grvNeedy').show();
            $('#grvNeedy tbody').empty();

            if (data.d.length > 0) {
                $('#lblNoRecord').hide();
                for (var i = 0; i < data.d.length; i++) {
                    // Prevent to display non  call data to be display on aspx page
                    if (data.d[i].ContactDateTime == '' && IsUpdateCall == 1) {
                    } else {

                        isUpdatetrigger = true;

                        if (i % 2 == 0) {
                            // set css for alternate row color
                            // Added by Kuldeep Rathore on 21th Aug, 2015. SOW-379
                            if (IsUpdateCall == 1) {
                                $("#grvNeedy").append("<tr style='word-break:break-all;word-wrap:break-word' ><td ><a href='NeedyPerson.aspx?NdID=" + data.d[i].NeedyPersonID + "&IsNew=0&CPID=" + data.d[i].ContactPersonID + "&CLID=" + data.d[i].CallHistoryID + "&UC=" + IsUpdateCall + "'>" + data.d[i].NeedyPersonFirstName + "</a></td><td>" + data.d[i].NeedyPersonLastName + "</td>" +
                                    "<td>" + data.d[i].NeedyPersonDOB + "</td><td>" + data.d[i].NeedyPersonPhonePri + "</td><td>" + data.d[i].NeedyPersonPhoneAlt + "</td> <td>" + data.d[i].ContactDateTime + "</td><td>" + data.d[i].UserName + "</td><td >" + data.d[i].ContactPersonFirstName + "</td><td >" + data.d[i].ContactPersonLastName + "</td><td>" + data.d[i].ContactPersonPhonePri + "</td><td>" + data.d[i].ContactPersonPhoneAlt + "</td></tr>");
                            }
                            else {
                                $("#grvNeedy").append("<tr style='word-break:break-all;word-wrap:break-word' ><td ><a href='NeedyPerson.aspx?NdID=" + data.d[i].NeedyPersonID + "&IsNew=0&CPID=" + data.d[i].ContactPersonID + "&CLID=" + data.d[i].CallHistoryID + "&UC=" + IsUpdateCall + "'>" + data.d[i].NeedyPersonFirstName + "</a></td><td>" + data.d[i].NeedyPersonLastName + "</td>" +
                                    "<td>" + data.d[i].NeedyPersonDOB + "</td><td>" + data.d[i].NeedyPersonPhonePri + "</td><td>" + data.d[i].NeedyPersonPhoneAlt + "</td> <td>" + data.d[i].ContactDateTime + "</td><td >" + data.d[i].ContactPersonFirstName + "</td><td >" + data.d[i].ContactPersonLastName + "</td><td>" + data.d[i].ContactPersonPhonePri + "</td><td>" + data.d[i].ContactPersonPhoneAlt + "</td></tr>");
                            }

                        }
                        else {

                            if (IsUpdateCall == 1) {// Changes done by SA on 20th May, 2015.
                                $("#grvNeedy").append("<tr style='word-break:break-all;word-wrap:break-word' ><td ><a href='NeedyPerson.aspx?NdID=" + data.d[i].NeedyPersonID + "&IsNew=0&CPID=" + data.d[i].ContactPersonID + "&CLID=" + data.d[i].CallHistoryID + "&UC=" + IsUpdateCall + "'>" + data.d[i].NeedyPersonFirstName + "</a></td><td>" + data.d[i].NeedyPersonLastName + "</td>" +
                                    "<td>" + data.d[i].NeedyPersonDOB + "</td><td>" + data.d[i].NeedyPersonPhonePri + "</td><td>" + data.d[i].NeedyPersonPhoneAlt + "</td> <td>" + data.d[i].ContactDateTime + "</td><td>" + data.d[i].UserName + "</td><td >" + data.d[i].ContactPersonFirstName + "</td><td >" + data.d[i].ContactPersonLastName + "</td><td>" + data.d[i].ContactPersonPhonePri + "</td><td>" + data.d[i].ContactPersonPhoneAlt + "</td></tr>");
                            }
                            else {
                                $("#grvNeedy").append("<tr style='word-break:break-all;word-wrap:break-word' ><td ><a href='NeedyPerson.aspx?NdID=" + data.d[i].NeedyPersonID + "&IsNew=0&CPID=" + data.d[i].ContactPersonID + "&CLID=" + data.d[i].CallHistoryID + "&UC=" + IsUpdateCall + "'>" + data.d[i].NeedyPersonFirstName + "</a></td><td>" + data.d[i].NeedyPersonLastName + "</td>" +
                                    "<td>" + data.d[i].NeedyPersonDOB + "</td><td>" + data.d[i].NeedyPersonPhonePri + "</td><td>" + data.d[i].NeedyPersonPhoneAlt + "</td> <td>" + data.d[i].ContactDateTime + "</td><td >" + data.d[i].ContactPersonFirstName + "</td><td >" + data.d[i].ContactPersonLastName + "</td><td>" + data.d[i].ContactPersonPhonePri + "</td><td>" + data.d[i].ContactPersonPhoneAlt + "</td></tr>");
                            }
                        }
                    }
                }

                if (isUpdatetrigger == true)
                    $('.tablesorter').trigger('update');
                else {
                    $('#grvNeedy').hide();

                    $('#lblNoRecord').show();
                }

                if (IsUpdateCall == 1)
                    $("#lblGridContactPersonHeader").html('Contact Person');
                else
                    $("#lblGridContactPersonHeader").html('Primary Contact Person');
            }
            else {
                $('#grvNeedy').hide();
                $('#lblNoRecord').show();

            }
        }

        //Created By: KP
        //Date: 26th Dec 2019(SOW-577)
        //purpose: Get needy data as based on Smart Search process.
        function GetSmartSearchData() {
            
            $('#Progressbar').show();

            var txtSmartSearch = ''
            if ($('#txtSmartSearch').val() != watermarkSmartSearch)
                txtSmartSearch = $('#txtSmartSearch').val().trim();

            var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            var IsUpdateCall = url[0].split('=')[1];

            var obj = {};
            obj.SmartSearch = txtSmartSearch;
            obj.IsUpdateCall = IsUpdateCall;

            // call method using jquery-json and bind records
            $.ajax({
                type: "POST",
                url: "NeedyPersonSearch.aspx/GetSmartSearchNeeding",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                data: JSON.stringify(obj),
                contentType: "application/json",
                dataType: "json",
                success: function (data) {
                    BindGrid(data, IsUpdateCall);                    
                },
                complete: function () {
                    $('#Progressbar').hide();
                }
            });
            
           $('#txtSmartSearch').focus();
        }

    </script>

    <div class="clear_01"></div>
    <div class="search_heading">Search Person Needing Assistance</div>
    <div class="main_search">
        <table width="80%" border="0" cellpadding="0" cellspacing="0" align="center" style="margin: 0 auto;">
            <tr id="rwUpdateCall">
                <td id="colUpdateCall" align="center" style="border: 1px">
                    <label id="lblUpdateMessage" style="color: White"></label>
                </td>
                <td></td>
            </tr>
            <tr>
                <td colspan="2" style="width:100%">                        
                    <div id="divSmartSearch">
                        <table style="width:100%">
                            <tr>
                                <td colspan="2" style="width:100%">
                        
                                    <table style="width:100%">
                                        <tr>
                                            <td align="right" style="width:85%">
                                                <input type="text" id="txtSmartSearch"  onblur="SetFocus(this);" onfocus="SetFocus(this);"
                                                    class="search_name" maxlength="100" style="width: 85%;" autocomplete="off" />
                                            </td>
                                            <td align="left">
                                                <input id="btnSmartSearch" type="button" name="btnSmartSearch" value="Search" class="btn_styleSearch" onclick="javascript: ValidateSmartSearch();" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>                
                            </tr>
                            <tr>
                                <td colspan="2" style="width:100%">
                                    <div style="width: 70%; margin: auto; position: relative;">
                                        <label>Examples:</label>
                                        <ul style="font-size:9px;margin-left:12px;">
                                            <li>Name: Search by First Name or/and Last Name like Adam Smith or Adam or Smith</li>
                                            <li>Phone: Search by Phone-Primary or Phone-Alt like 123-456-7890 or 123456790 </li>
                                            <li>DOB: Search by DOB like 01/13/1950 or 01-13-1950</li>
                                        </ul>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center" style="padding: 10px 0 20px 0;">
                                    Click here for <a id="aASearch" href="javascript:void(0);">Advanced Search</a>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div id="divAdvanceSearch" style="display:none">
                        <table style="width:100%">
                            <tr>
                                <td>
                                    <fieldset>
                                        <legend>Person Needing Assistance</legend>
                                        <div align="center">
                                            <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td align="left">
                                                            <%-- Commented By Kuldeep Rathore on 20th aug,2015. SOW-379 --%>
                                                        <%--<span class="search_label">Name:</span>--%>
                                                        <%-- Removed onkeyup="javascript:ClearValues('N');BindGridView('N');" on 27th May, 2015. SOW-362. As called from page load to delay in search.--%>
                                                        <%--<input type="text" id="txtNeedyName"  onblur="SetFocus(this);" onfocus="SetFocus(this);"
                                                            class="search_name" maxlength="50" style="width: 250px;" />--%>
                                                            <%-- Added By Kuldeep Rathore on 20th aug,2015. SOW-379 --%>
                                                        <span class="search_label">First Name:</span>
                                                            <input type="text" id="txtNeedyFirstName"  onblur="SetFocus(this);" onfocus="SetFocus(this);"
                                                            class="search_name" maxlength="50" style="width: 150px;" autocomplete="off"/>
                                                    </td>
                                                        <%-- Added By Kuldeep Rathore on 20th aug,2015. SOW-379 --%>
                                                    <td align="center">
                                                        <span class="second_opt">And/Or</span>
                                                    </td>
                                                        <%-- Added By Kuldeep Rathore on 20th aug,2015. SOW-379 --%>
                                                        <td align="left">                                     

                                                        <span class="search_label">Last Name:</span>
                                                            <input type="text" id="txtNeedyLastName"  onblur="SetFocus(this);" onfocus="SetFocus(this);"
                                                            class="search_name" maxlength="50" style="width: 150px;" autocomplete="off"/>
                                                    </td>
                                                    <td align="center">
                                                        <span class="second_opt">And/Or</span>
                                                    </td>
                                                    <td align="right">
                                                        <span class="search_label">Phone:</span>
                                                        <%-- Removed onkeyup="javascript:ClearValues('N');BindGridView('N');" on 27th May, 2015. SOW-362. As called from page load to delay in search.--%>
                                                        <input type="text" id="txtNeedyPhone" onblur="SetFocus(this);" onfocus="SetFocus(this);"
                                                            class="search_phone" maxlength="15" autocomplete="off"/>
                                                    </td>
                                                    <td>&nbsp; 
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </fieldset>
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>
                                    <fieldset>
                                        <legend>Contact Person</legend>
                                        <div align="center">


                                            <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td align="left">
                                                            <%-- Commented By Kuldeep Rathore on 20th aug,2015. SOW-379 --%>
                                                        <%--<span class="search_label">Name:</span>--%>
                                                        <%-- Removed onkeyup="javascript:ClearValues('C');BindGridView('C');" on 27th May, 2015. SOW-362. As called from page load to delay in search. --%>
                                                        <%--<input type="text" id="txtContactPerson" onblur="SetFocus(this);" onfocus="SetFocus(this);"
                                                            class="search_name" maxlength="50" style="width: 250px;" />--%>
                                                            <%-- Added By Kuldeep Rathore on 21th aug,2015. SOW-379 --%>
                                                        <span class="search_label">First Name:</span>
                                                        <input type="text" id="txtContactPersonFirstName" onblur="SetFocus(this);" onfocus="SetFocus(this);"
                                                            class="search_name" maxlength="50" style="width: 150px;" autocomplete="off"/>
                                                    </td>
                                                        <%-- Added By Kuldeep Rathore on 20th aug,2015. SOW-379 --%>
                                                    <td align="center">
                                                        <span class="second_opt">And/Or</span>
                                                    </td>
                                                        <%-- Added By Kuldeep Rathore on 20th aug,2015. SOW-379 --%>
                                                    <td align="left">                                 
                                                        <span class="search_label">Last Name:</span>
                                                        <input type="text" id="txtContactPersonLastName" onblur="SetFocus(this);" onfocus="SetFocus(this);"
                                                            class="search_name" maxlength="50" style="width: 150px;" autocomplete="off"/>
                                                    </td>
                                                    <td align="center">
                                                        <span class="second_opt">And/Or</span>
                                                    </td>
                                                    <td align="right">
                                                        <span class="search_label">Phone:</span>
                                                        <%-- Removed onkeyup="javascript:ClearValues('C');BindGridView('C');" on 27th May, 2015. SOW-362. As called from page load to delay in search. --%>
                                                        <input type="text" id="txtContactPhone" onblur="SetFocus(this);" onfocus="SetFocus(this);"
                                                            class="search_phone" maxlength="15" autocomplete="off"/>
                                                    </td>
                                                    <td width="25px"></td>
                                                </tr>



                                                <tr>
                                                    <td align="right" colspan="6">
										                <span style="color: blue;">*&nbsp;Search Person Needing Assistance having no name by "NA"</span>&nbsp;&nbsp;&nbsp;
                                                        <input id="btnSearch" type="button" name="btnShowAll" value="Search" class="btn_styleSearch" onclick="javascript: BindGridView('B', 'Click');" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </fieldset>
                                </td>
                                <td>
                                    <%-- <a href="NeedyPerson.aspx?NdID=0&IsNew=1" class="add_person_link">New Person</a>--%>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center" style="padding: 10px 0 20px 0;">
                                    Click here for <a id="aSSearch" href="javascript:void(0);">Smart Search</a>
                                </td>
                            </tr>
                            </table>
                    </div>                        
                </td>
            </tr>

        </table>
    </div>
 

    <div class="search_result">
        <div class="no-found">
            <label id="lblNoRecord">No Record Found.</label>
        </div>


        <table border="1" cellpadding="0" cellspacing="0" class="sub_hearder tablesorter"
            id="grvNeedy" width="98%" style="margin: 0px auto; border-collapse: collapse;">
            <thead id="tableHead">

                <tr class="gridview_main_header">
                    
                    <%-- // Changes done by SA on 20th May, 2015. --%>
                    <% if (IsUpdateCall1 == 1) %>
                    <%{ %>
                    <td colspan="7" align="center">Person Needing Assistance</td>
                    <td colspan="4" align="center">
                        <label id="lblGridContactPersonHeader" style="background-color: #1a3895; color: #fff; text-align: center; font-size: 11px; font-weight: bold"></label>
                    </td>
                    <%} %>
                    <%else %>
                    <%{ %>
                    <td colspan="6" align="center">Person Needing Assistance</td>
                    <td colspan="4" align="center">
                        <label id="lblGridContactPersonHeader" style="background-color: #1a3895; color: #fff; text-align: center; font-size: 11px; font-weight: bold"></label>
                    </td>
                    <%} %>
                </tr>

                <tr id="rwSecond">
                    <%--class="sub_hearder"--%>
                     <%-- Added By Kuldeep Rathore on 20th aug,2015. SOW-379 --%>
                    <th width="9%">First Name</th>
                    <th width="8%">Last Name</th>
                    <%-- Added Section Ends here --%>
                    <th width="7%">DOB</th>
                    <th width="10%">Phone-Primary</th>
                    <th width="10%">Phone-Alt</th>
                    <th width="12%">Contact Date & Time<!--Last Call On --></th>
                    <%-- // Changes done by SA on 20th May, 2015. --%>
                    <% if (IsUpdateCall1 == 1) %>
                    <%{ %>
                    <th width="9%">User Name</th>
                    <%} %>

                     <%-- Commneted By Kuldeep Rathore on 20th aug,2015. SOW-379 --%>
                    <%--<th width="12%">Name</th>--%>
                     <%-- Added By Kuldeep Rathore on 21th aug,2015. SOW-379 --%>
                    <th width="8%">First Name</th>
                    <th width="8%">Last Name</th>
                    <%-- Added Section Ends Here --%>
                    <th width="10%">Phone-Primary</th>
                    <th width="10%">Phone-Alt</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <%-- // Changes done by SA on 20th May, 2015. --%>
                    <% if (IsUpdateCall1 == 1) %>
                    <%{ %>
                    <td colspan="11"></td>
                    <%} %>
                    <%else %>
                    <%{ %>
                    <td colspan="10"></td>
                    <%} %>
                </tr>
            </tbody>
        </table>
    </div>
    <!-- Added By Kuldeep Rathore on 20th May,  2015 -->
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
