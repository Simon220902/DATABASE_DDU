void createNewUser(int _){
  String username = cp5.get(Textfield.class, "New username").getText();
  String password1 = cp5.get(Textfield.class, "New password").getText();
  String password2 = cp5.get(Textfield.class, "Repeat password").getText();
  
  //1st check whether the two passwords are the same
  
  //2nd check whether there already exists an entry in the user database with that user name.
  
  //3rd if all of the above apply then add the new user and go back to 
  
  if (password1.equals(password2)){
      db.query( "SELECT UserName FROM USERS WHERE UserName = '"+username+"';");
      db.next();
      String u = db.getString("UserName");
      println();
      println("RESULT", u);
      println();
      if (u == null){
        //We insert the new user and save the change to the data base
        db.execute("INSERT INTO Users (UserName, Password) VALUES ('" + username + "', '" + password1 + "');");
        Textlabel s = cp5.get(Textlabel.class, "success");
        s.setText("New user created");
        warningScreen.group.hide();
        successScreen.group.show();
    }
    else{
      Textlabel w = cp5.get(Textlabel.class, "warning");
      w.setText("The user already exists.");
      successScreen.group.hide();
      warningScreen.group.show();
    }
  }else{
    Textlabel w = cp5.get(Textlabel.class, "warning");
    w.setText("The passwords don't match.");
    successScreen.group.hide();
    warningScreen.group.show();
  }
  
  
  
  
  
  
  
  println("USERNAME: ", username);
  println("PASSWORD1: ", password1);
  println("PASSWORD2: ", password2);
  
  println("Try to create the USER!!");
}

//Consider using autoheight and autowidth and auto spacing for group
Screen MakeNewUserScreen(){
  int xBorder = int(width / 8);
  int yBorder = int(height / 15);
  
  Group newUserGroup = cp5.addGroup("newUserScreen")
                        .setPosition(xBorder, yBorder)
                        .setWidth(width - 2*xBorder)
                        .setBackgroundHeight(height - 2*yBorder)
                        .setBackgroundColor(color(200, 155))
                        .hideBar()
                        .hide()
                        ;
  
  int xGroupBorder = newUserGroup.getWidth() / 8;
  int yGroupBorder = newUserGroup.getBackgroundHeight() / 10;
  int yGap = yGroupBorder; //This value probably needs to be changed
  //Headline label
  Textlabel h = cp5.addTextlabel("l2")
                   .setText("Create new user")
                   .setPosition(xGroupBorder, yGroupBorder)
                   .setColorValue(color(255))
                   .setFont(createFont("Times",40))
                   .setGroup(newUserGroup)
                   ;

  PFont inputFont = createFont("Times",20);
  
  //Username textInput 
  Textfield uT = cp5.addTextfield("New username")
                    .setPosition(xGroupBorder, yGroupBorder + h.getHeight() + yGap )
                    .setSize(newUserGroup.getWidth() - 2*xGroupBorder, yGap)
                    .setFont(inputFont)
                    .setFocus(false)
                    .setColor(255)
                    .setColorBackground(0)
                    .setColorForeground(0)
                    .setColorActive(255)
                    .setGroup(newUserGroup)
                    ;
  //Put the label at the top and left.
  uT.getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);
  
  //Password textInput 
  Textfield p1T = cp5.addTextfield("New password")
                    .setPosition(xGroupBorder, yGroupBorder + h.getHeight() + yGap + uT.getHeight() + yGap)
                    .setSize(newUserGroup.getWidth() - 2*xGroupBorder, yGap)
                    .setFont(inputFont)
                    .setFocus(false)
                    .setColor(255)
                    .setColorBackground(0)
                    .setColorForeground(0)
                    .setColorActive(255)
                    .setGroup(newUserGroup)
                    ;
  //Put the label at the top and left.
  p1T.getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);
  
  //Password textInput 
  Textfield p2T = cp5.addTextfield("Repeat password")
                    .setPosition(xGroupBorder, yGroupBorder + h.getHeight() + yGap + uT.getHeight() + yGap + p1T.getHeight() + yGap)
                    .setSize(newUserGroup.getWidth() - 2*xGroupBorder, yGap)
                    .setFont(inputFont)
                    .setFocus(false)
                    .setColor(255)
                    .setColorBackground(0)
                    .setColorForeground(0)
                    .setColorActive(255)
                    .setGroup(newUserGroup)
                    ;
  //Put the label at the top and left.
  p2T.getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);
  
  Button cB = cp5.addButton("createNewUser")
                 .setLabel("Create new user")
                 .setPosition(xGroupBorder, yGroupBorder + h.getHeight() + yGap + uT.getHeight() + yGap + p1T.getHeight() + yGap + p2T.getHeight() + yGap/2)
                 .setSize(newUserGroup.getWidth() - 2*xGroupBorder, int(1.5*yGap))
                 .setFont(inputFont)
                 .setColorBackground(0)
                 .setGroup(newUserGroup)
                 ;
  
  return new Screen(newUserGroup, "newUserScreen");
}
