/*
    0. In a normal install of PostgreSQL, PostgreSQL becomes a 'service' that
       starts up when the machine boots. The installer also starts PostgreSQL
       after the installation is completed.

    1. Open the 'psql' interface to PostgreSQL (from GUI or command-line).
       The 'psql' utility is included in the normal installation.

    2. Enter this command at the 'psql' prompt:

           create role fred superuser login;        ## 'role' is effectively 'user'

    3. Enter this command at the prompt:

           alter role fred with password 'secret';  ## set the password for fred

    4. Enter this command at the prompt:

           create database skistuff;                ## create an empty database

    4. \q
*/

import java.sql.DriverManager;     // handles communication with the DB
import java.sql.Connection;        // a connection to the DB
import java.sql.Statement;         // an SQL statement for the DB to execute
import java.sql.ResultSet;         // a table of rows generated from an SQL query
import java.sql.SQLException;      // what's thrown when the JDBC operations fail
import java.util.Properties;       // key/value pairs

/* Compilation and execution from the command-line, with '%' as the command-line prompt:

   % javac BasicJDBC.java   ## core Java only is enough

   % java -cp .:postgresql-jdbc.jar BasicJDBC  ## the JAR contains the PostgreSQL 'driver'

   ## On Windows: % java -cp .;postgresql-jdbc.jar BasicJDBC
 */

public class BasicJDBC {
    /* Each string represents an inventory item, formatted as follows into three fields:
       
       product_name ! product_category ! price

       For example, in the first string the product name  is 'Scott Synergy',
       the product category is 'Telemark boot', and the price is '499.95'.
    */  
    private static String[ ] data = {
	"first_name!last_name!example@mail.com!password!01!01!2000!1",
	"first_name!last_name!example@mail.com!password!01!01!2000!1",
	"first_name!last_name!example@mail.com!password!01!01!2000!1",
	"first_name!last_name!example@mail.com!password!01!01!2000!1",
	"first_name!last_name!example@mail.com!password!01!01!2000!1",
	"first_name!last_name!example@mail.com!password!01!01!2000!1",
	"first_name!last_name!example@mail.com!password!01!01!2000!1",
	"first_name!last_name!example@mail.com!password!01!01!2000!1"

    };

    public static void main(String[ ] args)  {
	new BasicJDBC().setUp();
    }

    private Properties setLoginForDB() {
	Properties props = new Properties();
	props.setProperty("user", "fred");
	props.setProperty("password", "secret");
	return props;
    }

    private boolean tableExistsAlready(Connection conn, String name) {
	boolean flag = false;
	try {
	    Statement stmt = conn.createStatement();
	    String sql = "select count(*) as total from " + name + ";";
	    ResultSet rs = stmt.executeQuery(sql);
	    rs.next();
	    if (rs.getInt("total") > 0)
		flag = true;
	}
	catch(SQLException e) { e.printStackTrace(); }
	return flag;
    }

    /*
      Under JDBC, a URI (Uniform Resource Identifier) names a database. For a PostgreSQL DB, the URI
      has one of these forms:

      jdbc:postgresql:database
      jdbc:postgresql://host/database
      jdbc:postgresql://host:port/database
      
      where 'host', 'port', and 'database' name the machine that hosts the DB system, the port number
      at which the DB handles requests, and the database in question.
    */
    private void setUp() {
	String uri = "jdbc:postgresql://localhost/bird_users";  //*** skistuff is the database's name
	Properties props = setLoginForDB();

	try {
	    Class.forName("org.postgresql.Driver"); //*** load the PostreSQL driver
	    Connection conn = DriverManager.getConnection(uri, props);

	    // Check whether SkiStuff table exists already.
	    if (tableExistsAlready(conn, "users")) {
		// do nothing
	    }
	    else { 
		// otherwise, create the table and insert data
		Statement stmt = conn.createStatement();
		createDB(stmt);
	    
		conn.setAutoCommit(false); // We'll explicitly commit all of the rows after the insertions.
		insertRows(stmt);
		conn.commit();
		stmt.close();
	    }
	    conn.close(); // in either case, close the connection
	}
	catch(SQLException e) { e.printStackTrace(); }
	catch(ClassNotFoundException e) { e.printStackTrace(); } //*** Class.forName(...)

	testCreationInsertion(uri, props);
    }
    
    private void createDB(Statement stmt) {
	try {
	    String sql = "CREATE TABLE users " +
		"(id        SERIAL PRIMARY KEY NOT NULL," + 
		" first_name   VARCHAR(50)        NOT NULL," + 
        " last_name  VARCHAR(50)        NOT NULL," + 
        " email  VARCHAR(50)        NOT NULL," +
        " password  VARCHAR(50)        NOT NULL," +
		" birthDay     INT       ," +
		" birthMonth     INT      ," +
		" birthYear     INT       ," +
		" gender     INT      )";                         
	    stmt.executeUpdate(sql);
	}
	catch(SQLException e) { e.printStackTrace(); }
    }
    
    private void insertRows(Statement stmt) {
	try {
	    for (String str : data) {
		String[ ] columns = str.split("!"); // get the 3 pieces
		String sql = "INSERT INTO users (first_name, last_name, email, " +
			"password, birthDay, birthMonth, birthYear, gender) " +
		    "VALUES ('" + columns[0] + "', '" + columns[1] + "', '" + columns[2] + 
		    "', '" + columns[3] + "', " + columns[4] + ", " + columns[5] + ", " +
		    columns[6] + ", " + columns[7] + ");";
		stmt.executeUpdate(sql);
	    }
	}
	catch(SQLException e) { e.printStackTrace(); }
    }

    private void testCreationInsertion(String uri, Properties props) {
	try {
	    Connection conn = DriverManager.getConnection(uri, props);
	    Statement stmt = conn.createStatement();

	    ResultSet rs = stmt.executeQuery("SELECT * FROM users;");
	    while (rs.next()) {
		int id = rs.getInt("id");
		String first_name = rs.getString("first_name");
		String last_name = rs.getString("last_name");
		String email = rs.getString("email");
		String password = rs.getString("password");
		int birthDay = rs.getInt("birthDay");
		int birthMonth = rs.getInt("birthMonth");
		int birthYear = rs.getInt("birthYear");
		int gender = rs.getInt("gender");
		System.out.format("%d %s %s %s %s %d %d %d %d\n", id, first_name, last_name, email, password, birthDay, birthMonth, birthYear, gender);
	    }
	    rs.close();
	    stmt.close();
	    conn.close();
	}
	catch(SQLException e) { e.printStackTrace(); }
    }
}
