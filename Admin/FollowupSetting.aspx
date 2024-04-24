<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site.master" AutoEventWireup="true"
    CodeFile="FollowupSetting.aspx.cs" Inherits="Admin_FollowupSetting" %>

<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <script type="text/javascript">

        $(document).ready(function () {
            //  $('#txtPriorDay').spinner({ min: 0, max: $('#hdnMaxPriorDay').val() });
            $('#txtPriorDay').keydown(function (e) { if (e.shiftKey || e.ctrlKey || e.altKey) { e.preventDefault(); } else { var key = e.keyCode; if (!((key == 8) || (key == 46) || (key >= 35 && key <= 40) || (key >= 48 && key <= 57) || (key >= 96 && key <= 105))) { e.preventDefault(); } } });
            //            $('#txtPriorDay').on('blur', function () {
            //               

            //            });

        });

        function ValidatepriorDate() {
            var MaxPriorDay = $('#hdnMaxPriorDay').val();
            var PriorDay = $('#txtPriorDay').val();
            if (parseInt(PriorDay) > parseInt(MaxPriorDay)) {
                alert('Number of prior day should not be more than 30.');
                $('#txtPriorDay').focus();
                return false;
            }
            else if ($('#txtPriorDay').val() == '') {
                $('#txtPriorDay').val(0);
            }
        }

    </script>
    <div align="center">
        <h3>
            Follow-up Setting
        </h3><br />
        <fieldset style="width: 50%">
            <table width="80%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td align="left" valign="middle">
                      <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>Number of prior day(s)</td>
                            <td class="prior-day-ctrl"><asp:TextBox ID='txtPriorDay' runat='server' ClientIDMode='Static' Text='0' Height="20" 
                            Width="100" onBlur="ValidatepriorDate();" MaxLength="2"> </asp:TextBox></td>
                            <td>before the follow-up date to send email.</td>
                            <td><ajax:NumericUpDownExtender ID="numExtender" runat="server" TargetControlID="txtPriorDay"
                            Minimum="0" Maximum="30" Width="50" >
                        </ajax:NumericUpDownExtender> <input type="hidden" value="30" id="hdnMaxPriorDay" /></td>
                        </tr>
                      </table>
                        
                        
                        
                        
                        
                      
                    </td>
                </tr>
                <tr>
                    <td align="left" valign="middle"> 
                        <span style="padding:10px 0 0 0; display:block;">Enable reminder email &nbsp;
                            <asp:CheckBox ID="chkFollowUpActive" runat="server" />
                        </span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <br />
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" CssClass="btn" />
                    </td>
                </tr>
            </table>
        </fieldset>
    </div>
</asp:Content>
