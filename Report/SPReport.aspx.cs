using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrystalDecisions.Shared;
using CrystalDecisions.CrystalReports.Engine;
using System.IO;
using AISProtectData;
using ADRCIA;


public partial class Report_SPReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       

        if (!IsPostBack)
        {   
            try
            {
                // generate all reports
                //using (ReportDocument objReport = new ReportDocument())
                //{
                //    crvReport.ReportSource = Server.MapPath(ReportSettings.GetReportFileName()); // Report Path
                //    objReport.Load(Server.MapPath(ReportSettings.GetReportFileName())); // Report Path  
                //    ReportSettings.SetParametersForReportViewer(crvReport);
                //    crvReport.Visible = true;
                //    // assign database login info to crystal report 
                //    SetDBLoginInfoForReportViewer();
                //}
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message.ToString());
            }
            finally
            {
                
            }
        }
        /// Added by: MP
        /// Date:03 April 2014
        /// Purpose: Prohibit mobile download 
        if (MySession.blnIsMobileAgent)
        {
         //   btnExcel.Enabled = false;
            btnPDF.Enabled = false;
         //   crvReport.HasPrintButton = false;
        }
    }


    /// <summary>
    /// Author:NK
    /// Set database login info to the crystal report
    /// </summary>
    /// <param name="connectionInfo"></param>
    //private void SetDBLoginInfoForReportViewer()
    //{

    //    ConnectionInfo connectionInfo = new ConnectionInfo();
    //    try
    //    {

    //        string[] dbConParts = ((string)AISProtectData.DPAPI.UnProtectData(MySession.strAppDBConnString)).Split(';');

    //        // create crystal report login table login info
    //        TableLogOnInfos tableLogOnInfos = crvReport.LogOnInfo;
    //        crvReport.RefreshReport();
    //        foreach (TableLogOnInfo tableLogOnInfo in tableLogOnInfos)
    //        {
    //            tableLogOnInfo.ConnectionInfo = connectionInfo;
    //            connectionInfo.Password = dbConParts[3].Split('=')[1];
    //            connectionInfo.UserID = dbConParts[2].Split('=')[1];
    //            connectionInfo.IntegratedSecurity = false;
    //            // need to split on : for localhost to work                              
    //            ReportDS.Report.FileName = ReportSettings.GetReportFileName();
    //            connectionInfo.ServerName = dbConParts[0].Split('=')[1];
    //            connectionInfo.DatabaseName = dbConParts[1].Split('=')[1];
    //        }

    //    }
    //    catch (Exception ex)
    //    {
    //        throw new Exception(ex.Message.ToString());
    //    }
    //    finally
    //    {
    //        connectionInfo = null;
    //    }
    //}
    
   
    protected void btnPDF_Click(object sender, EventArgs e)
    {
        using (CrystalDecisions.CrystalReports.Engine.ReportDocument Report = new CrystalDecisions.CrystalReports.Engine.ReportDocument())
        {
           ReportSettings.SetParametersForExport(Report).ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, MySession.strActiveModule);
        }
    }
    protected void btnExcel_Click(object sender, EventArgs e)
    {
        using (CrystalDecisions.CrystalReports.Engine.ReportDocument Report = new CrystalDecisions.CrystalReports.Engine.ReportDocument())
        {
            ReportSettings.SetParametersForExport(Report).ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.Excel, Response, true, MySession.strActiveModule);
        }
    }


}
