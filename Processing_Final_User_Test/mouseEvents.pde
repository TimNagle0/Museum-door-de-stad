//When the mouse is pressed save the location and determine action
void mousePressed(){
  int x = mouseX;
  int y = mouseY;
  //If a vote is being pressed, display that visitors specification as long as the button is being held
  if (votingScene.isPressingVote(x,y) && currentScene == votingScene){
       votingScene.displayOtherVote = true;
       visitors.get(visitors.size()-1).explorationAmount +=1;
        visitors.get(visitors.size()-1).explorations[getVoteArea(x,y)] +=1;
        votingScene.area = votingScene.getVisitor(x,y).voteArea;
        votingScene.specific = votingScene.getVisitor(x,y).voteAreaChoice;
  //If no vote is being pressed but the cursor is within a vote area, cast the vote
  }else if (isInsideCircle(pX + 420,pY+374,322,x,y)&& votingScene.voteAllowed && currentScene == votingScene){
    print("adding vote at " + x + ""+ y);
    visitors.get(visitors.size()-1).voteArea = voteList[getVoteArea(x,y)];
    visitors.get(visitors.size()-1).votePositionX = x;
    visitors.get(visitors.size()-1).votePositionY = y;
    votingScene.voteAllowed = false;
  }
}

//stop displaying other votes
void mouseReleased(){
  votingScene.displayOtherVote = false;
}

//Return the vote area where the cursor was being pressed
int getVoteArea(int xPos, int yPos){
  int currentVote = 0;
  if (isInside(pX+323,pY+28,pX+398,pY+343,pX+87,pY+251,xPos,yPos)){
    currentVote = 0; //Education
  }else if (isInside(pX+361,pY+22,pX+671,pY+116,pX+435,pY+338,xPos,yPos)){
    currentVote = 3; //Economy
  }else if (isInside(pX+696,pY+147,pX+770,pY+462,pX+460,pY+369,xPos,yPos)){
    currentVote = 4; //Living
  }else if (isInside(pX+756,pY+499,pX+519,pY+721,pX+445,pY+405,xPos,yPos)){
    currentVote = 2; //Public space
  }else if(isInside(pX+481,pY+727,pX+171,pY+633,pX+407,pY+411,xPos,yPos)){
    currentVote = 1; //Leisure
  }else if (isInside(pX+149,pY+603,pX+72,pY+288,pX+383,pY+380,xPos,yPos)){
    currentVote = 5; //Culture
  }
  return currentVote;
}

//funtion to calculate the area of a triangle, retreived from https://www.geeksforgeeks.org/check-whether-a-given-point-lies-inside-a-triangle-or-not/
float area (int x1, int y1, int x2, int y2, int x3, int y3){
  return abs ((x1*(y2-y3) + x2*(y3-y1)+ x3*(y1-y2))/2.0); 
}

//function to determine if a point is within a triangle, retreived from https://www.geeksforgeeks.org/check-whether-a-given-point-lies-inside-a-triangle-or-not/
boolean isInside(int x1, int y1, int x2, int y2, int x3, int y3, int x, int y) {    
   /* Calculate area of triangle ABC */
   float A = area (x1, y1, x2, y2, x3, y3); 
  
   /* Calculate area of triangle PBC */   
   float A1 = area (x, y, x2, y2, x3, y3); 
  
   /* Calculate area of triangle PAC */   
  float A2 = area (x1, y1, x, y, x3, y3); 
  
   /* Calculate area of triangle PAB */    
   float A3 = area (x1, y1, x2, y2, x, y); 
    
   /* Check if sum of A1, A2 and A3 is same as A */ 
   return (A == A1 + A2 + A3);
}

//function to check if a point is within a circle, retreived from https://www.geeksforgeeks.org/find-if-a-point-lies-inside-or-on-circle/
boolean isInsideCircle(float circleX, float circleY, float r, float x, float y){
   if ((x-circleX)*(x-circleX) + (y-circleY)*(y-circleY) <= r*r){
     return true;
   }else{
     return false;
   }
}
