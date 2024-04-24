using System;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ADRCIA
{
    public static class functions
    {
        public static string restrictHTML(string str)
        {
            StringBuilder sb = new StringBuilder(str);

            // selectively allow specific HTML tags
            // all "valid" HTML tags must be in this string array, except for BR and A tags, handled later
            // fsep letter should be fsep letter capitalized
            // that way, we can check for different capitalization (initial caps as in array, all upper, all lower)
            string[] validHTML = new string[6] { "B", "Strong", "I", "Em", "P", "U" };

            for (int i = 0; i < validHTML.Length; i++)
            {
                sb.Replace("&lt;" + validHTML[i] + "&gt;", "<" + validHTML[i].ToLower() + ">");
                sb.Replace("&lt;/" + validHTML[i] + "&gt;", "</" + validHTML[i].ToLower() + ">");

                sb.Replace("&lt;" + validHTML[i].ToLower() + "&gt;", "<" + validHTML[i].ToLower() + ">");
                sb.Replace("&lt;/" + validHTML[i].ToLower() + "&gt;", "</" + validHTML[i].ToLower() + ">");

                sb.Replace("&lt;" + validHTML[i].ToUpper() + "&gt;", "<" + validHTML[i].ToLower() + ">");
                sb.Replace("&lt;/" + validHTML[i].ToUpper() + "&gt;", "</" + validHTML[i].ToLower() + ">");
            }

            // handle BR tags (any other tags that are not used in pairs could be added here too)
            // </a> tag is included because <a> tag needs to be handled separately
            string[] validBR = new string[4] { "Br", "Br/", "Br /", "/a" };

            for (int i = 0; i < validBR.Length; i++)
            {
                sb.Replace("&lt;" + validBR[i] + "&gt;", "<" + validBR[i].ToLower() + ">");
                sb.Replace("&lt;" + validBR[i].ToLower() + "&gt;", "<" + validBR[i].ToLower() + ">");
                sb.Replace("&lt;" + validBR[i].ToUpper() + "&gt;", "<" + validBR[i].ToLower() + ">");
            }

            // handle quotes
            sb.Replace("&quot;", "\"");

            // handle A tags
            int intAOpenStart = -1;
            int intAOpenEnd = -1;

            intAOpenStart = sb.ToString().IndexOf("&lt;a");

            while (intAOpenStart != -1)
            {
                if (intAOpenStart != -1)
                {
                    intAOpenEnd = sb.ToString().IndexOf("&gt;", intAOpenStart);
                    sb.Replace("&gt;", ">", intAOpenEnd, 4);
                    sb.Replace("&lt;a", "<a", intAOpenStart, 5);
                }

                intAOpenStart = sb.ToString().IndexOf("&lt;a");
            }

            // finally, remove all other &lt; and &gt; to render other tags non-executable
            sb.Replace("&lt;", "");
            sb.Replace("&gt;", "");

            return sb.ToString();
        }

        // calls error handler dll
        public static void HandleError(string strURL, string strQueryString, Exception ex)
        {
            //ErrorHandler.ErrorHandler.HandleError(strURL, strQueryString,
            //                                    MySession.strErrDBConnString, 
            //                                    MySession.myWebConfig.environment,
            //                                    MySession.myWebConfig.applicationName, 
            //                                    MySession.myWebConfig.SMTPClient, 
            //                                    MySession.myWebConfig.blnLogErrors, 
            //                                    MySession.myWebConfig.blnEmailErrors,
            //                                    MySession.strUserName, ex);

        }

        // sets focus to fsep textbox within the control passed to the function
        public static void SetFirstTextboxFocus(Control ctrlContent)
        {
            foreach (Control c in ctrlContent.Controls)
            {
                if (c.GetType().ToString() == "System.Web.UI.WebControls.TextBox" || c.GetType().ToString() =="System.Web.UI.HtmlControls.HtmlInputText")
                {
                    c.Focus();
                    break;
                }
            }
        }

        // returns numeric portion a string that includes numeric value
        public static int ParseInt(string str)
        {
            char[] chars = str.ToCharArray();
            string numeric = "";

            for (int i = 0; i < chars.Length; i++)
            {
                if (CharIsNumeric(chars[i]))
                {
                    numeric += Convert.ToString(chars[i]);
                }
            }

            if (numeric != "")
                return Convert.ToInt32(numeric);
            else
                return 0;
        }

        // returns T/F whether character is a number
        public static bool CharIsNumeric(char c)
        {
            int charCode = Convert.ToInt32(c);

            if (charCode > 47 && charCode < 58)
                return true;
            else
                return false;
        }

        public static void SetTabAndPage(string[] strURL)
        {
            // set session vars for current tab and current page

            //Request.Url.Segments returns URL in an array (strURL[])
            // at the root dir of the app, resulting string[] looks like:
            //{Dimensions:[3]}
            //    [0]: "/"
            //    [1]: "LSIS/"
            //    [2]: "default.aspx"
            // on localhost, within the provider directory, resulting string[] looks like:
            //Request.Url.Segments
            //{Dimensions:[4]}
            //    [0]: "/"
            //    [1]: "LSIS/"
            //    [2]: "provider/"
            //    [3]: "default.aspx"

            // current dir may be blank (if not on a tab yet)
            // last char "/" needs to be stripped off dir, dir should be lowercase for later comparisons
            if (strURL.Length > 3)
            {
                int intDirIndex = strURL.Length - 2;	// length is 0 based, so need - 2 to get second to last element
                MySession.strCurrentTab = strURL[intDirIndex].Substring(0, strURL[intDirIndex].Length - 1).ToLower();
            }
            else
                MySession.strCurrentTab = "";

            // current page is always last string in array
            MySession.strCurrentPage = strURL[strURL.Length - 1].ToLower();
        }

        public static decimal TryParseDecimal(string inputValue, string valueWhenNull)
        {
            inputValue = inputValue ?? valueWhenNull;
            decimal returnedValue = 0;
            decimal.TryParse(inputValue, out returnedValue);
            return returnedValue;
        }

        public static string FormatPhone(string strPhone)
        {

            return string.Format("({0}) {1}-{2}",
                                strPhone.Substring(0, 3), strPhone.Substring(3, 3), strPhone.Substring(6));

        }

        public static string FormatYesNo(string strBool)
        {
            // following construct is used as If/Then/Else... if strBool is true, return Yes, else return No
            return ((bool.Parse(strBool)) ? "Yes" : "No");
        }

        public static string FormatPhoneForSave(string strPhone)
        {
            return strPhone.Replace("(", "").Replace(")", "").Replace("-", "");
        }

        public static void moveListBoxItem(ListBox lbSource, ListBox lbDest, ListItem li)
        {
            try
            {
                lbDest.Items.Add(li);
                lbSource.Items.Remove(li);
            }
            catch (Exception ex) { }
        }

        public static void moveListBoxItem(ListBox lbSource, ListBox lbDest, string strValues)
        {
            string[] strIDs = strValues.Split(',');

            if (lbSource != null && lbSource.Items.Count > 0)
            {
                for (int i = 0; i < strIDs.Length; i++)
                {
                    if (strIDs[i].Length > 0)
                    {
                        try
                        {
                            ListItem li = lbSource.Items.FindByValue(strIDs[i]);

                            lbDest.Items.Add(li);
                            lbSource.Items.Remove(li);
                        }
                        catch (Exception ex) { }
                    }
                }
            }

        }

        public static string getIDsfromListBox(ListBox lb)
        {
            string strIDs = "";

            if (lb != null && lb.Items.Count > 0)
            {
                // loop thru items in listbox and add to string
                for (int i = 0; i < lb.Items.Count; i++)
                    strIDs += lb.Items[i].Value + ",";

                // strip off final comma
                strIDs = strIDs.TrimEnd(',');

            }

            return strIDs;
        }

        public static string getItemsfromListBox(ListBox lb)
        {
            string strIDs = "";

            if (lb != null && lb.Items.Count > 0)
            {
                // loop thru items in listbox and add to string
                for (int i = 0; i < lb.Items.Count; i++)
                    strIDs += lb.Items[i].ToString() + ", ";

                // strip off final comma
                strIDs = strIDs.Trim().TrimEnd(',');

            }

            return strIDs;
        }

        public static string buildListBoxValuesString(ListBox lb)
        {
            string strValues = "";

            for (int i = 0; i < lb.Items.Count; i++)
            {
                strValues += lb.Items[i].Value + ",";
            }

            return strValues.Trim(',');
        }

        // This method returns the control that cause the postback to occur
        // For explanation see: http://www.eggheadcafe.com/articles/20050609.asp
        public static Control GetPostBackControl(System.Web.UI.Page page)
        {
            Control control = null;
            string ctrlname = page.Request.Params["__EVENTTARGET"];
            if (ctrlname != null && ctrlname != String.Empty)
            {
                control = page.FindControl(ctrlname);
            }
            // if __EVENTTARGET is null, the control is a button type and we need to 
            // iterate over the form collection to find it
            else
            {
                string ctrlStr = String.Empty;
                Control c = null;
                foreach (string ctl in page.Request.Form)
                {
                    // handle ImageButton controls ...
                    if (ctl.EndsWith(".x") || ctl.EndsWith(".y"))
                    {
                        ctrlStr = ctl.Substring(0, ctl.Length - 2);
                        c = page.FindControl(ctrlStr);
                    }
                    else
                    {
                        c = page.FindControl(ctl);
                    }
                    if (c is System.Web.UI.WebControls.Button ||
                             c is System.Web.UI.WebControls.ImageButton)
                    {
                        control = c;
                        break;
                    }
                }
            }
            return control;
        }

        public static void populateMonthsIntoDD(DropDownList ddl, string strDefaultValue)
        {
            System.Globalization.CultureInfo culture = new System.Globalization.CultureInfo("en-US");
            string[] strMonthNames = culture.DateTimeFormat.MonthNames;

            for (int i = 0; i < 12; i++)
            {
                ListItem li = new ListItem(strMonthNames[i].ToString(), (i + 1).ToString());
                ddl.Items.Add(li);
            }

            if (strDefaultValue.Length > 0)
                ddl.SelectedValue = strDefaultValue;
        }

        public static void populateMonthsIntoDD(DropDownList ddl, string strDefaultValue, ListItem liFirstItem)
        {
            ddl.Items.Add(liFirstItem);

            System.Globalization.CultureInfo culture = new System.Globalization.CultureInfo("en-US");
            string[] strMonthNames = culture.DateTimeFormat.MonthNames;

            for (int i = 0; i < 12; i++)
            {
                ListItem li = new ListItem(strMonthNames[i].ToString(), (i + 1).ToString());
                ddl.Items.Add(li);
            }

            if (strDefaultValue.Length > 0)
                ddl.SelectedValue = strDefaultValue;
        }

        public static void populateYearsIntoDD(DropDownList ddl, string strDefaultValue)
        {
            if (int.Parse(strDefaultValue) < 2007)
                strDefaultValue = "2007";

            int intCurrentFY = DateTime.Now.Year;

            if (DateTime.Now.Month >= 10)
                intCurrentFY++;

            for (int i = intCurrentFY; i >= 2007; i--)
            {
                ddl.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }

            if (strDefaultValue.Length > 0)
                ddl.SelectedValue = strDefaultValue;
        }

        public static void populateYearsIntoDD(DropDownList ddl, string strDefaultValue, ListItem liFirstItem)
        {
            ddl.Items.Add(liFirstItem);

            int intCurrentFY = DateTime.Now.Year;

            if (DateTime.Now.Month >= 10)
                intCurrentFY++;

            for (int i = intCurrentFY; i >= 2007; i--)
            {
                ddl.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }

            if (strDefaultValue.Length > 0)
                ddl.SelectedValue = strDefaultValue;
        }

        // returns a date representing fsep day of specified month/year
        public static string BuildStartDate(string strMonth, string strYear)
        {
            return strMonth + "/1/" + strYear;
        }

        // returns a date representing last day of specified month/year
        public static string BuildStopDate(string strMonth, string strYear)
        {
            DateTime dtStop = new DateTime(int.Parse(strYear), int.Parse(strMonth), 1);
            dtStop = dtStop.AddMonths(1);
            dtStop = dtStop.AddDays(-1);
            return dtStop.ToShortDateString();
        }

        public static bool DatesWithinOneFY(string strStartDate, string strStopDate)
        {
            DateTime dtStartDate = DateTime.Parse(strStartDate);
            DateTime dtStopDate = DateTime.Parse(strStopDate);

            int intFiscalYear = GetFYFromDate(dtStartDate);

            if (dtStopDate <= Convert.ToDateTime("09/30/" + intFiscalYear.ToString()))
                return true;
            else
                return false;
        }

        public static int GetFYFromDate(DateTime dt)
        {
            int intFiscalYear;

            if (dt.Month < 10)
                intFiscalYear = dt.Year;
            else
                intFiscalYear = dt.Year + 1;

            return intFiscalYear;
        }
        public static string GetSectionAbbrev(string strURL)
        {
            string strSectionAbbrev = "";

            string[] strURLParts = strURL.Split('/');
            string strPage = strURLParts[strURLParts.Length - 1];

            if (strPage.ToUpper().Contains("SECTION"))
            {
                strSectionAbbrev = strPage.Split('.')[0].ToUpper().Replace("SECTION", "");
            }

            return strSectionAbbrev;
        }

        public static string SanitizeString(string str)
        {
            str = str.Replace("'", "''");
            str = System.Web.HttpUtility.HtmlEncode(str);
            return str;
        }
    }
}