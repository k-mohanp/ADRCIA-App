using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
/// <summary>
/// Summary description for ADRCReport
/// </summary>
///

[Serializable()]
public class ADRCReport
{
    /*Report Type*/
    public dynamic ReportType { get; set; }
    public dynamic ReportTypeText { get; set; }
    public dynamic ReportingStyle { get; set; }
    public dynamic AdvanceFilter { get; set; }

    /*Common Filter*/
    public string Agency { get; set; }
    public string AgencyText { get; set; }
    public string County { get; set; }
    public string City { get; set; }
    public string Township { get; set; } // Added by GK on 15Apr19 : SOW-563
    public string TownshipText { get; set; }
    public string CustomField { get; set; } // Added by GK on 22Apr19 : SOW-563
    public string CustomFieldText { get; set; } // Added by GK on 22Apr19 : SOW-563
    public string Service { get; set; }
    public string ServiceText { get; set; }
    public string ReferredBy { get; set; }//Added on 26-11-2014. SOW-335. SA.
    public string ReferredByText { get; set; }//Added on 26-11-2014. SOW-335. SA.
    public string ReferredTo { get; set; }
    public string ReferredToText { get; set; }
    public string ReferredByOther { get; set; }//Added on 10-11-2014 - SA - SOW-335 
    public string ReferredToOther { get; set; }//Added on 12-30-2014 - SA - SOW-335 
    public string Staff { get; set; }
    public string DateRangeFrom { get; set; }
    public string DateRangeTo { get; set; }

    /*Details */
    public string GroupBy { get; set; }
    public string ContactMethod { get; set; }
    public string AgeFromToday { get; set; }

    public string AgeFromDate { get; set; }
    public string AgeAsOfList { get; set; }
    public string ContactType { get; set; }
    public string Gender { get; set; }
    public string MaritalStatus { get; set; }
    public string LivingArrangement { get; set; }
    public string Race { get; set; }
    public string VeteranApplicable { get; set; }
    public string VeteranStatus { get; set; }
    public string ServiceNeedMet { get; set; }
    public string FollowUpStatus { get; set; }
    public string Ethnicity { get; set; }

    /*
         Done by SA.
         Change in Age List as to parameterised each age list.
         24th July, 2K14.
    */

    public object A1 { get; set; }
    public object A2 { get; set; }
    public object A3 { get; set; }
    public object A4 { get; set; }
    public object A5 { get; set; }
    public object A6 { get; set; }
    public object A7 { get; set; }
    public object A8 { get; set; }
    public object A9 { get; set; }
    public object A10 { get; set; }
    public object A11 { get; set; }
    public object A12 { get; set; }
    public object A13 { get; set; }
    public object A14 { get; set; }
    public object AUnknown { get; set; }

    public string AgencyLength { get; set; }
    public string CountyLength { get; set; }
    public string CityLength { get; set; }
    public string TownshipLength { get; set; } // Added by GK on 15Apr19 : SOW-563
    public string CustomFieldLength { get; set; } // Added by GK on 22May19 : SOW-563
    public string ServiceLength { get; set; }
    public string RefLength { get; set; }
    public string RefByLength { get; set; }//Added on 26-11-2014. SOW-335. SA.
    public string StaffLength { get; set; }

    //Changes in Properties to get Controls Text
    public string ContactMethodText { get; set; }
    public string AgeAsOfText { get; set; }
    public string ContactTypeText { get; set; }
    public string GenderText { get; set; }
    public string MaritalStatusText { get; set; }
    public string LivingArrangementText { get; set; }
    public string RaceText { get; set; }
    public string PrimaryLanguage { get; set; }// Added on 30-12-2014. SOW-335
    public string VeteranApplicableText { get; set; }
    public string VeteranStatusText { get; set; }
    public string ServiceNeedMetText { get; set; }
    public string FollowUpText { get; set; }
    public string DateText { get; set; }
    public string EthnicityText { get; set; }
    public string StaffName { get; set; }

    //16th Sep change by SA for duplicate/unduplicate reporting condition.

    public dynamic IsInfoOnly { get; set; }
    public dynamic IsADRC { get; set; }
    //20th Aug change by SA for Referred for OC addition in advance report - sow-379.
    public string IsReferredForOC { get; set; }
    public string IsReferredForOCText { get; set; }
    public string IsReferredForOCDate { get; set; }
    public string IsReferredForOCDateTo { get; set; }
    //Changes end here............................

    //Added By KR on 22 March 2017
    public string IsFundProvided { get; set; }
    public string IsFundProvidedText { get; set; }
    public string IsFromAmount { get; set; }
    public string IsToAmount { get; set; }
    //Added By VK on 03 Aug 2017.
    public string FundsProvidedDateFrom { get; set; }
    public string FundsProvidedDateTo { get; set; }
    public string CaregiverNeedyPerson { get; set; }
    public string CaregiverNeedyPersonText { get; set; }
    public string CaregiverText { get; set; }
    public string FundsUtilizedfor { get; set; }
    public string FundsUtilizedforText { get; set; }

    public string IsDemographics { get; set; }//Added by KP on 28-Sep-2017 - SOW-485 
    public string IsDemographicsText { get; set; }//Added by KP on 29-Sep-2017 - SOW-485 

    //Added By KP on 3rd Jan 2020(SOW-577), To hold the Contact Type Info.
    public string ContactInfo { get; set; }    
    public string ProfessionalInfoText { get; set; }
    public string ProxyInfoText { get; set; }
    public string FamilyInfoText { get; set; }
    public string OtherInfoText { get; set; }
    public string CaregiverInfoText { get; set; }
    
    //Added By KP on 26th March 2020(SOW-577)
    public string OtherService { get; set; }
    public string OtherServiceLength { get; set; }

}

//Added by KP on 16th March 2020(SOW-577), Report Selection Properties
public class ReportSelectionFilter
{
    public string ReuestedIDs { get; set; }
    public bool IsNeedyReuested { get; set; }
    public bool IsCallHistoryReuested { get; set; }
    public bool IsContactPersonReuested { get; set; }
    public bool IsOptionCounsReuested { get; set; }    
}