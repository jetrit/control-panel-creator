include <../templates/controlPanelTemplate.scad>
include <../templates/caseTemplate.scad>


// ======= DEFINE CASE =======

// panel[ X, Y,Z]
// thiknes of case is the same as panel[Z]
// final size of case is X+Z, Y+Z
panel = [100,60,4];

// room inside the case
caseZ = 35;

// Define cuts in case 
cuts = [[[90, 60, 11] ,R[X], 10], // 10 mm back right
        [[0 , 55, 11] ,R[Y], 3],  //  3 mm hole left side
        [[60, 30,  2] ,R[Z], 20], // 20 mm hole in the bottom
        [[0 ,  0,  0] ,[-45,0,-45], 5], // 5 mm Diagonal thru the corner
        [[30,  0, 10] ,R[X], 4],
        [[40,  0, 10] ,R[X], 4],
        [[50,  0, 10] ,R[X], 4],
        [[60,  0, 10] ,R[X], 4],
        [[70,  0, 10] ,R[X], 4],
        ]; 

// Define angle of panel on case
angel = 20;
// ======= Build Case =======

Case(panel, caseZ, angel, cuts=cuts);


// ======= DEFINE COMPONENTS ON PANEL =======

// [LIP_HEIGHT, BORE_DIA, SUNKEN_DIA, SUNKEN_DEAPTH]
jogWheel = [16,        7,         10, 12];
switch   = [ 0,        7,          0,  0];
led      = [ 0,      5.5,          0,  0];


// make placements  [X  ,Y , COMPONENT, NAME]
componentPlacement = [
          [panel[0]/4           , panel[1]/2+5, jogWheel, "jog 1"],
          [panel[0] - panel[0]/4, panel[1]/2+5, jogWheel, "jog 2"],
          [10                   , 10          , switch  , "on/off"],
          [panel[0]/2           , 10          , switch  , "fire button"],
          [panel[0]-7.5         , 7.5         , led     , "power led"],
          [panel[0]-15          , 7.5         , led     , "data led"],
          ];

// ======= Build panel out of the way =======

translate([panel[X]+10,0]){
    Panel(componentPlacement, panel);
}
