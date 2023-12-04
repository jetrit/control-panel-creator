
// predefine Cut rotations          
R = [[90,00,00], [00,90,00],[00,00,00]];
X = 0;
Y = 1;
Z = 2;


//translate([120,0,0]){
//    Panel(componentPlacement, panel);
//}




//this is a case for a panel 
//Case([65,65,4], 60);


module Case(topPanel, internalCaseDepth, tiltControl=0, cuts=[]){
    COORDINATES=0;
    ROTATION=1;
    DIAMETER=2;

    thiknes = topPanel[Z];
    difference(){
        translate([(topPanel[X]+thiknes)/2, (topPanel[Y]+thiknes)/2,(internalCaseDepth+thiknes)/2]){
            group(){
                difference(){
                    //create main box
                    cube([topPanel[X]+thiknes, topPanel[Y]+thiknes, internalCaseDepth+thiknes], true);
                    
                    //create void inside
                    translate([0, 0, thiknes]){
                        cube([topPanel[X]-thiknes, topPanel[Y]-thiknes, internalCaseDepth], true);
                    }
                }
                //add the tilted part of the control panel if needed.
                tiltControls(topPanel,internalCaseDepth, tiltControl);
            }
        }
        //make cutout for the lid
        lid(topPanel, internalCaseDepth, tiltControl);
        // cut holes for wires or air...
        cut(cuts);
    }
    
    //Recursive call over the cuts in the box
    module cut(cuts, h=thiknes*5, i=0) {
        if(i < len(cuts)) {
            cut = cuts[i];
            translate(cut[COORDINATES]) {
                rotate(cut[ROTATION]) {
                    cylinder(h=h, d=cut[DIAMETER], center=true);
                }
            }
            cut(cuts, h, i+1);   
        }
    }
    
    module tiltControls(topPanel,internalCaseDepth, tiltControl){
        thiknes = topPanel[Z];
            translate([-(topPanel[X]+thiknes)/2,-(topPanel[Y]+thiknes)/2,(internalCaseDepth+thiknes)/2]){
                
                rotate([90,0,90]){
            
                    rotate_extrude(angle=tiltControl){
                        difference(){
                            square([topPanel[Y]+thiknes,topPanel[X]+thiknes]);
                            translate([thiknes,thiknes,0]){
                                square([topPanel[Y]-thiknes,topPanel[X]-thiknes]); //cutout
                            }
                        }
                    }
                }
            }
    }

    module lid(topPanel, internalCaseDepth, angle, tolerence=0.5){
        thiknes = topPanel[Z];
        translate([thiknes/2,0,internalCaseDepth+thiknes])
        rotate([angle,0,0])
        translate([(topPanel[X])/2,(topPanel[Y]+thiknes)/2,-thiknes/2])
        cube([topPanel[X]+tolerence,topPanel[Y]+tolerence,thiknes], true);
    }
}