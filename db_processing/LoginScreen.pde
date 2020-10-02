String myKey = "BF3D4300EAD45FA669";

void login(int _) {
  //We need to get the password for the username if it is not the right password we need to do something something:___::_::_:;::?#€&%&#€%#€%#€%
  String username = cp5.get(Textfield.class, "username").getText();
  String password = cp5.get(Textfield.class, "password").getText();
  try {
        //Vha. MessageDigest kan vi anvende en hashing algoritme.... her SHA-256 ...
        //prøv f.eks. MD-5 og se om du kan bryde den ved at søge på nettet!
        MessageDigest md = MessageDigest.getInstance("SHA-256");         
        //MassageDigest objektet "fodres" med teksten, der skal "hashes"
        md.update(password.getBytes());    
        //digest funktionen giver "hash-værdien", men i hexadecimale bytes 
        byte[] byteList = md.digest();
        //Her anvendes processings hex funktion, der kan konvertere hexadecimale bytes til Strings
        //så det er muligt at læse "hash-værdien"
        StringBuffer hashedValueBuffer = new StringBuffer();
        for (byte b : byteList)hashedValueBuffer.append(hex(b)); 
        //We insert the new user and save the change to the data base
        password = hashedValueBuffer.toString();
      }
  catch (Exception e) {
        System.out.println("Exception: "+e);
  }


  //We do the database check
  try {
    Statement st = DB.createStatement();
    ResultSet rs = st.executeQuery("SELECT * FROM USERS WHERE UserName = '"+username+"';");
    Boolean wasThereAResult = rs.next();
    if (wasThereAResult) {
      
      String actualPassword = rs.getString("Password");
      println("WRITTEN PASSWORD: ", password);
      println("ACTUAL PASSWORD: ", actualPassword);

      if (password.equals(actualPassword)) {
        Textlabel s = cp5.get(Textlabel.class, "success");
        s.setText("Successful login");
        warningGroup.hide();
        successGroup.show();
    
        //We clear the text fields
        cp5.get(Textfield.class, "username").setText("");
        cp5.get(Textfield.class, "password").setText("");
        //We update the session, sessionGroup and change which Groups are shown
        session.updateUser(rs.getInt("UserID"), username);
        session.pickChat();
        cp5.get(Textlabel.class, "user").setText(session.currentUser);    
    
        loginGroup.hide();
        sessionGroup.show();
        
        chatListGroup.show();
        
        chatGroup.show();
        updateChatGroup();
      //HERE WE ARE GOING TO GET INTO THE ACTUAL MESSAGING APP WITH THAT USER.
      }else {
        Textlabel w = cp5.get(Textlabel.class, "warning");
        w.setText("The password is incorrect.");
        successGroup.hide();
        warningGroup.show();
      }
    }else{
      //WE should probablby handle the java.sql.SQLException.
      Textlabel w = cp5.get(Textlabel.class, "warning");
      w.setText("The user doesn't exist.");
      successGroup.hide();
      warningGroup.show();
    } 
    rs.close();
    st.close();
  }catch (java.sql.SQLException e) {
    println(e.getMessage());
  }
}

void newUser(int _) {
  //We shift to the new user Group
  loginGroup.hide(); 
  newUserGroup.show();
}

//Consider using autoheight and autowidth and auto spacing for group
Group MakeLoginGroup() {
  int xBorder = int(width / 8);
  int yBorder = int(height / 10);

  Group loginGroup = cp5.addGroup("LoginGroup")
                        .setPosition(xBorder, yBorder)
                        .setWidth(width - 2*xBorder)
                        .setBackgroundHeight(height - 2*yBorder)
                        .setBackgroundColor(color(200))
                        .hideBar()
                        .hide()
                        ;
  
  int xGroupBorder = loginGroup.getWidth() / 8;
  int yGroupBorder = loginGroup.getBackgroundHeight() / 10;
  int yGap = yGroupBorder; //This value probably needs to be changed
  //Headline label
  Textlabel h = cp5.addTextlabel("l1")
    .setText("Login")
    .setPosition(xGroupBorder, yGroupBorder)
    .setColorValue(color(255))
    .setFont(createFont("Times", 40))
    .setGroup(loginGroup)
    ;

  PFont inputFont = createFont("Times", 20);

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
    .setPosition(2*xGroupBorder, yGroupBorder + h.getHeight() + yGap + uT.getHeight() + yGap + pT.getHeight() + yGap/2)
    .setSize(loginGroup.getWidth() - 4*xGroupBorder, int(1.5*yGap))
    .setFont(inputFont)
    .setColorBackground(0)
    .setGroup(loginGroup)
    ;

  Button nB = cp5.addButton("newUser")
    .setLabel("New user")
    .setPosition(2*xGroupBorder, yGroupBorder + h.getHeight() + yGap + uT.getHeight() + yGap + pT.getHeight() + yGap/2 + lB.getHeight() + yGap/2)
    .setSize(loginGroup.getWidth() - 4*xGroupBorder, int(1.5*yGap))
    .setFont(inputFont)
    .setColorBackground(0)
    .setGroup(loginGroup)
    ;

  return loginGroup;
}
