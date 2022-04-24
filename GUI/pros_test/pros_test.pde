import controlP5.*; //import ControlP5 library
import processing.serial.*;

Serial port;

ControlP5 cp5; //create ControlP5 object

void setup(){ //Same as setup in arduino
  
  size(300, 300);                          //Window size, (width, height)
  port = new Serial(this, "/dev/cu.usbmodem14301", 9600);   //Change this to your port
  
  cp5 = new ControlP5(this);
  
  cp5.addButton("Button")  //The button
    .setPosition(90, 100)  //x and y coordinates of upper left corner of button
    .setSize(120, 70)      //(width, height)
  ;     

}

void draw(){  //Same as loop in arduino

  background(150, 0 , 150); //Background colour of window (r, g, b) or (0 to 255)
    
}

void Button(){
  
  port.write('t');
  
}
