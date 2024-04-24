<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site.master" AutoEventWireup="true"
	CodeFile="AdminNeedyPersonSearch.aspx.cs" Inherits="AdminNeedyPersonSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">

	<%--<script src="../Scripts/jquery-1.9.1.min.js" type="text/javascript"></script>
	<script src="../Scripts/jquery.tablesorter.min.js" type="text/javascript"></script>--%>
	<%-- Added --%>
	<script src="../Scripts/underscore.js" type="text/javascript"></script>
	   <%-- <script type="text/javascript" src="../Scripts/common_functions.js"></script>--%>
	<!--#include file ="~/CustomAlertInclude.inc"-->
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

		//$(function () {

		//	// Created by SA on 27th May, 2015. SOW-362. To invoke search functions.
		//	//Logic: feature that if user type fast then it should not go for search for every key press.(Delay: 500 ms)

		//	//$("#txtNeedyName").keyup(_.debounce(NeedyPersonName_PhoneSearch, 500));//Commented By Kuldeep Rathore on 19th Aug, 2015. SOW-379
		//	$("#txtNeedyFirstName").keyup(_.debounce(NeedyPersonName_PhoneSearch, 500));//Added By Kuldeep Rathore on 19th Aug, 2015. SOW-379
		//	$("#txtNeedyLastName").keyup(_.debounce(NeedyPersonName_PhoneSearch, 500));//Added By Kuldeep Rathore on 19th Aug, 2015. SOW-379
		//	$("#txtNeedyPhone").keyup(_.debounce(NeedyPersonName_PhoneSearch, 500));

		//	// $("#txtContactPerson").keyup(_.debounce(ContactPersonName_PhoneSearch, 500));//Commented By Kuldeep Rathore on 19th Aug, 2015. SOW-379
		//	$("#txtContactPersonFirstName").keyup(_.debounce(ContactPersonName_PhoneSearch, 500));//Added By Kuldeep Rathore on 19th Aug, 2015. SOW-379
		//	$("#txtContactPersonLastName").keyup(_.debounce(ContactPersonName_PhoneSearch, 500));//Added By Kuldeep Rathore on 19th Aug, 2015. SOW-379
		//	$("#txtContactPhone").keyup(_.debounce(ContactPersonName_PhoneSearch, 500));
  //      });

		//// Created by SA on 27th May, 2015. SOW-362. To pass this function as parameter to _.debounce function
		//function NeedyPersonName_PhoneSearch() {
		//	//ClearValues('B');//N
		//	BindGridView('B', 'Keyup');
		//}

		//// Created by SA on 27th May, 2015. SOW-362. To pass this function as parameter to _.debounce function
		//function ContactPersonName_PhoneSearch() {
		//	//ClearValues('B');
		//	BindGridView('B', 'Keyup');
		//}

	</script>


	<script type="text/javascript">

        var watermarkSmartSearch = 'Search by Name/Phone/DOB of Person Needing Assistance or Name/Phone of Contact Person';
		var watermarkFirstName = 'First Name (like Adam) ';
		var watermarkLastName = 'Last Name (like Smith)'
		var watermarkPhone = 'Phone Number';

		var mouseX, mouseY, windowWidth, windowHeight;
		var popupLeft, popupTop;

        //Modified by KP on 26th Dec 2019(SOW-577), Smart search is added, Advance search and watermarks are modified.
		$(document).ready(function () {

			$("#grvNeedy").tablesorter();//added by SA on 8th July, 2015.
			$("#gridHistory").tablesorter({
				headers:
				{
					7: { sorter: false }
				}

			});
            
			$('#lblNoRecord').hide();
			$("#grdSearchByContactPerson").tablesorter({//Index changed from 5,6 to 7,8. SA on 30th Aug, 2015. SOW-379
				headers:
				{
					7: { sorter: false },
					8: { sorter: false }
				}
			});

			$("#grdSearchbyNeedy").tablesorter({//4,5,6 to 5,6,7 //Index changed  SA on 30th Aug, 2015. SOW-379
				headers:
				{
					5: { sorter: false },
					6: { sorter: false },
					7: { sorter: false }
				}
			});
            
			$("#grdCPPopUp").tablesorter({
				headers:
				{
					4: { sorter: false },
					5: { sorter: false }
				}
            });
                      

            //Smart search block
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
                    $('#txtSmartSearch').setCursorPosition(0);
                }
            })

            //Display Advance Search panel on click event
            $("#aASearch").click(function () {
                $("#divSmartSearch").hide();
                $("#divAdvanceSearch").show();
                $('#grvNeedy').hide();
                $('#grdSearchByContactPerson').hide();
                $('#grdSearchbyNeedy').hide();
                $('#txtNeedyFirstName').focus();
                $('#txtNeedyFirstName').setCursorPosition(0);
            });

            //Display Smart Search panel on click event
            $("#aSSearch").click(function () {
                $("#divSmartSearch").show();
                $("#divAdvanceSearch").hide();
                $('#grvNeedy').hide();
                $('#grdSearchByContactPerson').hide();
                $('#grdSearchbyNeedy').hide();
                $('#txtSmartSearch').focus();
                $('#txtSmartSearch').setCursorPosition(0);
            });
            $("#divSmartSearch").show();
            $("#divAdvanceSearch").hide();     
            //End Smart search


            $('#grdSearchByContactPerson').hide();
                              
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
                    $('#txtNeedyPhone').setCursorPosition(0);
                }
            })
            
			
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
                    $('#txtContactPhone').setCursorPosition(0);
                }
            })
                    
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

			//==================================================================================================================================
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
        function ValidateSmartSearch() {
            if ($('#txtSmartSearch').val() == watermarkSmartSearch || $('#txtSmartSearch').val().trim() == '') {
                ShowAlert('Smart Search field is mandatory.', 'E');
                return false;
			}
            GetSmartSearchData();
        }

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
			$(divpnlContact).offset({ top: popupTop, left: popupLeft });
		}
		
		var CurrentActiveTextBox;
		function SetFocus(currentCtrl) {
			CurrentActiveTextBox = currentCtrl.id
		}
		//Created By: SM    
		//Purpose:  bind searched record  in table using jquery-json  to 
		function BindGridView(SearchType, EventType) {
			var IsAllFieldsEmpty = false;
			// var Name = '';  //Commnetd By Kuldeep Rathore on 19th Aug, 2015. SOW-379
			var FirstName = '';  //Added By Kuldeep Rathore on 19th Aug, 2015. SOW-379
			var LastName = '';
			var Phone = '';
			//var NeedyName = '';  //Commnetd By Kuldeep Rathore on 19th Aug, 2015. SOW-379
			var NeedyPhone = '';
			var NeedyFirstName = ''; //Added By Kuldeep Rathore on 19th Aug, 2015. SOW-379
			var NeedyLastName = ''; //Added By Kuldeep Rathore on 19th Aug, 2015. SOW-379
			// var ContactName = '';  //Commnetd By Kuldeep Rathore on 19th Aug, 2015. SOW-379
			var ContactPhone = '';
			var ContactFirstName = '';//Added By Kuldeep Rathore on 19th Aug, 2015. SOW-379
			var ContactLastName = '';//Added By Kuldeep Rathore on 19th Aug, 2015. SOW-379
			$("#lblNoRecord").hide();

			var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
			var IsUpdateCall = url[0].split('=')[1];
			// checked for search  Needy type
			if (SearchType == 'N') {

				//Added By Kuldeep Rathore on 19th Aug, 2015.
				if ($('#txtNeedyFirstName').val() != watermarkFirstName)
					FirstName = document.getElementById('txtNeedyFirstName').value;
				if ($('#txtNeedyLastName').val() != watermarkLastName)
					LastName = document.getElementById('txtNeedyLastName').value;

				if ($('#txtNeedyPhone').val() != watermarkPhone)
					Phone = document.getElementById('txtNeedyPhone').value;
				//Change Condition by Kuldeep rathore  from if (Name == '' && Phone == '') to if (FirstName == '' && LastName=='' && Phone == '') on 19th Aug 2015.SOW-379
				if (FirstName == '' && LastName == '' && Phone == '') {
					$('#grvNeedy').hide();//added by SA on 11th June, 2015.                    
					$('#grdSearchbyNeedy').hide();
					$('#lblNoRecord').show();
					return;
				}
			}
			// checked for search by click on Search button
			else {
				//Added By Kuldeep Rathore on 19th Aug, 2015. SOW-379.
				if ($('#txtNeedyFirstName').val() != watermarkFirstName)
					NeedyFirstName = document.getElementById('txtNeedyFirstName').value.trim();
				if ($('#txtNeedyLastName').val() != watermarkLastName)
					NeedyLastName = document.getElementById('txtNeedyLastName').value.trim();

				if ($('#txtNeedyPhone').val() != watermarkPhone)
					NeedyPhone = document.getElementById('txtNeedyPhone').value.trim();
				//get Conact person Name              
				//Added By Kuldeep Rathore on 19th Aug, 2015. SOW-379
				if ($('#txtContactPersonFirstName').val() != watermarkFirstName)
					ContactFirstName = document.getElementById('txtContactPersonFirstName').value.trim();
				if ($('#txtContactPersonLastName').val() != watermarkLastName)
					ContactLastName = document.getElementById('txtContactPersonLastName').value.trim();
				//get Contact Person phone
				if ($('#txtContactPhone').val() != watermarkPhone)
					ContactPhone = document.getElementById('txtContactPhone').value.trim();

				//Added by KP on 22 Sept 2017, To set SearchType based on Needy and Contact person
				if ((NeedyFirstName != '' || NeedyLastName != '' || NeedyPhone != '') && ContactFirstName == '' && ContactLastName == '' && ContactPhone == '') {
					SearchType = 'N';
				}
				else if (NeedyFirstName == '' && NeedyLastName == '' && NeedyPhone == '' && ContactFirstName == '' && ContactLastName == '' && ContactPhone == '') {
					IsAllFieldsEmpty = true;
					SearchType = 'N';
				}

				//Added by KP on 22 Sept 2017, To display no record when grid bound from keyup event                
				if (EventType == 'Keyup' && IsAllFieldsEmpty == true) {
					$('#grvNeedy').hide();
					$('#grdSearchbyNeedy').hide();
					$('#grdSearchByContactPerson').hide();
					$('#lblNoRecord').show();
					return;
				}
			}


			var SiteID = $("#<%=ddlAAACILName.ClientID %> option:selected").val();
			//****************************************************************************************
			if (IsUpdateCall == 0) {
				// Call this function when search for new call or for delete records
                BindGridOnNewCall(NeedyFirstName, NeedyLastName, NeedyPhone, SearchType, IsUpdateCall, SiteID, ContactFirstName, ContactLastName, ContactPhone);
			}
			else {
				// Call this function when search for update call
                BindGridOnUpdateCall(NeedyFirstName, NeedyLastName, NeedyPhone, SearchType, IsUpdateCall, SiteID, ContactFirstName, ContactLastName, ContactPhone);
			}
			//*******************************************************************************************
			if (CurrentActiveTextBox != null)
				$('#' + CurrentActiveTextBox).focus();
			else
				$('#txtNeedyFirstName').focus();
			// SetFocus(currentCtrl);
		}

		//Created By : Sanyosh Maurya
		// Date: 02 feb 2014
		// Purpose: Call This Function when search for new call
		function BindGridOnNewCall(FirstName, LastName, Phone, SearchType, IsUpdateCall, SiteID, ContactFirstName, ContactLastName, ContactPhone) {
			$('#lblNoRecord').hide();
			if (IsUpdateCall == 1)
				$("#lblGridContactPersonHeader").html('Contact Person');
			else
				$("#lblGridContactPersonHeader").html('Primary Contact Person');
			var isUpdatetrigger = false;
			var AgencyLink = '';
			var HiddenField = '';
			var NeedyName = '';			
			$('#Progressbar').show();

			//Added by KP on 21 Sept 2017, Set fields of Needy and Contact
			var obj = {};
            obj.strFirstName = FirstName.replace(/'/g, "''");
            obj.strLastName = LastName.replace(/'/g, "''");
            obj.strPhone = Phone.replace(/'/g, "''");
			obj.strSearchType = SearchType;
			obj.IsUpdateCall = IsUpdateCall;
			obj.AAASiteID = SiteID;
            obj.ContactFirstName = ContactFirstName.replace(/'/g, "''");
            obj.ContactLastName = ContactLastName.replace(/'/g, "''");
            obj.ContactPhone = ContactPhone.replace(/'/g, "''");
			//end

			$.ajax({
				type: "POST",
                url: "AdminNeedyPersonSearch.aspx/GetPersonDetails",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
				data: JSON.stringify(obj),
				contentType: "application/json",
				dataType: "json",
				asyn: false,
                success: function (data) {
                    BindNewCall(data, IsUpdateCall, SiteID, SearchType);
                },
				complete: function () {
					$('#Progressbar').hide();
				}
			});
		}

		//Created By : Sanyosh Maurya
		// Date: 02 feb 2014
		// Purpose: Call This Function when search for Update call
		function BindGridOnUpdateCall(FirstName, LastName, Phone, SearchType, IsUpdateCall, SiteID, ContactFirstName, ContactLastName, ContactPhone) {

			$('#lblNoRecord').hide();

			if (IsUpdateCall == 1)
				$("#lblGridContactPersonHeader").html('Contact Person');
			else
				$("#lblGridContactPersonHeader").html('Primary Contact Person');

			var isUpdatetrigger = false;
			var AgencyLink = '';
			var HiddenField = '';
			var NeedyName = '';
			$('#Progressbar').show();

			//Added by KP on 21 Sept 2017, Set fields of Needy and Contact
			var obj = {};
            obj.strFirstName = FirstName.replace(/'/g, "''");
            obj.strLastName = LastName.replace(/'/g, "''");
            obj.strPhone = Phone.replace(/'/g, "''");
			obj.strSearchType = SearchType;
			obj.IsUpdateCall = IsUpdateCall;
			obj.AAASiteID = SiteID;
            obj.ContactFirstName = ContactFirstName.replace(/'/g, "''");
            obj.ContactLastName = ContactLastName.replace(/'/g, "''");
            obj.ContactPhone = ContactPhone.replace(/'/g, "''");
			//end

			// call method using jquery-json and bind records
			$.ajax({
				type: "POST",
                url: "AdminNeedyPersonSearch.aspx/GetPersonDetails",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
				data: JSON.stringify(obj),
				contentType: "application/json",
				dataType: "json",
				asyn: false,
				success: function (data) {
                    BindUpdateCall(data, IsUpdateCall, SiteID);
				},
				complete: function () {
					$('#Progressbar').hide();
				},
			});

		}

        function BindUpdateCall(data, IsUpdateCall, SiteID){

            $('#grvNeedy tbody').empty();

            if (data.d.length > 0) {
                $('#grvNeedy').show();
                $('#lblNoRecord').hide();
                for (var i = 0; i < data.d.length; i++) {
                    // Prevent to display non  call data to be display on aspx page
                    NeedyName = '';
                    if (data.d[i].ContactDateTime == '' && IsUpdateCall == 1) {
                    } else {

                        isUpdatetrigger = true;

                        if (SiteID == -1 && data.d[i].ADRCSiteId != '0') {//Commented by KP on 13th April 2020(TaskID:18464), && (data.d[i].ADRCAgencyName != '' || data.d[i].ADRCSiteId == '')) {
                            AgencyLink = "&nbsp;<a href='javascript:void(0);' class='view_call_history_More' style='color:blue' onmouseover='showHideADRCPopup(" + data.d[i].NeedyPersonID + "," + data.d[i].ADRCSiteId + ",0);' onmouseout='showHideADRCPopup(" + data.d[i].NeedyPersonID + "," + data.d[i].ADRCSiteId + ",1);' >[Agency]</a> "
                            HiddenField = "&nbsp;<input type='hidden' id='hdnAgency" + data.d[i].NeedyPersonID + "' value='" + data.d[i].ADRCAgencyName + "'/>";
                        }
                        else {
                            AgencyLink = '';
                            HiddenField = '';
                        }


                        //Added By Kuldeep rathore on 20th aug 2015. SOW-379
                        var NeedyFirstName = '';
                        if (data.d[i].NeedyPersonName != 'NA')
                            NeedyFirstName = "<a href='../NeedyPerson.aspx?NdID=" + data.d[i].NeedyPersonID + "&IsNew=0&CPID=" + data.d[i].ContactPersonID + "&CLID=" + data.d[i].CallHistoryID + "&UC=" + IsUpdateCall + "&SiteID=" + data.d[i].ADRCSiteId + "'>" + data.d[i].NeedyPersonFirstName + "</a> ";//"&SiteID=" + data.d[i].ADRCSiteId + Removed by SA on 21-1-2015. SOW-335. As not required.
                        else
                            NeedyFirstName = data.d[i].NeedyPersonFirstName;


                        //Added By kuldeep Rathore on 20th Aug 2015. SOW-379
                        if (i % 2 == 0) {
                            // set css for alternate row color 
                            $("#grvNeedy").append("<tr style='word-break:break-all;word-wrap:break-word' ><td >" + NeedyFirstName + "   " + AgencyLink + " " + HiddenField + "</td><td>" + data.d[i].NeedyPersonLastName + "</td>" +
                                "<td>" + data.d[i].NeedyPersonDOB + "</td><td>" + data.d[i].NeedyPersonPhonePri + "</td><td>" + data.d[i].NeedyPersonPhoneAlt + "</td> <td>" + data.d[i].ContactDateTime + "</td><td>" + data.d[i].UserName + "</td><td >" + data.d[i].ContactPersonFirstName + "</td><td >" + data.d[i].ContactPersonLastName + "</td><td>" + data.d[i].ContactPersonPhonePri + "</td><td>" + data.d[i].ContactPersonPhoneAlt + "</td></tr>");


                        }
                        else {

                            $("#grvNeedy").append("<tr  class='gridview_alternaterow' style='word-break:break-all;word-wrap:break-word'><td >" + NeedyFirstName + "   " + AgencyLink + " " + HiddenField + "</td><td>" + data.d[i].NeedyPersonLastName + "</td>" +
                                "<td>" + data.d[i].NeedyPersonDOB + "</td><td>" + data.d[i].NeedyPersonPhonePri + "</td><td>" + data.d[i].NeedyPersonPhoneAlt + "</td> <td>" + data.d[i].ContactDateTime + "</td><td>" + data.d[i].UserName + "</td><td >" + data.d[i].ContactPersonFirstName + "</td><td >" + data.d[i].ContactPersonLastName + "</td><td>" + data.d[i].ContactPersonPhonePri + "</td><td>" + data.d[i].ContactPersonPhoneAlt + "</td></tr>");

                        }
                    }
                }
                if (isUpdatetrigger == true)
                    $('.tablesorter').trigger('update');
                else {
                    $('#grvNeedy').hide();

                    $('#lblNoRecord').show();
                }
            }
            else {
                $('#grvNeedy').hide();
                $('#lblNoRecord').show();

            }
        }
        
        function BindNewCall(data, IsUpdateCall, SiteID, SearchType)
        {
            if (SearchType == 'C' || SearchType == 'B') {
                // When Serch by Contact Person
                $('#grdSearchbyNeedy').hide();
                $('#grdSearchByContactPerson').show();
                if (data.d.length > 0) {
                    $('#lblNoRecord').hide();
                    $('#grdSearchByContactPerson tbody').empty();
                    for (var i = 0; i < data.d.length; i++) {
                        // Prevent to display non  call data to be display on aspx page
                        NeedyName = '';
                        var NeedyFirstName = '';
                        if (data.d[i].ContactDateTime == '' && IsUpdateCall == 1) {
                        } else {

                            isUpdatetrigger = true;
                            //bind records in table
                            if (SiteID == -1 && data.d[i].ADRCSiteId != '0') {//Commented by KP on 13th April 2020(TaskID:18464), && (data.d[i].ADRCAgencyName != '' || data.d[i].ADRCSiteId == '')) {
                                AgencyLink = "<a  href='javascript:void(0);' class='view_call_history_More' style='color:blue' onmouseover='showHideADRCPopup(" + data.d[i].NeedyPersonID + "," + data.d[i].ADRCSiteId + ",0);' onmouseout='showHideADRCPopup(" + data.d[i].NeedyPersonID + "," + data.d[i].ADRCSiteId + ",1);'>[Agency]</a>" //Modified by KP on 13th April 2020(TaskID:18464), Display tooltip on mouse over
                                HiddenField = "<input type='hidden' id='hdnAgency" + data.d[i].NeedyPersonID + "' value='" + data.d[i].ADRCAgencyName + "'/>";
                            }
                            else {
                                AgencyLink = '';
                                HiddenField = '';
                            }

                            if (data.d[i].NeedyPersonFirstName != 'NA')
                                NeedyFirstName = "<a href='../NeedyPerson.aspx?NdID=" + data.d[i].NeedyPersonID + "&IsNew=0&CPID=" + data.d[i].ContactPersonID + "&CLID=" + data.d[i].CallHistoryID + "&UC=" + IsUpdateCall + "&SiteID=" + data.d[i].ADRCSiteId + "'>" + data.d[i].NeedyPersonFirstName + "</a>";
                            else
                                NeedyFirstName = data.d[i].NeedyPersonFirstName;

                            if (i % 2 == 0) {
                                // set css for alternate row color 
                                $("#grdSearchByContactPerson").append("<tr style='word-break:break-all;word-wrap:break-word' id=" + data.d[i].ContactPersonID + "><td >" + NeedyFirstName + "  " + AgencyLink + " " + HiddenField + "</td><td>" + data.d[i].NeedyPersonLastName + "</td>" +
                                    "<td>" + data.d[i].NeedyPersonDOB + "</td><td>" + data.d[i].NeedyPersonPhonePri + "</td> <td >" + data.d[i].ContactPersonFirstName + "</td> <td >" + data.d[i].ContactPersonLastName + "</td><td>" + data.d[i].ContactPersonPhonePri + "</td><td> <a class='view_call_history_More' style='color:blue'  onclick='ShowAllCalls(" + data.d[i].NeedyPersonID + ");'>View Calls</a></td><td> <a class='view_call_history_More' style='color:blue'  onclick='DeleteContactPerson(" + data.d[i].ContactPersonID + ");'>Delete</a><input type='hidden' id='hdnCDName" + data.d[i].ContactPersonID + "' value='" + data.d[i].ContactPersonFirstName + ' ' + data.d[i].ContactPersonLastName + "'/> </td></tr>");
                            }
                            else {

                                $("#grdSearchByContactPerson").append("<tr  class='gridview_alternaterow' style='word-break:break-all;word-wrap:break-word' id=" + data.d[i].ContactPersonID + "><td >" + NeedyFirstName + "  " + AgencyLink + " " + HiddenField + "</td><td>" + data.d[i].NeedyPersonLastName + "</td>" +
                                    "<td>" + data.d[i].NeedyPersonDOB + "</td><td>" + data.d[i].NeedyPersonPhonePri + "</td> <td >" + data.d[i].ContactPersonFirstName + "</td> <td >" + data.d[i].ContactPersonLastName + "</td><td>" + data.d[i].ContactPersonPhonePri + "</td><td> <a class='view_call_history_More' style='color:blue'  onclick='ShowAllCalls(" + data.d[i].NeedyPersonID + ");'>View Calls</a></td><td> <a class='view_call_history_More' style='color:blue'  onclick='DeleteContactPerson(" + data.d[i].ContactPersonID + ");'>Delete</a><input type='hidden' id='hdnCDName" + data.d[i].ContactPersonID + "' value='" + data.d[i].ContactPersonFirstName + ' ' + data.d[i].ContactPersonLastName  + "'/> </td></tr>");
                            }
                        }
                    }
                    if (isUpdatetrigger == true)
                        $('.tablesorter').trigger('update');
                    else {
                        $('#grdSearchByContactPerson').hide();

                        $('#lblNoRecord').show();
                    }
                }
                else {
                    // if records not found than display message of record not found.
                    $('#grdSearchByContactPerson').hide();
                    $('#lblNoRecord').show();
                }
            }

            else {
                // when search for needy person

                $('#grdSearchbyNeedy').show();
                $('#grdSearchByContactPerson').hide();


                if (data.d.length > 0) {
                    $('#grdSearchbyNeedy tbody').empty();
                    $('#lblNoRecord').hide();
                    for (var i = 0; i < data.d.length; i++) {
                        // Prevent to display non  call data to be display on aspx page
                        NeedyName = '';
                        if (data.d[i].ContactDateTime == '' && IsUpdateCall == 1) {
                        }
                        else {

                            isUpdatetrigger = true;
                            //bind records in table
                            if (SiteID == -1 && data.d[i].ADRCSiteId != '0') {//Commented by KP on 13th April 2020(TaskID:18464), && (data.d[i].ADRCAgencyName != '' || data.d[i].ADRCSiteId == '')) {
                                AgencyLink = "&nbsp;<a  href='javascript:void(0);' class='view_call_history_More' style='color:blue' onmouseover='showHideADRCPopup(" + data.d[i].NeedyPersonID + "," + data.d[i].ADRCSiteId + ",0);' onmouseout='showHideADRCPopup(" + data.d[i].NeedyPersonID + "," + data.d[i].ADRCSiteId + ",1);' >[Agency]</a> "
                                HiddenField = "&nbsp;<input type='hidden' id='hdnAgency" + data.d[i].NeedyPersonID + "' value='" + data.d[i].ADRCAgencyName + "'/>";
                            }
                            else {
                                AgencyLink = '';
                                HiddenField = '';
                            }

                            NeedyFirstName = "<a href='../NeedyPerson.aspx?NdID=" + data.d[i].NeedyPersonID + "&IsNew=0&CPID=" + data.d[i].ContactPersonID + "&CLID=" + data.d[i].CallHistoryID + "&UC=" + IsUpdateCall + "&SiteID=" + data.d[i].ADRCSiteId + "'>" + data.d[i].NeedyPersonFirstName + "</a>";

                            //Added by kuldeep rathore on 20th Aug 2015. SOW-379
                            if (i % 2 == 0) {

                                // set css for alternate row color 
                                $("#grdSearchbyNeedy").append("<tr style='word-break:break-all;word-wrap:break-word' id=" + data.d[i].NeedyPersonID + "><td >" + NeedyFirstName + "  " + AgencyLink + " " + HiddenField + " </td><td>" + data.d[i].NeedyPersonLastName + "</td>" +
                                    "<td>" + data.d[i].NeedyPersonDOB + "</td><td>" + data.d[i].NeedyPersonPhonePri + "</td> <td >" + data.d[i].NeedyPersonPhoneAlt + "</td><td> <a class='view_call_history_More' style='color:blue'  onclick='ShowAllContactPerson(" + data.d[i].NeedyPersonID + ");'>View Contact Person</a></td><td> <a class='view_call_history_More' style='color:blue'  onclick='ShowAllCalls(" + data.d[i].NeedyPersonID + ");'>View Calls</a></td><td> <a class='view_call_history_More' style='color:blue'  onclick='DeleteNeedyPerson(" + data.d[i].NeedyPersonID + ");'>Delete</a><input type='hidden' id='hdnNDName" + data.d[i].NeedyPersonID + "' value='" + data.d[i].NeedyPersonFirstName + "'/></td></tr>");

                                //                                    
                            }
                            else {
                                // set css for alternate row color 
                                $("#grdSearchbyNeedy").append("<tr  class='gridview_alternaterow' style='word-break:break-all;word-wrap:break-word' id=" + data.d[i].NeedyPersonID + "><td >" + NeedyFirstName + "  " + AgencyLink + " " + HiddenField + " </td><td>" + data.d[i].NeedyPersonLastName + "</td>" +
                                    "<td>" + data.d[i].NeedyPersonDOB + "</td><td>" + data.d[i].NeedyPersonPhonePri + "</td> <td >" + data.d[i].NeedyPersonPhoneAlt + "</td><td> <a class='view_call_history_More' style='color:blue'  onclick='ShowAllContactPerson(" + data.d[i].NeedyPersonID + ");'>View Contact Person</a></td><td> <a class='view_call_history_More' style='color:blue'  onclick='ShowAllCalls(" + data.d[i].NeedyPersonID + ");'>View Calls</a></td><td> <a class='view_call_history_More' style='color:blue'  onclick='DeleteNeedyPerson(" + data.d[i].NeedyPersonID + ");'>Delete</a><input type='hidden' id='hdnNDName" + data.d[i].NeedyPersonID + "' value='" + data.d[i].NeedyPersonFirstName + "'/></td></tr>");


                            }
                        }
                    }
                    if (isUpdatetrigger == true)
                        $('.tablesorter').trigger('update');
                    else {
                        $('#grdSearchbyNeedy').hide();

                        $('#lblNoRecord').show();
                    }
                }
                else {
                    // if records not found than display message of record not found.
                    $('#grdSearchbyNeedy').hide();
                    $('#lblNoRecord').show();
                }
            }

        }

		//show all call of person needing assistance
		function ShowAllCalls(needyid) {

			$.ajax({
				type: "POST",
                url: "AdminNeedyPersonSearch.aspx/GetCallHistory",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
				data: "{'NeedyID':" + needyid + "}",
				contentType: "application/json",
				dataType: "json",
				asyn: false,
				success: function (data) {

					if (data.d.length > 0) {
						$('#lblCallCount').html('Total number of call : ' + data.d.length);
						$('#hdnTotalNoOfCall').val(data.d.length);
						$('#gridHistory').show();
                        if($('#gridHistory thead tr').length == 0){
						    $('#gridHistory thead').remove();
						    $('#gridHistory').append("<thead><tr><%-- Added By Kuldeep Rathore on 20th aug,2015. SOW-379 --%><th style='width:10%; padding:5px 15px 5px 5px'>First Name</th><th style='width:10%; padding:5px 15px 5px 5px'>Last Name</th><%-- Added Section Ends here --%><th style='width:6%; padding:5px 15px 5px 5px'>Email</th><th style='width:14%; padding:5px 15px 5px 5px'>Contact Date/Time</th><th style='width:10%; padding:5px 15px 5px 5px'>Call Duration</th><th style='width:16%; padding:5px 15px 5px 5px'>Services Requested</th><th style='width:10%; padding:5px 15px 5px 5px;'>User Name</th><th style='width:7%; padding:5px 15px 5px 5px'>ADRC</th><th style='width:8%; padding:5px 15px 5px 5px'>Info Only</th><th style='width:7%; padding:5px 15px 5px 5px'></th></tr></thead><tbody><tr><td colspan='9'></td></tr></tbody>");
						    //$('#gridHistory').tablesorter();
                        }
						$("#gridHistory").tablesorter({
							headers:
							//{
							//    4: { sorter: false },
							//    5: { sorter: false },
							//    sortList: [[0, 1]]
							//}
							{
								7: { sorter: false }
							}

						});
						$('#gridHistory tbody').empty();

						for (var i = 0; i < data.d.length; i++) {
							if (i % 2 == 0) {
								$("#gridHistory").append("<tr  class='gridview_rowstyle' valign='top' id=" + data.d[i].HistoryID + "><td align='left' style='word-break:break-all;word-wrap:break-word' > <a title='Click to view details'  style='color:blue'  class='view_call_history_More' id=" + data.d[i].HistoryID + " onclick='ShowMoreCallHistory(" + data.d[i].HistoryID + "," + data.d[i].NeedyPersonID + ");'> " + data.d[i].FirstName + "</a></td><td>" + data.d[i].LastName + "</td>" +
									"<td align='left'>" + data.d[i].Email + "</td> <td >" + data.d[i].ContactDate + " " + data.d[i].ContactTime + " </td><td>" + data.d[i].CallDuration + "</td><td align='left'>" + data.d[i].ServiceRequested + "</td><td align='left'>" + data.d[i].UserName + "<td align='left'>" + data.d[i].IsADRCYesNo + "</td>" + "<td align='left'>" + (data.d[i].IsInfoOnly == true ? "Yes" : "No") + "</td><td> <a class='view_call_history_More' style='color:blue'  onclick='DeleteCall(" + data.d[i].HistoryID + ")'>Delete</a> </td> </tr>");
							}
							else {
								$("#gridHistory").append("<tr  class='gridview_alternaterow' valign='top' id=" + data.d[i].HistoryID + " ><td align='left' style='word-break:break-all;word-wrap:break-word' > <a title='Click to view details'  style='color:blue'  class='view_call_history_More' id=" + data.d[i].HistoryID + " onclick='ShowMoreCallHistory(" + data.d[i].HistoryID + "," + data.d[i].NeedyPersonID + ");'> " + data.d[i].FirstName + "</a></td><td>" + data.d[i].LastName + "</td>" +
									"<td align='left'>" + data.d[i].Email + "</td><td >" + data.d[i].ContactDate + " " + data.d[i].ContactTime + "</td><td>" + data.d[i].CallDuration + "</td><td align='left'>" + data.d[i].ServiceRequested + "</td><td align='left'>" + data.d[i].UserName + "<td align='left'>" + data.d[i].IsADRCYesNo + "</td>" + "<td align='left'>" + (data.d[i].IsInfoOnly == true ? "Yes" : "No") + "</td><td>  <a class='view_call_history_More' style='color:blue'  onclick='DeleteCall(" + data.d[i].HistoryID + ")'>Delete</a> </td></tr>");
							}
						}
						$('.tablesorter').trigger('update');
					}
					else {
						$('#gridHistory').hide();
						$('#lblCallCount').html('No record found.');
					}

				}
			});
			ShowHideCallHistoryPopup();
		}





		// Created By: SM
		// Date:07/03/2013
		//Purpose: Show/Hide Needy person popup  
		function ShowHideCallHistoryPopup() {

			var showHideDiv = document.getElementById("<%=showHideDiv2.ClientID %>");
			var divPopUpContent = document.getElementById("<%=divPopUpContent2.ClientID %>");
			var divpnlContact = document.getElementById("<%=divpnlContact2.ClientID %>");
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


				SetPopupOpenPosition(divpnlContact);
			}
		}
		// Created By: SM
		// Date:07/03/2013
		//Purpose: Show/Hide Needy person popup  
		function ShowHideCPPopup() {
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
				$('#lblNoContactPersonPopup').html('');


			}
			else {
				showHideDiv.className = "main_popup_moreHistory ";
				divPopUpContent.className = "popup_moreHistory ";


				divpnlContact.style.display = "block";
				btnClose.style.display = "block";
				divpopupHeading.style.display = "block";
				$('#lblNoContactPersonPopup').html('No Contact person is associated with this person needing assistance.');
				SetPopupOpenPosition(divpnlContact);

			}
		}
		function DeleteCall(callid) {

            var isYes = confirm('Are you sure you want to delete?\n\nIf you click on OK, then reference table (RequestedService,OptionCounselling, ReferringAgency etc.) record(s) will also be deleted.');
			if (isYes) {

				$.ajax({
					type: "POST",
                    url: "AdminNeedyPersonSearch.aspx/DeleteCall",
                    headers: { 'X-Requested-With': 'XMLHttpRequest' },
					data: "{'CallId':" + callid + "}",
					contentType: "application/json",
					dataType: "json",
					asyn: false,
					success: function (data) {
						if (data.d) {

							$('#' + callid).animate({ opacity: 'hide' }, "slow");
							$('#' + callid).fadeOut("slow");

							var RecordCount = parseInt($('#hdnTotalNoOfCall').val()) - 1;


							$('#lblCallCount').html('Total number of call : ' + RecordCount);
							$('#hdnTotalNoOfCall').val(RecordCount)
						}
					}

				});

			}

		}

		function DeleteContactPerson(ContactPersonId) {

			if (ContactPersonId == 0) {
				alert('No contact person found.');
				return false;
			}


			var confirmMgs = 'Are you sure you want to delete this contact person [' + $('#hdnCDName' + ContactPersonId).val() + ']?';
			var isYes = confirm(confirmMgs);

			if (isYes) {

				$.ajax({
					type: "POST",
                    url: "AdminNeedyPersonSearch.aspx/DeleteContactPerson",
                    headers: { 'X-Requested-With': 'XMLHttpRequest' },
					data: "{'ContactPersonId':" + ContactPersonId + "}",
					contentType: "application/json",
					dataType: "json",
					asyn: false,
					success: function (data) {
						if (data.d) {

							$('#' + ContactPersonId).animate({ opacity: 'hide' }, "slow");
							$('#' + ContactPersonId).fadeOut("slow");
						}
					}

				});

			}

		}

		function DeleteNeedyPerson(NeedyPersonID) {

			if (NeedyPersonID == 0) {
				alert('Person Needing Assistance is not found.');
				return false;
			}



			var confirmMgs = 'All contact person and call information associated with this  person needing assistance [' + $('#hdnNDName' + NeedyPersonID).val() + '] also will be deleted. Are you sure you want to delete?';
			var isYes = confirm(confirmMgs);
			if (isYes) {

				$.ajax({
					type: "POST",
                    url: "AdminNeedyPersonSearch.aspx/DeleteNeedyPerson",
                    headers: { 'X-Requested-With': 'XMLHttpRequest' },
					data: "{'NeedyPersonId':" + NeedyPersonID + "}",
					contentType: "application/json",
					dataType: "json",
					asyn: false,
					success: function (data) {
						if (data.d) {

							$('#' + NeedyPersonID).animate({ opacity: 'hide' }, "slow");
							$('#' + NeedyPersonID).fadeOut("slow");
						}
					}

				});

			}
		}

		function ShowAllContactPerson(NeedyPersonID) {

			$('#lblNoContactPersonPopup').html('');
			$.ajax({
				type: "POST",
                url: "AdminNeedyPersonSearch.aspx/GetContactPersonByNeedyID",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
				data: "{'NeedyID':" + NeedyPersonID + "}",
				contentType: "application/json",
				dataType: "json",
				asyn: false,
				success: function (data) {
					// When Serch by Contact Person



					if (data.d.length > 0) {

						$('#grdCPPopUp').show();
						$('#grdCPPopUp tbody').empty();
						$('#lblNoContactPersonPopup').hide();

						for (var i = 0; i < data.d.length; i++) {
							// Prevent to display non  call data to be display on aspx page
							if (data.d[i].ContactDateTime == '' && IsUpdateCall == 1) {
							} else {

								isUpdatetrigger = true;
								//bind records in table
								if (i % 2 == 0) {
									// set css for alternate row color 
									$("#grdCPPopUp").append("<tr style='word-break:break-all;word-wrap:break-word' id=" + data.d[i].ContactPersonID + ">" +
                                        " <td >" + data.d[i].ContactPersonFirstName + "</td><td>" + data.d[i].ContactPersonLastName + "</td><td>" + data.d[i].ContactPersonPhonePri + "</td><td>" + data.d[i].ContactPersonPhoneAlt + "</td><td> <a class='view_call_history_More' style='color:blue'  onclick='ShowAllCPCalls(" + data.d[i].ContactPersonID + "," + data.d[i].NeedyPersonID + ");'>View Call</a></td><td> <a class='view_call_history_More' style='color:blue'  onclick='DeleteContactPerson(" + data.d[i].ContactPersonID + ");'>Delete</a><input type='hidden' id='hdnCDName" + data.d[i].ContactPersonID + "' value='" + data.d[i].ContactPersonFirstName + ' ' + data.d[i].ContactPersonLastName  + "'/></td></tr>");
								}
								else {
									$("#grdCPPopUp").append("<tr  class='gridview_alternaterow' style='word-break:break-all;word-wrap:break-word' id=" + data.d[i].ContactPersonID + ">" +
                                        " <td >" + data.d[i].ContactPersonFirstName + "</td><td >" + data.d[i].ContactPersonLastName + "</td><td>" + data.d[i].ContactPersonPhonePri + "</td><td>" + data.d[i].ContactPersonPhoneAlt + "</td><td> <a class='view_call_history_More' style='color:blue'  onclick='ShowAllCPCalls(" + data.d[i].ContactPersonID + "," + data.d[i].NeedyPersonID + ");'>View Call</a></td><td> <a class='view_call_history_More' style='color:blue'  onclick='DeleteContactPerson(" + data.d[i].ContactPersonID + ");'>Delete</a><input type='hidden' id='hdnCDName" + data.d[i].ContactPersonID + "' value='" + data.d[i].ContactPersonFirstName + ' ' + data.d[i].ContactPersonLastName  + "'/></td></tr>");

								}
							}
						}
						if (isUpdatetrigger == true)
							$('.tablesorter').trigger('update');
						else {
							$('#grdCPPopUp').hide();

							$('#lblNoContactPersonPopup').show();
						}
					}
					else {
						// if records not found than display message of record not found.
						$('#grdCPPopUp').hide();
						$('#lblNoContactPersonPopup').show();
					}


				}
			});


			ShowHideCPPopup();
		}

		//Show all call with respect to Contact Person
		function ShowAllCPCalls(ContactPersonID, NeedyPersonID) {

			$.ajax({
				type: "POST",
                url: "AdminNeedyPersonSearch.aspx/GetContactPersonCallHistory",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
				data: "{'ContactPersonID':" + ContactPersonID + ",'NeedyPersonID':" + NeedyPersonID + "}",
				contentType: "application/json",
				dataType: "json",
				asyn: false,
				success: function (data) {

					if (data.d.length > 0) {
						$('#lblCallCount').html('Total number of call : ' + data.d.length);
						$('#gridHistory').show();
                        if($('#gridHistory thead tr').length == 0){
						    $('#gridHistory thead').remove();
						    $('#gridHistory').append("<thead><tr><%-- Added By Kuldeep Rathore on 20th aug,2015. SOW-379 --%><th style='width:10%; padding:5px 15px 5px 5px'>First Name</th><th style='width:10%; padding:5px 15px 5px 5px'>Last Name</th><%-- Added Section Ends here --%><th style='width:6%; padding:5px 15px 5px 5px'>Email</th><th style='width:14%; padding:5px 15px 5px 5px'>Contact Date/Time</th><th style='width:10%; padding:5px 15px 5px 5px'>Call Duration</th><th style='width:16%; padding:5px 15px 5px 5px'>Services Requested</th><th style='width:10%; padding:5px 15px 5px 5px;'>User Name</th><th style='width:7%; padding:5px 15px 5px 5px'>ADRC</th><th style='width:8%; padding:5px 15px 5px 5px'>Info Only</th><th style='width:7%; padding:5px 15px 5px 5px'></th></tr></thead><tbody><tr><td colspan='9'></td></tr></tbody>");
						    //$('#gridHistory').tablesorter();
                        }
						$("#gridHistory").tablesorter({
							headers:
							//{
							//    4: { sorter: false },
							//    5: { sorter: false },
							//    sortList: [[0, 1]]
							//}
							{
								7: { sorter: false }
							}

						});
						$('#gridHistory tbody').empty();

						for (var i = 0; i < data.d.length; i++) {

							if (i % 2 == 0) {
								$("#gridHistory").append("<tr  class='gridview_rowstyle' valign='top' id=" + data.d[i].HistoryID + "><td align='left' style='word-break:break-all;word-wrap:break-word' > <a title='Click to view details'  style='color:blue'  class='view_call_history_More' id=" + data.d[i].HistoryID + " onclick='ShowMoreCallHistory(" + data.d[i].HistoryID + "," + data.d[i].NeedyPersonID + ");'> " + data.d[i].FirstName + "</a></td><td>" + data.d[i].LastName + "</td>" +
									"<td align='left'>" + data.d[i].Email + "</td> <td >" + data.d[i].ContactDate + " " + data.d[i].ContactTime + " </td><td>" + data.d[i].CallDuration + "</td><td align='left'>" + data.d[i].ServiceRequested + "</td><td align='left'>" + data.d[i].UserName + "<td align='left'>" + data.d[i].IsADRCYesNo + "</td>" + "<td align='left'>" + (data.d[i].IsInfoOnly == true ? "Yes" : "No") + "</td><td>  <a class='view_call_history_More' style='color:blue'  onclick='DeleteCall(" + data.d[i].HistoryID + ")'>Delete</a> </td> </tr>");
							}
							else {
								$("#gridHistory").append("<tr  class='gridview_alternaterow' valign='top' id=" + data.d[i].HistoryID + " ><td align='left' style='word-break:break-all;word-wrap:break-word' > <a title='Click to view details'  style='color:blue'  class='view_call_history_More' id=" + data.d[i].HistoryID + " onclick='ShowMoreCallHistory(" + data.d[i].HistoryID + "," + data.d[i].NeedyPersonID + ");'> " + data.d[i].FirstName + "</a></td><td>" + data.d[i].LastName + "</td>" +
									"<td align='left'>" + data.d[i].Email + "</td><td >" + data.d[i].ContactDate + " " + data.d[i].ContactTime + "</td><td>" + data.d[i].CallDuration + "</td><td align='left'>" + data.d[i].ServiceRequested + "</td><td align='left'>" + data.d[i].UserName + "<td align='left'>" + data.d[i].IsADRCYesNo + "</td>" + "<td align='left'>" + (data.d[i].IsInfoOnly == true ? "Yes" : "No") + "</td><td>  <a class='view_call_history_More' style='color:blue'  onclick='DeleteCall(" + data.d[i].HistoryID + ")'>Delete</a> </td></tr>");
							}
						}
						$('.tablesorter').trigger('update');
					}
					else {
						$('#gridHistory').hide();
						$('#lblCallCount').html('No record found.');
					}

				}
			});
			ShowHideCallHistoryPopup();
		}

		function ShowMoreCallHistory(callid, NeedyID) {

			$.ajax({
				type: "POST",
                url: "AdminNeedyPersonSearch.aspx/GetCallHistoryDetails",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
				data: "{'HistoryID':" + callid + ",'NeedyID':" + NeedyID + "}",
				contentType: "application/json",
				dataType: "json",
				success: function (data) {
					if (data.d.length > 0) {
						//                          $('#grdHistoryDetails').tablesorter();
						$('#grdHistoryDetails tbody').remove();

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


								"<tr><td valign='top'><span class='call_hist_lable'>First Name</span></td>" +
								"<td valign='top' style='word-break:break-all;word-wrap:break-word' >" + data.d[i].FirstName + "</td>" +
								//Added by Kuldeep Rathore on 21 Aug, 2015. SOW-379
								"<td valign='top'><span class='call_hist_lable'>Last Name</span></td>" +
								"<td valign='top' style='word-break:break-all;word-wrap:break-word' >" + data.d[i].LastName + "</td>" +
								"<td valign='top'><span class='call_hist_lable'>Relationship</span></td>" +
								"<td valign='top' width='10%' style='word-break:break-all;word-wrap:break-word' >" + data.d[i].Relationship + "</td>" +

								"<td valign='top'><span class='call_hist_lable'>Contact Date/Time</span></td>" +
								"<td valign='top'>" + data.d[i].ContactDate + " " + data.d[i].ContactTime + "</td></tr>" +
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
								"<td valign='top'colspan='3'>" + data.d[i].ServiceNeedsMetYesNo + "</td> </tr>" +
                                								
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

		function ShowHideMoreCallhistory() {
			var divpnlContact = document.getElementById("<%=divpnlContactCallDetails.ClientID %>");
			var showHideDiv = document.getElementById("<%=showHideDivCallDetails.ClientID %>");
			var divPopUpContent = document.getElementById("<%=divPopUpContentCallDetails.ClientID %>");
			var divpopupHeading = document.getElementById("<%=divpopupHeadingCallDetails.ClientID %>");
			var btnClose = document.getElementById("<%=btnCloseCallDetails.ClientID %>");

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



        function showHideADRCPopup(hdnFieldID, ADRCSiteID, isout) {
			var divpnlContact = document.getElementById("<%=divAgency.ClientID %>");
			if (isout == 1)
				divpnlContact.style.display = "none";
			else {
				var id = '#hdnAgency' + hdnFieldID;
				var agencyname = $(id).val();

				//if (ADRCSiteID == '0')
                //    $('#lblADRCAgencyName').html('Agency Name :  Office of Service to Aging');
                //else
                $('#lblADRCAgencyName').html('Agency Name : ' + (agencyname == '' ? 'NA' :  agencyname));//Modified by KP on 13th April 2020(TaskID:18464), Display NA as agency name when agency is blank.

				divpnlContact.style.display = "block";
				SetPopupOpenPosition(divpnlContact);
			}

		}
        

        //Created By: KP
        //Date: 27th Dec 2019(SOW-577)
        //purpose: Get needy data as based on Smart Search process.
        function GetSmartSearchData() {

            $('#Progressbar').show();

            var txtSmartSearch = ''
            if ($('#txtSmartSearch').val() != watermarkSmartSearch)
                txtSmartSearch = $('#txtSmartSearch').val().trim();

            var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            var IsUpdateCall = url[0].split('=')[1];
            var SiteID = $("#<%=ddlAAACILName.ClientID %> option:selected").val();

            var obj = {};
            obj.SmartSearch = txtSmartSearch;
            obj.IsUpdateCall = IsUpdateCall;
            obj.AAASiteID = SiteID;

            // call method using jquery-json and bind records
            $.ajax({
                type: "POST",
                url: "AdminNeedyPersonSearch.aspx/GetSmartSearchNeeding",
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
                data: JSON.stringify(obj),
                contentType: "application/json",
                dataType: "json",
                success: function (data) {
                    if (IsUpdateCall == 0)
                        BindNewCall(data, IsUpdateCall, SiteID, 'B');
                    else
                        BindUpdateCall(data, IsUpdateCall, SiteID);
                },
                complete: function () {
                    $('#Progressbar').hide();
                }
            });

            $('#txtSmartSearch').focus();
        }


    </script>

	<style>
		.form_block_popup, .form_block_popup_CPPopup {
			left: 10px !important;
		}
	</style>


	<div class="clear_01">
	</div>
      <div id="divoverlaysuccess" class="lightbox-overlay" style="display: none"></div>
        <div id="divalert" class="light-box" style="display: none">
            <div id="divheader" class="light-box-heading">
                <span id="spnImg"></span>
                <span id="spnHeader"></span>
            </div>
            <div class="light-box-body">
                <span id="spnMessage" class="lightbox-msg-style" style="text-align: left">
                    <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label><br />
                </span>
                <div style="text-align: center; padding: 10px 10px 0">
                    <input id="btnClosePopup" onclick="HideAlertBox()" class="btn_Confirm btn-successalert gradient" style="width: 100px !important; padding: 1px 9px" value="OK" type="button" />
                </div>
            </div>
        </div>
    
    <div class="clear_01"></div>
	<div class="search_heading">
		Search Person Needing Assistance
	</div>
	<div class="main_search">
		<table width="80%" border="0" cellpadding="0" cellspacing="0" align="center" style="margin: 0 auto;">
			<tr>
		        <td align="center">Agency :
                    <asp:DropDownList ID="ddlAAACILName" runat="server">
			        </asp:DropDownList>
		        </td>
			</tr>   
			<tr>
				<td>&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
			<tr id="rwUpdateCall">
				<td id="colUpdateCall" align="center" style="border: 1px">
					<label id="lblUpdateMessage" style="color: White">
					</label>
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
                                                    class="search_name" maxlength="100" style="width: 85%;"  autocomplete="off"/>
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
										                <%-- Commented By Kuldeep Rathore on 20th Aug, 2015.  SOW-379 --%>
										                <%--<span class="search_label">Name:</span>--%>
										                <%-- Removed onkeyup="javascript:ClearValues('N');BindGridView('N');" on 27th May, 2015. SOW-362. As called from page load to delay in search.--%>
										                <%-- <input type="text" id="txtNeedyName"
                                                            onblur="SetFocus(this);" onfocus="SetFocus(this);" class="search_name" maxlength="50"
                                                            style="width: 250px;" />--%>
										                <%-- Added By Kuldeep Rathore on 20th aug,2015. SOW-379 --%>
										                <span class="search_label">First Name:</span>
										                <%-- Removed onkeyup="javascript:ClearValues('N');BindGridView('N');" on 27th May, 2015. SOW-362. As called from page load to delay in search.--%>
										                <input type="text" id="txtNeedyFirstName"
											                onblur="SetFocus(this);" onfocus="SetFocus(this);" class="search_name" maxlength="50"
											                style="width: 150px;" autocomplete="off"/>
									                </td>
									                <%-- Added By Kuldeep Rathore on 20th aug,2015. SOW-379 --%>
									                <td align="center">
										                <span class="second_opt">And/Or</span>
									                </td>
									                <%-- Added By Kuldeep Rathore on 20th aug,2015. SOW-379 --%>
									                <td align="left">
										                <span class="search_label">Last Name:</span>
										                <%-- Removed onkeyup="javascript:ClearValues('N');BindGridView('N');" on 27th May, 2015. SOW-362. As called from page load to delay in search.--%>
										                <input type="text" id="txtNeedyLastName"
											                onblur="SetFocus(this);" onfocus="SetFocus(this);" class="search_name" maxlength="50"
											                style="width: 150px;" autocomplete="off"/>
									                </td>
									                <td align="center">
										                <span class="second_opt">And/Or</span>
									                </td>
									                <td align="right">
										                <span class="search_label">Phone:</span>
										                <%-- Removed onkeyup="javascript:ClearValues('N');BindGridView('N');" on 27th May, 2015. SOW-362. As called from page load to delay in search.--%>
										                <input type="text" id="txtNeedyPhone"
											                onblur="SetFocus(this);" onfocus="SetFocus(this);" class="search_phone" maxlength="15" autocomplete="off"/>
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
										                <%--<span class="search_label">Name:</span>--%>
										                <%-- Removed onkeyup="javascript:ClearValues('C');BindGridView('C');" on 27th May, 2015. SOW-362. As called from page load to delay in search. --%>
										                <%--   <input type="text" id="txtContactPerson" 
                                                            onblur="SetFocus(this);" onfocus="SetFocus(this);" class="search_name" maxlength="50"
                                                            style="width: 250px;" />--%>
										                <%-- Added By Kuldeep Rathore on 20th aug,2015. SOW-379 --%>
										                <span class="search_label">First Name:</span>
										                <%-- Removed onkeyup="javascript:ClearValues('C');BindGridView('C');" on 27th May, 2015. SOW-362. As called from page load to delay in search. --%>
										                <input type="text" id="txtContactPersonFirstName"
											                onblur="SetFocus(this);" onfocus="SetFocus(this);" class="search_name" maxlength="50"
											                style="width: 150px;" autocomplete="off"/>
									                </td>
									                <%-- Added By Kuldeep Rathore on 20th aug,2015. SOW-379 --%>
									                <td align="center">
										                <span class="second_opt">And/Or</span>
									                </td>
									                <%-- Added By Kuldeep Rathore on 20th aug,2015. SOW-379 --%>
									                <td align="left">
										                <span class="search_label">Last Name:</span>
										                <%-- Removed onkeyup="javascript:ClearValues('C');BindGridView('C');" on 27th May, 2015. SOW-362. As called from page load to delay in search. --%>
										                <input type="text" id="txtContactPersonLastName"
											                onblur="SetFocus(this);" onfocus="SetFocus(this);" class="search_name" maxlength="50"
											                style="width: 150px;" autocomplete="off"/>
									                </td>
									                <td align="center">
										                <span class="second_opt">And/Or</span>
									                </td>
									                <td align="right">
										                <span class="search_label">Phone:</span>
										                <%-- Removed onkeyup="javascript:ClearValues('C');BindGridView('C');" on 27th May, 2015. SOW-362. As called from page load to delay in search. --%>
										                <input type="text" id="txtContactPhone"
											                onblur="SetFocus(this);" onfocus="SetFocus(this);" class="search_phone" maxlength="15" autocomplete="off"/>
									                </td>
									                <td width="25px"></td>
								                </tr>
								                <tr>
									                <td align="right" colspan="6">
										                <span style="color: blue;">*&nbsp;Search Person Needing Assistance having no name by "NA"</span>&nbsp;&nbsp;&nbsp;
										                <input id="btnSearch" type="button" name="btnShowAll" value="Search" class="btn_styleSearch"
											                onclick="javascript: BindGridView('B', 'Click');" />
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
			<label id="lblNoRecord" style="display: none">
				No Record Found.</label>
		</div>
		<table border="1" cellpadding="0" cellspacing="0" class="sub_hearder tablesorter"
			id="grdSearchByContactPerson" width="98%" style="margin: 0px auto; border-collapse: collapse; display: none;">
			<thead id="tableHead">
				<tr class="gridview_main_header">
					<td colspan="4" align="center">Person Needing Assistance
					</td>
					<td colspan="5" align="center">Contact Person
					</td>
				</tr>
				<tr id="rwSecond">
					<%--class="sub_hearder"--%>
					<%-- Added By Kuldeep Rathore on 20th aug,2015. SOW-379 --%>
					<th width="14%">First Name
					</th>
					<th width="10%">Last Name
					</th>
					<%-- Added Section Ends here --%>
					<th width="8%">DOB
					</th>
					<th width="12%">Phone-Primary
					</th>
					<%-- Added By Kuldeep Rathore on 20th aug,2015. SOW-379 --%>
					<th width="12%">First Name
					</th>
					<th width="10%">Last Name
					</th>
					<%-- Added Section Ends here --%>
					<th width="12%">Phone-Primary
					</th>
					<th width="8%">&nbsp; &nbsp;
					</th>
					<th width="7%">&nbsp; &nbsp;
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="10"></td>
				</tr>
			</tbody>
		</table>
		<table border="1" cellpadding="0" cellspacing="0" class="sub_hearder tablesorter"
			id="grdSearchbyNeedy" width="98%" style="margin: 0px auto; border-collapse: collapse; display: none;">
			<thead id="Thead1">
				<tr class="gridview_main_header">
					<td colspan="8" align="center">Person Needing Assistance
					</td>
				</tr>
				<tr id="Tr1">
					<%--class="sub_hearder"--%>
					<%-- Added By Kuldeep Rathore on 20th aug,2015. SOW-379 --%>
					<th width="12%">First Name
					</th>
					<th width="12%">Last Name
					</th>
					<%-- Added Section Ends here --%>
					<th width="9%">DOB
					</th>
					<th width="11%">Phone-Primary
					</th>
					<th width="11%">Phone-Alt
					</th>
					<th width="12%"></th>
					<th width="7%">&nbsp; &nbsp;
					</th>
					<th width="6%">&nbsp; &nbsp;
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="8"></td>
				</tr>
			</tbody>
		</table>
		<table border="1" cellpadding="0" cellspacing="0" class="sub_hearder tablesorter"
			id="grvNeedy" width="98%" style="margin: 0px auto; border-collapse: collapse; display: none;">
			<thead id="Thead3">
				<tr class="gridview_main_header">
					<td colspan="7" align="center">Person Needing Assistance
					</td>
					<td colspan="4" align="center">
						<label id="lblGridContactPersonHeader" style="background-color: #1a3895; color: #fff; text-align: center; font-size: 11px; font-weight: bold">
						</label>
					</td>
				</tr>
				<tr id="Tr3">
					<%--class="sub_hearder"--%>
					<%-- Added By Kuldeep Rathore on 20th aug,2015. SOW-379 --%>
					<th width="11%">First Name
					</th>
					<th width="8%">Last Name
					</th>
					<%-- Added Section Ends here --%>
					<th width="7%">DOB
					</th>
					<th width="10%">Phone-Primary
					</th>
					<th width="9%">Phone-Alt
					</th>
					<th width="13%">
						<!-- Alter Column Name By Kuldeep Rathore on 19th May, 2015 -->
						Contact Date & Time
                        <!--Last Call On -->
					</th>
					<th width="8%">
						<!-- Added By Kuldeep Rathore on 19th May, 2015 -->
						User Name
					</th>
					<%-- Added By Kuldeep Rathore on 20th aug,2015. SOW-379 --%>
					<th width="9%">First Name
					</th>
					<th width="8%">Last Name
					</th>
					<%-- Added Section Ends Here --%>
					<th width="10%">Phone-Primary
					</th>
					<th>Phone-Alt
					</th>

				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="10"></td>
				</tr>
			</tbody>
		</table>
	</div>
	<%-- call list --%>
	<div id="showHideDiv2" runat="server" style="z-index: 99999;">
		<div id="divPopUpContent2" runat="server">
			<div class="form_block_popup ui-widget-content" id="divpnlContact2" runat="server" style="padding: 0 !important;">
				<div id="divpopupHeading2" style="display: none; width: 100%;" class="popup_form_heading_history"
					runat="server">
					Call Details
                    <input id="btnClose2" type="button" value="" runat="server" class="close_popmore"
						onclick="return ShowHideCallHistoryPopup();" style="display: none; right: 5px;" />
				</div>
				<div style="padding: 0; margin: 0 0 0 0; min-height: 100px; max-height: 200px; width: 100%;"
					class="grid_scroll_SearchPop">
					<div align="left">
						<label id="lblCallCount">
						</label>
						<input type="hidden" id="hdnTotalNoOfCall" value="0" />
					</div>

					<table border="1" cellpadding="0" cellspacing="0" class="gridview tablesorter" id="gridHistory"
						width="99.8%" style="margin: 1px auto; border-collapse: collapse; border-style: solid">
						<%-- Commented by SA on 1st Sep, 2015. SOW as Appended by jquery in ajax method. --%>
						<%--<thead>
                            <tr>
                               
                                <th width="10%">First Name
                                </th>
                                <th width="9%">Last Name
                                </th>
                                
                                <th width="14%">Email
                                </th>
                                <th width="16%">Contact Date/Time
                                </th>
                                <th width="12%">Call Duration
                                </th>
                                <th>Services Requested
                                </th>
                                <th>User Name
                                </th>
                                <th width="5%"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td colspan="9"></td>
                            </tr>
                        </tbody>--%>
					</table>
				</div>
			</div>
		</div>
	</div>
	<%-- More Call details--%>
	<div id="showHideDivCallDetails" runat="server" style="z-index: 99999;">
		<div id="divPopUpContentCallDetails" runat="server">
			<div class="form_block_popup" id="divpnlContactCallDetails" runat="server" style="padding: 0 !important;">
				<div id="divpopupHeadingCallDetails" style="display: none; margin: 0 auto; width: 100%;"
					class="popup_form_heading_history" runat="server">
					Call History Details
                    <input id="btnCloseCallDetails" type="button" value="" runat="server" class="close_popmore"
						onclick="return ShowHideMoreCallhistory();" style="display: none; right: 5px;" />
				</div>
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
	<%-- cp- Contact Person--%>
	<div id="showHideDivCP" runat="server" style="z-index: 9999;">
		<div id="divPopUpContentCP" runat="server">
			<div class="form_block_popup_CPPopup" id="divpnlContactCP" runat="server">
				<div id="divpopupHeadingCP" style="display: none;" class="popup_form_heading_history_CPPopup"
					runat="server">
					Contact Person
                    <input id="btnCloseCP" type="button" value="" runat="server" class="close_popmore"
						onclick="return ShowHideCPPopup();" style="display: none; right: 10px;" />
				</div>
				<div style="padding: 0; margin: 0 0 0 0; min-height: 100px; max-height: 200px; width: 100%;"
					class="grid_scroll_SearchPop">
					<table border="1" cellpadding="0" cellspacing="0" class="sub_hearder tablesorter"
						id="grdCPPopUp" width="99%" style="margin: 0px auto; border-collapse: collapse;">
						<thead id="Thead2">
							<tr id="Tr2">
								<%--class="sub_hearder"--%>
								<%-- Added By Kuldeep Rathore on 20th aug,2015. SOW-379 --%>
								<th width="10%">First Name
								</th>
								<th width="9%">Last Name
								</th>
								<%-- Added Section Ends Here --%>
								<th width="14%">Phone-Primary
								</th>
								<th width="14%">Phone-Alternate
								</th>
								<th width="7%">&nbsp; &nbsp;
								</th>
								<th width="7%">&nbsp; &nbsp;
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td colspan="8"></td>
							</tr>
						</tbody>
					</table>
					<div class="no-found" align="center">
						<label id="lblNoContactPersonPopup">
						</label>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="divAgency" class="hovertooltip" runat="server">
		<label id="lblADRCAgencyName"></label>
	</div>
	<!-- Added By Kuldeep Rathore on 18th May,  2015 -->
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
