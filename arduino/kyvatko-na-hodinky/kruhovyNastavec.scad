// sof
// ------------------------------------------------------------------
//
// Autor: Ivo Panáček, December 2021
// ivo.panacek@gmail.com
// Version: 1
//
// ------------------------------------------------------------------
//
// otvor pro kruhový nástavec na motor MG996R
//
// délka šroubu je 11.5, tloušťka nástavce je 2.3
// => je třeba ještě 9 mm nad tím
//
// ------------------------------------------------------------------

include <konstanty.scad>

// ------------------------------------------------------------------
// main program

//zakladnaSKruhovymNastavecem();
kruhovyNastavec();
//otvorProKruhovyNastavec();

// ------------------------------------------------------------------
// moduly

module zakladnaSKruhovymNastavecem(thickness=4) {
    width = 30;
    height = 30;
    delta=15;

    difference() {
        union() {
            cube([width,height,thickness]);
            translate([width-delta,delta,thickness])
            kruhovyNastavec();
        }
        translate([width-delta,delta,-kn_screwLength+3])
        otvoryProSrouby(kn_screwLength+2);
    }
}

module kruhovyNastavec() {

    difference() {
        translate([0,0,-kn_screwLength])
        kruhovyNastavecBase();
        kruhovyNastavecOtvory();
   }
}

module kruhovyNastavecOtvory() {

    translate([0,0,-kn_screwLength])
    translate([0,0,-0.1])
    otvorProKruhovyNastavec(height=3,thickness=kn_screwLength+1);
    translate([0,0,-99.9])
    cylinder(d=kn_innerDiameter,h=100);
}

module kruhovyNastavecBase() {
    cylinder(d=kn_outerDiameter,h=kn_screwLength);
}

module otvorProKruhovyNastavec(height = 2.3,thickness=4) {

    union() {
        nastavec(height);
        otvoryProSrouby(thickness+0.2);
    }
}

module samotnyKruhovyNastavec(height = 2.3) {

    difference() {
        nastavec(height);
        translate([0,0,-0.1]) otvoryProSrouby(height+0.2);
    }
}

module nastavec(height = 2.3) {
    diameter = 21;
    
    cylinder(d=diameter,h=height);
}

module otvoryProSrouby(height = 2.3) {
    union() {
        radaOtvoruProSroub(height);
        rotate(90) radaOtvoruProSroub(height);
        rotate(180) radaOtvoruProSroub(height);
        rotate(270) radaOtvoruProSroub(height);
    }
}

module radaOtvoruProSroub(height = 2.3) {
    centerDistance = 7;
    distance = 3.4;

    translate([0,centerDistance,0])
    union() {
        translate([-distance,0,0]) otvorProSroub(height);
        otvorProSroub(height);
        translate([+distance,0,0]) otvorProSroub(height);
    }
}

module otvorProSroub(height = 2.3) {
    screwDiameter = 2.4;

    cylinder(d=screwDiameter,h=height);
}

// ------------------------------------------------------------------
// eof