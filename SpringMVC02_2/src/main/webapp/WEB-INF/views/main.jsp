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
<title>Insert title here</title>
<script type="text/javascript">
	$(document).ready(function(){
		loadList();
	});
	
	function loadList(){	//서버와 통신 : 게시판 리스트 가져오기
		$.ajax({
			url : "board/all",
			type : "GET",
			dataType : "json",
			success : makeView,
			error : function(){alert("error");}
		});
	}
	
	function makeView(data){		// data = [{ },{ },{ },....]
		var listHtml = "<table class='table table-hover'>";
		listHtml += "<thead><tr>";
		listHtml += "<th>번호</th>";
		listHtml += "<th>제목</th>";
		listHtml += "<th>작성자</th>";
		listHtml += "<th>작성일</th>";
		listHtml += "<th>조회수</th>";
		listHtml += "</tr></thead>";
		
		$.each(data,function(index, obj){
			listHtml += "<tr>";
			listHtml += "<td>" + obj.idx +"</td>";
			listHtml += "<td id='t" + obj.idx + "' class='tdTag'><a href='javascript:goContent(" + obj.idx + ")' id='a"+obj.idx+"' class='aTag' style='display:inline-block'>" + obj.title +"</a></td>";
			listHtml += "<td>" + obj.writer +"</td>";
			listHtml += "<td>" + obj.indate.split(' ')[0] +"</td>";
			listHtml += "<td id='cnt" + obj.idx + "'>" + obj.count +"</td>";
			listHtml += "</tr>";
			
			listHtml += "<tr id='c" + obj.idx + "' class='trView' style='display:none;'>";
			listHtml += "<td>내용</td>"
			listHtml += "<td colspan='4'>";
			listHtml += "<textarea readonly rows='7' class='form-control noUp' id='ta" + obj.idx +"'></textarea>"
			listHtml += "<br>";
			listHtml += "<span id='ub" + obj.idx + "'></span>&nbsp;&nbsp;";
			listHtml += "<button class='btn btn-warning btn-sm' onclick='goDelete(" + obj.idx + ")'>삭제</button>";
			listHtml += "</td>";
			listHtml += "</tr>";
		});
		listHtml += "<tr style='border-bottom : none;'>";
		listHtml += "<td colspan='5'>"
		listHtml += "<button class='btn btn-info btn-sm' onclick='goForm()'>글쓰기</button>";
		listHtml += "</td>"
		listHtml += "</tr>";
		listHtml += "</table>";
		$("#view").html(listHtml);
		
		goList();	// 글쓰기 폼 초기화, 글쓰기 화면 숨기기, 리스트화면 보이기
	}
	
	// 글쓰기 화면
	function goForm(){
		$("#view").css("display","none");
		$("#wform").css("display", "block");
	}
	// 긂목록 화면
	function goList(){
		$("#fClear").trigger("click");		// 글쓰기 form 초기화
		$("#wform").css("display", "none");
		$("#view").css("display", "block");
	}
	
	// 글등록
	function goInsert(){
		var formData = $("#frm").serialize();		// 폼 안의 데이터를 한꺼번에 가져오기
		$.ajax({
			url : "board/new",
			type : "post",
			data : formData,
			success : loadList,
			error : function(){alert("error");}
		});
		
	}
	
	// content 화면 보이기
	function goContent(idx){
		if($("#c"+idx).css("display") == "none"){
			$.ajax({
				url : "board/" + idx,
				type : "get",
				dataType : "json",
				success : function(data){
					$("#ta"+idx).val(data.contents);
				},
				error : function(){alert("error");}
			});
			$(".noInput").css("display", "none");			// title : updataForm의 input태그 숨기기
			$(".aTag").css("display", "block");				// title : list에서 보여야 할 title 보이기
			$(".trView").css("display", "none");			// trView 클래스 전부 display : none		
			var upButton = "<button class='btn btn-success btn-sm' onclick='goUpdateForm(" + idx + ")'>수정화면</button>"
			$("#ub" + idx).html(upButton);
			$(".noUp").attr("readonly", true);				// 수정 안되게 readonly 적용하기
			$("#c"+idx).css("display", "table-row");		// 내가 클릭한 trView만 보이게-tr : block말고 table-row 해야지 td에 적용된 colspan이 적용된다.
		}else{
			$("#c"+idx).css("display", "none");
			console.log(idx +' : aaaa');
			$.ajax({						// 조회수 +
				url : "board/count/" + idx,
				type : "put",
				dataType : "json",
				success : function(data){
					$("#cnt" + idx).text(data.count);
				},
				error : function(){alert("error");}
			});
		}
	}
	
	// 글삭제
	function goDelete(idx){
		$.ajax({
			url : "board/" + idx,
			type : "delete",
			success : loadList,
			error : function(){alert("error");}
		});
	}
	
	// 글 수정화면
	function goUpdateForm(idx){
		$("#ta"+idx).attr("readonly",false);
		var title = $("#t"+ idx).text();
		var oldHtml = $("#t"+ idx).html();
		oldHtml += "<input type='text' id='nt" + idx + "' class='form-control noInput' value='" + title + "' style='display:block;'>";
		$("#t"+ idx).html(oldHtml);
		$('#a'+idx).css("display", "none");
		$("#ta"+idx).focus();
		
		var newButton = "<button class='btn btn-primary btn-sm' onclick='goUpdate(" + idx + ")'>수정</button>"
		$("#ub"+idx).html(newButton);
	}
	
	// 글 수정
	function goUpdate(idx){
		var title = $("#nt" + idx).val();
		var contents = $("#ta" + idx).val();
		console.log(title);
		$.ajax({
			url : "board/update",
			type : "put",
			contentType : 'application/json;charset=utf-8',										// 아래의 전송 데이터 타입을 걸어줌 json으로 보내겠다.
			data : JSON.stringify({"idx" : idx, "title" : title, "contents" : contents}),		// put으로 빈타입 혹은 여러개의 데이터 전송시 -> json 포맷으로 변형 : JSON.stringify
			success : loadList,
			error : function(){alert("error");}
		});
	}
</script>
</head>
<body>
<div class="container">
  <h2>Spring MVC02</h2>
  <div class="panel panel-primary">
    <div class="panel-heading">Board</div>
    <div class="panel-body" id="view"></div>
    <div class="panel-body" id="wform" style="display: none;">
    	<form id="frm">
		<table class="table">
			<tr>
				<td>제목</td>
				<td><input type="text" name="title" id="title" class="form-control"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea rows="7" name="contents" id="contents" class="form-control"></textarea>
			</tr>
			<tr>
				<td>작성자</td>
				<td><input type="text" name="writer" id="writer" class="form-control"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<button type="button" class="btn btn-success btn-sm" onclick="goInsert()">등록</button>
					<button type="reset" class="btn btn-warning btn-sm" id="fClear">취소</button>
					<button type="button" class="btn btn-info btn-sm" id="list1" onclick="goList()">목록</button>
				</td>
			</tr>
		</table>
		</form>
    </div>
    <div class="panel-footer footer">Panel Footer : 인프런 퐈이아!!!!</div>
  </div>
</div>
</body>
</html>