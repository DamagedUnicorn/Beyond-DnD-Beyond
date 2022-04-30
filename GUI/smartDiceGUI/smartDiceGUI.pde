// https://colab.research.google.com/drive/1rfc6Qd7l-PSdIHKEMnQdeImXL_XjI5-v?usp=sharing#scrollTo=l-8AvJV3T96e

import processing.serial.*;
import controlP5.*;

Serial port;
ControlP5 cp5;
PFont font;

String myPort = "/dev/cu.usbmodem14301";
final String characterId = "65349572";
final String dndUrl = "https://character-service.dndbeyond.com/character/v3/character/";

JSONObject json;
JSONArray jsonStats;
static String lineVal;    // Data received from the serial port
int sensorVal = 0;
int tmp;
int val;
int modifier;
String currentRoll = "Awating selection";
String name;

int[] coreStats = new int[6];


final int statColors[] = {
  color(242, 34, 34), // STR
  color(34, 242, 41), // DEX
  color(242, 165, 34), // CON
  color(34, 152, 242), // INT
  color(222, 216, 32), // WIS
  color(222, 32, 216)  // CHA
};

final int buttonWidth = 150;
final int buttonHeight = 70;

void setup() {
  //size(600, 600);
  fullScreen();

  json = loadJSONObject(dndUrl + characterId).getJSONObject("data");
  jsonStats = json.getJSONArray("stats");

  for (int i = 0; i < 6; i++) {
    coreStats[i] = jsonStats.getJSONObject(i).getInt("value");
  }

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


  //cp5.addButton("B")  //The button
  //  .setLabel("Perception")
  //  .setPosition(225, 100)  //x and y coordinates of upper left corner of button
  //  .setSize(buttonWidth, buttonHeight)      //(width, height)
  //  .setFont(font);

  //cp5.addButton("C")  //The button
  //  .setLabel("DEX Save")
  //  .setPosition(400, 100)  //x and y coordinates of upper left corner of button
  //  .setSize(buttonWidth, buttonHeight)      //(width, height)
  //  .setFont(font);
}

void draw() {


  background(0);
  textSize(80);
  textAlign(CENTER, BOTTOM);
  text(val, width/2, height-40);

  textSize(40);
  text(currentRoll, width/2, height-140);

  text(name, width/2, 70);

  myRead();
  val = sensorVal + modifier;
}

void controlEvent(CallbackEvent event) {
  if (event.getAction() == ControlP5.ACTION_CLICK) {
    switch(event.getController().getAddress()) {
    case "/check1":
      currentRoll = "Acrobatics";
      modifier = 0;
      break;
    case "/check2":
      currentRoll = "Animal Handling";
      modifier = 0;
      break;
    case "/check3":
      currentRoll = "Arcana";
      modifier = 0;
      break;
    case "/check4":
      currentRoll = "Athletics";
      modifier = 0;
      break;
    case "/check5":
      currentRoll = "Deception";
      modifier = 0;
      break;
    case "/check6":
      currentRoll = "History";
      modifier = 0;
      break;
    case "/check7":
      currentRoll = "Insight";
      modifier = 0;
      break;
    case "/check8":
      currentRoll = "Intimidation";
      modifier = 0;
      break;
    case "/check9":
      currentRoll = "Investigation";
      modifier = 0;
      break;
    case "/check10":
      currentRoll = "Medicine";
      modifier = 0;
      break;
    case "/check11":
      currentRoll = "Nature";
      modifier = 0;
      break;
    case "/check12":
      currentRoll = "Perception";
      modifier = 0;
      break;
    case "/check13":
      currentRoll = "Performance";
      modifier = 0;
      break;
    case "/check14":
      currentRoll = "Persuasion";
      modifier = 0;
      break;
    case "/check15":
      currentRoll = "Religion";
      modifier = 0;
      break;
    case "/check16":
      currentRoll = "Sleight of Hand";
      modifier = 0;
      break;
    case "/check17":
      currentRoll = "Stealth";
      modifier = 0;
      break;
    case "/check18":
      currentRoll = "Survival";
      modifier = 0;
      break;
      //case "/B":
      //  currentRoll = "Perception";
      //  modifier = 0;
      //  break;
      //case "/C":
      //  currentRoll = "DEX save";
      //  modifier = 7;
      //  break;
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
