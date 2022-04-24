// MPU-6050 Short Example Sketch
// By Arduino User JohnChi
// August 17, 2014
// Public Domain

#include<Wire.h>

const int MPU6050 = 0x68; // I2C address of the MPU-6050

int AcX, AcY, AcZ, Tmp, GyX, GyY, GyZ;

double GX = 0, GY = 0, GZ = 0;
double gennem_x, gennem_y, gennem_z;
float ite = 10000;

void setup() {

  Serial.begin(9600);

  Wire.begin();
  Wire.beginTransmission(MPU6050);
  Wire.write(0x6B);  // PWR_MGMT_1 register
  Wire.write(0);     // set to zero (wakes up the MPU-6050)
  Wire.endTransmission(true);

  Wire.beginTransmission(MPU6050);
  Wire.write(0x1C); // Component - 0x1C = Accelerometer - 0x1B = Gyro
  Wire.write(0x10); // Set Accelerometer Full Scale Range (±2g = 0x00 ±4g=0x01 ±8g=0x10, ±16g = 0x11)
  Wire.endTransmission(true);

  Wire.beginTransmission(MPU6050);
  Wire.write(0x1B); // Component - 0x1C = Accelerometer - 0x1B = Gyro
  Wire.write(0x10); // Set Gyro Full Scale Range (±250 = 0x00, ±500 = 0x01, ±1000 = 0x10, ±2000 = 0x11)
  Wire.endTransmission(true);

}

void loop() {

  for (int i = 0; i < ite; i++)
  {
    Wire.beginTransmission(MPU6050);
    Wire.write(0x3B);  // starting with register 0x3B (ACCEL_XOUT_H)
    Wire.endTransmission(false);
    Wire.requestFrom(MPU6050, 14, true); // request a total of 14 registers

    AcX = Wire.read() << 8 | Wire.read(); // 0x3B (ACCEL_XOUT_H) & 0x3C (ACCEL_XOUT_L)
    AcY = Wire.read() << 8 | Wire.read(); // 0x3D (ACCEL_YOUT_H) & 0x3E (ACCEL_YOUT_L)
    AcZ = Wire.read() << 8 | Wire.read(); // 0x3F (ACCEL_ZOUT_H) & 0x40 (ACCEL_ZOUT_L)
    Tmp = Wire.read() << 8 | Wire.read(); // 0x41 (TEMP_OUT_H) & 0x42 (TEMP_OUT_L)
    GyX = Wire.read() << 8 | Wire.read(); // 0x43 (GYRO_XOUT_H) & 0x44 (GYRO_XOUT_L)
    GyY = Wire.read() << 8 | Wire.read(); // 0x45 (GYRO_YOUT_H) & 0x46 (GYRO_YOUT_L)
    GyZ = Wire.read() << 8 | Wire.read(); // 0x47 (GYRO_ZOUT_H) & 0x48 (GYRO_ZOUT_L)

    GX = GX + GyX;
    GY = GY + GyY;
    GZ = GZ + GyZ;
    
    //Serial.print("i = ");
    //Serial.println(i);
    
    if (i == ite - 1)
    {
      gennem_x = GX / ite;
      gennem_y = GY / ite;
      gennem_z = GZ / ite;

      Serial.print(gennem_x);
      Serial.print(" ");
      Serial.print(gennem_y);
      Serial.print(" ");
      Serial.println(gennem_z);

      /*
      Serial.println("-------------------");
      Serial.print("iteration number : "); Serial.println(p);
      Serial.print("Average value in X is = "); Serial.println(gennem_x);
      Serial.print("Average value in Y is = "); Serial.println(gennem_y);
      Serial.print("Average value in Z is = "); Serial.println(gennem_z);
      Serial.println("-------------------");
      Serial.println(" ");
      */

      GX = 0; GY = 0; GZ = 0;
      gennem_x = 0; gennem_y = 0; gennem_z = 0;
      i = 0;
    }
  }

}

