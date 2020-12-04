<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% String new_id = (String)session.getAttribute("id"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="meta_css.html" %>
<title>Main</title>
</head>
<body>
<%@ include file="header.jsp" %>
<% if(session.getAttribute("id") == null) { %>
	<script>
		alert("비정상적인 접근입니다! ");
		location.href= "login.jsp";
	</script>
	<%
	};
	%> 	
<!-- Modal 부트스트랩 라이브러리 -->
	<div class="modal fade" id="siteModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">즐겨찾기 추가</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <form action = "site_add.jsp">
	      <div class="modal-body">
	      	<label>사이트 이름</label>
	        <input type="text" name="url_name" style="width: 100%;"><br>
	        <label>사이트 url</label>
	        <input type="text" name="url" style="width: 100%;" value="http://">
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	        <input type="submit" class="btn btn-primary" value="추가하기">
	      	</div>
	      </form>
	    </div>
	  </div>
	</div>
	

	<div class="today-phrase" style="text-align: center; margin-top: 100px;">
		<h4>오늘의 명언</h4><br>
			<%
			try {
				String recommend = null;
				String usr_MBTI = null;
				String driver = "org.mariadb.jdbc.Driver";
				Class.forName(driver); 
				ResultSet rs2 = null;
				
				String dbName = "project";
				String jdbcDriver = "jdbc:mariadb://localhost:3306/" + dbName;
				String dbUser = "user1";
				String dbPass = "1111";
				Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
				
				//------ phrase 테이블에 데이터 추가 (타임 스탬프, 띵언, 분야, 사용자 아이디, 한줄평) ------	
				Statement st = conn.createStatement();
		        String MBTI_query = "SELECT MBTI FROM user_info WHERE ID = '" + new_id +
		                "'"; 
		        ResultSet rs = st.executeQuery(MBTI_query);
		        if (rs.next()){
			        usr_MBTI = rs.getString("MBTI");
			        if (usr_MBTI.equals("INTJ") || usr_MBTI.equals("INTP") || usr_MBTI.equals("ENTJ") || usr_MBTI.equals("ENTP")){
			        	recommend = "SELECT phrase, sayer FROM phrase NATURAL JOIN source WHERE category = '시간' OR category = '노력' OR category = '공부' AND share = 'yes'order by rand() limit 1"; 
				        rs2 = st.executeQuery(recommend);
			        }
			        
			        else if (usr_MBTI.equals("INFJ") || usr_MBTI.equals("INFP") || usr_MBTI.equals("ENFJ") || usr_MBTI.equals("ENFP")){
			        	recommend = "SELECT phrase, sayer FROM phrase NATURAL JOIN source WHERE category = '사랑' OR category = '우정' OR category = '공부' AND share = 'yes'order by rand() limit 1"; 
			        	rs2 = st.executeQuery(recommend);
			        }
			        
			        else if (usr_MBTI.equals("ISTJ") || usr_MBTI.equals("ISFJ") || usr_MBTI.equals("ESTJ") || usr_MBTI.equals("ESFJ")){
			        	recommend = "SELECT phrase, sayer FROM phrase NATURAL JOIN source WHERE category = '자립' OR category = '인생' OR category = '공부' AND share = 'yes'order by rand() limit 1"; 
			        	rs2 = st.executeQuery(recommend);
			        }
			        
			        else {
			        	recommend = "SELECT phrase, sayer FROM phrase NATURAL JOIN source WHERE category = '겸손' OR category = '양심' OR category = '인륜' OR category = '공부' AND share = 'yes' order by rand() limit 1"; 
			        	rs2 = st.executeQuery(recommend);
			        }
		        }
		        while (rs2.next()){
		        %>
		        <h1><%= rs2.getString("phrase")%></h1>
		        <h5>- <%= rs2.getString("sayer")%> - </h5>
		        <% 
		        }
			} catch (Exception e) {
				e.printStackTrace();
				out.println("DB Connection Failed..");
			}	
			%>	
	</div>
	
	<div class="container" style="margin-top: 150px; width: 90%;">
		<div class="row ml-2 mr-2" style="margin-top: 150px;">
			<div class="col-5">
				<h2 align="center">즐겨찾기   <button type="button" class="btn btn-outline-dark" data-toggle="modal" data-target="#siteModal">추가</button></h2>
				<div class="favorites-box" style="border: 1px solid; overflow: auto;">
					
					<div class="row">
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
				        String show_site_query = "SELECT * FROM site WHERE user_ID = '" + new_id +
				                "'"; 
				        ResultSet rs = st.executeQuery(show_site_query);
				        
				        while (rs.next()){
				        	String site_url = rs.getString("url");
				 			String url_name = rs.getString("url_name");
				 			
				        	%> 
					  		<div class="col-4">
								<%= url_name %>
							</div>
							<div class="col-8">
								<a href="<%= site_url %>"><%=site_url %></a>
							</div>
					   		<%
						}
					} catch (Exception e) {
						e.printStackTrace();
						out.println("DB Connection Failed..");
					}	
					%>	
				</div>
			</div>
		</div>
		
		<div class="col-6">
			<!-- @@@@@@@@@@@ 명언 추가 창 @@@@@@@@@@@ -->
			<h2 align="center"> 명언 추가 </h2>
		    <form action="phrase_add.jsp" method="post" onsubmit="return input_check_func()">
			    <table border="1" style="margin: auto;">
			        <tr>
			            <th> 명언 </th> <td> <input id="add_phrase" name="add_phrase"> </td>
			        </tr>
			        <tr>
			            <th> 분야 </th> 
				            <td> 
					            <select id="add_category" name="add_category">
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
			        <tr>
			        	<th> 공유 </th> 
			        	<td> 
			        		<select name="add_share">
					        	<option value="yes">공유</option>
					        	<option value="no">미공유</option>
					        	
				        	</select> 
			        	</td>
			        </tr>
			        <tr>
		    			<td colspan="2"><input type="submit" value="추가하기" id="create-phrase-btn" class="btn btn-primary" align="center" style="width: 100%;"></td>
		    		</tr>
			    </table>
		    </form>
		</div>
	</div>
	
	
    <!-- @@@@@@@@@@@ 내가 추가한 명언 조회 @@@@@@@@@@@ -->
    <h3 style="margin-top: 75px;"> 내가 추가한 명언 </h3>
    <table width="100%" border="1">
       	<tr>
       		<td> 좋아요 </td>
       		<td> 명언 </td>
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
        String query = "select * from phrase NATURAL JOIN source where user_ID = '" + phrase_id + "' order by usr_like DESC";
        ResultSet rs = st.executeQuery(query);
		
        if (!rs.next()){
        	out.println("해당하는 정보가 없습니다.");
        }
        else {
        	rs.previous();
        }
        
        while (rs.next()){
        	int like_count = rs.getInt("usr_like");
        	%> 
    		<tr>
    			<td> <%=like_count - 5 %></td>
    			<td> <%=rs.getString("phrase")%></td>
    			<td> <%=rs.getString("category")%></td>
    			<td> <%=rs.getString("media")%></td>
    			<td> <%=rs.getString("media_name")%></td>
    			<td> <%=rs.getString("sayer")%></td>
    			<td> <%=rs.getString("comment")%></td>
    			<td>
    				<a href ="<%request.getContextPath(); %>
    				phrase_delete.jsp?send_phrase=<%=rs.getString("phrase")%>&send_ID=<%=rs.getString("user_ID")%>">삭제</a>
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
	<br><br><br><br>
	
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
			alert("명언이 추가되었습니다!");
			return true;
		}
	}
	</script>
	
</body>
</html>