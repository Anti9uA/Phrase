<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="meta_css.html" %>
<title>로그인창</title>
</head>
<body>
	<%@ include file="header.jsp" %>
	
	<div class="container">
      <table width="75%" align="center" bgcolor="#FFFF99" border>
        <tr>
          <td>
            <div align="center">
              아이디와 패스워드를 입력하세요
            </div>
          </td>
        </tr>
      </table>
      <table width="75%" align="center" bgcolor="#FFFF99" border>
        <form method="post" action="authentication.jsp">
          <tr>
            <td>
              <div align="center">
                아이디
              </div>
            </td>
            <td>
              <div style="text-align: center;"align="center">
                <input type="text" name="input_id">
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
                <input type="password" name="input_pw">
              </div>
            </td>
          </tr>
          <tr>
            <td colspan=2>
              <div align="center">
                <input type="submit" class="btn btn-primary" name="Submit" value="로그인">
                <input type="reset" class="btn btn-outline-primary" value="취소">
              </div>
            </td>
          </tr>
        </form>
      </table>
    </div>
</body>
</html>