import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port

Button doorOpen, doorClose, dispense;

int state;

PImage logo, signIn, signUp;

void setup() {
    size(420,800); //smart phone size
    state = 0;
    noStroke();
    doorOpen = new Button(0, 100, width, 50, "Open Door");
    doorClose = new Button(0, 200, width, 50, "Close Door");
    dispense = new Button(0, 300, width, 50, "Pour Food");
    
    // On Windows machines, this generally opens COM1.
    // Open whatever port is the one you're using.
    String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
    myPort = new Serial(this, portName, 9600);
    val = "-1";
    
    
    logo = loadImage("imgs/logo.png");
    logo.resize(400, 65);
    signIn = loadImage("imgs/signIn.png");
    signUp = loadImage("imgs/signUp.png");
}

void draw() {
    if ( myPort.available() > 0) {  // If data is available,
        val = myPort.readStringUntil('\n');         // read it and store it in val
    } 
    background(color(255));
       if(state == 0) {
           background(255);
           image(logo, 10, 150);
           image(signIn, 70, 400);
           image(signUp, 70, 500);
       }
       else if(state == 1) {
           doorOpen.update();
           doorClose.update();
           dispense.update();
       }
    
}

void mousePressed() {

}
