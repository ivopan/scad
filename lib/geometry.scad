// sof
// ------------------------------------------------------------------
//
// Autor: Ivo Panáček, February 2021
// ivo.panacek@gmail.com
// Version: 0
//
// ------------------------------------------------------------------
//
// geometry
//
// ------------------------------------------------------------------


// ------------------------------------------------------------------
// pomocný objekt = obloukem useknutý pravidelný lichoběžník

module cylinderCutTriangle( width, height, delta) {
    x = width/2;
    y = height;
    z = sqrt(x*x+y*y);
    
    r = delta*x/y;
    h = z*r/x;
    u = y-h;
    a = r*x/z;


    union() {
        difference() {
            cut = 3*r;
            polygon(points=[[0,0],[x,y],[width,0]]);
            translate([x-cut/2,a+u,0])square(size=cut);
        }
        difference() {
            cut = 3*r;
            translate([x,u,0])circle(r=r);
            translate([x-cut/2,a+u-cut,0])square(size=cut);
        }
    }
}

// ------------------------------------------------------------------
// eof