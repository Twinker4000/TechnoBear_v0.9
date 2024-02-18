#pragma once
#include <Arduino.h>

void init_HC_SR04(){
  pinMode(PIN_Xdir, OUTPUT);   //PIN_HC_SR04_TRIG = PIN_Xdir
  pinMode(PIN_Xstep, INPUT);   //PIN_HC_SR04_ECHO = PIN_Xstep
}
//Замер расстояния УЗ датчиком
int HC_SR04_dist(){
  digitalWrite(PIN_Xdir, LOW);
  delayMicroseconds(2);
  digitalWrite(PIN_Xdir, HIGH);
  delayMicroseconds(10);
  digitalWrite(PIN_Xdir, LOW);
  float distance = pulseIn(PIN_Xstep, HIGH);  // Узнаем длительность высокого сигнала на пине Echo
  distance = distance/58*10;                    // Перевод в мм
  return (int)distance;
}
