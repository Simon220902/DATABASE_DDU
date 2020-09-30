class Session{
  int currentUserID;
  String currentUser;
  //The username of the UserID2 in the current chattable.
  String currentUser2;
  String currentChatTable;
  String currentKey;
  
  void updateUser(int newUserID, String newUser){
    currentUserID = newUserID;
    currentUser = newUser;
  }
  
  void updateChat(String newChatTable){
    currentChatTable = newChatTable;
    if(db.connect()){
      db.query( "SELECT * FROM CHATS WHERE ChatTableName = '"+newChatTable+"';");
      db.next();
      currentKey = db.getString("EncryptionKey");
      int UserID1 = db.getInt("UserID1");
      int UserID2 = db.getInt("UserID2");
      db.query( "SELECT UserName FROM USERS WHERE (UserID = " + str(UserID1) + " OR UserId = " + str(UserID2) + " ) AND UserID != "+currentUserID+";");
      db.next();
      currentUser2 = db.getString("UserName");
      updateChatGroup();
    }
  }
  
  void pickChat(){
    //We just pick the first chat where our user is a "member"
    db.query( "SELECT * FROM CHATS WHERE UserID1 = "+str(currentUserID)+" OR UserID2 = "+str(currentUserID)+";");
    db.next();
    String newChatTable = db.getString("ChatTableName");
    if (newChatTable != null){
      updateChat(newChatTable);
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
