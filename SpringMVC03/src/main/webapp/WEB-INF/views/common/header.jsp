<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>

<nav class="navbar navbar-default" >
<div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="${path }/">스프링 1탄 AJAX</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="${path }/">Home</a></li>
        <li><a href="boardMain.do">게시판</a></li>
      </ul>
      <c:if test="${empty mvo }">
	      <ul class="nav navbar-nav navbar-right">
            <li><a href="${path }/memLoginForm.do"><span class="glyphicon glyphicon-log-in"></span> 로그인</a></li>
            <li><a href="memJoin.do"><span class="glyphicon glyphicon-user"></span> 회원가입</a></li>
	      </ul>
	      </c:if>
	      <c:if test="${not empty mvo }">
	      <ul class="nav navbar-nav navbar-right">
            <li><a href="${path }/memUpdateForm.do"><span class="glyphicon glyphicon-wrench"></span> 회원정보수정</a></li>
            <li><a href="${path }/memImageForm.do"><span class="glyphicon glyphicon-picture"></span> 사진등록</a></li>
            <li><a href="${path }/memLogout.do"><span class="glyphicon glyphicon-log-out"></span> 로그아웃</a></li>
            <c:if test="${!empty mvo }">
			  	<c:if test="${mvo.memProfile eq '' }">
			  		<li><img src="${path }/resources/images/person.png" class="img-circle" style="width : 50px; height : 50px;"> ${mvo.memId }님 Welcome.</li>
			  	</c:if>
			  	<c:if test="${mvo.memProfile ne '' }">
			  		<li><img src="${path }/resources/upload/${mvo.memProfile}" class="img-circle" style="width : 50px; height : 50px"> ${mvo.memId }님 Welcome.</li>
			  	</c:if>
			</c:if>
	      </ul>
      </c:if>
    </div>
</div>
</nav>