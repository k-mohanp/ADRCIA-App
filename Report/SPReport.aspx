<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="SPReport.aspx.cs" Inherits="Report_SPReport" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">

        <div class="report_border1">
            <div style="width: 825px; margin: 0 auto; left: 0">

                <asp:Button ID="btnPDF" runat="server" Text="Generate Report in PDF" OnClick="btnPDF_Click"
                    BackColor="#CEE3F6" />
                <%--  &nbsp;<asp:Button ID="btnExcel" runat="server" Text="Generate Report in Excel" OnClick="btnExcel_Click"
                BackColor="#CEE3F6" />
            <CR:CrystalReportViewer ID="crvReport" runat="server" AutoDataBind="true" ReportSourceID="ReportDS"
                ToolPanelView="None" HasRefreshButton="True" HasToggleGroupTreeButton="false"
                EnableDrillDown="False" EnableTheming="False" HasCrystalLogo="False" HasToggleParameterPanelButton="False"
                Height="996px" RenderingDPI="100" ShowAllPageIds="True" ToolPanelWidth="0px"
                ReuseParameterValuesOnRefresh="True" HasExportButton="False" EnableParameterPrompt="true"   HasPrintButton="False" />
            <CR:CrystalReportSource ID="ReportDS" runat="server">
            </CR:CrystalReportSource>--%>
            </div>
        </div>

    </form>
</body>
</html>


