void mouseClicked() {
  // 画面座標 -> ワールド座標へ変換
  
}


void keyPressed() {
  float zoomSpeed = 0.1;  // ズームの速度

  if (key == 'q') {  // ズームイン
    scaleFactor *= (1 + zoomSpeed);
  } else if (key == 'w') {  // ズームアウト
    scaleFactor *= (1 - zoomSpeed);
  }
  
  if (key == 'a') {
    float worldX = (mouseX - width / 2) / scaleFactor + bodies.get(0).pos.x;
    float worldY = (mouseY - height / 2) / scaleFactor + bodies.get(0).pos.y;
    int r = int(random(255)), g = int(random(255)), b = int(random(255));
    bodies.add(new Particle(worldX, worldY, random(-Vplanet, Vplanet), random(-Vplanet, Vplanet),0, 0, Mplanet, color(r,g,b)));
  }
  if (key == 's') {  // 天体削除
    if (bodies.size() > 0) {
      bodies.remove(bodies.size() - 1);
    }
  }
  
  if (key == 'r') {
    translate(bodies.get(0).pos.x, bodies.get(0).pos.y);
  }

  // ズーム範囲の制限
  //scaleFactor = constrain(scaleFactor, 0.1, 5.0);
}
