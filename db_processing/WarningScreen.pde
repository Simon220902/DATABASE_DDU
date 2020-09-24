Screen MakeSuccessScreen(){
  //Warning label
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
                   
  return new Screen(successGroup, "successScreen");
}

Screen MakeWarningScreen(){
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
                   
  return new Screen(warningGroup, "warningScreen");
}
