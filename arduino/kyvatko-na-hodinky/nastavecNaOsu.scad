// sof
// ------------------------------------------------------------------
//
// Autor: Ivo Panáček, December 2021
// ivo.panacek@gmail.com
// Version: 1
//
// ------------------------------------------------------------------
//
// nástavec na osu držáku
//
// ------------------------------------------------------------------

include <konstanty.scad>

// ------------------------------------------------------------------
// main program

nastavecNaOsu();

// ------------------------------------------------------------------
// moduly

module nastavecNaOsu(thickness=4) {
    difference() {
        cylinder(d=kn_outerDiameter,h=thickness);
        nastavecNaOsuOtvor(thickness);
    }
}

module nastavecNaOsuOtvor(thickness=4) {
    translate([0,0,-thickness])
    cylinder(d=prumer_trnu+delta_otvoru_trnu,h=3*thickness);
}

// ------------------------------------------------------------------
// eof