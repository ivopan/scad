// sof
// ------------------------------------------------------------------
//
// Autor: Ivo Panáček, December 2021
// ivo.panacek@gmail.com
// Version: 1
//
// ------------------------------------------------------------------
//
// díl č. 3 - horní držák
//
// ------------------------------------------------------------------

use <../drzakMotoru.scad>;

// ------------------------------------------------------------------
// main program

//base();
part3();

// ------------------------------------------------------------------
// moduly

module part3(thickness=4) {
    rotate([0,-90,0])
    union() {
        translate([0,55/2,thickness])
        drzakMotoru(thickness);
        base(thickness);
    }
}

module base(thickness=4) {
    width = 55;
    height = 30;

    cube([height,width,thickness]);
}

// ------------------------------------------------------------------
// eof