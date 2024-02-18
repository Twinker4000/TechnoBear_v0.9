#pragma once
#include <Arduino.h>


void init_Button(){
  pinMode(PIN_BUTTON, INPUT_PULLUP);
}

//Проверка бампера
void button_test(){
  static bool wait_ID = true;
  static long End_wait = millis() + 2000;
  static byte new_number = 0;

  static long btnTimer  = 0;
  static bool flag = 0;

  bool btnState = !digitalRead(PIN_BUTTON);


  if (btnState && !flag && millis() - btnTimer > 100) {  //"press"
    flag = true;
    btnTimer = millis();
    
    if (wait_ID == true){
      new_number++;
      Serial.println("Number "+String(new_number));
      End_wait = millis() + 2000;
    }else{
      SendOtvet(my_number,11,1);
    }

  }


  if (!btnState && flag && millis() - btnTimer > 100) {  //"release"
    flag = false;
    btnTimer = millis();
    //Serial.println("release");
  }


  
  if (!wait_ID)return;

  if (End_wait < millis()) {
    my_number = new_number;
    wait_ID = false;
    BUZZER_Time(100,my_number);
  }
}
