#include <NewPing.h>
#include <Servo.h>

// servo pins
const int LEFT_DOOR_PIN = 6;
const int RIGHT_DOOR_PIN = 9;
const int DISPENSER_PIN = 3;

// HC-SR04 sensor pins
const int TRIGGER_PIN = 11;
const int ECHO_PIN = 8;

// servos
Servo leftDoorServo;
Servo rightDoorServo;
Servo dispenserServo;

// distance for sensor detection
const int MAX_DISTANCE = 15;

// NewPing instance
NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE);

// flap door initial variables
bool flapDoorsAreOpen = false;

//vars for processing input
char incomingVal; // char recieved from processing port

void setup() {

  // initialize serial communciation
  Serial.begin(9600);

  // attach pins to servos
  leftDoorServo.attach(LEFT_DOOR_PIN);
  rightDoorServo.attach(RIGHT_DOOR_PIN);
  dispenserServo.attach(DISPENSER_PIN);

  closeFlapDoors();
}

void loop() {

  // get distance measurement in centimeters
  unsigned int distance = sonar.ping_cm();

  // read incoming processing value
  if (Serial.available() > 0) {
    incomingVal = Serial.read();
    Serial.println(incomingVal);
    
    // for debugging
    if(incomingVal == '1') {
      Serial.println("Received '1' and dispensing food.");
    } else {
      Serial.println("DID NOT receive '1'.");
    }

  }

  // if processing sends a 1,
  // open the doors and dispense food then close doors
  if(incomingVal == '1') {
    openFlapDoors();
    delay(200);
    dispenseFood();
    delay(1200);
    closeFlapDoors();
  }

  // check if cat is near food bowl
  if (catDetected(distance)) {

    if(!flapDoorsAreOpen) {
      openFlapDoors();
      flapDoorsAreOpen = true;
    }
    
  } else {

    if(flapDoorsAreOpen) {
      delay(2000); // let cat leave before door closes
      closeFlapDoors();
      flapDoorsAreOpen = false;
    }

  }

  delay(100);
}

void openFlapDoors() {
  leftDoorServo.write(140);
  rightDoorServo.write(20);
}

void closeFlapDoors() {
  leftDoorServo.write(0);
  rightDoorServo.write(180);
}

void openDispenserDoor() {
  dispenserServo.write(75);
}

void closeDispenserDoor() {
  dispenserServo.write(95);
}

bool catDetected(int dist) {
  return dist != 0 && dist < MAX_DISTANCE ? true : false;
}

void dispenseFood() {
  openDispenserDoor();
  delay(200);
  closeDispenserDoor();
}