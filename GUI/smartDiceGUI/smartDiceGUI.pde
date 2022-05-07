// inspiration
// https://colab.research.google.com/drive/1rfc6Qd7l-PSdIHKEMnQdeImXL_XjI5-v?usp=sharing#scrollTo=l-8AvJV3T96e

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

// temporary structures
static String lineVal; // Data received from the serial port
int tmp;
int size_;

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

// image
PImage img;

// button
final int statColors[] = {
  color(153, 65, 54),   // STR
  color(73, 91, 74),    // DEX
  color(205, 136, 59),  // CON
  color(61, 90, 128),   // INT
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
  getStatsAndModifiers();

  img = loadImage("classSymbols/" + characterClass + ".png");
  img.resize(85, 85);

  addButton();
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
