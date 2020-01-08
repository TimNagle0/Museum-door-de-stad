String feedbackImageNames [] = {
  "feedbackEducation.png",
  "feedbackLeisure.png",
  "feedbackPublicspace.png",
  "feedbackEconomy.png",
  "feedbackLiving.png",
  "feedbackCulture.png"
};
PImage feedbackImages [] = new PImage [feedbackImageNames.length];

String infoImageNames [] = {
  "infoEducation.png",
  "infoLeisure.png",
  "infoPublicspace.png",
  "infoEconomy.png",
  "infoLiving.png",
  "infoCulture.png"
};
PImage infoImages [] = new PImage [infoImageNames.length];

String otherImageNames [] = {
  "otherEducation.png",
  "otherLeisure.png",
  "otherPublicspace.png",
  "otherEconomy.png",
  "otherLiving.png",
  "otherCulture.png"
};
PImage otherImages [] = new PImage [otherImageNames.length];

String specifyImageNames [] = {
  "specifyEducation.png",
  "specifyLeisure.png",
  "specifyPublicspace.png",
  "specifyEconomy.png",
  "specifyLiving.png",
  "specifyCulture.png"
};
PImage specifyImages [] = new PImage [specifyImageNames.length];

void loadImages(){
  for (int i = 0; i< feedbackImageNames.length;i++){
    String feedbackName = feedbackImageNames[i];
    String infoName = infoImageNames[i];
    String otherName = otherImageNames[i];
    String specifyName = specifyImageNames[i];
    feedbackImages[i] = loadImage(feedbackName);
    infoImages[i] = loadImage(infoName);
    otherImages[i] = loadImage(otherName);
    specifyImages[i] = loadImage(specifyName);
  }
}
