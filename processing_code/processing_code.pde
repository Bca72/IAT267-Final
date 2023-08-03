import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port

//ints for states
final int START = 0;
final int HOME = 1;
final int OPTIONS = 2;
final int DEV = 3;
final int DISPENSED = 4;
final int SCHEDULE = 5;

boolean isActive = true;
boolean startTimer = false;
boolean send1 = false;
int timer, timer2, until;

ImageButton signIn, options, options2, feedCat, schedule, register, calibrate, home;
ImageButton upHour, downHour, upMin, downMin, confirmSchedule;
PImage logo, signUp, topBar, dispensed, colon;
PImage hour0, hour1, hour2, hour3, hour4, hour5, hour6, hour7, hour8, hour9;
int state, lastState;
int hour, min;


void setup() {
    size(420,800); //smart phone size
    frameRate(30);
    state = 0;
    lastState = -1;
    timer = 0;
    timer2 = 0;
    until = 10;
    noStroke();
    
    // On Windows machines, this generally opens COM1.
    // Open whatever port is the one you're using.
    String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
    myPort = new Serial(this, portName, 9600);
    
    val = "-1";
    hour = 0;
    min = 0;
    
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
    
    upHour = new ImageButton(5, 250, "imgs/up.png");
    downHour = new ImageButton(5, 400, "imgs/down.png");
    upMin = new ImageButton(210, 250, "imgs/up.png");
    downMin = new ImageButton(210, 400, "imgs/down.png");
    confirmSchedule = new ImageButton(10, 500, "imgs/sd.png");
    
    hour0 = loadImage("imgs/0.png");
    hour1 = loadImage("imgs/1.png");
    hour2 = loadImage("imgs/2.png");
    hour3 = loadImage("imgs/3.png");
    hour4 = loadImage("imgs/4.png");
    hour5 = loadImage("imgs/5.png");
    hour6 = loadImage("imgs/6.png");
    hour7 = loadImage("imgs/7.png");
    hour8 = loadImage("imgs/8.png");
    hour9 = loadImage("imgs/9.png");
    colon = loadImage("imgs/colon.png");
    
}

void draw() {
    surface.setTitle(str(timer) + ", " + str(timer2) + ", " + str(frameRate));
    
    if(startTimer){
        timer2++;
        if(timer2 == 30) {
            until--;
            println("feeding in " + str(until));
            timer2 = 0;
        }
        if(until == 0) {
            send1 = true;
            isActive = true;
            state = DISPENSED;
            startTimer = false;
            until = 10;
        }
    }
    
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
    else if(state == DISPENSED) {
        image(topBar, 0, 0);
        options.update();
        feedCat.update();
        schedule.update();
        image(dispensed, 10, 650);
        //sets a time after 5 secs back to home
        timer++;
        if(timer == 30*5) {
            state = HOME; 
        }
    }
    //schedule dispense screen
    else if(state == SCHEDULE) {
        image(topBar, 0, 0);
        options.update();   
        upHour.update();
        downHour.update();
        upMin.update();
        downMin.update();
        confirmSchedule.update();
        image(colon, 200, 270);
        switch(hour) {
            case 0:
                image(hour0, 10, 275);
                image(hour0, 100, 275);
                break;
            case 1:
                image(hour0, 10, 275);
                image(hour1, 100, 275);
                break;
            case 2:
                image(hour0, 10, 275);
                image(hour2, 100, 275);
                break;
            case 3:
                image(hour0, 10, 275);
                image(hour3, 100, 275);
                break;
            case 4:
                image(hour0, 10, 275);
                image(hour4, 100, 275);
                break;
            case 5:
                image(hour0, 10, 275);
                image(hour5, 100, 275);
                break;
            case 6:
                image(hour0, 10, 275);
                image(hour6, 100, 275);
                break;
            case 7:
                image(hour0, 10, 275);
                image(hour7, 100, 275);
                break;
            case 8:
                image(hour0, 10, 275);
                image(hour8, 100, 275);
                break;
            case 9:
                image(hour0, 10, 275);
                image(hour9, 100, 275);
                break;
            case 10:
                image(hour1, 10, 275);
                image(hour0, 100, 275);
                break;
            case 11:
                image(hour1, 10, 275);
                image(hour1, 100, 275);
                break;
            case 12:
                image(hour1, 10, 275);
                image(hour2, 100, 275);
                break;
            case 13:
                image(hour1, 10, 275);
                image(hour3, 100, 275);
                break;
            case 14:
                image(hour1, 10, 275);
                image(hour4, 100, 275);
                break;
            case 15:
                image(hour1, 10, 275);
                image(hour5, 100, 275);
                break;
            case 16:
                image(hour1, 10, 275);
                image(hour6, 100, 275);
                break;
            case 17:
                image(hour1, 10, 275);
                image(hour7, 100, 275);
                break;
            case 18:
                image(hour1, 10, 275);
                image(hour8, 100, 275);
                break;
            case 19:
                image(hour1, 10, 275);
                image(hour9, 100, 275);
                break;
            case 20:
                image(hour2, 10, 275);
                image(hour0, 100, 275);
                break;
            case 21:
                image(hour2, 10, 275);
                image(hour1, 100, 275);
                break;
            case 22:
                image(hour2, 10, 275);
                image(hour2, 100, 275);
                break;
            case 23:
                image(hour2, 10, 275);
                image(hour3, 100, 275);
                break;
        }
        
        switch(min) {
            case 0:
                image(hour0, 225, 275);
                image(hour0, 315, 275);
                break;
            case 1:
                image(hour0, 225, 275);
                image(hour1, 315, 275);
                break;
            case 2:
                image(hour0, 225, 275);
                image(hour2, 315, 275);
                break;
            case 3:
                image(hour0, 225, 275);
                image(hour3, 315, 275);
                break;
            case 4:
                image(hour0, 225, 275);
                image(hour4, 315, 275);
                break;
            case 5:
                image(hour0, 225, 275);
                image(hour5, 315, 275);
                break;
            case 6:
                image(hour0, 225, 275);
                image(hour6, 315, 275);
                break;
            case 7:
                image(hour0, 225, 275);
                image(hour7, 315, 275);
                break;
            case 8:
                image(hour0, 225, 275);
                image(hour8, 315, 275);
                break;
            case 9:
                image(hour0, 225, 275);
                image(hour9, 315, 275);
                break;
            case 10:
                image(hour1, 225, 275);
                image(hour0, 315, 275);
                break;
            case 11:
                image(hour1, 225, 275);
                image(hour1, 315, 275);
                break;
            case 12:
                image(hour1, 225, 275);
                image(hour2, 315, 275);
                break;
            case 13:
                image(hour1, 225, 275);
                image(hour3, 315, 275);
                break;
            case 14:
                image(hour1, 225, 275);
                image(hour4, 315, 275);
                break;
            case 15:
                image(hour1, 225, 275);
                image(hour5, 315, 275);
                break;
            case 16:
                image(hour1, 225, 275);
                image(hour6, 315, 275);
                break;
            case 17:
                image(hour1, 225, 275);
                image(hour7, 315, 275);
                break;
            case 18:
                image(hour1, 225, 275);
                image(hour8, 315, 275);
                break;
            case 19:
                image(hour1, 225, 275);
                image(hour9, 315, 275);
                break;
            case 20:
                image(hour2, 225, 275);
                image(hour0, 315, 275);
                break;
            case 21:
                image(hour2, 225, 275);
                image(hour1, 315, 275);
                break;
            case 22:
                image(hour2, 225, 275);
                image(hour2, 315, 275);
                break;
            case 23:
                image(hour2, 225, 275);
                image(hour3, 315, 275);
                break;
            case 24:
                image(hour2, 225, 275);
                image(hour4, 315, 275);
                break;
            case 25:
                image(hour2, 225, 275);
                image(hour5, 315, 275);
                break;
            case 26:
                image(hour2, 225, 275);
                image(hour6, 315, 275);
                break;
            case 27:
                image(hour2, 225, 275);
                image(hour7, 315, 275);
                break;
            case 28:
                image(hour2, 225, 275);
                image(hour8, 315, 275);
                break;
            case 29:
                image(hour2, 225, 275);
                image(hour9, 315, 275);
                break;
            case 30:
                image(hour3, 225, 275);
                image(hour0, 315, 275);
                break;
            case 31:
                image(hour3, 225, 275);
                image(hour1, 315, 275);
                break;
            case 32:
                image(hour3, 225, 275);
                image(hour2, 315, 275);
                break;
            case 33:
                image(hour3, 225, 275);
                image(hour3, 315, 275);
                break;
            case 34:
                image(hour3, 225, 275);
                image(hour4, 315, 275);
                break;
            case 35:
                image(hour3, 225, 275);
                image(hour5, 315, 275);
                break;
            case 36:
                image(hour4, 225, 275);
                image(hour6, 315, 275);
                break;
            case 37:
                image(hour3, 225, 275);
                image(hour7, 315, 275);
                break;
            case 38:
                image(hour3, 225, 275);
                image(hour8, 315, 275);
                break;
            case 39:
                image(hour3, 225, 275);
                image(hour9, 315, 275);
                break;
            case 40:
                image(hour4, 225, 275);
                image(hour0, 315, 275);
                break;
            case 41:
                image(hour4, 225, 275);
                image(hour1, 315, 275);
                break;
            case 42:
                image(hour4, 225, 275);
                image(hour2, 315, 275);
                break;
            case 43:
                image(hour4, 225, 275);
                image(hour3, 315, 275);
                break;
            case 44:
                image(hour4, 225, 275);
                image(hour4, 315, 275);
                break;
            case 45:
                image(hour4, 225, 275);
                image(hour5, 315, 275);
                break;
            case 46:
                image(hour4, 225, 275);
                image(hour6, 315, 275);
                break;
            case 47:
                image(hour4, 225, 275);
                image(hour7, 315, 275);
                break;
            case 48:
                image(hour4, 225, 275);
                image(hour8, 315, 275);
                break;
            case 49:
                image(hour4, 225, 275);
                image(hour9, 315, 275);
                break;
            case 50:
                image(hour5, 225, 275);
                image(hour0, 315, 275);
                break;
            case 51:
                image(hour5, 225, 275);
                image(hour1, 315, 275);
                break;
            case 52:
                image(hour5, 225, 275);
                image(hour2, 315, 275);
                break;
            case 53:
                image(hour5, 225, 275);
                image(hour3, 315, 275);
                break;
            case 54:
                image(hour5, 225, 275);
                image(hour4, 315, 275);
                break;
            case 55:
                image(hour5, 225, 275);
                image(hour5, 315, 275);
                break;
            case 56:
                image(hour5, 225, 275);
                image(hour6, 315, 275);
                break;
            case 57:
                image(hour5, 225, 275);
                image(hour7, 315, 275);
                break;
            case 58:
                image(hour5, 225, 275);
                image(hour8, 315, 275);
                break;
            case 59:
                image(hour5, 225, 275);
                image(hour9, 315, 275);
                break;
        }
    }
    
    
    if(send1 == true) {
        myPort.write('1');
        send1 = false;
    }
    else if (send1 == false){
        myPort.write('0');   
    }
}

void mousePressed() {
    
    if(isActive) {
    
        if(state == START && signIn.mouseOver()) {
            state = HOME;
            lastState = START;
        }
        else if(state == HOME && schedule.mouseOver()) {//pressed schedule
            state = SCHEDULE;
            lastState = HOME; 
        }
        else if(confirmSchedule.mouseOver()) {
            println("feeding in " + str(until));
            isActive = false;
            startTimer = true;
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
    
        if(state == HOME && feedCat.mouseOver()) {//pressed dispense
            state = DISPENSED;
            lastState = HOME;        
            send1 = true;
        }
    
    
    
        if(state == SCHEDULE && options.mouseOver()) {
            state = OPTIONS;
            lastState = SCHEDULE;
        }
        else if(state == OPTIONS && lastState == SCHEDULE &&  options2.mouseOver()) {
            state = SCHEDULE;
            lastState = OPTIONS;
        }
    
        if(state == SCHEDULE && upHour.mouseOver()) { 
            if(hour != 23){hour++;}
            else {hour = 0;}
        }
        else if(state == SCHEDULE && downHour.mouseOver()) { 
            if(hour != 0){hour--;}
            else {hour = 23;}
        }
        else if(state == SCHEDULE && upMin.mouseOver()) { 
            if(min != 59){min++;}
            else {min = 0;}
        }
        else if(state == SCHEDULE && downMin.mouseOver()) { 
            if(min != 0){min--;}
            else {min = 59;}
        }
    
    
    
        if(state == OPTIONS && home.mouseOver()) {
            state = HOME;
            lastState = OPTIONS;
        }
    }
}
