#include <NewPing.h>
#include <Servo.h>

// servo pins
const int LEFT_DOOR_PIN = 6;
const int RIGHT_DOOR_PIN = 9;
const int DISPENSER_PIN = 3;

// HC-SR04 sensor pins
const int TRIGGER_PIN = 11;
const int ECHO_PIN = 12;

// servos
Servo leftDoorServo;
Servo rightDoorServo;
Servo dispenserServo;

// distance for sensor detection
const int MAX_DISTANCE = 30;

// NewPing instance
NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE);

// flap door initial variables
bool flapDoorsAreOpen = false;

// other
const unsigned long interval = 5000;
unsigned long previousMillis = 0;

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

  // Get the current time
  unsigned long currentMillis = millis();

  // Check if the specified interval has elapsed
  if (currentMillis - previousMillis >= interval) {

    openFlapDoors();
    delay(1500);
    dispenseFood();
    delay(2000);
    closeFlapDoors();

    // Update the previousMillis variable
    previousMillis = currentMillis;
  }

  // get distance measurement in centimeters
  unsigned int distance = sonar.ping_cm();

  // Serial.println(distance);

  // // check if cat is near food bowl
  if (catDetected(distance)) {

    if(!flapDoorsAreOpen) {
      Serial.println("Opening");
      openFlapDoors();
      flapDoorsAreOpen = true;
    }
    
  } else {

    if(flapDoorsAreOpen) {
      Serial.println("Closing");
      closeFlapDoors();
      flapDoorsAreOpen = false;
    }

  }

  // short delay before looping 
  delay(1000);
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
  delay(300);
  closeDispenserDoor();
}