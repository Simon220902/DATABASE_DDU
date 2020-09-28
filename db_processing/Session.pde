class Session{
  int currentUserID;
  String currentUser;
  String currentChatTable;
  
  void updateUser(int newUserID, String newUser){
    currentUserID = newUserID;
    currentUser = newUser;
  }
  
  void updateChat(String newChatTable){
    currentChatTable = newChatTable;
    updateChatGroup();
  }
  
  void pickChat(){
    //We just pick the first chat where our user is a "member"
    db.query( "SELECT * FROM CHATS WHERE UserID1 = "+str(currentUserID)+" OR UserID2 = "+str(currentUserID)+";");
    db.next();
    String newChatTable = db.getString("ChatTableName");
    if (newChatTable != null){
      currentChatTable = newChatTable;
    }
  }
  
  void clear(){
    currentUserID = 0;
    currentUser = "";
    currentChatTable = "";
  }
}
