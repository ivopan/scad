// sof
// ------------------------------------------------------------------
//
// Autor: Ivo Panáček, December 2021
// ivo.panacek@gmail.com
// Version: 2
//
// ------------------------------------------------------------------
//
// všechno dohromady
//
// pro animaci je potřeba v menu "Zobrazit" zaškrtnout "Animovat"
// a dole do "FPS:" napsat třeba 20 a do "Kroky:" počet kroků, třeba 10
//
// ------------------------------------------------------------------


include <konstanty.scad>

use <verze-2/dil-1-spodni-drzak.scad>
use <verze-2/dil-2-spodni-spojka.scad>
use <motor.scad>

spodek(160*$t-80);

// ------------------------------------------------------------------

module
spodek(angle=0) {
    color([0,1,1],0.4)
    translate([-4,-9,30])
    rotate([90,-90,180])
    motor();

    color([1,0,0],0.6)
    translate([ 3*tloustka_sten-1.2, -5, 0 ])
    dil_1();

    color([0,1,0],0.6)
    translate([0,-9,38])
    translate([0,0,0])
    rotate([angle,0,0])
    translate([16,0,vyska_nohy])
    rotate([180,0,0])
    dil_2();
}

// ------------------------------------------------------------------
// eof