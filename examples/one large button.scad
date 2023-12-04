include <../templates/controlPanelTemplate.scad>
include <../templates/caseTemplate.scad>


// ======= DEFINE CASE =======

// panel[ X, Y,Z]
// thiknes of case is the same as panel[Z]
// final size of case is X+Z, Y+Z
panel = [65,65,4];

// room inside the case
caseZ = 60;

// Define cuts in case 
cuts = [[[60, 60, 11] ,R[X], 10],]; // 10 mm back right

// Define angle of panel on case
angle = 0;

// ======= Build Case =======

Case(panel, caseZ, angle, cuts);


// ======= DEFINE COMPONENTS ON PANEL =======

// Define components
// [LIP_HEIGHT, BORE_DIA, SUNKEN_DIA, SUNKEN_DEAPTH]
button  = [0, 25, 0, 0];

// make placements   [X          ,Y          , COMPONENT, NAME]
componentPlacement = [[panel[X]/2 , panel[Y]/2, button, "the one"]];


// ======= Build panel out of the way =======

translate([panel[X]+10, 0, 0]) { 
    Panel(componentPlacement, panel);
}

    