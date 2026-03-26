import java.util.Arrays;

color[] pal;

void setup() {
  size(512, 512);
  frameRate(60);

  float[] prob = {0.7, 0.3, 0.1, 0.05, 0.05, 0.1, 0.07, 0.03, 0.1};
  Arrays.sort(prob);
  float[] probIntegral = new float[prob.length];
  float scale = 10;

  for (int i = 0; i < probIntegral.length; i++) {
    float sum = 0;
    for (int j = i; j >= 0; j--) {
      sum += prob[j];
    }
    probIntegral[i] = sum;
  }
  
  pal = new color[prob.length];
  for (int i = 0; i < prob.length; i++) {
    pal[i] = (int) map(i, 0, prob.length, 255, 0);
  }
  
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      float p = noise(scale * x, scale * y);
      for (int i = 0; i < probIntegral.length - 1; i++) {
        if (probIntegral[i] <= p && p <= probIntegral[i + 1]) {
          stroke(pal[i]);
          point(x, y);
        }
      }
    }
  }
}

void draw() {
  float[] prob = {0.3, 0.2, 0.1, 0.05, 0.05, 0.1, 0.07, 0.03, 0.1};
  float[] probIntegral = new float[prob.length];
  float scale = 0.05;

  for (int i = 0; i < probIntegral.length; i++) {
    float sum = 0;
    for (int j = i; j >= 0; j--) {
      sum += prob[j];
    }
    probIntegral[i] = sum;
  }
  
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      float p = noise(scale * x, scale * y, sqrt(frameCount));
      for (int i = 0; i < probIntegral.length - 1; i++) {
        if (probIntegral[i] <= p && p <= probIntegral[i + 1]) {
          stroke(pal[i]);
          point(x, y);
        }
      }
    }
  }
}
