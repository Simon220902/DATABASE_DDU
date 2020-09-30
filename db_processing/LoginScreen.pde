void login(int _) {
  //We need to get the password for the username if it is not the right password we need to do something something:___::_::_:;::?#€&%&#€%#€%#€%
  String username = cp5.get(Textfield.class, "username").getText();
  String password = cp5.get(Textfield.class, "password").getText();

  try {
    String myKey = "password";    
    byte[] key = myKey.getBytes("UTF-8");
    MessageDigest sha = MessageDigest.getInstance("SHA-1");
    key = sha.digest(key);
    key = Arrays.copyOf(key, 16);
    SecretKeySpec secretKey = new SecretKeySpec(key, "AES");

    Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
    cipher.init(Cipher.ENCRYPT_MODE, secretKey);
    password = Base64.getEncoder().encodeToString(cipher.doFinal(password.getBytes("UTF-8")));
    println(password);
  }

  catch(Exception e) {
  }



  db.query( "SELECT * FROM USERS WHERE UserName = '"+username+"';");
  db.next();
  String actualPassword = db.getString("Password");

  if (actualPassword == null) {
    //WE should probablby handle the java.sql.SQLException.
    Textlabel w = cp5.get(Textlabel.class, "warning");
    w.setText("The user doesn't exist.");
    successGroup.hide();
    warningGroup.show();
  } else if (password.equals(actualPassword)) {
    Textlabel s = cp5.get(Textlabel.class, "success");
    s.setText("Successful login");
    warningGroup.hide();
    successGroup.show();

    //We clear the text fields
    cp5.get(Textfield.class, "username").setText("");
    cp5.get(Textfield.class, "password").setText("");

    //We update the session, sessionGroup and change which Groups are shown
    session.updateUser(db.getInt("UserID"), username);
    session.pickChat();
    cp5.get(Textlabel.class, "user").setText(session.currentUser);    

    loginGroup.hide();
    sessionGroup.show();
    chatGroup.show();
    updateChatGroup();
    chatListGroup.show();
    updateNewChatGroup();



    //HERE WE ARE GOING TO GET INTO THE ACTUAL MESSAGING APP WITH THAT USER.
  } else {
    Textlabel w = cp5.get(Textlabel.class, "warning");
    w.setText("The password is incorrect.");
    successGroup.hide();
    warningGroup.show();
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
    .setBackgroundColor(color(200, 155))
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
