package fa26.t2s2.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

public class DBUtils {
    private static String name ="huy";
    
    private static final String DB_NAME = "UserManagement";
    private static final String USER_NAME = "SA";
    private static final String PASSWORD = "12345";

    public static Connection getConnectionV1() throws ClassNotFoundException, SQLException {
        Connection conn = null;

        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

        String url = "jdbc:sqlserver://localhost:1433;databaseName=" + DB_NAME;
        conn = DriverManager.getConnection(url, USER_NAME, PASSWORD);
        return conn;
    }

    public static Connection getConnection() throws ClassCastException, SQLException, NamingException {
        Connection conn = null;
        Context context = new InitialContext();
        Context end = (Context) context.lookup("java:com/env");
        DataSource ds = (DataSource) end.lookup("DBCon");
        conn = ds.getConnection();
        return conn;
    }

}
