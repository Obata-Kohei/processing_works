float scale1 = 0.01;
float scale2 = 0.1;
float scale3 = 1;

float p,c;

void setup() {
  size(800, 800);
  frameRate(60);
  colorMode(HSB, 1, 1, 1);
}

void draw() {
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      p = noise(scale1 * x, scale1 * y, sqrt(frameCount));
      stroke(p, 1, 1);
      point(x, y);
    }
  }
}
