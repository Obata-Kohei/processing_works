
float x = 0.01;
float y = 0;
float z = 0;
float dt = 0.01;
float dx, dy, dz;

float p = 10;
float r = 28;
float b = 8.0/3.0;




void setup() {
  
  size(800, 600, P3D);
  frameRate(60);
  background(0);
  
}

void draw() {

  translate(width/2, height/2);
  scale(5);
  background(0); //軌跡を消す
  
  dx = (-p*x + p*y) * dt;
  dy = (-x*z + r*x - y) * dt;
  dz = (x*y - b*z) * dt;
  
  stroke(150);
  point(x, y, z);
  
  x = x + dx;
  y = y + dy;
  z = z + dz;
  stroke(255);
  point(x, y, z);
  
  if (key == 's') {
    noLoop();
  }
  
}
