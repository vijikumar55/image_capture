
function startautoplay(){
    if(autoplayparticipantflag){
        var newtime = Math.floor(Math.random() * 5000 ) + 2;
       setTimeout("autoplayparticipant()",newtime);
    }
}

function autoplayparticipant(){
    if($("#flipbutton").is(":visible")){
       $("#flipbutton").click();
    }else if($("#sendmessage4split").is(":visible")){
         var pickvalue1 = Math.random();
         if( pickvalue1 > .3){
            $("#sendmessage4split").click();
         }else{
            $("#sendmessage2split").click();
         }
    }else if($("#sendmessage2split").is(":visible")){
            $("#sendmessage2split").click();
    }else if($("#receiverchallenge").is(":visible")){
         var pickvalue2 = Math.random();
         if( pickvalue2 > .7){
            $("#receiverchallenge").click();
         }else{
            $("#receiveraccept").click();
         }
    }else if($("#receiveraccept").is(":visible")){
            $("#receiveraccept").click();
    }else if($("#receiverok").is(":visible")){
            $("#receiverok").click();
     }else if($("#senderok").is(":visible")){
            $("#senderok").click();
     }else if($("#receivergroupok").is(":visible")){
            $("#receivergroupok").click();
     }else if($("#sendergroupok").is(":visible")){
            $("#sendergroupok").click();
    }
     startautoplay();
}