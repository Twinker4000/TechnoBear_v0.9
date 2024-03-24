ButtonRect butKHelp   = new ButtonRect(240, 363, 70, 32, "butKHelpClick");

ButtonRect butK1     = new ButtonRect(10, 402, 70, 52, "butK1Click");
ButtonRect butK2     = new ButtonRect(87, 402, 70, 52, "butK2Click");
ButtonRect butK3     = new ButtonRect(163, 402, 70, 52, "butK3Click");
ButtonRect butKMap  = new ButtonRect(240, 402, 70, 52, "butKMapClick");

ButtonRect butK4     = new ButtonRect(10, 461, 70, 52, "butK4Click");
ButtonRect butK5     = new ButtonRect(87, 461, 70, 52, "butK5Click");
ButtonRect butK6     = new ButtonRect(163, 461, 70, 52, "butK6Click");
ButtonRect butKDel   = new ButtonRect(240, 461, 70, 52, "butKDelClick");

ButtonRect butK7     = new ButtonRect(10, 519, 70, 52, "butK7Click");
ButtonRect butK8     = new ButtonRect(87, 519, 70, 52, "butK8Click");
ButtonRect butK9     = new ButtonRect(163, 519, 70, 52, "butK9Click");

ButtonRect butKStar  = new ButtonRect(10, 578, 70, 52, "butKStarClick");
ButtonRect butK0     = new ButtonRect(87, 578, 70, 52, "butK0Click");
ButtonRect butKSharp = new ButtonRect(163, 578, 70, 52, "butKSharpClick");

ButtonCircle butKStop  = new ButtonCircle(275, 575, 70, "butKStopClick");

PFont a_LCDNova;
String new_massage = ""; 
String ConsoleLog[] = new String[12];
PImage console_png;

void initConsoleButtons(){
  butK0.SetSvgFile("k-on.svg","k-off.svg");
  butK1.SetSvgFile("k-on.svg","k-off.svg");
  butK2.SetSvgFile("k-on.svg","k-off.svg");
  butK3.SetSvgFile("k-on.svg","k-off.svg");
  butK4.SetSvgFile("k-on.svg","k-off.svg");
  butK5.SetSvgFile("k-on.svg","k-off.svg");
  butK6.SetSvgFile("k-on.svg","k-off.svg");
  butK7.SetSvgFile("k-on.svg","k-off.svg");
  butK8.SetSvgFile("k-on.svg","k-off.svg");
  butK9.SetSvgFile("k-on.svg","k-off.svg");

  butKSharp.SetSvgFile("k-on.svg","k-off.svg");
  butKStar.SetSvgFile("k-on.svg","k-off.svg");
  butKHelp.SetSvgFile("k-on.svg","k-off.svg");
  butKDel.SetSvgFile("k-on.svg","k-off.svg");
  butKStop.SetSvgFile("kc-on.svg","k-off.svg");
  butKMap.SetSvgFile("k-on.svg","k-off.svg");
  
  a_LCDNova = loadFont("a_LCDNova-48.vlw");
  console_png = loadImage("Console.png");
  for (int i = 0; i < ConsoleLog.length; i++)
    ConsoleLog[i]="";
}

void drawConsoleButtons(){
  
  butK0.DrawButton();
  butK1.DrawButton();
  butK2.DrawButton();
  butK3.DrawButton();
  butK4.DrawButton();
  butK5.DrawButton();
  butK6.DrawButton();
  butK7.DrawButton();
  butK8.DrawButton();
  butK9.DrawButton();

  butKSharp.DrawButton();
  butKStar.DrawButton();
  butKHelp.DrawButton();
  butKDel.DrawButton();
  butKStop.DrawButton();
  butKMap.DrawButton();
}

void pressedConsoleButtons(){
  butK0.Pressed();
  butK1.Pressed();
  butK2.Pressed();
  butK3.Pressed();
  butK4.Pressed();
  butK5.Pressed();
  butK6.Pressed();
  butK7.Pressed();
  butK8.Pressed();
  butK9.Pressed();

  butKSharp.Pressed();
  butKStar.Pressed();
  butKHelp.Pressed();
  butKDel.Pressed();
  butKStop.Pressed();
  butKMap.Pressed();
}

void releasedConsoleButtons(){
  butK0.Released();
  butK1.Released();
  butK2.Released();
  butK3.Released();
  butK4.Released();
  butK5.Released();
  butK6.Released();
  butK7.Released();
  butK8.Released();
  butK9.Released();

  butKSharp.Released();
  butKStar.Released();
  butKHelp.Released();
  butKDel.Released();
  butKStop.Released();
  butKMap.Released();
}

void drawConsole(){
  image(console_png,0,0);
  drawConsoleButtons();
  fill(0);
  textFont(a_LCDNova);
  textSize(32);
  text(new_massage,17,350);
  for (int i = 0; i < ConsoleLog.length; i++){
    textSize(25);
    if (ConsoleLog[i].indexOf('*')>-1)
      fill(#3c2b97);
    else if (ConsoleLog[i].indexOf('#')>-1)
      fill(#dc291b);
    else fill(130);
    text(ConsoleLog[i],18,305-i*25);
  }
}


void ConsoleLog(String new_s){
  for (int i = ConsoleLog.length-1; i>0; i--){
    ConsoleLog[i]=ConsoleLog[i-1];
  }
  ConsoleLog[0]=new_s;
}

void ConsoleLogTime(String new_s){
  ConsoleLog(""+hour()+":"+minute()+":"+second()+">"+new_s);
}

void ConsoleLogAdd(int id, int com, int dat, char end){
  String tmp="",new_s = "";
  tmp = str(id);
  if (tmp.length()<2)tmp="0"+tmp;
  new_s+=tmp;
  tmp = str(com);
  if (tmp.length()<2)tmp="0"+tmp;
  new_s+=tmp;
  if (dat>=0)new_s+=str(dat);
  new_s+=end;
  ConsoleLogTime(new_s);
}


void butK0Click(){
  if (new_massage.length()<15)new_massage+="0";
  if (!PortOn)ConectSerial(0);
}
void butK1Click(){
  if (new_massage.length()<15)new_massage+="1";
  if (!PortOn)ConectSerial(1);
}
void butK2Click(){
  if (new_massage.length()<15)new_massage+="2";
  if (!PortOn)ConectSerial(2);
}
void butK3Click(){
  if (new_massage.length()<15)new_massage+="3";
  if (!PortOn)ConectSerial(3);
}
void butK4Click(){
  if (new_massage.length()<15)new_massage+="4";
  if (!PortOn)ConectSerial(4);
}
void butK5Click(){
  if (new_massage.length()<15)new_massage+="5";
  if (!PortOn)ConectSerial(5);
}
void butK6Click(){
  if (new_massage.length()<15)new_massage+="6";
  if (!PortOn)ConectSerial(6);
}
void butK7Click(){
  if (new_massage.length()<15)new_massage+="7";
  if (!PortOn)ConectSerial(7);
}
void butK8Click(){
  if (new_massage.length()<15)new_massage+="8";
  if (!PortOn)ConectSerial(8);
}
void butK9Click(){
  if (new_massage.length()<15)new_massage+="9";
  if (!PortOn)ConectSerial(9);
}

void butKSharpClick(){
  new_massage+="#";
  SendMessage(new_massage);
  new_massage="";
}
void butKStarClick(){
  new_massage+="*";
  SendMessage(new_massage);
  new_massage="";
}

void butKDelClick(){
  new_massage="";
}


void butKStopClick(){
  SendMessage("0000*");
}

void butKHelpClick(){
   UseHelp=!UseHelp; 
}

void butKMapClick(){
  if (Tab=="Map")Tab="Robot";
  else Tab="Map";
}
