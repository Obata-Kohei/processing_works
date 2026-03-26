// color_util.pde

// color[]の中身を可視化する，画面いっぱいに縦長の長方形を描画
void viewColors(color[] colors) {
  for (int i = 0; i < colors.length; i++) {
    fill(colors[i]);
    rect(i * width / colors.length, 0, width / colors.length, height);
  }
}

// coolors.comのURLからカラーパレットを作る
color[] fromCoolors(String url) {
  String[] parts = split(url, "/");   // "/" で分割
  String hexPart = parts[parts.length - 1]; // 最後の部分を取得
  String[] hexColors = split(hexPart, "-"); // "-" で分割

  color[] colors = new color[hexColors.length];
  for (int i = 0; i < hexColors.length; i++) {
    colors[i] = unhex("FF" + hexColors[i]); // Alphaを加えて color に変換
  }
  return colors;
}

// HSVからRGBに変換してcolorを出力
color hsvToRgb(int h, int s, int v){
  float f;
  int i, p, q, t;
  
  i = (int)Math.floor(h / 60.0f) % 6;
  f = (h / 60.0f) - (float)Math.floor(h / 60.0f);
  p = Math.round(v * (1.0f - (s / 255.0f)));
  q = Math.round(v * (1.0f - (s / 255.0f) * f));
  t = Math.round(v * (1.0f - (s / 255.0f) * (1.0f - f)));
      
  int r = 0, g = 0, b = 0;
    
  switch (i) {
    case 0: r = v; g = t; b = p; break;
    case 1: r = q; g = v; b = p; break;
    case 2: r = p; g = v; b = t; break;
    case 3: r = p; g = q; b = v; break;
    case 4: r = t; g = p; b = v; break;
    case 5: r = v; g = p; b = q; break;
  }
  
  return color(r, g, b);
}

// バランスがいいとされる色をn個作成する
// 色相が近い色や、色相環を均等に割った色は相性がいい
color[] makeBalancedColors(int n) {
  int[][] hsb = new int[n][3];
  int margin = (int)random(4);
  
  hsb[0][0] = (int)random(360);
  hsb[0][1] = (int)random(100, 240);
  hsb[0][2] = (int)random(200, 240);
  
  for (int i = 1; i < n; i++) {
    hsb[i][0] = hsb[0][0] + (360 / (n+margin)) * i;
    hsb[i][1] = hsb[0][1];
    hsb[i][2] = hsb[0][2];
  }
  
  color[] colors = new color[n];
  
  for (int i = 0; i < n; i++) {
    colors[i] = hsvToRgb(hsb[i][0], hsb[i][1], hsb[i][2]);
  }
  
  return colors;
}

/*
void setup() {
  size(400, 400);
  
  String url = "https://coolors.co/9381ff-b8b8ff-f8f7ff-ffeedd-ffd8be";
  color[] pal1 = fromCoolors(url);
  //viewColors(pal1);
  
  color[] pal2 = makeBalancedColors(7);
  viewColors(pal2);
}
*/
