float scaleFactor = 0.3; // ウィンドウの表示スケール

color red = color(255, 0, 0);
color blue = color(0, 0, 255);
color yellow = color(255, 255, 0);
color white = color(255, 255, 255);
color black = color(0, 0, 0);

float G = 1; // 重力定数
float R = 1000;
float dR = R * 0.1;
float Mstar = 100;
float Mplanet = Mstar / 1836;
float Vplanet = Mplanet * 512 * scaleFactor;
int Nplanet = 1;

ArrayList<Particle> bodies;


void setup() {
  size(1280, 960);
  frameRate(60);
  background(255);
  colorMode(RGB, 255);
  
  bodies = new ArrayList<Particle>();

  // 初期設定
  // x, y, vx, vy, ax, ay, mass, colorの順に引数入れる
  bodies.add(new Star(0, 0, 0, 0, 0, 0, Mstar, black));
  for (int i=0; i<Nplanet; i++) {
    int r = int(random(255)), g = int(random(255)), b = int(random(255));
    bodies.add(new Planet(R*cos(random(2*PI))+random(-dR, dR), R*sin(random(2*PI))+random(-dR, dR), random(-Vplanet, Vplanet), random(-Vplanet, Vplanet), 0, 0, Mplanet, color(r, g, b)));
  }
}


void draw() {
  background(255);
  
  translate(width / 2, height / 2);
  scale(scaleFactor);
  translate(-bodies.get(0).pos.x, -bodies.get(0).pos.y);
  
  // 重力計算
  for (int i = 0; i < bodies.size(); i++) {
    for (int j = 0; j < bodies.size(); j++) {
      if (i != j) {
        PVector force = calculateGravitationalForce(bodies.get(i), bodies.get(j));
        bodies.get(i).applyForce(force);
      }
    }
  }

  // 更新と描画
  for (Particle b : bodies) {
    b.update();
    
    if (b instanceof Star) {
      ((Star) b).displayGrad(black, white, 100);
      //b.displayLog(10, black);
    } else {
      b.displayLog(10, b.col);
      b.showTrajectory(scaleFactor);
    }
  }
}
