#include <Arduino.h>

#include "Wheels.h"

//
//#define SET_MOVEMENT(side,f,b) ( digitalWrite( side[0], f ) ); digitalWrite( side[1], b ) )

#define SET_MOVEMENT(side,f,b) digitalWrite( side[0], f);\
                               digitalWrite( side[1], b)
//#define HIGH 1
//#define LOW 0

//#define SET_MOVEMENT(s,f,b) delay(10);


Wheels::Wheels()  
{
  dist = 0;
  this->reset();
}

void Wheels::attachRight(int pF, int pB, int pS)
{
    pinMode(pF, OUTPUT);
    pinMode(pB, OUTPUT);
    pinMode(pS, OUTPUT);
    this->pinsRight[0] = pF;
    this->pinsRight[1] = pB;
    this->pinsRight[2] = pS;
}


void Wheels::attachLeft(int pF, int pB, int pS)
{
    pinMode(pF, OUTPUT);
    pinMode(pB, OUTPUT);
    pinMode(pS, OUTPUT);
    this->pinsLeft[0] = pF;
    this->pinsLeft[1] = pB;
    this->pinsLeft[2] = pS;
}

void Wheels::setSpeedRight(uint8_t s)
{
    analogWrite(this->pinsRight[2], s);
}

void Wheels::setSpeedLeft(uint8_t s)
{
    analogWrite(this->pinsLeft[2], s);
}

void Wheels::setSpeed(uint8_t s)
{
    this-> currentSpeed = s;
    setSpeedLeft(s);
    setSpeedRight(s);
}

void Wheels::attach(int pRF , int pRB, int pRS, int pLF, int pLB, int pLS)
{
    this->attachRight(pRF, pRB, pRS);
    this->attachLeft(pLF, pLB, pLS);
}

void Wheels::forwardLeft() 
{
    SET_MOVEMENT(pinsLeft, HIGH, LOW);
}

void Wheels::forwardRight() 
{
    SET_MOVEMENT(pinsRight, HIGH, LOW);
}

void Wheels::backLeft()
{
    SET_MOVEMENT(pinsLeft, LOW, HIGH);
}

void Wheels::backRight()
{
    SET_MOVEMENT(pinsRight, LOW, HIGH);
}

void Wheels::forward()
{
    this->forwardLeft();
    this->forwardRight();
}

void Wheels::back()
{
    this->backLeft();
    this->backRight();
}

void Wheels::stopLeft()
{
    SET_MOVEMENT(pinsLeft, LOW, LOW);
}

void Wheels::stopRight()
{
    SET_MOVEMENT(pinsRight, LOW, LOW);
}

void Wheels::turnRight(int cm)
{
    this->reset();  
    dist = calculateDelay(cm);;
 
    this ->forwardLeft();
    this -> backRight();
  
}

void Wheels::turnLeft(int cm)
{
    this->reset();  
    dist = calculateDelay(cm);;
    

    this ->forwardRight();
    this -> backLeft();
  
}

//oblicza dystans w cm 
int Wheels:: calculateDistance() {
        int count0 = this->getCnt0();  
        int count1 = this->getCnt1();
        int averageCount = (count0 + count1) / 2;

        int turnovers = averageCount / Turnover;
        int dist = turnovers * Circum;  

        return dist;
}

//oblicza o ile musze zwiekszyc licznik, czyli dystans w liczbie inpulsow
int Wheels:: calculateDelay(int cm){
  int counterDellay = (cm * Turnover)/Circum;
  return counterDellay;
}


void Wheels::goForward(int cm) {
    this->reset();  // Reset the counters
    dist = calculateDelay(cm);;
    forward();
}

bool Wheels::checkStop(){
  if(!dist){
    return false;
  }
  int avgCount = (this->getCnt0() + this->getCnt1())/2;
  if(avgCount >= dist){
      stop();
      dist = 0;
      return true;
  }
  return false;

}

void Wheels::goBack(int cm){
    this->reset();  
    dist = calculateDelay(cm);;
 
    this->back();

    
    // int avgCount = (this->getCnt0() + this->getCnt1())/2;

    // while(avgCount < dist){
    //     avgCount = (this->getCnt0() + this->getCnt1())/2;
    // }
    // this -> stop();
}

void Wheels::stop()
{
    this->stopLeft();
    this->stopRight();
}


void Wheels:: reset(){
        cnt0 = 0;
        cnt1 = 0;
    }

void Wheels:: increment0() {
    noInterrupts();
    cnt0++;
    interrupts();
}

void Wheels:: increment1() {
    noInterrupts();
    cnt1++;
    interrupts();
}

int Wheels:: getCnt0() {
    return cnt0;
}

int Wheels:: getCnt1() {
    return cnt1;
}