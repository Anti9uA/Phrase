<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% String new_id = (String)session.getAttribute("id"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main</title>
</head>
<body>
	<h2> 메인 페이지 </h2>
	<% out.print(new_id + "님 환영합니다!"); %>	 
    <form action="logout.jsp" method="post">
    <br />
    <br /> <button> 로그아웃 </button>
	</form>
	<br />
	
	<!-- @@@@@@@@@@@ 명언 검색 창 @@@@@@@@@@@ -->
	<button onClick="location.href='search.jsp'"> 명언 검색 </button>
	
	<!-- @@@@@@@@@@@ 명언 추가 창 @@@@@@@@@@@ -->
	<h2> 띵언 추가 </h2>
    <form action="phrase_add.jsp" method="post" onsubmit="return input_check_func()">
    <table border="1">
        <tr>
            <th> 띵언 </th> <td> <input id="add_phrase" name="add_phrase"> </td>
        </tr>
        <tr>
            <th> 분야 </th> 
	            <td> 
		            <select id="add_category" name="add_category">
			        	<option value="사랑">사랑</option>
			        	<option value="노력">노력</option>
			        	<option value="우정">우정</option>
			        	<option value="자립">자립</option>
			        	<option value="겸손">겸손</option>
			        	<option value="인생">인생</option>
			        	<option value="시간">시간</option>
			        	<option value="양심">양심</option>
			        	<option value="인륜">인륜</option>
		        	</select>
	            </td>
        </tr>
        <tr>
            <th> 매체 </th> 
	            <td> 
	            <select id="add_media" name="add_media">
			        	<option value="드라마">드라마</option>
			        	<option value="영화">영화</option>
			        	<option value="만화">만화</option>
			        	<option value="노래">노래</option>
			        	<option value="책">책</option>
			        	<option value="인물">인물</option>
			        	<option value="속담/사자성어">속담/사자성어</option>
		        	</select> 
	            </td>
        </tr>
        <tr>
        	<th> 매체명 </th> <td> <input id="add_mediaName" name="add_mediaName"> </td>
        </tr>
        <tr>
        	<th> 화자 </th> <td> <input id="add_sayer" name="add_sayer"> </td>
        </tr>
        <tr>
        	<th> 한줄평 </th> <td> <input id="add_comment" name="add_comment"> </td>
        </tr>
    </table>
    <button> 추가하기 </button>
    </form>
    
    <!-- @@@@@@@@@@@ 내가 추가한 명언 조 @@@@@@@@@@@ -->
    <h3> 내가 추가한 띵언 </h3>
    <table width="100%" border="1">
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
		String phrase_id = (String)session.getAttribute("id");
		String driver = "org.mariadb.jdbc.Driver";
		Class.forName(driver);
		
		String dbName = "project";
		String jdbcDriver = "jdbc:mariadb://localhost:3306/" + dbName;
		String dbUser = "user1";
		String dbPass = "1111";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		
		Statement st = conn.createStatement();
        String query = "select * from phrase NATURAL JOIN source where user_ID = '" + phrase_id + "'";
        ResultSet rs = st.executeQuery(query);
		
        if (!rs.next()){
        	out.println("해당하는 정보가 없습니다.");
        }
        else {
        	rs.previous();
        }
        
        while (rs.next()){
        	%> 
    		<tr>
    			<td> <%=rs.getString("phrase")%></td>
    			<td> <%=rs.getString("user_ID")%></td>
    			<td> <%=rs.getString("category")%></td>
    			<td> <%=rs.getString("media")%></td>
    			<td> <%=rs.getString("media_name")%></td>
    			<td> <%=rs.getString("sayer")%></td>
    			<td> <%=rs.getString("comment")%></td>
    			<td>
    				<a href ="<%request.getContextPath(); %>
    				phrase_delete.jsp?send_phrase=<%=rs.getString("phrase")%>">삭제</a>
    			</td>
    			<td>
    				<a href ="<%request.getContextPath(); %>
    				update.jsp?send_phrase=<%=rs.getString("phrase")%>">수정</a>
    			</td>
    		</tr>
    		<%
        }
		
	} catch (Exception e) {
		e.printStackTrace();
		%> <script> 
		alert("Somethin got wrong..."); 
		history.go(-1); 
		</script> <% 
	}
	%>
	</table>
	
	<!-- @@@@@@@@@@@ 명언 추가시 아무것도 입력 안한 경우 진행 안되고 alert 표시해주는 자바 스크립트 함수 @@@@@@@@@@@ -->
	<script>
	function input_check_func(){
		var phrase = document.getElementById('add_phrase').value;
		var mediaName = document.getElementById('add_mediaName').value;
		var sayer = document.getElementById('add_sayer').value; 
		
		if (phrase == null || phrase == ""){
			alert("명언을 입력해주세요!");
			return false;
		}
		else if (mediaName == null || mediaName == ""){
			alert("매체명을 입력해주세요!");
			return false;
		}
		else if (sayer == null || sayer == "") {
			alert("화자를 입력해주세요!");
			return false;
		}
		else {
			return true;
		}
	}
	</script>

</body>
</html>