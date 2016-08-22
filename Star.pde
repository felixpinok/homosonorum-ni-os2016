class Star {
  float x;
  float y;
  float z;
  float lx, ly, rx, ry; //TALKS
  float tinte;

  float pz;

  Star() {
    x = random(-width, width);
    y = random(-height, height);
    z = random(width);
    pz = z;

  }
  void update() {
    z = z - speed;
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
    if (z < 1) {
      z = width;
      x = random(-width, width);
      y = random(-height, height);
      pz = z;
    }
  }
  void show() {

    noStroke();

    float sx = map(x / z, 0, 1, 0, width);
    float sy = map(y / z, 0, 1, 0, height);

    float r = map(z, 0, width, 16, 0);
    ellipse(sx, sy, r, r);

    float ppx = map(x / pz, 0, 1, 0, width);
    float ppy = map(y / pz, 0, 1, 0, height);

    pz = z;

    fill(hue, 100, 200, 255);
    line(ppx, ppy, sx, sy);
  }
}

