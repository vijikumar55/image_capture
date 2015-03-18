var payoutdata = new Array(2);
var nextcount = 0;
var paymentroll = new Array(2);
var amount = new Array(2);
var currentroll = 0;

$((function (){
    $((function () {
        for(aix=0;aix < 2;aix++){
            payoutdata[aix] = new Array(6);
            for(idx=0;idx<6;idx++){
                payoutdata[aix][idx] = jQuery.trim($("#payoutdata" + aix + "-" + idx).html());
            }
        }
        displaypayout(0);
        setdicetype(0);
        whitedice();
    }));
    $("#nextbutton").click(function(){
        if(nextcount == 0){
        $("#nextbutton").hide();
        $("#rollbutton").show();
        displaypayout(1);
        nextcount++;
    }else{
        $("#nextbutton").hide();
        sendpayment();
    }
    });
    $((function () {
       $("#nextbutton").hide();
    }));
}));

function diceroll(){
    // This is the actual coin flipping function overriding the original place holder function.
    rollvalue = actualroll();
    paymentroll[currentroll] = rollvalue;
    amount[currentroll] = payoutdata[currentroll][rollvalue]
    currentroll++;
}

function displaypayout(act){
    nohighlight();
    if(act == 0){
        $("#rollbutton").attr("value","Roll to select a guess 1 for payment")
        $("#finaltitle").html("Payout Selection For Guess 1");
    }else{
        $("#rollbutton").attr("value","Roll to select a guess 2 for payment")
        $("#finaltitle").html("Payout Selection For Guess 2");
    }
    for(idx=0;idx<6;idx++){
        $("#boxearned" + idx).html("$" + Number(payoutdata[act][idx]).toFixed(2));
    }
}

function sendpayment(){
        var msghash = {
            "roll1" : paymentroll[0],
            "roll2" : paymentroll[1],
            "amount1" : amount[0],
            "amount2" : amount[1]
        };
        $.post( controllername +"/guesspayment", msghash , function(data){
        sendpaymentreturn(data)}, "json" );
        }

function sendpaymentreturn(data){
        leaveok();
        $(window.location).attr("href", "final2");
}