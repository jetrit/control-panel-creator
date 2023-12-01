/*
Side model of the control panel, to create the case around it.
*/

module Case(topPanel, internalCaseDepth){
    ofset = topPanel[Z];
    difference(){
        cube([topPanel[X]+4, topPanel[Y]+4, internalCaseDepth+ofset]);
        
        //create void inside
        translate([ofset+2, ofset+2, ofset]){
            cube([panel[X]-2*ofset, topPanel[Y]-2*ofset, internalCaseDepth]);
        }
        
        //create cutout for toppanel
        translate([ofset-2, ofset-2, internalCaseDepth]){
            cube([topPanel[X], topPanel[Y], topPanel[Z]+0.1]);
        }
        // make hole for wire 
        // make generic
        translate([10,10,7.5]){
            rotate([90,0,0]){
                cylinder(h=11, d=7);
            }
        }
        
    }
}