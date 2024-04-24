
//function sticky_relocate() {
//	var window_top = $(window).scrollTop();
//	var div_top = $('#sticky-anchor').offset().top;
//	if (window_top > div_top) {
//		$('#sticky').addClass('stick');
//	} else {
//		$('#sticky').removeClass('stick');
//	}
//}

//$(function () {
//	$(window).scroll(sticky_relocate);
//	sticky_relocate();
//});



/* accessible */
$(document).ready(function() {
    $('.collapse').each(function() {
        var tis = $(this), state = true, answer = tis.next('.collapse_body').slideUp();
        tis.toggleClass('active', state);
        tis.click(function() {
        document.getElementById('dvMore').style.display = 'none';
        document.getElementById('dvexpand').style.display = 'block';
           
            state = !state;
            answer.slideToggle(state);
            tis.toggleClass('active', state);
        });
    });
});

///* accessible */
$(document).ready(function() {
 $('.expand').each(function() {
 var tis = $(this), state = true, answer = tis.prev('.collapse_body').slideUp();
        tis.toggleClass('active', state);
        tis.click(function() {
            state = !state;
            answer.slideToggle(state);
            document.getElementById('dvexpand').style.display = 'none';
            document.getElementById('dvMore').style.display = 'block';
        });
    });
});



// Added by GK on 3July18
function ShowAlert(msg, type) {

    if (type == "S")// if message is success message
    {
        $("#spnImg").removeClass("wrong");
        $("#spnImg").addClass("right");
        $("#spnImg").width("33px");
        $("#spnImg").height("25px");
        $("#spnHeader").text("Success");
    }
    else// if message is alert/error message
    {
        $("#spnImg").addClass("wrong");
        $("#spnImg").removeClass("right");
        $("#spnImg").width("20px");
        $("#spnImg").height("24px");
        $("#spnHeader").text("ALERT");
    }


    $("[id*=lblMsg]").html(msg);//Modified by KP on 6th Dec 2019(SOW-577), replace the text() to html() due to html format was not suported.
    $("#divalert").css("display", "block");
    $("#divoverlaysuccess").css("display", "block");
}

function HideAlertBox() {
    $("[id*=lblMsg]").text('');
    $("#divalert").css("display", "none");
    $("#divoverlaysuccess").css("display", "none");
    $(window).scrollTop(0);
}