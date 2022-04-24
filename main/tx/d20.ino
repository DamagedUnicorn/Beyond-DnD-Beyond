uint8_t d20 (float x, float y, float z) {
  for (int i = 0; i < 20; i++) {
    if ((x < x20Coordinates[i] + accTol20 && x > x20Coordinates[i] - accTol20) && \
        (y < y20Coordinates[i] + accTol20 && y > y20Coordinates[i] - accTol20) && \
        (z < z20Coordinates[i] + accTol20 && z > z20Coordinates[i] - accTol20)
       ) {
      return i + 1;
    }
  }
  return 0;
}
