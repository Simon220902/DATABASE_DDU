
//THIS IS READY FOR THE Group JUST CALL THE LIST CHATLIST AND BUTTON newChat
int chatListHeight; //SET THE VALUE OF THIS VARIABLE IN THE MakeNewChatListGroup function!!!!!!!!!!!!!!!!!!!

void updateChatListGroup(){
  ListBox chatList = cp5.get(ListBox.class, "ChatList");
  if(session.currentChatTable != null){
    chatList.clear();
    //SQL QUERY
    db.query("SELECT * FROM CHATS WHERE UserID1 = " + str(session.currentUserID) + " OR UserID2 = " + str(session.currentUserID) + ";");
    //RUNNING THROUGH EACH OF THE RESULTS
    int i = 0;
    while(db.next()){
        chatList.addItem(db.getString("ChatTableName"), i);
        i++;
    }
  }else{
    Textlabel w = cp5.get(Textlabel.class, "warning");
    w.setText("You don't have any chats, click on the button to create one.");
    successGroup.hide();
    warningGroup.show();
  }
  //Updates the height to dodge java.lang.IndexOutOfBoundsException, that comes when clicking in the messageList, where there are no items
  if(chatList.getItems().size()*30<chatListHeight){
    chatList.setHeight(chatList.getItems().size()*30);
  }else{
    chatList.setHeight(chatListHeight);    
  }
}

void newChat(){
  newChatGroup.show();
  chatListGroup.hide();
  chatGroup.hide();
}

// When a chat from the list is picked we change the current chat to that chat
void controlEventChatListGroup(ControlEvent theEvent) {
  //THE PROGRAM CRASHES IF YOU CLICK INSIDE THE AREA OF THE LISTBOX BUT WITHOUT THE ELEMENT
  ListBox chatList = cp5.get(ListBox.class, "ChatList");
  if (theEvent.isFrom(chatList)) {
    // an event from a group e.g. scrollList
    int activeIndex = int(theEvent.getValue());
    if (chatList.getItems().size()-1 >= activeIndex){
      Map<String, Object> listEntry = chatList.getItem(activeIndex);
      String chosenChat = (String) listEntry.get("text");
      println("THE CHOSEN CHAT IS: ", chosenChat);
      //Set this new chattable as the sessions chattable
      session.updateChat(chosenChat);
      //Give a success message and return to the chat Groups.
      Textlabel s = cp5.get(Textlabel.class, "success");
      s.setText("Changed current chat to " + chosenChat);
      warningGroup.group.hide();
      successGroup.show();
    }
  }
}
