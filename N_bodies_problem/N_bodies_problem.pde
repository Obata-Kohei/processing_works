// N_bodies_problem.pde
// 3体問題や一般のN体問題のシミュレーションをする

// How To Use
// 1. 各種定数を設定，// Config のフラグを設定
// 2. // 初期設定 で天体の情報を入力
// appendix: class Bodyのdisplayメソッドをいじって天体の表示形式を変える
// key a -> zoom out , key s -> zoom in

float G = 1; // 重力定数
float scaleFactor = 0.5; // スケール

// Config
boolean flgDynamicScale = false;  // 動的にスケーリングするか，falseならscaleFactorを確認する。
boolean flgTranslateCenter = false;  // 画面中心を常に(0, 0)とする，重心中心trueならそれを優先
boolean flgTranslateByMassCenter = true;  // 天体の重心を常に画面の中心にする。trueのほうがいい
boolean flgDrawBody = true;  // 天体を描くか
boolean flgDrawTrajectory = true;  // 天体の軌跡を表示するか
boolean flgDrawMassCenter = false;  // 天体の重心を表示するか
boolean flgDrawFrame = false;  // 天体の枠線を描くか
color frameColor = color(0, 255, 0);  // 天体の枠線の色
BodyDisplayMode log = BodyDisplayMode.LOG;
BodyDisplayMode si = BodyDisplayMode.SCALE_INVARIANT;
BodyDisplayMode BDM = si;  // LOG or SCALE_INVARIANT

ArrayList<Body> bodies;

void setup() {
  size(960, 800);
  frameRate(30);
  background(255);
  colorMode(RGB, 255);
  
  bodies = new ArrayList<Body>();

  // 初期設定
  // x, y, vx, vy, mass, colorの順に引数入れる
  bodies.add(new Body(random(-100, 100), random(-100, 100), 10, 0, 5000, color(255, 0, 0)));
  bodies.add(new Body(random(-100, 100), random(-100, 100), 0, 50, 100, color(0, 255, 0)));
  bodies.add(new Body(random(-100, 100), random(-100, 100), 0, 30, 100, color(0, 0, 255)));
  bodies.add(new Body(random(-100, 100), random(-100, 100), 0, 21, 100, color(255, 255, 0)));
  bodies.add(new Body(random(-100, 100), random(-100, 100), 0, 12, 100, color(255, 0, 255)));
  bodies.add(new Body(random(-100, 100), random(-100, 100), 0, 6, 100, color(0, 255, 255)));
}

void draw() {
  background(255);
  
  PVector mass_center = calculateCenterOfMass(bodies);  // 重心を計算
  
  // スケールを計算（動的調整）
  if (flgDynamicScale) scaleFactor = calculateScale(mass_center, bodies);
  
  if (flgTranslateCenter) {
    translate(width/2, height/2);
    scale(scaleFactor);
  }

  // 画面を重心に合わせて調整
  if (flgTranslateByMassCenter) {
    translate(width / 2, height / 2);
    scale(scaleFactor);
    translate(camX, camY);
    translate(-mass_center.x, -mass_center.y);
  }
  
  // 重心を表示
   if (flgDrawMassCenter) {
    stroke(255, 255, 255);
    circle(mass_center.x, mass_center.y, 10);
  }

  // 重力計算
  if (isRunning) {
    for (int i = 0; i < bodies.size(); i++) {
      for (int j = 0; j < bodies.size(); j++) {
        if (i != j) {
          PVector force = calculateGravitationalForce(bodies.get(i), bodies.get(j));
          bodies.get(i).applyForce(force);
        }
      }
    }
  }

  // 更新と描画
  for (Body b : bodies) {
    b.update();
    if (flgDrawBody) b.display();
    if (flgDrawTrajectory) b.showTrajectory();
  }
}

/*
void keyPressed() {
  if (key=='a') scaleFactor = scaleFactor + 0.02;
  else if (key=='s') {scaleFactor = scaleFactor - 0.2*log(5*scaleFactor); constrain(scaleFactor, 0, 100);}
}*/


// **重心を計算する関数（天体が3つに限定されないよう汎用化）**
PVector calculateCenterOfMass(ArrayList<Body> bodies) {
  float totalMass = 0;
  float x_c = 0;
  float y_c = 0;

  for (Body b : bodies) {
    totalMass += b.mass;
    x_c += b.pos.x * b.mass;
    y_c += b.pos.y * b.mass;
  }
  
  return new PVector(x_c / totalMass, y_c / totalMass);
}

// **スケールを計算する関数**
float calculateScale(PVector center, ArrayList<Body> bodies) {
  float maxDist = 0;
  
  for (Body b : bodies) {
    float d = PVector.dist(center, b.pos);
    if (d > maxDist) {
      maxDist = d;
    }
  }
  
  // 画面サイズに合わせてスケールを調整（余裕を持たせるため 0.8 を掛ける）
  return min(0.8 * width / (2 * maxDist), 1.0);
}

PVector calculateGravitationalForce(Body b1, Body b2) {
  PVector direction = PVector.sub(b2.pos, b1.pos);
  float distance = direction.mag();
  distance = constrain(distance, 5, 25); // 距離の制限
  float forceMagnitude = (G * b1.mass * b2.mass) / (distance * distance);
  return direction.normalize().mult(forceMagnitude);
}
