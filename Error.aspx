<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Error.aspx.cs" Inherits="Error" %>

<%@ PreviousPageType VirtualPath="~/CommonApiCall/ErrorHandling.aspx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div style="text-align: center">
        <asp:Label ID="lblErrorMsg" runat="server"></asp:Label>
    </div>
</asp:Content>
