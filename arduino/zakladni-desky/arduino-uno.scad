// sof
// ------------------------------------------------------------------
//
// Autor: Ivo Panáček, February 2021
// ivo.panacek@gmail.com
// Version: 0
//
// ------------------------------------------------------------------
//
// základní deska Arduino UNO
//
// ------------------------------------------------------------------

use <../../lib/geometry.scad>;

// -----------------------------------------
// šrouby, resp. držáky místo šroubů

screwDiameter = 3.3; // průměr otvorů pro šrouby
screwPinDelta = 0.2; // zmenšení průměru pro trn
screwSupportDelta = 1; // zvětšení průměru pro držák dole

// zámek
screwBoardDelta = 0; // přesah před zámkem
screwLockDelta = 0.2; // zvětšení průměru zámek nahoře
screwLockHeight = 2; // celková výška zámku

screwLockHoleWidth = 0.6; // šířka díry v zámku
// hloubka zámku pod spodek desky
// záporné => nad
screwLockHoleDepth = -0.5;

// -----------------------------------------
// středy otvorů pro šrouby

screwRimDistance = 2.4; // střed otvoru od kraje desky
screwLeftTop = 15; // středy levých otvorů od levého kraje desky
screwLeftBottom = 14.2; // středy levých otvorů od levého kraje desky
screwBottom = 7.8; // střed pravého dolního otvoru od spodního kraje desky
screwTop = 17.5; // střed pravého horního otvoru od horního kraje desky

// -----------------------------------------
// rozměry desky

boardThickness = 2.4; // tloušťka
boardY = 53.5; // výška
boardX = 66; // šířka

boardBumpX = 2.6; // šířka výstupku
boardBumpY1 = 38.2; // výška výstupku u desky
boardBumpY2 = 33; // výška výstupku na kraji
boardBumpYbottom = 3; // začátek výstupku u spodního konce desky

// -----------------------------------------
// umístění desky

boardDistance = 3; // výška umístění desky nad základnou

// -----------------------------------------
// krabička

boxBottom = 1; // tloušťka spodku
boxWall = 2; // tloušťka stěny

boxDistance = 0.5; // vzdálenost kraje desky od stěny

// -----------------------------------------
// držák krabičky

handleHoleDiameter = 3; // průměr otvoru pro šroubek
handleHoleDistance1 = 4; // vzdálenost středu otvoru od krabičky
handleHoleDistance2 = 4; // vzdálenost středu otvoru od okraje

// ---------------------------------------------------------
// závislé hodnoty

 // začátek výstupku u horního konce desky (12.3)
boardBumpYtop = boardY-boardBumpYbottom-boardBumpY1;

// výška díry v zámku
screwLockHoleHeight = screwLockHeight
                      +screwBoardDelta
                      +boardThickness
                      +screwLockHoleDepth;

handleWidth = handleHoleDistance1+handleHoleDistance2;

innerX = boardX+boardBumpX;
innerY = boardY;

outerX = innerX + 2*boxWall + 2*boxDistance;
outerY = innerY + 2*boxWall + 2*boxDistance;

// ------------------------------------------------------------------
dreh=$t*360;
$fn=100;

// ------------------------------------------------------------------
// main program

color([0,1,0])box();
//color([0,0,1])handleX();
color([0,0,1])handleY();

//visibleBoard();

//screwWithSupport();

// ------------------------------------------------------------------
// modules

// -----------------------------------

module handleY() {
    difference() {
        handlesY();
        handleHolesY();
    }
}

module handleX() {
    difference() {
        handlesX();
        handleHolesX();
    }
}

module handlesX() {
    translate([0,outerY,0])
    oneHandleX();
    translate([outerX,0,0])
    rotate([0,0,180])
    oneHandleX();
}

module handlesY() {
    oneHandleY();
    translate([outerX,outerY,0])
    rotate([0,0,180])
    oneHandleY();
}

module oneHandleY() {
    z = boardThickness;
    rotate([0,0,90])
    linear_extrude(height=z)
    cylinderCutTriangle( outerY, handleWidth, handleWidth/3);
}

module oneHandleX() {
    z = boardThickness;
    linear_extrude(height=z)
    cylinderCutTriangle( outerX, handleWidth, handleWidth/3);
}

// -----------------------------------

module handleHolesX() {
    y = outerY+2*handleHoleDistance1;
    translate([outerX/2,-handleHoleDistance1,0])
    union() {
        handleHole();
        translate([0,y,0])
        handleHole();
    }
}

module handleHolesY() {
    x = outerX+2*handleHoleDistance1;
    translate([-handleHoleDistance1,outerY/2,0])
    union() {
        handleHole();
        translate([x,0,0])
        handleHole();
    }
}

module handleHole() {
    translate([0,0,-boardThickness])
    cylinder( d=handleHoleDiameter,h=3*boardThickness);
}

// -----------------------------------

module screwWithSupport() {
    w = 4*screwDiameter;
    h = 1;
    cube([w,w,h]);
    translate([w/2,w/2,h])
    screw();
}

module visibleBoard() {
    color([1,0,0,0.5])
    translate([boxWall+boxDistance,boxWall+boxDistance,boxBottom+boardDistance])
    board();
}

// -----------------------------------

module box() {
    wallZ = boardDistance+boardThickness;

    // bottom
    color([0,1,0])
    cube([outerX,outerY,boxBottom]);

    // walls
    color([1,1,0])
    translate([0,0,boxBottom])
    union() {
        cube([boxWall,outerY,wallZ]);
        translate([outerX-boxWall,0,0])
        cube([boxWall,outerY,wallZ]);
    }
    color([1,0,1])
    translate([0,0,boxBottom])
    union() {
        cube([outerX,boxWall,wallZ]);
        translate([0,outerY-boxWall,0])
        cube([outerX,boxWall,wallZ]);
    }

    // šrouby
    translate([boxWall+boxDistance,boxWall+boxDistance,boxBottom])
    allScrews();
}

// -----------------------------------

module board() {

    color([1,0,0])
    difference() {
        // board
        union() {
            // hlavní obdélník
            cube([boardX,boardY,boardThickness]);

            // bump
            difference() {
                bump();
                translate([0,0,-boardThickness])
                bumpCut();
            }
        }
        // holes
        translate([0,0,-boardThickness])
        union() {

            translate([screwLeftBottom,screwRimDistance,0])
            screwHole(); 
            translate([screwLeftTop,boardY-screwRimDistance,0])
            screwHole(); 

            right = boardX+boardBumpX;

            translate([right-screwRimDistance,screwBottom,0])
            screwHole(); 
            translate([right-screwRimDistance,boardY-screwTop,0])
            screwHole(); 
        }
    }
}

module screwHole() {
    cylinder(d=screwDiameter,h=boardThickness*3);
}

module bump() {
    translate([boardX-boardBumpX,boardBumpYbottom,0])
    cube([2*boardBumpX,boardBumpY1,boardThickness]);
}

module bumpCut() {
    x = boardBumpX;
    y = (boardBumpY1-boardBumpY2)/2;
    z = 3*boardThickness;
    alpha = atan(y/x);
    help = 4*boardBumpX;cylinder( d=screwDiameter+screwSupportDelta,h=h1);

    union() {
        translate([screwLeftBottom,screwRimDistance,0])
        screw(); 
        translate([screwLeftTop,boardY-screwRimDistance,0])
        screw(); 

        right = boardX+boardBumpX;

        translate([right-screwRimDistance,screwBottom,0])
        screw(); 
        translate([right-screwRimDistance,boardY-screwTop,0])
        screw(); 
    }
}

module allScrews() {
    union() {

        translate([screwLeftBottom,screwRimDistance,0])
        screw(); 
        translate([screwLeftTop,boardY-screwRimDistance,0])
        screw(); 

        right = boardX+boardBumpX;

        translate([right-screwRimDistance,screwBottom,0])
        screw(); 
        translate([right-screwRimDistance,boardY-screwTop,0])
        screw(); 
    }
}


module screw() {
    h1 = boardDistance;
    pos1 = h1;
    h2 = boardThickness+screwBoardDelta;
    pos2 = pos1+h2;
    pos3 = pos2+screwLockHeight;
    
    color([1,0,0])
    difference() {
        union() {
            // spodek
            color([1,0,0])
            cylinder( d=screwDiameter+screwSupportDelta,h=h1);

            // trn
            color([1,1,0])
            translate([0, 0, pos1])
            cylinder( d=screwDiameter-screwPinDelta,h=h2);

            // lock
            color([1,1,1])
            translate([0, 0, pos2])
            screwLock();
        }
        // lock hole
        color([0,0,1])
        translate([0, 0, pos3-screwLockHoleHeight])
        screwLockHole();
    }
}

module screwLock() {
    d1 = screwDiameter-screwPinDelta;
    d2 = screwDiameter+screwLockDelta;
    d3 = screwDiameter;
    h = screwLockHeight/2;
    
    union() {
        cylinder(d1=d1,d2=d2,h=h);
        translate([0,0,h])
        cylinder(d1=d2,d2=d1,h=h);
    }
}

module screwLockHole() {
    x = 4*screwDiameter;
    y = screwLockHoleWidth;

    translate([-x/2,-y/2,0])
    cube([x,y,screwLockHoleHeight+1]);
}

// ------------------------------------------------------------------
// eof