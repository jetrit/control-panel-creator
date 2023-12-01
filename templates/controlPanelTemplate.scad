/**
This file helps create control a control panel
placing components you might want, taking into account 
that some components require a thiker panel than others
and some needs to be sunken into the panel 

// below you can see an example of a panel specification.
but you can create your own in 4 steps
1. define a Panel
2. define some components
3. place components on panel 
4. call Panel()


**/
// =========  this should be constants ========
X = 0;
Y = 1;
Z = 2;
COMPONENT = 2;
NAME = 3;
LIP_HEIGHT = 0;
BORE_DIA = 1;
SUNKEN_DIA = 2;
SUNKEN_DEAPTH =3;

/**

// panel[  X, Y,Z]
panel = [100,60,4];

// components
// [LIP_HEIGHT, BORE_DIA, SUNKEN_DIA, SUNKEN_DEAPTH]
jogWheel = [16,        7,         10, 12];
switch   = [ 0,        7,          0,  0];
led      = [ 0,      5.5,          0,  0];


//        [X                    ,Y            , COMPONENT, NAME]
componentPlacement = [
          [panel[0]/4           , panel[1]/2+5, jogWheel, "jog 1"],
          [panel[0] - panel[0]/4, panel[1]/2+5, jogWheel, "jog 2"],
          [10                   , 10          , switch  , "on/off"],
          [panel[0]/2           , 10          , switch  , "fire button"],
          [panel[0]-7.5         , 7.5         , led     , "power led"],
          [panel[0]-15          , 7.5         , led     , "data led"],
          ];


Panel(componentPlacement, panel);

**/

module Panel(componentPlacement, panelDim){
    difference(){
        group(){
            cube(panelDim);
            createLip(componentPlacement, panelDim, lipWith=panelDim[Z]);
        }
        drill(componentPlacement, panelDim);
        sunken(componentPlacement);
    }
    
    module drill(componentPlacement, panelDim, i=0, buffer=1){
        if(i < len(componentPlacement)){
            cp = componentPlacement[i];
            translate([cp[X], cp[Y], 0-buffer/2]){
                cylinder(
                    h = max(cp[COMPONENT][LIP_HEIGHT], panelDim[Z]) + buffer, 
                    d = cp[COMPONENT][BORE_DIA]);
            }
            drill(componentPlacement, panelDim, i+1, buffer);
        }
     }
     
     module createLip(componentPlacement, panelDim, i=0, lipWith=0){
        if(i < len(componentPlacement)){
            cp = componentPlacement[i];
            dia = max(cp[COMPONENT][SUNKEN_DIA], cp[COMPONENT][BORE_DIA]);
            assert(validate(cp, lipWith, dia/2, panelDim), str(cp[NAME], " out of bounds."));

            translate([cp[X], cp[Y], 0]){
                cylinder(
                    h = max(cp[COMPONENT][LIP_HEIGHT], panelDim[Z]), 
                    d = dia + lipWith
                );
            }
            createLip(componentPlacement, panelDim, i+1, lipWith);
        }
    }

    module sunken(componentPlacement, i=0, buffer=1){
        if(i < len(componentPlacement)){
            cp = componentPlacement[i];
            translate([cp[X], cp[Y],0-buffer]){
                cylinder(
                    h=cp[COMPONENT][SUNKEN_DEAPTH] + buffer, 
                    d=cp[COMPONENT][SUNKEN_DIA]
                );
            }
            sunken(componentPlacement, i+1, buffer);
        }
    }
    
    function max(a, b) = a > b ? a : b;
    function min(a, b) = a > b ? a : b;

    function validate(cp, lipWith, r, panelDim) = ((cp[X] + lipWith + r < panelDim[X]) &&
                                            (cp[X] - lipWith - r > 0) &&
                                            (cp[Y] + lipWith + r < panelDim[Y]) &&
                                            (cp[Y] - lipWith - r > 0)
                                            );

}