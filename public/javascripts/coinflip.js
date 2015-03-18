var coinstate = 0;
var sidecount = 0;
var coinimages = new Array(5);
coinimages[0] = new Image();
coinimages[0].src = "images/heads.jpg";
coinimages[1] = new Image();
coinimages[1].src = "images/tails1.jpg";
coinimages[2] = new Image();
coinimages[2].src = "images/tails.jpg";
coinimages[3] = new Image();
coinimages[3].src = "images/heads1.jpg";
coinimages[4] = new Image();
coinimages[4].src = "images/rotate.jpg";

var imageindex = new Array(3,4,2,1);
var flipping = null;
var coinside = 0;

$((function () {
    $("#flipbutton").click(function(){
        $("#flipbutton").attr("disabled", "disabled");
        coinfilp();
    });
    $(function() {
            //receiverscreen();
            //senderscreen();
            waitmsg("Waiting for other participants ...");
        }
    );
    $("#sendmessage2split").click(function(){
        flipmessagesent();
        flipmessage(2);
     });
    $("#sendmessage4split").click(function(){
        flipmessagesent();
        flipmessage(4);
    });
    $("#receiveraccept").click(function(){
        acceptmessage();
    });
    $("#receiverchallenge").click(function(){
        challengemessage();
    });

}));

function actualflip(){
    var splitvalue = 0;
    var flipvalue = Math.random();
    $("#sendmessage2split").hide();
    $("#sendmessage4split").hide();
    $("#coinresult").html("");
    $("#flipbutton").hide();
   if( flipvalue < .5 ){
        coinside = 0;
        splitvalue = 2;
    }else{
        coinside = 2;
        splitvalue = 4;
    }
    animatecoin(coinside);
    return splitvalue
}


function animatecoin(){
   coinstate = (sidecount) % 4;
   $("#coin").attr("src", coinimages[imageindex[coinstate]].src);
   sidecount++;
   if ((sidecount > 30) && (coinstate == coinside)) {
   $("#coin").attr("src", coinimages[coinstate].src);
       flipping = null;
        sidecount = 0;
        if (coinside == 0){
            filpped2();
        }
        if (coinside == 2){
            flipped4();
        }
   }else{
      flipping = setTimeout("animatecoin(coinside)", 25);
   }
}
function senderscreen(){
    // Set the screen for flipping and send messages
        $("#sendmessage2split").hide();
        $("#sendmessage4split").hide();
        $("#receivecontroldiv").hide();
        $("#waitmsg").hide();
        $("#flipbutton").hide();
        $("#sendercheck").hide();
        $("#sendercontroldiv").show();
        $("#coin").show();
        $("#senderok").show();
        setgametree(0);

}
function receiverscreen(){
    // Set the screen for receiving messages
        $("#sendercontroldiv").hide();
        $("#receiveraccept").hide();
        $("#receiverchallenge").hide();
        $("#waitmsg").hide();
        $("#receivercheck").hide();
        $("#receivecontroldiv").show();
        $("#receiverok").show();
        setgametree(0);

}
function filpped2(){
            $("#coinresult").html("Two");
            $("#sendmessage2split").show();
            setgametree(2);
}
function flipped4(){
            $("#coinresult").html("Four");
            $("#sendmessage2split").show();
            $("#sendmessage4split").show();
            setgametree(1);
}
function flipmessagesent(){
        $("#sendmessage2split").hide();
        $("#sendmessage4split").hide();
        $("#coinresult").html("");
}
function nextflip(){
        $("#flipbutton").removeAttr("disabled");
        $("#flipbutton").show();
        setgametree(0);
}
function waitmsg(msg){
    // Set the screen for receiving messages
        $("#sendercontroldiv").hide();
        $("#receivecontroldiv").hide();
        $("#sendmessage2split").hide();
        $("#sendmessage4split").hide();
        $("#coin").hide();
        $("#flipbutton").hide();
        $("#waitmsg").html(msg);
        $("#waitmsg").show();
        setgametree(0);
}
function messagesplit(splitmsg){
    if(splitmsg == 2){
        $("#receiversendermessage").html( "Two to Split");
        $("#receiveraccept").show();
        $("#receiverchallenge").show();
        setgametree(3);
    }
    if(splitmsg == 4){
        $("#receiverchallenge").hide();
        $("#receiveraccept").show();
        $("#receiversendermessage").html("Four to Split");
        setgametree(4);
    }
}

function hidesplitbuttons(){
        $("#receiveraccept").hide();
        $("#receiverchallenge").hide();
        $("#receiversendermessage").html("");
}
