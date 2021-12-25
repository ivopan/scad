// sof
// ------------------------------------------------------------------
//
// Autor: Ivo Panáček, December 2021
// ivo.panacek@gmail.com
// Version: 0
//
// ------------------------------------------------------------------
//
// klec na hodinky
//
// ------------------------------------------------------------------

// dreh=$t*360;
$fn=1000;

prumerTycky = 4;

// ------------------------------------------------------------------
// main program

// ------------------------------------------------------------------
// moduly

module tycky(thickness,height,width,delta) {
    distance = width-2*(delta+prumerTycky/2);

    translate([-distance/2, -distance/2, 0])
    union() {
        tycka(thickness,height);
        translate([distance,0,0]) tycka(thickness,height);
        translate([distance,distance,0]) tycka(thickness,height);
        translate([0,distance,0]) tycka(thickness,height);
    }
}

module otvory(height,width,delta) {
    distance = width-2*(delta+prumerTycky/2);

    translate([-distance/2, -distance/2, 0])
    union() {
        otvor(height);
        translate([distance,0,0]) otvor(height);
        translate([distance,distance,0]) otvor(height);
        translate([0,distance,0]) otvor(height);
    }
}

module tycka(thickness,height) {
    gap = 0.5;
    union() {
        cylinder(d=prumerTycky,h=height+thickness);
        cylinder(d=prumerTycky+gap,h=height);
    }
}

module otvor(height) {
    gap = 0.1;
    translate([0,0,-1])
    cylinder(d=prumerTycky+gap,h=height+2);
}

// ------------------------------------------------------------------
// eof