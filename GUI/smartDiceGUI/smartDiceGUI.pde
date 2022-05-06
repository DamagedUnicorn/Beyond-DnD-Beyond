// https://colab.research.google.com/drive/1rfc6Qd7l-PSdIHKEMnQdeImXL_XjI5-v?usp=sharing#scrollTo=l-8AvJV3T96e

import processing.serial.*;
import controlP5.*;

Serial port;
ControlP5 cp5;
PFont font;

String myPort = "/dev/cu.usbmodem14301";
final String characterId = "65349572"; // 65349572, 65602976
final String dndUrl = "https://character-service.dndbeyond.com/character/v3/character/";

JSONObject json;
JSONArray jsonStats;
JSONArray jsonClasses;
JSONArray jsonMod;
static String lineVal;    // Data received from the serial port
int sensorVal = 0;
int tmp;
int val;
int modifier;
String currentRoll = "Awating selection";
String name;

int[] coreStats = new int[6];
int[] modifiedStats = new int[6];
int[] savingThrowModifiers = new int[6];
int level;
int proficiencyBonus;

int s;
String subType;
String type;
String characterClass;

int[] abilityModifiers = new int[18];
int modValue;

PImage img;

final int statColors[] = {
//  color(242, 34, 34), // STR
//  color(34, 242, 41), // DEX
//  color(242, 165, 34), // CON
//  color(34, 152, 242), // INT
//  color(222, 216, 32), // WIS
//  color(222, 32, 216)  // CHA
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
  //size(600, 600);
  fullScreen();

  json = loadJSONObject(dndUrl + characterId).getJSONObject("data");
  jsonStats = json.getJSONArray("stats");
  jsonClasses = json.getJSONArray("classes");

  characterClass = jsonClasses.getJSONObject(0).getJSONObject("definition").getString("name");
  level = jsonClasses.getJSONObject(0).getInt("level");
  proficiencyBonus = getProficiencyBonus(level);
  
  img = loadImage("classSymbols/" + characterClass + ".png");
  img.resize(85, 85);
  

  for (int i = 0; i < 6; i++) {
    coreStats[i] = jsonStats.getJSONObject(i).getInt("value");
  }

  modifiedStats[0] = coreStats[0] + getStatModifiers("strength-score");
  modifiedStats[1] = coreStats[1] + getStatModifiers("dexterity-score");
  modifiedStats[2] = coreStats[2] + getStatModifiers("constitution-score");
  modifiedStats[3] = coreStats[3] + getStatModifiers("intelligence-score");
  modifiedStats[4] = coreStats[4] + getStatModifiers("wisdom-score");
  modifiedStats[5] = coreStats[5] + getStatModifiers("charisma-score");

  abilityModifiers[0]  = getModifierFromScore(modifiedStats[1]) + getProficiencyModifiers("acrobatics")      * proficiencyBonus;
  abilityModifiers[1]  = getModifierFromScore(modifiedStats[4]) + getProficiencyModifiers("animal-handling") * proficiencyBonus;
  abilityModifiers[2]  = getModifierFromScore(modifiedStats[3]) + getProficiencyModifiers("arcana")          * proficiencyBonus;
  abilityModifiers[3]  = getModifierFromScore(modifiedStats[0]) + getProficiencyModifiers("athletics")       * proficiencyBonus;
  abilityModifiers[4]  = getModifierFromScore(modifiedStats[5]) + getProficiencyModifiers("deception")       * proficiencyBonus;
  abilityModifiers[5]  = getModifierFromScore(modifiedStats[3]) + getProficiencyModifiers("history")         * proficiencyBonus;
  abilityModifiers[6]  = getModifierFromScore(modifiedStats[4]) + getProficiencyModifiers("insight")         * proficiencyBonus;
  abilityModifiers[7]  = getModifierFromScore(modifiedStats[5]) + getProficiencyModifiers("intimidation")    * proficiencyBonus;
  abilityModifiers[8]  = getModifierFromScore(modifiedStats[3]) + getProficiencyModifiers("investigation")   * proficiencyBonus;
  abilityModifiers[9]  = getModifierFromScore(modifiedStats[4]) + getProficiencyModifiers("medicine")        * proficiencyBonus;
  abilityModifiers[10] = getModifierFromScore(modifiedStats[3]) + getProficiencyModifiers("nature")          * proficiencyBonus;
  abilityModifiers[11] = getModifierFromScore(modifiedStats[4]) + getProficiencyModifiers("perception")      * proficiencyBonus;
  abilityModifiers[12] = getModifierFromScore(modifiedStats[5]) + getProficiencyModifiers("performance")     * proficiencyBonus;
  abilityModifiers[13] = getModifierFromScore(modifiedStats[5]) + getProficiencyModifiers("persuasion")      * proficiencyBonus;
  abilityModifiers[14] = getModifierFromScore(modifiedStats[3]) + getProficiencyModifiers("religion")        * proficiencyBonus;
  abilityModifiers[15] = getModifierFromScore(modifiedStats[1]) + getProficiencyModifiers("sleight-of-hand") * proficiencyBonus;
  abilityModifiers[16] = getModifierFromScore(modifiedStats[1]) + getProficiencyModifiers("stealth")         * proficiencyBonus;
  abilityModifiers[17] = getModifierFromScore(modifiedStats[4]) + getProficiencyModifiers("survival")        * proficiencyBonus;

  savingThrowModifiers[0] = getModifierFromScore(modifiedStats[0]) * getSavingThrowProficiencyModifiers("strength") * proficiencyBonus;
  savingThrowModifiers[1] = getModifierFromScore(modifiedStats[1]) * getSavingThrowProficiencyModifiers("dexterity") * proficiencyBonus;
  savingThrowModifiers[2] = getModifierFromScore(modifiedStats[2]) * getSavingThrowProficiencyModifiers("constitution") * proficiencyBonus;
  savingThrowModifiers[3] = getModifierFromScore(modifiedStats[3]) * getSavingThrowProficiencyModifiers("intelligence") * proficiencyBonus;
  savingThrowModifiers[4] = getModifierFromScore(modifiedStats[4]) * getSavingThrowProficiencyModifiers("wisdom") * proficiencyBonus;
  savingThrowModifiers[5] = getModifierFromScore(modifiedStats[5]) * getSavingThrowProficiencyModifiers("charisma") * proficiencyBonus;

  //println(coreStats);
  //println(modifiedStats);

  //println(abilityModifiers);

  name = json.getString("name");


  port = new Serial(this, myPort, 9600);

  //print(PFont.list());

  font = createFont("Serif", 18);
  cp5 = new ControlP5(this);

  cp5.addButton("check1") .setLabel("Acrobatics")    .setPosition(50, 100) .setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[1]);
  cp5.addButton("check2") .setLabel("Animal Hand.")  .setPosition(50, 200) .setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[4]);
  cp5.addButton("check3") .setLabel("Arcana")        .setPosition(50, 300) .setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[3]);
  cp5.addButton("check4") .setLabel("Athletics")     .setPosition(50, 400) .setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[0]);
  cp5.addButton("check5") .setLabel("Deception")     .setPosition(50, 500) .setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[5]);
  cp5.addButton("check6") .setLabel("History")       .setPosition(50, 600) .setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[3]);
  cp5.addButton("check7") .setLabel("Insight")       .setPosition(225, 100).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[4]);
  cp5.addButton("check8") .setLabel("Intimidation")  .setPosition(225, 200).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[5]);
  cp5.addButton("check9") .setLabel("Investigation") .setPosition(225, 300).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[3]);
  cp5.addButton("check10").setLabel("Medicine")      .setPosition(225, 400).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[4]);
  cp5.addButton("check11").setLabel("Nature")        .setPosition(225, 500).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[3]);
  cp5.addButton("check12").setLabel("Perception")    .setPosition(225, 600).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[4]);
  cp5.addButton("check13").setLabel("Performance")   .setPosition(400, 100).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[5]);
  cp5.addButton("check14").setLabel("Persuasion")    .setPosition(400, 200).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[5]);
  cp5.addButton("check15").setLabel("Religion")      .setPosition(400, 300).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[3]);
  cp5.addButton("check16").setLabel("Sleight of Ha.").setPosition(400, 400).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[1]);
  cp5.addButton("check17").setLabel("Stealth")       .setPosition(400, 500).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[1]);
  cp5.addButton("check18").setLabel("Survival")      .setPosition(400, 600).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[5]);

  cp5.addButton("save1").setLabel("STR save").setPosition(width/2-buttonWidth/2, 100).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[0]);
  cp5.addButton("save2").setLabel("DEX save").setPosition(width/2-buttonWidth/2, 200).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[1]);
  cp5.addButton("save3").setLabel("CON save").setPosition(width/2-buttonWidth/2, 300).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[2]);
  cp5.addButton("save4").setLabel("INT save").setPosition(width/2-buttonWidth/2, 400).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[3]);
  cp5.addButton("save5").setLabel("WIS save").setPosition(width/2-buttonWidth/2, 500).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[4]);
  cp5.addButton("save6").setLabel("CHA save").setPosition(width/2-buttonWidth/2, 600).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[5]);
}

void draw() {


  background(51);
  textSize(80);
  textAlign(CENTER, BOTTOM);
  text(val, width/2, height-40);

  textSize(40);
  text(currentRoll, width/2, height-140);

  text(name, width/2, 70);

  myRead();
  val = sensorVal + modifier;
  
  image(img, width/2 - 300, 5);
  
}

void controlEvent(CallbackEvent event) {
  if (event.getAction() == ControlP5.ACTION_CLICK) {
    switch(event.getController().getAddress()) {
    case "/check1":
      currentRoll = "Acrobatics";
      modifier = abilityModifiers[0];
      break;
    case "/check2":
      currentRoll = "Animal Handling";
      modifier = abilityModifiers[1];
      break;
    case "/check3":
      currentRoll = "Arcana";
      modifier = abilityModifiers[2];
      break;
    case "/check4":
      currentRoll = "Athletics";
      modifier = abilityModifiers[3];
      break;
    case "/check5":
      currentRoll = "Deception";
      modifier = abilityModifiers[4];
      break;
    case "/check6":
      currentRoll = "History";
      modifier = abilityModifiers[5];
      break;
    case "/check7":
      currentRoll = "Insight";
      modifier = abilityModifiers[6];
      break;
    case "/check8":
      currentRoll = "Intimidation";
      modifier = abilityModifiers[7];
      break;
    case "/check9":
      currentRoll = "Investigation";
      modifier = abilityModifiers[8];
      break;
    case "/check10":
      currentRoll = "Medicine";
      modifier = abilityModifiers[9];
      break;
    case "/check11":
      currentRoll = "Nature";
      modifier = abilityModifiers[10];
      break;
    case "/check12":
      currentRoll = "Perception";
      modifier = abilityModifiers[11];
      break;
    case "/check13":
      currentRoll = "Performance";
      modifier = abilityModifiers[12];
      break;
    case "/check14":
      currentRoll = "Persuasion";
      modifier = abilityModifiers[13];
      break;
    case "/check15":
      currentRoll = "Religion";
      modifier = abilityModifiers[14];
      break;
    case "/check16":
      currentRoll = "Sleight of Hand";
      modifier = abilityModifiers[15];
      break;
    case "/check17":
      currentRoll = "Stealth";
      modifier = abilityModifiers[16];
      break;
    case "/check18":
      currentRoll = "Survival";
      modifier = abilityModifiers[17];
      break;
    case "/save1":
      currentRoll = "STR save";
      modifier = savingThrowModifiers[0];
      break;
    case "/save2":
      currentRoll = "DEX save";
      modifier = savingThrowModifiers[1];
      break;
    case "/save3":
      currentRoll = "CON save";
      modifier = savingThrowModifiers[2];
      break;
    case "/save4":
      currentRoll = "INT save";
      modifier = savingThrowModifiers[3];
      break;
    case "/save5":
      currentRoll = "WIS save";
      modifier = savingThrowModifiers[4];
      break;
    case "/save6":
      currentRoll = "CHA save";
      modifier = savingThrowModifiers[5];
      break;
    }
  }
}

void myRead() {
  if ( port.available() > 0) {  // If data is available,
    lineVal = port.readStringUntil('\n'); 
    try {
      tmp = Integer.valueOf(lineVal.trim());
      if (tmp != 0) {
        sensorVal = tmp;
      }
    }
    catch(Exception e) {
      ;
    }
  }
}

int getProficiencyBonus(int lev) {
  if (lev <= 4) {
    return 2;
  } else if (lev <= 8) {
    return 3;
  } else if (lev <= 12) {
    return 4;
  } else if (lev <= 16) {
    return 5;
  } else {
    return 6;
  }
}

int getSavingThrowProficiencyModifiers(String skill) {
  int proficiencyMultiplier = 0;

  jsonMod = json.getJSONObject("modifiers").getJSONArray("race");
  s = jsonMod.size();
  for (int i = 0; i < s; i++) {
    type = jsonMod.getJSONObject(i).getString("type");
    subType = jsonMod.getJSONObject(i).getString("subType");
    if ((type.equals("proficiency")) && (subType.equals(skill + "-saving-throws"))) {
      proficiencyMultiplier = 1;
      break;
    }
  }

  jsonMod = json.getJSONObject("modifiers").getJSONArray("class");
  s = jsonMod.size();
  for (int i = 0; i < s; i++) {
    type = jsonMod.getJSONObject(i).getString("type");
    subType = jsonMod.getJSONObject(i).getString("subType");
    if ((type.equals("proficiency")) && (subType.equals(skill + "-saving-throws"))) {
      proficiencyMultiplier = 1;
      break;
    }
  }

  jsonMod = json.getJSONObject("modifiers").getJSONArray("background");
  s = jsonMod.size();
  for (int i = 0; i < s; i++) {
    type = jsonMod.getJSONObject(i).getString("type");
    subType = jsonMod.getJSONObject(i).getString("subType");
    if ((type.equals("proficiency")) && (subType.equals(skill + "-saving-throws"))) {
      proficiencyMultiplier = 1;
      break;
    }
  }

  jsonMod = json.getJSONObject("modifiers").getJSONArray("item");
  s = jsonMod.size();
  for (int i = 0; i < s; i++) {
    type = jsonMod.getJSONObject(i).getString("type");
    subType = jsonMod.getJSONObject(i).getString("subType");
    if ((type.equals("proficiency")) && (subType.equals(skill + "-saving-throws"))) {
      proficiencyMultiplier = 1;
      break;
    }
  }

  jsonMod = json.getJSONObject("modifiers").getJSONArray("feat");
  s = jsonMod.size();
  for (int i = 0; i < s; i++) {
    type = jsonMod.getJSONObject(i).getString("type");
    subType = jsonMod.getJSONObject(i).getString("subType");
    if ((type.equals("proficiency")) && (subType.equals(skill + "-saving-throws"))) {
      proficiencyMultiplier = 1;
      break;
    }
  }

  jsonMod = json.getJSONObject("modifiers").getJSONArray("condition");
  s = jsonMod.size();
  for (int i = 0; i < s; i++) {
    type = jsonMod.getJSONObject(i).getString("type");
    subType = jsonMod.getJSONObject(i).getString("subType");
    if ((type.equals("proficiency")) && (subType.equals(skill + "-saving-throws"))) {
      proficiencyMultiplier = 1;
      break;
    }
  }

  return proficiencyMultiplier;
}

int getProficiencyModifiers(String skill) {

  int proficiencyMultiplier = 0;

  jsonMod = json.getJSONObject("modifiers").getJSONArray("race");
  s = jsonMod.size();
  for (int i = 0; i < s; i++) {
    type = jsonMod.getJSONObject(i).getString("type");
    subType = jsonMod.getJSONObject(i).getString("subType");
    if ((type.equals("proficiency")) && (subType.equals(skill))) {
      proficiencyMultiplier = 1;
    } else if ((type.equals("expertise")) && (subType.equals(skill))) {
      proficiencyMultiplier = 2;
      break;
    }
  }

  jsonMod = json.getJSONObject("modifiers").getJSONArray("class");
  s = jsonMod.size();
  for (int i = 0; i < s; i++) {
    type = jsonMod.getJSONObject(i).getString("type");
    subType = jsonMod.getJSONObject(i).getString("subType");
    if ((type.equals("proficiency")) && (subType.equals(skill))) {
      proficiencyMultiplier = 1;
    } else if ((type.equals("expertise")) && (subType.equals(skill))) {
      proficiencyMultiplier = 2;
      break;
    }
  }

  jsonMod = json.getJSONObject("modifiers").getJSONArray("background");
  s = jsonMod.size();
  for (int i = 0; i < s; i++) {
    type = jsonMod.getJSONObject(i).getString("type");
    subType = jsonMod.getJSONObject(i).getString("subType");
    if ((type.equals("proficiency")) && (subType.equals(skill))) {
      proficiencyMultiplier = 1;
    } else if ((type.equals("expertise")) && (subType.equals(skill))) {
      proficiencyMultiplier = 2;
      break;
    }
  }

  jsonMod = json.getJSONObject("modifiers").getJSONArray("item");
  s = jsonMod.size();
  for (int i = 0; i < s; i++) {
    type = jsonMod.getJSONObject(i).getString("type");
    subType = jsonMod.getJSONObject(i).getString("subType");
    if ((type.equals("proficiency")) && (subType.equals(skill))) {
      proficiencyMultiplier = 1;
    } else if ((type.equals("expertise")) && (subType.equals(skill))) {
      proficiencyMultiplier = 2;
      break;
    }
  }

  jsonMod = json.getJSONObject("modifiers").getJSONArray("feat");
  s = jsonMod.size();
  for (int i = 0; i < s; i++) {
    type = jsonMod.getJSONObject(i).getString("type");
    subType = jsonMod.getJSONObject(i).getString("subType");
    if ((type.equals("proficiency")) && (subType.equals(skill))) {
      proficiencyMultiplier = 1;
    } else if ((type.equals("expertise")) && (subType.equals(skill))) {
      proficiencyMultiplier = 2;
      break;
    }
  }

  jsonMod = json.getJSONObject("modifiers").getJSONArray("condition");
  s = jsonMod.size();
  for (int i = 0; i < s; i++) {
    type = jsonMod.getJSONObject(i).getString("type");
    subType = jsonMod.getJSONObject(i).getString("subType");
    if ((type.equals("proficiency")) && (subType.equals(skill))) {
      proficiencyMultiplier = 1;
    } else if ((type.equals("expertise")) && (subType.equals(skill))) {
      proficiencyMultiplier = 2;
      break;
    }
  }

  return proficiencyMultiplier;
}


int getStatModifiers(String skill) {

  int modValueTmp = 0;

  jsonMod = json.getJSONObject("modifiers").getJSONArray("race");
  s = jsonMod.size();
  for (int i = 0; i < s; i++) {
    type = jsonMod.getJSONObject(i).getString("type");
    subType = jsonMod.getJSONObject(i).getString("subType");
    if ((type.equals("bonus")) && (subType.equals(skill))) {
      modValueTmp = modValueTmp + jsonMod.getJSONObject(i).getInt("fixedValue");
    }
  }

  jsonMod = json.getJSONObject("modifiers").getJSONArray("class");
  s = jsonMod.size();
  for (int i = 0; i < s; i++) {
    type = jsonMod.getJSONObject(i).getString("type");
    subType = jsonMod.getJSONObject(i).getString("subType");
    if ((type.equals("bonus")) && (subType.equals(skill))) {
      modValueTmp = modValueTmp + jsonMod.getJSONObject(i).getInt("fixedValue");
    }
  }

  jsonMod = json.getJSONObject("modifiers").getJSONArray("background");
  s = jsonMod.size();
  for (int i = 0; i < s; i++) {
    type = jsonMod.getJSONObject(i).getString("type");
    subType = jsonMod.getJSONObject(i).getString("subType");
    if ((type.equals("bonus")) && (subType.equals(skill))) {
      modValueTmp = modValueTmp + jsonMod.getJSONObject(i).getInt("fixedValue");
    }
  }

  jsonMod = json.getJSONObject("modifiers").getJSONArray("item");
  s = jsonMod.size();
  for (int i = 0; i < s; i++) {
    type = jsonMod.getJSONObject(i).getString("type");
    subType = jsonMod.getJSONObject(i).getString("subType");
    if ((type.equals("bonus")) && (subType.equals(skill))) {
      modValueTmp = modValueTmp + jsonMod.getJSONObject(i).getInt("fixedValue");
    }
  }

  jsonMod = json.getJSONObject("modifiers").getJSONArray("feat");
  s = jsonMod.size();
  for (int i = 0; i < s; i++) {
    type = jsonMod.getJSONObject(i).getString("type");
    subType = jsonMod.getJSONObject(i).getString("subType");
    if ((type.equals("bonus")) && (subType.equals(skill))) {
      modValueTmp = modValueTmp + jsonMod.getJSONObject(i).getInt("fixedValue");
    }
  }

  jsonMod = json.getJSONObject("modifiers").getJSONArray("condition");
  s = jsonMod.size();
  for (int i = 0; i < s; i++) {
    type = jsonMod.getJSONObject(i).getString("type");
    subType = jsonMod.getJSONObject(i).getString("subType");
    if ((type.equals("bonus")) && (subType.equals(skill))) {
      modValueTmp = modValueTmp + jsonMod.getJSONObject(i).getInt("fixedValue");
    }
  }

  return modValueTmp;
}


int getModifierFromScore(int score) {
  return floor((score - 10) / 2);
}
