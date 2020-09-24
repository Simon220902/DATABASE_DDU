Screen MakeLoginScreen(){
  int xBorder = int(width / 8);
  int yBorder = int(height / 10);
  
  Group loginGroup = cp5.addGroup("LoginScreen")
                        .setPosition(xBorder, yBorder)
                        .setWidth(width - 2*xBorder)
                        .setBackgroundHeight(height - 2*yBorder)
                        .setBackgroundColor(color(200, 155))
                        .hideBar()
                        ;
  
  int xGroupBorder = loginGroup.getWidth() / 8;
  int yGroupBorder = loginGroup.getBackgroundHeight() / 10;
  int yGap = yGroupBorder; //This value probably needs to be changed
  //Headline label
  Textlabel h = cp5.addTextlabel("l1")
                   .setText("Login")
                   .setPosition(xGroupBorder, yGroupBorder)
                   .setColorValue(color(255))
                   .setFont(createFont("Times",40))
                   .setGroup(loginGroup)
                   ;
  
  PFont inputFont = createFont("Times",20);
  //Username textInput 
  Textfield uT = cp5.addTextfield("username")
                    .setPosition(xGroupBorder, yGroupBorder + h.getHeight() + yGap )
                    .setSize(loginGroup.getWidth() - 2*xGroupBorder, yGap)
                    .setFont(inputFont)
                    .setFocus(false)
                    .setColor(255)
                    .setColorBackground(0)
                    .setColorForeground(0)
                    .setColorActive(255)
                    .setGroup(loginGroup)
                    ;
  //Put the label at the top and left.
  uT.getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);
  
  //Password textInput 
  Textfield pT = cp5.addTextfield("password")
                    .setPosition(xGroupBorder, yGroupBorder + h.getHeight() + yGap + uT.getHeight() + yGap)
                    .setSize(loginGroup.getWidth() - 2*xGroupBorder, yGap)
                    .setFont(inputFont)
                    .setFocus(false)
                    .setColor(255)
                    .setColorBackground(0)
                    .setColorForeground(0)
                    .setColorActive(255)
                    .setGroup(loginGroup)
                    ;
  //Put the label at the top and left.
  pT.getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);
  
  Button lB = cp5.addButton("login")
                 .setValue(100)
                 .setPosition(xGroupBorder, yGroupBorder + h.getHeight() + yGap + uT.getHeight() + yGap + pT.getHeight() + yGap)
                 .setSize(loginGroup.getWidth() - 2*xGroupBorder, yGap)
                 .setFont(inputFont)
                 .setColorBackground(0)
                 .setGroup(loginGroup)
                 ;

  return new Screen(loginGroup, "LoginScreen");
}

void login(){
  println("HERE WE SHOULD ATTEMPT TO LOGIN");
}
