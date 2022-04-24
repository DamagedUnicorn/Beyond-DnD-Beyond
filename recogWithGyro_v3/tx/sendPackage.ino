void sendPackage(uint8_t message) {
  String str = String(message);
  const int str_len = str.length() + 1;
  char msg[str_len];
  str.toCharArray(msg, str_len);
  rf_driver.send((uint8_t *)msg, strlen(msg));
  rf_driver.waitPacketSent();
}
