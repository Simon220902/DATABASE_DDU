import de.bezier.data.sql.*;
import controlP5.*;
import javax.crypto.*; 
import java.security.*;
import java.util.Arrays;
import java.util.Base64;
import java.security.*;
import java.sql.*;

ControlP5 cp5;

Group loginGroup;
Group newUserGroup;
Group sessionGroup;
Group chatGroup;
Group newChatGroup;
Group chatListGroup;

TimedGroup successGroup;
TimedGroup warningGroup;
ArrayList<TimedGroup> timedGroups;

Session session = new Session();

//OnlineDB relaterede ting
String url = "jdbc:postgresql://balarama.db.elephantsql.com:5432/kgbjldox";
String username = "kgbjldox";
String password = "HvrRx5ILj45gj2ujycZlPcJRLykaX2Ru";

Connection DB;

SQLite db;

void setup(){
    try {
      Class.forName("org.postgresql.Driver");
    }
    catch (java.lang.ClassNotFoundException e) {
        System.out.println(e.getMessage());
    }
    try {
      DB = DriverManager.getConnection(url, username, password);
    }
    catch (SQLException e) {
        System.out.println(e.getMessage());
    }
  
    size( 900, 700 );
    //CP5 things
    cp5 = new ControlP5(this);
    
    loginGroup = MakeLoginGroup();
    
    newUserGroup = MakeNewUserGroup();
    
    sessionGroup = MakeSessionGroup();

    chatGroup = MakeChatGroup();

    chatListGroup = MakeChatListGroup();
    
    newChatGroup = MakeNewChatGroup();
    
    successGroup = MakeSuccessGroup();
    
    warningGroup = MakeWarningGroup();
    
    timedGroups = new ArrayList<TimedGroup>();
    timedGroups.add(successGroup);
    timedGroups.add(warningGroup);
    
    //newUserGroup.group.show();
    loginGroup.show();
    //chatListGroup.show();
    //updateChatListGroup();
    //sessionGroup.show();
    //chatGroup.show();
    //newChatGroup.show();
    
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
  if(chatListGroup.isVisible()){
    fill(150);
    rect(chatListGroup.getPosition()[0], chatListGroup.getPosition()[1], chatListGroup.getWidth(), chatListGroup.getBackgroundHeight());
  }
}

// When a user from the list is picked we create a chat with that user
void controlEvent(ControlEvent theEvent) {
  controlEventNewChatGroup(theEvent);
  controlEventChatListGroup(theEvent);
  
}


void keyPressed(){
  //SPACE PRINTS ALL THE INFO IN THE DATABASE
  if (keyCode == 32){
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
