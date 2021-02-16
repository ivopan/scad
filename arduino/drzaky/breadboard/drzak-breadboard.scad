// sof
// ------------------------------------------------------------------
//
// Autor: Ivo Panáček, February 2021
// ivo.panacek@gmail.com
// Version: 0
//
// ------------------------------------------------------------------
//
// držák breadboard
//
// ------------------------------------------------------------------

use <../../../lib/geometry.scad>;

// -----------------------------------------
// rozměry desky

boardZ = 2; // tloušťka

// na šířku
boardY = 55; // výška
boardX = 82.5; // šířka

// va výšku
// boardX = 55; // výška
// boardY = 82.5; // šířka

// -----------------------------------------
// držák desky

handleHoleDiameter = 3; // průměr otvoru pro šroubek
handleHoleDistance1 = 4; // vzdálenost středu otvoru od desky
handleHoleDistance2 = 4; // vzdálenost středu otvoru od okraje

// ---------------------------------------------------------
// závislé hodnoty

handleWidth = handleHoleDistance1+handleHoleDistance2;

// ------------------------------------------------------------------
dreh=$t*360;
$fn=100;

// ------------------------------------------------------------------
// main program

color([0,1,0])board();
color([1,0,0])handle();

// ------------------------------------------------------------------
// modules

// -----------------------------------

module handle() {
    difference() {
        handles();
        handleHoles();
    }
}

module handles() {
    translate([0,boardY,0])
    oneHandle();
    translate([boardX,0,0])
    rotate([0,0,180])
    oneHandle();
}

module oneHandle() {
    z = boardZ;
    linear_extrude(height=z)
    cylinderCutTriangle( boardX, handleWidth, handleWidth/3);
}

// -----------------------------------


module handleHoles() {
    y = boardY+2*handleHoleDistance1;
    translate([boardX/2,-handleHoleDistance1,0])
    union() {
        handleHole();
        translate([0,y,0])
        handleHole();
    }
}

module handleHole() {
    translate([0,0,-boardZ])
    cylinder( d=handleHoleDiameter,h=3*boardZ);
}

// -----------------------------------

module board() {
    cube([boardX,boardY,boardZ]);
}

// ------------------------------------------------------------------
// eof