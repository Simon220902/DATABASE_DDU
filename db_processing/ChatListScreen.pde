int chatListHeight; //SET THE VALUE OF THIS VARIABLE IN THE MakeNewChatListGroup function!!!!!!!!!!!!!!!!!!!

Group MakeChatListGroup() {
  xGap = 2 * width/30;
  yGap = height/10;
  chooseChatGroupWidth = 8 * width/30;
  
  Group chatListGroup = cp5.addGroup("ChatListGroup")
                        .setPosition(xGap,yGap)
                        .setWidth(chooseChatGroupWidth)
                        .setBackgroundHeight(height-2*yGap)
                        .setBackgroundColor(color(150, 0))
                        .hideBar()
                        .hide()
                        ;
  Textlabel clL = cp5.addTextlabel("chatListTitle")
                        .setPosition(xGroupGap, yGroupGap)
                        .setText("Chat list")
                        .setColorValue(color(255))
                        .setFont(f)
                        .setGroup(chatListGroup) 
                        ;
  Button addChat = cp5.addButton("newChat")
                        .setPosition(xGroupGap,height-2*yGap-yGap)
                        .setWidth(chatListGroup.getWidth()-2*yGap)
                        .setSize(chooseChatGroupWidth-2*xGroupGap, 1*(chatListTextfieldHeight/16))
                        .setCaptionLabel("Make a new chat")
                        .setColorBackground(color(100))
                        .setFont(f)
                        .setGroup(chatListGroup)
                        ;
  return chatListGroup;
}

void newChat(){
  newChatGroup.show();
  updateNewChatGroup();
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
  }}
