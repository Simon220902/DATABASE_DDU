int xGap;
int yGap;

int chooseChatGroupWidth;
int chatGroupWidth;

int yGroupGap;
int xGroupGap;


int chatListTextfieldHeight;
int yMessageList;
int messageListHeight;

PFont f;

void MessageInput(String _){
  send(0);
}

void send(int _){
  if(session.currentChatTable != null){
    String message = cp5.get(Textfield.class, "MessageInput").getText(); 
    String userID = str(session.currentUserID);
    db.execute("INSERT INTO " + session.currentChatTable + "(Message, Time, UserID) VALUES "+"('"+message+"', datetime('now','localtime'),"+ userID +");");
    cp5.get(Textfield.class, "MessageInput").setText("");
    //Instead we should do the following:
    ListBox messageList = cp5.get(ListBox.class, "MessageList");
    messageList.addItem(userID+": "+message,messageList.getItems().size());
    //Updates the height to dodge java.lang.IndexOutOfBoundsException, that comes when clicking in the messageList, where there is no items
    if(messageList.getItems().size()*30<messageListHeight){
      messageList.setHeight(messageList.getItems().size()*30);
    }else{
      messageList.setHeight(messageListHeight);    
    }
  }else{
    Textlabel w = cp5.get(Textlabel.class, "warning");
    w.setText("You have to be in a chat to send a message.");
    successGroup.hide();
    warningGroup.show();
  }
}

  int xGap = 2 * width/30;
  int yGap = height/10;
  
  int chooseChatScreenWidth = 8 * width/30;
  int chatScreenWidth = 16 * width/30;

Screen MakeChatList() {
  
  Group chatList = cp5.addGroup("ChatList")
                        .setPosition(xGap,yGap)
                        .setWidth(chooseChatScreenWidth)
                        .setBackgroundHeight(height-2*yGap)
                        .setBackgroundColor(color(150))
                        .hideBar()
                        .hide()
                        ;
  
}
 

Screen MakeChatScreen(){

Group MakeChatGroup(){
  f = createFont("Times", 15);
  
  xGap = 2 * width/30;
  yGap = height/10;

  chooseChatGroupWidth = 8 * width/30;
  chatGroupWidth = 16 * width/30;
  
  Group chatGroup = cp5.addGroup("ChatGroup")
                       .setPosition(2*xGap+chooseChatGroupWidth, yGap)
                       .setWidth(chatGroupWidth)
                       .setBackgroundHeight(height-2*yGap)
                       .setBackgroundColor(color(150))
                       .hideBar()
                       .hide()
                       ;
  yGroupGap = chatGroup.getBackgroundHeight()/15;
  xGroupGap = chatGroup.getWidth()/15;
  
  Textlabel cL = cp5.addTextlabel("chatTitle")
                   .setPosition(xGroupGap, yGroupGap)
                   .setText("CHATTABLETITLE")
                   .setColorValue(color(255))
                   .setFont(f)
                   .setGroup(chatGroup)
                   ;

  chatListTextfieldHeight = chatGroup.getBackgroundHeight() - 3*yGroupGap - cL.getHeight();
  yMessageList = yGroupGap+cL.getHeight();
  messageListHeight = 15*(chatListTextfieldHeight/16);
  
  
  ListBox messageList = cp5.addListBox("MessageList")
                           .setPosition(xGroupGap, yMessageList)
                           .setSize(chatGroup.getWidth() - 2*xGroupGap, messageListHeight)
                           .setItemHeight(30)
                           .setColorBackground(color(200))
                           .setColorActive(color(200))
                           .setColorForeground(color(200))
                           .setFont(f)
                           .setBarVisible(false)
                           .setGroup(chatGroup)
                           ;
  
  int messageInputFieldAndSendButton = chatGroup.getWidth() - 2*xGroupGap;
  Textfield messageInput = cp5.addTextfield("MessageInput")
                              .setPosition(xGroupGap, 2*yGroupGap+cL.getHeight()+messageList.getHeight())
                              .setSize(9*messageInputFieldAndSendButton/10, 1*(chatListTextfieldHeight/16))
                              .setColor(255)
                              .setColorBackground(0)
                              .setColorForeground(0)
                              .setColorActive(255)
                              .setFont(f)
                              .setGroup(chatGroup)
                              ;

  Button sB = cp5.addButton("send")
                 .setPosition(xGroupGap + messageInput.getWidth(), 2*yGroupGap+cL.getHeight()+messageList.getHeight())
                 .setSize(messageInputFieldAndSendButton/10, messageInput.getHeight())
                 .setFont(f)
                 .setColorBackground(color(100))
                 .setGroup(chatGroup)
                 ;
  
  return chatGroup;
}

//Call when sessions chattable has been updated.
void updateChatGroup(){
  ListBox messageList = cp5.get(ListBox.class, "MessageList");
  if(session.currentChatTable != null){
    //Alternatively find a way to delete all of the items in the ListBox.
    messageList.clear();
    //SQL QUERY
    db.query("SELECT * FROM " + session.currentChatTable + ";");
  
    //RUNNING THROUGH EACH OF THE RESULTS
    int i = 0;
    while(db.next()){
        messageList.addItem(str(db.getInt("UserID"))+": "+db.getString("Message"), i);
        i++;
    }
  }else{
    Textlabel w = cp5.get(Textlabel.class, "warning");
    w.setText("You don't have any chats.");
    successGroup.hide();
    warningGroup.show();
  }
  //Updates the height to dodge java.lang.IndexOutOfBoundsException, that comes when clicking in the messageList, where there is no items
  if(messageList.getItems().size()*30<messageListHeight){
    messageList.setHeight(messageList.getItems().size()*30);
  }else{
    messageList.setHeight(messageListHeight);    
  }
}
