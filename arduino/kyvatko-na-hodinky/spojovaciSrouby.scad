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
spojovaciSrouby(thickness = 4, x = 30, y = 50)
{
    posun = 5;
    
    w = x/2 - posun;
    h = y/2 - posun;

    translate([0,0,-thickness])
    union() {
        translate([w,h,0])spojovaciSroub(thickness);
        translate([-w,h,0])spojovaciSroub(thickness);
        translate([w,-h,0])spojovaciSroub(thickness);
        translate([-w,-h,0])spojovaciSroub(thickness);
    }
}
    
module
spojovaciSroub(thickness = 4)
{
    diameter = 3.2;
    h = 3*thickness;

    cylinder(d=diameter, h=h);
}
    
// ------------------------------------------------------------------
// eof