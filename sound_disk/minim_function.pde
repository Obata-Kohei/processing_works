// minim_function.pde

// Function list:
// 
// 1. 時間波形を表示
// void drawWaveFrom(int x, int y, int w, int h)
// 2. 周波数分布を表示
// void drawSpectrum(int x, int y, int w, int h){
// 3. 円形の周波数分布を描画する関数
// void drawCircularSpectrum(float cx, float cy, float radius, float maxLineLength)
// 4. すべての周波数のパワーを取得して配列に格納
// float[] getFrequencyPowers()
// 5.任意の座標に周波数帯域ごとのパワーを基にグレイスケールの線分を描画する関数 未完
// void drawFrequencyPowerLine(float[] powerArray, float x1, float y1, float x2, float y2)
// 6. 円形スペクトルを描画する
// void drawCircluarSpectrum()
// 7. 円形スペクトログラムを描画する

// 時間波形を描画する関数（振幅がはみ出さないようにスケール調整）
void drawWaveform(int x, int y, int w, int h){
  strokeWeight(1);
  noStroke();
  noFill();
  rect(x, y, w, h);  // 枠線を描画

  stroke(0);
  float maxAmplitude = 0;
  for(int i = 0; i < player.bufferSize(); i++){
    maxAmplitude = max(maxAmplitude, abs(player.mix.get(i)));
  }
  
  beginShape();
  for(int i = 0; i < player.bufferSize(); i++){
    float xpos = map(i, 0, player.bufferSize(), x, x + w);
    float ypos = map(player.mix.get(i), -maxAmplitude, maxAmplitude, y + h, y);
    vertex(xpos, ypos);
  }
  endShape();
}

// 周波数分布を描画する関数（最大値を基準にスケール調整）
void drawSpectrum(int x, int y, int w, int h){
  strokeWeight(1);
  noStroke();
  noFill();
  rect(x, y, w, h);  // 枠線を描画
  
  float maxFreqValue = 0;
  for(int i = 0; i < fft.specSize(); i++){
    maxFreqValue = max(maxFreqValue, fft.getBand(i));
  }

  stroke(0);
  for(int i = 0; i < fft.specSize(); i++){
    float xpos = map(i, 0, fft.specSize(), x, x + w);
    float hbar = (maxFreqValue > 0) ? map(fft.getBand(i), 0, maxFreqValue, 0, h) : 0;
    hbar = constrain(hbar, 0, h);  // 万が一のため制約
    line(xpos, y + h, xpos, y + h - hbar);
  }
}

// 円形の周波数分布を描画する関数
void drawCircularSpectrum(float cx, float cy, float radius, float maxLineLength){

  float maxFreqValue = 0;
  for (int i = 0; i < fft.specSize(); i++) {
    maxFreqValue = max(maxFreqValue, fft.getBand(i));
  }

  stroke(0);
  strokeWeight(2);

  int numBands = fft.specSize();
  for (int i = 0; i < numBands; i++){
    float angle = map(i, 0, numBands, 0-PI/2, TWO_PI-PI/2);  // 周波数帯域ごとの角度, 直流成分を-PI/2の位置にした。
    float amp = (maxFreqValue > 0) ? map(fft.getBand(i), 0, maxFreqValue, 0, maxLineLength) : 0;

    // 内側の点
    float x1 = cx + cos(angle) * radius;
    float y1 = cy + sin(angle) * radius;

    // 外側の点（振幅に応じて長さが変化）
    float x2 = cx + cos(angle) * (radius + amp);
    float y2 = cy + sin(angle) * (radius + amp);

    line(x1, y1, x2, y2);
  }
  strokeWeight(1);
}

// すべての周波数のパワーを取得して配列に格納
float[] getFrequencyPowers() {
  int numBands = fft.specSize();  // FFTのバンド数
  float[] powers = new float[numBands];

  for (int i = 0; i < numBands; i++) {
    powers[i] = fft.getBand(i);
  }

  return powers;
}

void drawFrequencyPowerLine(float[] powerArray, float x1, float y1, float x2, float y2) {
  int numPixels = int(dist(x1, y1, x2, y2));  // 線分の長さに応じたピクセル数
  float stepX = (x2 - x1) / numPixels;
  float stepY = (y2 - y1) / numPixels;

  float maxPower = max(powerArray);

  for (int i = 0; i < numPixels; i++) {
    float px = x1 + stepX * i;
    float py = y1 + stepY * i;

    int index = int(map(i, 0, numPixels, 0, powerArray.length - 1));  
    float power = powerArray[index];

    color colVal = int(map(power, 0, maxPower, 255, 0));
    
    stroke(colVal);
    point(px, py);
  }
}

// 円形スペクトラムを描画する
void drawSpectrumCircleGraph(float cx, float cy, float r) {
  // **曲の進行度に応じた角度を計算**
  progress = player.position() / (float) player.length();  // 0.0 ～ 1.0
  angle = progress * TWO_PI;  // 0 ～ 2π に変換

  powers = getFrequencyPowers();
  powersArray.add(powers);

  x2 = cx + cos(angle) * r;
  y2 = cy + sin(angle) * r;
  endPoints.add(new float[] {x2, y2});
  
  for (int i = 0; i < powersArray.size(); i++) {
    drawFrequencyPowerLine(powersArray.get(i), endPoints.get(i)[0], endPoints.get(i)[1], cx, cy);
  }
}
