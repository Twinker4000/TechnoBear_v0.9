String Tab = "Robot";


void setup(){
   size(960,640);
   initConsoleButtons();
   initMap();
   initRobot();
   InitSerial();
}

void draw(){
  background(200);
  drawConsole();
  if (Tab=="Robot")
    drawRobot();
  else if (Tab=="Map")
    drawMap();
  if (PortTest()){
    //println(ID, Number, Command,"#");
    ConsoleLogAdd(ID, Number, Command,'#');
    if (Number==12){
      switch (ID){
        case 1: R1.Radar(lastRadarAngle,Command);break;
        case 2: R2.Radar(lastRadarAngle,Command);break;
        case 3: R3.Radar(lastRadarAngle,Command);break;
      }
    }
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
  println(key,keyCode);
  
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
  
  switch (keyCode){
    case 38:
      SendMessage("0131100*");
      break;
    case 40:
      SendMessage("0132100*");
      break;
    case 37:
      SendMessage("013360*");
      break;
    case 39:
      SendMessage("013460*");
      break;
  }
}
