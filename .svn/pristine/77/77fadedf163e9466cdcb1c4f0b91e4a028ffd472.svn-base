$((function() {
    $(function() {
        var group = jQuery.trim($("#group").html());
        var autologin = jQuery.trim($("#autologin").html());
        if(group == 1){
            hidebutton2();
        }
        if(group == 2){
            hidebutton1();
        }
        if(autologin == "yes"){
            var waittime = Math.floor(Math.random() * 5000 ) + 2
            $("#covercontrols").show();
            setInterval("autologin()", waittime);
        }else{
            $("#covercontrols").hide();
        }
    }
    );
}));

function hidebutton1(){
    $("#submitbutton1").hide();
}

function hidebutton2(){
    $("#submitbutton2").hide();
}

function autologin(){
    if($("#submitbutton1").is(":visible")){
        $("#submitbutton1").click();
    }else if($("#submitbutton2").is(":visible")){
        $("#submitbutton2").click();
    }
}