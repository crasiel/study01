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
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet"  href="${path }/resources/css/all.css">
<script type="text/javascript">
$(document).ready(function(){
	if(${!empty msgType}){
 		$("#messageType").attr("class", "modal-content panel-warning");    
		$("#myMessage").modal("show");
	}
});

/* var idCheck = false;			// form submit시 확인 
var passCheck= false;			// form submit시 확인  */
	// ID 중복확인
	function registerCheck(){
		var memId = $("#memId").val();
		$.ajax({
			url : "${path}/memRegisterCheck.do",
			type : "get",
			data : {"memId" : memId},
			success : function(result){
				// 중복유무 출력 : result=1 -> 사용할 수 있는 아이디, result=0 -> 사용할 수 없는 아이디
				if(result == 1){
					$("#checkMessage").html("사용할 수 있는 아이디입니다.");
					$("#checkType").attr("class", "modal-content panel-success");
					//idCheck = true;
				}else{
					$("#checkMessage").html("사용할 수 없는 아이디입니다.");					
					$("#checkType").attr("class", "modal-content panel-danger");
				//	idCheck = false;
				}
				$("#myModal").modal("show");
			},
			error : function(){alert("error");}
		});
	}
	
	// 비밀번호 확인
	function passwordCheck(){
		var pass1 = $("#memPassword1").val();
		var pass2 = $("#memPassword2").val();
		if(pass1 != pass2){
			$("#passMessage").html("비밀번호가 서로 일치하지 않습니다.");
		//	passCheck= false;
		}else{
			$("#passMessage").html("");
			$("#memPassword").val(pass1);
		//	passCheck= true;
		}
	}
	
	function goInsert(){
		var memAge = $("#memAge").val();
		if(memAge == null || memAge == "" || memAge == 0){
			alert("나이를 입력하세요");
			return false;
		}
		document.frm.submit();
	}
	
/* 
form에  onsubmit="return formSubmit()" 작성시
function formSubmit(){	// 가입시 form에 작성이 올바르지 않다면
		console.log("idCheck : ", idCheck, ", passCheck : ", passCheck);
		if(idCheck==false || passCheck==false){
			$("#checkMessage").html("가입 양식에 따라 작성을 해주세요.");					
			$("#checkType").attr("class", "modal-content panel-danger");
			$("#myModal").modal("show");
			return false; 
		};
	} */
	
</script>
</head>
<body>
<div class="container">
<jsp:include page="../common/header.jsp" /> 
  <h2>Spring MVC 03</h2>
  <div class="panel panel-info">
    <div class="panel-heading">회원가입</div>
    <div class="panel-body">
    	<form name="frm" action="${path }/memRegister.do" id="" method="post">
    		<input type="hidden" id="memPassword" name="memPassword" value="" />
    		<table class="table table-bordered" style="text-align : center; border: 1px solid #ddd">
    				<tr>
    					<td style="width : 110px; vertical-align : middle;">아이디</td>
    					<td><input type="text" name="memId" id="memId" class="form-control" maxlength="20" placeholder="아이디를 입력하세요."></td>
    					<td style="width : 110px;"><button type="button" class="btn btn-primary btn-sm" onclick="registerCheck()">중복확인 </button></td>
    				</tr>
    				<tr>
    					<td style="width : 110px; vertical-align : middle;">비밀번호</td>
    					<td colspan="2"><input type="password" name="memPassword1" id="memPassword1" class="form-control" onkeyup="passwordCheck()" maxlength="20" placeholder="비밀번호를 입력하세요."></td>
    				</tr>
    				<tr>
    					<td style="width : 110px; vertical-align : middle;">비밀번호확인</td>
    					<td colspan="2"><input type="password" name="memPassword2" id="memPassword2" class="form-control" onkeyup="passwordCheck()" maxlength="20" placeholder="비밀번호를 확인하세요."></td>
    				</tr>
    				<tr>
    					<td style="width : 110px; vertical-align : middle;">사용자 이름</td>
    					<td colspan="2"><input type="text" name="memName" id="memName" class="form-control" maxlength="20" placeholder="이름를 입력하세요."></td>
    				</tr>
    				<tr>
    					<td style="width : 110px; vertical-align : middle;">나이</td>
    					<td colspan="2"><input type="number" name="memAge" id="memAge" class="form-control" maxlength="20"></td>
    				</tr>
    				<tr>
    					<td style="width : 110px; vertical-align : middle;">성별</td>
    					<td colspan="2">
    						<div class="form-group" style="text-align:center; margin:0 auto;">
    							<div class="btn-group" data-toggle="buttons">
    								<label class="btn btn-primary active">
    								<input type="radio" name="memGender" id="memGender" autocomplete="off" value="남자" checked >남자
     								</label>
    								<label class="btn btn-primary">
    								<input type="radio" name="memGender" id="memGender" autocomplete="off" value="여자"  >여자
     								</label>
    							</div>
    						</div>
    					</td>
    				</tr>
    				<tr>
    					<td style="width : 110px; vertical-align : middle;">이메일</td>
    					<td colspan="2"><input type="text" name="memEmail" id="memEmail" class="form-control" maxlength="20" placeholder="이메일을 입력하세요."></td>
    				</tr>
    				<tr>
    					<td colspan="3" style="text-align:center;">
    						<span id="passMessage" style="color: red;"></span>
    						<input type="button" class="btn btn-primary btn-sm pull-right" value="등록" onclick="goInsert()">
    						<input type="reset" class="btn btn-warning btn-sm pull-right"  value="취소" style="margin-right : 10px;">
    					</td>
    				</tr>
    		</table>
    		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
    	</form>
    </div>
    <!-- 다이얼로그창(모달) -->
    <!-- Modal -->
	<div id="myModal" class="modal fade" role="dialog">
	  <div class="modal-dialog">	
	    <!-- Modal content-->
	    <div id="checkType" class="modal-content panel-info">
	      <div class="modal-header panel-heading">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">메시지 확인</h4>
	      </div>
	      <div class="modal-body">
	        <p id="checkMessage"></p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div>
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
	
    <div class="panel-footer">스프1탄_인프런(가즈아!!!!)</div>
  </div>
</div>

</body>
</html>