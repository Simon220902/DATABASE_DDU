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

void MessageInput(String _) {
  send(0);
}

void send(int _) {
  if (session.currentChatTable != null) {
    String message = cp5.get(Textfield.class, "MessageInput").getText();
    String userID = str(session.currentUserID);
    String messageEncrypted = "";
    try{
      byte[] key = session.currentKey.getBytes("UTF-8");
      MessageDigest sha = MessageDigest.getInstance("SHA-1");
      key = sha.digest(key);
      key = Arrays.copyOf(key, 16); 
      SecretKeySpec secretKey = new SecretKeySpec(key, "AES");
      
      
      //sådan kan man "kryptere"
      Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
      cipher.init(Cipher.ENCRYPT_MODE, secretKey);
      messageEncrypted = Base64.getEncoder().encodeToString(cipher.doFinal(message.getBytes("UTF-8")));
    }catch(Exception e){
      println("!!!EXCEPTION!!!:",e);
    }
  db.execute("INSERT INTO " + session.currentChatTable + "(Message, Time, UserID) VALUES "+"('"+messageEncrypted+"', datetime('now','localtime'),"+ userID +");");
  cp5.get(Textfield.class, "MessageInput").setText("");
  //We update the list of messages
  ListBox messageList = cp5.get(ListBox.class, "MessageList");
  messageList.addItem(userID+": "+message, messageList.getItems().size());
  //Updates the height to dodge java.lang.IndexOutOfBoundsException, that comes when clicking in the messageList, where there is no items
  if (messageList.getItems().size()*30<messageListHeight) {
    messageList.setHeight(messageList.getItems().size()*30);
  } else {
    messageList.setHeight(messageListHeight);
  }
  } else {
    Textlabel w = cp5.get(Textlabel.class, "warning");
    w.setText("You have to be in a chat to send a message.");
    successGroup.hide();
    warningGroup.show();
  }
}

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
  ListBox chatList = cp5.addListBox("ChatList")
                        .setPosition(-xGap-chooseChatGroupWidth+xGroupGap, yMessageList)
                        .setSize(chooseChatGroupWidth - 2*xGroupGap, messageListHeight)
                        .setItemHeight(30)
                        .setColorBackground(color(200))
                        .setColorActive(color(0))
                        .setColorForeground(color(100))
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
void updateChatGroup() {
  ListBox messageList = cp5.get(ListBox.class, "MessageList");
  ListBox chatList = cp5.get(ListBox.class, "ChatList");
  
  if(session.currentChatTable != null){
    //Alternatively find a way to delete all of the items in the ListBox.
    messageList.clear();
    //SQL QUERY
    db.query("SELECT * FROM " + session.currentChatTable + ";");
    try{
      byte[] key = session.currentKey.getBytes("UTF-8");
      MessageDigest sha = MessageDigest.getInstance("SHA-1");
      key = sha.digest(key);
      key = Arrays.copyOf(key, 16); 
      SecretKeySpec secretKey = new SecretKeySpec(key, "AES");
      Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
      cipher.init(Cipher.DECRYPT_MODE, secretKey);
      //RUNNING THROUGH EACH OF THE RESULTS
      int i = 0;
      while (db.next()) {
        String encryptedMessage = db.getString("Message");
        String decryptedMessage = new String(cipher.doFinal(Base64.getDecoder().decode(encryptedMessage)));
        messageList.addItem(str(db.getInt("UserID"))+": " + decryptedMessage, i);
        i++;
      }
    }catch(Exception e){
      println("!!exception!!:",e);
    }
    
    chatList.clear();
    db.query("SELECT * FROM CHATS WHERE UserID1 = " + str(session.currentUserID) + " OR UserID2 = " + str(session.currentUserID) + ";");
    //RUNNING THROUGH EACH OF THE RESULTS
    int i = 0;
    while(db.next()){
      String chatname = db.getString("ChatTableName");
        //messageList.addItem(str(db.getInt("UserID"))+": "+db.getString("Message"), i);
        chatList.addItem(chatname, i);
        i++;
    }
  }else{
    Textlabel w = cp5.get(Textlabel.class, "warning");
    w.setText("You don't have any chats.");
    successGroup.hide();
    warningGroup.show();
  }
  //Updates the height to dodge java.lang.IndexOutOfBoundsException, that comes when clicking in the messageList, where there is no items
  if (messageList.getItems().size()*30<messageListHeight) {
    messageList.setHeight(messageList.getItems().size()*30);
  } else {
    messageList.setHeight(messageListHeight);
  }
  if(chatList.getItems().size()*30<messageListHeight){
    chatList.setHeight(chatList.getItems().size()*30);
  }else{
    chatList.setHeight(messageListHeight);    
  }
}
