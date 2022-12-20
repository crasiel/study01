<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en">
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link rel="stylesheet"  href="${path }/resources/css/all.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

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
<jsp:include page="../common/header.jsp" /> 
  <h2>Spring MVC 03</h2>
  <div class="panel panel-info">
    <div class="panel-heading">회원사진등록</div>
    <div class="panel-body">
    	<form name="frm" action="${path }/memImageUpdate.do" id="" method="post" enctype="multipart/form-data">
    	<input type="hidden" name="memId" value="${mvo.memId }">
    		<table class="table table-bordered" style="text-align : center; border: 1px solid #ddd">
    				<tr>
    					<td style="width : 110px; vertical-align : middle;">아이디</td>
    					<td>${mvo.memId }</td>
    				</tr>
    				<tr>
    					<td style="width : 110px; vertical-align : middle;">사진업로드</td>
    					<td colspan="2">
    						<span class="btn btn-default">
    							이미지를 업로드하세요. <input type="file" name="memProfile">
    						</span>
    					</td>
    				</tr>
    				<tr>
    					<td colspan="2" style="text-align:center;">
    						<input type="submit" class="btn btn-primary btn-sm pull-right" value="등록">
    					</td>
    				</tr>
    		</table>
    	</form>
    </div>
    <div class="panel-footer">스프1탄_인프런(가즈아!!!!)</div>
  </div>
</div>

<!-- 실패 메시지 출력(Modal) -->
	<div id="myMessage" class="modal fade" role="dialog">
	  <div class="modal-dialog">	
	    <!-- Modal content-->
	    <div id="messageType" class="modal-content panel-info">
	      <div class="modal-header panel-heading">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">${msgType }</h4>
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