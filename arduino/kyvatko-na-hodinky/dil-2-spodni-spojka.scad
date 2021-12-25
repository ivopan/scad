// sof
// ------------------------------------------------------------------
//
// Autor: Ivo Panáček, December 2021
// ivo.panacek@gmail.com
// Version: 0
//
// ------------------------------------------------------------------
//
// díl č. 2 - spodní spojka
//
// ------------------------------------------------------------------

use <kruhovyNastavec.scad>;

$fn=1000;

// ------------------------------------------------------------------
// main program

part2();

// ------------------------------------------------------------------
// moduly

module part2(thickness=4) {

    rotate([180,0,0])
    union() {
        base();
        arm();
        top();
    }

}

module top(thickness=4) {
    width = 10;
    height = 30;

    translate([0,60-thickness,thickness])
    rotate([-90,0,0])
    cube([width,height,thickness]);
}

module arm(thickness=4) {
    width = 10;
    height = 30;

    translate([0,30,0])
    cube([width,height,thickness]);
}

module base(thickness=4) {
    width = 6;
    height = 30;

    union() {
        cube([width,height,thickness]);
        translate([width,0,0])
        zakladnaSKruhovymNastavecem(thickness);
    }
    
}



// ------------------------------------------------------------------
// eof