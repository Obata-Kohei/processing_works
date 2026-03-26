import java.util.Arrays;
import java.util.Comparator;

float[][] generateRandomParams(int num, float ampMin, float ampMax, float freqMin, float freqMax) {
  float[][] params = new float[num][2];
  
  for (int i = 0; i < num; i++) {
    float amp = random(ampMin, ampMax);  // 振幅をランダムに決定
    float freq = random(freqMin, freqMax);  // 周波数をランダムに決定
    
    params[i][0] = amp;
    params[i][1] = freq;
  }

  // 振幅(amp)を基準に降順ソート
  Arrays.sort(params, new Comparator<float[]>() {
    public int compare(float[] a, float[] b) {
      return Float.compare(b[0], a[0]);  // b[0] - a[0] で降順
    }
  });

  return params;
}
