import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port

Button doorOpen, doorClose, dispense;



void setup() {
    size(360,800); //samrt phone size
    noStroke();
    doorOpen = new Button(width/2, 100, width, 50, "Open Door");
    doorClose = new Button(width/2, 200, width, 50, "Close Door");
    dispense = new Button(width/2, 300, width, 50, "Pour Food");
    
    // On Windows machines, this generally opens COM1.
    // Open whatever port is the one you're using.
    String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
    myPort = new Serial(this, portName, 9600);
    val = "-1";
}

void draw() {
    background(color(255));
    doorOpen.update();
    doorClose.update();
    dispense.update();
    
    if ( myPort.available() > 0) {  // If data is available,
        val = myPort.readStringUntil('\n');         // read it and store it in val
    } 
    textSize(38);
    fill(0);
    text("Distance (Cm): " + val, 150, height/4);
    
}

void mousePressed() {
    if (doorOpen.rectOver) {
        //do stuff
        //textCol = color(0);
        myPort.write('1');
    }
    else if (doorClose.rectOver) {
        //do stuff
        //textCol = color(0);
        myPort.write('2');
    }
    else if (dispense.rectOver) {
        //do stuff
        //textCol = color(0);
        myPort.write('3');
    }
    else {
        myPort.write('0');   
    }
}
