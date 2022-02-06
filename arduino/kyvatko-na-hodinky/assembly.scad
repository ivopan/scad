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

celkova_vyska = 68;
vyska = 30;

//spodek1();

//spodek(160*$t-80);
//spodek();
//vrsek();
//spojeni(angleS=60,angleV=30);

animace(0.5);

//animace($t);

// ------------------------------------------------------------------

module animace(time=0) {

    angle = 160 * time - 80;

    angleS = angle;
    angleV = angle;

    spojeni(angleS=angleS,angleV=angleV);

}

module
spodek1(angle=0) {
    color([0,1,1],0.4)
    translate([posunout_stojan_y-4,-9,30])
    rotate([90,-90,180])
    motor();

    color([1,0,0],0.6)
    translate([ 2*tloustka_sten-1, -5, 0 ])
    dil_1();

    color([0,1,0],0.6)
    translate([posunout_stojan_y,-9,38])
    translate([0,0,0])
    
    rotate([angle,0,0])
    translate([16,0,vyska_nohy])
    rotate([180,0,0])
    dil_2();
}

module
spojeni(angleS=0,angleV=0) {
    union() {

        zakladna();

        translate([posunout_stojan_y,-9,38])    
        rotate([angleS,0,0])
        union() {
            translate([11,-7,vyska])
            rotate([0,0,90])
            vrsek(angle=angleV);
            drzak();
        }
    }
}

module
spodek(angle=0) {
    union() {

        zakladna();

        translate([posunout_stojan_y,-9,38])    
        rotate([angle,0,0])
        drzak();
    }
}

module
vrsek(angle=0) {

    union() {

        zakladna();

        translate([posunout_stojan_y,-9,38])    
        rotate([angle,0,0])

        drzak();
    }
}

module
zakladna() {
    color([0,1,1],0.4)
    translate([posunout_stojan_y-4,-9,30])
    rotate([90,-90,180])
    motor();

    color([1,0,0],0.6)
    translate([ 2*tloustka_sten-1, -5, 0 ])
    dil_1();
}

module
drzak() {
    color([0,1,0],0.6)
    translate([16,0,vyska_nohy])
    rotate([180,0,0])
    dil_2();
}

// ------------------------------------------------------------------
// eof