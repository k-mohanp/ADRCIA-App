using System;
using System.Net;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Error : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Application["LastError"] != null)
                Server.Transfer(Page.ResolveUrl("~/CommonApiCall/ErrorHandling.aspx"));
            else
            {
                if (PreviousPage != null)
                    Session["LastErrorResponse"] = PreviousPage.ErrorMessage;

                if (Session["LastErrorResponse"] != null)
                    lblErrorMsg.Text = Session["LastErrorResponse"].ToString();
            }
        }
        catch (Exception ex)
        {

        }
    }
}
