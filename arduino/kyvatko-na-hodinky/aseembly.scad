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
// ------------------------------------------------------------------


use <verze-2/dil-1-spodni-drzak.scad>
use <verze-2/dil-2-spodni-spojka.scad>
use <motor.scad>


color([0,1,1],0.4)
translate([-4,-9,31])
rotate([90,-90,180])
motor();

color([1,0,0],0.6)
dil_1();

color([0,1,0],0.6)
translate([0,-9,38])
translate([16,0,30])
rotate([180,0,0])
dil_2();

// ------------------------------------------------------------------
// eof