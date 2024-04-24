using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

public partial class WebUserControl : System.Web.UI.UserControl
{
    //public string Text
    //{
    //    get
    //    {
    //        HtmlTextArea txtarea = (HtmlTextArea)(this.FindControl("txtAreaBox"));

    //        return txtarea.Value;
    //    }

    //    set
    //    {
    //        HtmlTextArea txtarea = (HtmlTextArea)(this.FindControl("txtAreaBox"));
    //        txtarea.Value = value;

    //    }

    //}
    public string Text
    {
        get { return txtAreaBox.Text; }

        set { txtAreaBox.Text = value; }

    }
    public int MaxLength { get; set; }
    public Unit Height
    {
       
        get {
           
            return txtAreaBox.Height;   
        }

        set { txtAreaBox.Height = value; }
    }

    public Unit Width
    {
        get { return txtAreaBox.Width; }

        set { txtAreaBox.Width = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (MaxLength != 0)
        {
            txtAreaBox.Attributes.Add("onkeyup", "countChar(this," + MaxLength + ");");
            txtAreaBox.Attributes.Add("onkeydown", "countChar(this," + MaxLength + ");");
            txtAreaBox.Attributes.Add("onpaste", "countChar(this," + MaxLength + ");");
           // txtAreaBox.Attributes.Add("onkeypress", "countChar(this," + MaxLength + ");");
            txtAreaBox.Attributes.Add("style", "word-break:break-all;word-wrap:break-word");

          
        }
        else
            txtAreaBox.MaxLength = 2000;
    }
}