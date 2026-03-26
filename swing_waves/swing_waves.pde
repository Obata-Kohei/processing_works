// A4 300ppi 2480 x 3508 px
// A4 72ppi 595 x 842 px
// A4 48ppi 397 x 561 px

int PGWidth = 2480, PGHeight = 3508;
PGraphics img;
FloatFunction f;
int N;
float padding;

void setup() {
  size(595, 842);  // キャンバスサイズ
  background(255);  // 背景色を白に
  frameRate(10);
  img = createGraphics(PGWidth, PGHeight);
  N = 100;
  padding = 10;
  
  img.strokeWeight(5);
  f = x -> img.height/4 * sin(0.01 * x);
  drawFunction(img, f, -2*PGWidth, 2*PGWidth);

  image(img, 0, 0, width, height);
}

// 関数のインターフェースを定義
interface FloatFunction {
  float apply(float x);
}

// 任意の関数を描画する
void drawFunction(PGraphics pg, FloatFunction f, float xMin, float xMax) {
  pg.beginDraw();
  pg.background(255);
  pg.stroke(0);
  pg.noFill();
  pg.strokeWeight(5);
  
  float dx = (xMax - xMin) / 1000.0; // x の増分（範囲に応じて適切な値に）

  pg.beginShape();
  for (float x = xMin; x <= xMax; x += dx) {
    float y = f.apply(x);
    
    // 座標変換（中心を原点に）
    float sx = map(x, xMin, xMax, 0, pg.width);
    float sy = pg.height / 2 - y;
    
    pg.vertex(sx, sy);
  }
  pg.endShape();

  pg.endDraw();
}

void draw(){}

void keyPressed() {
  if (key == 's') {
    String timeStamp = year() + nf(month(), 2) + nf(day(), 2) + "_" + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
    String fileName = "./images/capture" + timeStamp + ".png";
    img.save(fileName);
    println("image saved");
  }
}
