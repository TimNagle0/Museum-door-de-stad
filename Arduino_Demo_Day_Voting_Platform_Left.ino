/* This program was created for a museum installation made for "Museum door de Stad", an initiative by Eindhoven Museum and Studio Soeps 
 *  The program operates the left part of the voting platform that is part of the installation and send its data to Processing using Serial Communication
 *  Made by Tim Naglé as part of the faculty of Industrial Design of TU/e
 */

#include <Adafruit_NeoPixel.h>
#include <ColorSensor.h>

//Define the pins for the LED strips
#define LED_PIN_PUBLICSPACE 6
#define LED_PIN_LEISURE 41
#define LED_PIN_EDUCATION 52

//Define the amount of LEDs per strip
#define LED_AMOUNT 6

//Define all the buttons pins and store their positions in an array
#define button_1_public_space  6
#define button_2_public_space  9
#define button_3_public_space  10
#define button_4_public_space  13
#define button_5_public_space  11
#define button_6_public_space  7
int buttons_public_space [6] = {button_1_public_space,button_2_public_space,button_3_public_space,button_4_public_space,button_5_public_space,button_6_public_space};

#define button_1_leisure 40
#define button_2_leisure 42
#define button_3_leisure 17
#define button_4_leisure 37
#define button_5_leisure 41
#define button_6_leisure 36
int buttons_leisure [6] = {button_1_leisure,button_2_leisure,button_3_leisure,button_4_leisure,button_5_leisure,button_6_leisure};

#define button_1_education 50
#define button_2_education 48
#define button_3_education 53
#define button_4_education 47
#define button_5_education 49
#define button_6_education 51
int buttons_education [6] = {button_1_education,button_2_education,button_3_education,button_4_education,button_5_education,button_6_education};

//Initiate the LED strips
Adafruit_NeoPixel public_space_strip(LED_AMOUNT,LED_PIN_PUBLICSPACE);
Adafruit_NeoPixel leisure_strip(LED_AMOUNT,LED_PIN_LEISURE);
Adafruit_NeoPixel education_strip(LED_AMOUNT,LED_PIN_EDUCATION);

//Create an array for the possible colors
uint32_t colors [8] = {leisure_strip.Color(255,0,0),
                     leisure_strip.Color(0,0,255),
                     leisure_strip.Color(0,255,0),
                     leisure_strip.Color(255,100,0),
                     leisure_strip.Color (255,255,0),
                     leisure_strip.Color(0,255,255),
                     leisure_strip.Color(255,0,255),
                     leisure_strip.Color(100,0,255),
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
  public_space_strip.begin();
  public_space_strip.show();
  leisure_strip.begin();
  leisure_strip.show();
  education_strip.begin();
  education_strip.show();

  //Setup all the buttons and assign a random color to every LED
  for (int i = 0; i <  6; i++){
    pinMode(buttons_public_space[i],INPUT);
    pinMode(buttons_leisure[i],INPUT);
    pinMode(buttons_education[i],INPUT);
     public_space_strip.setPixelColor(i,colors[random(int(0,8))]);
    leisure_strip.setPixelColor(i,colors[random(int(0,8))]);
    education_strip.setPixelColor(i,colors[random(int(0,8))]);
  }
  public_space_strip.show();
  leisure_strip.show();
  education_strip.show();
}

void loop() {
  String serialCode = "";
  //Read all the buttons, when pressed, send which button it is to the Serial Monitor
  for (int i = 0; i<6; i++){
    if (digitalRead(buttons_public_space[i]) == HIGH){
      serialCode = "B2,"+String(i)+",";
    }
    if (digitalRead(buttons_education[i]) == HIGH){
      serialCode = "B0,"+String(i)+",";
    }
    if(digitalRead(buttons_leisure[i]) == HIGH){
      serialCode = "B1,"+String(i)+",";
    }
    if (serialCode != ""){
      Serial.println(serialCode);
    }
    delay(100); 
  }
}


