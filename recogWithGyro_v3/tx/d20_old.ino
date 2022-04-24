int d20Old (float x, float y, float z) {
  if ((x < 0.0 + accTol20 && x > 0.0 - accTol20) && (y < 0.006 + accTol20 && y > 0.006 - accTol20) && (z < 1.0 + accTol20 && z > 1.0 - accTol20)) {
    return 1;
  }
  else if ((x < -0.573 + accTol20 && x > -0.573 - accTol20) && (y < -0.337 + accTol20 && y > -0.337 - accTol20) && (z < -0.747 + accTol20 && z > -0.747 - accTol20)) {
    return 2;
  }
  else if ((x < 0.354 + accTol20 && x > 0.354 - accTol20) && (y < 0.872 + accTol20 && y > 0.872 - accTol20) && (z < 0.339 + accTol20 && z > 0.339 - accTol20)) {
    return 3;
  }
  else if ((x < 0.354 + accTol20 && x > 0.354 - accTol20) && (y < -0.872 + accTol20 && y > -0.872 - accTol20) && (z < -0.339 + accTol20 && z > -0.339 - accTol20)) {
    return 4;
  }
  else if ((x < -0.577 + accTol20 && x > -0.577 - accTol20) && (y < -0.747 + accTol20 && y > -0.747 - accTol20) && (z < 0.33 + accTol20 && z > 0.33 - accTol20)) {
    return 5;
  }
  else if ((x < 0.934 + accTol20 && x > 0.934 - accTol20) && (y < 0.125 + accTol20 && y > 0.125 - accTol20) && (z < -0.336 + accTol20 && z > -0.336 - accTol20)) {
    return 6;
  }
  else if ((x < -0.573 + accTol20 && x > -0.573 - accTol20) && (y < 0.337 + accTol20 && y > 0.337 - accTol20) && (z < 0.747 + accTol20 && z > 0.747 - accTol20)) {
    return 7;
  }
  else if ((x < 0.0 + accTol20 && x > 0.0 - accTol20) && (y < 0.664 + accTol20 && y > 0.664 - accTol20) && (z < -0.748 + accTol20 && z > -0.748 - accTol20)) {
    return 8;
  }
  else if ((x < 0.934 + accTol20 && x > 0.934 - accTol20) && (y < -0.125 + accTol20 && y > -0.125 - accTol20) && (z < 0.336 + accTol20 && z > 0.336 - accTol20)) {
    return 9;
  }
  else if ((x < -0.577 + accTol20 && x > -0.577 - accTol20) && (y < 0.747 + accTol20 && y > 0.747 - accTol20) && (z < -0.33 + accTol20 && z > -0.33 - accTol20)) {
    return 10;
  }
  else if ((x < 0.577 + accTol20 && x > 0.577 - accTol20) && (y < -0.747 + accTol20 && y > -0.747 - accTol20) && (z < 0.33 + accTol20 && z > 0.33 - accTol20)) {
    return 11;
  }
  else if ((x < -0.934 + accTol20 && x > -0.934 - accTol20) && (y < 0.125 + accTol20 && y > 0.125 - accTol20) && (z < -0.336 + accTol20 && z > -0.336 - accTol20)) {
    return 12;
  }
  else if ((x < 0.0 + accTol20 && x > 0.0 - accTol20) && (y < -0.664 + accTol20 && y > -0.664 - accTol20) && (z < 0.748 + accTol20 && z > 0.748 - accTol20)) {
    return 13;
  }
  else if ((x < 0.573 + accTol20 && x > 0.573 - accTol20) && (y < -0.337 + accTol20 && y > -0.337 - accTol20) && (z < -0.747 + accTol20 && z > -0.747 - accTol20)) {
    return 14;
  }
  else if ((x < -0.934 + accTol20 && x > -0.934 - accTol20) && (y < -0.125 + accTol20 && y > -0.125 - accTol20) && (z < 0.336 + accTol20 && z > 0.336 - accTol20)) {
    return 15;
  }
  else if ((x < 0.577 + accTol20 && x > 0.577 - accTol20) && (y < 0.747 + accTol20 && y > 0.747 - accTol20) && (z < -0.33 + accTol20 && z > -0.33 - accTol20)) {
    return 16;
  }
  else if ((x < -0.354 + accTol20 && x > -0.354 - accTol20) && (y < 0.872 + accTol20 && y > 0.872 - accTol20) && (z < 0.339 + accTol20 && z > 0.339 - accTol20)) {
    return 17;
  }
  else if ((x < -0.354 + accTol20 && x > -0.354 - accTol20) && (y < -0.872 + accTol20 && y > -0.872 - accTol20) && (z < -0.339 + accTol20 && z > -0.339 - accTol20)) {
    return 18;
  }
  else if ((x < 0.573 + accTol20 && x > 0.573 - accTol20) && (y < 0.337 + accTol20 && y > 0.337 - accTol20) && (z < 0.747 + accTol20 && z > 0.747 - accTol20)) {
    return 19;
  }
  else if ((x < 0.0 + accTol20 && x > 0.0 - accTol20) && (y < -0.006 + accTol20 && y > -0.006 - accTol20) && (z < -1.0 + accTol20 && z > -1.0 - accTol20)) {
    return 20;
  }
  else {
    return 0;
  }
}
