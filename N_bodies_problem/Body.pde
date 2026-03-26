class Body {
  PVector pos, vel, acc;
  float mass;
  color col;
  ArrayList<PVector> trajectory;

  Body(float x, float y, float vx, float vy, float m, color c) {
    pos = new PVector(x, y);
    vel = new PVector(vx, vy);
    acc = new PVector(0, 0);
    mass = m;
    col = c;
    trajectory = new ArrayList<PVector>(); 
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acc.add(f);
  }

  void update() {
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
    trajectory.add(new PVector(pos.x, pos.y));
  }

  void display() {
    fill(col);
    noStroke();
    if (flgDrawFrame) {strokeWeight(2); stroke(frameColor);}
    
    switch (BDM) {
      case LOG:
        // logスケール，大質量をほどほどに大きく表示
        ellipse(pos.x, pos.y, 10 * log(mass+0.001), 10 * log(mass+0.001));
        break;
      case SCALE_INVARIANT:
        ellipse(pos.x, pos.y, 10/scaleFactor, 10/scaleFactor);
        break;
      default:
        ellipse(pos.x, pos.y, 10, 10);
        break;
    }
  }
  
  void showTrajectory() {
    stroke(col); // 軌道の色
    noFill();
    strokeWeight(int(1/scaleFactor));
    beginShape();
    for (PVector p : trajectory) {
      vertex(p.x, p.y);
    }
    endShape();
  }
}
