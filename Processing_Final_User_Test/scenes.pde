//Interface for all the scenes
interface Scene {
 void transitionToScene();
 void displayScene();
 void updateScene();
 void transitionFromScene();
}

//Introduction scene of the program
class IntroductionScene implements Scene{
  boolean transitionDone = false;
  //setup the scene
  void transitionToScene(){
    setupBalls();
    startButton.show();
    transitionDone = true;
  }
  //if the scene is done setting up show the animations
  void displayScene(){
    if (!transitionDone){
      transitionToScene();
    }else{
      background(white_background);
      image(year_eindhoven_logo,1620, 840, 460*0.4, 151*0.4);
      image(tue_logo,1600, 760, 105.2*2,22.6*2);
      textSize(162);
      fill(orange_background);
      
      text("CONNECTION", 155, 300);
      textSize(80);
      text("WITH EINDHOVEN",1030, 400);
    }    
  }
  void updateScene(){
    updateBalls();
  }

  void transitionFromScene(){
    transitionDone = false;
    visitorTimeSpend = millis();
    hideAll();
  }
}

//The connection scene of the program
class ConnectionScene implements Scene{
  color nextColor = color(0,0,0);
  boolean isVideoRunning = false;
  boolean transitionDone = false;
  int currentVideo = 0;
  //Start the video and reset the sliders
  void transitionToScene(){    
    Red.setValue(90);
    Green.setValue(90);
    Blue.setValue(50);
    startVideo (currentVideo,false);
    transitionDone = true;
  }
  
  void displayScene(){
    if (!transitionDone){
      transitionToScene(); 
    }else{
      background(255);
      if(isVideoRunning){
        displayVideo(currentVideo);
      }else{
        image(ticket_machine,1010,50);
        tint(nextColor);
        image(voting_ticket, 1355,661);
        tint(0,0,100);
        textSize(subtitleText);
        stroke(1);
        fill(0,0,0);
        if (visitors.size() < 10){
          text("0"+visitors.size(),1415,891); 
        }else{
          text(visitors.size()+1, 1415,891);
        }
        noStroke();
      }
    }
  }
  //update the sliders and the color of the voting ticket
  void updateScene(){
    float hue = map(Red.getValue(),0,180,0,160) + map(Green.getValue(),0,180,0,160);
    float brightness = map(Blue.getValue(),0,100,50,100);
    nextColor = color(hue,brightness,brightness);
  }
  //hide the sliders and buttons
  void hideButtons(){
    for (int i = 0; i < 5;i++){
      videoButtons[i].hide(); 
    }
    cb.hide(); 
    Red.hide();
    Blue.hide();
    Green.hide();
  }
  //replay the current video, or start the next video
  void startVideo(int video,boolean nextVideo){
    if (nextVideo){
      video +=1; 
    }
    questionMovies[video].jump(0);
    questionMovies[video].play();
    connectionScene.hideButtons();
    connectionScene.currentVideo = video;
    connectionScene.isVideoRunning = true;
  }
  //Display the video and when its done playing show the buttons and sliders
  void displayVideo(int video){
    if (questionMovies[video].time() >= questionMovies[video].duration()-1){
      isVideoRunning = false;
      videoButtons[video].show();
      cb.show();
      Red.show();
      Green.show();
      Blue.show();
      //catch the exeption because the third video doesn't have a "next video" button
      try{
        videoButtons[video+1].show();
      }catch (java.lang.ArrayIndexOutOfBoundsException e){
        ; 
      }
    }else{
      image(questionMovies[video],0,-1,1920,1080);
    }
  }
  
  //Add a new visitor with the values from the sliders
  void transitionFromScene(){
    currentVideo = 0;
    transitionDone = false;
    hideButtons();
    int visitorAmount = visitors.size()+1;
    visitors.add(new Visitor(visitorAmount,Red.getValue(),Green.getValue(),Blue.getValue()));
  }
}

//The voting scen of the program
class VotingScene implements Scene {
  //A 
  long instructionTimer;
  int delay = 10000;
  boolean isTimerRunning = false;
  boolean transitionDone = false;
  boolean voteAllowed = false;
  boolean displayOtherVote = false;
  String area = "";
  String specific = "";
  void startTimer(){
    isTimerRunning = true;
    instructionTimer = millis(); 
  }
  //Show instructions to the user about their color and what it means 
  void transitionToScene(){
    if (isTimerRunning && millis()-instructionTimer < delay){
      background(visitors.get(visitors.size()-1).personalColor);
      fill(white_background,100);
      rect(460,360,1000,360,50);
      fill(0,0,0);
      textSize(subtext);
      text("This is your personal color. This color represends your connection to Eindhoven.\nIn the next step you can use this color to vote on what you think is important for\nthe development of Eindhoven in the future. \nTo place your vote simply select the area you want to vote on.", 480,400);
    }else{
     vb.show();
     isTimerRunning = false;
     transitionDone = true;
     voteAllowed = true;
    }
  }
  //Display the voting platform, votes and instructions
  void displayScene(){
    if (!transitionDone){
      transitionToScene(); 
    }else{
     background (white_background);
     fill(orange_background);
     rect(0,0,640,1080);
     fill(255);
     textSize(subtext);
     text("What do you think is important for the \nfuture development of Eindhoven?",100,365);
     text("Chose an area to place your vote",100,465);
     image(voting_platform,pX,pY);
     drawVotes();
     if (displayOtherVote){
       fill(0,0,0);
       text("This person voted for "+ area+" because they think that " + specific + " needs to be improved",760,100); 
     }
    }
  }
  //Draw all the votes from previous visitors
  void drawVotes(){
   //Loop through all the votes and draw them in the right positions
   for (Visitor currentVisitor : visitors){
     fill (currentVisitor.personalColor);
     ellipse(currentVisitor.votePositionX,currentVisitor.votePositionY,20,20);
   }
  }
  
  void updateScene(){ 
  }
  //Check if the visitor is still pressing a previous vote
  boolean isPressingVote(int x, int y){
    for (Visitor currentVisitor : visitors){
      if (currentVisitor.checkVotePosition(x,y)){
        return true; 
      }
    }
    return false;
  }
  //Return the visitor that the vote on the screen belongs to, based on position of the mouse
  Visitor getVisitor(int x, int y){
    for (Visitor currentVisitor : visitors){
      if (currentVisitor.checkVotePosition(x,y)){
        return currentVisitor; 
      }
    }
    return null;
  }
  void transitionFromScene(){
    vb.hide();
    transitionDone = false;
  }
}

//The specify scene of the program
class SpecifyScene implements Scene{
  boolean transitionDone = false;
  int area;
  //display the question about what the chosen area means to the visitor
  void transitionToScene(){
    area =visitors.get(visitors.size()-1).getVotePosition();
    for (int i=0;i<5;i++){
      specifyButtons[area][i].show(); 
    }
    image(specifyDataImages[area],0,0);
    transitionDone = true;
  }
    
  void displayScene(){
    if (!transitionDone){
      transitionToScene(); 
    }else{
      ;
    }
  }
  
  void updateScene(){
  }
  //End the program and record the amount of time spend for this visitor
  void transitionFromScene(){
    for (int i=0;i<5;i++){
      specifyButtons[area][i].hide(); 
    }
    visitors.get(visitors.size()-1).timeSpend = int(millis() - visitorTimeSpend);
    transitionDone = false;
  }
}
