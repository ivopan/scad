// sof
// ------------------------------------------------------------------
//
// Autor: Ivo Panáček, December 2021
// ivo.panacek@gmail.com
// Version: 0
//
// ------------------------------------------------------------------
//
// spojovací šrouby
//
// ------------------------------------------------------------------

include <konstanty.scad>

// ------------------------------------------------------------------
// main program

spojovaciSrouby();

// ------------------------------------------------------------------
// moduly


module
spojovaciSrouby(thickness = 4, x = 30, y = 50, pos = 1, bez_otvoru = false)
{
    posun = 15;
    w = x/2 - posun;
    h = y/2 - posun;

    posun_pruchodky_x = 24;
    posun_pruchodky_y = 18;

    pos_x = -1;    
    pos_y = pos;

    translate([0,0,-thickness])
    union() {
        translate([w,h,0])spojovaciSroub(thickness);
        translate([-w,h,0])spojovaciSroub(thickness);
        translate([w,-h,0])spojovaciSroub(thickness);
        translate([-w,-h,0])spojovaciSroub(thickness);
        if(! bez_otvoru) {
            if(pos==1) {
                translate([pos_x*(x/2-posun_pruchodky_x),pos_y*(y/2-posun_pruchodky_y),0])pruchodka(thickness);
            } else {
                translate([pos_y*(y/2-posun_pruchodky_y),pos_x*(x/2-posun_pruchodky_x),0])pruchodka(thickness);
            }
        }
    }
}
    
module
spojovaciSroub(thickness = 4)
{
    diameter = 3.2;
    h = 3*thickness;

    union() {
        cylinder(d=diameter, h=h);
        matka();
    }
}

module
matka() {
    diameter = velikost_matky;
    h = vyska_matky;

    translate([0,0,0])
    cylinder(d=diameter, h=h, $fn=6);
}

module
pruchodka(thickness = 4) {
    cylinder(d=prumer_pruchodky,h=3*thickness);
}
    
// ------------------------------------------------------------------
// eof