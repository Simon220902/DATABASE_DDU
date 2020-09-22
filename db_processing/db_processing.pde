import de.bezier.data.sql.mapper.*;
import de.bezier.data.sql.*;

SQLite db;

void setup(){
    size( 500, 500 );

    db = new SQLite( this, "test.db" );  // open database file

    if ( db.connect() )
    {
        // list table names
        db.query( "SELECT name as \"Name\" FROM SQLITE_MASTER where type=\"table\"" );
        
        println("WE WRITE OUT ALL THE NAMES: ");
        while (db.next())
        {
            println( db.getString("Name") );
        }
        
        // read all in table "table_one"
        db.query( "SELECT * FROM table_one" );

        println("ALL THE TABLE CONTAINS: ");
        
        while (db.next())
        {
            println( db.getString("field_one"), " | ",  db.getInt("field_two"));
        }
    }
}
void draw(){
  rect(100, 100, 100, 100);
}
