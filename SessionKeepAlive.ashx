<%@ WebHandler Language="C#" Class="SessionKeepAlive" %>

using System;
using System.Web;
using System.Web.SessionState;
public class SessionKeepAlive : IHttpHandler, IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        
    }

    public bool IsReusable {
        get {
            return false;
        }
    }


}