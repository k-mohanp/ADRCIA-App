
//Created By:BS
//Created on:10-Feb-2017
//Purpose:Dispaly custom alert box
function ShowAlert(msg, type) {

    $("[id*=imgSucess]").css("display", "none");
    $("[id*=imgError]").css("display", "none");
    $("#spnHeader").css("color", "black");

    if (type == "S")// if message is success message
    {
        $("[id*=imgSucess]").css("display", "inline-block");
        $("#spnHeader").text("Success");
        $("#spnHeader").css("color", "green");
    }
    else// if message is alert/error message
    {
        $("[id*=imgError]").css("display", "inline-block");
        $("#spnHeader").text("Alert");
        $("#spnHeader").css("color", "red");
    }


    $("[id*=lblMsgAlert]").html(msg);
    $("#divalert").css("display", "block");
    $("#divoverlaysuccess").css("display", "block");
    $("#btnClosePopup").focus();
}

//Created By:BS
//Created on:10-Feb-2017
//Purpose:Hide custom alert box
function HideAlertBox() {
    $("[id*=lblMsgAlert]").text('');
    $("#divalert").css("display", "none");
    $("#divoverlaysuccess").css("display", "none");

}


//Created By:KP
//Created On:30th Dec 2019
//Purpose:Show custom confirmation box
function ShowUnsavedConfirmationBox(msg) {
    $("[id*=lblUnsavedMsgConfirm]").text(msg);
    $("#divUnSavedConfirm").css("display", "block");
    $("#divoverlaysuccess").css("display", "block");
    $("#btnUnSavedNoPopupConfirm").focus();
}

//Created By:KP
//Created On:30th Dec 2019
//Purpose:hide custom confirmation box
function HideUnSavedConfirmBox() {
    $("[id*=lblUnsavedMsgConfirm]").text();
    $("#divUnSavedConfirm").css("display", "none");
    $("#divoverlaysuccess").css("display", "none");
}
