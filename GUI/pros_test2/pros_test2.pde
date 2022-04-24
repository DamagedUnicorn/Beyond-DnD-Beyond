import controlP5.*;
import processing.serial.*;
ControlP5 cp5;
//PFont font;
Serial port;
int val;

void setup(){
  
size(300, 450); 
port = new Serial(this, "/dev/cu.usbmodem14301", 9600);
cp5 = new ControlP5(this);


//font = createFont("calibri light bold", 20);


cp5.addNumberbox("temp").setPosition(100,160)
.setSize(120,70).setValue(0);//.setFont(font);
}
void draw(){
background(150, 0 , 150);
fill(0, 255, 0); 
//textFont(font);
//text("CONTROL", 80, 30);
if ( port.available() > 0) 
{ 
  val = port.read();
  cp5.get("temp").setValue(val);
}
}
