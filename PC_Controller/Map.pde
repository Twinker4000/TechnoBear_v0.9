PGraphics map;
PGraphics Wallmap;
PImage Imap;
float compascorrecting = 0;

Robot R1 = new Robot(400, 1600, -PI/2 + compascorrecting, #FF0000);
Robot R2 = new Robot(1000, 1600, -PI/2 + compascorrecting, #00FF00);
Robot R3 = new Robot(1600, 1600, -PI/2 + compascorrecting, #0000FF);

void drawMap(){
  clearMap();
  R1.Draw();
  R2.Draw();
  R3.Draw();
  image(Imap, 320, 0, 640, 640);
  image(map, 320, 0, 640, 640);
  image(Wallmap, 320, 0, 640, 640);
}

float lastRadarAngle = 0;

void MapCommand(String message){
  int Id = int(message.charAt(0) - 48)*10 + int(message.charAt(1) - 48);
  int Com = int(message.charAt(2) - 48)*10 + int(message.charAt(3) - 48);
  int Data = -1;
  if (message.length()>5){
    Data=int(message.charAt(4) - 48);
    for (int i=5; i<message.length()-1;i++)Data = Data*10 + int(message.charAt(i) - 48);
  }

  if (message.charAt(message.length()-1)=='*'){
    switch (Com){
      case 12:
        lastRadarAngle=0;
        break;
      case 31:
        if (Id==1 || Id==0)R1.Move(Data);
        if (Id==2 || Id==0)R2.Move(Data);
        if (Id==3 || Id==0)R3.Move(Data);
        break;
      case 32:
        if (Id==1 || Id==0)R1.Move(-Data);
        if (Id==2 || Id==0)R2.Move(-Data);
        if (Id==3 || Id==0)R3.Move(-Data);
        break;
      case 33:
        if (Id==1 || Id==0)R1.Rotate(radians(-Data/2));
        if (Id==2 || Id==0)R2.Rotate(radians(-Data/2));
        if (Id==3 || Id==0)R3.Rotate(radians(-Data/2));
        break;
      case 34:
        if (Id==1 || Id==0)R1.Rotate(radians(Data/2));
        if (Id==2 || Id==0)R2.Rotate(radians(Data/2));
        if (Id==3 || Id==0)R3.Rotate(radians(Data/2));
        break;
      case 39:
        lastRadarAngle=radians(Data-90);
        break;
    }
  }
  
  if (message.charAt(message.length()-1)=='#'){
    
  }
}


void initMap() {
  map = createGraphics(2000, 2000);
  Wallmap = createGraphics(2000, 2000);
  Imap = loadImage("ScreenMap.jpg");
  clearMap();
  Wallmap.beginDraw();
  Wallmap.clear();
  Wallmap.endDraw();
}
void clearMap(){
  map.beginDraw();
  map.clear();
  
  //map.background(150);
  map.endDraw();
  
}
class Robot {
  float xpos, ypos, angle, speed;
  color fillcolor;
  Robot (float x, float y, float a, color c) {
    xpos = x;
    ypos = y;
    angle = a;
    fillcolor = c;
  }
  void Draw() {
    
    map.beginDraw();
    map.translate(xpos, ypos);
    map.strokeWeight(2);
    map.stroke(0);
    map.fill(240);
    map.rotate(angle);
    map.ellipse(0, 0, 140, 140);
    map.fill(fillcolor);
    map.triangle(10, -30, 60, 0, 10, 30);
    map.rotate(-angle);
    map.translate(-xpos, -ypos);
    map.endDraw();
  }
  void Move(float dist) {
    float newxpos=xpos+cos(angle)*dist;
    float newypos=ypos+sin(angle)*dist;
    if (newxpos<0 || newypos<0 || newxpos>2000 || newypos>2000)return;

    //int Vscan = VScaner();
    //if (Vscan!=0 && Vscan-75<dist) {
    //  return;
    //}

    map.beginDraw();
    map.stroke(230);
    map.strokeWeight(150);
    map.line(xpos, ypos, newxpos, newypos);
    map.endDraw();
    xpos=newxpos;
    ypos=newypos;
  }
  void Rotate(float a) {
    angle+=a;
    if (angle<0)angle+=2*PI;
    if (angle>=2*PI)angle-=2*PI;
  }
  void Radar(float a, float dist) {
    float radarangle=angle+a;
    if (radarangle<0)radarangle+=2*PI;
    if (radarangle>=2*PI)radarangle-=2*PI;

    Wallmap.beginDraw();
    Wallmap.stroke(240);
    Wallmap.strokeWeight(90);
    //map.line(xpos, ypos, xpos+cos(radarangle)*(dist-45), ypos+sin(radarangle)*(dist-45));
    Wallmap.stroke(60);
    Wallmap.strokeWeight(20);
    float walla = 0.15;
    Wallmap.point(xpos+cos(radarangle)*(dist), ypos+sin(radarangle)*(dist));
    //map.line(xpos+cos(radarangle-walla)*dist, ypos+sin(radarangle-walla)*dist, xpos+cos(radarangle+walla)*dist, ypos+sin(radarangle+walla)*dist);
    Wallmap.endDraw();
  }
  int VScaner() {
    int scan=0;
    float delta=PI/24;//угол сканирования
    int rays = 3;     //количество лучей
    map.beginDraw();
    map.strokeWeight(1);
    map.stroke(#00FF00);
    for (int i = 75; i<2000; i++) {
      for (int j=0; j<rays; j++) {
        int tx=int(xpos+cos(angle-delta/2+float(j)*delta/(rays-1))*float(i));
        int ty=int(ypos+sin(angle-delta/2+float(j)*delta/(rays-1))*float(i));
        color c = map.get(tx, ty);
        if (c==#000000 || c==#3C3C3C) {
          scan=i;
          break;
        }
        c = Wallmap.get(tx, ty);
        if (c==#000000 || c==#3C3C3C) {
          scan=i;
          break;
        }
        map.point(tx, ty);
      }
      if (scan!=0)break;
    }
    map.endDraw();
    println("VScaner - ", scan);
    return scan;
  }
}
