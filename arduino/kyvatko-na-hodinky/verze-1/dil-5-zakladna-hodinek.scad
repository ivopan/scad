// sof
// ------------------------------------------------------------------
//
// Autor: Ivo Panáček, December 2021
// ivo.panacek@gmail.com
// Version: 1
//
// ------------------------------------------------------------------
//
// díl č. 5 - základna hodinek
//
// ------------------------------------------------------------------

use <cage.scad>;

$fn=1000;

// ------------------------------------------------------------------
// main program

part5();

// ------------------------------------------------------------------
// moduly

module part5(thickness=4) {
    width = 50;
    w1 = 20;
    h1 = 10;

    difference() {
        desk(thickness,width);

        translate([-w1/2,-h1/2,1])
        cube([w1,h1,thickness]);
    }
}

module desk(thickness,width) {
    difference() {
        base(thickness,width);
        otvory(thickness,width,2);
    }
}

module base(thickness,width) {
    translate([-width/2,-width/2,0])
    cube([width,width,thickness]);
}

// ------------------------------------------------------------------
// eof