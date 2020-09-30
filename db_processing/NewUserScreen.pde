import javax.crypto.*; 
import java.security.*;
import java.util.Arrays;
import java.util.Base64;

void createNewUser(int _) {
  String username = cp5.get(Textfield.class, "New username").getText();
  String password1 = cp5.get(Textfield.class, "New password").getText();
  String password2 = cp5.get(Textfield.class, "Repeat password").getText();

  //1st check whether the two passwords are the same

  //2nd check whether there already exists an entry in the user database with that user name.

  //3rd if all of the above apply then add the new user and go back to 

  if (password1.equals(password2)) {
    
    db.query( "SELECT UserName FROM USERS WHERE UserName = '"+username+"';");
    db.next();
    String u = db.getString("UserName");
    if (u == null) {

      //incryption of password before reaching database.

      String myKey = "password";
      String pass = password1;
      //key is made
      try {
        byte[] key = myKey.getBytes("UTF-8");
        MessageDigest sha = MessageDigest.getInstance("SHA-1");
        key = sha.digest(key);
        key = Arrays.copyOf(key, 16);
        SecretKeySpec secretKey = new SecretKeySpec(key, "AES");

        //performing incryption
        Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
        cipher.init(Cipher.ENCRYPT_MODE, secretKey);
        String passwordIncrypted = Base64.getEncoder().encodeToString(cipher.doFinal(pass.getBytes("UTF-8")));
        //We insert the new user and save the change to the data base
        db.execute("INSERT INTO Users (UserName, Password) VALUES ('" + username + "', '" + passwordIncrypted + "');");
        println("passbfinc: "+password1);
        println("passInc: "+passwordIncrypted);
        
        //decryption for testing 
        cipher.init(Cipher.DECRYPT_MODE, secretKey);
        String beskedDekrypteret =  new String(cipher.doFinal(Base64.getDecoder().decode(passwordIncrypted)));
        println("password: "+beskedDekrypteret);
        
      }
      catch(Exception e) {
        
        
      }

      //We show the successlabel
      Textlabel s = cp5.get(Textlabel.class, "success");
      s.setText("New user created");
      warningGroup.hide();
      successGroup.show();

      //We clear the text fields
      cp5.get(Textfield.class, "New username").setText("");
      cp5.get(Textfield.class, "New password").setText("");
      cp5.get(Textfield.class, "Repeat password").setText("");

      //We go back to the login Group
      newUserGroup.hide();
      loginGroup.show();
    } else {
      Textlabel w = cp5.get(Textlabel.class, "warning");
      w.setText("The user already exists.");
      successGroup.hide();
      warningGroup.show();
    }
  } else {
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
