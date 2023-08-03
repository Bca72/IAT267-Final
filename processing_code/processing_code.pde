import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port

//ints for states
final int START = 0;
final int HOME = 1;
final int OPTIONS = 2;
final int DEV = 3;
final int DISPENSED = 4;


int timer;

ImageButton signIn, options, options2, feedCat, schedule, register, calibrate, home;
PImage logo, signUp, topBar, dispensed;
int state, lastState;


void setup() {
    size(420,800); //smart phone size
    frameRate(60);
    state = 0;
    lastState = -1;
    timer = 0;
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
    
    calibrate = new ImageButton(35, 180, "imgs/calibrate.png");
    home = new ImageButton(35, 80, "imgs/Home.png");
    dispensed = loadImage("imgs/dispensed.png");
    dispensed.resize(400, 100);
}

void draw() {
    surface.setTitle(str(timer));
    if ( myPort.available() > 0) {  // If data is available,
        val = myPort.readStringUntil('\n');         // read it and store it in val
    } 
    background(color(255));
    //start up screen
    if(state == START) {
        background(250);
        image(logo, 10, 150);
        signIn.update();
        image(signUp, 35, 500);
    }
    //home screen
    else if(state == HOME) {
        image(topBar, 0, 0);
        options.update();
        feedCat.update();
        schedule.update();
        //resets timer
        timer = 0;
        //register.update();
    }
    //options screen
    else if(state == OPTIONS) {
        background(235);
        image(topBar, 0, 0);
        options2.update();
        home.update();
        calibrate.update();
           
    }
    //dev screen
    else if(state == DEV) {
        background(50);
        image(topBar, 0, 0);
        options.update();
           
    }
    //home screen with dispensed text
    else if (state == DISPENSED) {
        image(topBar, 0, 0);
        options.update();
        feedCat.update();
        schedule.update();
        image(dispensed, 10, 650);
        //sets a time after 5 secs back to home
        timer++;
        if(timer == 60*5) {
            state = HOME; 
        }
    }
}

void mousePressed() {
    if(state == START && signIn.mouseOver()) {
        state = HOME;
        lastState = START;
    }
    
    if(state == HOME && options.mouseOver()) {
        state = OPTIONS;
        lastState = HOME;
    }
    else if(state == OPTIONS && lastState == HOME && options2.mouseOver()) {
        state = HOME;
        lastState = OPTIONS;
    }
    
    if(state == OPTIONS && calibrate.mouseOver()) {
        state = DEV;
        lastState = OPTIONS;
    }
    
    if(state == DEV && options.mouseOver()) {
        state = OPTIONS;
        lastState = DEV;
    }
    else if(state == OPTIONS && lastState == DEV &&  options2.mouseOver()) {
        state = DEV;
        lastState = OPTIONS;
    }
    
    if(state == HOME && feedCat.mouseOver()) {
        state = DISPENSED;
        lastState = HOME;
    }
    
    
    
    
    if(state == OPTIONS && home.mouseOver()) {
        state = HOME;
        lastState = OPTIONS;
    }
}
