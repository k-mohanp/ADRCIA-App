using System;
using System.Web;
using System.Web.UI;
using System.Net.Mail;
//using System.Web.Mail;
using System.Configuration;
using System.Data;
using ADRCIA;
using System.Text;
using System.IO;
using System.Web.Services;
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
            ScriptManager.RegisterClientScriptBlock(this.Page, GetType(), "MaxSize", "javascript:alert('You can not attach files more than 6 MB of size.');", true);
        }
        else
        {
            try
            {
                ReferredEmail refemail = (ReferredEmail)Session["ReferredEmail"];


                string ToEmail = txtTo.Text.Trim().Replace(";", ",");// if multiple email id with ';' then replace ';' with ','
                var index = txtTo.Text.Trim().LastIndexOf(",");
                if (index == txtTo.Text.Trim().Length - 1)
                {
                    ToEmail = txtTo.Text.Trim().Substring(0, txtTo.Text.Trim().Length - 1);// Remove ',' from last of email if contain
                }

                StringBuilder sb = new StringBuilder();

                sb.Append("<table width='100%' style='margin-top:10px;font-family:Calibri; font-size:10pt; margin-bottom:10px; background-color:InactiveCaption;' align='left'>");
                sb.Append("<tr>");
                sb.Append("<td colspan='2'>" + txtBody.Text.Replace("Thanks", " ") + "<br/><br/>" + "</td>");
                sb.Append("</tr>");
                sb.Append("<tr>");
                sb.Append("<td colspan='2'>Dear Referrer,</td>");
                sb.Append("</tr>");
                sb.Append("<tr>");
                sb.Append("<td colspan='2'>A referral has been done and being sent to you. Please refer below the details.</td>");
                sb.Append("</tr>");

                sb.Append("<tr>");
                sb.Append("<td colspan='2' align='left'>&nbsp;</td>");
                sb.Append("</tr>");

                sb.Append("<tr>");
                sb.Append("<td width='22%'><b>Needy Person Name: </b></td>");
                sb.Append("<td style='word-wrap:break-word;text-transform:capitalize;'> " + refemail.NeedyPersonName + " </td>");
                sb.Append("</tr>");

                //Commented by SA on 14th April, 2015.
                //sb.Append("<tr>");
                //sb.Append("<td width='22%'><b>Date of Birth: </b></td>");
                //sb.Append("<td style='word-wrap:break-word;text-transform:capitalize;'> " + refemail.DOB + " </td>");
                //sb.Append("</tr>");

                if (!string.IsNullOrEmpty(refemail.Gender))
                {
                    sb.Append("<tr>");
                    sb.Append("<td width='22%'><b>Gender: </b></td>");
                    sb.Append("<td> " + refemail.Gender == "--Select--" ? "N/A" : refemail.Gender + " </td>");
                    sb.Append("</tr>");
                }

                sb.Append("<tr>");
                sb.Append("<td><b>Referred By Agency:</b></td>");
                sb.Append("<td>" + MySession.AAAAgencyName + " </td> ");
                sb.Append("</tr>");

                sb.Append("<tr>");
                sb.Append("<td valign='top'><b>Referred to ADRC Partner: </b></td>");
                sb.Append("<td style='word-wrap:break-word;'> " + refemail.ReferredTo + "</td>");
                sb.Append("</tr>");

                sb.Append("<tr>");
                sb.Append("<td colspan='2' align='left'> <br/><br/><br/> </td>");
                sb.Append("</tr>");

                sb.Append("<tr>");
                sb.Append("<td colspan='2' align='left'> <b>Thanks & Regards, <br/> " + MySession.AAAAgencyName + ". <br/> ADRC Information & Assistance. <br/></b> </td>");
                sb.Append("</tr>");

                sb.Append("</table>");



                MailMessage mailMsg = new MailMessage(System.Configuration.ConfigurationManager.AppSettings["EmailFromID"], ToEmail, Sanitizer.GetSafeHtmlFragment(txtSubject.Text.ToString()), sb.ToString()); //Added by AP on March,28 2024, Regarding T#24533, handle the injection attack.   
                mailMsg.IsBodyHtml = true;

                string DocName = "";
                string DocContentType = string.Empty;
                if (FileUpload1.HasFile)
                {
                    // Get the HttpFileCollection
                    // Attach file that are browsed.
                    HttpFileCollection hfc = Request.Files;

                    for (int i = 0; i < hfc.Count; i++)
                    {
                        string[] arrName = Path.GetFileName(hfc[i].FileName).Split('.');
                        DocName = arrName[0];
                        string extension = Path.GetExtension(hfc[i].FileName);

                        if (extension.ToLower() == ".txt")
                        {
                            DocContentType = "application/text";
                            DocName += ".txt";
                        }
                        else if (extension.ToLower() == ".doc" || extension.ToLower() == ".docx")
                        {
                            DocContentType = "application/msword";
                            DocName += ".doc";
                        }
                        else if (extension.ToLower() == ".xls" || extension.ToLower() == ".xlsx")
                        {
                            DocContentType = "application/excel";
                            DocName += ".xls";
                        }
                        else if (extension.ToLower() == ".pdf")
                        {
                            DocContentType = "application/pdf";
                            DocName += ".pdf";
                        }
                        else if (extension.ToLower() == ".jpg" || extension.ToLower() == ".jpeg")
                        {
                            DocContentType = "image/jpg";
                            DocName += ".jpg";
                        }
                        else if (extension.ToLower() == ".gif")
                        {
                            DocContentType = "image/gif";
                            DocName += ".gif";
                        }
                        else if (extension.ToLower() == ".png")
                        {
                            DocContentType = "image/png";
                            DocName += ".png";
                        }
                        else if (extension.ToLower() == ".bmp")
                        {
                            DocContentType = "image/bmp";
                            DocName += ".bmp";
                        }
                        else if (extension.ToLower() == ".rtf")
                        {
                            DocContentType = "application/rtf";
                            DocName += ".rtf";
                        }

                        HttpPostedFile hpf = hfc[i];
                        if (hpf.ContentLength > 0)
                        {
                            hpf.InputStream.Position = 0;
                            mailMsg.Attachments.Add(new Attachment(hpf.InputStream, DocName, hpf.ContentType));
                        }
                    }
                }

                //byte[] myByteArray = System.Text.Encoding.UTF8.GetBytes(FileUpload1.PostedFile.ToString());

                //MemoryStream msExcel = new MemoryStream(myByteArray);
                //msExcel.Position = 0;
                //mailMsg.Attachments.Add(new Attachment(msExcel, DocName, DocContentType));
                // Attach file automatically when send email
                //if (hdnRemoveExcel.Value == "0" || hdnRemoveDoc.Value == "0")
                //{
                //    string ExcelName = "Report.xls"; // Excel file name
                //    string ExcelContentType = "application/excel"; // excel MIME
                //    string DocName = "Report.doc"; // Excel file name
                //    string DocContentType = "application/msword";//  word MIME
                //    //string ServiceID = Request.QueryString["serviceID"].ToString();// get Service id

                //    //if (hdnRemoveDoc.Value == "0") // if Excel file want to send in with email as attachment
                //    //{    // Get Stream  from Excel
                //    //    //MemoryStream msExcel = ADRCIA.ADRCIABAL.DataTableToStream(ADRCIADAL.GetServiceProviderAgency(ServiceID));
                //    //    //msExcel.Position = 0;
                //    //    //mailMsg.Attachments.Add(new Attachment(msExcel, DocName, DocContentType));
                //    //}

                //    //if (hdnRemoveExcel.Value == "0") // if Doc/Word file want to send in with email as attachment
                //    //{
                //    //    // Get Stream  from Word
                //    //    //MemoryStream msWord = ADRCIA.ADRCIABAL.DataTableToStream(ADRCIADAL.GetServiceProviderAgency(ServiceID));
                //    //    //msWord.Position = 0;
                //    //    //mailMsg.Attachments.Add(new Attachment(msWord, ExcelName, ExcelContentType));
                //    //}
                //}



                SmtpClient smtp = new SmtpClient();

                smtp.Host = System.Configuration.ConfigurationManager.AppSettings["SMTPClient"];// Set SMTP Server            
                //smtp.DeliveryMethod = SmtpDeliveryMethod.PickupDirectoryFromIis;// uncomment for production                 
                smtp.Send(mailMsg);
                smtp.Dispose();

                ScriptManager.RegisterClientScriptBlock(this.Page, GetType(), "Alert", "javascript:alert('Email sent successfully.');", true);
                ScriptManager.RegisterClientScriptBlock(this.Page, GetType(), "close", "window.close();", true);

            }
            catch (Exception ex)
            {
                //string alertErrorMgs = "javascript:alert('" + ex.Message + "');";
                //ScriptManager.RegisterClientScriptBlock(this.Page, GetType(), "Alertfail", alertErrorMgs, true);
            }
        }

    }


    private bool ValidateSize(HttpFileCollection hfc)
    {
        bool ValidSize = true;
        int FileMaxSize = Convert.ToInt32(ConfigurationManager.AppSettings["FileUploadSizeLimit"].ToString());
        int TotalattachFileSize = 0;
        for (int i = 0; i < hfc.Count; i++)
        {
            HttpPostedFile hpf = hfc[i];
            if (hpf.ContentLength > 0)
            {
                TotalattachFileSize = TotalattachFileSize + hpf.ContentLength;
            }
        }

        if (TotalattachFileSize > FileMaxSize)
        {
            ValidSize = false;
        }


        return ValidSize;
    }
    [WebMethod]
    public static void getRefEmailDetails(ReferredEmail referredEmail)
    {
        // Added by GK on 20Oct:2022 #Ticket 11847
        if (ValidateToken.IsValidAjaxRequest(HttpContext.Current.Request))
            HttpContext.Current.Session["ReferredEmail"] = referredEmail;
    }



}