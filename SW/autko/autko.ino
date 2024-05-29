#include "Wheels.h"
#include "lcd_controler.hpp"
#include "PinChangeInterrupt.h"
#include <Servo.h>
#include <IRremote.hpp>

//Interrupts
#define INTINPUT0 A0
#define INTINPUT1 A1

#define RF 10 // zielony
#define RB 4  // niebieski
#define RS 6  // żółty
#define LF 8  // szary
#define LB 7  // czerwony
#define LS 5  // biały

//Pilot
#define IR_RECEIVE_PIN 2

//LCD
// SDA - A4
// SCL - A5

//Sonar
#define TRIG A2
#define ECHO A3
#define SERVO 3  //mozna tez probowac 12

#define TurnCm 15  //stala do wyznaczenia 
#define TurnDegree 90

#define StopDist 10

byte LCDAddress = 0x27;


LiquidCrystal_I2C lcd(LCDAddress, 16, 2);

Wheels w;
Servo servo;
LcdControler lcd_controler(&lcd);


Mode currentMode = Mode::MANUAL;
State currentState = State::STOP;
State lastState = State::STOP;

//Servo 
int getDistance() {
          
  unsigned long tot = 0;      // czas powrotu (time-of-travel)
  unsigned int distance;
  
  digitalWrite(TRIG, HIGH);
  delay(10);
  digitalWrite(TRIG, LOW);
  tot += pulseIn(ECHO, HIGH);
  
  Serial.print("TOT ");
  Serial.println(tot);
  distance = tot/(58);
  Serial.print("Dist");
  Serial.println(distance);

  return distance;
}


int getAvgDistance(byte angle) {
          
  unsigned long tot = 0;      // czas powrotu (time-of-travel)
  unsigned int distance;

  servo.write(angle);
  
  for(int i = 0; i < 3; i++){
    digitalWrite(TRIG, HIGH);
    delay(10);
    digitalWrite(TRIG, LOW);
    tot += pulseIn(ECHO, HIGH);
    delay(10);
  }
  distance = tot/(58*3);

  return distance;
}

State makeDecision(){
  int distance1 = getAvgDistance(90 - TurnDegree); //lewo
  delay(500);
  int distance2 = getAvgDistance(90 + TurnDegree); //prawo

  if(distance1 > distance2){
      return State::LEFT;
  }else{
      return State::RIGHT;
  }
}

// Wheels
void setSpeed(int speed){
  w.setSpeed(speed);
  lcd_controler.printSpeed(Wheel::LEFT,speed);
  lcd_controler.printSpeed(Wheel::RIGHT,speed);
          
}

void forward(){
  w.forward();
  lcd_controler.printState(State::FORWARD);
}

void back(){
  w.back();
  lcd_controler.printState(State::BACKWARD);
}

void left(){
  w.turnLeft(TurnCm);
  lcd_controler.printState(State::LEFT);
}

void right(){
  w.turnRight(TurnCm);
  lcd_controler.printState(State::RIGHT);
}


//IR controller 
void handleManual() {
    w.checkStop();
    if (IrReceiver.decode()) {

      switch(IrReceiver.decodedIRData.command) {
        case 0x45:
          setSpeed(100);
          break;
        
        case 0x46:
          setSpeed(150);
          break;
        
        case 0x47:
          setSpeed(200);
          break;
        
        case 0x18:
          forward();
          break;
        
        case 0x5a:
          right();
          break;
        
        case 0x52:
          back();
          break;
        
        case 0x8:
          left();
          break;

        case 0x1C:
          w.stop();
          lcd_controler.printState(State::STOP);
          break;

        case 0x43: //przycisk numer 6
          //zmiana kontrolera 
          w.stop();
          lcd_controler.printMode(Mode::AUTO);
          currentMode = Mode::AUTO;
          currentState = State::INIT;
          break;

      }
      IrReceiver.resume(); 
    }
  }

  void handleAuto(){
    if (IrReceiver.decode()) {
      switch(IrReceiver.decodedIRData.command) {
        case 0x40: //przycisk numer 5
          w.stop();
          lcd_controler.printMode(Mode::MANUAL);
          currentMode = Mode::MANUAL; 
          currentState = State::STOP;
          servo.write(90);
          break;
      
        case 0x45:
          setSpeed(100);
          break;
        
        case 0x46:
          setSpeed(150);
          break;
        
        case 0x47:
          setSpeed(200);
          break;  
      }

      IrReceiver.resume(); 
    }
  }



void autoMode(){
  handleAuto();
  int distance;

  if(currentState != lastState)
    lcd_controler.printState(currentState);
  
    lastState = currentState;

    if(currentState == State::INIT) {
      servo.write(90);
      delay(1000);
      distance = getDistance();
      Serial.println(distance);
      if(distance < StopDist)
          currentState = State::SCAN;
      else
          currentState = State::FORWARD;
    }
    else if(currentState == State::FORWARD) {
      w.forward();
      distance = getDistance();
      if(distance < StopDist){
          w.stop();
          currentState = State::SCAN;
      }
    }
    else if(currentState == State::SCAN) {
      State newDirection = makeDecision(); 
      w.dist = 0;
      if(newDirection == State::LEFT){
          currentState = State::LEFT;
      }else{
          currentState = State::RIGHT;
      }        
    }
    else if(currentState == State::RIGHT) {
      if(w.dist == 0){
          right();
      }
      if(w.checkStop())
          currentState = State::INIT;
    }
    else if(currentState == State::LEFT) {
      if(w.dist == 0){
          left();
      }
      if(w.checkStop())
          currentState = State::INIT;
    }

}


void setup() {
  
  lcd.init();
  lcd.backlight();
  
  IrReceiver.begin(IR_RECEIVE_PIN, ENABLE_LED_FEEDBACK); 


  w.attach(RB, RF, RS, LB, LF, LS); //zamienione miejscami
  
  pinMode(TRIG, OUTPUT);
  pinMode(ECHO, INPUT);

  pinMode(INTINPUT0, INPUT);
  pinMode(INTINPUT1, INPUT);
 
  Serial.begin(9600);

  attachPCINT(digitalPinToPCINT(INTINPUT0), []() { w.increment0(); }, CHANGE);
  attachPCINT(digitalPinToPCINT(INTINPUT1), []() { w.increment1(); }, CHANGE);
 
  setSpeed(200);
  lcd_controler.printState(State::STOP);

  lcd_controler.printMode(Mode::MANUAL);
  servo.attach(SERVO);
  servo.write(90);
}

void loop() {
    
  if(currentMode == Mode::MANUAL){
    handleManual();
  }else{
    autoMode();
  }
}