import de.bezier.data.sql.*;
import controlP5.*;

ControlP5 cp5;

Screen loginScreen;
Screen newUserScreen;
Screen sessionScreen;
Screen chatScreen;
Screen newChatScreen;

TimedScreen successScreen;
TimedScreen warningScreen;
ArrayList<TimedScreen> timedScreens;

Session session = new Session();

SQLite db;

void setup(){
    size( 900, 700 );
    //CP5 things
    cp5 = new ControlP5(this);
    
    loginScreen = MakeLoginScreen();
    
    newUserScreen = MakeNewUserScreen();
    
    sessionScreen = MakeSessionScreen();
    
    chatScreen = MakeChatScreen();
    
    newChatScreen = MakeNewChatScreen();
    
    successScreen = MakeSuccessScreen();
    
    warningScreen = MakeWarningScreen();
    
    timedScreens = new ArrayList<TimedScreen>();
    timedScreens.add(successScreen);
    timedScreens.add(warningScreen);
    
    //newUserScreen.group.show();
    loginScreen.group.show();
    //sessionScreen.group.show();
    //chatScreen.group.show();
    //newChatScreen.group.show();
    
    db = new SQLite( this, "chat.db" );  // open database file
    db.connect();
}

void update(){
  for (TimedScreen ts : timedScreens){
    ts.update();
  }
}

void draw(){
  update();
  background(0);
  //rect(bx, by, bw, bh); 
}

// When a user from the list is picked we create a chat with that user
void controlEvent(ControlEvent theEvent) {
  controlEventNewChatScreen(theEvent);
  //controlEventChatListScreen(theEvent);
  
}


void keyPressed(){
  //SPACE PRINTS ALL THE INFO IN THE DATABASE
  if (keyCode == 32){
    //printInfoFromDatabase();
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
