/* 
 * Samples and code snippits for testing and experimintation.
 * Not to be used in production.
 */

jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})


$((function() {
    $(function() {
        timerint = self.setInterval("remoteupdate()",10000);
        }
    );
}));

function xxremoteupdate(){

    var myarray = new Array(5);
    var datahash = {
        "item1" : 33,
        "item2" : 44
    };
    myarray[0] = 4
    myarray[1] = 3
    myarray[2] = 5

    datahash["item2"] = myarray;
    //alert("Got timer call - " + dataAsJSON.toString() );

    //$.get("control/pageupdate.json", {"item1" : 1, "item2" : 44} , null, "json");
    $.post("control/pageupdate.json", datahash , function(data){
        remoteupdatereturn(data)}, "json" );

    //alert("Got timer call - " + dataAsJSON );
}

function remoteupdatereturn(data){
    //alert("remoteupdatereturn call -  State = " +  data.State + "  Array = " + data.dataarray);
}

