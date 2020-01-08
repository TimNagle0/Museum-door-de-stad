import controlP5.*;
import processing.video.*;

ControlP5 controlP5;

// Initiating different fonts
ControlFont buttonLarge;
ControlFont buttonRegular;
ControlFont textfield;
PFont introductionfont;

color redSlider;
color greenSlider;
color blueSlider;

//The different text sizes that will be used in the program
int titleText = 64;        
int subtitleText = 42;
int text = 32;
int subtext = 24;

//x and y coordinates of the voting platform image
int pX = 869;
int pY = 165;

//Colorpalette
color orange_background;
color white_background;

//Initializing all the scenes
IntroductionScene introductionScene = new IntroductionScene();
ConnectionScene connectionScene = new ConnectionScene();
VotingScene votingScene = new VotingScene();
SpecifyScene specifyScene = new SpecifyScene();
Scene currentScene;

//Create an arrayList to store all the visitors
ArrayList<Visitor> visitors = new ArrayList<Visitor>();

//Set up the CSV file for the data
//All code related to csv data was inspired by Rong-Hao Liang: r.liang@tue.nl
String date = getDate();
String time = getTime();
String csvFile = "data/visitorData_"+date+"_"+time+".csv";
Table visitorData;

long visitorTimeSpend;

void setup(){
  //set up the canvas
  size(1920,1080);
  noStroke();
  smooth();
  
  //Create a new table to save the visitor data
  visitorData = new Table();
  addColumns();
  
  //Change the color mode to HSB and create colors
  colorMode(HSB,360,100,100,255);
  orange_background = color(14,93,90);
  white_background = color(0,0,100);
  
  //Create all the fonts used in the program
  introductionfont = createFont("Nitti Eindhoven Light.otf",32);
  buttonLarge = new ControlFont(createFont("Bebas Neue",40));
  buttonRegular = new ControlFont(createFont("Bebas Neue",20));
  textfield = new ControlFont(createFont("Arial",20));
  controlP5 = new ControlP5(this);
  
  //load all assets and create the buttons
  loadImages();
  loadVideos();
  addButtons();
  hideAll();
  
  //set the starting scene
  currentScene = introductionScene;
}

void draw(){
  currentScene.displayScene();
  currentScene.updateScene();
}

//create all the columns for the csv file
void addColumns(){
  visitorData.addColumn("Question1");
  visitorData.addColumn("Question2");
  visitorData.addColumn("Question3");
  visitorData.addColumn("value");
  visitorData.addColumn("meaning");
  visitorData.addColumn("explorations");
  visitorData.addColumn("Education");
  visitorData.addColumn("Leisure");
  visitorData.addColumn("Public Space");
  visitorData.addColumn("Economy");
  visitorData.addColumn("Living");
  visitorData.addColumn("Culture");
  visitorData.addColumn("time");
}
//Save all the data gathered from the last visitor in the csv file
void saveVisitors(){
  Visitor currentVisitor = visitors.get(visitors.size()-1);
   TableRow newVisitor = visitorData.addRow();
   newVisitor.setFloat("Question1",currentVisitor.resultQuestion1);
   newVisitor.setFloat("Question2",currentVisitor.resultQuestion2);
   newVisitor.setFloat("Question3",currentVisitor.resultQuestion3);
   newVisitor.setString("value",currentVisitor.voteArea);
   newVisitor.setString("meaning",currentVisitor.voteAreaChoice);
   newVisitor.setInt("explorations",currentVisitor.explorationAmount);
   newVisitor.setInt("Education",currentVisitor.explorations[0]);
   newVisitor.setInt("Leisure",currentVisitor.explorations[1]);
   newVisitor.setInt("Public Space",currentVisitor.explorations[2]);
   newVisitor.setInt("Economy",currentVisitor.explorations[3]);
   newVisitor.setInt("Living",currentVisitor.explorations[4]);
   newVisitor.setInt("Culture",currentVisitor.explorations[5]);
   newVisitor.setInt("time",currentVisitor.timeSpend);
  saveTable(visitorData,csvFile);
}
//return the current date in dd/mm/yy format
String getDate(){
 String date;
 String day;
 String month;
 String year;
 if (day()<10){
   day = "0"+day(); 
 }else{
   day = ""+day();
 }
 if (month()<10){
   month = "0"+month(); 
 }else{
   month = ""+month();
 }
 if (year()<10){
   year = "0"+year(); 
 }else{
   year = ""+year();
 }
 date = day+"-"+month+"-"+year;
 return date;
}
//Return time in hh/mm/ss format
String getTime(){
  String time;
  String hour;
  String minute;
  String second;
  if(hour() < 10){
    hour = "0"+hour(); 
  }else{
    hour = ""+(hour());
  }
  if (minute() < 10){
    minute = "0"+minute(); 
  }else{
    minute = ""+minute();
  }
  if (second() < 10){
    second = "0"+second();
  }else{
    second = ""+second(); 
  }
  time = hour+"-"+minute+"-"+second;
  return time; 
}
