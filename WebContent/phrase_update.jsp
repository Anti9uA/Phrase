<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% String update_phrase = (String)session.getAttribute("update_phrase"); %>
<html>
<head>
<meta charset="UTF-8">
<title>업데이트</title>
</head>
<body>
	<%
	try {
		String u_phrase = request.getParameter("u_phrase");
		String u_category = request.getParameter("u_category");
		String u_media = request.getParameter("u_media");
		String u_media_name = request.getParameter("u_media_name");
		String u_sayer = request.getParameter("u_sayer");
		String u_comment = request.getParameter("u_comment");
		String u_share = request.getParameter("u_share");
		
		
		String driver = "org.mariadb.jdbc.Driver";
		Class.forName(driver);
		
		String dbName = "project";
		String jdbcDriver = "jdbc:mariadb://localhost:3306/" + dbName;
		String dbUser = "user1";
		String dbPass = "1111";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		String update_phrase_query = "UPDATE phrase SET phrase=?, category=?, comment=?, share=? WHERE phrase=?";
		PreparedStatement pstmt = conn.prepareStatement(update_phrase_query);
		
		pstmt.setString(1, u_phrase);
		pstmt.setString(2, u_category);
		pstmt.setString(3, u_comment);
		pstmt.setString(4, u_share);
		pstmt.setString(5, update_phrase);
		pstmt.executeUpdate();
		
		String update_source_query = "UPDATE source SET phrase=?, media=?, sayer=?, media_name=? WHERE phrase=?";
		PreparedStatement pstmt2 = conn.prepareStatement(update_source_query);
		
		pstmt2.setString(1, u_phrase);
		pstmt2.setString(2, u_media);
		pstmt2.setString(3, u_sayer);
		pstmt2.setString(4, u_media_name);
		pstmt2.setString(5, update_phrase);
		pstmt2.executeUpdate();
		
		%>
        <script>
        	alert("명언이 수정 되었습니다!");
        </script>
        <%
        
		response.sendRedirect("main.jsp");
		
	} catch (Exception e) {
		e.printStackTrace();
		out.println("DB Connection Failed..");
	}
		
	%>
</body>
</html>