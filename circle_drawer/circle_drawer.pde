float[][] params;  // float[n][2], param[i][0] = amp [px], param[i][1] = freq [Hz]
float t, dt;  // dt [sec]
float[] x, y;
float integralX, integralY;
ArrayList<PVector> path;  // 軌跡を保存するリスト

void setup() {
  size(1280, 920);
  background(0);
  
  params = generateRandomParams(5
  , 10, 100, 0.1, 2.0);

  t = 0;
  dt = 1.0 / 60.0;  // フレームレートが 60 fps と仮定
  
  x = new float[params.length];
  y = new float[params.length];
  
  path = new ArrayList<PVector>();  // 軌跡を記録
}

void draw() {
  background(0);  // 毎フレーム消して描き直す
  translate(width / 2, height / 2);
  
  float prevX = 0;
  float prevY = 0;
  
  for (int i = 0; i < params.length; i++) {
    float amp = params[i][0];
    float freq = params[i][1];
    
    float angle = TWO_PI * freq * t;
    float dx = amp * cos(angle);
    float dy = amp * sin(angle);
    
    x[i] = prevX + dx;
    y[i] = prevY + dy;
    
    // 円の描画
    stroke(100);
    noFill();
    ellipse(prevX, prevY, amp * 2, amp * 2);  // 円
    
    // 半径線の描画
    stroke(255);
    line(prevX, prevY, x[i], y[i]);
    
    prevX = x[i];
    prevY = y[i];
  }
  
  // 最終点の軌跡を保存
  path.add(new PVector(prevX, prevY));

  // 軌跡の描画
  stroke(255, 255, 0);
  noFill();
  beginShape();
  for (PVector p : path) {
    vertex(p.x, p.y);
  }
  endShape();
  
  t += dt;
}
