/*
Модуль содержит в себе классы для создания прямоугольных и круглых кнопок.
  
Использавание:
 
  1. Создание процедуры, которая будет вызываться после клика
    Пример:
    void button_1_Click(){
      ...
    }
    
  2. Создание глобального объекта
    2.1. ButtonRect(Xpos,Ypos,Width,Height,NamePrecedure) - прямоугольная кнопка
      Xpos, Ypos - координаты верхнего левого угла кнопки
      Width, Height - ширина и высота кнопки
      NamePrecedure - имя процедуры, которая будет вызываться после клика
      Пример:
      ButtonRect button_1 = new ButtonRect(10, 10, 180, 180, "button_1_Click");
    2.2. ButtonCircle(Xpos,Ypos,Diameter,NamePrecedure) - круглая кнопка
      Xpos, Ypos - координаты центра кнопки
      Diameter - диаметр кнопки
      NamePrecedure - имя процедуры, которая будет вызываться после клика
      Пример:
      ButtonCircle button_2 = new ButtonCircle(300, 100, 180, "button_2_Click");    
      
  3. Присвоение графических свойств кнопке в void setup (если пропустить этот пункт, получится невидимая кнопка)
    3.1.SetColor(fill_on,fill_off,stroke,strokeWeight);
      fill_on - цвет при нажатии
      fill_off - цвет в отпущенном состоянии
      stroke - цвет обводки
      strokeWeight - толщина обводки
      Пример:
      button_1.SetColor(#98F597,#C4C6C4,#484848,3);
    3.2. SetSvgFile(fileOn,fileOff);
      fileOn - имя svg файла, отображаемого при нажатии
      fileOff - имя svg файла, отображаемого в отпущенном состоянии
      Пример:
      button_2.SetSvgFile("buttonOn.svg","buttonOff.svg");
    
  4. Отрисовка в void draw
    Пример:
    button_1.Draw();
    
  5. Обновление состояния кнопки в void mousePressed
    Пример:
    button_1.Pressed();
    
  6. Обновление состояния кнопки в void mouseReleased
    Пример:
    button_1.Released();
*/

class ButtonRect { 
  int Xpos,Ypos,Width,Height;
  String ClickName = "";
  
  boolean buttonStatus = false;
  boolean lastMouseStatus = false;
  
  
  color Fon=#8DF5AB,Foff=#C5CBC5, Fstroke=color(0);
  int BstrokeWeight=1;
  
  PGraphics ButtonDrawBuffer;
  boolean bufferUse = false;
  PShape svgOn,svgOff;
  boolean svgUse = false;
  
  ButtonRect (int x,int y,int w,int h, String name) {  
    Xpos = x;
    Ypos = y;
    Width = w;
    Height = h;
    ClickName = name;

  } 
  
  void SetColor(color on, color off, color str, int strW){
    Fon=on;
    Foff=off;
    Fstroke=str;
    BstrokeWeight=strW;
    ButtonDrawBuffer = createGraphics(Width+20+BstrokeWeight*2, Height+20+BstrokeWeight*2);
    bufferUse = true;
    UpgradeBuffer();
  }
  
  void SetSvgFile(String fileOn, String fileOff){
    svgOn = loadShape(fileOn);
    svgOff = loadShape(fileOff);
    ButtonDrawBuffer = createGraphics(Width, Height);
    bufferUse = true;
    svgUse = true;
    UpgradeBuffer();
  }
  
  void Pressed() { 
    buttonStatus = Test();
    if (buttonStatus && bufferUse)UpgradeBuffer();
    lastMouseStatus = true;
  }
  
  void UpgradeBuffer(){
    ButtonDrawBuffer.beginDraw();  
    ButtonDrawBuffer.clear();  
    if (svgUse){
      if (buttonStatus)
        ButtonDrawBuffer.shape(svgOn, 0, 0, Width, Height);
      else
        ButtonDrawBuffer.shape(svgOff, 0, 0, Width, Height);
      ButtonDrawBuffer.endDraw();
      return;
    }
    
    if (buttonStatus)
      ButtonDrawBuffer.fill(Fon);
    else
      ButtonDrawBuffer.fill(Foff);
    ButtonDrawBuffer.stroke(Fstroke);
    ButtonDrawBuffer.strokeWeight(BstrokeWeight);
    ButtonDrawBuffer.rect(10+BstrokeWeight,10+BstrokeWeight,Width,Height);
    ButtonDrawBuffer.endDraw();
  }
  
  boolean Test(){
    return overRect(Xpos,Ypos,Width,Height);
  }
  
  boolean getStatus(){
    return buttonStatus;
  }
  
  void Released() { 
    if (ClickName=="")return;
    if (buttonStatus){
      if(Test())thread(ClickName);
    }
    buttonStatus=false;
    if (bufferUse)UpgradeBuffer();
    lastMouseStatus = false;
  }
  
  void DrawButton(){
    //if ((mousePressed) && (!lastMouseStatus))Pressed();
    //if ((!mousePressed) && (lastMouseStatus))Released();
    if(bufferUse){
      if (svgUse)image(ButtonDrawBuffer, Xpos, Ypos);
      else image(ButtonDrawBuffer, Xpos-10-BstrokeWeight, Ypos-10-BstrokeWeight);
    }
  }
}


boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) <= diameter/2 ) {
    return true;
  } else {
    return false;
  }
}

class ButtonCircle { 
  int Xpos,Ypos,Diameter;
  String ClickName = "";
  
  boolean buttonStatus = false;
  boolean lastMouseStatus = false;
  
  
  color Fon=#8DF5AB,Foff=#C5CBC5, Fstroke=color(0);
  int BstrokeWeight=1;
  
  PGraphics ButtonDrawBuffer;
  boolean bufferUse = false;
  PShape svgOn,svgOff;
  boolean svgUse = false;
  ButtonCircle (int x, int y, int diameter, String name) {  
    Xpos = x;
    Ypos = y;
    Diameter = diameter;
    ClickName = name;

  } 
  
  void SetColor(color on, color off, color str, int strW){
    Fon=on;
    Foff=off;
    Fstroke=str;
    BstrokeWeight=strW;
    ButtonDrawBuffer = createGraphics(Diameter+20+BstrokeWeight*2, Diameter+20+BstrokeWeight*2);
    bufferUse = true;
    UpgradeBuffer();
  }
  
  void SetSvgFile(String fileOn, String fileOff){
    svgOn = loadShape(fileOn);
    svgOff = loadShape(fileOff);
    ButtonDrawBuffer = createGraphics(Diameter, Diameter);
    
    bufferUse = true;
    svgUse = true;
    UpgradeBuffer();
  }
  
  void Pressed() { 
    buttonStatus = Test();
    if (buttonStatus && bufferUse)UpgradeBuffer();
    lastMouseStatus = true;
  }
  
  void UpgradeBuffer(){
    ButtonDrawBuffer.beginDraw();  
    ButtonDrawBuffer.clear();  
    
    if (svgUse){
      if (buttonStatus)
        ButtonDrawBuffer.shape(svgOn, 0, 0, Diameter, Diameter);
      else
        ButtonDrawBuffer.shape(svgOff, 0, 0, Diameter, Diameter);
      ButtonDrawBuffer.endDraw();
      return;
    }
    
    
    if (buttonStatus)
      ButtonDrawBuffer.fill(Fon);
    else
      ButtonDrawBuffer.fill(Foff);
    ButtonDrawBuffer.stroke(Fstroke);
    ButtonDrawBuffer.strokeWeight(BstrokeWeight);
    ButtonDrawBuffer.circle(10+BstrokeWeight+Diameter/2,10+BstrokeWeight+Diameter/2,Diameter);
    ButtonDrawBuffer.endDraw();
  }
  
  boolean Test(){
    return overCircle(Xpos,Ypos,Diameter);
  }
  
  void Released() { 
    if (ClickName=="")return;
    if (buttonStatus){
      if(Test())thread(ClickName);
    }
    buttonStatus=false;
    if (bufferUse)UpgradeBuffer();
    lastMouseStatus = false;
  }
  
  void DrawButton(){
    //if ((mousePressed) && (!lastMouseStatus))Pressed();
    //if ((!mousePressed) && (lastMouseStatus))Released();
    if (bufferUse){
      if (svgUse)image(ButtonDrawBuffer, Xpos-Diameter/2, Ypos-Diameter/2);
      else image(ButtonDrawBuffer, Xpos-10-BstrokeWeight-Diameter/2, Ypos-10-BstrokeWeight-Diameter/2);
    }
  }
}
