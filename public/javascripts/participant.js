var autoplayparticipantflag = false;

var currentactivity = "wait";
var unksend = [];
var unksendresults = {};
var unksendcount = -1;
var sentunksend = false;

var samesend = [];
var samesendresults = {};
var samesendcount = -1;
var sentsamesend = false;

var diffsend = [];
var diffsendresults = {};
var diffsendcount = -1;
var sentdiffsend = false;

var unkrec = [];
var unkreccount = -1;
var unkreccountdone = -1;
var sentunkrec = false;

var samerec = {};
var samereccount = -1;
var samereccountdone = -1;
var sentsamerec = false;

var diffrec = {};
var diffreccount = -1;
var diffreccountdone = -1;
var sentdiffrec = false;

var senddataloaded = false;
var recdataloaded = false;

var flipvalue;
var splitvalue;
var sendid;
var recid;

var sendtype = "none";
var rectype = "none";
var sendcomplete = false;

var receivermsgunk, receivermsgsame, receivermsgdiff;
var sendermsgunk, sendermsgsame, sendermsgdiff;

var currentreceivergroupmsg = "";
var currentsendergroupmsg = "";


$((function () {
    $(function() {
        receivermsgunk = jQuery.trim($("#receivermsgunk").html());
        receivermsgsame = jQuery.trim($("#receivermsgsame").html());
        receivermsgdiff = jQuery.trim($("#receivermsgdiff").html());

        sendermsgunk = jQuery.trim($("#sendermsgunk").html());
        sendermsgsame = jQuery.trim($("#sendermsgsame").html());
        sendermsgdiff = jQuery.trim($("#sendermsgdiff").html());
        $("#receiverok").hide();
        $("#senderok").hide();
        $("#receivergroupok").hide();
        $("#sendergroupok").hide();
        $("#sendercheck").hide();
        $("#receivergroupcheck").hide();
        $("#receivercheck").hide();
        $("#sendergroupcheck").hide();

       }
    );
    $("#receiverok").click(function(){
        $("#receiverok").hide();
        $("#receivercheck").show();
        promptrecmsg();
     });
    $("#senderok").click(function(){
        $("#senderok").hide();
        $("#sendercheck").show();
        setnextsend();

     });
    $("#receivergroupok").click(function(){
        $("#receivergroupok").hide();
        $("#receivergroupcheck").show();
        nextflip();
     });
    $("#sendergroupok").click(function(){
        $("#sendergroupok").hide();
        $("#sendergroupcheck").show();
        messagesplit(splitmsg);
     });

}));

function updateremoteprep(){
    // updatedatahash = {};
    if (!senddataloaded && ( currentactivity == "wait" || currentactivity == "send")){
        updatedatahash.needsenddata = true;
    }
    if (!recdataloaded && (currentactivity == "send" || currentactivity == "receive") && sendcomplete){
        updatedatahash.needrecdata = true;
    }
    if(currentactivity == "send"){
        formatsenddata();
    }
    else if(currentactivity == "receive"){
        formatrecdata();
    }
}

function formatsenddata(){
    if(!sentunksend  && sendtype == "same"){
        updatedatahash.unksend = [unksendresults[0],unksendresults[1],unksendresults[2],unksendresults[3],unksendresults[4],unksendresults[5]];
        sentunksend = true;
    }
    else if(!sentsamesend  && sendtype == "diff"){
        updatedatahash.samesend = [samesendresults[0],samesendresults[1],samesendresults[2],samesendresults[3],samesendresults[4],samesendresults[5]];
        sentsamesend = true;
    }
    else if(!sentdiffsend  && sendtype == "done"){
        updatedatahash.diffsend = [diffsendresults[0],diffsendresults[1],diffsendresults[2],diffsendresults[3],diffsendresults[4],diffsendresults[5]];
        sentdiffsend = true;
        sendcomplete = true;
    }
}

function formatrecdata(){
    if(!sentunkrec  && rectype == "same"){
        updatedatahash.unkrec = [unkrec[0],unkrec[1],unkrec[2],unkrec[3],unkrec[4],unkrec[5]];
        sentunkrec = true;
    }
    else if(!sentsamerec  && rectype == "diff"){
        updatedatahash.samerec = [samerec[0],samerec[1],samerec[2],samerec[3],samerec[4],samerec[5]];
        sentsamerec = true;
    }
    else if(!sentdiffrec  && rectype == "done"){
        updatedatahash.diffrec = [diffrec[0],diffrec[1],diffrec[2],diffrec[3],diffrec[4],diffrec[5]];
        sentdiffrec = true;
    }
}


function updateremotesent(){
   updatedatahash = {};
}


function remoteupdatereturn(data){
    redirectcmd(data);
    if(data.activity !== undefined){
        updateactivity(data.activity);
    }
    if(data.unksend !== undefined){
        unksend = data.unksend;
    }
    if(data.samesend !== undefined){
        samesend = data.samesend;
    }
    if(data.diffsend !== undefined){
        diffsend = data.diffsend;
        senddataloaded =true;
    }
    if(data.unkrec !== undefined){
        unkrec = data.unkrec;
    }
    if(data.samerec !== undefined){
        samerec = data.samerec;
    }
    if(data.diffrec !== undefined){
        diffrec = data.diffrec;
        recdataloaded =true;
    }
    if(data.autoplay !== undefined){
        var newflag = data.autoplay;
        var oldflag = autoplayparticipantflag;
        autoplayparticipantflag = newflag;
        if(!oldflag && newflag){
             startautoplay();
        }
    }
}

function updateactivity(activity){
// This function controls the activity state of the screen
    switch (activity){
        case "wait":
            if(currentactivity !== "wait"){
                waitmsg();
                currentactivity = "wait";
            }
            break;
        case "send":
            if(currentactivity !== "send" && senddataloaded ){
                senderscreen();
                //setnextsend();
                currentactivity = "send";
            }
            break;
        case "receive":
            if(currentactivity !== "receive" && recdataloaded){
                receiverscreen();
 //               promptrecmsg();
                currentactivity = "receive";
            }
             break;
        case "results":
             break;
        default:
            break;
    }
}

function coinfilp(){
// This is the actual coin flipping function overriding the original place holder function.
    setgametree(0);
    flipvalue = actualflip();
}

function acceptmessage(){
    hidesplitbuttons();
    setgametree(0);
    if(rectype == "unk"){
        unkreccountdone++;
        unkrec[unkreccountdone].accept = 1;
        unkrec[unkreccountdone].challenge = 0;
    }
    if(rectype == "same"){
        samereccountdone++;
        samerec[samereccountdone].accept = 1;
        samerec[samereccountdone].challenge = 0;
    }
    if(rectype == "diff"){
        diffreccountdone++;
        diffrec[diffreccountdone].accept = 1;
        diffrec[diffreccountdone].challenge = 0;
    }
    setTimeout("promptrecmsg()",900);
}
function challengemessage(){
    hidesplitbuttons();
    setgametree(0);

    if(rectype == "unk"){
        unkreccountdone++;    
        unkrec[unkreccountdone].accept = 0;
        unkrec[unkreccountdone].challenge = 1;
    }
    if(rectype == "same"){
        samereccountdone++;    
        samerec[samereccountdone].accept = 0;
        samerec[samereccountdone].challenge = 1;
    }
    if(rectype == "diff"){
        diffreccountdone++;    
        diffrec[diffreccountdone].accept = 0;
        diffrec[diffreccountdone].challenge = 1;
    }
    setTimeout("promptrecmsg()",900);
}
function setsplitmsg(msg){
    var splitmsg;
    if(msg == 2){
        splitmsg = "Two to split";
    }else{
        splitmsg = "Four to split";
    }
    $("#receiversendermessage").html(splitmsg);

}

function promptrecmsg(){
    if (unkreccount < 5 ){
        if (unkreccount == unkreccountdone){
            rectype = "unk";
            unkreccount++;
            sendid = unkrec[unkreccount].sid;
            recid = unkrec[unkreccount].rid;
            splitmsg =  unkrec[unkreccount].split;
            setsendergroupmsg(sendermsgunk);
        }
    }
    else if (samereccount < 5){
        if (samereccount == samereccountdone){
            rectype = "same";
            samereccount++;
            sendid = samerec[samereccount].sid;
            recid = samerec[samereccount].rid;
            splitmsg =  samerec[samereccount].split;
            setsendergroupmsg(sendermsgsame);
        }
    }
    else if (diffreccount < 5){
        if (diffreccount == diffreccountdone){
            rectype = "diff";
            diffreccount++;
            sendid = diffrec[diffreccount].sid;
            recid = diffrec[diffreccount].rid;
            splitmsg =  diffrec[diffreccount].split;
            setsendergroupmsg(sendermsgdiff);
        }
    }
    else{
        rectype = "done";
        waitmsg("Waiting for other participants to finish ...");
    }
}

function flipmessage(msg){

    splitvalue = msg;
    switch (sendtype){
        case "none":
            break;
        case "unk":
            unksendresults[unksendcount] = {
                "rid":recid, 
                "flip":flipvalue, 
                "split":splitvalue
            };
            break;
        case "same":
            samesendresults[samesendcount] = {
                "rid":recid, 
                "flip":flipvalue, 
                "split":splitvalue
            };
            break;
        case "diff":
            diffsendresults[diffsendcount] = {
                "rid":recid, 
                "flip":flipvalue, 
                "split":splitvalue
            };
            break;
        case "done":
            break;               
    }
    setnextsend();
}

function setnextsend(){
    if (unksendcount < 5 ){
        sendtype = "unk";
        unksendcount++;
        sendid = myuserid;
        recid = unksend[unksendcount];
        setreceivergroupmsg(receivermsgunk);
    }
    else if (samesendcount < 5){
        sendtype = "same";
        samesendcount++;
        sendid = myuserid;
        recid = samesend[samesendcount];
        setreceivergroupmsg(receivermsgsame);
    }
    else if (diffsendcount < 5){
        sendtype = "diff";
        diffsendcount++;
        sendid = myuserid;
        recid = diffsend[diffsendcount];
        setreceivergroupmsg(receivermsgdiff);
    }
    else{
        sendtype = "done";
        waitmsg("Waiting to receive messages from other participants ...");
    }

}

function setreceivergroupmsg(msg){
    if(currentreceivergroupmsg != msg){
        $("#receivergroup").html(msg);
        $("#receivergroupcheck").hide();
        $("#receivergroupok").show();
        currentreceivergroupmsg = msg;
        setgametree(0);
    }else{
        nextflip();
    }
}

function setsendergroupmsg(msg){
    if(currentsendergroupmsg != msg){
        $("#sendergroup").html(msg);
        $("#sendergroupcheck").hide();
        $("#sendergroupok").show();
        currentsendergroupmsg = msg;
        setgametree(0);
    }else{
        messagesplit(splitmsg);
    }
}