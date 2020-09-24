import de.bezier.data.sql.*;
import controlP5.*;

ControlP5 cp5;

int bx,by,bw,bh;


SQLite db;

void setup(){
    size( 500, 500 );
    
    //CP5 things
    cp5 = new ControlP5(this);
    //EN
    
    bx = 100;
    by = 100;
    bw = 100;
    bh = 50;
    db = new SQLite( this, "chat.db" );  // open database file
    db.connect();
    
}
void draw(){
  rect(bx, by, bw, bh); 
}

void mousePressed(){
  if(mouseX>bx && mouseX<bx+bw && mouseY>by && mouseY<by+bh){
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
}
