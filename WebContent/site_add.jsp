<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% String get_ID = (String)session.getAttribute("id"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	try {
		String add_url = request.getParameter("url");
		String add_url_name = request.getParameter("url_name");
		
		String driver = "org.mariadb.jdbc.Driver";
		Class.forName(driver);
		
		String dbName = "project";
		String jdbcDriver = "jdbc:mariadb://localhost:3306/" + dbName;
		String dbUser = "user1";
		String dbPass = "1111";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		
		//------ phrase 테이블에 데이터 추가 (타임 스탬프, 띵언, 분야, 사용자 아이디, 한줄평) ------	
		Statement st = conn.createStatement();
        String site_query = "INSERT INTO site VALUES (now(),'" + get_ID + 
                "','" + add_url + 
                "','" + add_url_name +
                "')"; 
        st.executeUpdate(site_query);
        
		response.sendRedirect("main.jsp");
		
	} catch (Exception e) {
		e.printStackTrace();
		out.println("DB Connection Failed..");
	}
		
	%>
</body>
</html>