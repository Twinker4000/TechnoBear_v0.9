#pragma once
#include <Arduino.h>

#include <Servo.h>
#include <MsTimer2.h>

// MOTOR (пин включения, пин шагов, пин направления, отношение пересчёта шагов, инверсия) - класс для управления шаговикамом через драйвер
class MOTOR {               
  public:
    MOTOR(byte PIN_EN, byte PIN_STEP, byte PIN_DIR, bool Invert) {
      _PIN_EN = PIN_EN;
      _PIN_STEP = PIN_STEP;
      _PIN_DIR = PIN_DIR;
      _Invert = Invert;

      pinMode(_PIN_STEP, OUTPUT);
      pinMode(_PIN_DIR, OUTPUT);
      pinMode(_PIN_EN, OUTPUT);
    }

    void ON() {
      digitalWrite(_PIN_EN, 0);
    }
    void OFF() {
      _Steps = 0;
      digitalWrite(_PIN_EN, 1);
    }
    long STOP(){
      long t = _Steps;
      OFF();
      return t;
    }

    long getSteps(){
      return _Steps;
    }

    bool isActive() {
      return (_Steps != 0);
    }

    void setNEXT(bool t){
      _NEXT = t;
    }

    void Move(long Target) {
      if (Target == 0)return;

      if ( (!isActive()) || (_NEXT==1) ) {
        digitalWrite(_PIN_EN, 0);
        
        if (Target > 0) {
          digitalWrite(_PIN_DIR, _Invert);
        } else {
          digitalWrite(_PIN_DIR, !_Invert);
        }

        _Steps = abs(Target);
        MsTimer2::start();
      }
    }

    void Go() {
      if (_Steps > 0) {
        _InStep = !_InStep;
        digitalWrite(_PIN_STEP, _InStep);
        if (!_InStep) _Steps--;
      }
      if (_Steps < 0) {
        _Steps = 0;
      }
    }

  private:
    byte _PIN_EN;  //Подключение драйвера
    byte _PIN_STEP;
    byte _PIN_DIR;
    bool _Invert;
    bool _EN = 0;        //
    bool _NEXT = 0;      //Начала нового движения без завершения текущего
    long _Steps;         //Отображает сколько шагов осталось сделать (в движении)
    bool _InStep;        //Подача импульсов на драйвер
};

MOTOR M1(PIN_en, PIN_Ystep, PIN_Ydir, 0);  //Подключаем левый мотор
MOTOR M2(PIN_en, PIN_Zstep, PIN_Zdir, 1);  //Подключаем правый мотор
Servo S3;

unsigned long TimeToOFF = 0;

void Timer();
void init_Motors(){
  MsTimer2::set(3, Timer);
  M1.OFF();
  M2.OFF();
  S3.attach(PIN_SERVO);
}

void Timer() {                                        
  M1.Go();
  M2.Go();

  if ((!M1.isActive()) && (!M2.isActive())) {
    MsTimer2::stop();
    if (HOLD==true)TimeToOFF = millis() + 250;
    else TimeToOFF = millis();
  }
}

void Motors_test(){
  if (TimeToOFF == 0)return;
  if (TimeToOFF < millis()){
    M1.OFF();
    M2.OFF();
    TimeToOFF = 0;
    DoingCom = 0;
    if (UZotvet==true){
      UZotvet=false;
      input_Number=my_number;
      input_Command=12;
      input_Data=-1;
      ToDoCom = true;
    }
  }
}

void MotorsMove(int l, int r){
  M1.Move(l);
  M2.Move(r);
}
