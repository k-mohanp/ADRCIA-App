using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using ADRCIA;
using Microsoft.Security.Application;   //Added by RK,01April2024

public partial class admin_messageCenter : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {


        //if (!MySession.blnADRCIAOSAAdmin)
        //    Response.Redirect("~/login.aspx", true);

        if (!Page.IsPostBack)
        {
            // populate Site drop down and set validation
            buildSiteDD();
            reqSites.ValidationExpression = MySession.strValidateDDSelectionAllowZero;

            // populate GridView
            buildGV();
        }

    }

    protected void buildSiteDD()
    {
        try
        {
            ddlSites.DataSource = ADRCIADAL.GetAAACILAgency();
            ddlSites.DataValueField = "AAACILSiteID";
            ddlSites.DataTextField = "AAACILSiteName";
            ddlSites.DataBind();
            ddlSites.Items.Insert(0, new ListItem("- All Agencies/Providers -", "0"));
            ddlSites.Items.Insert(0, new ListItem("- All Messages -", "-1"));

            //Added By KP on 2nd Apr 2020(TaskID:18464), To remove the AASA from dropdownlist.
            ListItem removeItem = ddlSites.Items.FindByText("AASA");
            if (removeItem != null)
                ddlSites.Items.Remove(removeItem);

        }
        catch { }
    }


    protected void buildGV()
    {
        gv1.DataSource = Messages.getADRCIAMessageList(int.Parse(ddlSites.SelectedValue));
        gv1.DataBind();
    }

    protected void gv1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        int intMessageID = int.Parse(gv1.DataKeys[e.NewEditIndex].Value.ToString());
        IDataReader rdr = Messages.getADRCIAMessage(intMessageID);
        if (rdr.Read())
        {
            hdnMessageID.Value = Sanitizer.GetSafeHtmlFragment(rdr["MessageID"].ToString());      //Modified by RK,01April2024,Task-ID: 24527,Purpose: Sanitization of data
            txtDateFrom.Text = DateTime.Parse(rdr["DateFrom"].ToString()).ToShortDateString();
            txtDateTo.Text = DateTime.Parse(rdr["DateTo"].ToString()).ToShortDateString();
            cbCritical.Checked = bool.Parse(rdr["Critical"].ToString());
            txtMessage.Text = Server.HtmlDecode(rdr["MessageText"].ToString());

            // if user selected a message from "All Messages", 
            // need to set Site DD to match clicked message, then rebuild grid
            if (ddlSites.SelectedValue == "-1")
            {
                ddlSites.SelectedValue = rdr["FKSiteID"].ToString();
                buildGV();
            }

        }
        rdr.Close();
        rdr.Dispose();

    }

    protected void gv1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        {
            Messages.deleteADRCIAMessage(int.Parse(gv1.DataKeys[e.RowIndex].Value.ToString()));
            clearForm();
            buildGV();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        // use Server.HtmlEncode on the txtMessage field to convert user-inputted html tags to &lt; "non-executable" format
        // then call functions.restrictHTML to convert allowed HTML tags back to < > format
        // any non-allowed html tags will NOT be "executed" when displayed on the site
        // this prevents cross-site scripting problems when validateRequest="false" 
        // (which is necessary in order to allow users to enter any HTML into form fields)
        
        Messages.setADRCIAMessage(int.Parse(hdnMessageID.Value), int.Parse(ddlSites.SelectedValue.ToString()),
                           Server.HtmlEncode(txtMessage.Text),
                            DateTime.Parse(txtDateFrom.Text), DateTime.Parse(txtDateTo.Text),
                            cbCritical.Checked);
        clearForm();
        buildGV();
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        clearForm();
        buildGV();
    }

    protected void clearForm()
    {
        hdnMessageID.Value = "0";
        txtDateFrom.Text = "";
        txtDateTo.Text = "";
        cbCritical.Checked = false;
        txtMessage.Text = "";
    }

    protected void gv1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gv1.PageIndex = e.NewPageIndex;
        buildGV();
    }
    protected void ddlSites_SelectedIndexChanged(object sender, EventArgs e)
    {
        buildGV();
    }
    protected void gv1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void gv1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[2].Attributes.Add("style", "word-wrap:break-word;");
            e.Row.Cells[3].Attributes.Add("style", "word-wrap:break-word;");
        }


    }
}
