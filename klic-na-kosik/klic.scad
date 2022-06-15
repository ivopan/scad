// ------------------------------------------------------------------
/*
    klíč do nákupního košíku
*/
// ------------------------------------------------------------------
include <../libs/BOSL/constants.scad>
use <../libs/BOSL/shapes.scad>
use <../libs/BOSL/masks.scad>
// ------------------------------------------------------------------
// rozměry

strana = 20;
srazeni = 0.5;
zakriveni = 3;
delka_nohy = 45;
sirka_nohy_1 = 7;
sirka_nohy_2 = 10;
otvor_v_noze = 4.4;
tloustka = 2.4;

// ------------------------------------------------------------------
// konstanty

smooth = 64;

// ------------------------------------------------------------------


//zaklad();
//drzatko();
klic();

// ------------------------------------------------------------------
// moduly

module
klic()
{
    union() {
        rotate([0,0,45])zaklad();
        translate([delka_nohy/2,0,0])drzatko();
    }
}

module
drzatko()
{
    difference() {
        cuboid([delka_nohy,sirka_nohy_1,tloustka], fillet=srazeni, $fn=smooth);
        translate([delka_nohy/2-otvor_v_noze,0,-tloustka/2])
        union() {
            translate([0,0,-tloustka])cylinder(d=otvor_v_noze,h=3*tloustka, $fn=smooth);
            translate([0,0,tloustka])fillet_hole_mask(d=otvor_v_noze, fillet=srazeni, $fa=2, $fs=2, $fn=smooth);
            rotate([180,0,0])fillet_hole_mask(d=otvor_v_noze, fillet=srazeni, $fa=2, $fs=2, $fn=smooth);
        }
    }
}

module
zaklad()
{
    difference() {
        cube([strana,strana,tloustka],true);
        union() {
            posun = strana/2;
            union() {
                z = tloustka/2;
                translate([0,posun,z]) fillet_mask_x(l=3*strana, r=srazeni, align=V_CENTER, $fn=smooth);
                translate([0,posun,-z]) fillet_mask_x(l=3*strana, r=srazeni, align=V_CENTER, $fn=smooth);
                translate([0,-posun,z]) fillet_mask_x(l=3*strana, r=srazeni, align=V_CENTER, $fn=smooth);
                translate([0,-posun,-z]) fillet_mask_x(l=3*strana, r=srazeni, align=V_CENTER, $fn=smooth);

                translate([posun,0,z]) fillet_mask_y(l=3*strana, r=srazeni, align=V_CENTER, $fn=smooth);
                translate([posun,0,-z]) fillet_mask_y(l=3*strana, r=srazeni, align=V_CENTER, $fn=smooth);
                translate([-posun,0,z]) fillet_mask_y(l=3*strana, r=srazeni, align=V_CENTER, $fn=smooth);
                translate([-posun,0,-z]) fillet_mask_y(l=3*strana, r=srazeni, align=V_CENTER, $fn=smooth);
            }
            union() {
                z = -tloustka;
                translate([posun,posun,z])fillet_mask_z(l=3*tloustka, r=zakriveni, align=V_UP, $fn=smooth);
                translate([-posun,posun,z])fillet_mask_z(l=3*tloustka, r=zakriveni, align=V_UP, $fn=smooth);
                translate([posun,-posun,z])fillet_mask_z(l=3*tloustka, r=zakriveni, align=V_UP, $fn=smooth);
                translate([-posun,-posun,z])fillet_mask_z(l=3*tloustka, r=zakriveni, align=V_UP, $fn=smooth);
            }
        }
    }
}

// ------------------------------------------------------------------
/*eof*/