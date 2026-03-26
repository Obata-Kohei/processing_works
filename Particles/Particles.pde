int numParticles = 1000;
Particle[] particles = new Particle[numParticles];

void setup() {
  size(1000, 600);
  colorMode(HSB, 360, 100, 100, 100);
  for (int i = 0; i < numParticles; i++) {
    float x = random(width);
    float y = random(height);
    float r = 10;
    float hue = random(200, 250);
    particles[i] = new Particle(x, y, r, hue);
  }
}

void draw() {
  background(0, 0, 0, 20);
  for (int i = 0; i < numParticles; i++) {
    particles[i].update();
    particles[i].display();
  }
}

class Particle {
  float x, y, r, hue;
  float speedX, speedY;
  float accelerationX, accelerationY;
  
  Particle(float x, float y, float r, float hue) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.hue = hue;
    this.speedX = random(-0.1, 0.1);
    this.speedY = random(-0.1, 0.1);
  }
  
  void update() {
    speedX += random(-0.08, 0.08);
    speedY += random(-0.08, 0.08);
    x += speedX;
    y += speedY;
    if (x < 0 || x > width) {
      speedX *= -1;
      accelerationX *= -0.5;
    }
    if (y < 0 || y > height) {
      speedY *= -1;
      accelerationY *= -0.5;
    }
  }
  
  void display() {
    fill(hue, 80, 80, 80);
    noStroke();
    ellipse(x, y, r, r);
  }
}
