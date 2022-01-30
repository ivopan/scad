// sof
// ------------------------------------------------------------------
//
// Autor: Ivo Panáček, December 2021
// ivo.panacek@gmail.com
// Version: 1
//
// ------------------------------------------------------------------
//
// díl č. 1 - spodní držák
//
// ------------------------------------------------------------------

use <../drzakMotoru.scad>;

// ------------------------------------------------------------------
// main program

part1();

// ------------------------------------------------------------------
// moduly

module part1(thickness=4) {
    rotate([0,-90,0])
    union() {
        translate([0,55/2,50])
        drzakMotoru(thickness);
        central();
        base(thickness);
    }
}

module central() {
    width = 55;
    height = 10;
    thickness=50;
    cube([height,width,thickness]);
}

module base(thickness=4) {
    width = 55;
    height = 31;

    cube([height,width,thickness]);
}

// ------------------------------------------------------------------
// eof