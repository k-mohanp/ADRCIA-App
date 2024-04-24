<%@ Page Language="C#" MasterPageFile="~/Admin/Site.master" AutoEventWireup="true" CodeFile="MergePersonNeedyAssistance.aspx.cs" Inherits="Admin_MergePersonNeedyAssistance" %>

<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <style type="text/css">
        .r-wrap label {
            margin-left: 6px;
            margin-right: 15px;
        }

        .aspNetDisabled {
            background: url(../images/button_bg_dis.jpg) no-repeat top left transparent;
            border: 0;
            width: 110px;
            height: 35px;
            padding: 11px 0 14px 0;
            text-align: center;
            font-weight: bold;
            color: black;
            cursor: not-allowed;
            color: #fff;
        }
    </style>
    <div class="search_heading">
        Merge Person Needing Assistance
    </div>
    <div class="main_search" style="padding-bottom: 10px;">
        <table width="80%" border="0" cellpadding="0" cellspacing="0" align="center" style="margin: 0 auto;">
            <tr>
                <td align="center">Agency :

                    <asp:DropDownList ID="ddlAgency" runat="server" OnSelectedIndexChanged="ddlAgency_SelectedIndexChanged" AutoPostBack="true" />
                </td>
            </tr>
            <tr>
                <td>&nbsp;&nbsp;&nbsp;</td>
            </tr>
            <tr>
                <td style="text-align: center; width: 100%">
                    <div style="width: 624px; margin: 0 auto;">
                        <asp:RadioButtonList CssClass="r-wrap" ID="rblSearchBy" runat="Server" RepeatDirection="Horizontal" Style="font-size: 10.5pt;">
                            <asp:ListItem Text="Search By Person Needing Assistance ID" Value="1" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Search By Person Needing Assistance Name" Value="2"></asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                </td>
            </tr>
            <tr>
                <td>&nbsp;&nbsp;&nbsp;</td>
            </tr>
            <tr id="rwUpdateCall">
                <td id="colUpdateCall" align="center" style="border: 1px currentColor; border-image: none; background-color: rgb(26, 138, 216);">
                    <label id="lblUpdateMessage" style="color: White">Search Person Needing Assistance </label>
                </td>
                <td></td>
            </tr>
            <tr id="fsSearchByID" runat="server">
                <td>
                    <fieldset>
                        <legend>Person Needing Assistance</legend>
                        <div align="center">
                            <table align="center" border="0" cellspacing="0" cellpadding="0">
                                <tbody>
                                    <tr>
                                        <td align="left">
                                            <span class="search_label">From Person ID:</span>
                                            <asp:TextBox ID="txtNeedyIdFrom" runat="server" CssClass="search_name watermark Number" Style="width: 150px;" MaxLength="9" autocomplete="off"></asp:TextBox>
                                        </td>

                                        <td align="center">
                                            <span class="second_opt">And</span>
                                        </td>

                                        <td align="left">
                                            <span class="search_label">To Person ID:</span>
                                            <asp:TextBox ID="txtNeedyIdTo" runat="server" CssClass="search_name watermark Number" Style="width: 150px;" MaxLength="9" autocomplete="off"></asp:TextBox>
                                        </td>

                                        <td>&nbsp; 
                                        </td>
                                    </tr>

                                </tbody>
                            </table>
                        </div>
                    </fieldset>
                </td>
                <td></td>
            </tr>

            <tr id="fsSearchByNameFrom" runat="server">
                <td>
                    <fieldset>
                        <legend>From</legend>
                        <div align="center">
                            <table align="center" border="0" cellspacing="0" cellpadding="0">
                                <tbody>
                                    <tr>
                                        <td align="left">
                                            <span class="search_label">First Name:</span>
                                            <asp:TextBox ID="txtFirstNameFrom" runat="server" CssClass="search_name watermark" Style="width: 150px;" MaxLength="50" autocomplete="off"></asp:TextBox>
                                        </td>

                                        <td align="center">
                                            <span class="second_opt">And</span>
                                        </td>

                                        <td align="left">
                                            <span class="search_label">Middle Name:</span>
                                            <asp:TextBox ID="txtMiddleNameFrom" runat="server" CssClass="search_name watermark" Style="width: 150px;" MaxLength="50" autocomplete="off"></asp:TextBox>
                                        </td>
                                        <td align="center">
                                            <span class="second_opt">And</span>
                                        </td>
                                        <td align="left">
                                            <span class="search_label">Last Name:</span>
                                            <asp:TextBox ID="txtLastNameFrom" runat="server" CssClass="search_name watermark" Style="width: 150px;" MaxLength="50" autocomplete="off"></asp:TextBox>
                                        </td>
                                        <td>&nbsp; 
                                        </td>
                                    </tr>

                                </tbody>
                            </table>
                        </div>
                    </fieldset>
                </td>
            </tr>

            <tr id="fsSearchByNameTo" runat="server">
                <td>
                    <fieldset>
                        <legend>To</legend>
                        <div align="center">
                            <table align="center" border="0" cellspacing="0" cellpadding="0">
                                <tbody>
                                    <tr>
                                        <td align="left">
                                            <span class="search_label">First Name:</span>
                                            <asp:TextBox ID="txtFirstNameTo" runat="server" CssClass="search_name watermark" Style="width: 150px;" MaxLength="50" autocomplete="off"></asp:TextBox>
                                        </td>

                                        <td align="center">
                                            <span class="second_opt">And</span>
                                        </td>

                                        <td align="left">
                                            <span class="search_label">Middle Name:</span>
                                            <asp:TextBox ID="txtMiddleNameTo" runat="server" CssClass="search_name watermark" Style="width: 150px;" MaxLength="50" autocomplete="off"></asp:TextBox>
                                        </td>
                                        <td align="center">
                                            <span class="second_opt">And</span>
                                        </td>
                                        <td align="left">
                                            <span class="search_label">Last Name:</span>
                                            <asp:TextBox ID="txtLastNameTo" runat="server" CssClass="search_name watermark" Style="width: 150px;" MaxLength="50" autocomplete="off"></asp:TextBox>
                                        </td>
                                        <td>&nbsp; 
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </fieldset>
                </td>
            </tr>

            <tr>
                <td align="right" colspan="6">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" class="btn_styleSearch" OnClick="btnSearch_Click" OnClientClick="return btnSearchValidate();" />
                </td>
            </tr>

        </table>
    </div>

    <div class="search_result">
        <%--<div class="no-found">
            <label id="lblNoRecord" style="display: none;">
                No Record Found.</label>
        </div>--%>
        <asp:GridView ID="gvNeedyPerson" runat="server" AutoGenerateColumns="false" DataKeyNames="NeedyPersonID" GridLines="Horizontal"
            Style="width: 98%; margin: 0px auto; display: table; border-collapse: collapse;" CssClass="sub_hearder" HeaderStyle-CssClass="Thead1 Tr1"
            RowStyle-CssClass="normal_gray" AlternatingRowStyle-CssClass="alternate_gray" ShowHeaderWhenEmpty="false" EmptyDataText="No record found.">
            <Columns>
                <asp:TemplateField HeaderText="Merge Into">
                    <ItemTemplate>
                        <asp:RadioButton ID="rbMergeInto" runat="server" onclick="MergeIntoChange(this)" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Merge From">
                    <ItemTemplate>
                        <asp:CheckBox ID="cbMergeFrom" runat="server" onclick="MergeFromChange(this)" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Person ID">
                    <ItemTemplate>
                        <a class='view_call_history_More' style='color: blue'
                            onclick='ShowFollowUpNeedyDetails({
                            FirstName: "<%#Eval("FirstName")%>",
                            MiddleName: "<%#Eval("MiddleName")%>",
                            LastName: "<%#Eval("LastName")%>",
                            PhonePrimary: "<%#Eval("PhonePrimary")%>",
                            PhoneAlternate: "<%#Eval("PhoneAlternate")%>",
                            DOB: "<%#Eval("DOB", "{0:MM/dd/yyyy}")%>",
                            Address: "<%#Eval("Address")%>",
                            CityName: "<%#Eval("CityName")%>",
                            State: "<%#Eval("State")%>",
                            Zip: "<%#Eval("Zip")%>",
                            Email: "<%#Eval("Email")%>",
                            Gender: "<%#Eval("Gender")%>",
                            Age: "<%#Eval("Age")%>",
                            MaritalStatus: "<%#Eval("MaritalStatus")%>",
                            LivingArrangement: "<%#Eval("LivingArrangement")%>",
                            VeteranStatus: "<%#Eval("VeteranStatus")%>",
                            Race: "<%#Eval("Race")%>",
                            Ethnicity: "<%#Eval("Ethnicity")%>",
                            IsContactPreferencePhone: "<%#Eval("IsContactPreferencePhone")%>",
                            IsContactPreferenceEmail: "<%#Eval("IsContactPreferenceEmail")%>",
                            IsContactPreferenceSMS: "<%#Eval("IsContactPreferenceSMS")%>",
                            IsContactPreferenceMail: "<%#Eval("IsContactPreferenceMail")%>",
                            })'
                            title="Click to view more person needing assistance"><%#Eval("NeedyPersonID")%></a></a>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Left" />
                </asp:TemplateField>
                <%--<asp:BoundField DataField="NeedyPersonID" HeaderText="Needy Person ID" ItemStyle-HorizontalAlign="Center" />--%>
                <asp:BoundField DataField="FirstName" HeaderText="First Name" ItemStyle-HorizontalAlign="Left" />
                <asp:BoundField DataField="MiddleName" HeaderText="Middle Name" ItemStyle-HorizontalAlign="Left" />
                <asp:BoundField DataField="LastName" HeaderText="Last Name" ItemStyle-HorizontalAlign="Left" />
                <asp:BoundField DataField="DOB" HeaderText="DOB" ItemStyle-HorizontalAlign="Left" DataFormatString="{0:MM/dd/yyyy}" />
                <asp:BoundField DataField="PhonePrimary" HeaderText="Phone-Primary" ItemStyle-HorizontalAlign="Left" />
            </Columns>
        </asp:GridView>
    </div>
    <div style="width: 80%; margin: 0 auto; text-align: center">
        <asp:Button ID="btnMerge" runat="server" Text="Merge" class="btn_style" OnClick="btnMerge_Click" OnClientClick="return btnMergeValidate();" />
    </div>

    <div id="showHideDiv2" runat="server">
        <div id="divPopUpContent2" runat="server">
            <input id="btnClose2" type="button" value="" runat="server" class="close_popmore"
                onclick="return ShowHideNeedyDetailPopup();" style="display: none" />
            <div id="divpopupHeading2" style="display: none; margin: 0 auto; width: 91%;" class="popup_form_heading_history"
                runat="server">
                Person Needing Assistance Details
            </div>
            <div class="form_block_popup" id="divpnlContact2" runat="server" style="padding: 0 !important;">
                <div style="padding: 0; margin: 0 0 0 0; min-height: 150px; max-height: 350px; width: 100%;">
                    <table width="98%" border="1" cellpadding="0" cellspacing="0" class="contact_gridview"
                        id="tblNDPerson" style="border-collapse: collapse;">
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

    <script type="text/javascript">
        $(document).ready(function () {
            $("#<%=rblSearchBy.ClientID%>").change(function () {
                ClearSearchByField();
                ChangeSearchBy();
            });
            ChangeSearchBy();
            NumericOnly();
            document.getElementById("<%=showHideDiv2.ClientID %>").style.display = "none";
            <%--$("#<%=btnMerge.ClientID%>").attr("disabled", "true");--%>
        });

        function ClearSearchByField() {
            $("#MainContent_txtNeedyIdFrom").val('');
            $("#MainContent_txtNeedyIdTo").val('');
            $("#MainContent_txtFirstNameFrom").val('');
            $("#MainContent_txtMiddleNameFrom").val('');
            $("#MainContent_txtLastNameFrom").val('');
            $("#MainContent_txtFirstNameTo").val('');
            $("#MainContent_txtMiddleNameTo").val('');
            $("#MainContent_txtLastNameTo").val('');
        }

        // Added by GK on 25Jun : Show/Hide search filter controls by rblSearchBy
        function ChangeSearchBy() {

            var fsSearchByID = $("#<%=fsSearchByID.ClientID%>");
            var fsSearchByNameFrom = $("#<%=fsSearchByNameFrom.ClientID%>");
            var fsSearchByNameTo = $("#<%=fsSearchByNameTo.ClientID%>");

            if ($("#<%=rblSearchBy.ClientID%> input:checked").val() == "1") {
                fsSearchByID.show();
                fsSearchByNameFrom.hide();
                fsSearchByNameTo.hide();
            }
            else {
                fsSearchByID.hide();
                fsSearchByNameFrom.show();
                fsSearchByNameTo.show();
            }
        }

        function btnSearchValidate() {
            var retVal = true;

            if ($("#MainContent_ddlAgency").val() == "-1") {
                //retVal = false;                
                ShowAlert("Please select an Agency.");
                $("#MainContent_ddlAgency").focus();
                return false;
            }

            var txtNeedyIdFrom = $("#MainContent_txtNeedyIdFrom");
            var txtNeedyIdTo = $("#MainContent_txtNeedyIdTo");

            // Search By Person Needing Assistance ID
            if ($("#MainContent_rblSearchBy").find('input[type=radio]:checked').val() == "1") {
                if (txtNeedyIdFrom.val().trim() == "") {
                    //retVal = false;
                    ShowAlert("Please enter From Person ID.");
                    txtNeedyIdFrom.focus();
                    return false;
                }
                if (txtNeedyIdTo.val().trim() == "") {
                    //retVal = false;
                    ShowAlert("Please enter To Person ID.");
                    txtNeedyIdTo.focus();
                    return false;
                }
            }
            else // Search By Person Needing Assistance Name
            {
                if ($("#MainContent_txtFirstNameFrom").val().trim() == "" &&
                    $("#MainContent_txtMiddleNameFrom").val().trim() == "" &&
                    $("#MainContent_txtLastNameFrom").val().trim() == "" &&
                    $("#MainContent_txtFirstNameTo").val().trim() == "" &&
                    $("#MainContent_txtMiddleNameTo").val().trim() == "" &&
                    $("#MainContent_txtLastNameTo").val().trim() == "") {
                    //retVal = false;
                    ShowAlert("Please enter From and To search area.");
                    $("#MainContent_txtFirstNameFrom").focus();
                    return false;
                }
            }

            return true;
        }


        function MergeFromChange(e) {
            var row = e.parentNode.parentNode;
            var rowIndex = row.rowIndex - 1;

            $("#MainContent_gvNeedyPerson_" + "rbMergeInto_" + rowIndex).prop("checked", false);
        }

        function MergeIntoChange(e) {
            var row = e.parentNode.parentNode;
            var rowIndex = row.rowIndex - 1;

            $("#MainContent_gvNeedyPerson_" + "cbMergeFrom_" + rowIndex).prop("checked", false);

            $('#MainContent_gvNeedyPerson input:radio').prop("checked", false);
            $("#MainContent_gvNeedyPerson_" + "rbMergeInto_" + rowIndex).prop("checked", true);

            var rows = $('#MainContent_gvNeedyPerson tbody tr');
        }

        function NumericOnly() {
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
            }).on('drop', function (e) {
                var $this = $(this);
                setTimeout(function () {
                    $this.val($this.val().replace(/[^0-9]/g, ''));
                }, 5);
            });;
        }

        // Created By GK on 10July18 : Show followup Needy person Details in popup
        function ShowFollowUpNeedyDetails(obj) {
            $('#tblNDPerson tbody').empty();

            var ContactTypePhone = (obj.IsContactPreferencePhone.toLowerCase() == 'true') ? "checked" : "";
            var ContactTypeEmail = (obj.IsContactPreferenceEmail.toLowerCase() == 'true') ? "checked" : "";
            var ContactTypeSMS = (obj.IsContactPreferenceSMS.toLowerCase() == 'true') ? "checked" : "";
            var ContactTypeMail = (obj.IsContactPreferenceMail.toLowerCase() == 'true') ? "checked" : "";


            $("#tblNDPerson").append(
                "<tr><td valign='top' width='8%'><span class='call_hist_lable'>First Name</span></td>" +
                    "<td valign='top' width='24%' style='word-break:break-all;word-wrap:break-word' >" + obj.FirstName + "</td>" +
                    "<td valign='top'><span class='call_hist_lable'>Last Name</span></td>" +
                    "<td valign='top' style='word-break:break-all;word-wrap:break-word'  width='15%'>" + obj.LastName + "</td>" +
                    "<td valign='top' width='10%' ><span class='call_hist_lable'>Phone-Primary</span></td>" +
                    "<td valign='top' width='12%'> " + obj.PhonePrimary + "</td>" +
                    "<td valign='top' ><span class='call_hist_lable'>Phone-Alternate</span></td>" +
                    "<td valign='top' >" + obj.PhoneAlternate + "</td>" +
                "</tr>" +
                "<tr>" +
                    "<td valign='top' ><span class='call_hist_lable'>Address</span></td>" +
                    "<td valign='top' style='word-break:break-all;word-wrap:break-word'>" + obj.Address + "</td>" +
                    "<td valign='top'><span class='call_hist_lable'>City</span></td>" +
                    "<td valign='top'>" + obj.CityName + "</td>" +
                    "<td valign='top'><span class='call_hist_lable'>State</span></td>" +
                    "<td valign='top'>" + obj.State + "</td>" +
                    "<td valign='top'><span class='call_hist_lable'>Zip</span></td>" +
                    "<td valign='top'>" + obj.Zip + "</td>" +
                "</tr>" +
                "<tr>" +
                    "<td valign='top'  ><span class='call_hist_lable'>Email</span></td>" +
                    "<td valign='top'> " + obj.Email + "</td>" +
                    "<td valign='top'><span class='call_hist_lable'>Gender</span></td>" +
                    "<td valign='top'>" + obj.Gender + "</td>" +
                    "<td valign='top'><span class='call_hist_lable'>DOB</span></td>" +
                    "<td valign='top'>" + obj.DOB + "</td>" +
                    "<td valign='top'><span class='call_hist_lable'>Age</span></td>" +
                    "<td valign='top'>" + obj.Age + "</td>" +
                "</tr>" +
                "<tr>" +
                    "<td valign='top'><span class='call_hist_lable'>Marital Status</span></td>" +
                    "<td valign='top'>" + obj.MaritalStatus + "</td>" +
                    "<td valign='top'><span class='call_hist_lable'>Living Arrangement</span></td>" +
                    "<td valign='top'>" + obj.LivingArrangement + "</td>" +
                    "<td valign='top' colspan='2'><span class='call_hist_lable'>Veteran Status</span></td>" +
                    "<td valign='top' colspan='2'>" + obj.VeteranStatus + "</td>" +
                " </tr>" +
                    "<tr>" +
                    "<td valign='top'><span class='call_hist_lable'>Race</span></td>" +
                    "<td valign='top'>" + obj.Race + "</td>" +
                    "<td valign='top'><span class='call_hist_lable'>Ethnicity</span></td>" +
                    "<td valign='top'>" + obj.Ethnicity + "</td>" +
                    "<td valign='top' '  colspan='2' ><span class='call_hist_lable'>Method of contact</span></td>" +
                    "<td  colspan='2'> <input type='checkbox' disabled=true name='Phone'  value='Phone' " + ContactTypePhone + "/> Phone &nbsp;" +
                    "<input type='checkbox' disabled=true name='Email' value='Email' " + ContactTypeEmail + "/> Email &nbsp;" +
                    "<input type='checkbox' disabled=true name='SMStext' value='SMS' " + ContactTypeSMS + "/> SMS Text &nbsp;" +
                    "<input type='checkbox' disabled=true name='Mail' value='Mail' " + ContactTypeMail + "/> Mail &nbsp; </td>" +
                "</tr>");

            ShowHideNeedyDetailPopup();
        }

        //Created By GK on 10July18 Purpose: Show/Hide Needy person popup
        function ShowHideNeedyDetailPopup() {
            var divpnlContact = document.getElementById("<%=divpnlContact2.ClientID %>");
            var showHideDiv = document.getElementById("<%=showHideDiv2.ClientID %>");
            var divPopUpContent = document.getElementById("<%=divPopUpContent2.ClientID %>");
            var divpopupHeading = document.getElementById("<%=divpopupHeading2.ClientID %>");
            var btnClose = document.getElementById("<%=btnClose2.ClientID %>");
            if (divpnlContact.style.display == "block") {
                showHideDiv.style.display = "none";
                showHideDiv.className = "";
                divPopUpContent.className = "";
                divpnlContact.style.display = "none";
                btnClose.style.display = "none";
                divpopupHeading.style.display = "none";
            }
            else {
                showHideDiv.style.display = "block";
                showHideDiv.className = "main_popup_moreHistory ";
                divPopUpContent.className = "popup_moreHistory ";
                divpnlContact.style.display = "block";
                btnClose.style.display = "block";
                divpopupHeading.style.display = "block";
            }
        }

        function btnMergeValidate() {

            if ($("#MainContent_ddlAgency").val() == "-1") {
                //retVal = false;                
                ShowAlert("Please select an Agency.");
                $("#MainContent_ddlAgency").focus();
                return false;
            }

            var hasValueMergeInto = false, hasValueMergeFrom = false;
            $("#<%=gvNeedyPerson.ClientID %> input[id*='rbMergeInto']").each(function (index) {
                if ($(this).is(':checked') && !hasValueMergeInto) hasValueMergeInto = true;
            });
            $("#<%=gvNeedyPerson.ClientID %> input[id*='cbMergeFrom']").each(function (index) {
                if ($(this).is(':checked') && !hasValueMergeFrom) hasValueMergeFrom = true;
            });

            if (!hasValueMergeInto && !hasValueMergeFrom) {
                ShowAlert("Please select Merge From and Merge Into to proceed."); // Please select Merge From and Merge Into to proceed.
                return false;
            }
            else if (!hasValueMergeInto) {
                ShowAlert("Please select Merge Into.") // Please select Merge Into to proceed.
                return false;
            }
            else if (!hasValueMergeFrom) {
                ShowAlert("Please select Merge From.") // Please select Merge From to proceed.
                return false;
            }

            if (!confirm("After successful merge, the selected (Merge From) Person Needing Assistance record(s) will be merged in to the selected (Merge Into) record and all selected (Merge From) record will be deleted!\n\nAre you sure you want to proceed merge?")) {
                return false;
            }

            return true;
        }
    </script>
</asp:Content>
