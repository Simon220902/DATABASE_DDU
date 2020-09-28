void logout(int _){
  session.clear();
  //We shift to the login Group
  sessionGroup.hide();
  chatGroup.hide();
  //HIDE ALL THE CHAT GroupS AND STUFF
  loginGroup.show();
  
}

Group MakeSessionGroup(){
  int GroupWidth = (width/2);
  int GroupHeight = height/10;  
  int buttonWidth = (GroupWidth/4);
  int buttonHeight = GroupHeight;
  //Success label
  Group sessionGroup = cp5.addGroup("SessionGroup")
                          .setPosition(width - GroupWidth, 0)
                          .setWidth(GroupWidth)
                          .setBackgroundHeight(GroupHeight)
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
  u.setPosition(buttonWidth, GroupHeight/2 - u.getHeight()/2);

  Button lB = cp5.addButton("logout")
               .setPosition(0, 0)
               .setSize(buttonWidth, buttonHeight)
               .setColorBackground(color(100))
               .setFont(f)
               .setGroup(sessionGroup)
               ;
                   
  return sessionGroup;
}
