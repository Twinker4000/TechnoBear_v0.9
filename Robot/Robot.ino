// Use Arduino, GRBL, CC1101, buzzer, button, HC-SR04
byte my_number = 0;

bool ToDoCom = false;
int input_Number=-1, input_Command=-1, input_Data=-1;
byte DoingCom = 0;
  
bool RADIO = false;      //Включение измерения дистанции после комплексных команд
bool UZotvet = false;   
bool HOLD = true;        //Включение торможения после движений
bool NEXT = false;

//---------------------------------------------------------------------
#define PIN_Xdir 2
#define PIN_Ydir 3
#define PIN_Zdir 4
#define PIN_Xstep 5
#define PIN_Ystep 6
#define PIN_Zstep 7
#define PIN_en 8

#define PIN_BUZZER A1
#define PIN_BUTTON A0
#define PIN_SERVO A2


#include "Buzzer.h"
#include "CC1101.h"
#include "Button.h"
#include "HC_SR04.h"
#include "Motor.h"
//---------------------------------------------------------------------
void BUZZER_Time(long t);
void setup() {
  Serial.begin(9600);

  init_Buzzer();
  init_Button();
  init_CC1101();
  init_HC_SR04();
  init_Motors();
  
  BUZZER_Time(100);
}

void loop() {
  button_test();
  CC1101_test();
  Motors_test();
  
  if (ToDoCom)
    CommandDoing(input_Number, input_Command, input_Data);
}


//Выбор действий в зависимости от входных данных 
void CommandDoing(int Number, int Command, int Data) {
  ToDoCom = false;
  String S = "Do - "+String(Number)+" "+ String(Command)+" "+ String(Data);
  Serial.println(S);
  if ( (Number>0) && (Number != my_number) )return; 
  DoingCom = Command;
  switch (Command){
    
    case 0:
      M1.STOP();
      M2.STOP();
      break;
    case 1:
      M1.Move(Data);
      break;
    case 2:
      M1.Move(-Data);
      break;
    case 3:
      M2.Move(Data);
      break;
    case 4:
      M2.Move(-Data);
      break;
    case 5:
      S3.write(180-Data);
      break;
    

    case 11:
      SendOtvet(my_number, 11, (int)!digitalRead(PIN_BUTTON));
      break;
    case 12:
      SendOtvet(my_number, 12, HC_SR04_dist());
      break;


    case 30:
      M1.STOP();
      M2.STOP();
      break;
    case 31:
      MotorsMove(Data, Data);
      if (RADIO==true) UZotvet=true;
      break;
    case 32:
      MotorsMove(-Data, -Data);
      if (RADIO==true) UZotvet=true;
      break;
    case 33:
      MotorsMove(-Data, Data);
      if (RADIO==true) UZotvet=true;
      break;
    case 34:
      MotorsMove(Data, -Data);
      if (RADIO==true) UZotvet=true;
      break;

    case 35:
      MotorsMove(Data, 0);
      if (RADIO==true) UZotvet=true;
      break;
    case 36:
      MotorsMove(-Data, 0);
      if (RADIO==true) UZotvet=true;
      break;
    case 37:
      MotorsMove(0, Data);
      if (RADIO==true) UZotvet=true;
      break;
    case 38:
      MotorsMove(0, -Data);
      if (RADIO==true) UZotvet=true;
      break;
    case 39:
      S3.write(180-Data);
      delay(1000);
      SendOtvet(my_number, 12, HC_SR04_dist());
      break;
    

    case 72:
      BUZZER_Time(Data);
      break;


    case 81:
      HOLD=(Data>0);
      break;
    case 82:
      RADIO=(Data>0);
      break;
      
  }
}
