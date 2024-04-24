using System;

public partial class getSession : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		for (int i = 0; i < Request.Form.Count; i++)
		{
			Session[Request.Form.GetKey(i).ToString()] = Request.Form[i].ToString();
		}

		Response.Redirect("login.aspx");
    }
}
