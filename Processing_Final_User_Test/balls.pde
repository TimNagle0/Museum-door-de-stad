//Array of words that can appear next to the balls
String[] words = {"Past","Now", "Future","1920 to 2020","Eindhoven","Woensel", "Tongelre", "Stratum", "Gestel", "Strijp"};

/*
  Class for the animation that runs when on the start screen
  Based of "Connect The Dots" by nicetryharshit
  http://www.openprocessing.org/sketch/405226
  Licensed under Creative Commons Attribution ShareAlike
  https://creativecommons.org/licenses/by-sa/3.0
  https://creativecommons.org/licenses/GPL/2.0/
*/

class Ball {
  color ballColor;
  float xPos, yPos;
  float xSpeed, ySpeed;
  float size;
  String word;

  Ball(color _ballColor, float _xPos, float _yPos, float _xSpeed, float _ySpeed, float _size, String _word) {
    ballColor = _ballColor;
    xPos = _xPos;
    yPos = _yPos;
    xSpeed = _xSpeed;
    ySpeed = _ySpeed;
    size = _size;
    word = _word;
  }
  //Display the ball
  void display() {
    noStroke();
    fill(ballColor);
    ellipse(xPos, yPos, size, size);
    text(word, xPos, yPos);
  }
  //Move the ball to a new position
  void move() {
    xPos = xPos + xSpeed;
    yPos = yPos + ySpeed;
    if (xPos > width || xPos < 0) {
      xSpeed = xSpeed * -1;
    }
    if (yPos > height || yPos < 0) {
      ySpeed = ySpeed * -1;
    }
  }
  //Handle collisions between balls
  void collision() {
    for (int i = 0; i < orb.length; i++) {
      if (dist(xPos, yPos, orb[i].xPos, orb[i].yPos) < (size + orb[i].size)/2 && orb[i] != this) {
        xSpeed = xSpeed * -1;
        ySpeed = ySpeed * -1;
      }
    }
  }
  //Create lines between balls if they get close enough
  void lines() {
    stroke(232,67,24,65);
    for (int i = 0; i < orb.length; i++) {
      if (dist(xPos, yPos, orb[i].xPos, orb[i].yPos) < 300 && orb[i] != this) {
        line(xPos, yPos, orb[i].xPos, orb[i].yPos);
      }
    }
  }
}

Ball[] orb = new Ball[30];

//Create all the balls for the animation, some with text attached
void setupBalls(){
  for (int i = 0; i < orb.length; i++) {
    if(i<=9)
      orb[i] = new Ball(color(random(255), random(255), random(255), random(255)), random(width), random(height), random(3), random(4), 20, words[i]);
    else
      orb[i] = new Ball(color(random(255), random(255), random(255), random(255)), random(width), random(height), random(3), random(4), 20, " ");
  } 
}
//Update the balls
void updateBalls(){
 for (int i = 0; i < orb.length; i++) {
    textSize(32);
    orb[i].display();
    orb[i].move();
    orb[i].collision();
    orb[i].lines();
  } 
}
