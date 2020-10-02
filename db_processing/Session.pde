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
    try{
      //Get the userids of the chat and encryption key
      Statement st = DB.createStatement();
      ResultSet rs = st.executeQuery( "SELECT * FROM CHATS WHERE ChatTableName = '"+newChatTable+"';");
      rs.next();
      currentKey = rs.getString("EncryptionKey");
      int UserID1 = rs.getInt("UserID1");
      int UserID2 = rs.getInt("UserID2");
      rs.close();
      st.close();
      
      
      //Get the username of the other user in the chat.
      st = DB.createStatement();
      rs = st.executeQuery("SELECT UserName FROM USERS WHERE (UserID = " + str(UserID1) + " OR UserId = " + str(UserID2) + " ) AND UserID != "+str(currentUserID)+";");
      rs.next();
      currentUser2 = rs.getString("UserName");
      rs.close();
      st.close();
      
      updateChatGroup();
    }catch (java.sql.SQLException e) {
        println(e.getMessage());
    }
  }
  
  void pickChat(){
    //We just pick the first chat where our user is a "member"
    try{
      Statement st = DB.createStatement();
      ResultSet rs = st.executeQuery( "SELECT * FROM CHATS WHERE UserID1 = "+str(currentUserID)+" OR UserID2 = "+str(currentUserID)+";");
      Boolean isThereAChat = rs.next();
      if (isThereAChat){
        String newChatTable = rs.getString("ChatTableName");
        updateChat(newChatTable);
      }else{
        Textlabel w = cp5.get(Textlabel.class, "warning");
        w.setText("The user doesn't have any chats.");
        successGroup.hide();
        warningGroup.show();
      }
      rs.close();
      st.close();
    }catch (java.sql.SQLException e) {
      println(e.getMessage());
    }
  }
  
  void clear(){
    currentUserID = 0;
    currentUser = "";
    currentChatTable = "";
  }
}
