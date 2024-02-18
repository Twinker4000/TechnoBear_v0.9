
#include <ELECHOUSE_CC1101.h>  //Download it here: http://electronoobs.com/eng_arduino_ELECHOUSE_CC1101.php

//TX
#define buffer_len 16
char buffer[buffer_len];

//RX
#define MaxSizeData 20
byte RX_buffer[MaxSizeData];
byte RX_size;
// bool correct;

void setup() {
  Serial.begin(9600);
  
  ELECHOUSE_cc1101.Init(F_433);
  ELECHOUSE_cc1101.SetReceive();
}

void loop() {
  if (Serial.available()) parsing(Serial.read());

  if (ELECHOUSE_cc1101.CheckReceiveFlag()) {
    bool correct = ReadDataCRC();
    if (correct) Protocol();
    // else Serial.println("Data is not correct!");
    ELECHOUSE_cc1101.SetReceive();
  }
}



bool ReadDataCRC() {

  RX_size = ELECHOUSE_cc1101.ReceiveData(RX_buffer);
  long crc = 0;
  for (byte i = 0; i < RX_size - 1; i++) {
    crc += RX_buffer[i];
  }
  if ((RX_buffer[RX_size - 1] == byte(crc % 256))) return 1;
  else return 0;
}

void SendDataCRC(char* data, int n) {

  ELECHOUSE_cc1101.SetReceive();
  ELECHOUSE_cc1101.Init(F_433);
  delay(10);
  byte buffer[n + 1];
  long crc = 0;
  for (int i = 0; i < n; i++) {
    buffer[i] = byte(data[i]);
    crc += buffer[i];
  }
  buffer[n] = byte(crc % 256);
  ELECHOUSE_cc1101.SendData(buffer, n + 1);
  delay(10);
  ELECHOUSE_cc1101.SetReceive();
  
}


void Protocol() {
  if (RX_size<4)return;
  for (byte i = 0; i < RX_size - 1; i++) {
    Serial.print(char(RX_buffer[i]));
  }
  Serial.println();
}


int parsing(char in) {
  // Serial.println(in);
  static bool parseStart = false;
  static bool errorLong = false;
  static byte counter = 0;

  if (in == '\n' || in == '\r') return 0;  // игнорируем перевод строки

  if (in == '*') {  // завершение пакета
    parseStart = false;
    byte n = counter;
    counter = 0;
    if (errorLong) {
      errorLong = false;
      return 0;
    } else if (n < 4) return 0;
    else {
      buffer[n] = (char)in;
      // Serial.print("IN ");
      // Serial.println(n + 1);
      SendDataCRC(buffer, n + 1);
      
      return n + 1;
    }
  }

  if (in == '#') {  // завершение пакета
    parseStart = false;
    counter = 0;
    return 0;
  }

  if (counter >= buffer_len) {
    errorLong = true;
    return 0;
  }

  if (('0' <= in) && (in <= '9')) {
    buffer[counter] = (char)in;
    counter++;
  } else {
    counter = 0;
  }

  return 0;
}
