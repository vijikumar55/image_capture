
function startautoplay(){
    if(autoplayfinalflag){
        var newtime = Math.floor(Math.random() * 2000 ) + 1;
       setTimeout("autoplayfinal()",newtime);
    }
}

function autoplayfinal(){
    if($("#rollbutton").is(":visible")){
       $("#rollbutton").click();
    }else if($("#nextbutton").is(":visible")){
       $("#nextbutton").click();
    }
     startautoplay();
}