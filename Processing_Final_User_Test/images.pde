//All the images and assets for the program
PImage voting_platform;
PImage voting_ticket;
PImage eindhoven_museum_logo;
PImage year_eindhoven_logo;
PImage tue_logo;
PImage ticket_machine;
PImage confirm_hover;
PImage confirm_inactive;
PImage confirm_pressed;
PImage startButtonImage;

String specifyDataImageNames [] = {
  "specifyEducationData.png",
  "specifyLeisureData.png",
  "specifyPublicSpaceData.png",
  "specifyEconomyData.png",
  "specifyLivingData.png",
  "specifyCultureData.png"
};
PImage specifyDataImages [] = new PImage [specifyDataImageNames.length];

//All the videos used in the program
Movie first_question;
Movie second_question;
Movie third_question;

Movie [] questionMovies = new Movie[3];



//Load all the images
void loadImages(){
  for (int i = 0; i< specifyDataImageNames.length;i++){
    String specifyDataName = specifyDataImageNames[i];
    specifyDataImages[i] = loadImage(specifyDataName);
  }
   voting_platform = loadImage("voting_platform.png");
  voting_ticket = loadImage("voting_ticket.png");
  eindhoven_museum_logo  = loadImage("Eindhoven museum logo.PNG");
  year_eindhoven_logo = loadImage("100 jaar eindhoven logo.png");
  tue_logo = loadImage("tue logo.png");
  ticket_machine = loadImage("ticket_machine.png");
  confirm_inactive = loadImage("confirm_inactive.png");
  confirm_hover = loadImage("confirm_hover.png");
  confirm_pressed = loadImage("confirm_pressed.png");
  startButtonImage = loadImage("start_button_inactive.png");
}

//load all the videos and set them up
void loadVideos(){
  first_question = new Movie(this, "first_question.mp4");
  second_question = new Movie(this, "second_question.mp4");
  third_question = new Movie(this, "third_question.mp4");
  questionMovies [0] = first_question;
  questionMovies [1] = second_question;
  questionMovies [2] = third_question;
  
  for (int i = 0; i<3;i++){
    questionMovies[i].stop();
    questionMovies[i].noLoop();
    questionMovies[i].volume(0);
  }
}

//Movie event
void movieEvent(Movie m){
  m.read();
}
