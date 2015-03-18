
$((function() {

   $(document).bind("keydown", function(event) {
      // track enter key
      var keycode = (event.keyCode ? event.keyCode : (event.which ? event.which : event.charCode));
      if (keycode == 13) { // keycode for enter key
         // force the 'Enter Key' to implicitly click the Update button
         $("#submitbutton").submit();
         //alert("Pressed Enter Key")
         return false;
      } else  {
         return true;
      }
   }); // end of function
    $(function() {
        $("#covercontrols").hide();
    });

    $(function() {
        // This function is use to reload the current page if the div == yes
        //   The reason for this that on the first time connecting to this site
        //   the session id will not be sent to the server.  The reload will
        //   allow the server to see the cookie session id.
        var reload = $("#reloadsession").text();
        leaveok();
        if (reload == "yes"){
            //alert("Will Reload");
            location.reload();
        }
    });
}));
