// study_of_perlin_noise.pde

float dia;
int matW, matH;
float[][] mat;
int r, g, b;
float nx, ny, nf;
float hue, sat, val;
float dulation;
float timeOffset = 0;
int cx, cy;
float circleFreq;
float valFreq;
float T, beta;

void setup() {
  size(800, 800);
  //fullScreen();
  frameRate(45);
  colorMode(HSB, 255);
  noiseSeed((int)random(10000)); // 毎回異なるノイズパターン
  background(0);

  matW = 50; matH = 50;
  mat = new float[matH][matW];
  dia = width / (2*matW);
  
  cx = width / 2; cy = height / 2;
  circleFreq = 0.04;
  valFreq = 0.02;
  T = 0.5; beta = 1;
}

void draw() {
  background(255);
  
  val = map(sin(valFreq * frameCount - PI/2), 0, 1, 0, 255);
  noStroke();
  fill(0, 0, val);
  circle(cx, cy, width / 2);
  if (val >= 253) {
    cx = (int) random(width / 4, 3 * width / 4);
    cy = (int) random(height / 4, 3 * height / 4);
  }

  for (int x=0; x<matW; x++) {
    for (int y=0; y<matH; y++) {
      nx = noise(x * 0.1 + y * random(-0.02, 0.02), x * 0.1 + y * random(-0.02, 0.02));
      ny = noise(y * 0.1 + x * random(-0.02, 0.02), x * 0.1 + x * random(-0.02, 0.02));
      nf = noise(frameCount * circleFreq, sqrt(x*y));

      hue = map(nx, 0, 1, 0, 255);
      sat = map(ny, 0, 1, 110, 220);
      val = map(nf, 0, 1, 10, 130);
      fill(0, 0, val);
      noStroke();
      circle((1+2*x)*dia, (1+2*y)*dia, dia * noise(x, y, nf) + 1.4*dia);
    }
  }
  
  //if (frameCount <= frameRate * 60*3) saveFrame("frames/frame####.png");
}
