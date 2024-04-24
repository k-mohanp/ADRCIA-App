<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <table>
        <tr>
            <td>
                &nbsp;
            </td>
            <td colspan="2" align="left">
                <asp:Literal ID="litInstruct" runat="server" Visible="false">Please enter your Resource Maintenance login info below to continue to the RMS application.</asp:Literal>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td colspan="2" align="center">
                <asp:Label ID="lblError" runat="server" CssClass="error" />
            </td>
        </tr>
        <asp:Panel ID="pnlLogin" runat="server" Visible="false">
            <tr>
                <td>
                    &nbsp;
                </td>
                <td align="right">
                    User Name:&nbsp;
                </td>
                <td align="left">
                    <asp:TextBox ID="txtUser" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
                <td align="right">
                    Password:&nbsp;
                </td>
                <td align="left">
                    <asp:TextBox ID="txtPassword" TextMode="Password" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
                <td colspan="2" align="center">
                    <br />
                    <asp:Button ID="btnLogin" runat="server" Text="Login" />
                </td>
            </tr>
        </asp:Panel>
    </table>
    </form>
</body>
</html>
