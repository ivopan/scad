// sof
// ------------------------------------------------------------------
//
// Autor: Ivo Panáček, January 2021
// ivo.panacek@gmail.com
// Version: 0
//
// ------------------------------------------------------------------
// parameters

batteryHeight = 46;

batteryWidth = 26.3;
batteryThickness = 15.6;

batteryTopDelta = -8;

batteryPinRadius = 4;
batteryPinDistance = 14;
batteryPinHeight = 2.2;

clipStartDelta = -2;
clipWidth = 8;
clipBase = 4;
clipTop = 2;
clipRadius = 2;
clipDistance = 8;

wallThickness = 2;
rimHeight = 2;

bottomThickness = 3;
bottomPaddingX = 6;
bottomPaddingY = 2;

dreh=$t*360;
$fn=100;

// ------------------------------------------------------------------
// main program

realBatteryInSpace();

fullHolder();

// ------------------------------------------------------------------
// modules

module fullHolder() {
    bottom();
    translate([bottomPaddingX,bottomPaddingY,bottomThickness])
    union() {
        batteryBase();
        batteryClips();
    }
}


module batteryClips() {
    size = 2*clipWidth+clipDistance;
    margin = (batteryHeight-size)/2;
    color([0,1,1])
    translate([margin+wallThickness,wallThickness,0])
    union() {
        batterySideClips();
        translate([size,batteryWidth,0])
        rotate([0,0,180])
        batterySideClips();
    }
}

module batterySideClips() {
    union() {
        batteryClip();
        translate([clipWidth+clipDistance,0,0])
        batteryClip();
    }
}

module batteryClip() {
    d = 2*clipRadius;
    h = batteryThickness + d + clipStartDelta;
    x = clipWidth;
    y = clipTop;
    z = h;
    y0 = clipTop-clipBase;

    points = [
        [ 0, y0, 0], // 0
        [ x, y0, 0], // 1
        [ x, y, 0], // 2
        [ 0, y, 0], // 3
        [ 0, 0, z], // 4
        [ x, 0, z], // 5
        [ x, y, z], // 6
        [ 0, y, z] // 7
    ];

    faces = [
        [0,1,2,3],  // bottom
        [4,5,1,0],  // front
        [7,6,5,4],  // top
        [5,6,2,1],  // right
        [6,7,3,2],  // back
        [7,4,0,3] // left
    ];

    //translate([0,-clipTop,0])
    union() {
        // cube([x,y,z]);
        translate([0,-clipTop,0])
        polyhedron( points, faces );

        translate([0,0,h-clipRadius])
        difference() {
            rotate([0,90,0])
            cylinder(r=clipRadius,h=clipWidth);
            translate([-clipWidth,-d,-d])
            cube([3*clipWidth,d,2*d]);
        }
    }
}

module batteryBase() {
    union() {
        batteryBottom();
        batteryTop();
        batteryRim();
    }
}

module batteryRim() {
    color([0,0,1])
    translate([wallThickness,0,0])
    difference() {
        cube([batteryHeight,batteryWidth+2*wallThickness,rimHeight]);
        translate([-rimHeight,wallThickness,-rimHeight])
        cube([batteryHeight+2*rimHeight, batteryWidth, 3*rimHeight]);
    }
}

module batteryPins() {
    d = 2*batteryPinRadius;
    left = batteryWidth-batteryPinDistance-d;
    margin = left / 2;
    color([1,0,1])
    translate([-wallThickness,wallThickness,batteryThickness/2])
    union() {
        translate([0, margin+batteryPinRadius, 0])
        batteryPin();
        translate([0, margin+batteryPinRadius+batteryPinDistance, 0])
        batteryPin();        
        batteryPinBridge();
    }
}

module batteryPinBridge() {
    union() {
        translate([ 0, batteryPinRadius+wallThickness, -batteryPinRadius])
        cube([3*wallThickness, batteryPinDistance, batteryThickness]);
    }
}

module batteryPin() {
    x = 3*wallThickness;
    union() {
        rotate([0,90,0])
        cylinder(r = batteryPinRadius, h = x);
        translate([0,-batteryPinRadius,0])
        cube([x, 2*batteryPinRadius, batteryThickness]);
    }
}

module batteryTop() {
    color([1,1,0])
    translate([wallThickness+batteryHeight, 0, 0])
    difference() {
        cube([wallThickness, batteryWidth + 2*wallThickness, batteryThickness+batteryTopDelta]);
        batteryPins();
    }
}

module batteryBottom() {
    color([1,1,0])
    cube([wallThickness, batteryWidth + 2*wallThickness, batteryThickness+2*clipRadius+clipStartDelta]);
}

module bottom(){
  x = 2*bottomPaddingX + batteryHeight + 2*wallThickness;
  y = 2*bottomPaddingY + batteryWidth + 2*wallThickness;
  z = bottomThickness;
  color([1,0,0]) cube([x,y,z]);
}

// ---------------------------------------
// just to see battery

module realBatteryInSpace() {
    translate([wallThickness+bottomPaddingX,wallThickness+bottomPaddingY,bottomThickness])
    realBattery();
}

module realBattery() {
    color([0,1,0])
    union() {
        cube([batteryHeight, batteryWidth, batteryThickness]);
        translate([batteryHeight,0,0])
        realBatteryPins();
    }
}

module realBatteryPins() {
    d = 2*batteryPinRadius;
    left = batteryWidth-batteryPinDistance-d;
    margin = left / 2;
    translate([0,0,batteryThickness/2])
    union() {
        translate([0, margin+batteryPinRadius, 0])
        realBatteryPin();
        translate([0, margin+batteryPinRadius+batteryPinDistance, 0])
        realBatteryPin();
    }
}

module realBatteryPin() {
    rotate([0,90,0])
    cylinder(r = batteryPinRadius, h = batteryPinHeight);
}



// ------------------------------------------------------------------
// eof