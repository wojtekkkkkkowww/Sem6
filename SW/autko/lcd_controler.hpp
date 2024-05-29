#include <LiquidCrystal_I2C.h>


#ifndef LCD_CONTROLER_HPP
#define LCD_CONTROLER_HPP


enum class Wheel
{
    LEFT,
    RIGHT
};
enum class State
{
    FORWARD,
    BACKWARD,
    STOP,
    LEFT,
    RIGHT,
    SCAN,
    INIT
};

enum class Mode
{
  MANUAL,
  AUTO

};

// Arduino uno używa pinów A4 = SDA i A5 = SCL do komunikacji I2C
class LcdControler
{
public:
    LcdControler(LiquidCrystal_I2C *lcd)
    {
        this->lcd = lcd;
    }

    void printSpeed(Wheel wh, int speed)
    {
        uint8_t row = 0;
        uint8_t col;
        char cstr[16];

        if (wh == Wheel::LEFT)
        {
            this -> lcd -> setCursor(0, 0);
            this -> lcd -> print("        ");
            this -> lcd -> setCursor(0, 0);

            col = 0;
        }
        else
        {
            this->lcd->setCursor(7, 0);
            this->lcd->print("        ");
            this -> lcd -> setCursor(7, 0);


            if(speed <= 0) {
              col = 15 - this->calc_pading(speed);    
            }else{
              col = 16 - this->calc_pading(speed);
            }
        }
        this->lcd->setCursor(col, row);
        this->lcd->print(itoa(speed, cstr, 10));
    }

    void printState(State state) {
      String stateName;
      switch (state) {
          case State::FORWARD:
              stateName = "FORWARD";
              break;
          case State:: BACKWARD:
              stateName = "BACKWARD";
              break;
          case State::STOP:
              stateName = "STOP";
              break;
          case State::LEFT:
              stateName = "LEFT";
              break;
          case State::RIGHT:
              stateName = "RIGHT";
              break;
          case State::SCAN:
              stateName = "SCAN";
              break;
          case State::INIT:
              stateName = "INIT";
              break;
          default:
              stateName = "";
              break;
      }
      int lcdWidth = 16;  
      this->lcd->setCursor(0, 1);  
      this->lcd->print("                "); 
      this->lcd->setCursor(0, 1);  
      if (stateName == "") {
          return;
      }
      
      int startPosition = (lcdWidth - stateName.length()) / 2;  

      lcd -> setCursor(startPosition, 1); 
      lcd -> print(stateName); 
  }


  void printMode(Mode mode){
    this->lcd->setCursor(5,0);
    this->lcd->print("      ");
    this->lcd->setCursor(5,0);
    switch(mode){
        case Mode::AUTO:
          this->lcd->print("AUTO");
          break;
        case Mode::MANUAL:
          this->lcd->print("MANUAL");
          break;
    }


  }


private:
    LiquidCrystal_I2C *lcd;

    int calc_pading(int speed)
    {
        int i = 0;
        if (speed < 0)
        {
            i++;
        }

        while (speed > 0)
        {
            speed /= 10;
            i++;
        }

        return i;
    }
};

#endif