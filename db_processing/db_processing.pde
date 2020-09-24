import de.bezier.data.sql.*;
import controlP5.*;

ControlP5 cp5;

ScreenManager manager;
Screen loginScreen;
Screen newUserScreen;

Screen successScreen;
Screen warningScreen;

SQLite db;

void setup(){
    size( 900, 700 );
    //CP5 things
    cp5 = new ControlP5(this);
    manager = new ScreenManager();
    
    loginScreen = MakeLoginScreen();
    manager.addScreen(loginScreen);
    
    newUserScreen = MakeNewUserScreen();
    manager.addScreen(newUserScreen);
    
    successScreen = MakeSuccessScreen();
    manager.addScreen(successScreen);
    
    warningScreen = MakeWarningScreen();
    manager.addScreen(warningScreen);

    newUserScreen.group.show();
    //loginScreen.group.show();
    
    db = new SQLite( this, "chat.db" );  // open database file
    db.connect();
}

void update(){
  
}

void draw(){
  background(0);
  //rect(bx, by, bw, bh); 
}

void keyPressed(){
  if (key == 'm'){
    printInfoFromDatabase();
  }
}

void printInfoFromDatabase(){
  ArrayList<String> chatTableNames = new ArrayList<String>();
  // list users
  db.query( "SELECT * FROM USERS;");
  
  println("WE WRITE OUT ALL THE USERS: ");
  while (db.next()){
      println( " | ", db.getInt("UserID"), " | ", db.getString("UserName"), " | ", db.getString("Password"), " | ");
  }
  // list users
  db.query( "SELECT * FROM CHATS;");
  
  println("WE WRITE OUT ALL THE CHATS: ");
  while (db.next()){
      String tableName = db.getString("ChatTableName");
      chatTableNames.add(tableName);
      println( " | ", db.getInt("ChatID"), " | ", tableName, " | ", db.getString("UserID1"), " | ", db.getString("UserID2"), " | ");
  }
  //All messages in alle the chats
  for (String tableName : chatTableNames){
    println("WE PRINT ALL THE MESSAGES FROM ", tableName);
    
    db.query( "SELECT * FROM "+tableName);
    while (db.next()){
        println( " | ", db.getInt("MessageID"), " | ", db.getString("Message"), " | ", db.getString("UserID"), " | ");
    }
  }
}
