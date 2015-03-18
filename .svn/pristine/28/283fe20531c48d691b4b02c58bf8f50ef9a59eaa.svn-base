
function startautoplay(){
    if(autoplayguessflag){
        var newtime = Math.floor(Math.random() * 4000 ) + 1;
       setTimeout("autoplayguess()",newtime);
    }
}

function autoplayguess(){
    var newtime = Math.floor(Math.random() * 4000 ) + 1;
    var submit = true;

    newguess = Math.floor(Math.random() * 100)

    if(guesses.guesssender1 == -1){
        $("#guesssender1").val(newguess);
        showGuess("guesssender1", newguess)
        submit = false;
    }else if(guesses.guesssender2 == -1){
       $("#guesssender2").val(newguess);
        showGuess("guesssender2", newguess)
         submit = false;
    }else if(guesses.guesssender3 == -1){
       $("#guesssender3").val(newguess);
        showGuess("guesssender3", newguess)
         submit = false;
    }else if(guesses.guessreceiver1 == -1){
       $("#guessreceiver1").val(newguess);
        showGuess("guessreceiver1", newguess)
        submit = false;
    }else if(guesses.guessreceiver2 == -1){
       $("#guessreceiver2").val(newguess);
        showGuess("guessreceiver2", newguess)
        submit = false;
    }else if(guesses.guessreceiver3 == -1){
       $("#guessreceiver3").val(newguess);
        showGuess("guessreceiver3", newguess)
        submit = true;
    }

    if(submit){
        leaveok();
        $('#guessform').submit();
    }else{
        startautoplay();
    }
}
