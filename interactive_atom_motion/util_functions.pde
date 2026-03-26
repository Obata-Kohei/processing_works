// **重心を計算する関数（天体が3つに限定されないよう汎用化）**
PVector calculateCenterOfMass(ArrayList<Particle> bodies) {
  float totalMass = 0;
  float x_c = 0;
  float y_c = 0;

  for (Particle b : bodies) {
    totalMass += b.mass;
    x_c += b.pos.x * b.mass;
    y_c += b.pos.y * b.mass;
  }
  
  return new PVector(x_c / totalMass, y_c / totalMass);
}

// **スケールを計算する関数**
float calculateScale(PVector center, ArrayList<Particle> bodies) {
  float maxDist = 0;
  
  for (Particle b : bodies) {
    float d = PVector.dist(center, b.pos);
    if (d > maxDist) {
      maxDist = d;
    }
  }
  
  // 画面サイズに合わせてスケールを調整（余裕を持たせるため 0.9 を掛ける）
  return min(0.9 * width / (2 * maxDist), 1.0);
}

PVector calculateGravitationalForce(Particle b1, Particle b2) {
  PVector direction = PVector.sub(b2.pos, b1.pos);
  float distance = direction.mag();
  distance = constrain(distance, 5, 25); // 距離の制限
  float forceMagnitude = (G * b1.mass * b2.mass) / (distance * distance);
  return direction.normalize().mult(forceMagnitude);
}
