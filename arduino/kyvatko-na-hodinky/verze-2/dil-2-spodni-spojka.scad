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
use <../spojovaciSrouby.scad>

//sirka_desky = 64;
sirka_desky = prumer_zakladny;
sirka_desky_y = prumer_zakladny;

sirka_nohy = kn_outerDiameter;

delka_zahloubeni = 15;

vzdalenost_kruhoveho_nastavce = 44;
delta_nastavce_na_osu = 0.5;
vzdalenost_drzaku = vzdalenost_kruhoveho_nastavce + delta_nastavce_na_osu;

delka_drzaku = vzdalenost_drzaku + kn_screwLength;

// ------------------------------------------------------------------
// main program

//sroub();
//part3();
//part3spojka();
//part4();
part5();

//show();

// ------------------------------------------------------------------

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
        rotate([90,0,90])
        union() {
            part3();
            part3spojka();
        }
        translate([-vzdalenost_drzaku/2,0,0])
        rotate([90,0,-90])part4();
    }
}

module
part5_0(thickness1 = tloustka_sten, thickness2 = tloustka_sten_spojky, deepening = hloubka_zahloubeni)
{
    //x = delka_drzaku + 2*thickness1;
    x = sirka_desky_y;
    y = sirka_desky;

    echo("Horni drzak: ",x,", ",y);

    difference() {

        difference() {
            translate([-x/2,-y/2,0])
            cube([x,y,thickness1]);
            spojovaciSrouby(thickness=thickness1,x=x,y=y,pos=-1);
        }

        translate([0,0,-delta_zahloubeni/2])
        union() {
            // pro part4
            translate([-x/2+thickness1/2,0,0])
            teeDeep(thickness1,deepening,delta_zahloubeni_nasunovaci);
            // pro part3spojka
            translate([x/2-thickness1/2-thickness1,0,0])
            rotate([0,0,180])
            teeDeep(thickness2,deepening,delta_zahloubeni);
        }
    }
}

module
part5(thickness1 = tloustka_sten, thickness2 = tloustka_sten_spojky, deepening = hloubka_zahloubeni)
{
    x = delka_drzaku + 2*thickness1;
    deska_x = sirka_desky_y;
    deska_y = sirka_desky;

    echo("Horni drzak: ",deska_x,", ",deska_y);

    difference() {

        difference() {
            // translate([-deska_x/2,-deska_y/2,0])
            // cube([deska_x,deska_y,thickness1]);
            cylinder(d=deska_x,h=thickness1);
            translate([0,0,1.3+2.6])
            spojovaciSrouby(thickness=thickness1,x=deska_x,y=deska_y,pos=-1);
        }

        translate([0,0,-delta_zahloubeni/2])
        union() {
            // pro part4
            translate([-x/2+thickness1/2,0,0])
            teeDeep(thickness1,deepening,delta_zahloubeni_nasunovaci);
            // pro part3spojka
            translate([x/2-thickness1/2-thickness1,0,0])
            rotate([0,0,180])
            teeDeep(thickness2,deepening,delta_zahloubeni);
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

    h = vyska_nohy - deepening;

    difference() {
        translate([0,0,kn_screwLength])
        union() {
            difference() {
                translate([-sirka_nohy/2,0,-thickness])
                cube([sirka_nohy,h,thickness]);
                kruhovyNastavecOtvory();
            }    
            kruhovyNastavec();
        }
        color([1,0,0])
        translate([0, 0, thickness])
        srouby(thickness);
    }
}

module
part3spojka(thickness1 = tloustka_sten, thickness2 = tloustka_sten_spojky, deepening = hloubka_zahloubeni)
{

    posun = vyska_nohy - vyska_spojky_nohy;
    h = kn_screwLength-thickness1;

    difference() {
        translate([0,posun,h])
        union() {
            translate([-sirka_nohy/2,0,-thickness2])
            cube([sirka_nohy,vyska_spojky_nohy,thickness2]);

            color([0,1,1])
            translate([-sirka_zahloubeni/2,vyska_spojky_nohy-deepening,-delka_zahloubeni-thickness2])
            cube([sirka_zahloubeni,deepening,delka_zahloubeni]);
        }
        color([1,0,0])
        translate([0,0,h-thickness2-0.05])
        srouby(thickness2,deepening);
    }
}

module
srouby(thickness = tloustka_sten, deepening = hloubka_zahloubeni) {
    posun = vyska_nohy - vyska_spojky_nohy;
    p = posun + (vyska_spojky_nohy-deepening)/2;
    y = sirka_nohy/2-sirka_nohy/4;

    translate([y,p,0])sroub(thickness);
    translate([-y,p,0])sroub(thickness);
}

module
sroub(thickness = tloustka_sten) {
    diameter = 3.2;
    h = 3*thickness;

    union() {
        cylinder(d=diameter, h=h);
        matka();
    }
}

module
matka() {
    diameter = 6.7;
    h = 2.6;

    translate([0,0,0])
    cylinder(d=diameter, h=h, $fn=6);
}

// ------------------------------------------------------------------
// eof
