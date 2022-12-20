// ------------------------------------------------------------------
/*
    náhradní rukojeť ke schránce pro kočku
*/
// ------------------------------------------------------------------
include <../../libs/BOSL/constants.scad>
use <../../libs/BOSL/shapes.scad>
// ------------------------------------------------------------------
// rozměry - nastavení

trn_prumer = 6.4;
trn_delka = 4.4;

hlava_delka = 1.4;
hlava_vyska = 8;
hlava_plocha = 4.4;

za_trnem_prumer = 8.2;
za_trnem_delka = 8;

rukojet_roztec_vnejsi = 127.6;
rukojet_vyska_vnitrni = 40-za_trnem_prumer/2;
rukojet_vyska_horni = 21;
rukojet_tloustka_horni = 15;

maska = 300;

// ------------------------------------------------------------------
// rozměry - výpočty

nasadka_delka = trn_delka+hlava_delka+za_trnem_delka;

// ------------------------------------------------------------------
// konstanty

smooth = 64; // pro ladění
//smooth = 256; // pro reálný tisk

// ------------------------------------------------------------------

//trn();
//za_trnem();
//hlava();
//nasadka();
//obe_nasadky();

//drzadlo_nahoru();
//drzadlo_maska();
//drzadlo_zaklad();
//drzadlo();
//maska_drzadla();


//komplet();
vysledek();


// ------------------------------------------------------------------
// moduly

module
vysledek()
{
    rotate([0,90,0])
    difference() {
        komplet();
        translate([0,-maska/2,-maska/2])cube([maska,maska,maska]);
    }
}

module
komplet()
{
    union() {
        obe_nasadky();
        drzadlo();
    }
}

// ------------------------------------------------------------------
// drzadlo

module
drzadlo()
{
    difference() {
        drzadlo_zaklad();
        maska_drzadla();
    }
}

module
maska_drzadla()
{
    union() {
        spodni_maska_drzadla();
        horni_maska_drzadla();
    }

}

module
horni_maska_drzadla()
{
    delka = rukojet_roztec_vnejsi+za_trnem_delka;
    sirka = rukojet_tloustka_horni;
    translate([0,0,rukojet_vyska_vnitrni+rukojet_vyska_horni-sirka/2])
    rotate([90,0,0])
    difference() {
        difference() {
            cube([2*sirka,2*sirka,delka],center=true);
            cylinder(d=sirka,h=delka+2,center=true,$fn=smooth);
        }
        translate([0,-sirka,0])cube([4*sirka,2*sirka,2*delka],center=true);
    }
}

module
spodni_maska_drzadla()
{
    delka = rukojet_roztec_vnejsi-2*za_trnem_delka;
    sirka = rukojet_tloustka_horni;
    translate([0,0,rukojet_vyska_vnitrni+sirka/2])
    rotate([90,0,0])
    difference() {
        difference() {
            cube([2*sirka,2*sirka,delka],center=true);
            cylinder(d=sirka,h=delka+2,center=true,$fn=smooth);
        }
        translate([0,sirka,0])cube([4*sirka,2*sirka,2*delka],center=true);
    }
}

module
drzadlo_zaklad()
{
    difference() {
        drzadlo_nahoru();
        drzadlo_maska();
    }
}

module
drzadlo_maska()
{
    delka = rukojet_roztec_vnejsi-2*za_trnem_delka;
    vyska = rukojet_vyska_vnitrni+2;
    tlouska = 10*rukojet_tloustka_horni;
    translate([0,0,vyska/2-2])cube([tlouska,delka,vyska],center=true);
}

module
drzadlo_nahoru()
{
    delka = rukojet_roztec_vnejsi;
    spodni_sirka = za_trnem_prumer;
    horni_sirka = rukojet_tloustka_horni;
    vyska = rukojet_vyska_vnitrni+rukojet_vyska_horni;
    prismoid(size1=[spodni_sirka,delka], size2=[horni_sirka,delka], h=vyska);
}

// ------------------------------------------------------------------
// nasadky

module
obe_nasadky()
{
    translate([0,-rukojet_roztec_vnejsi/2,0])
    union() {
        nasadka();
        translate([0,rukojet_roztec_vnejsi,0])rotate([0,0,180])nasadka();
    }
}

module
nasadka()
{
    center = hlava_delka+trn_delka/2+za_trnem_delka;
    translate([0, center-nasadka_delka, 0])
    union() {
        rotate([90,0,0])trn();
        translate([0,(za_trnem_delka+trn_delka)/2,0])rotate([90,0,0])za_trnem();
        translate([0,-(hlava_delka+trn_delka)/2,0])hlava();
    }
}

module
trn()
{
    cylinder(h=trn_delka, d=trn_prumer, center=true, $fn=smooth);
}

module
za_trnem()
{
    cylinder(h=za_trnem_delka, d=za_trnem_prumer, center=true, $fn=smooth);
}

module
hlava()
{
    rotate([90,0,0])cylinder(h=hlava_delka, d=trn_prumer, center=true, $fn=smooth);
    prismoid(size1=[trn_prumer,hlava_delka], size2=[hlava_plocha,hlava_delka], h=hlava_vyska-trn_prumer/2);
}

// ------------------------------------------------------------------
/*eof*/