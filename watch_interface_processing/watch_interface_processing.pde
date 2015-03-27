import processing.serial.*;

Serial myPort;
String val;
String temp;
String heartRate;

int width = 640;
int height = 480;
int buttonNum = 1;
String s2;
String m2;
PShape heart;
PImage heartNone;

long lastTempTime = 0;
long timer;
long lastPulsePrint = 0;
long start = 0;

void setup() {

  size(width, height);
  heart = loadShape("heart.svg");
  heartNone = loadImage("heartOutline.png");

  lastTempTime = millis();
  lastPulsePrint = millis();

  String portName = Serial.list()[5]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
};









void draw() {




  if ( myPort.available() > 0) 
  {  // If data is available,
    val = myPort.readStringUntil('\n');         // read it and store it in val
  } 

  if (val != null) {  
    println(val);
  } 






  background(0);



if(start < 3000) {
  
  start = millis();
}


  else {
      if (val != null && val.contains("buttonPressed")) {
if((millis() - lastPulsePrint) > 200) {
    buttonPressed();
    
      lastPulsePrint = millis();
}
  }   
  
  }
  



  fill(31, 156, 234);

  switch(buttonNum) {
  case 1: 
    getTime();
    break;



  case 2:
    textSize(120);
    //pulse

    getHeartRate();
    break;

  case 3:
    getTemp();
    break;

  default:
    getTime();
    break;
  };
};

void buttonPressed() {







  buttonNum += 1;

  if (buttonNum > 3) {
    buttonNum = 1;
  }

  //  println(buttonNum);
}


void getHeartRate() {


  if (val != null) {

    heartRate = val.substring(val.lastIndexOf("BPMStart")+8, val.lastIndexOf("BPMEnd"));
    //println("Heart Rate " + heartRate);
  } 

  textSize(100);
  text(heartRate + " BPM", width/3, height/2);
  if (val != null && val.contains("beat")) {

    timer = millis();
  }
  if ( (millis() - timer) < 200) {

    shape(heart, 80, 150, 80, 80);
  } else {
    image(heartNone, 80, 150, 100, 100);
  }
}

void getTemp() {


  if (val != null) {

    if (millis() - lastTempTime > 2000) {


      temp = val.substring(val.lastIndexOf("beginTemp")+9, val.lastIndexOf("endTemp"));
      // println("Temperature: " + temp);

      lastTempTime = millis();
    }
  }



  textSize(120);
  text(temp + "°F", width/8, height/2);
}

void getTime() {

  int s = second();
  int m = minute();
  int h = hour();


  // standard time
  if (h > 12) {

    h -= 12;
  } else if (h == 0) {
    h= 12;
  }

  // fix to second single digit
  if (s < 10) {
    s2 = str(s);
    s2 ="0" + s2;
  } else {
    s2 = str(s);
  }

  //fix to minute single digit

  if (m < 10) {
    m2 = str(m);
    m2 ="0" + m2;
  } else {
    m2 = str(m);
  }



  textSize(140);
  text( h +":" + m2+ ":" + s2, width/8, height/2);

  //get month
  int monthNum = month();
  int day = day();
  int year = year();


  String[] month = new String[13];
  month[0] = "None";
  month[1] = "Janaury";
  month[2] = "February";
  month[3]= "March";
  month[4] = "April";
  month[5] = "May";
  month[6] ="June";
  month[7] = "July";
  month[8] = "August";
  month[9] = "September";
  month[10] = "October";
  month[11] = "November";
  month[12] = "December";

  textSize(50);
  text(month[monthNum]+ " " + day + ", " + year, width/8, height/1.6);
} 




