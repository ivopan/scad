//sof
// --------------------------------------------------------

//match case
width=36.3;
thickness=12.2;
height=53.3;

shell=1;

paper=0.4;

// left and bottom slot
slot=thickness/1.5;

// main slot
mainslotdelta=4;
mainslotw=width-mainslotdelta;
mainsloth=height-mainslotdelta;

// --------------------------------------------------------

module mainRectPlate() { union() {

    
// middle plate rectangle
translate([-mainslotw/2,thickness/2-slot/4,mainslotdelta/2+slot/2]){
    cube([mainslotw, shell*4, mainsloth-slot]);
}

// cross rectangle
translate([-mainslotw/2+slot/2,thickness/2-slot/4,mainslotdelta/2]){
    cube([mainslotw-slot, shell*4, mainsloth]);
}

// circle top left
translate([mainslotw/2-slot/2,
           thickness/2+2*shell,
           mainsloth-slot/2+mainslotdelta/2]){
    rotate(a = 90, v=[1, 0, 0]) cylinder(r=slot/2, h=shell*4);
}

// circle top right
translate([-mainslotw/2+slot/2,
           thickness/2+2*shell,
           mainsloth-slot/2+mainslotdelta/2]){
    rotate(a = 90, v=[1, 0, 0]) cylinder(r=slot/2, h=shell*4);
}

// circle bottom left
translate([mainslotw/2-slot/2,
           thickness/2+2*shell,
           slot/2+mainslotdelta/2]){
    rotate(a = 90, v=[1, 0, 0]) cylinder(r=slot/2, h=shell*4);
}

// circle bottom right
translate([-mainslotw/2+slot/2,
           thickness/2+2*shell,
           slot/2+mainslotdelta/2]){
    rotate(a = 90, v=[1, 0, 0]) cylinder(r=slot/2, h=shell*4);
}

}}

// --------------------------------------------------------

module mainRhombusPlate1() {
    resize([mainslotw,shell*4,mainsloth])
    translate([-(mainslotw*sqrt(2))/4,0,(mainslotw*sqrt(2))/4])
    rotate(a=45, v=[0,1,0])
    resize([mainslotw,shell*4,mainslotw])
    mainRectPlate();
}

module mainRhombusPlate() { union() {

mainRhombusPlate1();

}}

// --------------------------------------------------------

module leftPlate() {union() {
    
//circle1
translate([width/2.2,0,height-slot]){
rotate(a = 90, v=[0, 1, 0]) cylinder(r=slot/2, h=shell*4);
}

//circle2
translate([width/2.2,0,slot]){
rotate(a = 90, v=[0, 1, 0]) cylinder(r=slot/2, h=shell*4);
}

//rectangle
translate([width/2.2,-slot/2,slot]){
    cube([shell*4, slot, (height-slot*2)]);
}

}}

module rightPlate() {
    
    translate([-width-slot/4,0,0])leftPlate();

}

// --------------------------------------------------------

module bottomPlate() { union() {

// circle1
translate([-width*0.5+slot,0,-shell*2]){
    cylinder(r=slot/2, h=shell*4);
}

//circle2
translate([width*0.5-slot,0,-shell*2]){
    cylinder(r=slot/2, h=shell*4);
}

//rectangle
translate([-width*0.5+slot,-slot/2,-shell*2]){
    cube([width-slot*2, slot, shell*4]);
}

}}

// --------------------------------------------------------

module mainBox() { difference() {

//outside box
translate([-(width+shell*2)/2,-(thickness+shell*2)/2,0]){
    cube([width+shell*2, thickness+shell*2, height+shell]);
    }

//inside box
translate([-width/2,-thickness/2,shell]){
    cube([width, thickness, height+shell*2]);
    }

}}

// --------------------------------------------------------
// image

module image() {
    name="matchbox-pipe-template-heights-small.png";
    // name="matchbox-pipe-template-heights.png";
    
    moveby=thickness/2+2*shell;
    
    translate([-width/2,-moveby,height])
    rotate(a=90, v=[0,1,0])
    rotate(a=90, v=[1,0,0])
    resize([height,width,shell])
    surface(file=name, invert=true);
}

// --------------------------------------------------------
// cover

module openedCover() {difference(){

mainBox();
    
//mainRectPlate();
mainRhombusPlate();
leftPlate();
rightPlate();
bottomPlate();

}}

module closedCover() {difference(){

mainBox();
    
leftPlate();
rightPlate();
bottomPlate();

}}

module fullCover() {difference(){

mainBox();
    
translate([shell*3-shell/2-paper,0,0])leftPlate();
translate([-shell+paper,0,0])rightPlate();
bottomPlate();

}}

module imageCover() {union() {
    
    image();fullCover();
    
}}

// --------------------------------------------------------
// drawer

module drawer() { difference() {
    gapW = 0.2;
    gapH = 0.2;
    
    x = width-2*gapW;
    y = thickness-2*gapH;
    z = height;
    
    //outside box
    cube([x, y, z]);
    
    //inside box
    translate([shell,2*shell,shell])cube([x-2*shell, y-shell, z-2*shell]);

//inside box

}}

// --------------------------------------------------------
// main part

    
//drawer();

fullCover();

//imageCover();


// --------------------------------------------------------
// eof