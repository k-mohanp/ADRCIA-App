using System.Web.Optimization;

public class BundleConfig
{
    public static void RegisterBundles(BundleCollection bundles)
    {
        #region bundles with new version (2022) 
        //(default)
        bundles.Add(new ScriptBundle("~/Scripts/Default").Include(
              "~/Scripts/jquery-3.6.0.min.js",
              "~/Scripts/jquery.tablesorter.min-2.31.3.js",
               "~/Scripts/jquery-ui.min.js",
               "~/Scripts/jquery.ui.widget.js",
               "~/Scripts/jquery.ui.dialog.js",
               "~/Scripts/common_functions.js",
               "~/Scripts/progressbar_mini.js",
               "~/Scripts/jquery.textarearesizer.compressed.js",
               "~/Scripts/MaskedEditFix.js",
               "~/Scripts/json2.js",
               "~/Scripts/CustomAlert.js",
               "~/Scripts/ajaxLogout.js"   //Added by: AR, 14-Nov-2023(SOW-654)
        ));


        //(default css) 
        bundles.Add(new StyleBundle("~/Content/Default").Include(
           "~/Content/template.css",
           "~/Content/sessionpopup.css"
       ));

        #region Admin Bundle
        bundles.Add(new ScriptBundle("~/Scripts/AdminDefault").Include(
              "~/Scripts/jquery-3.6.0.min.js",
              "~/Scripts/jquery.tablesorter.min-2.31.3.js",
              "~/Scripts/progressbar_mini.js",
              "~/Scripts/jquery.ui.widget.js",
              "~/Scripts/jquery.ui.dialog.js",
              "~/Scripts/json2.js",
              "~/Scripts/common_functions.js",
              "~/Scripts/ajaxLogout.js"   //Added by: AR, 14-Nov-2023(SOW-654)              
        ));

        #endregion
        #region NeedyPerson
        bundles.Add(new ScriptBundle("~/Scripts/NeedPerson").Include(                
              "~/Scripts/jquery.multiselect.js",
              "~/Scripts/jquery.multiselect.filter.js",
              "~/Scripts/DateValidation.js",
              "~/Scripts/prettify.js",
              "~/Scripts/CommonValidator.js",
              "~/Scripts/jquery.mcautocomplete.js",
              "~/Scripts/ModalPopupWindow.js"              
        ));
        //Need Person css
        bundles.Add(new StyleBundle("~/Content/NeedPerson").Include(
           "~/Content/jQueryUI.css",
           "~/Content/jquery.multiselect.css",
           "~/Content/jquery.multiselect.filter.css",
           "~/Content/style.css",
           "~/Content/prettify.css"
       ));
        #endregion
        #endregion
        #region Bundle with Old Files 
        // bundles.Add(new ScriptBundle("~/Scripts/Default").Include(
        //      "~/Scripts/jquery-1.9.1.min.js",
        //       "~/Scripts/jquery-ui.min.js",
        //       "~/Scripts/jquery.ui.widget.js",
        //       "~/Scripts/jquery.ui.dialog.js",
        //       "~/Scripts/common_functions.js",
        //       "~/Scripts/progressbar_mini.js",
        //       "~/Scripts/jquery.textarearesizer.compressed.js",
        //       "~/Scripts/MaskedEditFix.js",
        //       "~/Scripts/json2.js",
        //       "~/Scripts/jquery-1.11.1.min.js",
        //       "~/Scripts/CustomAlert.js"
        //));

        //bundles.Add(new ScriptBundle("~/Scripts/AdminDefault").Include(
        //      "~/Scripts/progressbar_mini.js",
        //      "~/Scripts/jquery-1.9.1.min.js",
        //      "~/Scripts/progressbar_mini.js",
        //      "~/Scripts/jqueryUI.1.9.2.js",
        //      "~/Scripts/jquery.ui.widget.js",
        //      "~/Scripts/jquery.ui.dialog.js",
        //      "~/Scripts/json2.js",
        //      "~/Scripts/common_functions.js",
        //      "~/Scripts/jquery-1.11.1.min.js"
        //));

        //bundles.Add(new ScriptBundle("~/Scripts/NeedPerson").Include(
        //      "~/Scripts/jquery.js",
        //      "~/Scripts/jquery-ui.min.js",
        //      "~/Scripts/jquery.textarearesizer.compressed.js",
        //      "~/Scripts/MaskedEditFix.js",
        //      "~/Scripts/jquery.multiselect.js",
        //      "~/Scripts/jquery.multiselect.filter.js",
        //      "~/Scripts/jquery.tablesorter.min.js",
        //      "~/Scripts/DateValidation.js",
        //      "~/Scripts/progressbar_mini.js",
        //      "~/Scripts/prettify.js",
        //      "~/Scripts/CommonValidator.js",
        //      "~/Scripts/jquery.mcautocomplete.js"
        //));
        #endregion

        BundleTable.EnableOptimizations = true;
    }
}