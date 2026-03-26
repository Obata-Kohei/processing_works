// A4 300ppi 2480x3508 px
// A4 72ppi 595x842 px
// A4 48ppi 397x561 px
// FHD 1920x1080 px

int targetW = 1080, targetH = 1920;
float fps = 30;
PGraphics img;

int padding = 10;
float marginX = 170, marginY = 200*2/3;
int cols = 4, rows =7;  // 外側の円(ブロックと呼称)の個数
int numCircleInBlock = 5;  // 一番外側を含めた円の個数
float outerR;  // ブロックの外側の円の半径
float innerR;  // ブロックの最も内側の円の半径
float rTmp;  // ブロック内の円の半径を計算する作業用変数

float sw = 0.4;  // standard Stroke Weight
float xOffset, yOffset;  // 円の中心座標の最外側円の中心からのずれ
float xOffsetMax, yOffsetMax;



void setup() {
  size(360, 640);
  background(0);
  frameRate(10);
  img = createGraphics(targetW, targetH);
  
  float rCand1 = (img.width - (cols - 1) * padding - 2 * marginX) / cols;
  float rCand2 = (img.height - (rows - 1) * padding - 2 * marginY) / rows;
  outerR = min(rCand1, rCand2);
  innerR = outerR / numCircleInBlock;
  xOffsetMax = outerR / numCircleInBlock - innerR / 2;
  yOffsetMax = outerR / numCircleInBlock - innerR / 2;
  xOffset = int(random(-xOffsetMax, xOffsetMax));
  yOffset = int(random(-yOffsetMax, yOffsetMax));
  
  img.beginDraw();
  img.colorMode(HSB, 255);
  img.background(255);
  img.stroke(0);
  img.noFill();
  img.strokeWeight(sw);
  
  for (float x = marginX + outerR / 2; x < img.width - marginX; x += padding + outerR) {
    for (float y = marginY + outerR / 2; y < img.height - marginY; y += padding + outerR) {
      // 最も外側の正方形の描z画
      img.stroke(255*303/360, 100, 100);
      img.circle(x, y, outerR);
      
      xOffset = 0;//-xOffsetMax * tan(TWO_PI/2 * x);
      yOffset = 0;//-yOffsetMax * tan(TWO_PI/2 * y);
      
      for (int i = 0; i < numCircleInBlock; i++) {
        img.stroke(120, 255, map(i, 0, numCircleInBlock, 0, 255));
        rTmp = map(i, 0, numCircleInBlock, outerR, innerR);
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
