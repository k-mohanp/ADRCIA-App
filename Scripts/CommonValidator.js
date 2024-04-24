//Created by SA on 16th March, 2016. 
/*
    Beforedecimal --> Number of digits to be allowed = Maxlength - Beforedecimal
    afterDecimal -- Number of digits after decimal
*/

$.fn.CommonValidator = function (options) {

    // This is the easiest way to have default options.
    var settings = $.extend({
        // These are the defaults.
        beforeDecimal: 3,
        afterDecimal: 2,
        afterDecimalRate: 3,
        beforeDecimalRate: 4,
        selectionStart: 5, //parameter to customise numbers before decimal
        selectionStartRate: 3,//parameter to customise numbers before decimal
    }, options);

    // Greenify the collection based on the settings variable.
    this.keydown(function (event) {
        var val = this.value;
        var points = 0;
        points = val.indexOf(".", points);
        var keyCode = event.charCode || event.keyCode;
        if (keyCode === 37) {
            if (event.preventDefault) {
                event.preventDefault();
            } else {
                event.returnValue = false;
            }
        }
       
       moveCursor(this, val.length);
    });

    this.keyup(function (event) {

        var val = this.value;
        var points = 0;

        points = val.indexOf(".", points);
        if (points >= 0) {
            if (val.split('.')[1].length == 0) {
                if (points == 0) {
                    this.value = '';
                    return false;
                }
            }
        }
       
        moveCursor(this, val.length);

    });
    

    this.keypress(function (event) {

        var val = this.value;
        var points = 0;
        points = val.indexOf(".", points);
        if (points >= 1 && event.which == 46) {
            return false;
        }
        if ((event.which != 46 ||

            $(this).val().indexOf('.') != -1)

            &&
          ((event.which < 48 || event.which > 57) &&
            (event.which != 0 && event.which != 8))) {
            event.preventDefault();
        }

        var text = $(this).val();

        var dot = event.char != undefined ? event.char : event.key;

        if (text.length != this.maxLength - settings.beforeDecimal) {
            if (text.length + 1 > this.maxLength - settings.beforeDecimal) {
                if (text.indexOf('.') == -1)
                    event.preventDefault();
                else {
                    if ( dot != "Backspace" && val.split('.')[1].length >= 2 ) {

                        event.preventDefault();
                    }
                }
            }
        }        
        else {
            if ((dot != "." && dot != "Decimal") && event.charCode != 46 && dot != "Backspace" && (event.which != 0 && event.which != 8) && ($(this)[0].selectionStart >= text.length - settings.afterDecimal))
            {
                if (text.indexOf('.') != -1) {
                    if (val.split('.')[1].length >= 2) {

                        event.preventDefault();
                    }
                }
                else
                    event.preventDefault();
            }               
           
        }
    });


};


function removeLastDigit(value) {
    return value.substring(0, value.length - 1);
}


function moveCursor(inp, s, e) {
    e = e || s;
    if (inp.createTextRange) {
        var r = inp.createTextRange();
        r.collapse(true);
        r.moveEnd('character', e);
        r.moveStart('character', s);
        r.select();
    }
    else if (inp.setSelectionRange) {
        inp.focus();
        inp.setSelectionRange(s, e);
    }
}
