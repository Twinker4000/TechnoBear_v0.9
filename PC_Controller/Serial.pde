import processing.serial.*;
Serial port;
String[] Ports;
boolean PortOn=false;

int ID, Number, Command, DataLen = 0;

void InitSerial(){      //Сохранение доступных портов в массив
  println("Activ ports:");
  ConsoleLog("Activ ports:");
  Ports=Serial.list();
  printArray(Ports);
  for (int i=0; i<Ports.length; i++){
    ConsoleLog("["+i+"] "+Ports[i]);
  }
  println("Please select port!");

}

void ConectSerial(int index) {          //Подключение к выбранному порту
  if (index<0)return;
  if (index>=Ports.length)return;
  print("Conect to "+Ports[index]+" ... ");
  PortOn = true;
  port = new Serial(this, Ports[index], 9600);
  port.bufferUntil(10);
  println("OK");
  ConsoleLog("Conect to "+Ports[index]);
  new_massage="";
  println("------------------");
  
}

boolean PortTest(){
  if (!PortOn)return false;
  if (port.available() <= 0)return false;
  char ch = port.readChar();
  return TestNaProtocol(ch);
  
}

boolean TestNaProtocol(char ch) {
  if (DataLen == 0){
    ID = -1; Number = -1; Command = -1;
  }

  if (ch == '\n' || ch == '\r') {
    DataLen = 0;
    return false;
  }
  
  if (DataLen < 4) {
    if (!isNumber(ch)) {
      DataLen = 0;
      return false;
    }
    switch (DataLen) {
      case 0: ID = int(ch - 48) * 10; break;
      case 1: ID += int(ch - 48); break;
      case 2: Number = int(ch - 48) * 10; break;
      case 3: Number += int(ch - 48); break;
    }
    DataLen++;
  }
  else if (ch == '#') {
    DataLen = 0;
    return true;
  }
  else if (ch == '*') {
    DataLen = 0;
    return false;
  } else if (DataLen < 10) {
    if (!isNumber(ch)) {
      // dataError = true;
      DataLen = 0;
      return false;
    }
    switch (DataLen) {
      case 4: Command = int(ch - 48); break;
      default: Command = Command * 10 + int(ch - 48);
    }
    DataLen++;
  }
  return false;
}

boolean isNumber(char ch) {
  if (48 <= ch && ch <= 57) return true;
  else return false;
}

long old_millis = 0;
void SendMessage(String Send){
  if (old_millis>millis())return;
  old_millis=millis()+500;
  if (!PortOn)return;
  ConsoleLogTime(Send);
  //println(Send);
  port.write(Send);
}
