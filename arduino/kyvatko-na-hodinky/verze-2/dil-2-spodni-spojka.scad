// sof
// ------------------------------------------------------------------
//
// Autor: Ivo Panáček, December 2021
// ivo.panacek@gmail.com
// Version: 2
//
// ------------------------------------------------------------------
//
// díl č. 2 - spodní spojka
//
// ------------------------------------------------------------------

include <../konstanty.scad>
use <../kruhovyNastavec.scad>
use <../nastavecNaOsu.scad>

sirka_desky = 30;

sirka_nohy = kn_outerDiameter;
vyska_nohy = 30;
delka_zahloubeni = 15;

vzdalenost_kruhoveho_nastavce = 44;
delta_nastavce_na_osu = 0.5;
vzdalenost_drzaku = vzdalenost_kruhoveho_nastavce + delta_nastavce_na_osu;

delka_drzaku = vzdalenost_drzaku + kn_screwLength;


// ------------------------------------------------------------------
// main program

//part3();
//part4();

show();

module
show() {
    rotate([180,0,0])
    union() {
        color([1,1,0],0.1)part3_4();
        color([0,1,0],0.4)part5();
    }
}

// ------------------------------------------------------------------
// moduly

module dil_2() {
    rotate([180,0,0])
    union() {
        part3_4();
        part5();
    }
}

module
part3_4(thickness = tloustka_sten, deepening = hloubka_zahloubeni)
{
    translate([0,0,deepening])
    translate([-thickness,0,-vyska_nohy])
    union() {
        translate([vzdalenost_drzaku/2,0,0])
        rotate([90,0,90])part3();
        translate([-vzdalenost_drzaku/2,0,0])
        rotate([90,0,-90])part4();
    }
}

module
part5(thickness = tloustka_sten, deepening = hloubka_zahloubeni)
{
    x = delka_drzaku + 2*thickness;
    y = sirka_desky;

    difference() {

        translate([-x/2,-y/2])
        cube([x,y,thickness]);

        translate([0,0,-delta_zahloubeni/2])
        union() {
            translate([-x/2+thickness/2,0,0])
            teeDeep(thickness,deepening,delta_zahloubeni_nasunovaci);
            translate([x/2-thickness/2,0,0])
            rotate([0,0,180])
            teeDeep(thickness,deepening,delta_zahloubeni);
        }
    }
}

module
teeDeep(thickness = tloustka_sten, deepening = hloubka_zahloubeni, delta = delta_zahloubeni) {
    w1 = delka_zahloubeni + delta;
    h1 = sirka_zahloubeni + delta;

    w2 = thickness + delta;
    h2 = sirka_nohy + delta;

    z = deepening + delta_zahloubeni;

    translate([-delta/2,0,0])
    union() {
        translate([w2,-h1/2,0])
        cube([w1,h1,z]);
        translate([0,-h2/2,0])
        cube([w2,h2,z]);
    }

}

module
part4(thickness = tloustka_sten, deepening = hloubka_zahloubeni)
{

    translate([0,0,thickness])
    union() {
        difference() {
            translate([-sirka_nohy/2,0,-thickness])
            cube([sirka_nohy,vyska_nohy,thickness]);
            nastavecNaOsuOtvor(thickness);
        }    
        translate([0,0,-thickness])
        nastavecNaOsu(thickness);

        color([0,1,1])
        translate([-sirka_zahloubeni/2,vyska_nohy-deepening,-delka_zahloubeni-thickness])
        cube([sirka_zahloubeni,deepening,delka_zahloubeni]);
    }
}

module
part3(thickness = tloustka_sten, deepening = hloubka_zahloubeni)
{

    translate([0,0,kn_screwLength])
    union() {
        difference() {
            translate([-sirka_nohy/2,0,-thickness])
            cube([sirka_nohy,vyska_nohy,thickness]);
            kruhovyNastavecOtvory();
        }    
        kruhovyNastavec(thickness);

        color([0,1,1])
        translate([-sirka_zahloubeni/2,vyska_nohy-deepening,-delka_zahloubeni-thickness])
        cube([sirka_zahloubeni,deepening,delka_zahloubeni]);
    }
}

// ------------------------------------------------------------------
// eof
