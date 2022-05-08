// inspiration
// https://colab.research.google.com/drive/1rfc6Qd7l-PSdIHKEMnQdeImXL_XjI5-v?usp=sharing#scrollTo=l-8AvJV3T96e

// POSSIBILITIES
// in JSON under inventory, find items with equipped=true
// if they have filterType=Weapon or damage in tags or some other indicator
// then fetch name
// if two of the same are equipped and two weapon fighting, make one main and off hand
// to find modifier: if finesse max(str, dex) ortherwise str, if profficient add prof bonus

// library import
import processing.serial.*;
import controlP5.*;

// serial communication
Serial port;
final String myPort = "/dev/cu.usbmodem14301";

// D&D Beyond information
final String characterId = "65349572"; // 65349572, 65602976
final String dndUrl = "https://character-service.dndbeyond.com/character/v3/character/";

// text formatting
PFont font;

// controlP5 instance
ControlP5 cp5;

// JSON structures
JSONObject json;
JSONArray jsonStats;
JSONArray jsonClasses;
JSONArray jsonMod;
JSONArray jsonInventory;

// temporary structures
static String lineVal; // Data received from the serial port
int tmp;
String tmpWeapon;
int size_;
int size_2;
//boolean isEquipped;

// sensor and modifier  srtructures
int sensorVal = 0;
int modifier;
String currentRoll = "Awating selection";
int modValue;

// character information
int[] coreStats = new int[6];
int[] modifiedStats = new int[6];
int[] savingThrowModifiers = new int[6];
int[] abilityModifiers = new int[18];
int level;
int proficiencyBonus;
String subType;
String type;
String characterClass;
String name;

// Attacks
int weaponListLen = 10;
String[] weapons = new String[weaponListLen];
boolean[] isWeaponLight = new boolean[weaponListLen];
boolean[] isWeaponLightZeroMultiplier = new boolean[weaponListLen];
boolean[] isWeaponFinesse = new boolean[weaponListLen];
int[] weaponsModifiers = new int[weaponListLen];

// image
PImage img;

// button
final int statColors[] = {
  color(153, 65, 54), // STR
  color(73, 91, 74), // DEX
  color(205, 136, 59), // CON
  color(61, 90, 128), // INT
  color(173, 173, 173), // WIS
  color(152, 120, 139)  // CHA
};

final int buttonWidth = 150;
final int buttonHeight = 70;

void setup() {

  fullScreen();

  port = new Serial(this, myPort, 9600);

  font = createFont("Serif", 18);
  cp5 = new ControlP5(this);

  getJSONData();
  findEquippedWeapons();
  getStatsAndModifiers();

  setupClassSymbol();

  addButtons();
}

void draw() {

  background(51);
  textSize(80);
  textAlign(CENTER, BOTTOM);

  if (modifier >= 0) {
    text(sensorVal + "+" + modifier + "=" + (sensorVal + modifier), width/2, height-40);
  } else {
    text(sensorVal + "" + modifier + "=" + (sensorVal + modifier), width/2, height-40);
  }

  textSize(40);
  text(currentRoll, width/2, height-140);

  text(name, width/2, 70);

  myRead();

  image(img, width/2 - 300, 5);
}
