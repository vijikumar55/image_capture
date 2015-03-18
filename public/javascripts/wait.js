
$((function (){
  $("#marquee").marquee();
}));

function updateremoteprep(){
//    updatedatahash = {"UaerItem1" : "Test Sting", "Useritem2" : [111,222,333,000] };
}

function remoteupdatereturn(data){
    //alert("remoteupdatereturn(data.running) - " + data.running)
    //alert("remoteupdatereturn(data.can_start) - " + data.can_start)
    //alert("remoteupdatereturn(data.connections) - " + data.connections.connections)
    if(data.redirect){
        //alert("Window Location = [" + window.location + "]");
        if(data.path != "wait"){
            leaveok();
            window.location = data.path;
        }
    }

}
