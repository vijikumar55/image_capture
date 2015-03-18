
function startautoplay(){
    if(autoplaypayoutflag){
        var newtime = Math.floor(Math.random() * 2000 ) + 1;
       setTimeout("autoplaypayout()",newtime);
    }
}

function autoplaypayout(){
    if($("#submitbutton").is(":visible")){
       var computerid = $("#computerid").html();
       $("#username").val("GhostFirstName" + computerid + " GhostLastName" + computerid);
       $("#submitbutton").click();
    }
     startautoplay();
}