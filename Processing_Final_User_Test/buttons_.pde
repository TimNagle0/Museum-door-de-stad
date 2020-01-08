//Create all the buttons and sliders needed
controlP5.Button startButton;
controlP5.Button cb; //connection button
controlP5.Button vb; //voting button
controlP5.Button videoButton1;
controlP5.Button videoReplayButton1;
controlP5.Button videoButton2;
controlP5.Button videoReplayButton2;
controlP5.Button videoReplayButton3;
controlP5.Button specifyButtons [][] = new controlP5.Button[5][5];
controlP5.Button [] videoButtons = new controlP5.Button[5];
Slider Red;
Slider Green;
Slider Blue;

//Event for all the buttons
void controlEvent(ControlEvent theEvent){
  if(theEvent.isController()){
    int index = theEvent.getController().getName().indexOf("o");
    //All the buttons for the transitions between scenes
    if (theEvent.getController().getName() == "start"){
      currentScene.transitionFromScene();
      currentScene = connectionScene;
    }else if(theEvent.getController().getName() == "confirmConnection"){
      currentScene.transitionFromScene();
      currentScene = votingScene;
      votingScene.startTimer();
    }else if (theEvent.getController().getName() == "confirmVote"){
      currentScene.transitionFromScene();
      currentScene = specifyScene;
    }else if (index == 0){
      //When the user specifies their area get the choice, save the data and start over
      String buttonName = theEvent.getController().getName();
      int button = int(buttonName.substring(7));
      visitors.get(visitors.size()-1).specifyChoice(button);
      currentScene.transitionFromScene();
      saveVisitors();
      currentScene = introductionScene;
    }
  }
  //all the buttons that control the transitions between videos in the connection scene
  if (theEvent.getController().getName() == "videoButton1"){
    first_question.stop();
    connectionScene.startVideo(connectionScene.currentVideo,true);
  }else if (theEvent.getController().getName() == "videoReplayButton1"){
    connectionScene.startVideo(connectionScene.currentVideo,false);
  }else if (theEvent.getController().getName() == "videoButton2"){
    second_question.stop();
    connectionScene.startVideo(connectionScene.currentVideo,true);
  }else if (theEvent.getController().getName() == "videoReplayButton2"){
    connectionScene.startVideo(connectionScene.currentVideo,false);
  }else if (theEvent.getController().getName() == "videoReplayButton3"){
    connectionScene.startVideo(connectionScene.currentVideo,false);
  }
}

//Hide all the buttons and sliders
void hideAll(){
  for (int i = 0; i<5; i++){
    videoButtons[i].hide(); 
    for (int x = 0;x<5;x++){
      specifyButtons[i][x].hide();
    }
  }
  startButton.hide();
  cb.hide(); 
  vb.hide();
  Red.hide();
  Green.hide();
  Blue.hide();
}

//add all the buttons and sliders
void addButtons(){
  redSlider = color(350, 74, 37);
  greenSlider = color(110, 73, 38);
  blueSlider = color(230, 73, 38);
  startButton = controlP5.addButton("start")
    .setPosition(880,760)
    .setSize(146,146)
    .setImages(startButtonImage,startButtonImage,startButtonImage)
   ;
  cb = controlP5.addButton("confirmConnection")
   .setPosition(1336,592)
   .setSize(660,100)
   .setImages(confirm_inactive,confirm_hover,confirm_pressed)
   ;
  videoButtons[0] = controlP5.addButton("videoButton1")
   .setCaptionLabel("Next")
   .setPosition(660,930)
   .setSize(200,50)
   .setFont(buttonRegular)
   .setColorActive(#4863A0)
   .setColorForeground(#654A0C)
   .setColorBackground(#A18648)  
   ;

  videoButtons[1] = controlP5.addButton("videoReplayButton1")
   .setCaptionLabel("Replay")
   .setPosition(100,930)
   .setSize(200,50)
   .setFont(buttonRegular)
   .setColorActive(#4863A0)
   .setColorForeground(#654A0C)
   .setColorBackground(#A18648)  
   ;
  videoButtons[2] = controlP5.addButton("videoButton2")
   .setCaptionLabel("Next")
   .setPosition(660,930)
   .setSize(200,50)
   .setFont(buttonRegular)
   .setColorActive(#4863A0)
   .setColorForeground(#654A0C)
   .setColorBackground(#A18648)  
   ;
  videoButtons[3] = controlP5.addButton("videoReplayButton2")
   .setCaptionLabel("Replay")
   .setPosition(100,930)
   .setSize(200,50)
   .setFont(buttonRegular)
   .setColorActive(#4863A0)
   .setColorForeground(#654A0C)
   .setColorBackground(#A18648)  
   ;
  videoButtons[4] = controlP5.addButton("videoReplayButton3")
   .setCaptionLabel("Replay")
   .setPosition(100,930)
   .setSize(200,50)
   .setFont(buttonRegular)
   .setColorActive(#4863A0)
   .setColorForeground(#654A0C)
   .setColorBackground(#A18648)  
   ;
  for (int x = 0; x <5;x++){
    for (int i =0; i<5;i++){
      String hel = "option"+i;
      println(hel);
      specifyButtons[x][i] = controlP5.addButton("option"+x+""+i)
      .setCaptionLabel(specifyLists[x][i])
      .setFont(buttonRegular)
      .setPosition(1057,242+i*120)
      .setSize(770,100)
      .setColorActive(#4863A0)
      .setColorForeground(#654A0C)
      .setColorBackground(#A18648)
      ;
    }
  }
  vb = controlP5.addButton("confirmVote")
   .setCaptionLabel("Confirm")
   .setPosition(1620,880)
   .setSize(200,100)
   .setFont(buttonRegular)
   .setColorActive(#4863A0)
   .setColorForeground(#654A0C)
   .setColorBackground(#A18648)  
   ;
   //adding the sliders to the program
  Red = controlP5.addSlider("Red")
   .setPosition(1136,273)
   .setSize(622,27)
   .setFont(textfield)
   .setRange(0,180)
   .setColorActive(redSlider)
   .setColorForeground(redSlider)
   .setColorBackground(#990000)
   .setLabelVisible(false)
   ;
  Green = controlP5.addSlider("Green")
   .setPosition(1136,400)
   .setSize(622,27)
   .setFont(textfield)
   .setRange(0,180)
   .setColorActive(greenSlider)
   .setColorForeground(greenSlider)
   .setColorBackground(#009900)
   .setLabelVisible(false)
   ;
  Blue = controlP5.addSlider("Blue")
   .setPosition(1136,529)
   .setSize(622,27)
   .setFont(textfield)
   .setRange(0,100)
   .setColorActive(blueSlider)
   .setColorForeground(blueSlider)
   .setColorBackground(#000080)
   .setLabelVisible(false)
   ;
}
