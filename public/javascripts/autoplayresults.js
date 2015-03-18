var unkautopressed = false;
var sameautopressed = false;
var diffautipressed = false;
var unk1autopressed = false;
var same1autopressed = false;
var diff1autipressed = false;
var unk2autopressed = false;
var same2autopressed = false;
var diff2autipressed = false;
var doneautopressed = false;


function startautoplay(){
    if(autoplayresultsflag){
        var newtime = Math.floor(Math.random() * 2000 ) + 1;
       setTimeout("autoplayresults()",newtime);
    }
}

function autoplayresults(){
    if( !$('#unkbutton1').is(':disabled') && !unk1autopressed){
       $("#unkbutton1").click();
       unk1autopressed = true;
    }else if(!$('#samebutton1').is(':disabled') && !same1autopressed){
       $("#samebutton1").click();
       same1autopressed = true;
    }else if(!$('#diffbutton1').is(':disabled') && !diff1autipressed){
       $("#diffbutton1").click();
       diff1autipressed = true;
    }else if(!$('#unkbutton2').is(':disabled') && !unk2autopressed){
       $("#unkbutton2").click();
       unk2autopressed = true;
    }else if(!$('#samebutton2').is(':disabled') && !same2autopressed){
       $("#samebutton2").click();
       same2autopressed = true;
    }else if(!$('#diffbutton2').is(':disabled') && !diff2autipressed){
       $("#diffbutton2").click();
       diff2autipressed = true;
    }else if(!$('#unkbutton').is(':disabled') && !unkautopressed){
       $("#unkbutton").click();
       unkautopressed = true;
    }else if(!$('#samebutton').is(':disabled') && !sameautopressed){
       $("#samebutton").click();
       sameautopressed = true;
    }else if(!$('#diffbutton').is(':disabled') && !diffautipressed){
       $("#diffbutton").click();
       diffautipressed = true;
    }else if(!$('#donebutton').is(':disabled') && !doneautopressed){
       $("#donebutton").click();
       doneautopressed = true;
    }
    startautoplay();
}