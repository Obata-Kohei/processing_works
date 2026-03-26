// Star.pde

public class Star extends Particle {
  Star(PVector pos, PVector vel, PVector acc, color col) {
    super(pos, vel, acc, col);
  }
  
  Star(float x, float y, float vx, float vy, float ax, float ay, float m, color c) {
    super(x, y, vx, vy, ax, ay, m, c);
  }
  
  @Override
  void display(ParticleDisplayMode display_mode, float factor, color color_frame) {
    fill(col);
    stroke(color_frame);
    strokeWeight(5);

    switch (display_mode) {
      case LOG:
        // logスケール，大質量をほどほどに大きく表示
        circle(pos.x, pos.y, factor*log(mass+0.001));
        break;
      case SCALE_INVARIANT:
         // scaleFactorで割る，遠ざかっても見やすい
        float scaleFactor = factor;
        circle(pos.x, pos.y, factor/scaleFactor);
        break;
      case CONSTANT:
        // 常にすべて同じサイズ
        circle(pos.x, pos.y, factor);
        break;
      case LINEAR:
        // 質量に対して線形に大きくなる
        circle(pos.x, pos.y, mass*factor);
        break;
    }
  }
  
  @Override
  void displayLog(float factor, color color_frame) {
    fill(white);
    stroke(color_frame);
    strokeWeight(4);
    circle(pos.x, pos.y, factor*log(mass+0.001));
  }
  
  void displayGrad(color c1, color c2, int r_max) {
    noStroke();  // 線なし
    for (int r = r_max; r > 0; r--) {  // 外側から内側へ描画
      float amt = map(r, 0, r_max, 0, 1);
      fill(lerpColor(c1, c2, amt));  // グラデーション
      ellipse(pos.x, pos.y, r * 2, r * 2);  // 直径を指定
    }
  }
}
