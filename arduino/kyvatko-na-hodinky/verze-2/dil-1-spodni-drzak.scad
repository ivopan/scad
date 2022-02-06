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
use <../spojovaciSrouby.scad>

vzdalenost_dilu = 30.5;

posun_chladice = 2*tloustka_sten;
chladic = sirka_motoru_a_kridelek - 2*posun_chladice;

hloubka_zakladny = 21;
hlouba_zakladny_vnejsi = 10;

deska_x = 64;
deska_y = 64; // 30;
deska_z = tloustka_spodni_desky;

posunout_stojan = ( delka_nohy_motoru - sirka_zahloubeni ) / 2;

echo("Spodni zakladna: ",deska_x,", ",deska_y);

// ------------------------------------------------------------------
// main program

//part1();
//part2();
//partB();
//part1_2();
//dil_1();

show();

// ------------------------------------------------------------------

module
show() {
    translate([0,0,hloubka_zahloubeni+0.5])
    color([1,1,0],0.1)part1_2();
    //color([0,1,1],0.6)
    partB();
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
    w = vzdalenost_dilu+2*thickness;
    translate([0, sirka_zahloubeni/2 + posunout_stojan, 0])
    union() {
        // stojka
        translate([w/2,0,0])part1();
        // trn
        translate([-w/2,0,0])part2();
    }
}

module
partB(thickness = tloustka_sten, deepening = hloubka_zahloubeni)
{
    vz = vzdalenost_dilu+thickness;

    h2 = hloubka_zakladny + 2*delta_zahloubeni;
    h2_vnejsi = hlouba_zakladny_vnejsi + 2*delta_zahloubeni;
    w2 = sirka_zahloubeni + 2*delta_zahloubeni;
    z = deepening + delta_zahloubeni;

    translate([delta_zahloubeni,0,deepening])
    difference() {
        difference() {
            translate([-deska_x/2,-deska_y/2,-deska_z])
            cube([deska_x,deska_y,deska_z]);

            translate([thickness/2,posunout_stojan,-deepening-delta_zahloubeni/2])
            color([1,0,0])
            union() {
                // trn
                translate([-vz/2,0,0])
                translate([-h2_vnejsi,-w2/2,0])cube([h2_vnejsi,w2,z]);
                // drzak
                translate([vz/2,0,0])
                translate([-h2,-w2/2,0])cube([h2,w2,z]);
            }
        }

        spojovaciSrouby(thickness,deska_x,deska_y);
    }
}

module
part2(thickness = tloustka_sten, deepening = hloubka_zahloubeni)
{
    height = sirka_motoru_a_kridelek;
    width = delka_nohy_motoru+thickness;
    w2 = sirka_zahloubeni;

    x = hlouba_zakladny_vnejsi;

    // translate([-thickness,0,0])
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
        translate([ -x+thickness, -w2, 0])
        cube([x,w2,deepening]);
    }
}

module
part1(thickness = tloustka_sten, deepening = hloubka_zahloubeni)
{
    width = sirka_motoru_a_kridelek;
    hloubka_zakladny = 21;
    w2 = sirka_zahloubeni;

    //zada = hloubka_zakladny;
    zada = vzdalenost_dilu + thickness;

    translate([-hloubka_zakladny, 0, 0])
    union() {
        translate([ hloubka_zakladny, 0, width/2+deepening])
        rotate([ -90, 0, 180 ]) 
        difference() {
            drzakMotoruSeZakladnou( thickness=thickness, hloubka_zakladny=zada);
            z = 3*thickness;
            translate([posun_chladice,-chladic/2,-z/3])
            cube([100,chladic,z]);
        }


        color([0,1,1])
        translate([ 0, -w2, 0])
        cube([hloubka_zakladny,w2,deepening]);
    }
}

// ------------------------------------------------------------------
// eof
