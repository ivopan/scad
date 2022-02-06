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

vzdalenost_dilu = 30.5 - tloustka_sten - tloustka_drzaku_u_motoru;

delka_zubu = 7;
posun_zubu = 5.4;

posun_chladice = 2*tloustka_sten;
chladic = sirka_motoru_a_kridelek - 2*posun_chladice;

hloubka_zakladny = 21;
hlouba_zakladny_vnejsi = 10;

// deska_x = 64;
// deska_y = 64; // 30;
deska_x = prumer_zakladny;
deska_y = prumer_zakladny;
deska_z = tloustka_spodni_desky;

posunout_stojan_x = ( delka_nohy_motoru - sirka_zahloubeni ) / 2;

echo("Spodni zakladna: ",deska_x,", ",deska_y);

// ------------------------------------------------------------------
// main program

//part1();
//part2();
//partB();
//part1_2();
//dil_1();

// zuby();
// diry_na_zuby();

show();

//chladic(tloustka_sten);

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
    translate([posunout_stojan_y, sirka_zahloubeni/2 + posunout_stojan_x, 0])
    union() {
        // stojka
        color([1,1,0],0.4)
        translate([w/2,0,0])part1();
        // trn
        color([0,1,0],0.4)
        translate([-w/2,0,0])part2();
    }
}

module
partB_0(thickness = tloustka_spodni_desky, deepening = hloubka_zahloubeni)
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

            translate([posunout_stojan_y+thickness/2,posunout_stojan_x,-deepening-delta_zahloubeni/2])
            color([1,0,0])
            union() {
                // trn
                translate([-vz/2,0,0])
                translate([-h2_vnejsi,-w2/2,0])cube([h2_vnejsi,w2,z]);
                // drzak
                translate([vz/2,0,0])
                translate([-h2,-w2/2,0])cube([h2,w2,z]);
                // dira
                color([1,1,0])
                translate([vz/2-8-tloustka_sten,-2*w2,-2*thickness])
                cube([8,delka_nohy_motoru+tloustka_sten,3*thickness]);
            }
        }
        union() {
            translate([0,0,-1])
            spojovaciSrouby(thickness,deska_x,deska_y);
        }
    }
}

module
partB(thickness = tloustka_spodni_desky, deepening = hloubka_zahloubeni)
{
    vz = vzdalenost_dilu+thickness;

    h2 = hloubka_zakladny + 2*delta_zahloubeni;
    h2_vnejsi = hlouba_zakladny_vnejsi + 2*delta_zahloubeni;
    w2 = sirka_zahloubeni + 2*delta_zahloubeni;
    z = deepening + delta_zahloubeni;

    translate([delta_zahloubeni,0,deepening])
    difference() {
        difference() {
            // translate([-deska_x/2,-deska_y/2,-deska_z])
            // cube([deska_x,deska_y,deska_z]);
            translate([0,0,-deska_z])
            cylinder(d=deska_x,h=deska_z);

            translate([posunout_stojan_y+thickness/2,posunout_stojan_x,-deepening-delta_zahloubeni/2])
            color([1,0,0])
            union() {
                // trn
                translate([-vz/2,0,0])
                translate([-h2_vnejsi,-w2/2,0])cube([h2_vnejsi,w2,z]);
                // drzak
                translate([vz/2,0,0])
                translate([-h2,-w2/2,0])cube([h2,w2,z]);
                // dira
                color([1,1,0])
                translate([vz/2-8-tloustka_sten,-2*w2,-2*thickness])
                cube([8,delka_nohy_motoru+tloustka_sten,3*thickness]);
            }
        }
        union() {
            translate([0,0,-1])
            spojovaciSrouby(thickness,deska_x,deska_y);
        }
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
    difference() {
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
        translate([vzdalenost_dilu+2*thickness,0,0])
        diry_na_zuby(thickness);
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
            translate([hloubka_zakladny/2-thickness, 0, 0])
            color([1,0,0])
            chladic(thickness);
        }

        translate([ hloubka_zakladny, 0, 0])
        zuby(thickness);

        difference() {
            color([0,1,1])
            translate([ 0, -w2, 0])
            cube([hloubka_zakladny,w2,deepening]);
            // dira
            wd=delka_nohy_motoru+tloustka_sten;
            color([1,1,0])
            translate([hloubka_zakladny-8-thickness,-wd-thickness,-deepening*0.5])
            cube([8,wd,2*deepening]);
        }
    }
}

module
zuby(thickness = tloustka_sten) {
    pocet = 4;
    color([1,0,0],0.4)
    translate([-thickness/2-vzdalenost_dilu-thickness,-thickness/2,delka_zubu/2+hloubka_zahloubeni+posun_zubu])
    for(i=[0:pocet-1]) {
        translate([0,0,i*2*delka_zubu])zub(thickness);
    }
}

module
diry_na_zuby(thickness = tloustka_sten) {
    pocet = 4;
    color([0,1,0],0.6)
    translate([-thickness/2-vzdalenost_dilu-thickness,-thickness/2,delka_zubu/2+hloubka_zahloubeni+posun_zubu])
    for(i=[0:pocet-1]) {
        translate([0,0,i*2*delka_zubu])dira_na_zub(thickness);
    }
}

module
zub(thickness = tloustka_sten) {
    translate([-thickness/2,-thickness/2,-delka_zubu/2])
    cube([thickness,thickness,delka_zubu]);
}

module
dira_na_zub(thickness = tloustka_sten) {
    h = delka_zubu+delta_zahloubeni;
    t = thickness+delta_zahloubeni;
    t2 = thickness+1;
    translate([-t2/2,-t/2,-h/2])
    cube([t2,t,h]);
}

module
chladic(thickness = tloustka_sten) {
    delta_x = 6;
    pocet_x = 2;
    pocet_y = 10;
    for(i=[0:pocet_x-1]) {
        translate([2*i*delta_x,0,0])
        chladic_row(thickness,pocet_y);
        translate([(2*i+1)*delta_x,0,0])
        chladic_row(thickness,pocet_y-1);
    }
}

module
chladic_row(thickness = tloustka_sten, pocet = 4) {
    delta_y = 4;
    translate([0,-delta_y*(pocet-1)/2,0])
    for(i=[0:pocet-1]) {
        translate([0,i*delta_y,0])chladic1(thickness);
    }
}

module
chladic1(thickness = tloustka_sten) {
    h = 2;
    w = 4;
    translate([-w/2,-h/2,-thickness])
    cube([w,h,3*thickness]);
}


// ------------------------------------------------------------------
// eof
