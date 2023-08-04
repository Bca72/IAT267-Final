#include <NewPing.h>
#include <Servo.h>
#include <SPI.h>
#include <MFRC522.h>

// RFID pins
#define SS_PIN 10
#define RST_PIN 5
MFRC522 rfid(SS_PIN, RST_PIN);
const String CAT_ID = "0c8a7a32";

// flap door servo pins
const int LEFT_DOOR_PIN = 6;
const int RIGHT_DOOR_PIN = 9;
const int DISPENSER_PIN = 3;

// HC-SR04 distance sensor pins
// const int TRIGGER_PIN = 11;
const int TRIGGER_PIN = 7;
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

//add a delay with millis
unsigned long timeNow = 0;
unsigned long timeBefore = 0;
int interval = 2000;

void setup() {

  // initialize serial communciation
  Serial.begin(9600);

  // attach pins to servos
  leftDoorServo.attach(LEFT_DOOR_PIN);
  rightDoorServo.attach(RIGHT_DOOR_PIN);
  dispenserServo.attach(DISPENSER_PIN);

  // setup nfc reader 
  SPI.begin(); // init SPI bus
  rfid.PCD_Init(); // init MFRC522

  // reset doors to closed position 
  closeFlapDoors();
}

void loop() {

  // set current time
  timeNow = millis();

  // get distance measurement in centimeters
  unsigned int distance = sonar.ping_cm();

  // read incoming processing value
  if (Serial.available() > 0) {
    incomingVal = Serial.read();
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

  // check cat ID if it is near food bowl
  // open doors if it is the correct ID
  if (catDetected(distance) && verifyTag()) {

    if(!flapDoorsAreOpen) {
      openFlapDoors();
      flapDoorsAreOpen = true;
    }
    
  } else {
    if(flapDoorsAreOpen) {
      if(timeBefore == 0) {
        timeBefore = timeNow;
      }
      if(timeNow >= timeBefore + interval) {
        closeFlapDoors();
        flapDoorsAreOpen = false;
        timeBefore = 0;
      }
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

bool verifyTag() {
  bool tagMatch = false;

  if (rfid.PICC_IsNewCardPresent()) { // new tag is available
    if (rfid.PICC_ReadCardSerial()) { // NUID has been readed
      MFRC522::PICC_Type piccType = rfid.PICC_GetType(rfid.uid.sak);

      // print NUID into string
      String id = "";
      for (int i = 0; i < rfid.uid.size; i++) {
        String hexValue = (rfid.uid.uidByte[i] < 0x10 ? "0" : "") + String(rfid.uid.uidByte[i], HEX);
        id += hexValue;
      }
      
      if(id == CAT_ID) {
        Serial.println("Matching ID.");
        tagMatch = true;
      } else {
        Serial.println("ID does not match.");
      }

      rfid.PICC_HaltA(); // halt PICC
      rfid.PCD_StopCrypto1(); // stop encryption on PCD
    }
  }

  return tagMatch;
}