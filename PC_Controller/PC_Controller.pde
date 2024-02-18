
void setup(){
   size(960,640);
   initConsoleButtons();
   initRobot();
   InitSerial();
}

void draw(){
  drawConsole();
  drawRobot();
  if (PortTest()){
    //println(ID, Number, Command,"#");
    ConsoleLogAdd(ID, Number, Command,'#');
  }
}

void mousePressed(){
  pressedConsoleButtons();
  pressedRobotButtons();
}

void mouseReleased(){
  releasedConsoleButtons();
  releasedRobotButtons();
}
void keyPressed(){
  //println(key,keyCode);
  
  switch (key){
    case '0':
      butK0Click();
      break;
    case '1':
      butK1Click();
      break;
    case '2':
      butK2Click();
      break;
    case '3':
      butK3Click();
      break;
    case '4':
      butK4Click();
      break;
    case '5':
      butK5Click();
      break;
    case '6':
      butK6Click();
      break;
    case '7':
      butK7Click();
      break;
    case '8':
      butK8Click();
      break;
    case '9':
      butK9Click();
      break;
    case '*':
      butKStarClick();
      break;
    case '/':
      butKSharpClick();
      break;
    case '-':
      butKDelClick();
      break;
  }
}
