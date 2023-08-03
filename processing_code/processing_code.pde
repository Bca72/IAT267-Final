import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port

Button doorOpen, doorClose, dispense;

int state;

void setup() {
    size(360,800); //samrt phone size
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
}

void draw() {
    if ( myPort.available() > 0) {  // If data is available,
        val = myPort.readStringUntil('\n');         // read it and store it in val
    } 
    background(color(255));
       if(state == 0) {
           
       }
       else if(state == 1) {
           doorOpen.update();
           doorClose.update();
           dispense.update();
       }
    
}

void mousePressed() {

}
