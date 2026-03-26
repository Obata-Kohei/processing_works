// Particle.pde

public class Particle{
  public PVector pos, vel, acc;  // position, velocity, acceleration
  public float mass;  // mass
  public color col;  // color
  public ArrayList<PVector> trj;  // trajectory, 軌跡
  
  Particle(PVector pos, PVector vel, PVector acc, color col) {
    this.pos = pos;
    this.vel = vel;
    this.acc = acc;
    this.col = col;
    this.trj = new ArrayList<PVector>();
  }
  
  Particle(float x, float y, float vx, float vy, float ax, float ay, float m, color c) {
    this.pos = new PVector(x, y);
    this.vel = new PVector(vx, vy);
    this.acc = new PVector(ax, ay);
    this.mass = m;
    this.col = c;
    this.trj = new ArrayList<PVector>();
  }
  
  void applyForce(PVector f) {
    if (mass>0) {
      PVector a = PVector.div(f, mass);
      acc = a;
    }
  }
  
  void update() {
    vel.add(acc);
    pos.add(vel);
    //acc.mult(0);
    trj.add(new PVector(pos.x, pos.y));
  }
  
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
  
  void displayLog(float factor) {
    // logスケール，大質量をほどほどに大きく表示
    circle(pos.x, pos.y, factor*log(mass+0.001));
  }
  
  void displayScaleInvariant(float factor, float scale) {
    // scaleFactorで割る，遠ざかっても見やすい
    circle(pos.x, pos.y, factor/scale);
  }
  
  void showTrajectory(float scaleFactor) {
    stroke(col);
    noFill();
    strokeWeight(int(1/scaleFactor));
    
    beginShape();
    for (PVector p : trj) {
      vertex(p.x, p.y);
    }
    endShape();
  }
}
