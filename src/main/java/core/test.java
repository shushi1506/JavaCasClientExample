package core;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

/**
 * @author tuananh 3/16/2018
 * test
 * core
 */
public class test
{
    public String getHello(){
        try {
            Connection connection=getSQLServerConnection_SQLJDBC();
            Statement stmt=connection.createStatement();
            ResultSet rs=stmt.executeQuery("SELECT * from Customer where Id <6");
            List<String>t=new ArrayList<>();
            while (rs.next()){
                t.add(rs.getString("FirstName"));
            }
            stmt.close();
            connection.close();
            return t.toString();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Hello bay";
    }
    public static Connection getSQLServerConnection_SQLJDBC()
            throws ClassNotFoundException, SQLException {
        String hostName = "10.200.200.41";
        String sqlInstanceName = "SQLExpress";
        String database = "ExampleDB";
        String userName = "sa";
        String password = "123456aA@";

        return getSQLServerConnection_SQLJDBC(hostName, sqlInstanceName,
                database, userName, password);
    }
    private static Connection getSQLServerConnection_SQLJDBC(String hostName,
                                                             String sqlInstanceName, String database, String userName,
                                                             String password) throws ClassNotFoundException, SQLException {
        // Khai báo class Driver cho DB SQLServer
        // Việc này cần thiết với Java 5
        // Java6 tự động tìm kiếm Driver thích hợp.
        // Nếu bạn dùng Java > 5, thì ko cần dòng này cũng được.
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

        // Cấu trúc URL Connection dành cho SQLServer
        // Ví dụ:
        // jdbc:sqlserver://ServerIp:1433/SQLEXPRESS;databaseName=simplehr
        String connectionURL = "jdbc:sqlserver://10.200.200.41\\SQLExpress:1433;database=ExampleDB";

        Connection conn = DriverManager.getConnection(connectionURL, userName,
                password);
        return conn;
    }
}
