<%@ Page Language="C#" AutoEventWireup="true" CodeFile="getSession.aspx.cs" Inherits="getSession" EnableViewStateMac="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="~/CSRFControl.ascx" TagPrefix="uc1" TagName="CSRFControl" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
        <uc1:CSRFControl runat="server" ID="CSRFControl" /> 
    <div>
		<asp:Literal ID="lit1" runat="server" Visible="false"><b>Session vars</b><br /></asp:Literal>
		
		<asp:HyperLink ID="lnkLogin" runat="server" NavigateUrl="~/login.aspx" Visible="false">Login</asp:HyperLink>
    </div>
    </form>
</body>
</html>
