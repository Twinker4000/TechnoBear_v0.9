#pragma once
#include <Arduino.h>
#include <ELECHOUSE_CC1101.h>

#define RX_buffer_max 16
byte RX_buffer[RX_buffer_max];
byte RX_buffer_size = 0;
bool CommandCorrect = false;



void init_CC1101(){
  Serial.print("Init_cc1101...");
  ELECHOUSE_cc1101.Init(F_433);
  ELECHOUSE_cc1101.SetReceive();
  Serial.println("OK");
}


//Чтение данных, пришедших на радиомодуль, и их проверка
bool ReadDataCRC() {

  RX_buffer_size = ELECHOUSE_cc1101.ReceiveData(RX_buffer);
  byte crc = 0;
  for (byte i = 0; i < RX_buffer_size - 1; i++) {
    crc += RX_buffer[i];
  }
  if ((RX_buffer[RX_buffer_size - 1] == crc)) return 1;
  else return 0;
}

//Отправка данных с помощью радиомодуля
void SendDataCRC(char* data, int n) {
  ELECHOUSE_cc1101.Init(F_433);
  byte buffer[n + 1];
  byte crc = 0;
  for (int i = 0; i < n; i++) {
    buffer[i] = byte(data[i]);
    crc += buffer[i];
  }
  buffer[n] = crc;
  ELECHOUSE_cc1101.SendData(buffer, n + 1);
  ELECHOUSE_cc1101.SetReceive();
}

void TestNaProtocol(char ch);

void CC1101_test(){
  if (ELECHOUSE_cc1101.CheckReceiveFlag()) {
    BUZZER_Time(100);
    bool test = ReadDataCRC();

    Serial.write(RX_buffer, RX_buffer_size);
    Serial.println();

    ELECHOUSE_cc1101.SetReceive();

    if (test) {
      BUZZER_Time(100);
      CommandCorrect = false;
      for (byte i = 0; i < RX_buffer_size - 1; i++)
        TestNaProtocol(char(RX_buffer[i]));
      ToDoCom = CommandCorrect;
    }
  }
}


//Формирование сообщиния для отправки
void SendOtvet(byte id ,byte num, long d){
  if ((d<-1) || (d>2000000000) || (num>99)|| (id>99))return;
  if (d==-1){
    char chara[] = "0000#";
    chara[0] = '0' + (id / 10);
    chara[1] = '0' + (id % 10);
    chara[2] = '0' + (num / 10);
    chara[3] = '0' + (num % 10);
    SendDataCRC(chara, strlen(chara));
  }else{
    char chara[16];
    chara[0] = '0' + (id / 10);
    chara[1] = '0' + (id % 10);
    chara[2] = '0' + (num / 10);
    chara[3] = '0' + (num % 10);
    String sd = String(d);
    byte n = 4;
    for (byte i = 0; i < sd.length();i++){
      chara[n]=sd[i];
      n++;
    }
    chara[n] = '#';
    chara[n+1] = '\0';
    SendDataCRC(chara, strlen(chara));
  }
  
}


bool isNumber(char ch);

//Расшифровка входящего сообщения
void TestNaProtocol(char ch) {
  static int DataLen = 0;
  if (DataLen == 0){
    input_Number = -1; input_Command = -1; input_Data = -1;
  }

  if (ch == '\n' or ch == '\r') {
    DataLen = 0;
    return;
  }

  if (DataLen < 4) {
    if (!isNumber(ch)) {
      DataLen = 0;
      return;
    }
    switch (DataLen) {
      case 0: input_Number = int(ch - 48) * 10; break;
      case 1: input_Number += int(ch - 48); break;
      case 2: input_Command = int(ch - 48) * 10; break;
      case 3: input_Command += int(ch - 48); break;
    }
    DataLen++;
  }
  else if (ch == '*') {
    DataLen = 0;
    // ComandDoing(input_Number, input_Command, input_Data);
    CommandCorrect = true;
  }
  else if (ch == '#') {
    DataLen = 0;
    return false;
  } else if (DataLen < 10) {
    if (!isNumber(ch)) {
      // dataError = true;
      DataLen = 0;
      return;
    }
    switch (DataLen) {
      case 4: input_Data = int(ch - 48); break;
      default: input_Data = input_Data * 10 + int(ch - 48);
    }
    DataLen++;
  }
}
bool isNumber(char ch) {
  if (48 <= ch && ch <= 57) return 1;
  else return 0;
}
