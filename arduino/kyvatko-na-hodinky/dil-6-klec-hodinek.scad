// sof
// ------------------------------------------------------------------
//
// Autor: Ivo Panáček, December 2021
// ivo.panacek@gmail.com
// Version: 0
//
// ------------------------------------------------------------------
//
// díl č. 6 - klec hodinek
//
// ------------------------------------------------------------------

use <cage.scad>;

$fn=1000;

// ------------------------------------------------------------------
// main program

part6();

// ------------------------------------------------------------------
// moduly

module part6(thickness=4) {
    height = 20;
    width = 50;

    union() {
        bottom(thickness,width);
        tycky(thickness,height,width,2);
    }
}

module bottom(thickness,width) {
    diameter = width-6;

    difference() {
        base(thickness,width);
        translate([0,0,-1])
        cylinder(d=diameter,h=thickness+2);
    }
}

module base(thickness,width) {
    translate([-width/2,-width/2,0])
    cube([width,width,thickness]);
}

// ------------------------------------------------------------------
// eof