// sof
// ------------------------------------------------------------------
//
// Autor: Ivo Panáček, December 2021
// ivo.panacek@gmail.com
// Version: 0
//
// ------------------------------------------------------------------
//
// motor MG996R
//
// ------------------------------------------------------------------

// dreh=$t*360;
$fn=1000;

// ------------------------------------------------------------------
// main program

motor();

// ------------------------------------------------------------------
// moduly

module motor() {
    color([0.6,0,0.2])
    import("Servo_Motor.stl");
}


// ------------------------------------------------------------------
// eof