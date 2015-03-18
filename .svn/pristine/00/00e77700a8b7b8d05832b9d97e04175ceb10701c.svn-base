var sendunk;
var sendsame;
var senddiff;
var recunk;
var recsame;
var recdiff;
var unk1pressed = true;
var same1pressed = false;
var diff1pressed = false;
var unk2pressed = false;
var same2pressed = false;
var diff2pressed = false;
var donepushed = false;

var coin4 = 0;
var split2 = 0;
var challenged = 0;
var sucessfulsend = 0;
var sucessfulrec = 0;
var falsemessage = 0;

var resultstitlesend = "When you were a Sender: "
var resultstitlerec  = "When you were a Receiver: "

$((function () {
    $(function() {
        $("#waitmsgdiv").hide();
        var msghash = {
            "needhistorydata" : "true"
        };
        $.post( controllername +"/loadhistorydata", msghash , function(data){
            loadhistorydata(data)
        }, "json" );
        $("#diffbutton").attr("value", difftext);
        $("#summarymsgsend").hide();
        $("#summarymsgrec").hide();

    });
    $(function() {
        $("#unkbutton1").click(function(){
            showunk1();
        });
        $("#samebutton1").click(function(){
            showsame1();
        });
        $("#diffbutton1").click(function(){
            showdiff1();
        });
        $("#unkbutton2").click(function(){
            showunk2();
        });
        $("#samebutton2").click(function(){
            showsame2();
        });
        $("#diffbutton2").click(function(){
            showdiff2();
        });
        $("#donebutton").click(function(){
            donepushed = true;
            done();
        });
    });

}))


function showunk1(){
    loaddata(sendunk);
    $("#resultstitle").html(resultstitlesend + " Unknown Age Group");
    $("#resultstableheader2").html("False Message");
    $("#unkbutton1").css("background-color", "#ffff66");
    $("#samebutton1").css("background-color", "silver");
    $("#diffbutton1").css("background-color", "silver");
    $("#unkbutton2").css("background-color", "silver");
    $("#samebutton2").css("background-color", "silver");
    $("#diffbutton2").css("background-color", "silver");

    updatesummarysendmsg();

    $("#summarymsgsend").show();
    $("#summarymsgrec").hide();
    unk1pressed = true;
    enabledone();
}

function showsame1(){
    loaddata(sendsame);
    $("#resultstitle").html(resultstitlesend + " Same Age Group");
    $("#resultstableheader2").html("False Message");
    $("#unkbutton1").css("background-color", "silver");
    $("#samebutton1").css("background-color", "#ffff66");
    $("#diffbutton1").css("background-color", "silver");
    $("#unkbutton2").css("background-color", "silver");
    $("#samebutton2").css("background-color", "silver");
    $("#diffbutton2").css("background-color", "silver");

    updatesummarysendmsg();

    $("#summarymsgsend").show();
    $("#summarymsgrec").hide();
    same1pressed = true;
    enabledone();
}
function showdiff1(){
    loaddata(senddiff);
    $("#resultstitle").html(resultstitlesend + " " + difftext);
    $("#resultstableheader2").html("False Message");
    $("#unkbutton1").css("background-color", "silver");
    $("#samebutton1").css("background-color", "silver");
    $("#diffbutton1").css("background-color", "#ffff66");
    $("#unkbutton2").css("background-color", "silver");
    $("#samebutton2").css("background-color", "silver");
    $("#diffbutton2").css("background-color", "silver");

    updatesummarysendmsg();

    $("#summarymsgsend").show();
    $("#summarymsgrec").hide();
    diff1pressed = true;
    enabledone();
}

function updatesummarysendmsg(){
    $("#summarymsgsend1").html(coin4 + "/6");
    $("#summarymsgsend2").html(falsemessage + "/" + coin4);
    $("#summarymsgsend3").html(challenged + "/" + split2);
    $("#summarymsgsend4").html(sucessfulsend + "/" + challenged );
}



function showunk2(){
    loaddata(recunk);
    $("#resultstitle").html(resultstitlerec + " Unknown Age Group");
    $("#resultstableheader2").html("Sent Message");
    $("#unkbutton1").css("background-color", "silver");
    $("#samebutton1").css("background-color", "silver");
    $("#diffbutton1").css("background-color", "silver");
    $("#unkbutton2").css("background-color", "#ffff66");
    $("#samebutton2").css("background-color", "silver");
    $("#diffbutton2").css("background-color", "silver");

    updatesummaryrecmsg();

    $("#summarymsgsend").hide();
    $("#summarymsgrec").show();
    unk2pressed = true;
    enabledone();
}

function showsame2(){
    loaddata(recsame);
    $("#resultstitle").html(resultstitlerec + " Same Age Group");
    $("#resultstableheader2").html("Sent Message");
    $("#unkbutton1").css("background-color", "silver");
    $("#samebutton1").css("background-color", "silver");
    $("#diffbutton1").css("background-color", "silver");
    $("#unkbutton2").css("background-color", "silver");
    $("#samebutton2").css("background-color", "#ffff66");
    $("#diffbutton2").css("background-color", "silver");

    updatesummaryrecmsg();

    $("#summarymsgsend").hide();
    $("#summarymsgrec").show();
    same2pressed = true;
    enabledone();
}

function showdiff2(){
    loaddata(recdiff);
    $("#resultstitle").html(resultstitlerec + " " + difftext);
    $("#resultstableheader2").html("Sent Message");
    $("#unkbutton1").css("background-color", "silver");
    $("#samebutton1").css("background-color", "silver");
    $("#diffbutton1").css("background-color", "silver");
    $("#unkbutton2").css("background-color", "silver");
    $("#samebutton2").css("background-color", "silver");
    $("#diffbutton2").css("background-color", "#ffff66");

    updatesummaryrecmsg();

    $("#summarymsgsend").hide();
    $("#summarymsgrec").show();
    diff2pressed = true;
    enabledone();
}

function updatesummaryrecmsg(){
    $("#summarymsgrec1").html(split2 + "/6");
    $("#summarymsgrec2").html(challenged + "/" + split2);
    $("#summarymsgrec3").html(sucessfulrec + "/" + challenged );
}


function done(){
  $("#unkbutton1").attr("disabled", "disabled");
  $("#samebutton1").attr("disabled", "disabled");
  $("#diffbutton1").attr("disabled", "disabled");
  $("#unkbutton2").attr("disabled", "disabled");
  $("#samebutton2").attr("disabled", "disabled");
  $("#diffbutton2").attr("disabled", "disabled");
  $("#donebutton").attr("disabled", "disabled");
  $("#resultsouterouterdiv").hide();
  $("#buttonpanel2").hide();
  $("#resultstitle").hide();
  $("#waitmsgdiv").show();
  $.post( "results/done","json" );
}

function loadhistorydata(data){
    sendunk = data.send.unk;
    sendsame = data.send.same;
    senddiff = data.send.diff;
    recunk = data.rec.unk;
    recsame = data.rec.same;
    recdiff = data.rec.diff;
    showunk1();
}


function loaddata(data){
    var coin;
    var chal;
    var msg;
    coin4 = 0;
    split2 = 0;
    challenged = 0;
    sucessfulsend = 0;
    sucessfulrec = 0;
    falsemessage = 0;
    for(i=0;i<=5;i++){
        coin = data[i][0].coin;
        chal = data[i][0].chal;
        msg = data[i][0].msg;
        if(coin == "4"){ coin4 = coin4 + 1;}
        if(chal == "Yes"){ challenged = challenged + 1;}
        if(msg == "2 to Split" || coin == "2"){ split2 = split2 + 1;}
        if(msg == "2 to Split" && chal == "Yes"){ sucessfulsend = sucessfulsend + 1;}
        if(msg == "2 to Split" && chal == "Yes" && coin == "4"){ sucessfulrec = sucessfulrec + 1;}
        if(msg == "2 to Split" && coin == "4"){ falsemessage = falsemessage + 1;}

        $("#coin" + i ).html(coin);
        $("#msg" + i ).html(msg);
        $("#chal" + i ).html(chal);
        $("#pay" + i ).html("$" + Number(data[i][0].pay).toFixed(2));
    }

}

function enabledone(){
    if(unk1pressed && same1pressed && diff1pressed && unk2pressed && same2pressed && diff2pressed ){
        if(!doneenabled){
            $("#donebutton").removeAttr("disabled");
        }
    }
}
