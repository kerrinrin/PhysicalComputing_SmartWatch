
const int tempPin =2;




void setupTemp() {
  
  Serial.begin(9600);
  pinMode(buttonPin, INPUT);
  
}

void startTemp() 


{
  
  

  
  

  
  
 float voltage, degreesF, degreesC;
  
  voltage = analogRead(tempPin) * 0.004882814;
 

  degreesC = (voltage - 0.5) * 100.0;



  degreesF = degreesC * (9.0/5.0) + 32.0;
  
 
 
 Serial.print("beginTemp");
Serial.print(degreesF);
 Serial.println("endTemp");
  
  delay(100);
  
}
