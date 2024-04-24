// Added by GK on 26July2023 : SOW-654
// Attach the ajaxStart event listener
let approoturl = "";
$(document).ajaxStart(myAjaxHandler);

$(document).ajaxStop(function () {
    $(document).ajaxStart(myAjaxHandler);
});

function myAjaxHandler() {    
    // Detach the ajaxStart event listener        
    $(document).off("ajaxStart", myAjaxHandler);
    let isSionout = false;
    $.ajax({
        type: "POST",
        url: approoturl + "/Login.aspx/IsSessionKilled",
        headers: { 'X-Requested-With': 'XMLHttpRequest' },
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function (data) {
            if (data.d == true) {
                window.location.href = approoturl + "/logout.aspx";
                isSionout = true;
            }                
        },
        error: function (xhr, status, error) {
        }
    });    
    return isSionout;
}