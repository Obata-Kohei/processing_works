float g = 9.8066;

float m1 =10;
float m2 = 5;

float l1 = 100;
float l2 = 150;

float theta1 = PI/2;
float theta2 = PI/6;

float dt = 0.02;

float x1, y1, x2, y2;
float ddtheta1, ddtheta2;
float dtheta1, dtheta2;


void setup() {
  
  size(600, 600);
  background(255);
  frameRate(144);
  
}

void draw() {
  
  translate(width/2, height/4);
  background(255);
  
  ddtheta1 = (- m2*l2*ddtheta2*cos(theta1-theta2) - m2*l2*dtheta2*dtheta2*sin(theta1-theta2) - (m1+m2)*g*sin(theta1))/((m1+m2)*l1);
  ddtheta2 = (m2*l1*dtheta1*dtheta1*sin(theta1-theta2) - m2*l1*ddtheta1*cos(theta1-theta2) - m2*g*sin(theta2))/(m2*l2);
  
  dtheta1 += ddtheta1 * dt;
  dtheta2 += ddtheta2 * dt;
  
  theta1 += dtheta1 * dt;
  theta2 += dtheta2 * dt;
  
  x1 = l1 * sin(theta1);
  y1 = l1 * cos(theta1);
  
  x2 = x1 + l2 * sin(theta2);
  y2 = y1 + l2 * cos(theta2);
  
  stroke(0);
  fill(0);
  line(0, 0, x1, y1);
  circle(x1, y1, 10);
  line(x1, y1, x2, y2);
  circle(x2, y2, 10);
  stroke(255, 0, 0);
  
  
}
  
