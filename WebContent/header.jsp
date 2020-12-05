<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
  String session_id = (String)session.getAttribute("id");
  String session_pw = (String)session.getAttribute("pw");
  String log;
  if (session_id == null)
    log="<a href=login.jsp class='nav-link'>로그인</a>";
  else
    log="<a href=logout.jsp class='nav-link'>로그아웃</a>";
 %>
   
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="main.jsp">오늘의 명언</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarNavAltMarkup" style="justify-content: space-between;">
    <div class="navbar-nav">
      <a class="nav-link" href="search.jsp">명언검색</a>
      <a class="nav-link" href="#"><%= log %></a>
    </div>
   	<div>
     <% if (session_id != null) { %>
	  	<span class="navbar-text"><%= session_id %>님 방문을 환영합니다.</span>
	  <% } else { %>
	    <span class="navbar-text">로그인 후 사용하세요! :)</span>
      <% } %>
      </div>
  </div>
</nav>