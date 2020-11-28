<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search</title>
</head>
<body>
	<h1> 검색 페이지 </h1>
	<!-- @@@@@@@@@@@ 뒤로가기 버튼 @@@@@@@@@@@ -->
	<button onClick="location.href='main.jsp'"> 메인으로.. </button> 
	<br/><br/>   
	
	<!-- @@@@@@@@@@@ 명언 검색 창 @@@@@@@@@@@ -->
	<form action="search.jsp" method="post">
    검색분류 <select id="search_cat" name="search_cat">
	        	<option value="phrase">명언</option>
	        	<option value="user_ID">사용자</option>
	        	<option value="category">분야</option>
	        	<option value="media">매체 종류</option>
	        	<option value="media_name">매체명</option>
	        	<option value="sayer">인물</option>
        	</select> 
           <br />
           <br /> 검색창 <input name="input_search" type="text"> 
           <button> 검색 </button>
           </form> <br/>
            
       <table width="80%" border="1">
       	<tr>
       		<td> 명언 </td>
       		<td> 사용자 </td>
       		<td> 분야 </td>
       		<td> 매체</td>
       		<td> 매체명 </td>
       		<td> 인물 </td>
       		<td> 한줄평 </td>
       	<tr>      
    
    <%
	try {
		String search_cat = request.getParameter("search_cat");
		String input_search = request.getParameter("input_search");
		
		String driver = "org.mariadb.jdbc.Driver";
		Class.forName(driver);
		
		String dbName = "project";
		String jdbcDriver = "jdbc:mariadb://localhost:3306/" + dbName;
		String dbUser = "user1";
		String dbPass = "1111";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		
		// ---- Secure coding to prevent sql injection ----
		String query = "Select * FROM phrase NATURAL JOIN source WHERE " 
				+ search_cat + 
                " = ? AND share = 'yes' order by " + search_cat;
		PreparedStatement stmt = conn.prepareStatement(query);
		stmt.setString(1, input_search);
        ResultSet rs = stmt.executeQuery();
     	// ------------------------------------------------
		
		Boolean isSearch = false;
		while(rs.next()){
			isSearch = true;
		%> 
		<tr>
			<td> <%=rs.getString("phrase")%></td>
			<td> <%=rs.getString("user_ID")%></td>
			<td> <%=rs.getString("category")%></td>
			<td> <%=rs.getString("media")%></td>
			<td> <%=rs.getString("media_name")%></td>
			<td> <%=rs.getString("sayer")%></td>
			<td> <%=rs.getString("comment")%></td>
		</tr>
		<%
		}
    } catch (Exception e) {
    	e.printStackTrace();
        out.println("DB Connection Failed..");
    }	
	%>
	</table>
	
</body>
</html>