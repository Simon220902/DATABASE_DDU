int backButtonHeight = 40;

Group MakeNewChatGroup(){
  f = createFont("Times", 15);
  
  xGap = 2 * width/30;
  yGap = height/10;
  
  Group newChatGroup = cp5.addGroup("NewChatGroup")
                       .setPosition(xGap, yGap)
                       .setWidth(width - 2*xGap)
                       .setBackgroundHeight(height - 2*yGap)
                       .setBackgroundColor(color(150))
                       .hideBar()
                       .hide()
                       ;
  yGroupGap = newChatGroup.getBackgroundHeight()/15;
  xGroupGap = newChatGroup.getWidth()/15;
  
  Textlabel ncL = cp5.addTextlabel("newChatTitle")
                   .setPosition(xGroupGap, yGroupGap)
                   .setText("Make a new chat with:")
                   .setColorValue(color(255))
                   .setFont(f)
                   .setGroup(newChatGroup)
                   ;

  int yUsersList = yGroupGap+ncL.getHeight();
  
  ListBox usersList = cp5.addListBox("UsersList")
                           .setPosition(xGroupGap, yUsersList)
                           .setSize(newChatGroup.getWidth() - 2*xGroupGap, newChatGroup.getBackgroundHeight() - 3*yGroupGap - backButtonHeight)
                           .setItemHeight(30)
                           .setColorBackground(color(200))
                           .setColorActive(color(50))
                           .setColorForeground(color(150))
                           .setFont(f)
                           .setBarVisible(false)
                           .setGroup(newChatGroup)
                           ;
  
  Button bB = cp5.addButton("back")
                 .setPosition(xGroupGap, yUsersList + usersList.getHeight() + yGroupGap)
                 .setSize(newChatGroup.getWidth() - 2*xGroupGap, backButtonHeight)
                 .setFont(f)
                 .setColorBackground(color(100))
                 .setGroup(newChatGroup)
                 ;
  
  return newChatGroup;
}

void updateNewChatGroup(){
  //OKAY SO WHA
  ListBox usersList = cp5.get(ListBox.class, "UsersList");
  usersList.clear();
  //We do the query of which users in USERS that the currentUserID doesn't have any chats with (we do a longer compare with the chatstable (both userID1 and 2))
  try{
    Statement st = DB.createStatement();
    ResultSet rs = st.executeQuery("SELECT * FROM USERS WHERE (UserID NOT IN (SELECT UserID1 FROM CHATS WHERE UserID2=" + str(session.currentUserID) + ")) AND (UserID NOT IN (SELECT UserID2 FROM CHATS WHERE UserID1=" + str(session.currentUserID) + ")) AND UserID != " + str(session.currentUserID) + ";");
    while(rs.next()){
      usersList.addItem(rs.getString("UserName"),rs.getInt("UserID"));
    }
  }catch (java.sql.SQLException e) {
    println(e.getMessage());
  }
  
  //We update the height
  if(usersList.getItems().size()*30 < newChatGroup.getBackgroundHeight() - 3*yGroupGap - backButtonHeight){
    usersList.setHeight(usersList.getItems().size()*30);
  }else{
    usersList.setHeight(newChatGroup.getBackgroundHeight() - 3*yGroupGap - backButtonHeight);    
  }
}

// When a user from the list is picked we create a chat with that user
void controlEventNewChatGroup(ControlEvent theEvent) {
  //THE PROGRAM CRASHES IF YOU CLICK INSIDE THE AREA OF THE LISTBOX BUT WITHOUT THE ELEMENT
  ListBox usersList = cp5.get(ListBox.class, "UsersList");
  if (theEvent.isFrom(usersList)) {
    // an event from a group e.g. scrollList
    int activeIndex = int(theEvent.getValue());
    if (usersList.getItems().size()-1 >= activeIndex){
      Map<String, Object> listEntry = usersList.getItem(activeIndex);
      String chosenUsername = (String) listEntry.get("text");
      int chosenUserID = (int) listEntry.get("value");
      println("THE USERID: ", str(chosenUserID));
      println("THE TEXT OF THE ACTIVE ENTRY: ", chosenUsername);
      //Here we should create a new chattable with the user at the active index and add it to the CHATS table
      String newChatName = "Chat"+str(session.currentUserID)+str(chosenUserID);
      //WE SHOULD PROBABLY DO THIS IN A BETTER WAY
      String newEncryptionKey = "";
      for (int i = 0; i < 10; i++){
        newEncryptionKey += str(random(-200,400)*i);
      }
      
      //Creating the new chat table
      try{
        Statement st = DB.createStatement();
        st.executeUpdate("CREATE TABLE " + newChatName + " ( MessageID SERIAL PRIMARY KEY, Message TEXT NOT NULL, Time TEXT, UserID INT NOT NULL);");
        st.close();
      
      }catch (java.sql.SQLException e) {
        println(e.getMessage());
      }
      
      //Adding this to the CHATS table
      try{
        Statement st = DB.createStatement();
        st.executeUpdate("INSERT INTO CHATS (ChatTableName, EncryptionKey, UserID1, UserID2) VALUES ('" + newChatName +  "', '" + newEncryptionKey + "', " + str(session.currentUserID) + ", " + str(chosenUserID) + ");");
        st.close();
       
      }catch (java.sql.SQLException e) {
        println(e.getMessage());
      }      
      
      //Set this new chattable as the sessions chattable
      session.updateChat(newChatName);
      //Give a success message and return to the chat Groups.
      Textlabel s = cp5.get(Textlabel.class, "success");
      s.setText("Created a chat with "+ chosenUsername + " called " + newChatName);
      warningGroup.hide();
      successGroup.show();
      //Returning to the chat
      newChatGroup.hide();
      chatListGroup.show();
      chatGroup.show();
      updateChatGroup();
    }
  }
}

void back(int _){
  newChatGroup.hide();
  chatListGroup.show();
  chatGroup.show();
}
