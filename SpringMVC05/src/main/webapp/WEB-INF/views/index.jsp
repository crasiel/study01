<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet"  href="${path }/resources/css/all.css">
<script type="text/javascript">
$(document).ready(function(){
	if(${!empty msgType}){
 		$("#messageType").attr("class", "modal-content panel-warning");    
		$("#myMessage").modal("show");
	}
});
</script>
</head>
<body>
<div class="container">
<jsp:include page="common/header.jsp" />
 <div class="panel panel-default">
    <div style="width : 100%; height : 450px; text-align : center; display : felx; justify-content: center;">
		<img src="${path }/resources/images/main.jpg" style="width:100%; height : 100%; object-fit : cover;"/>
	</div>
    <div class="panel-body">
		<ul class="nav nav-tabs">
		  <li class="active"><a data-toggle="tab" href="#home">Home</a></li>
		  <li><a data-toggle="tab" href="#menu1">게시판</a></li>
		  <li><a data-toggle="tab" href="#menu2">공지사항</a></li>
		</ul>
		
		<div class="tab-content">
		  <div id="home" class="tab-pane fade in active">
		    <h3>HOME</h3>
		    <p>Some content.</p>
		  </div>
		  <div id="menu1" class="tab-pane fade">
		    <h3>게시판</h3>
		    <p>
		    	게시판 리스트
		    </p>
		  </div>
		  <div id="menu2" class="tab-pane fade">
		    <h3>공지사항</h3>
		    <p>Some content in menu 2.</p>
		  </div>
		</div>
	</div>
    <div class="panel-footer">스프1탄_인프런(가즈아!!!!)</div>
  </div>
</div>

<!-- 가입성공 메시지 출력(Modal) -->
	<div id="myMessage" class="modal fade" role="dialog">
	  <div class="modal-dialog">	
	    <!-- Modal content-->
	    <div id="messageType" class="modal-content panel-info">
	      <div class="modal-header panel-heading">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">${magType }</h4>
	      </div>
	      <div class="modal-body">
	        <p id="checkMessage">${msg }</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
</body>
</html>
