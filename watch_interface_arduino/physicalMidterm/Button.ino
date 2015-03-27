const int buttonPin = 3;
int buttonState;
int lastButtonState = LOW;

long lastDebounceTime = 0;
long debounceDelay = 100;




void setupButton() {  
  Serial.begin(9600);
  pinMode(buttonPin, INPUT);
  lastPrintTime = millis();

  
}

void startButton() {
  

  

 
 
// read the state of the switch
 int reading = digitalRead(buttonPin);
 
 
   // check to see if you just pressed the button 
  // (i.e. the input went from LOW to HIGH),  and you've waited 
  // long enough since the last press to ignore any noise:  

  // If the switch changed, due to noise or pressing:
 if(reading != lastButtonState) {
   
  lastDebounceTime = millis(); 
 }


if((millis() - lastDebounceTime) > debounceDelay) {
  // whatever the reading is at, it's been there for longer
    // than the debounce delay, so take it as the actual current state:
 
 //if the button state has changed:
     if (reading != buttonState) {
       buttonState = reading;
       
       // only toogle the LED if the new switch state is high 
       if(buttonState == HIGH) {
        
         
         
         Serial.print("buttonPressed");
         
       }
  
    }
}



//save the reading so next time it goes through the loop it will be the last switch state
lastButtonState = reading;

}
