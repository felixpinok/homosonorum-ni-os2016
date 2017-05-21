import pKinect.PKinect;
import oscP5.*;
import netP5.*;

PKinect kinect;
OscP5 osc; //TALKS
NetAddress maxmsp; //TALKS
Spout spout; //SPOUT

PImage tex; //SPOUT
PGraphics sol;
PGraphics planeta;
PFont font;
ArrayList<SkeletonData> bodies;
ArrayList<Point> points;
PImage img;
float sXj1;
float sYj1;
float sXj2;
float sYj2;
float sXj3;
float sYj3;
float sXj4;
float sYj4;
float sXj5;
float sYj5;
float xpos;
float ypos;
float zxpos;
float zypos;
float dw;
float hue = 174;
float hueSpeed = 0.2;
float x = 1;
float speed = 1;
float accel = 0.1;
float[] gray;
float rotation; 
float anglerotation = 0; 
int status;
int anzahl; //red
int hoechstens; //red
int p; //punkt
int meistens; //red
int lx, ly; //red

Punkt P[]; //red
Star[] stars = new Star[1000];

void setup()
{
  size(800, 600, P3D);
  //size(displayWidth, displayHeight, P3D);
  //size(1920, 1080, P3D);
  colorMode(HSB, 360, 255, 255, 255);
  background(0, 0, 255);
  frameRate(60);
  smooth();
  noCursor();
  kinect = new PKinect(this);
  bodies = new ArrayList<SkeletonData>();
  points = new ArrayList<Point>();
  spout = new Spout(); //SPOUT
  spout.initSender("Spout Processing", width, height); //SPOUT

  osc = new OscP5(this, 12000); //TALKS listening for incoming messages at port 12000

    maxmsp = new NetAddress("127.0.0.1", 57120); //TALKS sending messages to port 57120

    anzahl=10000; //red
  P= new Punkt[anzahl]; //red
  hoechstens=100; //red
  sol = createGraphics(displayWidth, 550, P2D);
  planeta = createGraphics(displayWidth, 550, P2D);
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
  gray = new float[height];
}

void draw() {

  if (status==0)screen0();
  if (status==1)screen1();
  if (status==2)screen2();
  if (status==3)screen3();
  if (status==4)screen4();
  if (status==5)screen5();
  if (status==6)screen6();
  if (status==7)screen7();
  if (status==8)screen8();
  if (status==9)screen9();
  if (status==10)screen10();

  spout.sendTexture(); //SPOUT
}

/*VOIDSCREEN0-VOIDSCREEN0-VOIDSCREEN0-VOIDSCREEN0-VOIDSCREEN0-VOIDSCREEN0-VOIDSCREEN0-VOIDSCREEN0-*/

void screen0() {
  background(0, 0, 255);
}

/*VOIDSCREEN1-VOIDSCREEN1-VOIDSCREEN1-VOIDSCREEN1-VOIDSCREEN1-VOIDSCREEN1-VOIDSCREEN1-VOIDSCREEN1-*/

void screen1() {
  float closestX; //closestLine
  float closestY; //closestLine
  float interpolX = lerp(sXj2, sXj3, 0.6f); //closestLine
  float interpolY = lerp(sYj2, sYj3, 0.6f);  //closestLine
  closestX = sXj3; //closestLine
  closestY = sYj3; //closestLine
  //translate(width/2+sXj2, height+sYj2);
  // strokeWeight(0.5); //red
  hue = hue + hueSpeed;
  if (hue > 321.) {
    hueSpeed = -0.2;
  }
  if (hue < 174.) {
    hueSpeed = 0.2;
  } 
  //println(hue);

  for (int i=0; i<bodies.size (); i++) {
    drawSkeleton(bodies.get(i));
    // drawPosition(bodies.get(i));
  }
  //if (dist(sXj2, sYj2, sXj3, sYj3) < 100) { //closestLine //red
  lx=int(sXj2); //red
  ly=int(sYj2); //red
  P[p]=new Punkt(p); //red
  P[p].desenhaLinie(); //red
  p=(p+1)%anzahl; //red
  //}
  stroke(hue, hue, 150, random(5, 10));
}

/*VOIDSCREEN2-VOIDSCREEN2-VOIDSCREEN2-VOIDSCREEN2-VOIDSCREEN2-VOIDSCREEN2-VOIDSCREEN2-VOIDSCREEN2-*/

void screen2() {
  strokeWeight(1);
  translate(width/2, 0);
  lights();
  rotateY(x);
  x = x + 0.033;
  hue = hue + hueSpeed;
  if (hue > 321.) {
    hueSpeed = -0.2;
  }
  if (hue < 174.) {
    hueSpeed = 0.2;
  }

  for (int i=0; i<bodies.size (); i++) {
    drawSkeleton(bodies.get(i));
    points.add(new Point());
    Point pointz = (Point) points.get(points.size() - 1);
    // pointz.setValues(sXj1 - width/2, sYj1 , sXj2 - width/2, sYj2);
  }


  for (int i = points.size () - 1; i >= 0; i--) {
    Point dots = (Point) points.get(i);
    dots.display();

    if (dots.lifespan<0) {
      points.remove(0);
    }
  }
}

/*VOIDSCREEN3-VOIDSCREEN3-VOIDSCREEN3-VOIDSCREEN3-VOIDSCREEN3-VOIDSCREEN3-VOIDSCREEN3-VOIDSCREEN3-*/

void screen3() {

  background(0);
  for (int i=0; i<bodies.size (); i++) {
    drawSkeleton(bodies.get(i));
  }
  translate(width/2+map(sXj2, 0., 1., 0., 800.), height/2+map(sYj2, 0., 1., 0., 800.));

  accel = map(sXj3, 0., 0.5, 0., 100.);  
  speed = accel; 

  /* if (speed > 5.) {
   accel = -accel;
   }
   if (speed < 0.01) {
   accel = accel;
   } 
   */


  hue = hue + hueSpeed;

  if (hue > 321.) {
    hueSpeed = -0.2;
  }
  if (hue < 174.) {
    hueSpeed = 0.2;
  } 

  for (int i = 0; i < stars.length; i++) {
    stars[i].update();
    stars[i].show();
  }
}
/*VOIDSCREEN4-VOIDSCREEN4-VOIDSCREEN4-VOIDSCREEN4-VOIDSCREEN4-VOIDSCREEN4-VOIDSCREEN4-VOIDSCREEN4-*/

void screen4() {

  float lx, ly, rx, ry; //TALKS

  rx=map(sXj2, 0., 1.0, 0, width);
  ry=map(sYj2, 0., 1.0, 0, height);
  lx=map(sXj3, 0., 1.0, 0, width);
  ly=map(sYj3, 0., 1.0, 0, height);
  OscMessage msg = new OscMessage("/coorX"); //TALKS
  msg.add(lx); //TALKS
  msg.add(ly); //TALKS
  msg.add(rx); //TALKS
  msg.add(ry); //TALKS
  osc.send(msg, maxmsp); //TALKS
  // SOLES
  //  zoom =-map(pote2ObjC, 0, 126, 0, width*9);
  //  translate (0, 0, zoom);
  rotation = 0.01;
  anglerotation+=rotation;
  for (int i=0; i<bodies.size (); i++) {
    drawSkeleton(bodies.get(i));
  }

  for (int i = 0; i < 33; i++) {
    gray[i] = random(width);

    translate(width/2, height/2);
    rotate(anglerotation+radians(map(sXj1, 0., 1.0, 0, width))); //Angulo de Rotacion
    translate(-width/2, -height/2);

    stroke(map(sXj2, 0., 1.0, 0, 360), hue, 150, random(5, 200));
    line(width/2+map(sXj2, 0., 1.0, 0, width), height/2+map(sYj2, 0., 1.0, 0, height), -i-random(255), gray[i]); // BALANCE_0

    stroke(map(sXj3, 0., 1.0, 0, 255), hue, 150, random(5, 200));
    line(width/2+map(sXj3, 0., 1.0, 0, width), height/2+map(sYj3, 0., 1.0, 0, height), -i-random(255), gray[i]); // BALANCE_255
  }
}

/*VOIDSCREEN5-VOIDSCREEN5-VOIDSCREEN5-VOIDSCREEN5-VOIDSCREEN5-VOIDSCREEN5-VOIDSCREEN5-VOIDSCREEN5-*/

void screen5() {
  background(0);
}

/*VOIDSCREEN6-VOIDSCREEN6-VOIDSCREEN6-VOIDSCREEN6-VOIDSCREEN6-VOIDSCREEN6-VOIDSCREEN6-VOIDSCREEN6-*/

void screen6() {
}

/*VOIDSCREEN7-VOIDSCREEN7-VOIDSCREEN7-VOIDSCREEN7-VOIDSCREEN7-VOIDSCREEN7-VOIDSCREEN7-VOIDSCREEN7-*/

void screen7() {

  // PROBANDO PGRAPHICS I
  //  zoom =-map(pote2ObjC, 0, 126, 0, width*9);
  //  translate (0, 0, zoom);
  rotation = 0.1;
  anglerotation+=rotation;

  //  background(30, 75, 4.7);

  background(0, 0);


  for (int i = 0; i < 33; i++) {
    gray[i] = random(width);
    sol.beginDraw();
    for (int j = 0; j < stars.length; j++) {
      stars[j].update();
      stars[j].show();
      sol.endDraw();

      //    if (status != 7) sol.clear(); // tratando de limpiar el buffer
    }
    planeta.beginDraw();
    //  planeta.background(0, 0);
    planeta.background(0, 0);
    planeta.noStroke();
    planeta.fill(0, 255, 0);
    planeta.ellipse(mouseX, mouseY, 20, 20);
    planeta.endDraw();

    //    image(sol.get(0, 0, width,height), width, 0);
    //    image(planeta.get(0, 0, width,height), height, 0);
    image(sol, 0, 0, width, height); 
    image(planeta, 0, 0, width, height);
  }
}
/*VOIDSCREEN8-VOIDSCREEN8-VOIDSCREEN8-VOIDSCREEN8-VOIDSCREEN8-VOIDSCREEN8-VOIDSCREEN8-VOIDSCREEN8-*/

void screen8() {
  // SOLES
  //  zoom =-map(pote2ObjC, 0, 126, 0, width*9);
  //  translate (0, 0, zoom);
  rotation = 0.01;
  anglerotation+=rotation;
  for (int i=0; i<bodies.size (); i++) {
    drawSkeleton(bodies.get(i));
  }

  for (int i = 0; i < 33; i++) {
    gray[i] = random(width);

    translate(width/2, height/2);
    rotate(anglerotation+radians(map(sXj1, 0., 1.0, 0, width))); //Angulo de Rotacion
    translate(-width/2, -height/2);

    stroke(map(sXj2, 0., 1.0, 0, 360), hue, 150, random(5, 200));
    line(width/2+map(sXj2, 0., 1.0, 0, width), height/2+map(sYj2, 0., 1.0, 0, height), -i-random(255), gray[i]); // BALANCE_0

    stroke(map(sXj3, 0., 1.0, 0, 255), hue, 150, random(5, 200));
    line(width/2+map(sXj3, 0., 1.0, 0, width), height/2+map(sYj3, 0., 1.0, 0, height), -i-random(255), gray[i]); // BALANCE_255
  }
}
/*VOIDSCREEN9-VOIDSCREEN9-VOIDSCREEN9-VOIDSCREEN9-VOIDSCREEN9-VOIDSCREEN9-VOIDSCREEN9-VOIDSCREEN9-*/

void screen9() {
  float closestX; //closestLine
  float closestY; //closestLine
  float interpolX = lerp(sXj2, sXj3, 0.6f); //closestLine
  float interpolY = lerp(sYj2, sYj3, 0.6f);  //closestLine
  closestX = sXj3; //closestLine
  closestY = sYj3; //closestLine


  background(0);
  translate(width/2-sXj2+(sXj2+2), height/2-sYj2+(sYj2*2));
  stroke(hue, hue, 150, random(5, 10));
  for (int i=0; i<bodies.size (); i++) {
    drawSkeleton(bodies.get(i));
  }
  hue = hue + hueSpeed;
  if (hue > 321.) {
    hueSpeed = -0.2;
  }
  if (hue < 174.) {
    hueSpeed = 0.2;
  } 
  lx=int(sXj2); //red
  ly=int(sYj2); //red
  P[p]=new Punkt(p); //red
  P[p].desenhaLinie(); //red
  p=(p+1)%anzahl; //red
  for (int i = 0; i < stars.length; i++) {
    stars[i].update();
    stars[i].show();
  }
}

/*VOIDSCREEN10-VOIDSCREEN10-VOIDSCREEN10-VOIDSCREEN10-VOIDSCREEN10-VOIDSCREEN10-VOIDSCREEN10-VOIDSCREEN10-*/

void screen10() {
  background(map(xpos, 0., 1.0, 0., 360.), map(ypos, 0., 1.0, 0., 255.), 200);
  image(kinect.GetMask(), 0, 0, width, height);
  for (int i=0; i<bodies.size (); i++) 
  {
    drawSkeleton(bodies.get(i));
    drawPosition(bodies.get(i));
  }

  stroke (#F20594); // ROJO CABEJA
  fill (#F20594);
  ellipse (map(sXj1, 0., 1.0, 0., width), map(sYj1, 0., 1.0, 0., height), 10, 10);

  stroke (#05A1F2); // CELESTE MANO DERECHA
  fill (#05A1F2);
  ellipse (map(sXj2, 0., 1.0, 0., width), map(sYj2, 0., 1.0, 0., height), 10, 10);

  stroke (#CF14DE); // MORADO MANO IZQUIERDA
  fill (#CF14DE);
  ellipse (map(sXj3, 0., 1.0, 0., width), map(sYj3, 0., 1.0, 0., height), 10, 10);

  stroke (#7E7A7E); // PLOMO PIE DERCEHO
  fill (#7E7A7E);
  ellipse (map(sXj4, 0., 1.0, 0., width), map(sYj4, 0., 1.0, 0., height), 10, 10);

  stroke (#EA4E4E); // FLAN PIE IZQUIERDO
  fill (#EA4E4E);
  ellipse (map(sXj5, 0., 1.0, 0., width), map(sYj5, 0., 1.0, 0., height), 10, 10);

  stroke (#E4F500); // AMARILLO OMBLIGO
  fill (#E4F500);
  ellipse (map(xpos, 0., 1.0, 0., width), map(ypos, 0., 1.0, 0., height), 10, 10);

  stroke (#00FF79); // VERDE OMBLIGO 
  noFill();
  ellipse (map(zxpos, 0., 1.0, 0., width), map(zypos, 0., 1.0, 0., height), 30, 30);
} 

/*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*/

void drawPosition(SkeletonData _s) 
{
  //noStroke();
  //fill(0, 100, 255);
  String s1 = str(_s.dwTrackingID);
  text(s1, _s.position.x*width/2, _s.position.y*height/2);

  xpos = +_s.position.x;
  ypos = +_s.position.y;

  zxpos = _s.position.x;
  zypos = _s.position.y;
}
void drawSkeleton(SkeletonData _s) 
{
  // 5 PUNTOS

  DrawBone(_s, PKinect.NUI_SKELETON_POSITION_HEAD, 
  PKinect.NUI_SKELETON_POSITION_HAND_RIGHT, 
  PKinect.NUI_SKELETON_POSITION_HAND_LEFT, 
  PKinect.NUI_SKELETON_POSITION_FOOT_RIGHT, 
  PKinect.NUI_SKELETON_POSITION_FOOT_LEFT);

  // Body
  /*
  DrawBone(_s, PKinect.NUI_SKELETON_POSITION_HEAD, PKinect.NUI_SKELETON_POSITION_SHOULDER_CENTER);
   DrawBone(_s, PKinect.NUI_SKELETON_POSITION_SHOULDER_CENTER, PKinect.NUI_SKELETON_POSITION_SHOULDER_LEFT);
   DrawBone(_s, PKinect.NUI_SKELETON_POSITION_SHOULDER_CENTER, PKinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT);
   DrawBone(_s, PKinect.NUI_SKELETON_POSITION_SHOULDER_CENTER, PKinect.NUI_SKELETON_POSITION_SPINE);
   DrawBone(_s, PKinect.NUI_SKELETON_POSITION_SHOULDER_LEFT, PKinect.NUI_SKELETON_POSITION_SPINE);
   DrawBone(_s, PKinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT, PKinect.NUI_SKELETON_POSITION_SPINE);
   DrawBone(_s, PKinect.NUI_SKELETON_POSITION_SPINE, PKinect.NUI_SKELETON_POSITION_HIP_CENTER);
   DrawBone(_s, PKinect.NUI_SKELETON_POSITION_HIP_CENTER, PKinect.NUI_SKELETON_POSITION_HIP_LEFT);
   DrawBone(_s, PKinect.NUI_SKELETON_POSITION_HIP_CENTER, PKinect.NUI_SKELETON_POSITION_HIP_RIGHT);
   DrawBone(_s, PKinect.NUI_SKELETON_POSITION_HIP_LEFT, PKinect.NUI_SKELETON_POSITION_HIP_RIGHT);
   
   // Left Arm
   DrawBone(_s, PKinect.NUI_SKELETON_POSITION_SHOULDER_LEFT, PKinect.NUI_SKELETON_POSITION_ELBOW_LEFT);
   DrawBone(_s, PKinect.NUI_SKELETON_POSITION_ELBOW_LEFT, PKinect.NUI_SKELETON_POSITION_WRIST_LEFT);
   DrawBone(_s, PKinect.NUI_SKELETON_POSITION_WRIST_LEFT, PKinect.NUI_SKELETON_POSITION_HAND_LEFT);
   
   //println(PKinect.NUI_SKELETON_POSITION_WRIST_LEFT);
   
   // Right Arm
   DrawBone(_s, PKinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT, PKinect.NUI_SKELETON_POSITION_ELBOW_RIGHT);
   DrawBone(_s, PKinect.NUI_SKELETON_POSITION_ELBOW_RIGHT, PKinect.NUI_SKELETON_POSITION_WRIST_RIGHT);
   DrawBone(_s, PKinect.NUI_SKELETON_POSITION_WRIST_RIGHT, PKinect.NUI_SKELETON_POSITION_HAND_RIGHT);
   
   // Left Leg
   DrawBone(_s, PKinect.NUI_SKELETON_POSITION_HIP_LEFT, PKinect.NUI_SKELETON_POSITION_KNEE_LEFT);
   DrawBone(_s, PKinect.NUI_SKELETON_POSITION_KNEE_LEFT, PKinect.NUI_SKELETON_POSITION_ANKLE_LEFT);
   DrawBone(_s, PKinect.NUI_SKELETON_POSITION_ANKLE_LEFT, PKinect.NUI_SKELETON_POSITION_FOOT_LEFT);
   
   // Right Leg
   DrawBone(_s, PKinect.NUI_SKELETON_POSITION_HIP_RIGHT, PKinect.NUI_SKELETON_POSITION_KNEE_RIGHT);
   DrawBone(_s, PKinect.NUI_SKELETON_POSITION_KNEE_RIGHT, PKinect.NUI_SKELETON_POSITION_ANKLE_RIGHT);
   DrawBone(_s, PKinect.NUI_SKELETON_POSITION_ANKLE_RIGHT, PKinect.NUI_SKELETON_POSITION_FOOT_RIGHT);
   */
}

void DrawBone(SkeletonData _s, int _j1, int _j2, int _j3, int _j4, int _j5) {

  if (_s.skeletonPositionTrackingState[_j1] != PKinect.NUI_SKELETON_POSITION_NOT_TRACKED &&
    _s.skeletonPositionTrackingState[_j2] != PKinect.NUI_SKELETON_POSITION_NOT_TRACKED &&
    _s.skeletonPositionTrackingState[_j3] != PKinect.NUI_SKELETON_POSITION_NOT_TRACKED &&
    _s.skeletonPositionTrackingState[_j4] != PKinect.NUI_SKELETON_POSITION_NOT_TRACKED &&
    _s.skeletonPositionTrackingState[_j5] != PKinect.NUI_SKELETON_POSITION_NOT_TRACKED) {

    sXj1 = _s.skeletonPositions[_j1].x;
    sYj1 = +_s.skeletonPositions[_j1].y;
    sXj2 = +_s.skeletonPositions[_j2].x;  
    sYj2 = +_s.skeletonPositions[_j2].y;
    sXj3 = +_s.skeletonPositions[_j3].x;  
    sYj3 = +_s.skeletonPositions[_j3].y;
    sXj4 = +_s.skeletonPositions[_j4].x;  
    sYj4 = +_s.skeletonPositions[_j4].y;
    sXj5 = +_s.skeletonPositions[_j5].x;  
    sYj5 = +_s.skeletonPositions[_j5].y;
  }
}

void appearEvent(SkeletonData _s) 
{
  if (_s.trackingState == PKinect.NUI_SKELETON_NOT_TRACKED) 
  {
    return;
  }
  synchronized(bodies) {
    bodies.add(_s);
  }
}

void disappearEvent(SkeletonData _s) 
{
  synchronized(bodies) {
    for (int i=bodies.size ()-1; i>=0; i--) 
    {
      if (_s.dwTrackingID == bodies.get(i).dwTrackingID) 
      {
        bodies.remove(i);
      }
    }
  }
}

void moveEvent(SkeletonData _b, SkeletonData _a) 
{
  if (_a.trackingState == PKinect.NUI_SKELETON_NOT_TRACKED) 
  {
    return;
  }
  synchronized(bodies) {
    for (int i=bodies.size ()-1; i>=0; i--) 
    {
      if (_b.dwTrackingID == bodies.get(i).dwTrackingID) 
      {
        bodies.get(i).copy(_a);
        break;
      }
    }
  }
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/currentStatus")==true) {
    status = theOscMessage.get(0).intValue();
    println("status" + status);
  }
}



void keyPressed() {
  if (key=='º')status=0;
  if (key=='1')status=1;
  if (key=='2')status=2;
  if (key=='3')status=3;
  if (key=='4')status=4;
  if (key=='5')status=5;
  if (key=='6')status=6;
  if (key=='7')status=7;
  if (key=='8')status=8;
  if (key=='9')status=9;
  if (key=='0')status=10;

  if (key==32) { //SPACE
    saveFrame("pic_####.png");
    println("imagengrabada");
  }
  if (key == 'r') {
    setup();
  }
}
void exit() {
  // CLOSE THE SPOUT SENDER HERE
  spout.closeSender();
  super.exit();
}

