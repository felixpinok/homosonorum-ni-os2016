class Punkt { //red
  int id;
  float lx, ly, rx, ry;
  //int px, py; //TALKS
  int[] strich;
  int QLinie;

  Punkt(int p) {
    id=p;
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
    strich=new int[id];

    for (int i=0; i<id; i++) {
      float tdist = dist(P[i].rx, P[i].ry, rx, ry);
      if (tdist<hoechstens && tdist>5) {
        strich[QLinie]=i;
        QLinie++;
      }
    }
  }
  void desenhaLinie() {
    for (int i=0; i<QLinie; i++) {
      line(rx, ry, P[strich[i]].rx, P[strich[i]].ry);
    }
  }
}

