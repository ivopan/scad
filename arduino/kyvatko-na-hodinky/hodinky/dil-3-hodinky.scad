// sof
// ------------------------------------------------------------------
//
// Autor: Ivo Panáček, December 2021
// ivo.panacek@gmail.com
// Version: 2
//
// ------------------------------------------------------------------
//
// díl č. 3 - držák hodinek
//
// ------------------------------------------------------------------

include <../konstanty.scad>
// ------------------------------------------------------------------
// main program

vyska_hlavice_sroubu = 3.4;

vyska_hodinek = 13;
vyska_pasku_hodinek = 5;

pruhled = 36;

vyska_spary = 0.2;

tloustka_spodni_zaklad = 1;
tloustka_spodni_mezi = vyska_pasku_hodinek + vyska_hlavice_sroubu;

tloustka_horni_zaklad = 1;

tloustka_zaklad = tloustka_spodni_zaklad + tloustka_horni_zaklad;
echo("tloustka_zaklad",tloustka_zaklad);

tloustka_komplet = tloustka_zaklad + vyska_hodinek + vyska_hlavice_sroubu;
echo("tloustka_komplet",tloustka_komplet);

tloustka_spodni = tloustka_spodni_zaklad + tloustka_spodni_mezi;
echo("tloustka_spodni",tloustka_spodni);

tloustka_horni = tloustka_komplet - tloustka_spodni_zaklad;
echo("tloustka_horni",tloustka_horni);

tloustka_horni_mezi = tloustka_horni - tloustka_horni_zaklad - vyska_spary - tloustka_spodni_mezi;
echo("tloustka_horni_mezi",tloustka_horni_mezi);

tloustka_mezi = tloustka_spodni_mezi + tloustka_horni_mezi + vyska_spary;
echo("tloustka_mezi",tloustka_mezi);

sirka_ramu = 3;
delta_ramu = 0.2;

//hodinky();
//hodinky(true);

//hlavice();
//spojovaciSroub(10);
//spojovaciSrouby(10,50,50);

dil_3_spodek();
//rotate([180,0,0])dil_3_kryt();

//show();

// ------------------------------------------------------------------

module
show() {
    translate([0,0,tloustka_spodni_mezi])
    color([0,1,0],0.05)dil_3_spodek();
    color([0,0,1],0.05)dil_3_kryt();
    translate([0,0,vyska_hlavice_sroubu])
    hodinky();
}

// ------------------------------------------------------------------
// moduly

module
dil_3_kryt() {

    h = vyska_spary + tloustka_spodni;
    w1 = prumer_zakladny;
    w2 = w1-sirka_ramu+delta_ramu;

    difference() {
        difference() {
            difference() {
                cylinder(d=w1,h=tloustka_horni);
                translate([0,0,-0.1])
                cylinder(d=w2,h=h+0.1);
            }
            translate([0,0,-50])
            cylinder(d=pruhled,h=100);
        }
        translate([0,0,vyska_hlavice_sroubu])
        hodinky(true);
    }
}

module
dil_3_spodek() {

    h = tloustka_spodni_zaklad + tloustka_spodni_mezi;
    w1 = prumer_zakladny;
    w2 = w1-sirka_ramu;

    difference() {
        difference() {
            union() {
                translate([0,0,-tloustka_spodni_mezi])
                cylinder(d=w2,h=tloustka_spodni_mezi);
                translate([0,0,-h])
                cylinder(d=w1,h=tloustka_spodni_zaklad);
            }
            color([0,0,1])
            translate([0,0,-tloustka_spodni_mezi+vyska_hlavice_sroubu])
            spojovaciSrouby(10*h,w1,w1);
        }
        translate([0,0,-vyska_pasku_hodinek])
        hodinky();
    }
}

// ------------------------------------------------------------------

module
spojovaciSrouby(thickness = 4, x = 30, y = 50)
{
    posun = posun_spojovacich_sroubu;
    w = x/2 - posun;
    h = y/2 - posun;

    union() {
        translate([w,h,0])spojovaciSroub(thickness);
        translate([-w,h,0])spojovaciSroub(thickness);
        translate([w,-h,0])spojovaciSroub(thickness);
        translate([-w,-h,0])spojovaciSroub(thickness);
    }
}
    
module
spojovaciSroub(thickness = 4)
{
    diameter = prumer_spojovaciho_sroubu;
    h = thickness;

    union() {
        translate([0,0,-h])
        cylinder(d=diameter, h=h);
        hlavice();
    }
}

module
hlavice() {
    diameter = 5.8;
    h = vyska_hlavice_sroubu;
    delta = 40;

    translate([0,0,-h])
    cylinder(d=diameter, h=h+delta);
}

// ------------------------------------------------------------------

module
hodinky(hluboky_pasek = false) {
    vyska = vyska_hodinek;
    delka = 51;
    sirka_stred = 50;
    sirka_kraj = 33;
    sirka_pasku = 22;
    vyska_pasku = vyska_pasku_hodinek + 0.1;
    delka_pasku = 300;

    r1 = sirka_stred/2;
    r2 = sirka_kraj/2;
    h = r1-r2;
    s = delka;
    r = s*s/(8*h);
    x = r-r1;

    color([1,0,0])
    union() {
        pulhodinky(vyska,r,s/2,x);
        rotate([0,0,180])pulhodinky(vyska,r,s/2,x);
        if(hluboky_pasek) {
            delta = 2*vyska_hlavice_sroubu;
            translate([-sirka_pasku/2,-delka_pasku/2,-delta])
            cube([sirka_pasku,delka_pasku,vyska_pasku+delta]);
        } else {
            translate([-sirka_pasku/2,-delka_pasku/2,0])
            cube([sirka_pasku,delka_pasku,vyska_pasku]);
        }
    }
}

module
pulhodinky(tloustka,r,v,x) {

    h = 3*tloustka;
    d = 2*r;

    difference() {
        translate([-x,0,0])
        cylinder(d=d,tloustka);
        union() {
            translate([-2*d-1,-d,-tloustka])
            cube([2*d,2*d,h]);
            translate([-d,v,-tloustka])
            cube([2*d,2*d,h]);
            translate([-d,-2*d-v,-tloustka])
            cube([2*d,2*d,h]);
        }
    }
}

// ------------------------------------------------------------------
// eof
