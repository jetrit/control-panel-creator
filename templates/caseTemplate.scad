/*
Side model of the control panel, to create the case around it.
*/
X = 0;
Y = 1;
Z = 2;

//this is a case for a panel 
Case([65,65,4], 60, 7);


module Case(topPanel, internalCaseDepth, wireDia){
    ofset = topPanel[Z];
    buffer = 0.2;
    difference(){
        translate([0,0,(internalCaseDepth+ofset)/2]){
            group(){
                difference(){
                    cube([topPanel[X]+ofset, topPanel[Y]+ofset, internalCaseDepth+ofset], true);
                    
                    //create void inside
                    translate([0, 0, 0]){
                        color("red");
                        cube([topPanel[X]-ofset, topPanel[Y]-ofset, internalCaseDepth], true);
                    }
                    
                    //create cutout for toppanel
                    translate([0, 0, internalCaseDepth/2]){
                        cube([topPanel[X]+0.2, topPanel[Y]+0.2, topPanel[Z]+0.1], true);
                    }                    
                }
            }
        }
        
        // make hole for wire 
        // make generic
        translate([topPanel[X]/2-ofset-wireDia/2,(topPanel[Y]+ofset)/2+buffer+wireDia/2,ofset + (wireDia/2)]){
            rotate([90,0,0]){
                cylinder(h=11, d=wireDia);
            }
        }
    }
}