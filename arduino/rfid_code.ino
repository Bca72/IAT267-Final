#include <MFRC522.h>
#include <MFRC522Extended.h>
#include <SPI.h>

//defines pins for the rfid reader
int SS_PIN = 3;
int RST_PIN = 5;

MFRC522 rfid(SS_PIN, RST_PIN);

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);   // Initiate a serial communication
  SPI.begin();      // Initiate  SPI bus
  rfid.PCD_Init();   // Initiate MFRC522

}

void loop() {
  // put your main code here, to run repeatedly:

}
