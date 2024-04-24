using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ADRCIA;
using CrystalDecisions.Shared;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Web;
/// <summary>
/// Summary description for ReportSettings
/// </summary>
public class ReportSettings
{
    public ReportSettings()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static void setLoginInfo(ReportDocument reportDocument)
    {



        using (Sections ReportSections = reportDocument.ReportDefinition.Sections)
        {

            ReportObjects crReportObjects;
            SubreportObject crSubreportObject;
            ReportDocument crSubreportDocument;
            Database crDatabase;
            Tables crTables;
            string[] dbConParts = ((string)AISProtectData.DPAPI.UnProtectData(MySession.strAppDBConnString)).Split(';');
            CrystalDecisions.Shared.TableLogOnInfo myLogin;
            foreach (Section section in ReportSections)
            {
                crReportObjects = section.ReportObjects;

                foreach (ReportObject crReportObject in crReportObjects)
                {
                    if (crReportObject.Kind != ReportObjectKind.SubreportObject)
                        continue;

                    crSubreportObject = (SubreportObject)crReportObject;
                    crSubreportDocument = crSubreportObject.OpenSubreport(crSubreportObject.SubreportName);
                    crDatabase = crSubreportDocument.Database;
                    crTables = crDatabase.Tables;
                    foreach (CrystalDecisions.CrystalReports.Engine.Table myTable in crTables)
                    {
                        myLogin = myTable.LogOnInfo;
                        //Commented by PC on 24 Feb 2021, Purpose: To apply windows authentication
                        //myLogin.ConnectionInfo.Password = dbConParts[3].Split('=')[1];
                        //myLogin.ConnectionInfo.UserID = dbConParts[2].Split('=')[1];
                        myLogin.ConnectionInfo.IntegratedSecurity = true;
                        myLogin.ConnectionInfo.ServerName = dbConParts[0].Split('=')[1];
                        myLogin.ConnectionInfo.DatabaseName = dbConParts[1].Split('=')[1];
                        myTable.ApplyLogOnInfo(myLogin);
                    }
                }
            }

            CrystalDecisions.CrystalReports.Engine.Tables tables = reportDocument.Database.Tables;
            foreach (CrystalDecisions.CrystalReports.Engine.Table myTable in tables)
            {
                myLogin = myTable.LogOnInfo;
                //Commented by PC on 24 Feb 2021, Purpose: To apply windows authentication
                //myLogin.ConnectionInfo.Password = dbConParts[3].Split('=')[1];
                //myLogin.ConnectionInfo.UserID = dbConParts[2].Split('=')[1];
                myLogin.ConnectionInfo.IntegratedSecurity = true;
                myLogin.ConnectionInfo.ServerName = dbConParts[0].Split('=')[1];
                myLogin.ConnectionInfo.DatabaseName = dbConParts[1].Split('=')[1];
                myTable.ApplyLogOnInfo(myLogin);
            }


        }

    }



    public static ReportDocument SetParametersForExport(ReportDocument Report)
    {
        Report.FileName = HttpContext.Current.Server.MapPath("Report/" + ReportSettings.GetReportFileName());
        // setting DB login info (Credentials)
        ReportSettings.setLoginInfo(Report);
        // setting parameter values

        CrystalDecisions.CrystalReports.Engine.ParameterFieldDefinitions crParameterdef;
        crParameterdef = Report.DataDefinition.ParameterFields;

        for (int i = 0; i < crParameterdef.Count; i++)
        {
            if (crParameterdef[i].Name.Equals("@NeedyPersonID") || crParameterdef[i].Name.Equals("@NeedyPersonID"))    // check if parameter exists in report            
                Report.SetParameterValue(i, Convert.ToInt32(HttpContext.Current.Session["PrintNeedyId"]));  // set the parameter value in the report
            if (crParameterdef[i].Name.Equals("@CallHistoryID"))    // check if parameter exists in report            
                Report.SetParameterValue(i, Convert.ToInt32(HttpContext.Current.Session["PrintCallHistoryId"]));  // set the parameter value in the report
            if (crParameterdef[i].Name.Equals("@ContactHistoryID"))    // check if parameter exists in report            
                Report.SetParameterValue(i, Convert.ToInt32(HttpContext.Current.Session["PrintCallHistoryId"]));  // set the parameter value in the report
            if (crParameterdef[i].Name.Equals("CheckboxImagePath"))    // check if parameter exists in report            
                Report.SetParameterValue(i, HttpContext.Current.Server.MapPath(@"~/Images/"));    // set the parameter value in the report



        }


        return Report;
    }

    public static void SetParametersForReportViewer(CrystalReportViewer crvReport)
    {
        ParameterFields paramFields = new ParameterFields(); // Added by PC on 3 July 2019 for Task Id: 15719
        for (int i = 0; i < crvReport.ParameterFieldInfo.Count; i++)
        {
            if (crvReport.ParameterFieldInfo[i].Name == "@NeedyPersonID" || crvReport.ParameterFieldInfo[i].Name == "@NeedyPersonID")
            {
                ParameterField f1 = crvReport.ParameterFieldInfo[i];
                ParameterDiscreteValue v1 = new ParameterDiscreteValue();
                v1.Value = Convert.ToInt32(HttpContext.Current.Session["PrintNeedyId"]); // input field
                f1.CurrentValues.Add(v1);
                paramFields.Add(f1); // Added by PC on 3 July 2019 for Task Id: 15719
            }

            if (crvReport.ParameterFieldInfo[i].Name == "@CallHistoryID")
            {
                ParameterField FCallHistory = crvReport.ParameterFieldInfo[i];
                ParameterDiscreteValue VCallHistory = new ParameterDiscreteValue();
                VCallHistory.Value = Convert.ToInt32(HttpContext.Current.Session["PrintCallHistoryId"]); // input field
                FCallHistory.CurrentValues.Add(VCallHistory);
                paramFields.Add(FCallHistory); // Added by PC on 3 July 2019 for Task Id: 15719
            }
            if (crvReport.ParameterFieldInfo[i].Name == "@ContactHistoryID")
            {
                ParameterField FContactHistoryID = crvReport.ParameterFieldInfo[i];
                ParameterDiscreteValue VContactHistoryID = new ParameterDiscreteValue();
                VContactHistoryID.Value = Convert.ToInt32(HttpContext.Current.Session["PrintCallHistoryId"]); // input field
                FContactHistoryID.CurrentValues.Add(VContactHistoryID);
                paramFields.Add(FContactHistoryID); // Added by PC on 3 July 2019 for Task Id: 15719
            }
            if (crvReport.ParameterFieldInfo[i].Name == "CheckboxImagePath")
            {
                ParameterField CheckboxImagePathField = crvReport.ParameterFieldInfo[i];
                ParameterDiscreteValue CheckboxImagePathVal = new ParameterDiscreteValue();
                CheckboxImagePathVal.Value = HttpContext.Current.Server.MapPath(@"~/images/");
                CheckboxImagePathField.CurrentValues.Add(CheckboxImagePathVal);
                paramFields.Add(CheckboxImagePathField); // Added by PC on 3 July 2019 for Task Id: 15719
            }
        }
        crvReport.ParameterFieldInfo = paramFields; // Added by PC on 3 July 2019 for Task Id: 15719
    }
    public static string GetReportFileName()
    {
        string ReportFile = "rptPrintNeedy.rpt";
        return ReportFile;
    }

}