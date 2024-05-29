  #include <Arduino.h>

  #ifndef Wheels_h
  #define Wheels_h


  #define Turnover 40
  #define Circum 21


  class Wheels {
      public: 
          //Counter& counter;
          uint8_t currentSpeed;
          Wheels();
         // Wheels(Counter& counter);
          void attachRight(int pinForward, int pinBack, int pinSpeed);
          void attachLeft(int pinForward, int pinBack, int pinSpeed);
            //(pRF = zielony, pRB = niebieski,pRS = żółty,pLF = szary,pLB = czerwony,pLS = biały)
          void attach(int pinRightForward, int pinRightBack, int pinRightSpeed,
                      int pinLeftForward, int pinLeftBack, int pinLeftSpeed);
          void forward();
          void forwardLeft();
          void forwardRight();
          void back();
          void backLeft();
          void backRight();
          void stop();
          void stopLeft();
          void stopRight();
          void setSpeed(uint8_t);
          void setSpeedRight(uint8_t);
          void setSpeedLeft(uint8_t);
          void goForward(int cm);
          void goBack(int cm);
          void turnRight(int cm);
          void turnLeft(int cm);
          int calculateDistance();
          int calculateDelay(int cm);
          bool checkStop();
          int dist;

          void reset();
          void increment0();
          void increment1();
          int getCnt0();
          int getCnt1();

      private: 
          int pinsRight[3];
          int pinsLeft[3];
          volatile int cnt0;
          volatile int cnt1;
  };



  #endif
