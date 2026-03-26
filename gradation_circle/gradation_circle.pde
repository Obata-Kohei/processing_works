int centerX, centerY;
int r_max;

void setup() {
  size(400, 400);
  background(255);
  centerX = width / 2;
  centerY = height / 2;
  r_max = 200;  // 半径の最大値

  color c1 = color(255, 255, 255);
  color c2 = color(100, 100, 100);

  noStroke();  // 線なし
  for (int r = r_max; r > 0; r--) {  // 外側から内側へ描画
    float amt = map(r, 0, r_max, 0, 1);
    fill(lerpColor(c1, c2, amt));  // グラデーション
    ellipse(centerX, centerY, r * 2, r * 2);  // 直径を指定
  }
}
