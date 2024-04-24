<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="MergeDuplicatePerson.aspx.cs" Inherits="Admin_MergeDuplicatePerson" %>

<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <style>
        .r-wrap label {
            margin-left: 10px;
        }
    </style>
    <div class="search_heading">
        Search Person Needing Assistance
    </div>
    <div class="main_search">
        <table width="80%" border="0" cellpadding="0" cellspacing="0" align="center" style="margin: 0 auto;">
            <tr>
                <td align="center">Agency :
                   
                <select name="ctl00$MainContent$ddlAAACILName" id="MainContent_ddlAAACILName">
                    <option value="-1">--All--</option>
                    <option value="0">OSA</option>
                    <option value="2684">A-1 Nursing Services, LLC</option>
                    <option value="26526">Aalska</option>
                    <option value="22534">Adults Prescibed Dosage</option>
                    <option value="8085">Aegin  Place of West Michigan</option>
                    <option value="18515">AIS_New_ResourTestt Site @#!@$%^##HJHJFHFHDUF4578845889__DSdbftsibr te7itr6</option>
                    <option value="9464">AIS_New_Site</option>
                    <option value="26527">Alaska1</option>
                    <option value="206">Alcona County Commission On Aging</option>
                    <option value="506">Alger County COA</option>
                    <option value="29530">Amaze_Stars</option>
                    <option value="7988">Angel Home Care</option>
                    <option value="8738">Ann Arbor Center for Independent Living</option>
                    <option value="2628">Arcadia Health Services of Marquette</option>
                    <option value="270">Area Agency on Aging  of Western MI, Inc.</option>
                    <option value="428">Area Agency On Aging 1-B</option>
                    <option value="268">Area Agency On Aging of Northwest MI, Inc.</option>
                    <option value="9404">Area Agency OSA MI_Site</option>
                    <option value="540">Association of Chinese Americans</option>
                    <option value="22531">Barista</option>
                    <option value="29528">bingo123</option>
                    <option value="452">Blue Water Center for Independent Living</option>
                    <option value="9022">Blue Water Center for Independent Living - Huron Office</option>
                    <option value="9023">Blue Water Center for Independent Living - Tuscola</option>
                    <option value="9024">Blue Water Center for Independent Living-Lapeer</option>
                    <option value="9025">Blue Water Center for Independent Living-Sandusky</option>
                    <option value="8856">Boyne Area Senior Center</option>
                    <option value="907">Branch-St. Joseph Area Agency on Aging 3-C</option>
                    <option value="2861">C.A.U.S.E.</option>
                    <option value="8748">Capital Area Center for Independent Living</option>
                    <option value="9047">Catholic Charities of Southeast MI</option>
                    <option value="328">Central Office/Metro Detroit</option>
                    <option value="9309">check AAA</option>
                    <option value="9313">child Care center</option>
                    <option value="14514">Child_Funding</option>
                    <option value="9348">Cisco site</option>
                    <option value="9438">CT Site 2</option>
                    <option value="8305">dba-Mom's Meals</option>
                    <option value="9329">delete site </option>
                    <option value="9287">details</option>
                    <option value="891">Detroit Area Agency on Aging</option>
                    <option value="9392">Detroit resource Agency</option>
                    <option value="481">Dickinson-Iron CAA--Main office</option>
                    <option value="8742">Disability Advocates of Kent County</option>
                    <option value="8751">Disability Connection West michigan</option>
                    <option value="6467">Disability Connections Main Office - Jackson</option>
                    <option value="9305">Disability Connections Main Office - Test jack</option>
                    <option value="8745">Disability Network Lakeshore</option>
                    <option value="8739">Disability Network Oakland &amp; Macomb - Macomb Office</option>
                    <option value="9019">Disability Network Oakland &amp; Macomb - Oakland Office</option>
                    <option value="8750">Disability Network of Mid Michigan</option>
                    <option value="8752">Disability Network of Northern Michigan</option>
                    <option value="8746">Disability Network Southwest MI - Main Office</option>
                    <option value="9021">Disability network Southwest MI Berrien/Cass Office</option>
                    <option value="8740">Disability Network Wayne County-Detroit</option>
                    <option value="8792">Farwell Recreation Center</option>
                    <option value="319">HHS, Health Options for Life</option>
                    <option value="9312">Human care</option>
                    <option value="68">Jewish Vocational Services</option>
                    <option value="22533">Johansberg</option>
                    <option value="981">Macomb-Oakland Regional Center, Inc.</option>
                    <option value="2492">Marquette Senior Day Care</option>
                    <option value="2616">Medicare Medicaid Assistance Program (MMAP)</option>
                    <option value="9285">Michigan Medical2</option>
                    <option value="9468">Michigan Site of Adults</option>
                    <option value="22532">Mohali</option>
                    <option value="9048">Monroe Center for Independent Living</option>
                    <option value="9296">name 23</option>
                    <option value="16520">Napis Pub AAA Site</option>
                    <option value="27526">Neighbour Site</option>
                    <option value="9389">new resource for test</option>
                    <option value="9310">New Test Site 23</option>
                    <option value="9454">New_Site_Special_grants</option>
                    <option value="9304">next date</option>
                    <option value="903">Northeast MI Community Service Agency</option>
                    <option value="984">Northern Health Care Management</option>
                    <option value="983">Northern Michigan Regional Health System</option>
                    <option value="682">Ogemaw County Commission On Aging</option>
                    <option value="12514">Partner Channel for test</option>
                    <option value="910">Region 2 Area Agency on Aging</option>
                    <option value="909">Region 3-A Area Agency on Aging_Kalamazoo County Health and Community Servi</option>
                    <option value="525">Region 3-B - Battle Creek site</option>
                    <option value="906">Region IV Area Agency on Aging, Inc.</option>
                    <option value="277">Region VII Area Agency on Aging</option>
                    <option value="9391">Resource 18 Feb 2015</option>
                    <option value="12513">Resource New AAA Agency</option>
                    <option value="9398">Resource_AAA_VEX</option>
                    <option value="9405">Resource_Default Site</option>
                    <option value="9399">Resource_test FIRST VEX 1</option>
                    <option value="9400">Resource_test FIRST VEX 2</option>
                    <option value="297">Restoration Towers</option>
                    <option value="23525">Revenew of Store</option>
                    <option value="1449">RSVP of Monroe County/Bedford Public Schools</option>
                    <option value="24">Senior Neighbors, Inc.</option>
                    <option value="214">Senior Resources</option>
                    <option value="133">Senior Services Inc. (Kalamazoo Site)PA</option>
                    <option value="130">Senior Support Services</option>
                    <option value="25527">Site 1</option>
                    <option value="9465">Site 123</option>
                    <option value="9503">Site name 123_Area Agency on resource name with site 123</option>
                    <option value="13514">Site October 19</option>
                    <option value="9387">Site of Michigan</option>
                    <option value="9439">site@123</option>
                    <option value="9472">Site_Area Agency 1-P_New</option>
                    <option value="9441">Site_MM1_Resource 1</option>
                    <option value="9426">site789</option>
                    <option value="9352">SSSSSSSSS</option>
                    <option value="7775">State Line Medical</option>
                    <option value="8749">Superior Alliance for Independent Living</option>
                    <option value="21554">teeming</option>
                    <option value="28532">test</option>
                    <option value="23527">test site</option>
                    <option value="9388">test Site FIRST resource</option>
                    <option value="9362">Test site of Ann Arbor </option>
                    <option value="9384">Test Site Resource</option>
                    <option value="9385">Test Site Resource 1</option>
                    <option value="14513">Test User site 2016</option>
                    <option value="22535">test_site_test</option>
                    <option value="28536">Testing_123</option>
                    <option value="9502">Testing_Resource_Site</option>
                    <option value="27527">TestSiteVendor</option>
                    <option value="8741">The Disability Network</option>
                    <option value="9150">The Gathering Place</option>
                    <option value="62">The Information Center</option>
                    <option value="21556">The New Site</option>
                    <option value="323">The Senior Alliance</option>
                    <option value="904">Tri-County Office on Aging</option>
                    <option value="9469">U.P. New Site </option>
                    <option value="28535">United Nation of America</option>
                    <option value="902">UPCAP Services, Inc. </option>
                    <option value="8048">Upper Peninsula</option>
                    <option value="286">Valley Area Agency On Aging</option>
                    <option value="2927">Valley Services, Inc.</option>
                    <option value="9448">Vendor Site</option>
                    <option value="28526">vendorSite</option>
                    <option value="9395">VEX_Resource 1</option>
                    <option value="9397">VIS_RSVP Resource 1</option>
                    <option value="29529">Volgan345</option>
                    <option value="9462">Volunteer_SIte</option>
                    <option value="799">Washtenaw County ETCS Group</option>
                    <option value="2231">Westside Center</option>
                    <option value="29526">ZD1</option>
                    <option value="29527">ZD2</option>

                </select>
                </td>
            </tr>
            <tr>
                <td>&nbsp;&nbsp;&nbsp;</td>
            </tr>
            <tr>
                <td style="text-align: center; width: 100%">
                    <div style="width: 540px; margin: 0 auto">
                        <asp:RadioButtonList CssClass="r-wrap" ID="RadioButtonList1" runat="Server" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Search By Person Needy Assistance ID" Value="Search By Person Needy Assistance ID"></asp:ListItem>
                            <asp:ListItem Text="Search By Person Needy Assistance Name" Value="Search By Person Needy Assistance Name"></asp:ListItem>

                        </asp:RadioButtonList>
                    </div>
                </td>
            </tr>
            <tr>
                <td>&nbsp;&nbsp;&nbsp;</td>
            </tr>
            <tr id="rwUpdateCall">
                <td id="colUpdateCall" align="center" style="border: 1px currentColor; border-image: none; background-color: rgb(26, 138, 216);">
                    <label id="lblUpdateMessage" style="color: White">Search Person Needing Assistance </label>
                </td>
                <td></td>
            </tr>
            <tr>
                <td>
                    <div id="SearchByName">
                        <fieldset>
                            <legend>Person Needing Assistance</legend>
                            <div align="center">
                                <table align="center" border="0" cellspacing="0" cellpadding="0">
                                    <tbody>
                                        <tr>
                                            <td align="left">





                                                <span class="search_label">From Needy ID:</span>

                                                <input class="search_name watermark" style="width: 150px;" type="text" maxlength="50" />
                                            </td>

                                            <td align="center">
                                                <span class="second_opt">And</span>
                                            </td>

                                            <td align="left">
                                                <span class="search_label">To Needy ID:</span>

                                                <input class="search_name watermark" style="width: 150px;" type="text" maxlength="50" />
                                            </td>


                                            <td>&nbsp; 
                                    </td>
                                        </tr>

                                    </tbody>
                                </table>
                            </div>
                        </fieldset>
                    </div>

                </td>
                <td></td>
            </tr>
            <tr>
                <td>
                    <div id="SearchByID">
                        <fieldset>
                            <legend>From</legend>
                            <div align="center">
                                <table align="center" border="0" cellspacing="0" cellpadding="0">
                                    <tbody>
                                        <tr>
                                            <td align="left">
                                                <span class="search_label">First Name:</span>

                                                <input class="search_name watermark" style="width: 150px;" type="text" maxlength="50" />
                                            </td>

                                            <td align="center">
                                                <span class="second_opt">And</span>
                                            </td>

                                            <td align="left">
                                                <span class="search_label">Middle Name:</span>

                                                <input class="search_name watermark" style="width: 150px;" type="text" maxlength="50" />
                                            </td>
                                            <td align="center">
                                                <span class="second_opt">And</span>
                                            </td>
                                            <td align="left">
                                                <span class="search_label">Last Name:</span>

                                                <input class="search_name watermark" style="width: 150px;" type="text" maxlength="50" />
                                            </td>
                                            <td>&nbsp; 
                                    </td>
                                        </tr>

                                    </tbody>
                                </table>
                            </div>
                        </fieldset>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div>
                        <fieldset>
                            <legend>To</legend>
                            <div align="center">
                                <table align="center" border="0" cellspacing="0" cellpadding="0">
                                    <tbody>
                                        <tr>
                                            <td align="left">
                                                <span class="search_label">First Name:</span>

                                                <input class="search_name watermark" style="width: 150px;" type="text" maxlength="50" />
                                            </td>

                                            <td align="center">
                                                <span class="second_opt">And</span>
                                            </td>

                                            <td align="left">
                                                <span class="search_label">Middle Name:</span>

                                                <input class="search_name watermark" style="width: 150px;" type="text" maxlength="50" />
                                            </td>
                                            <td align="center">
                                                <span class="second_opt">And</span>
                                            </td>
                                            <td align="left">
                                                <span class="search_label">Last Name:</span>

                                                <input class="search_name watermark" style="width: 150px;" type="text" maxlength="50" />
                                            </td>
                                            <td>&nbsp; 
                                    </td>
                                        </tr>
                                        <tr>
                                            <td align="right" colspan="6">
                                                <input id="btnSearch" type="button" name="btnShowAll" value="Search" class="btn_styleSearch" />
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </fieldset>
                    </div>
                </td>
            </tr>

        </table>
    </div>

    <div class="search_result">
        <div class="no-found">
            <label id="lblNoRecord" style="display: none;">
                No Record Found.</label>
        </div>

        <table width="98%" class="sub_hearder" id="grdSearchbyNeedy" style="margin: 0px auto; display: table; border-collapse: collapse;" border="1" cellspacing="0" cellpadding="0">
            <thead id="Thead1">

                <tr id="Tr1">


                    <th width="8%" class="header">Merge Into
                    </th>
                    <th width="8%" class="header">Merge From
                    </th>

                    <th width="9%" class="header">Needy Person ID
                    </th>
                    <th width="11%" class="header">First Name
                    </th>
                    <th width="11%" class="header">Middle Name
                    </th>
                    <th class="header" width="12%">Last Name</th>
                    <th class="header" width="7%">DOB</th>
                    <th width="12%">Phone-Primary</th>

                </tr>
            </thead>

            <tbody>
                <tr>
                    <td style="text-align: center">
                        <input type="radio" /></td>
                    <td style="text-align: center">
                        <input type="checkbox" /></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>

            </tbody>
        </table>

    </div>
    <div style="width:80%;margin:0 auto;text-align:center">
        <input class="btn_style" id="btnRunReport" type="button" value="Merge" />
    </div>
</asp:Content>

