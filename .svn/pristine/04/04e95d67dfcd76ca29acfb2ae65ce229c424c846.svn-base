var histdata = new Array(2);
var nextcount = 0;
var historyloaded = false;
var currentpickdata;
var currentroll = 0;
var currentamount = 0;
var paymentroll = new Array(4);
var amount = new Array(2);

var picktextcolor = "blue";
var msgtitle = "";

$((function (){
    $((function () {
        $("#nextbutton").hide();
        setdicetype(1);
        whitedice();
        var msghash = {
            "needhistorydata" : "true"
        };
        $.post( controllername +"/loadhistorydata", msghash , function(data){
            loadhistorydata(data)
        }, "json" );
        displaypayout(0);
    }));
    $("#nextbutton").click(function(){
        if(nextcount == 0){
            $("#nextbutton").hide();
            whitedice();
            displaypayout(1);
            $("#pickpayoutouterdiv").hide();
            nextcount++;
        }else{
            $("#nextbutton").hide();
            sendpayment();
        }
    });
    $((function () {
        }));
}));

function diceroll(){
    // This is the actual coin flipping function overriding the original place holder function.
    rollvalue = actualroll();
    paymentroll[currentroll] = rollvalue;
    if(dicecolor == "red"){
        amount[currentamount] = currentpickdata[rollvalue][0].pay
        currentamount++;
    }
    currentroll++;
}

function displaypayout(act){
    nohighlight();
    if(historyloaded){
        for(idx=0;idx<6;idx++){
            loadboxes(histdata[act]);
        }
    }
    $("#pickpayoutouterdiv").hide();
    if(act == 0){
        $("#rollbutton").attr("value","Roll to select an Interaction 1 group for payment")
        $("#finaltitle").html("Payout Selection For Interaction 1");
    }else{
        $("#pickpayoutouterdiv").hide();
        $("#rollbutton").attr("value","Roll to select an Interaction 2 group for payment")
        $("#finaltitle").html("Payout Selection For Interaction 2");
    }
    $("#rollbutton").show();
}

function loadhistorydata(data){
    histdata = data;
    historyloaded = true;
    loadboxes(histdata[0]);
}

function loadboxes(data){
    sendunk = data.send.unk;
    sendsame = data.send.same;
    senddiff = data.send.diff;
    recunk = data.rec.unk;
    recsame = data.rec.same;
    recdiff = data.rec.diff;

    loadrows(0,sendunk);
    loadrows(1,sendsame);
    loadrows(2,senddiff);
    loadrows(3,recunk);
    loadrows(4,recsame);
    loadrows(5,recdiff);
}
function loadrows(box,boxdata){
    for(i=0;i<6;i++){
        $("#boxtable" + box + i + "-1").html(boxdata[i][0].coin)
        $("#boxtable" + box + i + "-2").html(boxdata[i][0].msg)
        $("#boxtable" + box + i + "-3").html(boxdata[i][0].chal)
        $("#boxtable" + box + i + "-4").html("$" + Number(boxdata[i][0].pay).toFixed(2))
    }
}
function pickrow(){
     loadpickrows(getselectedboxdata());
     $("#pickrowheader2").html(msgtitle);
     $("#pickpayoutouterdiv").show();
     $("#pickrowdiv").css("color", picktextcolor );
     reddice();
     $("#rollbutton").attr("value","Roll to select Interaction in this group for payment")
     $("#rollbutton").show();

}
function hidepickrow(){
}

function loadpickrows(boxdata){
    currentpickdata = boxdata;
    for(i=0;i<6;i++){
        $("#pickrow" + i + "-1").html(boxdata[i][0].coin)
        $("#pickrow" + i + "-2").html(boxdata[i][0].msg)
        $("#pickrow" + i + "-3").html(boxdata[i][0].chal)
        $("#pickrow" + i + "-4").html("$" + Number(boxdata[i][0].pay).toFixed(2))
    }
}

function getselectedboxdata(){
    var returndata;
    switch(rollvalue)
    {
        case 0:
            returndata = sendunk;
            picktextcolor = "green";
            break;
        case 1:
            returndata = sendsame;
            picktextcolor = "green";
            break;
        case 2:
            returndata = senddiff;
            picktextcolor = "green";
            break;
        case 3:
            returndata = recunk;
            picktextcolor = "blue";
            break;
        case 4:
            returndata = recsame;
            picktextcolor = "blue";
            break;
        case 5:
            returndata = recdiff;
            picktextcolor = "blue";
            break;
        default:
        }
        if(picktextcolor == "green"){
            msgtitle = "False Message";
        }
        else{
            msgtitle = "Sent Message";
        }

        return returndata;
    }
function sendpayment(){
        var msghash = {
            "roll1" : paymentroll[0],
            "roll2" : paymentroll[1],
            "roll3" : paymentroll[2],
            "roll4" : paymentroll[3],
            "amount1" : amount[0],
            "amount2" : amount[1]
        };
        $.post( controllername +"/interactpayment", msghash , function(data){
            sendpaymentreturn(data)}, "json" );
        }

function sendpaymentreturn(data){
   leaveok();
  $(window.location).attr("href", "payout");
}