//sof
// --------------------------------------------------------
// globals

// wall thickness
thickness = 1;

// total inner height
height = 120;


// --------------------------------------------------------
// main

result();
// zasuvka(thickness,height);
//diraNaSnuru(thickness, 10, 25, height);

// --------------------------------------------------------
// result

module result() {
    union() {
        translate([ 0, -50-thickness, 0]) {
            zasuvka(thickness,height);
        }
        krytka(thickness,height);
    }
}

// --------------------------------------------------------
// parts

module zasuvka(thickness,height) {
    depth = 50;
    d = 10;
    difference() {
        simpleBox(thickness, 70, depth, height, 0, 0);
        translate([-thickness, (depth-d)/2+thickness, 0]) {
            diraNaSnuru(thickness, d, 25, height);
        }
    }
}

module diraNaSnuru(thickness, diameter, delta, height) {
    depth = 4*thickness;
    radius = diameter/2;
    height = height - delta - radius;

    union() {
        translate([0,radius,height]) {
            rotate(a=[0,90,0]){
                cylinder(h=depth,r=radius);
            }
        }
        cube([depth, diameter, height]);
    }
}

module krytka(thickness,height) {
    difference() {
        simpleBox(thickness, 130, 60, height, 1, 1);
        translate([thickness, -thickness, -thickness]) {
            cube([70, 4*thickness, height+thickness]);
        }
    }
}

// --------------------------------------------------------
// simple modules

module simpleBox(thickness, innerX, innerY, innerZ, front, back) {
    outerX = innerX + 2*thickness;
    outerY = innerY + 2*thickness;
    outerZ = innerZ + thickness;
    innerHeight = innerZ + thickness;

    difference() {

        //outside box
        cube([outerX, outerY, outerZ]);

        //inside box
        translate([thickness, thickness, -thickness]) {
            cube([innerX, innerY, innerHeight]);
        }

        if( front == 0 ) {
            translate([thickness, -2*thickness, -thickness]) {
                cube([innerX, 4*thickness, innerHeight]);
            }
        }

        if( back == 0 ) {
            translate([thickness, outerY-2*thickness, -thickness]) {
                cube([innerX, 4*thickness, innerHeight]);
            }
        }

    }
}


// --------------------------------------------------------
// eof