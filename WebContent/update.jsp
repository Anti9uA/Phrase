<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="meta_css.html" %>
<title>Insert title here</title>
</head>
<body>
	<%@ include file="header.jsp" %>
	<%
	String get_phrase = request.getParameter("send_phrase");
	String u_phrase = null;
	String u_category = null;
	String u_media = null;
	String u_media_name = null;
	String u_sayer = null;
	String u_comment = null;
	
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
        String query = "select * from phrase NATURAL JOIN source where phrase = '" + get_phrase + "'";
        ResultSet rs = st.executeQuery(query);
        
        if (rs.next()){
        	u_phrase = rs.getString("phrase");
        	u_category = rs.getString("category");
        	u_media = rs.getString("media");
        	u_media_name = rs.getString("media_name");
        	u_sayer = rs.getString("sayer");
        	u_comment = rs.getString("comment");
        	session.setAttribute("update_phrase", get_phrase);
        }	
	} catch (Exception e) {
		e.printStackTrace();
		out.println("DB Connection Failed..");
	}
	%>
	<h2 align="center"> 명언 수정 창 </h2>
	    <form action="phrase_update.jsp" method="post" onsubmit="return input_check_func()">
		    <table border="1" style="margin: auto;">
		        <tr>
		            <th> 띵언 </th> <td> <input type="text" name="u_phrase" value="<%=u_phrase %>" ></td>
		        </tr>
		        <tr>
		            <th> 분야 </th> 
			            <td> 
				            <select id="u_category" name="u_category">
				            	<option value="공부">공부</option>
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
			            <select id="u_media" name="u_media">
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
		        	<th> 매체명 </th> <td> <input type="text" name="u_media_name" value="<%=u_media_name%>"></td>
		        </tr>
		        <tr>
		        	<th> 화자 </th> <td> <input type="text" name="u_sayer" value="<%=u_sayer%>" ></td>
		        </tr>
		        <tr>
		        	<th> 한줄평 </th> <td> <input type="text" name="u_comment" value="<%=u_comment%>" ></td>
		        </tr>
		       <tr>
		        	<th> 공유 </th> 
			        	<td> 
			        		<select id="u_share" name="u_share">
					        	<option value="yes">공유</option>
					        	<option value="no">미공유</option>
				        	</select> 
			        	</td>
			        </tr>
		        <tr>
	    			<td colspan="2"><input type="submit" value="수정하기" onClick="createPhraseBtn()" class="btn btn-primary" align="center" style="width: 100%;"></td>
	    		</tr>
		    </table>
	    </form>
    
    <script>
	function input_check_func(){
		var phrase = document.getElementById('u_phrase').value;
		var mediaName = document.getElementById('u_media_name').value;
		var sayer = document.getElementById('u_sayer').value; 
		
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
	
	<script>
			function createPhraseBtn() {
			  alert("명언이 수정되었습니다.")
			}
	</script>
</body>
</html>