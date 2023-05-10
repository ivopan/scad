// ------------------------------------------------------------------
/*
    šroubovací krabička na pikslu jogurtu
*/
// ------------------------------------------------------------------
include <../libs/BOSL/constants.scad>
use <../libs/BOSL/metric_screws.scad>
use <../libs/BOSL/masks.scad>
// ------------------------------------------------------------------
// rozměry - nastavení

// vlastní jogurt

// Olma Klasik 2,7
//jogurt_spodni_prumer = 50;
//jogurt_horni_prumer = 70;
//jogurt_vyska = 86;

// Albert bílý NATUR
jogurt_spodni_prumer = 48;
jogurt_horni_prumer = 78;
jogurt_vyska = 90;

// výsledný cylindr
tloustka_steny = 5;
vyska_sroubovice = 20;
sroubovice_od_horniho_dilu = 1;

// ------------------------------------------------------------------
// rozměry - konstanty

vyska_zavitu = 4;

tloustka_cisteho_zavitu = 4; // zmerena konstanta

// ------------------------------------------------------------------
// rozměry - výpočty

jogurt_prumer = max(jogurt_spodni_prumer,jogurt_horni_prumer);
//echo("jogurt_prumer:", jogurt_prumer);

valec_prumer = jogurt_prumer + 2*tloustka_steny;
valec_vyska = jogurt_vyska + 2*tloustka_steny;

zavit_prumer = valec_prumer - 4;

zavit_volnost = 1;

echo("----------------------------------------------------");
echo("valec_prumer=",valec_prumer);
echo("zavit_prumer=",zavit_prumer);
echo("----------------------------------------------------");

// ------------------------------------------------------------------
// konstanty

//smooth = 64; // pro ladění
smooth = 256; // pro reálný tisk

// ------------------------------------------------------------------

//translate([0,0,valec_vyska-tloustka_steny/2])rotate([180,0,0])
//color("red",0.6)
horni_dil();

//color("green",0.6)
//spodni_dil();

//spodni_valec_se_sroubem();
//spodni_dil_test();

//translate([valec_prumer+5,0,0]) horni_dil();

//zaklopka();
//translate([0,0,vyska_sroubovice])zaklopka();
//horni_sroub();
//horni_matice();
//orez_cylinder();
//orez_vrstva();

//matice();
//sroub();

// ------------------------------------------------------------------
// vrsek

module
horni_dil()
{
    translate([0,0,vyska_sroubovice+tloustka_steny/2])
    rotate([0,180,0])
    union() {
        translate([0,0,vyska_sroubovice])zaklopka();
        horni_sroub();
    }
}

module
horni_sroub()
{
    difference() {
        horni_matice();
        orez_vrstva();
    }
}

module
horni_matice()
{
    difference() {
        matice();
        orez_cylinder();
    }
}

module
zaklopka()
{
    translate([0,0,tloustka_steny/2])
    difference() {
        cylinder( 
            h = tloustka_steny, 
            r = valec_prumer/2, 
            center = true,
            $fn = smooth );
        translate([0,0,tloustka_steny/2])vyhlazeni();
    }
}

module
orez_vrstva()
{
    vyska = valec_vyska+10;
    prumer = 2*valec_prumer;
    translate([0,0,vyska_sroubovice])
    translate([0,0,vyska/2])
    cylinder( 
        h = vyska, 
        r = prumer/2, 
        center = true,
        $fn = smooth );
}
module
orez_cylinder()
{
    vyska = valec_vyska+10;
    translate([0,0,vyska/2-1])
    difference() {
        cylinder( 
            h = vyska, 
            r = valec_prumer, 
            center = true,
            $fn = smooth );
        cylinder( 
            h = vyska+2, 
            r = valec_prumer/2, 
            center = true,
            $fn = smooth );
    }
}

// ------------------------------------------------------------------
// spodek

module
spodni_dil_test()
{
    sokl = tloustka_steny;
    vyska = jogurt_vyska + tloustka_steny - vyska_sroubovice; 
    translate([0,0,-vyska+sokl])
    difference() {
        spodni_dil();
        translate([0,0,-valec_vyska/2+vyska-sokl])
        cylinder(
            h = valec_vyska, 
            r = 2*valec_prumer/2, 
            center = true,
            $fn = smooth);
    }
}

module
spodni_dil()
{
    difference() {
        spodni_valec_se_sroubem();
        translate([0,0,tloustka_steny])jogurt();
    }
}

module
spodni_valec_se_sroubem()
{
    union() {
        spodni_valec_vyhlazeny();
        translate([0,0,jogurt_vyska + tloustka_steny - sroubovice_od_horniho_dilu])
        sroub();
    }
}

module
spodni_valec_vyhlazeny()
{
    difference() {
        spodni_valec();
        rotate([0,180,0])vyhlazeni();
    }
}

module
spodni_valec()
{
    vyska = jogurt_vyska + tloustka_steny - vyska_sroubovice; 
    translate([0,0,vyska/2])
    cylinder( 
        h = vyska, 
        r = valec_prumer/2, 
        center = true,
        $fn = smooth );
}

module
vyhlazeni() {
    chamfer_cylinder_mask(
        r = valec_prumer/2,
        chamfer = 2,
        $fn = smooth);
}

// ------------------------------------------------------------------
// pomucky

module
matice()
{
    metric_nut(
        size = zavit_prumer+zavit_volnost/2, 
        hole = true, 
        pitch = vyska_zavitu,
        details = true,
        $fn = smooth );
}

module
sroub()
{
    metric_bolt(
        size = zavit_prumer-zavit_volnost/2,
        l = vyska_sroubovice,
        headtype = "none",
        pitch = vyska_zavitu,
        details = true,
        $fn = smooth );
}

module
jogurt()
{
    union() {
        translate([0,0,jogurt_vyska])
        cylinder( 
            h = 1, 
            r = jogurt_horni_prumer/2, 
            center = true,
            $fn = smooth );
        translate([0,0,jogurt_vyska/2])
        cylinder( 
            h = jogurt_vyska, 
            r1 = jogurt_spodni_prumer/2, 
            r2 = jogurt_horni_prumer/2, 
            center = true,
            $fn = smooth );
    }
}

// ------------------------------------------------------------------
/*eof*/