// sound_disk.pde
// inplementation of SOUND OF SPACE by thedotisblack

import ddf.minim.*;  
import ddf.minim.analysis.*;

Minim minim;  
AudioPlayer player;  
FFT fft;
float[] powers;
ArrayList<float[]> powersArray;
ArrayList<float[]> endPoints;
int padding, waveX, waveY, specX, specY, rectWidth, rectHeight;
float progress, angle;
float cx, cy, lineLength, x2, y2;

String filename = "CLUSTER.mp3";
String title = "CLUSTER";
int titleX, titleY;

void setup(){
  size(1280, 720);
  frameRate(90);
  minim = new Minim(this);  
  player = minim.loadFile(filename);  
  player.play();  
  
  float bufferDurationInSeconds = player.bufferSize() / player.sampleRate();
  println(bufferDurationInSeconds);

  fft = new FFT(player.bufferSize(), player.sampleRate());

  padding = 40;
  waveX = padding; waveY = padding;
  specX = padding; specY = height/2 + padding/2;
  rectWidth = width/2 - 3*padding;
  rectHeight = height/2 - 3*padding;

  powersArray = new ArrayList<float[]>();
  endPoints = new ArrayList<float[]>();
  cx = 3 * width/4 - padding;
  cy = height/2;
  lineLength = width/4 + padding/2;
  
  titleX = width/2; titleY = height/2 - padding / 2;
}

void draw() {
  background(#f3f3f2);
  fill(0);  // 文字色を黒に設定
  textSize(32);  // 文字のサイズを設定
  textAlign(CENTER, CENTER);  // 文字を中央に配置
  text(title, titleX, titleY);  // 中央に文字列を表示

  fft.forward(player.mix);

  // 時間波形の表示
  drawWaveform(waveX, waveY, rectWidth, rectHeight);

  // 周波数分布の表示
  drawSpectrum(specX, specY, rectWidth, rectHeight);

  // スペクトラムの円形表示
  drawSpectrumCircleGraph(cx, cy, lineLength);
  
  
  if (!player.isPlaying()) {
    stroke(255); 
    line(cx, cy, cx+cos(angle)*lineLength, cy+sin(angle)*lineLength);
  }
  
  //if (player.isPlaying()) saveFrame("frames/#####.png");
}


void stop(){
  player.close();  
  minim.stop();
  super.stop();
}
