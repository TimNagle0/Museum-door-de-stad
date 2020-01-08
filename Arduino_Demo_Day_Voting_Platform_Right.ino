/* This program was created for a museum installation made for "Museum door de Stad", an initiative by Eindhoven Museum and Studio Soeps 
 *  The program operates the right part of the voting platform that is part of the installation and send its data to Processing using Serial Communication
 *  Made by Tim Naglé as part of the faculty of Industrial Design of TU/e
 */
#include <Adafruit_NeoPixel.h>
#include <ColorSensor.h>

//Define the pins for the LED strips
#define LED_PIN_CULTURE 6
#define LED_PIN_LIVING 31
#define LED_PIN_ECONOMY 46

//Define the amount of LEDs per strip
#define LED_AMOUNT 6

//Define all the buttons pins and store their positions in an array
#define button_1_culture  13
#define button_2_culture  10
#define button_3_culture  12
#define button_4_culture  7
#define button_5_culture  8
#define button_6_culture  11
int buttons_culture [6] = {button_1_culture,button_2_culture,button_3_culture,button_4_culture,button_5_culture,button_6_culture};

#define button_1_living 25
#define button_2_living 27
#define button_3_living 26
#define button_4_living 22
#define button_5_living 23
#define button_6_living 24
int buttons_living [6] = {button_1_living,button_2_living,button_3_living,button_4_living,button_5_living,button_6_living};

#define button_1_economy 52
#define button_2_economy 49
#define button_3_economy 50
#define button_4_economy 51
#define button_5_economy 53
#define button_6_economy 48
int buttons_economy [6] = {button_1_economy,button_2_economy,button_3_economy,button_4_economy,button_5_economy,button_6_economy};

//Initiate the LED strips
Adafruit_NeoPixel culture_strip(LED_AMOUNT,LED_PIN_CULTURE);
Adafruit_NeoPixel living_strip(LED_AMOUNT,LED_PIN_LIVING);
Adafruit_NeoPixel economy_strip(LED_AMOUNT,LED_PIN_ECONOMY);

//Create an array for the possible colors
uint32_t colors [8] = {culture_strip.Color(255,0,0),
                     culture_strip.Color(0,0,255),
                     culture_strip.Color(0,255,0),
                     culture_strip.Color(255,100,0),
                     culture_strip.Color (255,255,0),
                     culture_strip.Color(0,255,255),
                     culture_strip.Color(255,0,255),
                     culture_strip.Color(100,0,255),
};

//Variable for sending data to Processing
String readString, data;

void setup() {
  //Set up Serial Communication
  Serial.begin(9600);
  while(!Serial){
    ;
  }
  //Set up LED strips
  culture_strip.begin();
  culture_strip.show();
  living_strip.begin();
  living_strip.show();
  economy_strip.begin();
  economy_strip.show();

  //Setup all the buttons and assign a random color to every LED
  for (int i = 0; i <  6; i++){
    pinMode(buttons_culture[i],INPUT);
    pinMode(buttons_living[i],INPUT);
    pinMode(buttons_economy[i],INPUT);
    culture_strip.setPixelColor(i,colors[random(int(0,8))]);
    living_strip.setPixelColor(i,colors[random(int(0,8))]);
    economy_strip.setPixelColor(i,colors[random(int(0,8))]);
  }
  culture_strip.show();
  living_strip.show();
  economy_strip.show();
}

void loop() {
  String serialCode ="";
  //Read all the buttons, when pressed, send which button it is to the Serial Monitor
  for (int i = 0; i<6; i++){
    if (digitalRead(buttons_culture[i]) == HIGH){
      serialCode = "B5,"+String(i)+",";
    }
    if (digitalRead(buttons_economy[i]) == HIGH){
      serialCode = "B3,"+String(i)+",";
    }
    if(digitalRead(buttons_living[i]) == HIGH){
      serialCode = "B4,"+String(i)+",";
    }
  }
  if (serialCode != ""){
    Serial.println(serialCode);
  }
  delay(100);  
}
