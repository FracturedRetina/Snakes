int cvsW = 500;
int cvsH = 500;
final int numSnakes = 15;
Snake[] snakes = new Snake[numSnakes];

void setup() {
  boolean fullscreen = false;
  
  if (fullscreen) {
    size(displayWidth, displayHeight);
    cvsW = displayWidth;
    cvsH = displayHeight;
  } else {
    size(cvsW, cvsH);
  }
  
  for (int i = 0; i < numSnakes; i++) {
    snakes[i] = new Snake(50, 5, 30, cvsW / 2, cvsH / 2);
  }
  stroke(255);
  noLoop();
  
  loop();
}

void draw() { 
  background(0);
  
  for (int i = 0; i < numSnakes; i++) {
    snakes[i].update();
    snakes[i].draw();
  }
}

class Snake {
  float angle = random(360);
  int links;
  float speed;
  float curve;
  float[] x;
  float[] y;
  color c;
  
  Snake(int numLinks, int movSpeed, float steer, float initX, float initY) {
    links = numLinks;
    x = new float[numLinks];
    y = new float[numLinks];
    c = color(255);
    speed = movSpeed;
    curve = steer;
    
    for (int i = 0; i < numLinks; i++) {
      x[i] = initX;
      y[i] = initX;
    }
  }
  
  void update() {
    float[] newX = new float[links];
    float[] newY = new float[links];
    
    if (random(1) > 0.5) {
      angle -= random(curve);
    } else {
      angle += random(curve);
    }
    
    newX[0] = x[0] + cos(angle * (PI / 180)) * speed;
    newY[0] = y[0] + sin(angle * (PI / 180)) * speed;
    
    if (newX[0] < -1) {
      newX[0] = -1;
    }
    if (newY[0] < -1) {
      newY[0] = -1;
    }
    if (newX[0] > 500) {
      newX[0] = cvsW;
    }
    if (newY[0] > 500) {
      newY[0] = cvsH;
    }
    
    //shift
    for (int i = 0; i < links - 1; i++) {
      newX[i + 1] = x[i];
      newY[i + 1] = y[i];
    }
    
    x = newX;
    y = newY;
    
//    print("\nx [");
//    for (int i = 0; i < links; i++) {
//      print(x[i]);
//      print(",");
//    }
//    print("]\ny [");
//    for (int i = 0; i < links; i++) {
//      print(y[i]);
//      print(",");
//    }
//    print("]\n");
  }
  
  void draw() {
    stroke(c);
    for (int i = 0; i < links - 1; i++) {
      stroke(255);
      line(x[i], y[i], x[i + 1], y[i + 1]);
    }
  }
}
