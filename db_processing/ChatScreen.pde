int xGap;
int yGap;

int chooseChatScreenWidth;
int chatScreenWidth;

int yScreenGap;
int xScreenGap;


int chatListTextfieldHeight;
int yMessageList;

PFont f;

void send(int _){
  println("A MESSAGE WAS SENT");
  String message = cp5.get(Textfield.class, "MessageInput").getText(); 
  db.execute("INSERT INTO " + session.currentChatTable + "(Message, Time, UserID) VALUES "+"('"+message+"', datetime('now','localtime'),"+ str(session.currentUserID) +");");
  cp5.get(Textfield.class, "MessageInput").setText("");
  //PROBABLY A BIT SLOW
  updateChatScreen();
}
 
/*
MessageID INTEGER PRIMARY KEY AUTOINCREMENT,
Message TEXT NOT NULL,
Time TEXT,
UserID INT NOT NULL)

*/ 
 

Screen MakeChatScreen(){
  f = createFont("Times", 15);
  
  xGap = 2 * width/30;
  yGap = height/10;

  chooseChatScreenWidth = 8 * width/30;
  chatScreenWidth = 16 * width/30;
  
  Group chatGroup = cp5.addGroup("ChatScreen")
                       .setPosition(2*xGap+chooseChatScreenWidth, yGap)
                       .setWidth(chatScreenWidth)
                       .setBackgroundHeight(height-2*yGap)
                       .setBackgroundColor(color(150))
                       .hideBar()
                       .hide()
                       ;
  yScreenGap = chatGroup.getBackgroundHeight()/15;
  xScreenGap = chatGroup.getWidth()/15;
  
  Textlabel cL = cp5.addTextlabel("chatTitle")
                   .setPosition(xScreenGap, yScreenGap)
                   .setText("CHATTABLETITLE")
                   .setColorValue(color(255))
                   .setFont(f)
                   .setGroup(chatGroup)
                   ;

  chatListTextfieldHeight = chatGroup.getBackgroundHeight() - 3*yScreenGap - cL.getHeight();
  yMessageList = yScreenGap+cL.getHeight();
  
  ListBox messageList = cp5.addListBox("MessageList")
                           .setPosition(xScreenGap, yMessageList)
                           .setSize(chatGroup.getWidth() - 2*xScreenGap, 15*(chatListTextfieldHeight/16))
                           .setItemHeight(30)
                           .setColorBackground(color(200))
                           .setColorActive(color(200))
                           .setColorForeground(color(200))
                           .setFont(f)
                           .setBarVisible(false)
                           .setGroup(chatGroup)
                           ;
  for (int i=0;i<80;i++) {
      messageList.addItem("MESSAGE: "+i, i);
  }
  
  int messageInputFieldAndSendButton = chatGroup.getWidth() - 2*xScreenGap;
  Textfield messageInput = cp5.addTextfield("MessageInput")
                              .setPosition(xScreenGap, 2*yScreenGap+cL.getHeight()+messageList.getHeight())
                              .setSize(9*messageInputFieldAndSendButton/10, 1*(chatListTextfieldHeight/16))
                              .setColor(255)
                              .setColorBackground(0)
                              .setColorForeground(0)
                              .setColorActive(255)
                              .setFont(f)
                              .setGroup(chatGroup)
                              ;

  Button sB = cp5.addButton("send")
                 .setPosition(xScreenGap + messageInput.getWidth(), 2*yScreenGap+cL.getHeight()+messageList.getHeight())
                 .setSize(messageInputFieldAndSendButton/10, messageInput.getHeight())
                 .setFont(f)
                 .setColorBackground(color(100))
                 .setGroup(chatGroup)
                 ;
  
  return new Screen(chatGroup, "chatScreen");
}

//Call when sessions chattable has been updated.
void updateChatScreen(){
  cp5.remove(cp5.get("MessageList"));
  ListBox messageList = cp5.addListBox("MessageList")
                           .setPosition(xScreenGap, yMessageList)
                           .setSize(chatScreen.group.getWidth() - 2*xScreenGap, 15*(chatListTextfieldHeight/16))
                           .setItemHeight(30)
                           .setColorBackground(color(200))
                           .setColorActive(color(200))
                           .setColorForeground(color(200))
                           .setFont(f)
                           .setBarVisible(false)
                           .setGroup(chatScreen.group)
                           ;

  //SQL QUERY
  db.query("SELECT * FROM " + session.currentChatTable + ";");

  //RUNNING THROUGH EACH OF THE RESULTS
  int i = 0;
  while(db.next()){
      messageList.addItem(str(db.getInt("UserID"))+": "+db.getString("Message"), i);
      i++;
  }
  
}
