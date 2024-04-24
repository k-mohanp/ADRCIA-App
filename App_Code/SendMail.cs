using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Net;
using System.Net.Mail;
/// <summary>
/// Summary description for SendMail
/// </summary>
public class SendMail
{
    //public void sendmail(string strFrom, string strTo, string strSubject, string strMessage, string strSMTPServer)
    //{
    //    System.Web.Mail.MailMessage objMail;
    //    objMail = new System.Web.Mail.MailMessage();
    //    objMail.From = strFrom;
    //    objMail.To = strTo;
    //    objMail.Subject = strSubject;
    //    objMail.Body = strMessage;
    //    objMail.BodyFormat = System.Web.Mail.MailFormat.Html;        
    //    System.Web.Mail.SmtpMail.SmtpServer = strSMTPServer;
    //    System.Web.Mail.SmtpMail.Send(objMail);        
    //}
    //Add by VK on 19 Aug ,2016. for is IsNull Or Empty SMPTServer IP then pass default. 
    public void sendmail(string strFrom, string strTo, string strSubject, string strMessage, string strSMTPServer)
    {
        MailMessage mailMsg = new MailMessage(strFrom, strTo, strSubject.ToString(), strMessage.ToString());
        mailMsg.IsBodyHtml = true;
        SmtpClient smtp = new SmtpClient();
        try
        {
            if (!string.IsNullOrEmpty(strSMTPServer))
                smtp.Host = strSMTPServer;
            else
            {
                if (!string.IsNullOrEmpty(System.Configuration.ConfigurationManager.AppSettings["SMTPClient"]))
                    smtp.Host = System.Configuration.ConfigurationManager.AppSettings["SMTPClient"];
                else
                    smtp.Host = "192.168.10.20";
            }
            //smtp.DeliveryMethod = SmtpDeliveryMethod.PickupDirectoryFromIis;// uncomment for production                 
            smtp.Send(mailMsg);
        }
        catch
        {
        }
        finally
        {
            mailMsg.Dispose();
            //smtp.Dispose(); 
        }
    }
}
