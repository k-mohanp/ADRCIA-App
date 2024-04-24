using ADRCIA;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_MergePersonNeedyAssistance : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!MySession.blnADRCIAOSAAdmin)
        //    Response.Redirect("~/login.aspx", true);

        if (!Page.IsPostBack)
        {
            try
            {
                // populate Agency List from db.
                BindAgencyList();

                //gvNeedyPerson.DataSource = null;
                //gvNeedyPerson.DataBind();

                //btnMerge.Visible = false;
                //btnMerge.Attributes.Add("disabled", "true");
                btnMerge.Enabled = false;
                divpnlContact2.Attributes.Add("display", "none");
            }
            catch (Exception ex)
            {
                var msgShow = ex.Message;
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "clientScript", "ShowAlert('" + msgShow.Replace("\'", "").Replace("\r", "").Replace("\n", "") + " \\r\\nPlease try again!');", true);
            }
        }
    }

    void BindAgencyList()
    {
        ddlAgency.DataSource = ADRCIADAL.GetAAACILAgency();
        ddlAgency.DataValueField = "AAACILSiteID";
        ddlAgency.DataTextField = "AAACILSiteName";
        ddlAgency.DataBind();
        ddlAgency.Items.Insert(0, new ListItem("-- Select --", "-1")); // Agency is required field
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        //btnMerge.Visible = false;
        //btnMerge.Attributes.Add("disabled", "true");
        btnMerge.Enabled = false;
        try
        {
            int AgencyID;
            int? NeedyPersonIdFrom = null, NeedyPersonIdTo = null;
            string FirstNameFrom = null, MiddleNameFrom = null, LastNameFrom = null, FirstNameTo = null, MiddleNameTo = null, LastNameTo = null;
            var dList = new DataTable();

            if (ddlAgency.SelectedValue == "-1")
            {
                ddlAgency.Focus();
                throw new ArgumentException("Please select an Agency.");
            }

            AgencyID = Convert.ToInt32(ddlAgency.SelectedValue);

            if (rblSearchBy.SelectedValue == "1") // Search By Person Needing Assistance ID
            {
                if (!string.IsNullOrWhiteSpace(txtNeedyIdFrom.Text) && !string.IsNullOrWhiteSpace(txtNeedyIdTo.Text))
                {
                    NeedyPersonIdFrom = Convert.ToInt32(txtNeedyIdFrom.Text);
                    NeedyPersonIdTo = Convert.ToInt32(txtNeedyIdTo.Text);

                    dList = ADRCIADAL.GetPersonNeedyListForMerge(AgencyID, NeedyPersonIdFrom, NeedyPersonIdTo, null, null, null, null, null, null);
                }
            }
            else // Search By Person Needing Assistance Name
            {
                if (!string.IsNullOrWhiteSpace(txtFirstNameFrom.Text)) FirstNameFrom = txtFirstNameFrom.Text.Trim();
                if (!string.IsNullOrWhiteSpace(txtLastNameFrom.Text)) LastNameFrom = txtLastNameFrom.Text.Trim();

                if (!string.IsNullOrWhiteSpace(txtMiddleNameFrom.Text) && !string.IsNullOrWhiteSpace(txtFirstNameFrom.Text)
                    && !string.IsNullOrWhiteSpace(txtLastNameFrom.Text))
                    MiddleNameFrom = txtMiddleNameFrom.Text.Trim();

                if (!string.IsNullOrWhiteSpace(txtFirstNameTo.Text)) FirstNameTo = txtFirstNameTo.Text.Trim();
                if (!string.IsNullOrWhiteSpace(txtLastNameTo.Text)) LastNameTo = txtLastNameTo.Text.Trim();

                if (!string.IsNullOrWhiteSpace(txtMiddleNameTo.Text) && !string.IsNullOrWhiteSpace(txtFirstNameTo.Text)
                    && !string.IsNullOrWhiteSpace(txtLastNameTo.Text)) MiddleNameTo = txtMiddleNameTo.Text.Trim();

                if (FirstNameFrom != null || LastNameFrom != null || FirstNameTo != null || LastNameTo != null)
                    dList = ADRCIADAL.GetPersonNeedyListForMerge(AgencyID, null, null, FirstNameFrom, MiddleNameFrom,
                        LastNameFrom, FirstNameTo, MiddleNameTo, LastNameTo);
            }

            if (dList.Rows.Count > 1)
            {
                //btnMerge.Visible = true;
                //btnMerge.Attributes.Remove("disabled");
                btnMerge.Enabled = true;
            }

            gvNeedyPerson.DataSource = dList;
            gvNeedyPerson.DataBind();
            gvNeedyPerson.Visible = true;
        }
        catch (Exception ex)
        {
            var msgShow = ex.Message;
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "clientScript", "ShowAlert('" + msgShow.Replace("\'", "").Replace("\r", "").Replace("\n", "") + " \\r\\nPlease try again!');", true);
        }
    }

    protected void btnMerge_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddlAgency.SelectedValue == "-1")
            {
                ddlAgency.Focus();
                throw new ArgumentException("Please select an Agency.");
            }

            if (gvNeedyPerson.Rows.Count == 0)
                throw new ArgumentException("No record found to merge.");

            int? mergeInto = null;
            var listMergeFrom = new List<int>();

            foreach (GridViewRow r in gvNeedyPerson.Rows)
            {
                if ((r.FindControl("rbMergeInto") as RadioButton).Checked)
                    mergeInto = Convert.ToInt32(gvNeedyPerson.DataKeys[r.RowIndex]["NeedyPersonID"]);

                if ((r.FindControl("cbMergeFrom") as CheckBox).Checked)
                    listMergeFrom.Add(Convert.ToInt32(gvNeedyPerson.DataKeys[r.RowIndex]["NeedyPersonID"]));
            }

            if (mergeInto == null) throw new ArgumentException("Please select Merge Into.");
            if (listMergeFrom.Count == 0) throw new ArgumentException("Please select Merge From.");

            int retVal = ADRCIADAL.MergeDuplicateNeedyPerson((int)mergeInto, listMergeFrom);
            if (retVal > 0)
            {
                var message = "Merged successfully.";
                ScriptManager.RegisterStartupScript(this, GetType(), "clientScript1", "ShowAlert('" + message + "','S');", true);

                btnSearch_Click(null, null);
            }
        }
        catch (Exception ex)
        {
            var msgShow = ex.Message;
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "clientScript", "ShowAlert('" + msgShow.Replace("\'", "").Replace("\r", "").Replace("\n", "") + " \\r\\nPlease try again!');", true);
        }
    }

    protected void ddlAgency_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            gvNeedyPerson.DataSource = null;
            gvNeedyPerson.DataBind();

            gvNeedyPerson.Visible = false;
            btnMerge.Enabled = false;
        }
        catch (Exception ex)
        {
            var msgShow = ex.Message;
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "clientScript", "ShowAlert('" + msgShow.Replace("\'", "").Replace("\r", "").Replace("\n", "") + " \\r\\nPlease try again!');", true);
        }
    }
}
