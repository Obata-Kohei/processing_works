float raisedCosineFilter(float t, float T, float beta) {
  if (t == 0) {
    return 1.0;
  } else if (abs(t) == T / (2 * beta)) {
    return sin(PI / (2 * beta)) / (PI / (2 * beta));
  } else {
    float num = sin(PI * t / T) * cos(PI * beta * t / T);
    float denom = (PI * t / T) * (1 - (4 * beta * beta * t * t) / (T * T));
    return num / denom;
  }
}
