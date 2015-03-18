var guesses = {};
var guessNotComplete = true;
var autoplayguessflag = false;

$((function (){
   $(function() {
       guesses.guesssender1 = -1;
       guesses.guesssender2 = -1;
       guesses.guesssender3 = -1;
       guesses.guessreceiver1 = -1;
       guesses.guessreceiver2 = -1;
       guesses.guessreceiver3 = -1;
       $("#guessbutton").attr("disabled","disabled");
    });
    $("#guessbutton").click(function(){
        submitguess();
     });

    }));

function updateremoteprep(){
    updatedatahash = {};
}

function remoteupdatereturn(data){
    //alert("remoteupdatereturn(data.running) - " + data.running);
    //alert("remoteupdatereturn(data.can_start) - " + data.can_start)
    //alert("remoteupdatereturn(data.connections) - " + data.connections.connections)
    redirectcmd(data);
    if(data.autoplay !== undefined){
        var newflag = data.autoplay;
        var oldflag = autoplayguessflag;
        autoplayguessflag = newflag;
        if(!oldflag && newflag){
             startautoplay();
    }
}}

function showGuess(guessid, guessvalue){
    if (guessNotComplete){
        var showguessid = "#" + guessid + "view";
        var newvalue = guessvalue;
        $(showguessid).html(newvalue);
        guesses[guessid] = newvalue;
        cansubmit();
    }
}

function cansubmit(){
    var goodtogo = true;
    if(guesses.guesssender1 == -1) goodtogo = false;
    if(guesses.guesssender2 == -1) goodtogo = false;
    if(guesses.guesssender3 == -1) goodtogo = false;
    if(guesses.guessreceiver1 == -1) goodtogo = false;
    if(guesses.guessreceiver2 == -1) goodtogo = false;
    if(guesses.guessreceiver3 == -1) goodtogo = false;
    var submitdisabled = $("#guessbutton").attr("disabled");
    //alert("button state = [" + submitdisabled + "]")
    if(goodtogo){
        if (submitdisabled) $("#guessbutton").removeAttr("disabled");
    }else{
        if (!submitdisabled) $("#guessbutton").attr("disabled","disabled");
    }
    return goodtogo;
}

function submitguess(){

    jConfirm("Are you sure you want to submit your guess?", "Confirm Your Guess", function(result){
           if(result){
                leaveok();
                $.post(controllername +"/submitguess", $("#guessform").serialize());
           }
    } );  
}