include <../templates/controlPanelTemplate.scad>
include <../templates/caseTemplate.scad>

// panel[  X, Y,Z]
panel = [65,65,4];

internalCaseDepth = 60;
wireDia = 7;

// components
// [LIP_HEIGHT, BORE_DIA, SUNKEN_DIA, SUNKEN_DEAPTH]
button  = [0, 25, 0, 0];


//        [X                    ,Y            , COMPONENT, NAME]
componentPlacement = [[panel[X]/2 , panel[Y]/2, button, "the one"]];

Case(panel, internalCaseDepth, wireDia);

translate([panel[X]/2+5, -panel[Y]/2, 0]) {
    Panel(componentPlacement, panel);
}


