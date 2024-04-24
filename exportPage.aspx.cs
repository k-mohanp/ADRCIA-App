using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using ADRCIA;
using System.Text;
using System.Net.Mail;
using System.IO;
public partial class exportPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
         string ContentType=string.Empty;
       string FileName = string.Empty;
        string ServiceID = string.Empty;
        int ExportType=0;
        //0: Excel
        //1: Word
        //2 for Email with attachment
        if (Request.Form["ExportType"] == "0")
        {
            ContentType = "application/excel";
            FileName = "Report.xls";
            ExportType = 0;
        }
        else if (Request.Form["ExportType"] == "1")
        {
            ContentType = "application/msword";
           FileName = "Report.doc";
           ExportType = 1;
        }

        else if (Request.Form["ExportType"] == "2")
        {
            ContentType = "application/excel";
            FileName = "Report.xls";
            ExportType = 2;
        }

        //ExportToFile(ContentType, FileName, Request.Form["serviceID"]);

        ExportToSpreadsheet(ContentType, FileName, Request.Form["serviceID"], ExportType);
        //HttpContext.Current.Response.End();
    }

    /// <summary>
    /// Created By: SM
    /// Date: 11 April 2014
    /// Purpose:Open file as dialog 
    /// </summary>
    /// <param name="tableStream"></param>
    /// <param name="name"></param>
    private void ExportToSpreadsheetInternal(MemoryStream tableStream, string name)
    {

        HttpContext context = HttpContext.Current;
        context.Response.Clear();
        context.Response.ContentType = ContentType;
        context.Response.AppendHeader(
            "Content-Disposition"
            , "attachment; filename=" + name);

        tableStream.Position = 0;
        tableStream.CopyTo(context.Response.OutputStream);
      
        context.Response.Flush();
        context.Response.End();

    }
    /// <summary>
    /// Created By: SM
    /// Date: 11 April 2014
    /// Purpose:This is comman function that will call for Export to Excel and Export to Word.         
    /// </summary>
    /// <param name="ContentType"></param>
    /// <param name="FileName"></param>
    /// <param name="ServiceID"></param>
    /// <param name="ExportType"></param>
    public void ExportToSpreadsheet(string ContentType, string FileName, string ServiceID, int ExportType)
    {
       
        // ExportType:
        // 0- Excel,
        // 1- Doc,
        DataTable dtlist = ADRCIADAL.GetServiceProviderAgency(ServiceID);
        MemoryStream stream =  ADRCIA.ADRCIABAL.DataTableToStream(dtlist);
     
        // open file dialog window
        ExportToSpreadsheetInternal(stream, FileName);

        stream.Dispose();
        dtlist.Dispose();
    }

    
}