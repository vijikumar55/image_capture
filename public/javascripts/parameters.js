

$((function () {
    $("#amountbutton").click(function(){
        var currentvalue = $("#amountvalue").html();
        var answer = prompt("Enter new Amount",currentvalue);
        if(answer != null){
            answer = jQuery.trim(answer);
            if(answer != currentvalue){
                changeamount(answer);
            }
        }
    });
    $("#requiredusersbutton").click(function(){
        var currentvalue = $("#requiredusersvalue").html();
        var answer = prompt("Enter number of required users. (For Testing Only)",currentvalue);
        if(answer != null){
            answer = jQuery.trim(answer);
            if(answer != currentvalue && answer <= 40 && answer > 0 ){
                changerequiredusers(answer);
            }
        }
    });
    $("#autoplaybutton").click(function(){
        var currentvalue = $("#autoplayvalue").html();
        var newval;
        if(currentvalue == "Off" || currentvalue == "off"){
            newval = "On";
        }else{
            newval = "Off";
        }
        var answer = confirm("Toggle Autoplay " + newval + "? (For Testing Only) ");
        if(answer == true){
            changeautoplay(newval);
        }
    });
    $("#allowloginsbutton").click(function(){
        var currentvalue = $("#allowloginsvalue").html();
        var newval;
        var answer;
        if(experimentrunning){
            alert("Cannot disable login while experiment is running!");
        }else{
            if(currentvalue == "No" || currentvalue == "no"){
                newval = "Yes";
                answer = confirm("Toggle Allow User Logins to " + newval + "?");
            }else{
                newval = "No";
                answer = confirm("Toggle Allow User Logins to " + newval + "?  WARNING!!! WARNING!!! This WILL logoff ALL logged in users!!!");
            }
            if(answer == true){
                changeallowlogins(newval);
            }
        }
    });
    $("#requirepasswordsbutton").click(function(){
        var currentvalue = $("#requirepasswordsvalue").html();
        var newval;
        if(currentvalue == "No" || currentvalue == "no"){
            newval = "Yes";
        }else{
            newval = "No";
        }
        var answer = confirm("Toggle Require Passwords " + newval + "? ");
        if(answer == true){
            changerequirepasswords(newval);
        }
    });

}));

function changeamount(newvalue){
    var senddata = {};
    $("#amountvalue").html(newvalue);
    senddata.amount = newvalue;
    $.post( controllername +"/changeamount", senddata ,"json" );
}
function changerequiredusers(newvalue){
    var senddata = {};
    $("#requiredusersvalue").html(newvalue);
    senddata.requiredusers = newvalue;
    $.post( controllername +"/changerequiredusers", senddata ,"json" );
}
function changeautoplay(newvalue){
    var senddata = {};
    $("#autoplayvalue").html(newvalue);
    senddata.autoplay = newvalue;
    $.post( controllername +"/changeautoplay", senddata ,"json" );
}
function changeallowlogins(newvalue){
    var senddata = {};
    $("#allowloginsvalue").html(newvalue);
    senddata.allowlogins = newvalue;
    $.post( controllername +"/changeallowlogins", senddata ,"json" );
}
function changerequirepasswords(newvalue){
    var senddata = {};
    $("#requirepasswordsvalue").html(newvalue);
    senddata.requrepasswords = newvalue;
    $.post( controllername +"/changerequirepasswords", senddata ,"json" );
}


function updateamount(newvalue){
    currentvalue = $("#amountvalue").html();
    if(currentvalue != newvalue){
       $("#amountvalue").html(newvalue);
    }
}
function updaterequiredusers(newvalue){
    currentvalue = $("#requiredusersvalue").html();
    if(currentvalue != newvalue){
       $("#requiredusersvalue").html(newvalue);
    }
}
function updateautoplay(newvalue){
    currentvalue = $("#autoplayvalue").html();
    if(currentvalue != newvalue){
       $("#autoplayvalue").html(newvalue);
    }
}
function updateallowlogins(newvalue){
    currentvalue = $("#allowloginsvalue").html();
    allowlogins = newvalue;
    if(currentvalue != newvalue){
       $("#allowloginsvalue").html(newvalue);
    }
}
function updaterequirepasswords(newvalue){
    currentvalue = $("#requirepasswordsvalue").html();
    if(currentvalue != newvalue){
       $("#requirepasswordsvalue").html(newvalue);
    }
}
