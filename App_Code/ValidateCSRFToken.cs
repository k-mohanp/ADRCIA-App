using System;
using System.Web;
using System.Web.Helpers;

public static class ValidateToken
{
    public static bool IsValidAjaxRequest(HttpRequest request)
    {
        if (request == null)
        {
            throw new ArgumentNullException("request");
        }
        //Added by AR 02 Jan 2024 to check invalid ajax request after session killed (SOW-654)
        if ((!request.Url.AbsolutePath.ToLower().Contains("login.aspx") && HttpContext.Current.Session["AUTH_USER"] == null))
            return false;

        return (request["X-Requested-With"] == "XMLHttpRequest") ||
            ((request.Headers != null) && (request.Headers["X-Requested-With"] == "XMLHttpRequest"));
    }

    public static bool ValidateAntiForgeryToken(HttpRequest request)
    {
        try
        {
            if (request == null)
            {
                return false;
            }
            AntiForgery.Validate(HttpContext.Current.Request.Cookies["__RequestVerificationToken"].Value, request.Headers["RequestVerificationToken"].ToString());
            return true;
        }
        catch(Exception ex)
        {
            return false;
        }
    }
}
