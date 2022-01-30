// sof
// ------------------------------------------------------------------
//
// Autor: Ivo Panáček, December 2021
// ivo.panacek@gmail.com
// Version: 1
//
// ------------------------------------------------------------------
//
// díl č. 0 - základna
//
// ------------------------------------------------------------------

use <drzakMotoru.scad>;

sqrt2 = sqrt(2);

// ------------------------------------------------------------------
// main program

//leg(4,30,50,10,20);
//legs(4,50,140);
//block(4,140);

part0();

// ------------------------------------------------------------------
// moduly

module part0(thickness=4) {
    width = 140;

    difference() {
        block(thickness=thickness,width = 140);
        translate([0,0,1])
        hole(thickness);
    }
}

module hole(thickness=4) {
    gap = 0.2;
    width = 55 + gap;
    height = 31 + gap;

    translate([-height/2,-width/2,0])
    cube([height,width,thickness]);
}

module fullBlock(thickness=4,width = 140) {

    translate([-width/2,-width/2,0])
    cube([width,width,thickness]);
}

module block(thickness=4,width = 140) {
    innerWidth = 60;

    union() {
        translate([-innerWidth/2,-innerWidth/2,0])
        cube([innerWidth,innerWidth,thickness]);
        legs(thickness,innerWidth,width);
    }
}

module legs(thickness,innerWidth, width) {
    legSize = (width-innerWidth)/2;
    legHeight = legSize * sqrt2;
    pawWidth = 10;
    shift = (innerWidth-pawWidth)/2;
    hoof = 20;

    union() {
        leg(thickness,shift,legHeight,pawWidth,hoof);
        rotate([0,0,90]) leg(thickness,shift,legHeight,pawWidth,hoof);
        rotate([0,0,180]) leg(thickness,shift,legHeight,pawWidth,hoof);
        rotate([0,0,270]) leg(thickness,shift,legHeight,pawWidth,hoof);
    }
}


module leg(thickness,shift,height,pawWidth,width) {
    move = height/sqrt2;
    translate([move+shift,-move-shift,0])
    union() {
        rotate([0,0,45])
        translate([-pawWidth/2,0,0])
        cube([pawWidth,height,thickness]);
        color([0,1,0])
        translate([-width/2,-width/2,0])
        cube([width,width,thickness]);
    }
}

// ------------------------------------------------------------------
// eof