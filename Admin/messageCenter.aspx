<%@ Page Language="C#" MasterPageFile="~/Admin/Site.master" AutoEventWireup="true"
    Inherits="admin_messageCenter" Title="Message Center"
    CodeFile="messageCenter.aspx.cs" %>

<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<%@ Import Namespace="ADRCIA" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <%--<script src="../ckeditor/ckeditor.js" type="text/javascript"></script>--%>
    
    

   
    <div align="center">
        <h1 class="heading">
            Message Center</h1>
        <table border="0" cellpadding="10" cellspacing="10">
            <tr>
                <td id="tdLabel1" runat="server" class="formlabel">
                    <label>
                        Agency/Provider</label>
                </td>
                <td id="tdDDL1" runat="server" align="left">
                    <asp:DropDownList ID="ddlSites" runat="server" CssClass="required" AutoPostBack="true"
                        OnSelectedIndexChanged="ddlSites_SelectedIndexChanged" />
                    <asp:RegularExpressionValidator ID="reqSites" ControlToValidate="ddlSites" runat="server"
                        Display="None" SetFocusOnError="true" ErrorMessage="Agency/Provider or 'All Agencies/Providers' is required." />
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td align="left">
                    <asp:ValidationSummary ID="validationSummary" runat="server" HeaderText="Please correct the following error(s):" />
                    <asp:HiddenField ID="hdnMessageID" Value="0" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    <label>
                        Date From </label>
                </td>
                <td align="left">
                    <asp:TextBox ID="txtDateFrom" runat="server" CssClass="required" Width="90px" />
                    <asp:ImageButton ID="btnDateFrom" runat="server" ImageUrl="~/images/calendar_icon.png"
                        CausesValidation="false" TabIndex="-1" ImageAlign="AbsBottom" />
                    <%--   <asp:RequiredFieldValidator ID="reqDateFrom" runat="server" ControlToValidate="txtDateFrom" ErrorMessage=" Date From is required. " Display="None"></asp:RequiredFieldValidator>--%>
                    <ajax:MaskedEditExtender ID="meeDateFrom" TargetControlID="txtDateFrom" runat="server"
                        MaskType="date" Mask="99/99/9999" ClearMaskOnLostFocus="false">
                    </ajax:MaskedEditExtender>
                    <ajax:MaskedEditValidator ID="mevDateFrom" ControlToValidate="txtDateFrom" ControlExtender="meeDateFrom"
                        runat="server" Display="None" InvalidValueMessage="Date From is required in valid format."
                        IsValidEmpty="false" />
                    <asp:CompareValidator ID="cmpDateFromValid" ControlToValidate="txtDateFrom" ValueToCompare="01/01/1900"
                        runat="server" Display="none" Type="date" Operator="GreaterThanEqual" SetFocusOnError="true"
                        ErrorMessage="Date From should be less than To Date." />
                    <ajax:CalendarExtender ID="calDateFrom" TargetControlID="txtDateFrom" Enabled="true"
                        runat="server" PopupButtonID="btnDateFrom" />
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    <label>
                        Date To</label>
                </td>
                <td align="left">
                    <asp:TextBox ID="txtDateTo" runat="server" CssClass="required" Width="90px" />
                    <asp:ImageButton ID="btnDateTo" runat="server" ImageUrl="~/images/calendar_icon.png"
                        CausesValidation="false" TabIndex="-1" ImageAlign="AbsBottom" />
                    <%-- <asp:RequiredFieldValidator ID="reqDateTo" runat="server" ControlToValidate="txtDateTo" ErrorMessage=" Date To is required. " Display="None"></asp:RequiredFieldValidator>--%>
                    <ajax:MaskedEditExtender ID="meeDateTo" TargetControlID="txtDateTo" runat="server"
                        MaskType="date" Mask="99/99/9999" ClearMaskOnLostFocus="false">
                    </ajax:MaskedEditExtender>
                    <ajax:MaskedEditValidator ID="mevDateTo" ControlToValidate="txtDateTo" ControlExtender="meeDateTo"
                        runat="server" Display="None" InvalidValueMessage="Date To is required in valid format."
                        IsValidEmpty="false" />
                    <asp:CompareValidator ID="cmpDateToValid" ControlToValidate="txtDateTo" ValueToCompare="1/1/1900"
                        runat="server" Display="none" Type="date" Operator="GreaterThanEqual" SetFocusOnError="true"
                        ErrorMessage="Date To should be greater than Date From." />
                    <ajax:CalendarExtender ID="calDateTo" TargetControlID="txtDateTo" Enabled="true"
                        runat="server" PopupButtonID="btnDateTo" />
                    <asp:CompareValidator ID="cmpDateTo" ControlToValidate="txtDateTo" ControlToCompare="txtDateFrom"
                        runat="server" Display="none" Type="date" Operator="GreaterThanEqual" SetFocusOnError="false"
                        ErrorMessage="Date To cannot be before Date From." TabIndex="-1" />
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    <label>
                        Critical</label>
                </td>
                <td align="left">
                    <asp:CheckBox ID="cbCritical" runat="server" />
                </td>
            </tr>


        </table>
        <table width="90%">
            <tr>
                <td  align="left">
                    <label>
                        Message:</label>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <%--<textarea name="txtMessage" id="txtMessage" runat="server" clientidmode="Static"    onkeyup="return ismaxlength(this);" ></textarea>--%>

                    <mt:CKEditorControl ID="txtMessage" runat="server" />
                   
                    <asp:RequiredFieldValidator ID="reqMessage" ControlToValidate="txtMessage" runat="server"
                        Display="None" SetFocusOnError="true" ErrorMessage="Message is required." />
                    <%--<script type="text/javascript">
                        CKEDITOR.replace('txtMessage');
                    </script>--%>
                </td>
            </tr>
            <tr>
            <td>
            &nbsp;  &nbsp;  &nbsp;  &nbsp;
            </td>
            
            </tr>
            <tr>
                <td align="center">
                    <asp:Button ID="btnSubmit" runat="server" Text="Save" OnClick="btnSubmit_Click" CssClass="btn" />&nbsp;&nbsp;
                    <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click" CausesValidation="false"
                        CssClass="btn" />
                </td>
            </tr>

             <tr>
            <td colspan="2">
            &nbsp;  &nbsp;  &nbsp;  &nbsp;
            </td>
            
            </tr>
            <tr>
            <td colspan="2">
            <asp:GridView ID="gv1" runat="server" AutoGenerateColumns="false" DataKeyNames="MessageID"
            GridLines="Horizontal" OnRowEditing="gv1_RowEditing" OnRowDeleting="gv1_RowDeleting"
            AllowPaging="true" PageSize="10" PagerSettings-Position="TopAndBottom" PagerSettings-Visible="true"
            CssClass="gridview_gray" HeaderStyle-CssClass="gridview_header_gray" RowStyle-CssClass="normal_gray"
            AlternatingRowStyle-CssClass="alternate_gray" OnPageIndexChanging="gv1_PageIndexChanging"
            OnRowDataBound="gv1_RowDataBound" OnSelectedIndexChanged="gv1_SelectedIndexChanged">
            <Columns>
                <asp:TemplateField  SortExpression="MessageID" ItemStyle-Width="4%">
                    <ItemTemplate>
                        &nbsp;
                        <asp:ImageButton ID="btnDelete"  ToolTip ="Delete" runat="server" CausesValidation="false" ImageUrl="~/images/trash_can.gif"
                            OnClientClick="return confirm('Are you sure you want to delete this record?');"
                            CommandName="Delete" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Date Added" SortExpression="CreatedDate" ItemStyle-Width="8%">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkEdit" runat="server" ToolTip="Edit" CausesValidation="false" CommandName="Edit"><%# DateTime.Parse(DataBinder.Eval(Container.DataItem, "CreatedDate").ToString()).ToShortDateString() %></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Message Text" SortExpression="MessageText"   ItemStyle-Wrap="true">
                    <ItemTemplate>
                        <%# 
						"<div " + ((DataBinder.Eval(Container.DataItem, "Critical").ToString() == "True")?"class=red":"") + ">" + Server.HtmlDecode( DataBinder.Eval( Container.DataItem, "MessageText").ToString())
					
						+ "</div>" 
                        %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="Agency/Provider" DataField="AAAProviderName" SortExpression="AAAProviderName"
                    ReadOnly="true" ItemStyle-Width="15%" />
                <asp:TemplateField HeaderText="Date From" SortExpression="DateFrom" ItemStyle-Width="8%">
                    <ItemTemplate>
                        <%# DateTime.Parse(DataBinder.Eval(Container.DataItem, "DateFrom").ToString()).ToShortDateString() %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Date To" SortExpression="DateTo" ItemStyle-Width="5%">
                    <ItemTemplate>
                        <%# DateTime.Parse(DataBinder.Eval(Container.DataItem, "DateTo").ToString()).ToShortDateString() %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField  HeaderText="Critical" SortExpression="Critical" ItemStyle-Width="4%" ItemStyle-HorizontalAlign="Right">
                    <ItemTemplate>
                        <%# functions.FormatYesNo(DataBinder.Eval(Container.DataItem, "Critical").ToString()) %>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

            </td>
            </tr>
        </table>
         
           

    </div>
</asp:Content>
