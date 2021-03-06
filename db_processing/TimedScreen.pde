class TimedGroup{
  int time;
  int timeShown = 1000; //We show it for five seconds
  Group group;
  
  TimedGroup(Group g){
    group = g;
  }
  
  void show(){
    time = millis();
    group.show();
  }

  void hide(){
    group.hide();
  }
  
  void update(){
    if (group.isVisible()){
      if (millis() > time+timeShown){
        group.hide();
      }
    }
  }
}

TimedGroup MakeSuccessGroup(){
  //Success label
  Group successGroup = cp5.addGroup("SuccessScreen")
                          .setPosition(0, 0)
                          .setWidth(width)
                          .setBackgroundHeight(height/6)
                          .setBackgroundColor(color(0, 255, 0, 100))
                          .hideBar()
                          .hide()
                          ;
  Textlabel s = cp5.addTextlabel("success")
                   .setText("STANDARD TEXT")
                   .setPosition(successGroup.getWidth()/5, successGroup.getBackgroundHeight()/3)
                   .setColorValue(color(255))
                   .setFont(createFont("Times",30))
                   .setGroup(successGroup)
                   ;
                   
  return new TimedGroup(successGroup);
}

TimedGroup MakeWarningGroup(){
  //Warning label
  Group warningGroup = cp5.addGroup("WarningScreen")
                          .setPosition(0, 0)
                          .setWidth(width)
                          .setBackgroundHeight(height/6)
                          .setBackgroundColor(color(255, 0, 0, 100))
                          .hideBar()
                          .hide()
                          ;
  Textlabel w = cp5.addTextlabel("warning")
                   .setText("STANDARD TEXT")
                   .setPosition(warningGroup.getWidth()/5, warningGroup.getBackgroundHeight()/3)
                   .setColorValue(color(255))
                   .setFont(createFont("Times",30))
                   .setGroup(warningGroup)
                   ;
                   
  return new TimedGroup(warningGroup);
}
