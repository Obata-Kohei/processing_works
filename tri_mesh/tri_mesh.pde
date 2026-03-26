int cols = 20;
int rows = 20;
float cellW, cellH;

void setup() {
  size(600, 600);
  
  cellW = width / (float)cols;
  cellH = height / (float)rows;
}

void draw() {
  background(255);
  stroke(0);
  noFill();

  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {

      float x0 = x * cellW;
      float y0 = y * cellH;
      float x1 = (x + 1) * cellW;
      float y1 = (y + 1) * cellH;

      // 1つ目の三角形
      beginShape(TRIANGLES);
      vertex(x0, y0);
      vertex(x1, y0);
      vertex(x1, y1);

      // 2つ目の三角形
      vertex(x0, y0);
      vertex(x1, y1);
      vertex(x0, y1);
      endShape();
    }
  }
}
