int N = 10;

float g = 9.8066;
float thetaMax = PI/12;
float phase = 0.0;

float t = 0;
float dt = 0.3;

void pendulum (float l, float H, float S, float B) {
  
  float theta = thetaMax * cos(sqrt(g/l) * t + phase);
  float x = l * sin(theta);
  float y = l * cos(theta);
  stroke(H, S, B);
  line(0, 0, x, y);
  circle(x, y, 10);
  fill(H, S, B);
}

void setup() {
  size(400, 600);
  scale(7);
  frameRate(120);
}

void draw() {
  translate(width/2, 0);
  background(255);
  colorMode(HSB);
  
  for (int i = 1; i < N + 1 ; i++) {
    pendulum(map(i, 1, N+1, height*60/100, height*70/100), map(i, 1, N, 0, 360) -30, 150, 220);
    
  }
  
  t = t + dt;

}


  
  
