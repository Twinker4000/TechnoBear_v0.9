ButtonCircle butSonar0  = new ButtonCircle(415, 320, 32, "butSonar0Click");
ButtonCircle butSonar30  = new ButtonCircle(445, 207, 32, "butSonar30Click");
ButtonCircle butSonar60  = new ButtonCircle(527, 125, 32, "butSonar60Click");
ButtonCircle butSonar90  = new ButtonCircle(640, 95, 32, "butSonar90Click");
ButtonCircle butSonar120  = new ButtonCircle(753, 125, 32, "butSonar120Click");
ButtonCircle butSonar150  = new ButtonCircle(835, 207, 32, "butSonar150Click");
ButtonCircle butSonar180  = new ButtonCircle(865, 320, 32, "butSonar180Click");

ButtonCircle butF50 = new ButtonCircle(540, 170, 35, "butF50Click");
ButtonCircle butF100 = new ButtonCircle(590, 170, 35, "butF100Click");
ButtonCircle butF200 = new ButtonCircle(640, 170, 35, "butF200Click");
ButtonCircle butF400 = new ButtonCircle(690, 170, 35, "butF400Click");
ButtonCircle butF800 = new ButtonCircle(740, 170, 35, "butF800Click");

ButtonCircle butL45 = new ButtonCircle(570, 250, 32, "butL45Click");
ButtonCircle butL90 = new ButtonCircle(542, 320, 32, "butL90Click");

ButtonCircle butR45 = new ButtonCircle(710, 250, 32, "butR45Click");
ButtonCircle butR90 = new ButtonCircle(738, 320, 32, "butR90Click");

ButtonCircle butB50= new ButtonCircle(640, 470, 32, "butB50Click");

ButtonCircle butNum00 = new ButtonCircle(640, 574, 50, "butNum00Click");
ButtonCircle butNum01 = new ButtonCircle(690, 574, 50, "butNum01Click");
ButtonCircle butNum02 = new ButtonCircle(740, 574, 50, "butNum02Click");
ButtonCircle butNum03 = new ButtonCircle(790, 574, 50, "butNum03Click");
ButtonCircle butNum04 = new ButtonCircle(840, 574, 50, "butNum04Click");
ButtonCircle butNum05 = new ButtonCircle(890, 574, 50, "butNum05Click");

void initRobot(){
  butSonar0.SetSvgFile("kc-on.svg","k-off.svg");
  butSonar30.SetSvgFile("kc-on.svg","k-off.svg");
  butSonar60.SetSvgFile("kc-on.svg","k-off.svg");
  butSonar90.SetSvgFile("kc-on.svg","k-off.svg");
  butSonar120.SetSvgFile("kc-on.svg","k-off.svg");
  butSonar150.SetSvgFile("kc-on.svg","k-off.svg");
  butSonar180.SetSvgFile("kc-on.svg","k-off.svg");
  
  butF50.SetSvgFile("kc-on.svg","k-off.svg");
  butF100.SetSvgFile("kc-on.svg","k-off.svg");
  butF200.SetSvgFile("kc-on.svg","k-off.svg");
  butF400.SetSvgFile("kc-on.svg","k-off.svg");
  butF800.SetSvgFile("kc-on.svg","k-off.svg");
  
  butL45.SetSvgFile("kc-on.svg","k-off.svg");
  butL90.SetSvgFile("kc-on.svg","k-off.svg");
  
  butR45.SetSvgFile("kc-on.svg","k-off.svg");
  butR90.SetSvgFile("kc-on.svg","k-off.svg");
  
  butB50.SetSvgFile("kc-on.svg","k-off.svg");
  
  
  MapRobot_png = loadImage("MapRobot.png");
  Help_png = loadImage("Help.png");
   
  Num00_png = loadImage("Num00.png");
  Num01_png = loadImage("Num01.png");
  Num02_png = loadImage("Num02.png");
  Num03_png = loadImage("Num03.png");
  Num04_png = loadImage("Num04.png");
  Num05_png = loadImage("Num05.png");
   
  SonarOn_png = loadImage("SonarOn.png");
  SonarOff_png = loadImage("SonarOff.png");

}

PImage MapRobot_png;
PImage Help_png;

int usingNum = 0;
PImage Num00_png;
PImage Num01_png;
PImage Num02_png;
PImage Num03_png;
PImage Num04_png;
PImage Num05_png;

boolean UseHelp = false;

PImage SonarOn_png;
PImage SonarOff_png;

void drawRobot(){
  image(MapRobot_png,320,0);
  switch (usingNum){
    case 0:
      image(Num00_png,619,550);
      break;
    case 1:
      image(Num01_png,619,550);
      break;
    case 2:
      image(Num02_png,619,550);
      break;
    case 3:
      image(Num03_png,619,550);
      break;
    case 4:
      image(Num04_png,619,550);
      break;
    case 5:
      image(Num05_png,619,550);
      break;
  }
  if (usingNum == 0) image(SonarOff_png,320,0);
  else image(SonarOn_png,320,0);
  if (UseHelp)image(Help_png,320,0);
  
  butSonar0.DrawButton();
  butSonar30.DrawButton();
  butSonar60.DrawButton();
  butSonar90.DrawButton();
  butSonar120.DrawButton();
  butSonar150.DrawButton();
  butSonar180.DrawButton();
  
  butF50.DrawButton();
  butF100.DrawButton();
  butF200.DrawButton();
  butF400.DrawButton();
  butF800.DrawButton();
  
  butL45.DrawButton();
  butL90.DrawButton();
  
  butR45.DrawButton();
  butR90.DrawButton();
  
  butB50.DrawButton();
}

void pressedRobotButtons(){
  if (usingNum != 0){
    butSonar0.Pressed();
    butSonar30.Pressed();
    butSonar60.Pressed();
    butSonar90.Pressed();
    butSonar120.Pressed();
    butSonar150.Pressed();
    butSonar180.Pressed();
  }
  
  butF50.Pressed();
  butF100.Pressed();
  butF200.Pressed();
  butF400.Pressed();
  butF800.Pressed();
  
  butL45.Pressed();
  butL90.Pressed();
  
  butR45.Pressed();
  butR90.Pressed();
  
  butB50.Pressed();
  
  butNum00.Pressed();
  butNum01.Pressed();
  butNum02.Pressed();
  butNum03.Pressed();
  butNum04.Pressed();
  butNum05.Pressed();
  
}

void releasedRobotButtons(){
  butSonar0.Released();
  butSonar30.Released();
  butSonar60.Released();
  butSonar90.Released();
  butSonar120.Released();
  butSonar150.Released();
  butSonar180.Released();
  
  butF50.Released();
  butF100.Released();
  butF200.Released();
  butF400.Released();
  butF800.Released();
  
  butL45.Released();
  butL90.Released();
  
  butR45.Released();
  butR90.Released();
  
  butB50.Released();
  
  butNum00.Released();
  butNum01.Released();
  butNum02.Released();
  butNum03.Released();
  butNum04.Released();
  butNum05.Released();
}


//-----------------------------------------------------------------
void butSonar0Click(){
  String s = str(usingNum);
  if (s.length()<2)s="0"+s;
  s += "390*";
  SendMessage(s);
}
void butSonar30Click(){
  String s = str(usingNum);
  if (s.length()<2)s="0"+s;
  s += "3930*";
  SendMessage(s);
}
void butSonar60Click(){
  String s = str(usingNum);
  if (s.length()<2)s="0"+s;
  s += "3960*";
  SendMessage(s);
}
void butSonar90Click(){
  String s = str(usingNum);
  if (s.length()<2)s="0"+s;
  s += "3990*";
  SendMessage(s);
}
void butSonar120Click(){
  String s = str(usingNum);
  if (s.length()<2)s="0"+s;
  s += "39120*";
  SendMessage(s);
}
void butSonar150Click(){
  String s = str(usingNum);
  if (s.length()<2)s="0"+s;
  s += "39150*";
  SendMessage(s);
}
void butSonar180Click(){
  String s = str(usingNum);
  if (s.length()<2)s="0"+s;
  s += "39180*";
  SendMessage(s);
}
//-----------------------------------------------------------------
void butF50Click(){
  String s = str(usingNum);
  if (s.length()<2)s="0"+s;
  s += "3150*";
  SendMessage(s);
}
void butF100Click(){
  String s = str(usingNum);
  if (s.length()<2)s="0"+s;
  s += "31100*";
  SendMessage(s);
}
void butF200Click(){
  String s = str(usingNum);
  if (s.length()<2)s="0"+s;
  s += "31200*";
  SendMessage(s);
}
void butF400Click(){
  String s = str(usingNum);
  if (s.length()<2)s="0"+s;
  s += "31400*";
  SendMessage(s);
}
void butF800Click(){
  String s = str(usingNum);
  if (s.length()<2)s="0"+s;
  s += "31800*";
  SendMessage(s);
}

void butB50Click(){
  String s = str(usingNum);
  if (s.length()<2)s="0"+s;
  s += "3250*";
  SendMessage(s);
}
//-----------------------------------------------------------------
void butL45Click(){
  String s = str(usingNum);
  if (s.length()<2)s="0"+s;
  s += "3390*";
  SendMessage(s);
}
void butL90Click(){
  String s = str(usingNum);
  if (s.length()<2)s="0"+s;
  s += "33180*";
  SendMessage(s);
}

void butR45Click(){
  String s = str(usingNum);
  if (s.length()<2)s="0"+s;
  s += "3490*";
  SendMessage(s);
}
void butR90Click(){
  String s = str(usingNum);
  if (s.length()<2)s="0"+s;
  s += "34180*";
  SendMessage(s);
}
//-----------------------------------------------------------------
void butNum00Click(){
  usingNum=0;
}
void butNum01Click(){
  usingNum=1;
}
void butNum02Click(){
  usingNum=2;
}
void butNum03Click(){
  usingNum=3;
}
void butNum04Click(){
  usingNum=4;
}
void butNum05Click(){
  usingNum=5;
}
