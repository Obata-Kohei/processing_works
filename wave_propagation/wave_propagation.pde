float dx = 1;
float dy = 1;
float a;

// 複数の波源の位置
PVector[] sources;

void setup() {
  size(800, 800);
  background(255);
  translate(width/2, height/2);
  
  // 波源の位置（中心からの相対座標）
  sources = new PVector[2];
  sources[0] = new PVector(-150, 0);  // 左
  sources[1] = new PVector(150, 0);   // 右

  float maxDist = dist(0, 0, width/2, height/2);
  float baseFreq = 0.06;

  for (float x = -width/2; x < width/2; x += dx) {
    for (float y = -height/2; y < height/2; y += dy) {
      float sum = 0;

      for (int i = 0; i < sources.length; i++) {
        float r = dist(x, y, sources[i].x, sources[i].y);
        float wave = sin(r * baseFreq);
        sum += wave;
      }

      // 合成波：平均 or スケーリング（ここでは平均）
      float combined = sum / sources.length;
      
      // 合成波を透明度にマッピング
      a = map(combined, -1, 1, 0, 255);
      
      //stroke(0, a);
      stroke(a);
      point(x, y);
    }
  }
}

void draw() {
}
