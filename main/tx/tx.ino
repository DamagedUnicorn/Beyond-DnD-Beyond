#include <Wire.h>
#include <RH_ASK.h>
#include <SPI.h>
//https://randomnerdtutorials.com/rf-433mhz-transmitter-receiver-module-with-arduino/
//https://www.lattepanda.com/topic-f10t1931.html

RH_ASK rf_driver;
const int MPU6050 = 0x68; // I2C address of the MPU-6050
float AcX, AcY, AcZ, Tmp, GyX, GyY, GyZ;
uint8_t d20Side;
const float accTol20 = 0.1;
const float xCoordinates[20] = {0.0, -0.573, 0.354, 0.354, -0.577, 0.934, -0.573, 0.0, 0.934, -0.577, 0.577, -0.934, 0.0, 0.573, -0.934, 0.577, -0.354, -0.354, 0.573, 0.0};
const float yCoordinates[20] = {0.006, -0.337, 0.872, -0.872, -0.747, 0.125, 0.337, 0.664, -0.125, 0.747, -0.747, 0.125, -0.664, -0.337, -0.125, 0.747, 0.872, -0.872, 0.337, -0.006};
const float zCoordinates[20] = {1.0, -0.747, 0.339, -0.339, 0.33, -0.336, 0.747, -0.748, 0.336, -0.33, 0.33, -0.336, 0.748, -0.747, 0.336, -0.33, 0.339, -0.339, 0.747, -1.0};

float mean;
float variance;
const int Nvar = 20;
float stdArray[Nvar] = {};

void setup()
{
  rf_driver.init();

  Serial.begin(9600);

  Wire.begin();
  Wire.beginTransmission(MPU6050);
  Wire.write(0x6B);  // PWR_MGMT_1 register
  Wire.write(0);     // set to zero (wakes up the MPU-6050)
  Wire.endTransmission(true);

  Wire.beginTransmission(MPU6050);
  Wire.write(0x1C); // Component - 0x1C = Accelerometer - 0x1B = Gyro
  Wire.write(0x10); // Set Accelerometer Full Scale Range ( ±2g = 0x00 ±4g=0x01 ±8g=0x10, ±16g = 0x11 )
  Wire.endTransmission(true);

  Wire.beginTransmission(MPU6050);
  Wire.write(0x1B); // Component - 0x1C = Accelerometer - 0x1B = Gyro
  Wire.write(0x11); // Set Gyro Full Scale Range (±250 = 0x00, ±500 = 0x01, ±1000 = 0x10, ±2000 = 0x11)
  Wire.endTransmission(true);
}

void loop()
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

  AcX = (0.00024405125076266016 * AcX) - 0.03965832824893223;
  AcY = (0.0002442002442002442 *  AcY) + 0.006105006105006083;
  AcZ = (0.00023923444976076556 * AcZ) + 0.14832535885167464;

  variance = 0;
  mean = 0;
  for (int i = 0; i < Nvar - 1; i++) {
    stdArray[i] = stdArray[i + 1];
  }
  stdArray[Nvar - 1] = AcX;
  for (int i = 0; i < Nvar; i++){
    mean += stdArray[i];
    }
  mean /= Nvar;
  for (int i = 0; i < Nvar; i++) {
    stdArray[i] -= mean;
   variance += pow(stdArray[i], 2);
  }
  variance /= Nvar;
  Serial.println(variance, 5);
  //Serial.println(mean);
  


  //d20Side = d20(AcX, AcY, AcZ);
  //sendPackage(d20Side);


}
