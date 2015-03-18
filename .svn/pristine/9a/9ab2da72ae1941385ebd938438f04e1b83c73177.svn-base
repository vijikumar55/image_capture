var experimentrunning = false;
var allowlogins = "No";


$((function (){
    $("#datafilesbutton").click(function(){
        window.open ("dataaccess", "Data Files","resizable=1,scrollbars=1,width=900,height=600");
    });
    $("#startbutton").click(function(){
        var answer = confirm("Confirm start experiment?");
        if (answer){
            startexperiment();
        }
    });
    $("#resetbutton").click(function(){
        var answer = confirm("Confirm reset experiment?  This will stop the running experiment and all data from that experiment will be lost!");
        if (answer){
            resetexperiment();
        }
    });
    getcontrollername();
    remoteupdate();

}));


function startexperiment(){
        $("#startbutton").attr("disabled", "disabled");
        running = true;
        $.post( "control/startexperiment" );
}

function resetexperiment(){
        $("#resetbutton").attr("disabled", "disabled");
        $.post( "control/resetexperiment" );
}

function updateremoteprep(){
    //updatedatahash = {"item1" : 1, "item2" : [33,22,66] }
}

function remoteupdatereturn(data){
    //alert("remoteupdatereturn(data.can_start) - " + data.can_start)
    updateconnections(data.usersonline, data.usercomputerid);
    updateuserstatus(data.userstatus)
    updatestartbutton(data.can_start, data.running, data.completed);
    updateparameters(data);
}


function updateconnections(conn,ipadd){
    var connlen = 41;
    for(var i=1; i<connlen; i++) {
	var value = conn[i];
	//alert(i + "=) "+value);
        var eidred = "#imgidred" + i;
        var eidgreen = "#imgidgreen" + i;
        if (value){
            $(eidred).hide();
            $(eidgreen).show();
        }else {
            $(eidred).show();
            $(eidgreen).hide();
        }
        var ipaddid = "#utr"+i+"c4";
        $(ipaddid).html(ipadd[i]);
        var statusid = "#utr"+i+"c5";
        $(statusid).html(ipadd[i]);
    }
}
function updateuserstatus(statusmsgs){
    var len = 41;
    for(var i=1; i<len; i++) {
        var statusid = "#utr"+i+"c5";
        if(allowlogins == "Yes"){
            $(statusid).html(statusmsgs[i]);
        } else{
            $(statusid).html("Login NOT Allowed!");
        }
    }
}


function updatestartbutton(canstart, running, completed){
    if (!running){
        experimentrunning = false;
        if(completed){
            $("#startbutton").attr("value", "Experiment Completed");
            $("#startbutton").attr("disabled", "disabled");
            $("#resetbutton").removeAttr("disabled");
        }else{
            $("#startbutton").attr("value", "Start Experiment");
            $("#resetbutton").attr("disabled", "disabled");
            }
        if(canstart){
            $("#startbutton").removeAttr("disabled");
        }else{
            $("#startbutton").attr("disabled", "disabled");
        }
    }else{
        if(completed){
            $("#startbutton").attr("value", "Experiment Completed");
            $("#startbutton").attr("disabled", "disabled");
            $("#resetbutton").removeAttr("disabled");
        }else{
            $("#startbutton").attr("disabled", "disabled");
            $("#startbutton").attr("value", "Running !");
            $("#resetbutton").removeAttr("disabled");
            experimentrunning = true;
        }
    }
}


function updateparameters(data){
    var amount = data.amount;
    var requiredusers = data.requiredusers;
    var autoplay = data.autoplay;
    var allowlogins = data.allowlogins;
    var requirepasswords = data.requirepasswords

    updateamount(amount);
    updaterequiredusers(requiredusers);
    updateautoplay(autoplay);
    updateallowlogins(allowlogins);
    updaterequirepasswords(requirepasswords);
}