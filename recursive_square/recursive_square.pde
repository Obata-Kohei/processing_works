// A4 300ppi 2480x3508 px
// A4 72ppi 595x842 px
// A4 48ppi 397x561 px

int PGWidth = 2480, PGHeight = 3508;
PGraphics img;

int padding = 10;
int numX = 5, numY = 7;  // 外側の正方形(ブロックと呼称)の個数
int numSquareInBlock = 6;  // 一番外側を含めた正方形の個数
int wSquareOutside, hSquareOutside;  // ブロックの外側の正方形の幅，高さ
int wSquareInside, hSquareInside;  // ブロックの最も内側の正方形の幅，高さ
float wTmp, hTmp;  // ブロック内の正方形の幅，高さを計算する作業用変数

int sw = 5;  // standard Stroke Weight
int xOffset, yOffset;  // 正方形の中心座標の最外側正方形の中心からのずれ
float xOffsetMax, yOffsetMax;



void setup() {
  size(595, 842);
  background(0);
  frameRate(10);
  img = createGraphics(PGWidth, PGHeight);
  img.rectMode(CENTER);
  
  wSquareOutside = (img.width - (numX + 1) * padding) / numX;
  hSquareOutside = (img.height - (numY + 1)  * padding) / numY;
  wSquareInside = wSquareOutside / numSquareInBlock;
  hSquareInside = hSquareOutside / numSquareInBlock;
  xOffsetMax = wSquareOutside / numSquareInBlock - wSquareInside / 2;
  yOffsetMax = hSquareOutside / numSquareInBlock - hSquareInside / 2;
  xOffset = int(random(-xOffsetMax, xOffsetMax));
  yOffset = int(random(-yOffsetMax, yOffsetMax));
  
  img.beginDraw();
  
  img.background(255);
  img.stroke(0);
  img.rectMode(CENTER);
  img.noFill();
  img.strokeWeight(sw);
  
  for (int x = padding + wSquareOutside / 2; x < img.width; x += padding + wSquareOutside) {
    for (int y = padding + hSquareOutside / 2; y < img.height; y += padding + hSquareOutside) {
      // 最も外側の正方形の描画
      img.rect(x, y, wSquareOutside, hSquareOutside);
      
      xOffset = int(random(-xOffsetMax, xOffsetMax));
      yOffset = int(random(-yOffsetMax, yOffsetMax));
      
      for (int i = 0; i < numSquareInBlock; i++) {
        wTmp = map(i, 0, numSquareInBlock, wSquareOutside, wSquareInside);
        hTmp = map(i, 0, numSquareInBlock, hSquareOutside, hSquareInside);
        img.rect(x + xOffset * i, y + yOffset * i, (int) wTmp, (int) hTmp);
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
