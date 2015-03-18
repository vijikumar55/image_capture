var xticklabels = [[0,"Never"], [.2, "20%"],[.4, "40%"],[.6,"60%"],[.8,"80%"],[1,"Always"]];
var yticklabels = [];
var acutalvalue = [];
var maxamount = 0;
var blue = "#0033ff";
var green = "#008000";

var resultstitle;

var sendmsgs = "#plotareafalsemsg";
var recmsgs  = "#plotareachallenge";

var peak = 5;
var span = 36;

var unksendguess;
var samesendguess;
var diffsendguess;

var unkrecguess;
var samerecguess;
var diffrecguess;

var unksendact;
var samesendact;
var diffsendact;

var unkrecact;
var samerecact;
var diffrecact;


var unksenddata = [];
var samesenddata = [];
var diffsenddata = [];
var unkrecdata = [];
var samerecdata = [];
var diffrecdata = [];

var unksendactdata = [];
var samesendactdata = [];
var diffsendactdata = [];
var unkrecactdata = [];
var samerecactdata = [];
var diffrecactdata = [];
var showing;

$((function () {
    $(function() {
        resultstitle = jQuery.trim($("#resultstitle").html());
        unksendguess = jQuery.trim($("#guesssend0").html());
        unkrecguess = jQuery.trim($("#guessrec0").html());
        samesendguess = jQuery.trim($("#guesssend1").html());
        samerecguess = jQuery.trim($("#guessrec1").html());
        diffsendguess = jQuery.trim($("#guesssend2").html());
        diffrecguess = jQuery.trim($("#guessrec2").html());

        unksendact = jQuery.trim($("#actualsend0").html());
        unkrecact = jQuery.trim($("#actualrec0").html());
        samesendact = jQuery.trim($("#actualsend1").html());
        samerecact = jQuery.trim($("#actualrec1").html());
        diffsendact = jQuery.trim($("#actualsend2").html());
        diffrecact = jQuery.trim($("#actualrec2").html());

        unksendearned = jQuery.trim($("#unksendearned").html());
        unkrecearned = jQuery.trim($("#unkrecearned").html());
        samesendearned = jQuery.trim($("#samesendearned").html());
        samerecearned = jQuery.trim($("#samerecearned").html());
        diffsendearned = jQuery.trim($("#diffsendearned").html());
        diffrecearned = jQuery.trim($("#diffrecearned").html());
        maxamount = jQuery.trim($("#maxamount").html());

        $("#diffbutton").attr("value", difftext);


        peak = jQuery.trim($("#resultpeak").html());
        span = jQuery.trim($("#resultspan").html());
        setylabel();
        setactualdata();
        setguessdata();
        showunk();

});
}))


function calcSeries(points, guess, peak, span){
    var inter1;
    for(x=0.0;x<1.0;x=x+.01){
        var xy = [];
        xy.push(x);
        inter1 = (x - guess) * (x - guess);
        y = Math.max(0,(1 - span * inter1) * peak);
        xy.push(y);
        points.push(xy);
    }
    return points;
}

function plotareas(tag, guessdata, actualdata, color){
$.plot($(tag), [actualdata, guessdata],  {
    colors:[color, "#ff0000"] ,
    yaxis: {
        max: 5,
        ticks:yticklabels
    },
    xaxis: {
        max: 1 ,
        ticks:xticklabels
    },
    lines:{
        lineWidth: 4
    }
});
}

function setylabel(){
   yticklabels = [];
   yticklabels.push([0,"$0"]);
   yticklabels.push([peak/2,""]);
   yticklabels.push([peak,"$" + maxamount]);
}

function setactualdata(){
   unksendactdata = [];
   samesendactdata = [];
   diffsendactdata = [];
   
   unkrecactdata = [];
   samerecactdata = [];
   diffrecactdata = [];

   unksendactdata.push([unksendact,0]);
   unksendactdata.push([unksendact,peak]);
   samesendactdata.push([samesendact,0]);
   samesendactdata.push([samesendact,peak]);
   diffsendactdata.push([diffsendact,0]);
   diffsendactdata.push([diffsendact,peak]);

   unkrecactdata.push([unkrecact,0]);
   unkrecactdata.push([unkrecact,peak]);
   samerecactdata.push([samerecact,0]);
   samerecactdata.push([samerecact,peak]);
   diffrecactdata.push([diffrecact,0]);
   diffrecactdata.push([diffrecact,peak]);

}

function setguessdata(){
    calcSeries(unksenddata, unksendguess, peak, span);
    calcSeries(samesenddata, samesendguess, peak, span);
    calcSeries(diffsenddata, diffsendguess, peak, span);

    calcSeries(unkrecdata, unkrecguess, peak, span);
    calcSeries(samerecdata, samerecguess, peak, span);
    calcSeries(diffrecdata, diffrecguess, peak, span);
}

function showunk(){
    if(showing != "unk"){
        $("#resultstitle").html(resultstitle + " Unknown Age Group");
        $("#unkbutton").css("background-color", "#ffff66");
        $("#samebutton").css("background-color", "silver");
        $("#diffbutton").css("background-color", "silver");
        plotareas(sendmsgs, unksenddata, unksendactdata, green);
        plotareas(recmsgs, unkrecdata, unkrecactdata, blue);
        $("#falsemsgguess").html(Math.round(unksendguess * 100));
        $("#falsemsgactual").html(Math.round(unksendact * 100));
        $("#falsemsgearned").html("$" + Number(unksendearned).toFixed(2));
        $("#challengemsgguess").html(Math.round(unkrecguess * 100));
        $("#challengemsgactual").html(Math.round(unkrecact * 100));
        $("#challengemsgearned").html("$" + Number(unkrecearned).toFixed(2));
        unkpressed = true;
        enabledone();
        showing = "unk"
    }
}

function showsame(){
    if(showing != "same"){
        $("#resultstitle").html(resultstitle + " Same Age Group");
        $("#unkbutton").css("background-color", "silver");
        $("#samebutton").css("background-color", "#ffff66");
        $("#diffbutton").css("background-color", "silver");
        plotareas(sendmsgs, samesenddata, samesendactdata, green);
        plotareas(recmsgs, samerecdata, samerecactdata, blue);
        $("#falsemsgguess").html(Math.round(samesendguess * 100));
        $("#falsemsgactual").html(Math.round(samesendact * 100));
        $("#falsemsgearned").html("$" + Number(samesendearned).toFixed(2));
        $("#challengemsgguess").html(Math.round(samerecguess * 100));
        $("#challengemsgactual").html(Math.round(samerecact * 100));
        $("#challengemsgearned").html("$" + Number(samerecearned).toFixed(2));
        samepressed = true;
        enabledone();
        showing = "same"
    }
}

function showdiff(){
    if(showing != "diff"){
        $("#resultstitle").html(resultstitle + " " + difftext);
        $("#unkbutton").css("background-color", "silver");
        $("#samebutton").css("background-color", "silver");
        $("#diffbutton").css("background-color", "#ffff66");
        plotareas(sendmsgs, diffsenddata, diffsendactdata, green);
        plotareas(recmsgs, diffrecdata, diffrecactdata, blue);
        $("#falsemsgguess").html(Math.round(diffsendguess * 100));
        $("#falsemsgactual").html(Math.round(diffsendact * 100));
        $("#falsemsgearned").html("$" + Number(diffsendearned).toFixed(2));
        $("#challengemsgguess").html(Math.round(diffrecguess * 100));
        $("#challengemsgactual").html(Math.round(diffrecact * 100));
        $("#challengemsgearned").html("$" + Number(diffrecearned).toFixed(2));
        diffpressed = true;
        enabledone();
        showing = "diff"
    }
}

function done(){
  $("#unkbutton").attr("disabled", "disabled");
  $("#samebutton").attr("disabled", "disabled");
  $("#diffbutton").attr("disabled", "disabled");
  $("#donebutton").attr("disabled", "disabled");
   leaveok();
  $(window.location).attr("href", "results2");
 //       $("#donebutton").attr("disabled", "disabled");
//        $.post( "results/done","html" );
}

