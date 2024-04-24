<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SendRefEmail.aspx.cs" Inherits="SendEmail" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Send Email</title>
      <%--<script src="Scripts/jquery1.9.1.js" type="text/javascript"></script>--%>
    <script src="Scripts/jquery-3.6.0.min.js" type="text/javascript"></script> 
    <script src="Scripts/jquery.MultiFile.js" type="text/javascript"></script>
    <link href="Styles/template.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript">

      <%--  function RemoveDoc() {
            $("#hprRemoveDoc").hide();
            $("#lblDocfile").hide();
            document.getElementById('<%= hdnRemoveDoc.ClientID %>').value = 1;
        }
        function RemoveExcel() {
            $("#hprRemoveExcel").hide();
            $("#lblExcelFile").hide();
            document.getElementById('<%= hdnRemoveExcel.ClientID %>').value = 1;
        }--%>

        function Valid() {

            document.getElementById("lbltoerr").innerHTML = '';
            var email = document.getElementById("<%= txtTo.ClientID%>");


            if (email.value == "") {
                document.getElementById("lbltoerr").style.color = 'Red';
                document.getElementById("lbltoerr").innerHTML = 'Please enter email id.';
                email.focus();
                return false;
            }

            var isValid = false;
            var regex = /^((\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*)\s*[;,.]{0,1}\s*)+$/;
            isValid = regex.test(email.value);

            if (!isValid) {
                document.getElementById("lbltoerr").style.color = 'Red';
                document.getElementById("lbltoerr").innerHTML = 'Please enter valid email id.';
                email.focus();
                return false;
            }

        }

        $(document).ready(function () {

            document.getElementById("<%=txtSubject.ClientID %>").value = "ADRC Referral Information";
            document.getElementById("<%=txtBody.ClientID %>").value = "Please find the details of referral." + "\n\n\n" + "Thanks";
        });

    </script>
</head>
<body>
    <form id="form1" runat="server" autocomplete="off">
        <div class="form_heading" id="MainContent_divContact" style="position: relative; height: 20px">ADRC I & A Mailing Service  </div>
        <table width="80%" style="border-style: solid; margin-top: 10px; margin-bottom: 10px; background-color: InactiveCaption;" align="center">

            <tr>
                <td valign="top" width="5%">
                    <label>To: </label>

                </td>
                <td>
                    <asp:TextBox ID="txtTo" runat="server" Width="500px" ValidationGroup="email"></asp:TextBox>
                    <label id="lbltoerr"></label>
                    <%--<asp:RequiredFieldValidator ID="reqSendEmailID" ControlToValidate="txtTo" ErrorMessage="Please enter email id."
                        runat="server" ValidationGroup="email" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                    <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ValidationExpression="^((\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*)\s*[;,.]{0,1}\s*)+$"
                        ControlToValidate="txtTo" ErrorMessage="Please enter valid email id. " ValidationGroup="email"
                        ForeColor="Red">                                        
                    </asp:RegularExpressionValidator>--%>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <label>Subject: </label>

                </td>
                <td>
                    <asp:TextBox ID="txtSubject" runat="server" Width="500px" MaxLength="200"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <label>Body:</label>

                </td>
                <td>
                    <asp:TextBox ID="txtBody" runat="server" TextMode="MultiLine" Width="500px" Height="100px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <label>Attachment:</label>

                </td>
                <td>

                    <asp:FileUpload ID="FileUpload1" runat="server" class="multi" accept="doc|docx|xls|xlsx|pdf|txt|rtf|jpg|jpeg|gif|png|bmp" Height="20px" Width="500px"/>

                </td>
            </tr>
            <%-- <tr>
            <td>
            </td>
            <td>
                <a id="hprRemoveDoc" href="#" onclick="RemoveDoc();">x</a>&nbsp;&nbsp;<asp:Label
                    ID="lblDocfile" Text="Report.docx" runat="server"></asp:Label><br />
                <a id="hprRemoveExcel" href="#" onclick="RemoveExcel();">x</a>&nbsp;&nbsp;<asp:Label
                    ID="lblExcelFile" Text="Report.xls" runat="server"></asp:Label>
                <asp:HiddenField Value="0" ID="hdnRemoveExcel" runat="server" />
                <asp:HiddenField Value="0" ID="hdnRemoveDoc" runat="server" />
            </td>
        </tr>--%>

            <tr>
                <td>
                    <label>Valid Extensions:</label></td>
                <td>
                    <label>(doc, docx, xls, xlsx, pdf, txt, rtf, jpg, jpeg, gif, png, bmp)</label></td>
            </tr>
            <tr>
                <td colspan="2" align="center" height="10px">
                    <asp:Button ID="btnSendEmail" runat="server" Text="     Send Email    " OnClientClick="return Valid();" OnClick="btnSendEmail_Click" />
                </td>
            </tr>
        </table>

        <%--<table width="80%" style="margin-top: 10px; font-family:Calibri; font-size:8pt; margin-bottom: 10px; background-color: InactiveCaption;" align="center">
            <tr>
                <td colspan="2">Dear Referrer,</td>
            </tr>

            <tr>
                <td colspan="2">A referral has been done and being sent to you. Please refer below the details.</td>
            </tr>

            <tr>
                <td width="25%"><b>Needy Person Name: </b></td>
                <td></td>
            </tr>
            <tr>
                <td><b>Referred By Agency:</b></td>
                <td></td>
            </tr>
            <tr>
                <td><b>Referred to Service Providers: </b></td>
                <td></td>
            </tr>
            <tr>
                <td>
                    <br /><br />
                </td>
            </tr>
            <tr>
                <td><b>Thanks.</b> </td>
            </tr>
        </table>--%>
    </form>
</body>
</html>
