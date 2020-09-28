import de.bezier.data.sql.*;
import controlP5.*;

ControlP5 cp5;

Group loginGroup;
Group newUserGroup;
Group sessionGroup;
Group chatGroup;
Group newChatGroup;

TimedGroup successGroup;
TimedGroup warningGroup;
ArrayList<TimedGroup> timedGroups;

Session session = new Session();

SQLite db;

void setup(){
    size( 900, 700 );
    //CP5 things
    cp5 = new ControlP5(this);
    
    loginGroup = MakeLoginGroup();
    
    newUserGroup = MakeNewUserGroup();
    
    sessionGroup = MakeSessionGroup();
    
    chatGroup = MakeChatGroup();
    
    newChatGroup = MakeNewChatGroup();
    
    successGroup = MakeSuccessGroup();
    
    warningGroup = MakeWarningGroup();
    
    timedGroups = new ArrayList<TimedGroup>();
    timedGroups.add(successGroup);
    timedGroups.add(warningGroup);
    
    //newUserGroup.group.show();
    loginGroup.show();
    //sessionGroup.group.show();
    //chatGroup.group.show();
    //newChatGroup.group.show();
    
    db = new SQLite( this, "chat.db" );  // open database file
    db.connect();
}

void update(){
  for (TimedGroup ts : timedGroups){
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
  controlEventNewChatGroup(theEvent);
  //controlEventChatListGroup(theEvent);
  
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
