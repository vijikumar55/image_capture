


$((function (){
    $(function() {
        $("#summaryouterdiv").hide();
        $("#okbutton").hide();
        $("#thankyououterdiv").hide();
        $("#enternameouterdiv").show();

    });
    $("#submitbutton").click(function(){
        buttonpressed();
    });
    $("#okbutton").click(function(){
        finalcleanup();
    });

    $(document).bind("keydown", function(event) {
        // track enter key
        var keycode = (event.keyCode ? event.keyCode : (event.which ? event.which : event.charCode));
        if (keycode == 13) { // keycode for enter key
            // force the 'Enter Key' to implicitly click the Update button
            buttonpressed();
            //alert("Pressed Enter Key")
            return false;
        } else  {
            return true;
        }
    }); // end of function


}));


function buttonpressed(){
    var username;
    username = $("#username").val()
    if(validateusername(username)){
        submitusername(username);
        $("#summaryouterdiv").show();
        $("#okbutton").show();
        $("#enternameouterdiv").hide();
        setTimeout("finalcleanup()",120000);
    }else{
        alert("I did not recognize this as a first and last name!  Please enter both first and last name.")
    }
}


function validateusername(name){
    var namelength = name.length;
    var space = name.search(" ");
    returnvalue = false;
    if(namelength > 4 && space > 0){
        returnvalue = true;
    }
    return returnvalue;
}

function submitusername(username){
    var msghash = {
        "username" : username
    }
    $.post( controllername +"/savename", msghash , function(){}, "json" );
}

var autoplaypayoutflag = false;


function remoteupdatereturn(data){
    redirectcmd(data);
    if(data.autoplay !== undefined){
        var newflag = data.autoplay;
        var oldflag = autoplaypayoutflag;
        autoplaypayoutflag = newflag;
        if(!oldflag && newflag){
             startautoplay();
        }
    }

}

function finalcleanup(){
        $("#summaryouterdiv").hide();
        $("#okbutton").hide();
        $("#enternameouterdiv").hide();
        $("#thankyououterdiv").show();
        leaveok();
}
