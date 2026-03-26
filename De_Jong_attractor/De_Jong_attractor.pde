// A4 300ppi 2480x3508 px
// A4 72ppi 595x842 px
// A4 48ppi 397x561 px

int PGWidth = 2480, PGHeight = 3508;
PGraphics img;

// De Jong Attractor variables
float x = 0, y = 0;
float a = 1.57;
float b = 1.97;
float c = 1.77;
float d = 1.77;
int totalPoints = 1000000;

void setup() {
  size(595, 842);  // プレビュー用
  background(0);
  frameRate(10);

  img = createGraphics(PGWidth, PGHeight);

  img.beginDraw();
  img.background(255);        // 背景白
  img.translate(PGWidth/2, PGHeight/2);  // 中心を原点に
  img.stroke(0, 5);           // 黒・透明度5
  img.strokeWeight(7);      // 細めの点

  for (int i = 0; i < totalPoints; i++) {
    float newX = sin(a * y) - cos(b * x);
    float newY = sin(c * x) - cos(d * y);

    float drawX = map(newX, -2, 2, -PGWidth/2, PGWidth/2);
    float drawY = map(newY, -2, 2, -PGWidth/2, PGWidth/2);

    img.point(drawX, drawY);

    x = newX;
    y = newY;
  }

  img.endDraw();
  
  // 表示部分：アスペクト比を維持して中央に表示
  float imgAspect = float(PGWidth) / PGHeight;
  float screenAspect = float(width) / height;

  float displayW, displayH;
  if (imgAspect > screenAspect) {
    displayW = width;
    displayH = width / imgAspect;
  } else {
    displayH = height;
    displayW = height * imgAspect;
  }

  float offsetX = (width - displayW) / 2;
  float offsetY = (height - displayH) / 2;

  image(img, offsetX, offsetY, displayW, displayH);
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
