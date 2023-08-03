import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port


ImageButton signIn, options, options2, feedCat, schedule, register;
PImage logo, signUp, topBar;
int state;


void setup() {
    size(420,800); //smart phone size
    state = 0;
    noStroke();
    
    // On Windows machines, this generally opens COM1.
    // Open whatever port is the one you're using.
    String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
    myPort = new Serial(this, portName, 9600);
    val = "-1";
    
    
    logo = loadImage("imgs/logo.png");
    logo.resize(400, 65);
    signIn = new ImageButton(35, 380, "imgs/signIn.png");
    signUp = loadImage("imgs/signUp.png");
    
    topBar = loadImage("imgs/topBar.png");
    options = new ImageButton(width-67, 25, "imgs/more.png");
    options2 = new ImageButton(width-67, 25, "imgs/more2.png");
    feedCat = new ImageButton(35, 250, "imgs/feed.png");
    schedule = new ImageButton(35, 425, "imgs/schedule.png");
    register = new ImageButton(35, 600, "imgs/register.png");
}

void draw() {
    if ( myPort.available() > 0) {  // If data is available,
        val = myPort.readStringUntil('\n');         // read it and store it in val
    } 
    background(color(255));
    //start up screen
    if(state == 0) {
        background(250);
        image(logo, 10, 150);
        signIn.update();
        image(signUp, 35, 500);
    }
    //home screen
    else if(state == 1) {
        image(topBar, 0, 0);
        options.update();
        feedCat.update();
        schedule.update();
        //register.update();
    }
    else if(state == 2) {
        background(235);
        image(topBar, 0, 0);
        options2.update();
        
           
    }
    else if(state == 3) {
        image(topBar, 0, 0);
        options2.update();
           
    }
    
}

void mousePressed() {
    if(state == 0 && signIn.mouseOver()) {
        state = 1;
    }
    if(state == 1 && options.mouseOver()) {
        state = 2;
    }
    else if(state == 2 && options2.mouseOver()) {
        state = 1;
    }
}
