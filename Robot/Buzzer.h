#pragma once
#include <Arduino.h>



void init_Buzzer() {
  pinMode(PIN_BUZZER, OUTPUT);
}

void BUZZER_Time(long t) {
  if (t <= 0) return;
  digitalWrite(PIN_BUZZER, 1);
  delay(t);
  digitalWrite(PIN_BUZZER, 0);
  delay(t);
}

void BUZZER_Time(long t, int c) {
  if ((t <= 0) || (c <= 0)) return;
  for (int i = 0; i < c; i++) {
    digitalWrite(PIN_BUZZER, 1);
    delay(t);
    digitalWrite(PIN_BUZZER, 0);
    delay(t);
  }
}
