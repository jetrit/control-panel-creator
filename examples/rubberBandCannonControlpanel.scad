include <../templates/controlPanelTemplate.scad>
include <../templates/caseTemplate.scad>

// panel[  X, Y,Z]
panel = [100,60,4];

internalCaseDepth = 35;

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

//create the panel
Panel(componentPlacement, panel);

// or the case
//Case(panel, internalCaseDepth);
