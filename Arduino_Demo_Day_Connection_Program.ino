/* This program was made for museum installation made for "Museum door de Stad", an initiative by Eindhoven Museum and Studio Soeps
 * The program allows visitors to give input to the installation by changing 3 sliders and adjusts an LED strip based on their results. The output can also be used by other programs using the serial communication
 * Made by Tim Naglé as part of the faculty of Industrial Design of TU/e
 */

//Defining all the input ports
#define buttonPin 2
#define sliderPin_1 A1
#define sliderPin_2 A2
#define sliderPin_3 A3

//Defining the output ports for the LED strip
#define redPin 5
#define greenPin 6
#define bluePin 9

const int pressed = 1;
const int released = 0;
int buttonState = 0;

float slider1 = 0;
float slider2 = 0;
float slider3 = 0;
float hue;
float bright;
float col[3];
String lastColorCode = "0";
int lastButtonState = released;

void setup() {
  //Starting Serial Communication
  Serial.begin(9600);
  while (!Serial){
    ;
  }
  // Setting up sensors and the LED strip
  pinMode(buttonPin, INPUT);
  pinMode(redPin, OUTPUT);
  pinMode(greenPin, OUTPUT);
  pinMode(bluePin, OUTPUT);
  pinMode(sliderPin_1, INPUT);
  pinMode(sliderPin_2, INPUT);
  pinMode(sliderPin_3,INPUT);
}

void loop() {
  //read all input
  buttonState = digitalRead(buttonPin);
  slider1 = map(analogRead(sliderPin_1),1023,0,0,180);
  slider2 = map(analogRead(sliderPin_2),1023,0,0,180);
  slider3 = map(analogRead(sliderPin_3),1023,0,100,80);

  //map sliders to rgb and set color of the ledstrip
  hue = (slider1+slider2)/360;
  bright = slider3/100;
  setColor(hsv2rgb(hue, bright, bright, col));

  //Combine the sliders into one color code to send to processing
  String r1 = String(int(slider1));
  String r2 = String(int(slider2));
  String r3 = String(int(slider3));
  String colorCode = r1 + "," + r2 + "," + r3 + ",";

  //Send the color code to the Serial Monitor
  if (buttonState == HIGH && lastButtonState == released){
     lastButtonState = pressed;
     lastColorCode = colorCode;
     Serial.println(colorCode);
     delay(40);
  }else if (buttonState == LOW && lastButtonState == pressed){
    lastButtonState = released;
  }
  delay(10);
}

//HSV to RGB converter for the ledstrip, hsv should be in 0.0-...- 1.0 interval
//conversion made by postspectacular on github.com -- https://gist.github.com/postspectacular/2a4a8db092011c6743a7
void setColor(float *rgb) {
  analogWrite(redPin, (int)((1.0 - rgb[0]) * 255));
  analogWrite(greenPin, (int)((1.0 - rgb[1]) * 255));
  analogWrite(bluePin, (int)((1.0 - rgb[2]) * 255));  
}

float fract(float x) { return x - int(x); }

float mix(float a, float b, float t) { return a + (b - a) * t; }

float* hsv2rgb(float h, float s, float b, float* rgb) {
  rgb[0] = b * mix(1.0, constrain(abs(fract(h + 1.0) * 6.0 - 3.0) - 1.0, 0.0, 1.0), s);
  rgb[1] = b * mix(1.0, constrain(abs(fract(h + 0.6666666) * 6.0 - 3.0) - 1.0, 0.0, 1.0), s);
  rgb[2] = b * mix(1.0, constrain(abs(fract(h + 0.3333333) * 6.0 - 3.0) - 1.0, 0.0, 1.0), s);
  return rgb;
}
