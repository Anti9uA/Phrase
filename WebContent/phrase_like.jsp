<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
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
		boolean isCheck = false;
        String result = null;
		// ---- Secure coding to prevent sql injection ----
		String check_query = "SELECT if(phrase = ? AND sender = ?, 'no', 'yes') as result from ddabong WHERE phrase = ? AND receiver = ?";
		PreparedStatement pstmt = conn.prepareStatement(check_query);
		pstmt.setString(1, like_phrase);
		pstmt.setString(2, sender);
		pstmt.setString(3, like_phrase);
		pstmt.setString(4, receiver);
		ResultSet rs = pstmt.executeQuery();
		// ------------------------------------------------
		if (rs.next()) {
			result = rs.getString("result");
			if (result == "yes") {
				String add_ddabong_query = "INSERT INTO ddabong values(now(),'"+ like_phrase +
						"','" + sender + 
						"','" + receiver +
						"');";
				st.executeUpdate(add_ddabong_query);
				
				String add_score_query = "UPDATE phrase set usr_like = usr_like + 1 WHERE phrase = '"+ like_phrase +"'";
				st.executeUpdate(add_score_query);
				isCheck = true;
			}
			else if (result == "no"){
				isCheck = false;
			}
		}
		else {
			out.println(rs.next()+"null!!");
			String add_ddabong_query2 = "INSERT INTO ddabong values(now(),'"+ like_phrase +
					"','" + sender + 
					"','" + receiver +
					"');";
			st.executeUpdate(add_ddabong_query2);
			
			String add_score_query = "UPDATE phrase set usr_like = usr_like + 1 WHERE phrase = '"+ like_phrase +"'";
			st.executeUpdate(add_score_query);
			isCheck = true;  
		}
		out.println(sender+", "+result+", "+receiver+", "+like_phrase);
		response.sendRedirect("search.jsp?isCheck="+isCheck);
		
	} catch (Exception e) {
		e.printStackTrace();
		out.println("DB Connection Failed..");
	}
		
	%>
</body>
</html>