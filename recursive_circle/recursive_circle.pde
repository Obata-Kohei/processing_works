// A4 300ppi 2480x3508 px
// A4 72ppi 595x842 px
// A4 48ppi 397x561 px

int PGWidth = 2480, PGHeight = 3508;
PGraphics img;

int padding = 10;
float initX = 170, initY = 200*2/3;
int numX = 15, numY = 20;  // 外側の円(ブロックと呼称)の個数
int numCircleInBlock = 20;  // 一番外側を含めた円の個数
float rCircleOutside;  // ブロックの外側の円の半径
float rCircleInside;  // ブロックの最も内側の円の半径
float rTmp;  // ブロック内の円の半径を計算する作業用変数

float sw = 0.4;  // standard Stroke Weight
float xOffset, yOffset;  // 円の中心座標の最外側円の中心からのずれ
float xOffsetMax, yOffsetMax;



void setup() {
  size(595, 842);
  background(0);
  frameRate(10);
  img = createGraphics(PGWidth, PGHeight);
  
  float rCand1 = (img.width - (numX - 1) * padding - 2 * initX) / numX;
  float rCand2 = (img.height - (numY - 1) * padding - 2 * initY) / numY;
  rCircleOutside = min(rCand1, rCand2);
  rCircleInside = rCircleOutside / numCircleInBlock;
  xOffsetMax = rCircleOutside / numCircleInBlock - rCircleInside / 2;
  yOffsetMax = rCircleOutside / numCircleInBlock - rCircleInside / 2;
  xOffset = int(random(-xOffsetMax, xOffsetMax));
  yOffset = int(random(-yOffsetMax, yOffsetMax));
  
  img.beginDraw();
  img.colorMode(HSB, 255);
  img.background(255);
  img.stroke(0);
  img.noFill();
  img.strokeWeight(sw);
  
  for (float x = initX + rCircleOutside / 2; x < img.width - initX; x += padding + rCircleOutside) {
    for (float y = initY + rCircleOutside / 2; y < img.height - initY; y += padding + rCircleOutside) {
      // 最も外側の正方形の描画
      img.stroke(255*303/360, 100, 100);
      img.circle(x, y, rCircleOutside);
      
      xOffset = -xOffsetMax * tan(TWO_PI/2 * x);
      yOffset = -yOffsetMax * tan(TWO_PI/2 * y);
      
      for (int i = 0; i < numCircleInBlock; i++) {
        img.stroke(120, 255, map(i, 0, numCircleInBlock, 0, 255));
        rTmp = map(i, 0, numCircleInBlock, rCircleOutside, rCircleInside);
        img.circle(x + xOffset * i, y + yOffset * i, (int) rTmp);
      }
    }
  }
  img.endDraw();
  
  image(img, 0, 0, width, height);
}


void draw() {
}


void keyPressed() {
  if (key == 's') {
    String timeStamp = year() + nf(month(), 2) + nf(day(), 2) + "_" + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
    String fileName = "./images/capture" + timeStamp + ".png";
    img.save(fileName);
    println("image saved");
  }
}
