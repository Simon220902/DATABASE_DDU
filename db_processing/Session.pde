class Session{
  int currentUserID;
  String currentUser;
  String currentChatTable;
  String currentKey;
  
  void updateUser(int newUserID, String newUser){
    currentUserID = newUserID;
    currentUser = newUser;
  }
  
  void updateChat(String newChatTable){
    currentChatTable = newChatTable;
    db.query( "SELECT EncryptionKey FROM CHATS WHERE ChatTableName = "+newChatTable+";");
    updateChatGroup();
  }
  
  void pickChat(){
    //We just pick the first chat where our user is a "member"
    db.query( "SELECT * FROM CHATS WHERE UserID1 = "+str(currentUserID)+" OR UserID2 = "+str(currentUserID)+";");
    db.next();
    String newChatTable = db.getString("ChatTableName");
    String newKey = db.getString("EncryptionKey");
    if (newChatTable != null && newKey != null){
      currentChatTable = newChatTable;
      currentKey = newKey;
    }else{
      //Give some warning message
    }
  }
  
  void clear(){
    currentUserID = 0;
    currentUser = "";
    currentChatTable = "";
  }
}
