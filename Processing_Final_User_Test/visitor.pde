//Array of possible choices of voting areas
String voteList [] = {"Education","Leisure","PublicSpace","Economy","Living","Culture"};
//Arrays for possible specifications per voting area
String specifyEducationList[] = {"Education resources and facilities","Universities","Entrepreneur and staff training","Art and Design","Other"};
String specifyEconomyList[] = {"Finance","Industry","Talent development","International companies","Other"};
String specifyLivingList[] = {"Housing resources","Sustainability of housing","Food","Freedom of choice and equality","Other"};
String specifyLeisureList[] = {"Sport","Music","Shopping Malls","Art and Design","Other"};
String specifyPublicSpaceList[] = {"Mobility","Green areas","Architecture","Lighting","Other"};
String specifyCultureList[] = {"Urban culture","City brand and history","Cultural integration","Art and Design","Other"};
String specifyLists [][] = {specifyEducationList,specifyLeisureList,specifyPublicSpaceList,specifyEconomyList,specifyLivingList,specifyCultureList};

//Class object for each visitor
class Visitor {
  int visitorNumber;
  color personalColor;
  float resultQuestion1, resultQuestion2, resultQuestion3;
  String voteArea;
  int votePositionX, votePositionY;
  String voteAreaChoice;
  int explorationAmount;
  int explorations[] = {0,0,0,0,0,0};
  int timeSpend;
  
  Visitor(int number,float result1, float result2, float result3){
    visitorNumber = number;
    voteArea = "";
    votePositionX = -100;
    votePositionY = -100;
    resultQuestion1 = result1;
    resultQuestion2 = result2;
    resultQuestion3 = result3;
    personalColor = createColor(resultQuestion1,resultQuestion2,resultQuestion3);
  }
  //Determine the personal color of the current visitor
  color createColor(float r1, float r2, float r3){
    float hue = map(r1,0,180,0,160) + map(r2,0,180,0,160);
    float brightness = map(r3,0,100,50,100);
    return color(hue,brightness,brightness);
  }
  //add the visitors vote
  void addVote(int area){
    voteArea = voteList[area];
  }
  //Check if the given position is within the person's vote on the voting platform
  boolean checkVotePosition(int posX, int posY){
     if (posX < votePositionX+10 && posX > votePositionX-10 && posY < votePositionY + 10 && posY > votePositionY -10){
       return true;
     }else{
       return false;
     }
  }
  //Get the position of the chosen area in terms of location on the physical installation
  int getVotePosition(){
    int votePosition = 0;
    for (int i =0;i<5;i++){
      if(voteArea.equals(voteList[i])){
        votePosition = i; 
      }
    }
    return votePosition;
  }
  //Assign the chosen meaning to the chosen area
  void specifyChoice(int option){
    voteAreaChoice = specifyLists[getVotePosition()][option];
  }
}
