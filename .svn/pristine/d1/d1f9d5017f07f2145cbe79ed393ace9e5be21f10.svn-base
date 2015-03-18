var dicestate = 0;
var sidecount = 0;
var rollvalue;
var dicecolor = "white";
var dicetype = 0;
var currentdiceimages;

var diceimages = new Array(6);
diceimages[0] = new Image();
diceimages[0].src = "images/dice/face1.jpg";
diceimages[1] = new Image();
diceimages[1].src = "images/dice/face2.jpg";
diceimages[2] = new Image();
diceimages[2].src = "images/dice/face3.jpg";
diceimages[3] = new Image();
diceimages[3].src = "images/dice/face4.jpg";
diceimages[4] = new Image();
diceimages[4].src = "images/dice/face5.jpg";
diceimages[5] = new Image();
diceimages[5].src = "images/dice/face6.jpg";

var reddiceimages = new Array(6);
reddiceimages[0] = new Image();
reddiceimages[0].src = "images/dice/redface1.jpg";
reddiceimages[1] = new Image();
reddiceimages[1].src = "images/dice/redface2.jpg";
reddiceimages[2] = new Image();
reddiceimages[2].src = "images/dice/redface3.jpg";
reddiceimages[3] = new Image();
reddiceimages[3].src = "images/dice/redface4.jpg";
reddiceimages[4] = new Image();
reddiceimages[4].src = "images/dice/redface5.jpg";
reddiceimages[5] = new Image();
reddiceimages[5].src = "images/dice/redface6.jpg";

var imageindex = new Array(3,4,2,1,5,0);
var rolling = null;
var diceside = 0;

$((function () {
    $("#rollbutton").click(function(){
        $("#rollbutton").hide();
        diceroll();
    });
}));

function actualroll(){
    rollvalue = Math.round(Math.random() * 5);
    //$("#rollbutton").hide();
    animatedice();
    return rollvalue
}


function animatedice(){
        
    randside = getdiceside();
    dicestate = randside;
    highlightselection(dicestate);
    sidecount++;
    if ((sidecount > 30) ) {
        highlightselection(rollvalue);
        sidecount = 0;
        if(dicetype == 0){
            setTimeout("shownext()", 1500);
        }else{
            if(dicecolor == "white"){
                setTimeout("pickrow()", 1500);
            }else{
                setTimeout("shownext()", 1500);
            }
        }
    }else{
        rolling = setTimeout("animatedice()", 120);
    }
}

function getdiceside(){
   randside = Math.round(Math.random() * 5 );
   if(randside == dicestate){
       randside = randside + 1;
       if(randside > 5){
           randside = 0;
       }
   }
   return randside
}

function highlightselection(idx){
   $("#dice").attr("src", currentdiceimages[idx].src);
   if(dicecolor == "white"){
        highlightbox(idx);
   }else{
        highlightrow(idx);
   }
}

function highlightbox(idx){
    $("#highlight0").hide();
    $("#highlight1").hide();
    $("#highlight2").hide();
    $("#highlight3").hide();
    $("#highlight4").hide();
    $("#highlight5").hide();

    $("#highlight" + idx ).show();
}
function nohighlight(){
    if(dicetype == 0){
        $("#highlight0").hide();
        $("#highlight1").hide();
        $("#highlight2").hide();
        $("#highlight3").hide();
        $("#highlight4").hide();
        $("#highlight5").hide();
    }else{
        $("#highlight0").hide();
        $("#highlight1").hide();
        $("#highlight2").hide();
        $("#highlight3").hide();
        $("#highlight4").hide();
        $("#highlight5").hide();
        $("#highlightrow0").hide();
        $("#highlightrow1").hide();
        $("#highlightrow2").hide();
        $("#highlightrow3").hide();
        $("#highlightrow4").hide();
        $("#highlightrow5").hide();
    }
}

function highlightrow(idx){
    $("#highlightrow0").hide();
    $("#highlightrow1").hide();
    $("#highlightrow2").hide();
    $("#highlightrow3").hide();
    $("#highlightrow4").hide();
    $("#highlightrow5").hide();

    $("#highlightrow" + idx ).show();
}


function shownext(){
    $("#nextbutton").show();
}

function reddice(){
    dicecolor = "red";
    currentdiceimages = reddiceimages;
    $("#dice").attr("src", currentdiceimages[5].src);
}
function whitedice(){
    dicecolor = "white";
    currentdiceimages = diceimages;
    $("#dice").attr("src", currentdiceimages[5].src);
}

function setdicetype(type){
    dicetype = type;
}