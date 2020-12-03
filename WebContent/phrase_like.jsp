<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% String sender = (String)session.getAttribute("id"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Like</title>
</head>
<body>
	<%
	try {
		String like_phrase = request.getParameter("phrase");
		String receiver = request.getParameter("receiver");
		
		
		String driver = "org.mariadb.jdbc.Driver";
		Class.forName(driver);
		
		String dbName = "project";
		String jdbcDriver = "jdbc:mariadb://localhost:3306/" + dbName;
		String dbUser = "user1";
		String dbPass = "1111";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		Statement st = conn.createStatement();
		
		// ---- Secure coding to prevent sql injection ----
		String check_query = "SELECT CASE WHEN phrase = ? AND sender = ? THEN 'no' ELSE 'yes' END AS result FROM ddabong";
		PreparedStatement pstmt = conn.prepareStatement(check_query);
		pstmt.setString(1, like_phrase);
		pstmt.setString(2, sender);
		ResultSet rs = pstmt.executeQuery();
		// ------------------------------------------------
		/* //------ phrase 테이블에 데이터 삭제 (타임 스탬프, 띵언, 분야, 사용자 아이디, 한줄평) ------	
        String like_query = "SELECT CASE WHEN phrase = " + like_phrase + 
        "AND sender = " + sender + " THEN 'no' ELSE 'yes' END AS result FROM ddabong"; */
		if (rs.next()) {
			String result = rs.getString("result");
			if (result.equals("no")) {
				%>
		        <script>
		        	alert("이미 따봉을 누른 명언입니다!");
		        	history.go(-1);
		        </script>
		        <%
			}
			else {	
				%>
		        <script>
		        	alert("따봉을 누르셨습니다!!");
		        </script>
		        <%
				String add_ddabong_query = "INSERT INTO ddabong values(now(),'"+ like_phrase +
						"','" + sender + 
						"','" + receiver +
						"');";
				st.executeUpdate(add_ddabong_query);
			}
		}
		response.sendRedirect("search.jsp");
		
	} catch (Exception e) {
		e.printStackTrace();
		out.println("DB Connection Failed..");
	}
		
	%>
</body>
</html>