<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
	<% 
	if(session.getAttribute("id") == null) {
	%>
	<!-- post send, to authentication.jsp -->
	<h1> 로그인 페이지 </h1> 
			<form action="authentication.jsp" method="post">
            <br /> ID: <input name="input_id" type="text">
            <br />
            <br /> PW: <input name="input_pw" type="password"> 
            <button> 로그인 </button>
            <br /> </form>
            <br /> <button onClick="location.href='signup.jsp'"> 회원가입 </button>
    <%
    }
    %>
</body>
</html>