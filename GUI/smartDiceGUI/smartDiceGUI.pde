// inspiration
// https://colab.research.google.com/drive/1rfc6Qd7l-PSdIHKEMnQdeImXL_XjI5-v?usp=sharing#scrollTo=l-8AvJV3T96e

// spells
// under classSpells
// the id can be mapped to characterValues to get name
// attackType=2 might indicate if a hit roll is needed or maybe if "Damage" is in tags


// library import
import processing.serial.*;
import controlP5.*;

// serial communication
Serial port;
final String myPort = "/dev/cu.usbmodem14301";

// D&D Beyond information
final int characterId = 45441447; // Steve 65349572, Spelta 65602976, Dagnathoin 65349741, Tim 65358232, Torben 26054991, BS 45441447
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
int jsonInventoryId;
int jsonSpellId;
JSONArray jsonCharacterValues;
//JSONArray jsonClassSpells;
final String modifierOrigins[] = {"race", "class", "background", "item", "feat", "condition"};

// temporary structures
static String lineVal; // Data received from the serial port
int tmp;
String tmpWeapon;
int size_;
int size_2;
//boolean isEquipped;
boolean COMPortTrue;

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
int weaponListLen = 18;
int numberOfweapons = 0;
int numberOfSpells = 0;
//String[] weapons = new String[weaponListLen];
String[] weaponName = new String[weaponListLen];
String[] weaponType = new String[weaponListLen];
boolean[] isWeaponLight = new boolean[weaponListLen];
boolean[] isWeaponLightZeroMultiplier = new boolean[weaponListLen];
boolean[] isWeaponFinesse = new boolean[weaponListLen];
int[] weaponsModifiers = new int[weaponListLen];
int[] weaponsBonus = new int[weaponListLen];
int attackButtonCounter = 0;
final String simpleWeapons[] = {
  "Club", 
  "Dagger", 
  "Greatclub", 
  "Handaxe", 
  "Javellin", 
  "Light-hammer", 
  "Mace", 
  "Quarterstaff", 
  "Sickle", 
  "spear", 
  "Crossbow, light", 
  "Dart", 
  "Shortbow", 
  "Sling"
};

final String martialWeapons[] = {
  "Battleaxe", 
  "Flail", 
  "Glaive", 
  "Greataxe", 
  "Greatsword", 
  "Halberd", 
  "Lance", 
  "Longsword", 
  "Maul", 
  "Morningstar", 
  "Pike", 
  "Rapier", 
  "Scimitar", 
  "Shortsword", 
  "Trident", 
  "war-pick", 
  "Warhammer", 
  "Whip", 
  "Blowgun", 
  "Crossbow, hand", 
  "Crossbow, heavy", 
  "Longbow", 
  "Net"
};

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
  try {
    port = new Serial(this, myPort, 9600);
    COMPortTrue = true;
  }    
  catch(Exception e) {
    COMPortTrue = false;
  }
  font = createFont("Serif", 18);
  cp5 = new ControlP5(this);

  getJSONData();
  findEquippedWeapons();
  findSpells();
  //print(weaponName);
  //print(weaponsModifiers);
  //print(weaponType);
  //print(numberOfweapons);
  
  getStatsAndModifiers();
  //print(isWeaponProficiency(weaponType[0]));
  //println(weaponsBonus);

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

  myRead(COMPortTrue);

  image(img, width/2 - 400, 5);
}
