void send(int _){
  println("A MESSAGE WAS SENT");
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

  

  Group chatGroup = cp5.addGroup("ChatScreen")
                        .setPosition(2*xGap+chooseChatScreenWidth, yGap)
                        .setWidth(chatScreenWidth)
                        .setBackgroundHeight(height-2*yGap)
                        .setBackgroundColor(color(150))
                        .hideBar()
                        .hide()
                        ;
  int yScreenGap = chatGroup.getBackgroundHeight()/15;
  int xScreenGap = chatGroup.getWidth()/15;
  
  PFont f = createFont("Times", 15);
  Textlabel cL = cp5.addTextlabel("chatTitle")
                   .setPosition(xScreenGap, yScreenGap)
                   .setText("CHATTABLETITLE")
                   .setColorValue(color(255))
                   .setFont(f)
                   .setGroup(chatGroup)
                   ;

  int chatListTextfielHeight = chatGroup.getBackgroundHeight() - 3*yScreenGap - cL.getHeight();
    
  ListBox messageList = cp5.addListBox("MessageList")
                           .setPosition(xScreenGap, yScreenGap+cL.getHeight())
                           .setSize(chatGroup.getWidth() - 2*xScreenGap, 15*(chatListTextfielHeight/16))
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
                              .setSize(9*messageInputFieldAndSendButton/10, 1*(chatListTextfielHeight/16))
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
