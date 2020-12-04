<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="meta_css.html" %>
<title>Search</title>
</head>
<body>
<%@ include file="header.jsp" %>
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
       		<td> 좋아요 </td>
       		<td> 인물 </td>
       		<td> 명언 </td>
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
                " = ? AND share = 'yes' order by usr_like DESC";
		PreparedStatement stmt = conn.prepareStatement(query);
		stmt.setString(1, input_search);
        ResultSet rs = stmt.executeQuery();
     	// ------------------------------------------------
		
		Boolean isSearch = false;
		while(rs.next()){
			isSearch = true;
			int like_count = rs.getInt("usr_like");
		%> 
		<tr>
			<td><%=like_count - 5%></td>
			<td><%=rs.getString("sayer")%></td>
			<td><%=rs.getString("phrase")%></td>
			
			
			<td style="width: 100px;">
				<button type="button" class="btn btn-info" style="width: 100%;"
						data-toggle="popover" 
						data-html="true" 
						title="<%= rs.getString("phrase") %>" 
						data-content="
							분야: <%= rs.getString("category") %><br />
							매체: <%= rs.getString("media") %><br />
							매체명: <%= rs.getString("media_name") %><br />
							한줄평: <%= rs.getString("comment") %><br />
						">더보기</button>
			</td>
			<td style="width: 100px;">
				<a  href="phrase_like.jsp?phrase=<%= rs.getString("phrase") %>&receiver=<%= rs.getString("user_id") %>"
					type="button" style="width: 100%;">
					<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-heart-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
					  <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
					</svg>
				</a>
			</td>
		</tr>
		<%
		}
    } catch (Exception e) {
    	e.printStackTrace();
        out.println("DB Connection Failed..");
    }	
	%>
	</table>
	<script>
	<% String isCheck = request.getParameter("isCheck"); %>
	if(<%= isCheck %> !== null) {
		if(<%= isCheck %>) {
			alert("좋아요를 누르셨습니다!");
			
		} else {
			alert("이미 좋아요를 누른 명언입니다!");
		}
	}
	</script>
	<script>
	$(function () {
		  $('[data-toggle="popover"]').popover()
		})
	</script>
</body>
</html>