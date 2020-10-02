void createNewUser(int _) {
  String username = cp5.get(Textfield.class, "New username").getText();
  String password1 = cp5.get(Textfield.class, "New password").getText();
  String password2 = cp5.get(Textfield.class, "Repeat password").getText();

  //1st check whether the two passwords are the same

  //2nd check whether there already exists an entry in the user database with that user name.

  //3rd if all of the above apply then add the new user and go back to 

  if (password1.equals(password2)) {
    try {
      Statement st = DB.createStatement();
      ResultSet rs = st.executeQuery("SELECT UserName FROM USERS WHERE UserName = '"+username+"';");
      //If the user EXISTS
      if (rs.next()) {
        Textlabel w = cp5.get(Textlabel.class, "warning");
        w.setText("The user already exists.");
        successGroup.hide();
        warningGroup.show();

        rs.close();
        st.close();
      }
      //If the user doesn't already exist
      else {
        rs.close();
        st.close();

        try {
          //Vha. MessageDigest kan vi anvende en hashing algoritme.... her SHA-256 ...
          //prøv f.eks. MD-5 og se om du kan bryde den ved at søge på nettet!
          MessageDigest md = MessageDigest.getInstance("SHA-256");         
          //MassageDigest objektet "fodres" med teksten, der skal "hashes"
          md.update(password1.getBytes());    
          //digest funktionen giver "hash-værdien", men i hexadecimale bytes 
          byte[] byteList = md.digest();
          //Her anvendes processings hex funktion, der kan konvertere hexadecimale bytes til Strings
          //så det er muligt at læse "hash-værdien"
          StringBuffer hashedValueBuffer = new StringBuffer();
          for (byte b : byteList) hashedValueBuffer.append(hex(b));
          //We return before getting the exception below
          returnToLogin(0);
          //We insert the new user and save the change to the data base
          st = DB.createStatement();
          st.executeQuery("INSERT INTO Users (UserName, Password) VALUES ('" + username + "', '" + hashedValueBuffer.toString() + "');");
          rs.close();
          st.close();
        }
        catch (Exception e) {
          System.out.println("Exception: "+e);
        }
      }
    }catch (java.sql.SQLException e) {
        println(e.getMessage());
      }
  }else {
    Textlabel w = cp5.get(Textlabel.class, "warning");
    w.setText("The passwords don't match.");
    successGroup.hide();
    warningGroup.show();
  }
}

void returnToLogin(int _) {
  //We clear the text fields
  cp5.get(Textfield.class, "New username").setText("");
  cp5.get(Textfield.class, "New password").setText("");
  cp5.get(Textfield.class, "Repeat password").setText("");
  //We go back to the login Group
  newUserGroup.hide();
  loginGroup.show();
}

//Consider using autoheight and autowidth and auto spacing for group
Group MakeNewUserGroup() {
  int xBorder = int(width / 8);
  int yBorder = int(height / 15);

  Group newUserGroup = cp5.addGroup("newUserGroup")
    .setPosition(xBorder, yBorder)
    .setWidth(width - 2*xBorder)
    .setBackgroundHeight(height - 2*yBorder)
    .setBackgroundColor(color(200, 155))
    .hideBar()
    .hide()
    ;

  int xGroupBorder = newUserGroup.getWidth() / 8;
  int yGroupBorder = newUserGroup.getBackgroundHeight() / 12;
  int yGap = yGroupBorder; //This value probably needs to be changed
  //Headline label
  Textlabel h = cp5.addTextlabel("l2")
    .setText("Create new user")
    .setPosition(xGroupBorder, yGroupBorder)
    .setColorValue(color(255))
    .setFont(createFont("Times", 40))
    .setGroup(newUserGroup)
    ;

  PFont inputFont = createFont("Times", 20);

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
    .setPosition(2*xGroupBorder, yGroupBorder + h.getHeight() + yGap + uT.getHeight() + yGap + p1T.getHeight() + yGap + p2T.getHeight() + yGap/2)
    .setSize(newUserGroup.getWidth() - 4*xGroupBorder, int(1.5*yGap))
    .setFont(inputFont)
    .setColorBackground(0)
    .setGroup(newUserGroup)
    ;

  Button rB = cp5.addButton("returnToLogin")
    .setLabel("← Return to login")
    .setPosition(2*xGroupBorder, yGroupBorder + h.getHeight() + yGap + uT.getHeight() + yGap + p1T.getHeight() + yGap + p2T.getHeight() + yGap/2 + cB.getHeight() + yGap/2)
    .setSize(newUserGroup.getWidth() - 4*xGroupBorder, int(1.5*yGap))
    .setFont(inputFont)
    .setColorBackground(0)
    .setGroup(newUserGroup)
    ;

  return newUserGroup;
}
