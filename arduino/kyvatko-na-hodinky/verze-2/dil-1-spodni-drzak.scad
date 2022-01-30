// sof
// ------------------------------------------------------------------
//
// Autor: Ivo Panáček, December 2021
// ivo.panacek@gmail.com
// Version: 2
//
// ------------------------------------------------------------------
//
// díl č. 1 - spodní držák
//
// ------------------------------------------------------------------

include <../konstanty.scad>
use <../drzakMotoru.scad>

vzdalenost_dilu = 30;

posun_chladice = 2*tloustka_sten;
chladic = sirka_motoru_a_kridelek-2*posun_chladice;

hlouba_zakladny = 21;

deska_x = 70;
deska_y = 40;
deska_z = tloustka_spodni_desky;

// ------------------------------------------------------------------
// main program

//part1();
//part2();

show();

module
show() {
    color([1,1,0],0.1)part1_2();
    color([0,1,1],0.6)partB();
}

// ------------------------------------------------------------------
// moduly

module
dil_1() {
    part1_2();
    partB();
}

module
part1_2(thickness = tloustka_sten, deepening = hloubka_zahloubeni)
{
    w = vzdalenost_dilu;
    translate([11,sirka_zahloubeni/2,0])
    union() {
        translate([w/2,0,0])part1();
        translate([-w/2,0,0])part2();
    }
}

module
partB(thickness = tloustka_sten, deepening = hloubka_zahloubeni)
{
    vz = vzdalenost_dilu;

    h2 = hlouba_zakladny + delta_zahloubeni;
    w2 = sirka_zahloubeni + delta_zahloubeni;
    z = deepening + delta_zahloubeni;

    translate([0,0,deepening])
    difference() {
        translate([-deska_x/2,-deska_y/2,-deska_z])
        cube([deska_x,deska_y,deska_z]);

        translate([0,0,-deepening-delta_zahloubeni/2])
        union() {
            translate([-vz/2,0,0])
            translate([-h2/2,-w2/2,0])cube([h2,w2,z]);
            translate([vz/2+thickness,0,0])
            translate([-h2/2,-w2/2,0])cube([h2,w2,z]);
        }
    }
}

module
part2(thickness = tloustka_sten, deepening = hloubka_zahloubeni)
{
    height = sirka_motoru_a_kridelek;
    width = delka_nohy_motoru+thickness;
    w2 = sirka_zahloubeni;

    translate([-thickness,0,0])
    union() {
        translate([0,-width/2,deepening])
        union() {
            translate([-vyska_trnu,0,vyska_osy+sirka_nohy_motoru])
            rotate([0,90,0])
            cylinder(d=prumer_trnu,h=vyska_trnu);

            translate([0,-width/2,0])
            cube([thickness,width,height]);
        }

        color([0,1,1])
        translate([ -hlouba_zakladny+thickness, -w2, 0])
        cube([hlouba_zakladny,w2,deepening]);
    }
}

module
part1(thickness = tloustka_sten, deepening = hloubka_zahloubeni)
{
    width = sirka_motoru_a_kridelek;
    hlouba_zakladny = 21;
    w2 = sirka_zahloubeni;

    //zada = hlouba_zakladny;
    zada = vzdalenost_dilu+thickness;

    translate([-hlouba_zakladny+thickness, 0, 0])
    union() {
        translate([ hlouba_zakladny, 0, width/2+deepening])
        rotate([ -90, 0, 180 ]) 
        difference() {
            drzakMotoruSeZakladnou( thickness=thickness, hlouba_zakladny=zada);
            z = 3*thickness;
            translate([posun_chladice,-chladic/2,-z/3])
            cube([100,chladic,z]);
        }


        color([0,1,1])
        translate([ 0, -w2, 0])
        cube([hlouba_zakladny,w2,deepening]);
    }
}

// ------------------------------------------------------------------
// eof
