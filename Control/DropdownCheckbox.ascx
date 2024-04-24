<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DropdownCheckbox.ascx.cs" Inherits="Control_DropdownCheckbox" %>

<%--<script src="Scripts/jquery-1.11.1.js"></script>--%>
<link rel="stylesheet" type="text/css" href="assets/jquery.multiselect.css" />
<link rel="stylesheet" type="text/css" href="assets/jquery.multiselect.filter.css" />
<link rel="stylesheet" type="text/css" href="assets/style.css" />
<link rel="stylesheet" type="text/css" href="assets/prettify.css" />
<link href="../assets/jQueryUI.css" rel="stylesheet" />
<script type="text/javascript" src="src/jquery.multiselect.js"></script>
<script type="text/javascript" src="src/jquery.multiselect.filter.js"></script>
<script type="text/javascript" src="assets/prettify.js"></script>
<script type="text/javascript" src="Scripts/json2.js"></script>
<script type="text/javascript">

    $(function () {

        getRefferedTo();

        $("#chkList").multiselect().multiselectfilter();
        $("input[name=multiselect_chkList]:eq(0)").prop("checked", false);

        bindCheckList();

        setHeaderText();
        GetCheckboxValues();


    });
    
    function setHeaderText()
    {
        var values = GetCheckboxText();
        $("#btnHeader").html(GetCheckboxText());
    }

    function getRefferedTo() {

        $.ajax({
            type: "POST",
            url: "NeedyPerson.aspx/GetRefferedTo",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{}",
            async: false,
            success: function (data) {
                var Result = JSON.parse(data.d);
                $.each(Result, function (key, value) {

                    $("#chkList").append("<option value=" + value.Value + ">" + value.Key + "</option>");

                });
            },

            error: function () {

                alert('Failed to retrieve data.');
            }
        });
    }


    function bindCheckList() {

        var items = "9008,9037,9048,9058";

        $('input[name=multiselect_chkList]').each(function (index) {

            if (items.indexOf($(this).val()) != -1) {

                $(this).attr('checked', true);
            }
        });
    }

    function GetCheckboxValues() {

        var chkValues = $('input[name=multiselect_chkList]:checked').map(function () { return $(this).val(); }).get().join(',');

        return chkValues;
    }


    function GetCheckboxText() {

             var chkValues = $('input[name=multiselect_chkList]:checked').map(function () { return $(this).next().html(); }).get().join(',');

        var len = $('input[name=multiselect_chkList]:checked').length;

        //chkValues = (len > 0) ? (len > 3) ? len : chkValues : chkValues;

        return (chkValues == "") ? "Select options" : len + " selected.";
    }
</script>
<p>
    <select id="chkList" onchange="setHeaderText()"  style="width: 370px; ">
    </select>
</p>

