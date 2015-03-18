var autoplayfinalflag = false;


function remoteupdatereturn(data){
    redirectcmd(data);
    if(data.autoplay !== undefined){
        var newflag = data.autoplay;
        var oldflag = autoplayfinalflag;
        autoplayfinalflag = newflag;
        if(!oldflag && newflag){
             startautoplay();
        }
    }

}

