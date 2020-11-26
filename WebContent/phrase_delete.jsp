<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>phrase_delete</title>
</head>
<body>
	<%
	try {
		String delete_phrase = request.getParameter("send_phrase");
		
		
		String driver = "org.mariadb.jdbc.Driver";
		Class.forName(driver);
		
		String dbName = "project";
		String jdbcDriver = "jdbc:mariadb://localhost:3306/" + dbName;
		String dbUser = "user1";
		String dbPass = "1111";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		Statement st = conn.createStatement();
		
		//------ phrase 테이블에 데이터 삭제 (타임 스탬프, 띵언, 분야, 사용자 아이디, 한줄평) ------	
        String delete_query = "DELETE FROM phrase WHERE phrase = '" + delete_phrase + "'";
        st.executeUpdate(delete_query);
        
      //------ phrase 테이블에 데이터 삭제 (타임 스탬프, 띵언, 분야, 사용자 아이디, 한줄평) ------	
        String delete_query2 = "DELETE FROM source WHERE phrase = '" + delete_phrase + "'";
        st.executeUpdate(delete_query);
        
		response.sendRedirect("main.jsp");
		
	} catch (Exception e) {
		e.printStackTrace();
		out.println("DB Connection Failed..");
	}
		
	%>
</body>
</html>