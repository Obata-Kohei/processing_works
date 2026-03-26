int cols, rows;
int scale = 10;  // ベクトル場のスケール
Particle[] particles;
PVector[][] vectorfield;

void setup() {
  size(1000, 800);
  colorMode(HSB, 255);
  cols = width / scale;
  rows = height / scale;
  
  vectorfield = new PVector[cols][rows];
  particles = new Particle[10000];  // 1000個の粒子
  
  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle();
  }
  
  generateVectorField2D();  // 任意のベクトル場を設定
  background(0);
}

void draw() {
    //background(0); // 毎フレーム背景をクリア
    fill(0, 10); rect(0, 0, width, height);  // 粒子の軌跡を少し残す
    for (Particle p : particles) {
        p.follow(vectorfield);
        p.update();
        p.show();
        p.edges();
    }
}

// 任意のベクトル場を設定
void generateVectorField2D() {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      float x = map(i, 0, cols, -width/2, width/2);
      float y = map(j, 0, rows, -height/2, height/2);
      float freq = 0.1;
      float angle = sin(freq * x*y) * PI;
      angle = random(TWO_PI);
      PVector force = new PVector(cos(angle), -sin(angle)); // 二次元ベクトル場をここに書く
      force.setMag(0.1);  // 大きさを統一
      vectorfield[i][j] = force;
    }
  }
}

// 粒子クラス
class Particle {
  PVector pos, vel, acc;
  float maxSpeed = 2;
  
  Particle() {
    // 中心 (-width/2, width/2) の範囲でランダムに初期化
    pos = new PVector(random(width), random(height));
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }
  
  void applyForce(PVector force) {
    acc.add(force);
  }
  
  void follow(PVector[][] vectors) {
    // グリッドのインデックスを求める
    int x = int(pos.x / scale);
    int y = int(pos.y / scale);
    x = constrain(x, 0, cols - 1);
    y = constrain(y, 0, rows - 1);
    PVector force = vectors[x][y];
    applyForce(force);
  }
  
  void update() {
    vel.add(acc);
    vel.limit(maxSpeed);
    pos.add(vel);
    acc.mult(0);  // 加速度をリセット
  }
  
  void show() {
    float speed = vel.mag();
    float hue = map(speed, 0, maxSpeed, 170, 0);
    stroke(hue, 255, 255);
    strokeWeight(2);
    point(pos.x, pos.y);
  }
  
  void edges() {  // トロイダル境界，画面端についたら反対側に行く
    if (pos.x > width) pos.x = 0;
    if (pos.x < 0) pos.x = width;
    if (pos.y > height) pos.y = 0;
    if (pos.y < 0) pos.y = height;
  }
}
