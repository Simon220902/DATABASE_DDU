void logout(int _){
  session.clear();
  //We shift to the login screen
  sessionScreen.group.hide();
  //HIDE ALL THE CHAT SCREENS AND STUFF
  loginScreen.group.show();
  
}

Screen MakeSessionScreen(){
  int screenWidth = (width/2);
  int screenHeight = height/10;  
  int buttonWidth = (screenWidth/4);
  int buttonHeight = screenHeight;
  //Success label
  Group sessionGroup = cp5.addGroup("SessionScreen")
                          .setPosition(width - screenWidth, 0)
                          .setWidth(screenWidth)
                          .setBackgroundHeight(screenHeight)
                          .setBackgroundColor(color(150))
                          .hideBar()
                          .hide()
                          ;
  PFont f = createFont("Times",20);
  Textlabel u = cp5.addTextlabel("user")
                   .setText("USERNAME")
                   .setWidth(buttonWidth*3)
                   .setColorValue(color(255))
                   .setFont(f)
                   .setGroup(sessionGroup)
                   ;
  u.setPosition(buttonWidth, screenHeight/2 - u.getHeight()/2);

  Button lB = cp5.addButton("logout")
               .setPosition(0, 0)
               .setSize(buttonWidth, buttonHeight)
               .setColorBackground(color(100))
               .setFont(f)
               .setGroup(sessionGroup)
               ;
                   
  return new Screen(sessionGroup, "sessionScreen");
}
