/*This program was created for a museum installation made for "Museum door de Stad", an initiative by Eindhoven Museum and Studio Soeps 
 *The program receives data from the Arduinos that are in the installation and manages the digital and visual components
 *  Made by Tim Naglé as part of the faculty of Industrial Design of TU/e
 */
import processing.serial.*;
import controlP5.*;
import processing.video.*;

//Create class instances
Movie introduction;
Serial votingPortLeft;
Serial votingPortRight;

//Variables for the timer of the images
long lastTime;
long currentTime;
int timeDelay = 5000;
boolean timerRunning = false;

int area = 0; //Area that a button was being pressed in

void setup(){
  fullScreen();
  //Set up the instruction video
  introduction = new Movie(this, "video.mp4");
  introduction.play();
  introduction.volume(0);
  introduction.loop();
  
  //Load all the images
  loadImages();
  
  //Set up the Serial Communication
  votingPortLeft = new Serial (this,"COM5",9600);
  votingPortRight = new Serial (this,"COM7",9600);
  
  lastTime = millis();
  noStroke();
}

void draw(){
  //If a button was pressed, display the series of images, otherwise play the instruction video
  if (timerRunning){
    long timer = millis()-lastTime;
    if(timer <= timeDelay){
      displayImage(0);
    }else if (timer > timeDelay && timer <= timeDelay*3){
      displayImage(1);
    }else if (timer > timeDelay*3 && timer <= timeDelay*7){
      displayImage(2);
    }else if (timer > timeDelay*7 && timer <= timeDelay*11){
      displayImage(3);
    }else{
      timerRunning = false;
    }
  }else{
    image(introduction,0,0);
  }
}

//Event for playing the video
void movieEvent(Movie m){
  m.read();
}

//Determine which image needs to be displayed
void displayImage(int stage){
  if (stage == 0){
    image(otherImages[area],0,0);
  }else if (stage == 1){
    image(specifyImages[area],0,0);
  }else if (stage == 2){
    image(feedbackImages[area],0,0);
  }else if (stage == 3){
    image(infoImages[area],0,0,1920,1140); 
  }
}

int [] results = {0,0};

void serialEvent(Serial port){
  //If a button was pressed, determine which arduino it came from
  //Then split the information, determine what area the button was in and start the animations
  //Arduino MEGA 1
  if(port == votingPortLeft){
    String s = port.readStringUntil(10);
    if (s != null){
      if (s.indexOf("B") == 0 && !timerRunning){
        String string = s.substring(1);
        results = int(split(string, ','));
        if (results[0] != 1){
        lastTime = millis();
        timerRunning = true;
        area = results[0];
        }
      }
    }
  }
  //Arduino MEGA 2
  if(port == votingPortRight){
    String s = port.readStringUntil(10);
    if (s != null){
      if (s.indexOf("B") == 0 && !timerRunning){
        String string = s.substring(1);
        results = int(split(string, ','));
        if (results[0] != 1){
        lastTime = millis();
        timerRunning = true;
        area = results[0];
        }
      }
    }
  }
}
