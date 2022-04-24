uint8_t d20 (float x, float y, float z) {
  for (int i = 0; i < 20; i++) {
    if ((x < xCoordinates[i] + accTol20 && x > xCoordinates[i] - accTol20) && \
        (y < yCoordinates[i] + accTol20 && y > yCoordinates[i] - accTol20) && \
        (z < zCoordinates[i] + accTol20 && z > zCoordinates[i] - accTol20)
       ) {
      return i + 1;
    }
  }
  return 0;
}
