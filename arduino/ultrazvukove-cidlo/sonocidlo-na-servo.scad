// sof
// ------------------------------------------------------------------
//
// Autor: Ivo Panáček, January 2021
// ivo.panacek@gmail.com
// Version: 0
//
// ------------------------------------------------------------------
//
// připevnění sonočidla na servomotor
//
// ------------------------------------------------------------------
// parameters


// ---------------------------------------------------------
// nastavení velikosti sono čidla

sensorDiameter = 16.5; // průměr otvoru na jedno sono čidlo
sensorCenterDistance = 26; // vzdálenost středů čidel
sensorBoardWidth = 45.5; // šířka desky
sensorBoardHeight = 20.5; // výška desky

sensorBoardDistance = 4; // nutná vzdálenost desky od přední plochy (jsou tam součástky)
sensorBoardThickness = 3; // tloušťka desky s čidlem
sensorBoardRimVertical = 2; // přesah rámečku nahoře a dole
sensorBoardRimHoritonal = 2; // přesah rámečku do stran
sensorBoardRimDistance = 0.3; // stranová vzdálenost desky od rámečku

sensorHoleDiameter = 2; // průměr otvoru na šroub
sensorScrewHeadDiameter = 3.2; // průměr otvoru na hlavičku šroubu
sensorScrewHeadHeight = 1.5; // výška hlavičky šroubu
sensorHoleDistance = 1.5; // vzdálenost středu otvoru na šroub od kraje desky

sensorConnectorWidth = 11; // šířka konektoru

// ---------------------------------------------------------
// nastavení plošiny pro servo

servoHolderThickness = 3; // tloušťka desky pro servo

// přidat rezervy

servoAxisDiameter = 8; // průměr středového kruhu držáku serva (7)
servoHolderDepth = 2; // hloubka otvoru pro držák serva (2)
servoHolderWidth = 33; // šířka otvoru pro držák serva (32)
servoHolderHeight = 6; // výška otvoru pro držák serva (5)

servoHolesDistance = 29.4; // vzdálenost otvorů pro upevňovací šrouby
servoScrewDiameter = 1; // průměr otvoru pro upevňovací šrouby

servoHolderMaskDepth = 2; // hloubka otvoru pro držák
servoHolderMaskWidth = 7.1;
servoHolderMaskHeight = 32.1;

// ---------------------------------------------------------
// závislé hodnoty

sensorScrewBoxHorizontal = sensorBoardRimHoritonal + 2*sensorHoleDistance;
sensorScrewBoxVertical = sensorBoardRimVertical + 2*sensorHoleDistance;
sensorDistance = sensorCenterDistance - sensorDiameter; // vzdálenost krajů čidel
servoHolderDepthDelta = 1; // přesah pro jistotu

// ------------------------------------------------------------------
dreh=$t*360;
$fn=100;
// ------------------------------------------------------------------
// main program

//image();
//sensorBoard();
//servoHole();
//servoScrewHoles();

//rotate([0,0,90])rotate([0,180,0])servoHolderAdapter();
//rotate([0,0,90])rotate([0,180,0])
sensorBoard();
// fullHolder();


// ------------------------------------------------------------------
// modules

module fullHolder() {
    x = sensorBoardHeight+2*sensorBoardRimVertical+servoHolderThickness;
    y = sensorBoardWidth+2*sensorBoardRimHoritonal;
    z = x+servoHolderThickness;

    delta = sensorBoardThickness+sensorBoardDistance;

    // intersection() {
        union() {
            servoHolderAdapter();
            translate([0,0,x])
            rotate([0,90,0])
            sensorBoard();
        }
        // color([0,1,1])
        // translate([delta,y/2,-z])
        // resize([y-2*(delta+sensorBoardDistance),y,3*z])
        // cylinder(d=y,h=3*z);
    // }
}

// -----------------------------------

module servoHolderAdapter() {
    x = sensorBoardHeight+2*sensorBoardRimVertical;
    y = sensorBoardWidth+2*sensorBoardRimHoritonal;
    z = servoHolderThickness;


    color([0,1,0])
    // difference() {
        difference() {
            servoBoard();
            // translate([x/2,y/2,-servoHolderDepthDelta])
            // servoHole();
            translate([x/2,y/2,0])
            image();
        }
    //     translate([x/2,y/2,-servoHolderDepthDelta])
    //     servoScrewHoles();
    // }
}

module servoBoard() {
    x = sensorBoardHeight+2*sensorBoardRimVertical;
    y = sensorBoardWidth+2*sensorBoardRimHoritonal;
    z = servoHolderThickness;

    color([0,1,0])
    cube([x,y,z]);
}

module servoHole() {
    z = servoHolderDepth+servoHolderDepthDelta;

    color([0,1,1])
    union() {
        cylinder(d=servoAxisDiameter,h=z);
        color([1,0,0])
        translate([-servoHolderHeight/2,-servoHolderWidth/2,0])
        cube([servoHolderHeight,servoHolderWidth,z]);
    }
}

module servoScrewHole() {
    z = servoHolderThickness+2*+servoHolderDepthDelta;

    color([0,0,1])
    cylinder(d=servoScrewDiameter,h=z);
}

module servoScrewHoles() {
    z = servoHolderDepth+servoHolderDepthDelta;

    color([0,0,1])
    translate([0,-servoHolesDistance/2,0])
    union() {
        servoScrewHole();
        translate([0,servoHolesDistance-servoScrewDiameter,0])
        servoScrewHole();
    }
}

// -----------------------------------

module sensorBoard() {
    x = sensorBoardHeight+2*sensorBoardRimVertical;
    y = sensorBoardWidth+2*sensorBoardRimHoritonal;
    z = sensorBoardThickness;
    margin = (y-sensorDistance-sensorDiameter)/2;
    rim = sensorBoardDistance + sensorBoardThickness;

    x2 = sensorBoardHeight + 2*sensorBoardRimDistance;
    y2 = sensorBoardWidth + 2*sensorBoardRimDistance;

    color([1,0,0])
    union() {
        difference(){
            difference(){
                union() {
                    cube([x,y,z]);
                    screwBoxes(x,y);
                }
                screwHoles(x,y);
            }
            translate([x/2,0,0])
            union() {
                translate([0, margin, 0])
                sensorHole();
                translate([0, y-margin, 0])
                sensorHole();
            }
        }

        color([0,0,1])
        difference() {
            translate([0, 0, z])cube([x,y,rim]);
            translate([
                sensorBoardRimVertical-sensorBoardRimDistance, 
                sensorBoardRimHoritonal-sensorBoardRimDistance, 
                z-0.1])
            cube([x2,y2,2*rim]);
        }
    }
}

module sensorHole() {
    z = sensorBoardDistance+sensorBoardThickness;
    translate([0,0,-z])
    cylinder(d=sensorDiameter,h=3*z);

}

module screwBoxes(x,y) {
    translate([0,0,sensorBoardThickness])
    union() {
        screwBox(1,1);
        translate([x-sensorScrewBoxVertical,0,0])
        screwBox(1,0);
        translate([x-sensorScrewBoxVertical,y-sensorScrewBoxHorizontal,0])
        screwBox(0,0);
        translate([0,y-sensorScrewBoxHorizontal,0])
        screwBox(0,1);
    }
}

module screwBox(left,top) {

    yLeft = sensorScrewBoxHorizontal - sensorHoleDistance;
    yRight = sensorHoleDistance;
    y = left*yLeft + (1-left)*yRight;

    xTop = sensorScrewBoxVertical - sensorHoleDistance;
    xBottom = sensorHoleDistance;
    x = top*xTop + (1-top)*xBottom;

    cube([sensorScrewBoxVertical,sensorScrewBoxHorizontal,sensorBoardDistance]);
}

module screwHoles(x,y) {
    translate([0,0,sensorBoardThickness])
    union() {
        screwHole(1,1);
        translate([x-sensorScrewBoxVertical,0,0])
        screwHole(1,0);
        translate([x-sensorScrewBoxVertical,y-sensorScrewBoxHorizontal,0])
        screwHole(0,0);
        translate([0,y-sensorScrewBoxHorizontal,0])
        screwHole(0,1);
    }
}

module screwHole(left,top) {

    yLeft = sensorScrewBoxHorizontal - sensorHoleDistance;
    yRight = sensorHoleDistance;
    y = left*yLeft + (1-left)*yRight;

    xTop = sensorScrewBoxVertical - sensorHoleDistance;
    xBottom = sensorHoleDistance;
    x = top*xTop + (1-top)*xBottom;


    translate([x,y,-sensorScrewHeadHeight-sensorBoardThickness])
    union() {
        cylinder(d=sensorScrewHeadDiameter,h=2*sensorScrewHeadHeight);
        cylinder(d=sensorHoleDiameter,h=3*sensorBoardDistance);
    }
}

// --------------------------------------------------------
// image

module image() {
    //name="drzak-servo-maska.png";
    name="drzak-servo-maska-mala.png";
    
    w = servoHolderMaskWidth;
    h = servoHolderMaskHeight;
    z = servoHolderMaskDepth*2;

    translate([-w/2,-h/2,z/2])
    resize([w,h,z])
    surface(file=name, invert=true);
}

// ------------------------------------------------------------------
// eof