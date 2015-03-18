var myuserid;
var okaytoleave = false;

$((function () {
    $(function() {
        myuserid = jQuery.trim($("#myuserid").html());
        if (myuserid == null){controllername = "0"}
        //alert("myuserid = [" + myuserid + "]");
        }
    );
    $(window).bind("beforeunload", function() {
        if(!okaytoleave){
            return "Please do not leave the experiment. Press the Stay on this Page button!!";
        }
    });

}));


function leaveok(){
    okaytoleave = true;
}
