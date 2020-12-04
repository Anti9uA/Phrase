<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% String add_ID = (String)session.getAttribute("id"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	try {
		String add_phrase = request.getParameter("add_phrase");
		String add_category = request.getParameter("add_category");
		String add_media = request.getParameter("add_media");
		String add_mediaName = request.getParameter("add_mediaName");
		String add_sayer = request.getParameter("add_sayer");
		String add_comment = request.getParameter("add_comment");
		String add_share = request.getParameter("add_share");
		
		String driver = "org.mariadb.jdbc.Driver";
		Class.forName(driver);
		
		String dbName = "project";
		String jdbcDriver = "jdbc:mariadb://localhost:3306/" + dbName;
		String dbUser = "user1";
		String dbPass = "1111";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		
		//------ phrase 테이블에 데이터 추가 (타임 스탬프, 띵언, 분야, 사용자 아이디, 한줄평) ------	
		Statement st = conn.createStatement();
        String phrase_query = "INSERT INTO phrase VALUES ('" + add_phrase + 
                "','" + add_category + 
                "','" + add_ID +
                "','" + add_comment +
                "', 000,'" + add_share+ 
                "')"; 
        st.executeUpdate(phrase_query);
        
        //------ source 테이블에 데이터 추가 (타임 스탬프, 매체 종류, 매체명, 화자) ------	
        String source_query = "INSERT INTO source VALUES (now(), '" + add_phrase +
        		"','" + add_ID +
        		"','" + add_media +
                "','" + add_sayer +
                "','" + add_mediaName +
                "')";
        
        st.executeUpdate(source_query);
        
        //------ 한줄평을 작성 안한 경우 null 값이 들어가는걸 '없음'으로 수정해줌 ------	
        String update_null_query = "UPDATE phrase SET comment = '없음' WHERE comment = ' '";
        st.executeUpdate(update_null_query);
        
        String add_score_query = "UPDATE phrase set usr_like = usr_like + 5 WHERE phrase = '"+ add_phrase +"'";
		st.executeUpdate(add_score_query);
		
		response.sendRedirect("main.jsp");
		
	} catch (Exception e) {
		e.printStackTrace();
		out.println("DB Connection Failed..");
	}
		
	%>

</body>
</html>