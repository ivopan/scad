// sof
// ------------------------------------------------------------------
//
// Autor: Ivo Panáček, December 2021
// ivo.panacek@gmail.com
// Version: 0
//
// ------------------------------------------------------------------
//
// díl č. 4 - horní spojka
//
// ------------------------------------------------------------------

use <kruhovyNastavec.scad>;

$fn=1000;

// ------------------------------------------------------------------
// main program

part4();

// ------------------------------------------------------------------
// moduly

module part4(thickness=4) {

    rotate([180,0,0])
    union() {
        color([0,1,0])
        zakladnaSKruhovymNastavecem(thickness);
        color([1,0,0])
        arm();
        color([0,0,1])
        top();
    }

}

module top(thickness=4) {
    width = 10;
    height = 20;

    translate([10,90-thickness,thickness])
    rotate([-90,0,0])
    cube([width,height,thickness]);
}

module arm(thickness=4) {
    width = 10;
    height = 60;

    translate([10,30,0])
    cube([width,height,thickness]);
}

// ------------------------------------------------------------------
// eof