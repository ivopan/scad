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
jogurt_spodni_prumer = 50;
jogurt_horni_prumer = 70;
jogurt_vyska = 86;

// výsledný cylindr
tloustka_steny = 5;
vyska_sroubovice = 20;

vyska_zavitu = 4;

// ------------------------------------------------------------------
// rozměry - výpočty

jogurt_prumer = max(jogurt_spodni_prumer,jogurt_horni_prumer);
//echo("jogurt_prumer:", jogurt_prumer);

valec_prumer = jogurt_prumer + 2*tloustka_steny;
valec_vyska = jogurt_vyska + 2*tloustka_steny;

zavit_prumer = valec_prumer - tloustka_steny;

// ------------------------------------------------------------------
// konstanty

//smooth = 64; // pro ladění
smooth = 256; // pro reálný tisk

// ------------------------------------------------------------------

spodni_dil();
//horni_dil();
//spodni_dil_test();

//translate([valec_prumer+5,0,0]) horni_dil();

// ------------------------------------------------------------------
// moduly

module
horni_dil()
{
    translate([0,0,vyska_sroubovice+tloustka_steny/2])
    rotate([0,180,0])
    union() {
        translate([0,0,vyska_sroubovice])zaklopka();
        difference() {
            difference() {
                matice();
                orez_cylinder();
            }
            orez_vrstva();
        }
    }
}

module
zaklopka()
{
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
    translate([0,0,vyska/2+vyska_sroubovice])
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
        difference() {
            union() {
                spodni_valec();
                translate([0,0,jogurt_vyska + tloustka_steny - 2.5])
                sroub();
            }
            translate([0,0,tloustka_steny])jogurt();
        }
        rotate([0,180,0])vyhlazeni();
    }
}

module
vyhlazeni() {
    chamfer_cylinder_mask(
        r = valec_prumer/2,
        chamfer = 2,
        $fn = smooth);
}

module
sroub()
{
    metric_bolt(
        size = zavit_prumer-1,
        l = vyska_sroubovice-1,
        headtype = "none",
        pitch = vyska_zavitu,
        details = true,
        $fn = smooth );
}

module
matice()
{
    metric_nut(
        size = zavit_prumer, 
        hole = true, 
        pitch = vyska_zavitu,
        details = true,
        $fn = smooth );
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