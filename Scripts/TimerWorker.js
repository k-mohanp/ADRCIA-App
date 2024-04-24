// Following global variables and function is used for timeout counter
var intTimerLimit = 0;
var intTimerStep = 1;
var minutes;
var seconds;

onmessage = function (msg) {
    intTimerLimit = msg.data;
    startSessionClock();
};

function startSessionClock() {

    intTimerLimit = intTimerLimit - intTimerStep;
    minutes = new String(parseInt(intTimerLimit / 60));
    seconds = (intTimerLimit % 60);

    if (parseInt(seconds) < 10) seconds = new String('0' + seconds);
    if (parseInt(minutes) < 10) minutes = new String('0' + minutes);

    postMessage([new String(minutes + ':' + seconds), intTimerLimit]);
        
    if (intTimerLimit > 0)
        setTimeout("startSessionClock()", 1000);
    
}