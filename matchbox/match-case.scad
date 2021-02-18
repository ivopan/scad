//sof
// --------------------------------------------------------

//match case
width=36.3;
thickness=13;
height=53.3;

shellTop=1;
shellSide=2;
shellLast=1;

shellImage=1;

shellDrawer=1;
shellSure=2;

paper=0.6;

// left and bottom slot
slot=thickness/1.5;

// main slot
mainslotdelta=4;
mainslotw=width+shellSide-mainslotdelta;
mainsloth=height+shellLast-mainslotdelta;

// drawer
gapW = 0.4;
gapH = 0.2;
gapClip = 0.05;
biggerGapClip = 0.01;
 
// --------------------------------------------------------

module mainRectPlate() { union() {
   
    // middle plate rectangle
    translate([-mainslotw/2,thickness/2-slot/4,mainslotdelta/2+slot/2]){
        cube([mainslotw, shellSure*4, mainsloth-slot]);
    }

    // cross rectangle
    translate([-mainslotw/2+slot/2,thickness/2-slot/4,mainslotdelta/2]){
        cube([mainslotw-slot, shellSure*4, mainsloth]);
    }

    // circle top left
    translate([mainslotw/2-slot/2,
            thickness/2+2*shellSure,
            mainsloth-slot/2+mainslotdelta/2]){
        rotate(a = 90, v=[1, 0, 0]) cylinder(r=slot/2, h=shellSure*4);
    }

    // circle top right
    translate([-mainslotw/2+slot/2,
            thickness/2+2*shellSure,
            mainsloth-slot/2+mainslotdelta/2]){
        rotate(a = 90, v=[1, 0, 0]) cylinder(r=slot/2, h=shellSure*4);
    }

    // circle bottom left
    translate([mainslotw/2-slot/2,
            thickness/2+2*shellSure,
            slot/2+mainslotdelta/2]){
        rotate(a = 90, v=[1, 0, 0]) cylinder(r=slot/2, h=shellSure*4);
    }

    // circle bottom right
    translate([-mainslotw/2+slot/2,
            thickness/2+2*shellSure,
            slot/2+mainslotdelta/2]){
        rotate(a = 90, v=[1, 0, 0]) cylinder(r=slot/2, h=shellSure*4);
    }

}}

// --------------------------------------------------------

module mainRhombusPlate1() {
    resize([mainslotw,shellSure*4,mainsloth])
    translate([-(mainslotw*sqrt(2))/4,0,(mainslotw*sqrt(2))/4])
    rotate(a=45, v=[0,1,0])
    resize([mainslotw,shellSure*4,mainslotw])
    mainRectPlate();
}

module mainRhombusPlate() { union() {

    mainRhombusPlate1();

}}

// --------------------------------------------------------

module leftRoundPlate() {union() {
    
    //circle1
    translate([width/2,0,height+shellLast-slot]){
    rotate(a = 90, v=[0, 1, 0]) cylinder(r=slot/2, h=shellSide*4);
    }

    //circle2
    translate([width/2,0,slot]){
    rotate(a = 90, v=[0, 1, 0]) cylinder(r=slot/2, h=shellSide*4);
    }

    //rectangle
    translate([width/2,-slot/2,slot]){
        cube([shellSide*4, slot, (height+shellLast-slot*2)]);
    }

}}

module rightRoundPlate() {
    
    translate([-width-slot/4,0,0])leftRoundPlate();

}

module leftSquarePlate() {union() {
    
    //rectangle
    translate([width/2,-slot/2,slot]){
        cube([shellSide*2, slot, (height+shellLast-slot*2)]);
    }

}}


module rightSquarePlate() {
    
    translate([-width-shellSide,0,0])
    leftSquarePlate();

}

// --------------------------------------------------------

module bottomPlate() { union() {

    // circle1
    translate([-width*0.5+slot,0,-shellSure*2]){
        cylinder(r=slot/2, h=shellSure*4);
    }

    //circle2
    translate([width*0.5-slot,0,-shellSure*2]){
        cylinder(r=slot/2, h=shellSure*4);
    }

    //rectangle
    translate([-width*0.5+slot,-slot/2,-shellSure*2]){
        cube([width-slot*2, slot, shellSure*4]);
    }

}}

// --------------------------------------------------------

module mainBox() { difference() {

    //outside box
    translate([-(width+shellSide*2)/2,-(thickness+shellTop*2)/2,0]){
        cube([width+shellSide*2, thickness+shellTop*2, height+shellLast]);
        }

    //inside box
    translate([-width/2,-thickness/2,shellLast]){
        cube([width, thickness, height+shellLast*2]);
        }

}}

// --------------------------------------------------------
// image

module image() {
    // name="matchbox-pipe-template-heights.png";
    // name="matchbox-pipe-template-heights-small.png";
    name="pipe-plate-1.png";
    
    w=width+2*shellSide;
    h=height+shellLast;

    moveby=thickness/2+2*shellImage;
    
    translate([w/2,-moveby,0])
    rotate(a=-90, v=[0,1,0])
    rotate(a=90, v=[1,0,0])
    resize([h,w,shellImage])
    surface(file=name, invert=true);
}

// --------------------------------------------------------
// cover

module openedRectCover() {difference(){

    mainBox();
        
    mainRectPlate();
    leftRoundPlate();
    rightRoundPlate();
    bottomPlate();

}}

module openedRoundCover() {difference(){

    mainBox();
        
    mainRhombusPlate();
    leftRoundPlate();
    rightRoundPlate();
    bottomPlate();

}}

module closedCover() {difference(){

    mainBox();
        
    leftRoundPlate();
    rightRoundPlate();
    bottomPlate();

}}

module fullCover() {difference(){

    mainBox();
        
    translate([shellSide-paper,0,0])leftSquarePlate();
    translate([-2*shellSide+paper,0,0])rightSquarePlate();
    bottomPlate();

}}

module imageCover() {union() {
    
    image();
    
    fullCover();
    
}}

// --------------------------------------------------------
// drawer

module drawer() { difference() {
    
    x = width-2*gapW;
    y = thickness-2*gapH;
    z = height;

    x1 = width-2*gapClip;
    //y1 = thickness-2*gapH;
    z1 = 6*shellDrawer;

    x2 = width-2*biggerGapClip;

    union() {

        //outside box
        translate([gapW,0,0])
        cube([x, y, z]);

        // original handle
        // translate([gapClip,0,0])
        // cube([x1, y, z1]);

        // bigger handle
        translate([biggerGapClip,0,0])
        cube([x2, y, z1]);
    }
    
    //inside box
    
    translate([shellDrawer+gapW,2*shellDrawer,shellDrawer])
    cube([x-2*shellDrawer, y-shellDrawer, z-2*shellDrawer]);
    
}}


// --------------------------------------------------------
// main part



drawer();

//fullCover();

// imageCover();


/*
openedRectCover();
openedRoundCover();

union(){
    rightRoundPlate();
    leftSquarePlate();
}
*/
// --------------------------------------------------------
// eof