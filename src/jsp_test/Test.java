package jsp_test;
import java.sql.*;
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.sql.Statement;

public class Test {

	public static void main(String[] args) {
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
		
		try {
			String jdbcDriver = "jdbc:mariadb://localhost:3306/class";
			String dbUser = "user1";
			String dbPass = "1111";
			String query = "SELECT * FROM instructor;";
			String update_query = "UPDATE instructor set salary = salary * 1.01 WHERE salary < 70000;";
			
			// DB Connection 생성
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			// Statement 생성	
			stmt = conn.createStatement();
			// Query 실행	
			stmt.executeUpdate(update_query);
			result = stmt.executeQuery(query);
			
			while (result.next()) {
				int id = result.getInt("ID");
				String name = result.getNString("name");
				String dept_name = result.getNString("dept_name");
				int salary = result.getInt(4);
				System.out.println(id + "/" + name + "/" + dept_name + "/" + salary);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
