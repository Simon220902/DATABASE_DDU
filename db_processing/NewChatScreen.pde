import java.util.Map;

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
  int backButtonHeight = 40;
  
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
  usersList.addItem("FIRST ITEM!", 0);
  usersList.addItem("SECOND ITEM!", 1);
  
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
  db.query("SELECT * FROM USERS WHERE (UserID NOT IN (SELECT UserID1 FROM CHATS WHERE UserID2=" + str(session.currentUserID) + ")) AND (UserID NOT IN (SELECT UserID2 FROM CHATS WHERE UserID1=" + str(session.currentUserID) + ")) AND UserID != " + str(session.currentUserID) + ";");
  int i = 0;
  while(db.next()){
    usersList.addItem(db.getString("UserName"),db.getInt("UserID"));
    i++;
  }
  //We update the height, the itemheight being 30.
  usersList.setHeight(usersList.getItems().size()*30) ;
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
      //Creating the new chat table
      db.execute("CREATE TABLE " + newChatName + " ( MessageID INTEGER PRIMARY KEY AUTOINCREMENT, Message TEXT NOT NULL, Time TEXT, UserID INT NOT NULL);");
      //Adding this to the CHATS table
      db.execute("INSERT INTO CHATS (ChatTableName, UserID1, UserID2) VALUES ('" + newChatName +  "', " + str(session.currentUserID) + ", " + str(chosenUserID) + ");");
      //Set this new chattable as the sessions chattable
      session.updateChat(newChatName);
      //updateChatListGroup();
      //Give a success message and return to the chat Groups.
      Textlabel s = cp5.get(Textlabel.class, "success");
      s.setText("Created a chat with "+ chosenUsername + " called " + newChatName);
      warningGroup.hide();
      successGroup.show();
      //Returning to the chat
      newChatGroup.hide();
      //chatListGroup.group.show();
      chatGroup.show();
    }
  }
}

void back(int _){
  newChatGroup.hide();
  //chatListGroup.group.show();
  chatGroup.show();
}