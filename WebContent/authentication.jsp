<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Authentication</title>
</head>
<body>
	<%
	try {
		String driver = "org.mariadb.jdbc.Driver";
		Class.forName(driver);
		
		String dbName = "project";
		String jdbcDriver = "jdbc:mariadb://localhost:3306/" + dbName;
		String dbUser = "user1";
		String dbPass = "1111";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		
		String user_id = request.getParameter("input_id");
		String user_pw = request.getParameter("input_pw");
		
		// ---- Secure coding to prevent sql injection ----
		String query = "SELECT * FROM user_info WHERE id = ? AND pw = ?";
		PreparedStatement pstmt = conn.prepareStatement(query);
		pstmt.setString(1, user_id);
		pstmt.setString(2, user_pw);
		ResultSet rs = pstmt.executeQuery();
		// ------------------------------------------------
		
		Boolean isLogin = false;
		while(rs.next()){
			isLogin = true;
		}
		
		// Login Success
		if (isLogin){	
			session.setAttribute("id", user_id);
			session.setAttribute("pw", user_pw);
			response.sendRedirect("main.jsp");
		}
		
		// if there's no user_info, print Login Failed...
		else {
            %> <script> alert("Login Failed.."); history.go(-1); </script> <%            
        }
		
    } catch (Exception e) {
    	e.printStackTrace();
        out.println("DB Connection Failed..");
    }
		
	%>
</body>
</html>