
var iDay = "This field must be a day number between 1 and 31. Please re-enter it now.";
var iMonth = "This field must be a month number between 1 and 12. Please re-enter it now.";
var iYear = "This field must be a 4 digit year number between 1900 and 2079. Please re-enter it now.";


function checkYear(theField, emptyOK) {
    if (checkYear.arguments.length == 1) emptyOK = defaultEmptyOK;
    if ((emptyOK == true) && (isEmpty(theField.value))) {
        blnNoErrorCaught = true;
        return true;

    }
    if (!isYear(theField.value, false)) {
        blnNoErrorCaught = false;
        return warnInvalid(theField, iYear);
    }
    else {
        blnNoErrorCaught = true;
        return true;
    }
}

function checkMonth(theField, emptyOK) {
    if (checkMonth.arguments.length == 1) emptyOK = defaultEmptyOK;
    if ((emptyOK == true) && (isEmpty(theField.value))) {
        blnNoErrorCaught = true;
        return true;
    }
    if (!isMonth(theField.value, false)) {
        blnNoErrorCaught = false;
        return warnInvalid(theField, iMonth);
    }
    else {
        blnNoErrorCaught = true;
        return true;
    }
}


function checkDay(theField, emptyOK) {
    if (checkDay.arguments.length == 1) emptyOK = defaultEmptyOK;
    if ((emptyOK == true) && (isEmpty(theField.value))) {
        blnNoErrorCaught = true;
        return true;
    }
    if (!isDay(theField.value, false)) {
        blnNoErrorCaught = false;
        return warnInvalid(theField, iDay);
    }
    else {
        blnNoErrorCaught = true;
        return true;
    }
}

function checkEntireDate(theMonth, theDay, theYear, emptyOK) {
    if (checkEntireDate.arguments.length == 3) emptyOK = defaultEmptyOK;
    if ((emptyOK == true) && ((isEmpty(theMonth.value)) && (isEmpty(theDay.value)) && (isEmpty(theYear.value))))
        return true;
    else {
        return (checkMonth(theMonth, false) && checkDay(theDay, false)
			&& checkYear(theYear, false));
    }
}

//checks to make sure that Apr, Jun, Sept, & Nov have a max of 30 days and February has 28 or 29 depending on leap year.
function maxMonthDays(obj1, obj2, obj3) {
    var month = obj1;
    var day = obj2;
    var year = obj3;

    if ((month == 4 || month == 6 || month == 9 || month == 11) && (day > 30)) {
        alert('Sorry, the maximum number of days in this month is 30.  Please re-enter.')
        blnNoErrorCaught = false;
        //obj2.focus();
        return false;
    }
    else if ((month == 2) && (day > daysInFebruary(year))) {
        alert('Sorry, the maximum number of days in this month is ' + daysInFebruary(year) + '.  Please re-enter.')
        blnNoErrorCaught = false;
        //obj2.focus();
        return false;
    }
    else if ((month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) && (day > 31)) {
        alert('Sorry, the maximum number of days in this month is 31.  Please re-enter.')
        blnNoErrorCaught = false;
        //obj2.focus();
        return false;
    }
    /*else if (month == '') {
    alert('Please enter the month portion of the date.')
    blnNoErrorCaught = false;
    obj1.focus();
    return false;
    }
    else if (day == '') {
    alert('Please enter the day portion of the date.')
    blnNoErrorCaught = false;
    obj2.focus();
    return false;
    }
    else if (year < 1900) {
    alert('Sorry, the year needs to be 1900 or later.  Please re-enter.')
    blnNoErrorCaught = false;
    obj3.focus();
    return false;
    }*/
    else {
        blnNoErrorCaught = true;
        return true;
    }
}


function checkDate(yearField, monthField, dayField, labelString, OKtoOmitDay) {
    if (checkDate.arguments.length == 4) OKtoOmitDay = false;
    if (!isYear(yearField.value, OKtoOmitDay)) return warnInvalid(yearField, iYear);
    if (!isMonth(monthField.value)) return warnInvalid(monthField, iMonth);

    if ((OKtoOmitDay && isEmpty(dayField.value) && isEmpty(monthField.value) && isEmpty(yearField.value)) || (!isEmpty(dayField.value) && !isEmpty(monthField.value) && !isEmpty(yearField.value))) {
        return true;
    } else {
        alert(iDatePrefix + labelString + iDateSuffix);
        return false;
    }
    if ((OKtoOmitDay == true) && isEmpty(dayField.value)) return true;
    else if (!isDay(dayField.value))
        return warnInvalid(dayField, iDay);
    if (isDate(yearField.value, monthField.value, dayField.value))
        return true;
    alert(iDatePrefix + labelString + iDateSuffix);
    // alert ("I am in");

    return false;
}

function checkDateToday(yearField, monthField, dayField, labelString, OKtoOmitDay) {
    var RealDate = monthField.value + "/" + dayField.value + "/" + yearField.value;
    if (checkDateToday.arguments.length == 4) OKtoOmitDay = false;
    if (!isYear(yearField.value)) return warnInvalid(yearField, iYear);
    if (!isMonth(monthField.value)) return warnInvalid(monthField, iMonth);
    if (!isRealDate(RealDate)) {
        alert("Please enter '" + labelString + "' as  mm/dd/yyyy");
        return false;
    }
    if ((OKtoOmitDay == true) && isEmpty(dayField.value)) return true;
    else if (!isDay(dayField.value))
        return warnInvalid(dayField, iDay);
    if (isCorrectDateToday(yearField.value, monthField.value, dayField.value)) {
        return true;
    } else {
        alert("'" + labelString + "' date cannot be date in the future.")
        return false;
    }
}


function isDateInFiscalYear(myMonth, myDay, myYear, FY, myObj) {
    if ((myMonth.value == '') || (myDay.value == '') || (myYear.value == '') || FY == '') {
        return true;
    }
    else
        var begFY = new Date((parseInt(FY) - 1), 9, 1);
    var endFY = new Date(parseInt(FY), 9, 1);
    var x = new Date;
    x.setDate(parseInt(myDay.value));
    x.setFullYear(parseInt(myYear.value));
    x.setMonth(parseInt(myMonth.value) - 1);

    if ((x - begFY > 0) && (endFY - x > 0)) {
        return true;
    } else {
        myObj.focus();
        myObj.select();
        alert("Date is outside of Fiscal Year!");
        return false;
    }
}


function clearDate(theField) {
    //this function works for a link that immediately follows the date fields only
    document.all[document.all(theField.name).sourceIndex - 1].value = '';
    document.all[document.all(theField.name).sourceIndex - 2].value = '';
    document.all[document.all(theField.name).sourceIndex - 3].value = '';
}



function isYear(s) {
    if (isEmpty(s)) {
        if (isYear.arguments.length == 1) return defaultEmptyOK;
        else return (isYear.arguments[1] == true);
    }
    if (!isNonnegativeInteger(s)) return false;
    if (s < 1900) return false;
    if (s > 2078) return false;
    return (s.length == 4);
}

function isIntegerInRange(s, a, b) {
    if (isEmpty(s))
        if (isIntegerInRange.arguments.length == 1) return defaultEmptyOK;
        else return (isIntegerInRange.arguments[1] == true);
    if (!isInteger(s, false)) return false;

    var num = parseInt(s);
    return ((num >= a) && (num <= b));
}


function isMonth(s) {
    if (isEmpty(s))
        if (isMonth.arguments.length == 1) return defaultEmptyOK;
        else return (isMonth.arguments[1] == true);

    if (s.charAt(0) == '0') { s = s.charAt(1) }
    return isIntegerInRange(s, 1, 12);
}


function isDay(s) {
    if (isEmpty(s))
        if (isDay.arguments.length == 1) return defaultEmptyOK;
        else return (isDay.arguments[1] == true);

    if (s.charAt(0) == '0') { s = s.charAt(1) }
    return isIntegerInRange(s, 1, 31);
}


function daysInFebruary(year) {
    return (((year % 4 == 0) && ((!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28);
}


function isDate(year, month, day) {
    if (!(isYear(year, false) && isMonth(month, false) && isDay(day, false))) return false;

    var intYear = parseInt(year);
    var intMonth = parseInt(month);
    var intDay = parseInt(day);

    if (intDay > daysInMonth[intMonth]) return false;

    if ((intMonth == 2) && (intDay > daysInFebruary(intYear))) return false;

    return true;
}

function isEmpty(s) {
    return ((s == null) || (s.length == 0));
}

function warnInvalid(theField, s) {
    //the message (s) passed in normally comes from the list at the top of this file
    //although this function can be called from elsewhere with a custom message
    theField.focus();
    theField.select();
    alert(s);
    return false;
}

