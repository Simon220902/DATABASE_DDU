class TimedScreen extends Screen{
  int time;
  int timeShown = 500; //We show it for five seconds
  
  TimedScreen(Group g, String n){
    super(g, n);
  }
  
  void show(){
    time = millis();
    group.show();
  }
  void update(){
    if (group.isVisible()){
      if (millis() > time+timeShown){
        group.hide();
      }
    }
  }
}

TimedScreen MakeSuccessScreen(){
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
                   
  return new TimedScreen(successGroup, "successScreen");
}

TimedScreen MakeWarningScreen(){
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
                   
  return new TimedScreen(warningGroup, "warningScreen");
}
