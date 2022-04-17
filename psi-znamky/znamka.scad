/*
    psí známka

    10x zmenšit

*/
include <../libs/BOSL/constants.scad>
use <../libs/BOSL/shapes.scad>
use <../libs/BOSL/masks.scad>
// ------------------------------------------------------------------
smooth = 240;

faktor = 10;

sirka = 20;
delka = 40;
tloustka = 2;

prumer_otvoru = 3;
posun_otvoru = 5;

font = "DejaVu Sans Mono:style=Bold Oblique";

posun_telefonu = 3;

zahloubeni = 0.5;

//placka();
//otvor();
//zakladna();

//telefon();
//zakladna_s_telefonem();

//jmeno("ČERT");
//jmeno("MIKULÁŠ");

znamka("ČERT");
//znamka("MIKULÁŠ");

// ------------------------------------------------------------------
// moduly

module
znamka(s) {
    difference() {
        zakladna_s_telefonem();
        translate([(-delka/2+posun_telefonu)*faktor,-25,(tloustka/2-zahloubeni)*faktor])
        jmeno(s);
    }
}

module
jmeno(s) {
    linear_extrude(height=tloustka*faktor)
    scale(5)
    union() {
        napis(s);
    }
}

module
zakladna_s_telefonem() {
    rotate([180,0,0])
    difference() {
        zakladna();
        translate([(-delka/2+posun_telefonu)*faktor,-10,(tloustka/2-zahloubeni)*faktor])
        telefon();
    }
}

module
telefon() {
    linear_extrude(height=tloustka*faktor)
    scale(3.2)
    union() {
        translate([0,10,0])napis("   +420");
        translate([0,-10,0])napis("602 337 776");
    }
}

module
napis(s) {
    text(text=s, font=font, $fn=smooth);
}

module
zakladna()
{    
    difference() {
        placka();
        translate([(delka/2-posun_otvoru)*faktor,0,0])
        otvor();
    }
}

module
placka()
{    
    cuboid([delka*faktor,sirka*faktor,tloustka*faktor], fillet=10, $fn=smooth);
}

module otvor()
{
    union() {
        translate([0,0,-1])
        cylinder(h=4+tloustka*faktor, d=prumer_otvoru*faktor, center=true, $fn=smooth);
        translate([0,0,tloustka*faktor/2])
        fillet_hole_mask(d=prumer_otvoru*faktor, fillet=10, $fa=2, $fs=2, $fn=smooth);
        translate([0,0,-tloustka*faktor/2])
        rotate([180,0,0])
        fillet_hole_mask(d=prumer_otvoru*faktor, fillet=10, $fa=2, $fs=2, $fn=smooth);
    }
}

/*eof*/