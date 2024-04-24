using System;
using System.Collections.Generic;
using System.Web;
using System.Configuration;
using Newtonsoft.Json;
using System.Net.Http;
using System.Reflection;
using System.Net;
using System.Data;
using System.Collections;
using System.Net.Http.Headers;

public partial class CommonApiCall_ErrorHandling : System.Web.UI.Page
{
    public string ErrorMessage { get; set; }
    
    protected void Page_Load(object sender, EventArgs e)
    {
        string user = "";
        if (Session["AUTH_USER"] != null)
            user = Session["AUTH_USER"].ToString();
        else if (Session["UserName"] != null)
            user = Session["UserName"].ToString();
        Exception errorObj = (Exception) Application["LastError"];
        ErrorMessage = GetErrorMessage(errorObj, Request, user);
        Server.ClearError();
        Application.Remove("LastError");
        Server.Transfer(Page.ResolveUrl("~/error.aspx"));
    }

    public string GetErrorMessage(Exception errorObj, HttpRequest requestObj, string user)
    {
        string errorMsg = "";
        try
        {
            string apiBaseAddress = "http://132.147.1.11/secure/AISCommonApi/";
            string Key = "OnY_Hy6CNgcWF-DbFHy8Bq1PSCqCWOwp";

            HttpClient client = new HttpClient();
            Uri baseAddress = new Uri(apiBaseAddress);
            client.BaseAddress = baseAddress;
            client.DefaultRequestHeaders.Add("AISErrorKey", Key);
            string AppName = "";

            if (!string.IsNullOrEmpty(Convert.ToString(requestObj.Url)))
            {
                string appName = "";
                appName = requestObj.Url.Segments[1].Replace('/', ' ').Trim();
                if (appName.ToLower().Trim() == "secure")
                    appName = requestObj.Url.Segments[2].Replace('/', ' ').Trim();
                AppName = appName.Replace('?', ' ').Trim();
            }
            BaseHttpRequestDetails reqObject = new BaseHttpRequestDetails()
            {
                BrowserName = requestObj.Browser.Browser,
                MajorVersion = requestObj.Browser.MajorVersion.ToString(),
                MinorVersion = requestObj.Browser.MinorVersion.ToString(),
                UserHostAddress = requestObj.UserHostAddress.ToString(),
                Url = requestObj.Url.ToString(),
                UserName = user,
                AppNameKey = AppName,

            };
            ArrayList paramList = new ArrayList();
            paramList.Add(JsonConvert.SerializeObject(errorObj));
            paramList.Add(JsonConvert.SerializeObject(reqObject));
            HttpResponseMessage response = client.PostAsJsonAsync("api/v1/ErrorMessage", paramList).Result;
            if (response.IsSuccessStatusCode)
            {
                errorMsg = response.Content.ReadAsAsync<string>().Result;
            }
            else
                errorMsg = response.ReasonPhrase;
        }
        catch (Exception ex)
        {
            errorMsg = "Error: No connection could be made because the error api actively refused it."
               + "<br/> If this error message continuously appears, please contact site administrator.";
        }
        return errorMsg;
    }

    public class BaseHttpRequestDetails
    {
        public string UserHostAddress { get; set; }
        public string BrowserName { get; set; }
        public string MajorVersion { get; set; }
        public string MinorVersion { get; set; }
        public string Url { get; set; }
        public string UserName { get; set; }
        public string AppNameKey { get; set; }
    }
}