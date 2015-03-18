var autoplayresultsflag = false;

var doneenabled = false;
var unkpressed = true;
var samepressed = false;
var diffpressed = false;
var donepushed = false;

var timefirstreminder = 300000;
var timeotherreminders = 120000;



$((function () {
    $(function() {
        $("#donebutton").attr("disabled", "disabled");
        //setTimeout("reminder()",120000);
        setTimeout("reminder()",timefirstreminder);

    }
    );
$(function() {
    $("#unkbutton").click(function(){
        showunk();
    });
    $("#samebutton").click(function(){
        showsame();
    });
    $("#diffbutton").click(function(){
        showdiff();
    });
    $("#donebutton").click(function(){
        donepushed = true;
        done();
    });

});
}))

function enabledone(){
    if(unkpressed && samepressed && diffpressed){
        if(!doneenabled){
            $("#donebutton").removeAttr("disabled");
        }
    }
}



function remoteupdatereturn(data){
    redirectcmd(data);
    if(data.autoplay !== undefined){
        var newflag = data.autoplay;
        var oldflag = autoplayresultsflag;
        autoplayresultsflag = newflag;
        if(!oldflag && newflag){
             startautoplay();
        }
    }

}

function reminder(){
    if(!donepushed){
        jAlert("After reviewing all results, please click on the DONE button, so that the experiment can progress. \n\
           <br><br> The experiment cannot progress until everyone has clicked on the DONE button.", "Reminder!", function(){
            setTimeout("reminder()",timeotherreminders);
        });
    }
}







