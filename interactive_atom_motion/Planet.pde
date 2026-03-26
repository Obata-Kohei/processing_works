// Planet.pde

public class Planet extends Particle {
  Planet(PVector pos, PVector vel, PVector acc, color col) {
    super(pos, vel, acc, col);
  }
  
  Planet(float x, float y, float vx, float vy, float ax, float ay, float m, color c) {
    super(x, y, vx, vy, ax, ay, m, c);
  }
  
  @Override
  void display(ParticleDisplayMode display_mode, float factor, color color_frame) {
    fill(col);
    stroke(color_frame);

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
}
