<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CSRFControl.ascx.cs" Inherits="CSRFControl" %>
<%-- Added by PC on 23 Jan 2020, Purpose: Cross-site request forgery (CSRF) --%>
            <%= System.Web.Helpers.AntiForgery.GetHtml() %>
<%--END--%>
