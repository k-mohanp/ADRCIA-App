using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using ADRCIA;
public partial class Admin_FollowupSetting : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!MySession.blnADRCIAOSAAdmin)
        //    Response.Redirect("~/login.aspx", true);


        if (!IsPostBack)
        GetFollowUpEmailConfig();
    }

   /// <summary>
   /// Created By: SM
   /// Date:07/10/2013
   /// Purpose:Get followw-up Email Configuration.
   /// </summary>
  private  void GetFollowUpEmailConfig()
    {
        DataTable dtFollowup = ADRCIA.ADRCIADAL.GetFollowUpEmailConfiguration();
        if (dtFollowup.Rows.Count > 0)
        {
            txtPriorDay.Text=Convert.ToString(dtFollowup.Rows[0]["PriorDay"]);
            
            chkFollowUpActive.Checked = Convert.ToBoolean(dtFollowup.Rows[0]["IsFollowUPActive"]);
        }

    }
    
    protected void txtPriorDay_TextChanged(object sender, EventArgs e)
    {

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {

        if (ADRCIA.ADRCIADAL.SetFollowUpEmailConfiguration(Convert.ToInt32(txtPriorDay.Text), chkFollowUpActive.Checked))
            ScriptManager.RegisterStartupScript(this, GetType(), "Saved", "alert('Follow up saved successfully.');", true);
        else
            ScriptManager.RegisterStartupScript(this, GetType(), "SavedFail", "alert('Follow up not saved.');", true);
    }
}