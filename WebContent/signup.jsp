<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up</title>
</head>
<body>
	<h1> 회원가입 </h1>
	<button onClick="location.href='login.jsp'"> 가입창으로.. </button> 
	<br/><br/>
	<h1> 회원정보 입력</h1>
	<form action="register.jsp" method="post" onsubmit="return signup_check()">
		<br /> ID: <input id="signup_id" name="signup_id" type="text">
        <br />
        <br /> PW: <input id="signup_pw" name="signup_pw" type="password">
        <br />
        <br /> 이름: <input id="signup_name" name="signup_name" type="text">
        <br />
        <br /> MBTI
        <select id="MBTI" name="MBTI">
        	<option value="INTJ">INTJ (용의주도한 전략가)</option>
        	<option value="INTP">INTP (논리적인 사색가)</option>
        	<option value="ENTJ">ENTJ (대담한 통솔자)</option>
        	<option value="ENTP">ENTP (뜨거운 논쟁을 즐기는 변론가)</option>
        	<option value="INFJ">INFJ (선의의 옹호자)</option>
        	<option value="INFP">INFP (열정적인 중재자)</option>
        	<option value="ENFJ">ENFJ (정의로운 사회운동가)</option>
        	<option value="ENFP">ENFP (재기발랄한 활동가)</option>
        	<option value="ISTJ">ISTJ (청렴결백한 논리주의자)</option>
        	<option value="ISFJ">ISFJ (용감한 수호자)</option>
        	<option value="ESTJ">ESTJ (엄격한 관리자)</option>
        	<option value="ESFJ">ESFJ (사교적인 외교관)</option>
        	<option value="ISFJ">ISFJ (만능 재주꾼)</option>
        	<option value="ISFP">ISFP (호기심 많은 예술가)</option>
        	<option value="ESTP">ESTP (모험을 즐기는 사업가)</option>
        	<option value="ESFP">ESFP (자유로운 영혼의 연예인)</option>
        </select>
        <br /> <br />
        <button> 가입하기 </button>
	</form>
	
	<script>
	function signup_check(){
		var id = document.getElementById('signup_id').value;
		var pw = document.getElementById('signup_pw').value;
		var name = document.getElementById('signup_name').value; 
		var MBTI = document.getElementById('MBTI').value;
		
		if (id == null || id == ""){
			alert("아이디를 입력해주세요!");
			return false;
		}
		else if (pw == null || pw == ""){
			alert("비밀번호를 입력해주세요!");
			return false;
		}
		else if (name == null || name == "") {
			alert("이름을 입력해주세요!");
			return false;
		}
		else {
			alert("회원가입 완료! 환영합니다!");
			return true;
		}
	}
	</script> 
</body>
</html> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="meta_css.html" %>
<title>Sign Up</title>
</head>
<body>
<%@ include file="header.jsp" %>
	<div class="container">
      <table width="75%" align="center" bgcolor="#FFFF99" border>
        <tr>
          <td>
            <div align="center">
              회원가입
            </div>
          </td>
        </tr>
      </table>
      <table width="75%" align="center" bgcolor="#FFFF99" border>
        <form action="register.jsp" method="post" onsubmit="return signup_check()">
          <tr>
            <td>
              <div align="center">
                아이디
              </div>
            </td>
            <td>
              <div style="text-align: center;"align="center">
                <input id="signup_id" name="signup_id" type="text">
              </div>
            </td>
          </tr>
          <tr>
            <td>
              <div align="center">
                패스워드
              </div>
            </td>
            <td>
              <div align="center">
                <input id="signup_pw" name="signup_pw" type="password">
              </div>
            </td>
          </tr>
          <tr>
            <td>
              <div align="center">
                이름
              </div>
            </td>
            <td>
              <div align="center">
                <input id="signup_name" name="signup_name" type="text">
              </div>
            </td>
          </tr>
          <tr>
            <td>
              <div align="center">
                MBTI
              </div>
            </td>
            <td>
              <div align="center">
                <select id="MBTI" name="MBTI">
		        	<option value="INTJ">INTJ (용의주도한 전략가)</option>
		        	<option value="INTP">INTP (논리적인 사색가)</option>
		        	<option value="ENTJ">ENTJ (대담한 통솔자)</option>
		        	<option value="ENTP">ENTP (뜨거운 논쟁을 즐기는 변론가)</option>
		        	<option value="INFJ">INFJ (선의의 옹호자)</option>
		        	<option value="INFP">INFP (열정적인 중재자)</option>
		        	<option value="ENFJ">ENFJ (정의로운 사회운동가)</option>
		        	<option value="ENFP">ENFP (재기발랄한 활동가)</option>
		        	<option value="ISTJ">ISTJ (청렴결백한 논리주의자)</option>
		        	<option value="ISFJ">ISFJ (용감한 수호자)</option>
		        	<option value="ESTJ">ESTJ (엄격한 관리자)</option>
		        	<option value="ESFJ">ESFJ (사교적인 외교관)</option>
		        	<option value="ISFJ">ISFJ (만능 재주꾼)</option>
		        	<option value="ISFP">ISFP (호기심 많은 예술가)</option>
		        	<option value="ESTP">ESTP (모험을 즐기는 사업가)</option>
		        	<option value="ESFP">ESFP (자유로운 영혼의 연예인)</option>
		        </select>
              </div>
            </td>
          </tr>
          <tr>
            <td colspan=2>
              <div align="center">
                <input type="submit" class="btn btn-primary" value="가입하기">
                <a href="login.jsp" class="btn btn-outline-primary">로그인페이지</a>
              </div>
            </td>
          </tr>
        </form>
      </table>
    </div>
	
	
	<script>
	function signup_check(){
		var id = document.getElementById('signup_id').value;
		var pw = document.getElementById('signup_pw').value;
		var name = document.getElementById('signup_name').value; 
		var MBTI = document.getElementById('MBTI').value;
		
		if (id == null || id == ""){
			alert("아이디를 입력해주세요!");
			return false;
		}
		else if (pw == null || pw == ""){
			alert("비밀번호를 입력해주세요!");
			return false;
		}
		else if (name == null || name == "") {
			alert("이름을 입력해주세요!");
			return false;
		}
		else {
			return true;
		}
	}
	</script> 
</body>
</html>