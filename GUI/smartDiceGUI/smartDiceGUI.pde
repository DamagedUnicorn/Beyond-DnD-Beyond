import processing.serial.*;
import controlP5.*;

Serial port;
ControlP5 cp5;
PFont font;

String myPort = "/dev/cu.usbmodem14301";
final String characterId = "65349572";
final String dndUrl = "https://character-service.dndbeyond.com/character/v3/character/";

JSONObject json;
static String lineVal;    // Data received from the serial port
int sensorVal = 0;
int tmp;
int val;
int modifier;
String currentRoll = "Awating selection";
String name;

void setup() {
  size(600, 600);

  json = loadJSONObject(dndUrl + characterId).getJSONObject("data");
  
  name = json.getString("name");
  

  port = new Serial(this, myPort, 9600);

  //print(PFont.list());

  font = createFont("Serif", 20);
  cp5 = new ControlP5(this);

  cp5.addButton("A")  //The button
    .setLabel("Attack")
    .setPosition(50, 100)  //x and y coordinates of upper left corner of button
    .setSize(150, 70)      //(width, height)
    .setFont(font);

  cp5.addButton("B")  //The button
    .setLabel("Perception")
    .setPosition(225, 100)  //x and y coordinates of upper left corner of button
    .setSize(150, 70)      //(width, height)
    .setFont(font);

  cp5.addButton("C")  //The button
    .setLabel("DEX Save")
    .setPosition(400, 100)  //x and y coordinates of upper left corner of button
    .setSize(150, 70)      //(width, height)
    .setFont(font);
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
    case "/A":
      currentRoll = "Attack";
      modifier = 7;
      break;
    case "/B":
      currentRoll = "Perception";
      modifier = 0;
      break;
    case "/C":
      currentRoll = "DEX save";
      modifier = 7;
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
