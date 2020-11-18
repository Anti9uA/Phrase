<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
</head>
<body>
	<%
	try {
		String new_id = request.getParameter("signup_id");
		String new_pw = request.getParameter("signup_pw");
		String new_name = request.getParameter("signup_name");
		String new_MBTI = request.getParameter("MBTI");
		
		String driver = "org.mariadb.jdbc.Driver";
		Class.forName(driver);
		
		String dbName = "project";
		String jdbcDriver = "jdbc:mariadb://localhost:3306/" + dbName;
		String dbUser = "user1";
		String dbPass = "1111";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		
		Statement st = conn.createStatement();
        String query = "INSERT INTO user_info VALUES ('" + new_id + 
                "','" + new_pw + 
                "','" + new_name +
                "','" + new_MBTI +
                "')";
        st.executeUpdate(query);
		response.sendRedirect("login.jsp");
		
	} catch (SQLException e) {
		e.printStackTrace();
		%> <script> 
		alert("이미 사용중인 ID입니다..."); 
		history.go(-1); 
		</script> <% 
	}
		
	%>
</body>
</html>