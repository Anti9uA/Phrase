<%@ page language="java" contentType="text/html; charset=UTF-8"
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
			return true;
		}
	}
	</script> 
</body>
</html>