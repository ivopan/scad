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
sensorBoardThickness = 3; // tloušťka desky se čidlem
sensorBoardRim = 4; // přesah rámečku

sensorHoleDiameter = 1; // průměr otvoru na šroub
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

sensorScrewBox = 2*(sensorBoardRim+sensorHoleDistance);
sensorDistance = sensorCenterDistance - sensorDiameter; // vzdálenost krajů čidel
servoHolderDepthDelta = 1; // přesah pro jistotu

// ------------------------------------------------------------------
dreh=$t*360;
$fn=100;
// ------------------------------------------------------------------
// main program

//sensorBoard();
rotate([0,0,90])rotate([0,180,0])servoHolderAdapter();
//servoHole();
//servoScrewHoles();

//fullHolder();

//image();

// ------------------------------------------------------------------
// modules

module fullHolder() {
    x = sensorBoardHeight+2*sensorBoardRim+servoHolderThickness;
    y = sensorBoardWidth+2*sensorBoardRim;
    z = x+servoHolderThickness;

    delta = sensorBoardThickness+sensorBoardDistance;

    intersection() {
        union() {
            servoHolderAdapter();
            translate([0,0,x])
            rotate([0,90,0])
            sensorBoard();
        }
        color([0,1,1])
        translate([delta,y/2,-z])
        resize([y-2*(delta+sensorBoardDistance),y,3*z])
        cylinder(d=y,h=3*z);
    }
}

// -----------------------------------

module servoHolderAdapter() {
    x = sensorBoardHeight+2*sensorBoardRim;
    y = sensorBoardWidth+2*sensorBoardRim;
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
    x = sensorBoardHeight+2*sensorBoardRim;
    y = sensorBoardWidth+2*sensorBoardRim;
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
    x = sensorBoardHeight+2*sensorBoardRim;
    y = sensorBoardWidth+2*sensorBoardRim;
    z = sensorBoardThickness;
    margin = (y-sensorDistance-sensorDiameter)/2;

    color([1,0,0])
    difference(){
        union() {
            cube([x,y,z]);
            translate([0,0,sensorBoardThickness])
            union() {
                screwBox();
                translate([x-sensorScrewBox,0,0])
                screwBox();
                translate([x-sensorScrewBox,y-sensorScrewBox,0])
                screwBox();
                translate([0,y-sensorScrewBox,0])
                screwBox();
            }
        }
        translate([x/2,0,0])
        union() {
            translate([0, margin, 0])
            sensorHole();
            translate([0, y-margin, 0])
            sensorHole();
        }
    }
}

module sensorHole() {
    z = sensorBoardDistance+sensorBoardThickness;
    translate([0,0,-z])
    cylinder(d=sensorDiameter,h=3*z);

}

module screwBox() {
    difference() {
        cube([sensorScrewBox,sensorScrewBox,sensorBoardDistance]);
        translate([sensorScrewBox/2,sensorScrewBox/2,-sensorBoardDistance])
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