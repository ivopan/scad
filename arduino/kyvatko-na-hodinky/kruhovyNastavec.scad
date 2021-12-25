// sof
// ------------------------------------------------------------------
//
// Autor: Ivo Panáček, December 2021
// ivo.panacek@gmail.com
// Version: 0
//
// ------------------------------------------------------------------
//
// otvor pro kruhový nástavec na motor MG996R
//
// délka šroubu je 11.5, tloušťka nástavce je 2.3
// => je třeba ještě 9 mm nad tím
//
// ------------------------------------------------------------------

// dreh=$t*360;
$fn=1000;

// ------------------------------------------------------------------
// main program

zakladnaSKruhovymNastavecem();
//kruhovyNastavec();
//otvorProKruhovyNastavec();

// ------------------------------------------------------------------
// moduly

module zakladnaSKruhovymNastavecem(thickness=4) {
    screwLength = 11.5;
    width = 30;
    height = 30;
    delta=15;

    difference() {
        union() {
            cube([width,height,thickness]);
            translate([width-delta,delta,thickness])
            kruhovyNastavec();
        }
        translate([width-delta,delta,-screwLength+3])
        otvoryProSrouby(screwLength+2);
    }
}

module kruhovyNastavec() {
    screwLength = 11.5;
    innerDiameter = 10;
    outerDiameter = 27;

    translate([0,0,-screwLength])
    difference() {
        kruhovyNastavecBase();
        translate([0,0,-0.1])
        otvorProKruhovyNastavec(height=3,thickness=screwLength+1);
   }
}

module kruhovyNastavecBase() {
    screwLength = 11.5;
    innerDiameter = 10;
    outerDiameter = 27;

    difference() {
        cylinder(d=outerDiameter,h=screwLength);
        translate([0,0,-1])
        cylinder(d=innerDiameter,h=screwLength+2);
    }

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
    screwDiameter = 1.4;
    diameter = 2;

    cylinder(d=diameter,h=height);
}

// ------------------------------------------------------------------
// eof