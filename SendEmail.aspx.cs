using System;
using System.Web;
using System.Web.UI;
using System.Net.Mail;
//using System.Web.Mail;
using System.Configuration;
using System.IO;
using ADRCIA;
using Microsoft.Security.Application;
//using System.Security.Cryptography.X509Certificates.X509CertificateCollection;
public partial class SendEmail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }
    protected void btnSendEmail_Click(object sender, EventArgs e)
    {
        SendProviderEmail();     
    }

 

    /// <summary>
    /// Created by: SM
    /// Date: 16 April 2014
    /// Purpose: Sent Email by system.net.mail
    /// </summary>
    private void SendProviderEmail()
    {
        if (!ValidateSize(Request.Files))
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, GetType(), "MaxSize", "javascript:alert('You can not attche files more than 6 MB of size.');", true);
        }
        else
        {
            try
            {
                string ToEmail = txtTo.Text.Trim().Replace(";", ",");// if multiple email id with ';' then replace ';' with ','
                var index = txtTo.Text.Trim().LastIndexOf(",");
                if (index == txtTo.Text.Trim().Length - 1)
                {
                    ToEmail = txtTo.Text.Trim().Substring(0, txtTo.Text.Trim().Length - 1);// Remove ',' from last of email if contain
                }

                MailMessage mailMsg = new MailMessage(System.Configuration.ConfigurationManager.AppSettings["EmailFromID"], Sanitizer.GetSafeHtmlFragment(ToEmail), Sanitizer.GetSafeHtmlFragment(txtSubject.Text.ToString()), Sanitizer.GetSafeHtmlFragment(txtBody.Text.ToString()));  //Added by AP on March,28 2024, Regarding T#24533, handle the injection attack. 
                // Attach file automatically when send email
                if (hdnRemoveExcel.Value == "0" || hdnRemoveDoc.Value == "0")
                {
                    string ExcelName = "Report.xls"; // Excel file name
                    string ExcelContentType = "application/excel"; // excel MIME
                    string DocName = "Report.doc"; // Excel file name
                    string DocContentType = "application/msword";//  word MIME
                    string ServiceID = Request.QueryString["serviceID"].ToString();// get Service id

                    if (hdnRemoveDoc.Value == "0") // if Excel file want to send in with email as attachment
                    {    // Get Stream  from Excel
                        MemoryStream msExcel = ADRCIA.ADRCIABAL.DataTableToStream(ADRCIADAL.GetServiceProviderAgency(ServiceID));
                        msExcel.Position = 0;
                        mailMsg.Attachments.Add(new Attachment(msExcel, DocName, DocContentType));
                    }

                    if (hdnRemoveExcel.Value == "0") // if Doc/Word file want to send in with email as attachment
                    {
                        // Get Stream  from Word
                        MemoryStream msWord = ADRCIA.ADRCIABAL.DataTableToStream(ADRCIADAL.GetServiceProviderAgency(ServiceID));
                        msWord.Position = 0;
                        mailMsg.Attachments.Add(new Attachment(msWord, ExcelName, ExcelContentType));
                    }
                }

                // Get the HttpFileCollection
                // Attach file that are browsed.
                HttpFileCollection hfc = Request.Files;
                for (int i = 0; i < hfc.Count; i++)
                {
                    HttpPostedFile hpf = hfc[i];
                    if (hpf.ContentLength > 0)
                    {
                        hpf.InputStream.Position = 0;
                        mailMsg.Attachments.Add(new Attachment(hpf.InputStream, hpf.FileName, hpf.ContentType));
                    }
                }


                SmtpClient smtp = new SmtpClient();

                smtp.Host = System.Configuration.ConfigurationManager.AppSettings["SMTPClient"];// Set SMTP Server            
                // smtp.DeliveryMethod = SmtpDeliveryMethod.PickupDirectoryFromIis;// uncomment for production                 
                smtp.Send(mailMsg);
                smtp.Dispose();

                ScriptManager.RegisterClientScriptBlock(this.Page, GetType(), "Alert", "javascript:alert('Email sent successfully.');", true);
                ScriptManager.RegisterClientScriptBlock(this.Page, GetType(), "close", "window.close();", true);

            }
            catch (Exception ex)
            {
                string alertErrorMgs = "javascript:alert('" + ex .Message+ "');";
                ScriptManager.RegisterClientScriptBlock(this.Page, GetType(), "Alertfail", alertErrorMgs, true);
            }
        }
    }

    
private bool ValidateSize( HttpFileCollection hfc )
{
    bool ValidSize = true;
    int FileMaxSize = Convert.ToInt32(ConfigurationManager.AppSettings["FileUploadSizeLimit"].ToString());
    int TotalattachFileSize = 0;
    for (int i = 0; i < hfc.Count; i++)
    {
        HttpPostedFile hpf = hfc[i];
        if (hpf.ContentLength > 0)
        {
            TotalattachFileSize =TotalattachFileSize+ hpf.ContentLength;
        }
    }

    if (TotalattachFileSize > FileMaxSize)
    { ValidSize = false;
    }
   

    return ValidSize;
}
   


}