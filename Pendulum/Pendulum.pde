float g = 9.8066;
float l = 400;
float thetaMax = PI/12;
float phase = 0.0;

float theta, x, y;
float t;
float dt = 0.1;


void setup() {
  size(400, 500);
  scale(7);
  frameRate(90);
}

void draw() {
  translate(width/2, 0);
  background(255);
  theta = thetaMax * cos(sqrt(g/l) * t + phase);
  x = l * sin(theta);
  y = l * cos(theta);
  stroke(0);
  line(0, 0, x, y);
  circle(x, y, 40);
  t = t + dt;
  
}
