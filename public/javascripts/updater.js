var timerint;
var controllername;
var updatedatahash = {};


$((function() {   
    $(function() {
        var pagetime = $("#pageupdatetime").html();
        if (pagetime == null){pagetime = 3000}
        //alert("pagetime = " + pagetime);
        timerint = self.setInterval("remoteupdate()",pagetime);
        //alert("pagetime = " + pagetime)
        }
    );
    $(function() {
        getcontrollername();
    });

}));

function getcontrollername(){
        controllername = jQuery.trim($("#controllername").html());
        if (controllername == null){controllername = ""}
        //alert("controllername = [" + controllername + "]");
//        alert("pagetime = " + pagetime);

}

function remoteupdate(){
    // This function is called as a periodic update of the page.
    // It sends and receives JSON onject and is not intended to do general
    // DOM update using RJS.
        //alert("controllername = [" + controllername + "]");
    updateremoteprep();
//    alert("controllername = [" + controllername + "]");
    $.post( controllername +"/pageupdate", updatedatahash , function(data){
        remoteupdatereturn(data)}, "json" );
    updateremotesent();
}

function remoteupdatereturn(data){
   //placeholder function to process data.
    //alert("remoteupdatereturn(data.running) - " + data.running)
    //alert("remoteupdatereturn(data.can_start) - " + data.can_start)
    //alert("remoteupdatereturn(data.connections) - " + data.connections.connections)
    redirectcmd(data)
}

function updateremotedatahash(){
   //placeholder function to return json data.
}

function updateremoteprep(){
   //placeholder function to return json data.
}
function updateremotesent(){
   //placeholder function to return json data.
}

function redirectcmd(data){
    if(data.redirect !== undefined){
        if(data.redirect == true){
            if(data.path !== undefined){
            leaveok();
            window.location = data.path;
            }
        }
    }
}