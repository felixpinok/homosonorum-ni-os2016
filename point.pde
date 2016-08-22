class Point {
  float a, b, x, y;
  float lx, ly, rx, ry; //TALKS
  float lifespan = 10;
  Point() {
    lifespan = lifespan - 1;
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
  }

  void setValues(float apos, float bpos, float xpos, float ypos) {
    lx = apos;
    ly = bpos;
    rx = xpos;
    ry = ypos;
  }
  
  boolean isDead() {
    if (lifespan <= 0) {
      return true;
    }
    else {
      return false;
    }
  }

  void display() {
    stroke(hue, random(150, 200), map(sYj3, 0., 1.0, 0, 255), 2);
    line(lx-width/4, ly, rx-width/4, ry);
  }
}

