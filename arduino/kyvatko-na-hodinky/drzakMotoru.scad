// sof
// ------------------------------------------------------------------
//
// Autor: Ivo Panáček, December 2021
// ivo.panacek@gmail.com
// Version: 0
//
// ------------------------------------------------------------------
//
// drzak na motor MG996R
//
// ------------------------------------------------------------------

// dreh=$t*360;
$fn=1000;

// ------------------------------------------------------------------
// main program


drzakMotoru();

// ------------------------------------------------------------------
// moduly

module drzakMotoru(thickness=4) {
    delta = 48; // 41 + 2x polovina width

    translate([0,0,10])
    rotate([0,90,0])
    union() {
        translate([0,-delta/2,0])noha(thickness);
        translate([0,delta/2,0])noha(thickness);
    }
}

module noha(thickness=4) {
    height = 20;
    width = 7;

    difference() {
        translate([-height/2,-width/2,0])
        cube([height,width,thickness]);
        otvory(thickness);
    }
}

module otvory(thickness=4) {
    delta = 10;

    union() {
        translate([-delta/2,0,0])otvor(thickness);
        translate([delta/2,0,0])otvor(thickness);
    }    
}

module otvor(thickness=4) {
    diameter = 4;
    
    translate([0,0,-0.5])
    cylinder(d=diameter,h=thickness+1);
}

// ------------------------------------------------------------------
// eof