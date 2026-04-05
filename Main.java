import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.*;


//A basic Java runner that reads your .sql file, executes it, and writes to a .txt
public class Main {
    public static void main(String[] args) throws Exception {
        // variables needed to connect to local baseball db
        String url = "jdbc:postgresql://localhost:5432/Baseball";
        String user = "postgres";
        // add password before run:
        String password = "Cody@DB1";
        // reading the queries that we wrote
        String query = Files.readString(Path.of("output_query.sql"));
        // connecting to db and pulling the query as well as establishing our conneciton to the 
        // output .txt file for us to write to
        try (Connection conn = DriverManager.getConnection(url,user,password);
                Statement stmt = conn.createStatement();
                PrintWriter writer = new PrintWriter("results.txt")) {
            
            // checking if results exist from query and initiating a while loop to print those
            // results out for each query result returned
            boolean hasResult = stmt.execute(query);
            int resultSet = 0;
            
            while(hasResult){
                resultSet++;
                writer.println("--- Part 3 Query " + resultSet + " ---");

                ResultSet rs = stmt.getResultSet();
                ResultSetMetaData meta = rs.getMetaData();
                int cols = meta.getColumnCount();

                // writing header
                for (int i = 1; i <= cols; i++){
                    writer.print(meta.getColumnName(i) + "\t");
                }
                writer.println();

                // writing rows
                while (rs.next()){
                    for (int i = 1; i <= cols; i++){
                        writer.print(rs.getString(i) + "\t");
                    }
                    writer.println();
                }
                writer.println();
                hasResult = stmt.getMoreResults();
            }
        }  // exception handled at main lvl

    }
}