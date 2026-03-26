void mouseClicked() {
  // 画面座標 -> ワールド座標へ変換
  float worldX = (mouseX - width / 2) / scaleFactor + bodies.get(0).pos.x;
  float worldY = (mouseY - height / 2) / scaleFactor + bodies.get(0).pos.y;
  
  //int r = int(random(255)), g = int(random(255)), b = int(random(255));
  //bodies.add(new Particle(worldX, worldY, random(-Vplanet, Vplanet), random(-Vplanet, Vplanet),0, 0, Mplanet, color(r,g,b)));
}

// ズーム速度
float zoomSpeed = 0.1;;

// カメラの移動量
float camX = 0, camY = 0;
float camSpeed = 10;  // 矢印キーでの移動速度

// プログラムは動作しているか
boolean isRunning = true;

void keyPressed() {
  // ズーム
  if (key == 'a') {  // ズームイン
    scaleFactor *= (1 + zoomSpeed);
  } else if (key == 's') {  // ズームアウト
    scaleFactor *= (1 - zoomSpeed);
  }
  // ズーム範囲の制限
  scaleFactor = constrain(scaleFactor, 0.1, 5.0);

  // 矢印キーで移動
  if (keyCode == LEFT) {
    camX -= camSpeed / scaleFactor;  // スケールに応じた移動
  } else if (keyCode == RIGHT) {
    camX += camSpeed / scaleFactor;
  } else if (keyCode == UP) {
    camY -= camSpeed / scaleFactor;
  } else if (keyCode == DOWN) {
    camY += camSpeed / scaleFactor;
  }
}
