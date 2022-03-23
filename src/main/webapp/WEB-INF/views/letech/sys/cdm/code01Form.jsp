<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
<jsp:include page="/resources/com/inc/meta.jsp" />
<title>Letech Intranet</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("ul.panel li.tab_cont:not("+$("ul.tab li a.selected").attr("href")+")").hide()
		$("ul.tab li a").click(function(){
			$("ul.tab li a").removeClass("selected");
			$(this).addClass("selected");
			$("ul.panel li.tab_cont").hide();
			$($(this).attr("href")).show();
			return false;
		});
	});
</script>
</head>
<body class="pop">
	<div id="wrap" class="container">
	
	<form class="pp_form" id="form2" name="form2" method="post" action="">
		<input type="hidden" id="mode" name="mode" value="" />
		<input type="hidden" id="cd" name="cd" value="${getCodeView.CD }" />
		<input type="hidden" id="flag" name="flag" value="${params.flag }" />
		<fieldset>
		<c:if test="${params.flag eq '2'}">
		<h1 class="" id="title">코드상세</h1>
		</c:if>
		<c:if test="${params.flag eq '1'}">
		<h1 class="" id="title">코드등록</h1>
		</c:if>
		<div class="clearfix pop-contents">
			<ul>
				<li class="form-group">
					<label class=" ">코&nbsp;&nbsp;&nbsp;드</label>
					<c:if test="${params.flag eq '2'}">
						<input class="form-control" name="cd" id="cd" type="text" value="${getCodeView.CD}" readonly>
					</c:if>
					<c:if test="${params.flag eq '1'}">
						<input class="form-control" name="cd" id="cd" type="text" readonly>
					</c:if>
				</li>
				<li class="form-group">
				<label class=" ">코드명</label> 
				<c:if test="${params.flag eq '2'}">
					<input class="form-control" name="cd_nm" id="cd_nm" type="text" value="${getCodeView.CD_NM}" readonly>
				</c:if>
				<c:if test="${params.flag eq '1'}">
					<input class="form-control" name="cd_nm" id="cd_nm" type="text">
				</c:if>
				</li>
				<li class="form-group">
					<label class="">코드값</label>
					<c:if test="${params.flag eq '2'}">
						<input class="form-control" name="cd_val" id="cd_val" type="text" value="${getCodeView.CD_VAL}" readonly>
					</c:if>
					<c:if test="${params.flag eq '1'}">
						<input class="form-control" name="cd_val" id="cd_val" type="text">
					</c:if>
				</li>
			</ul>
		</div>
			<p class="clearfix pop-btn">
				<c:if test="${params.flag eq '2'}">
					<a href="#delete" class="btn btn-sm btn-info" id="delete" onclick="window.parent.closeModal();" style="margin-left:15px;"><span>삭제</span></a>
					<span class="pull-right">
						<a href="#modify" class="btn btn-sm btn-info" id="modify" onclick="codeModify('${getCodeView.CD}');">수정</a>
						<a href="#cancel" class="btn btn-sm btn-default" onclick="window.self.close();" style="margin-right:20px;">닫기</a>
					</span>
				</c:if>
				<c:if test="${params.flag eq '1'}">
					<span class="pull-right">
					<a href="#submit" class="btn btn-sm btn-info" onclick="fnSubmit('${params.flag}');">저장</a>
					<a href="#cancel" class="btn btn-sm btn-default" onclick="window.self.close();" style="margin-right:20px;">닫기</a>
					</span>
				</c:if>
			</p>
		</fieldset>
	</form>
	</div>
	         
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">

function codeModify(cd) {
//	console.log(cd);
	$('#title').replaceWith('<h1 class="" id="title">코드수정</h1>');
	$('#cd_nm').removeAttr('readonly');
	$('#cd_val').removeAttr('readonly');
	$('#delete').remove();
	$('#modify').replaceWith('<a href="#submit" class="btn btn-sm btn-info" id="modify" onclick="codeSave();">저장</a>');
	
}

function codeSave() {
	alert('저장');
	window.self.close();
}
//function fnSubmit(flag){
//	if(flag == '3'){
//		document.form2.mode.value = '<%=VarConsts.MODE_U%>';
//	}else{
//		document.form2.mode.value = '<%=VarConsts.MODE_I%>';
//	}
//	$.ajax({
//		url: "<%=request.getContextPath()%>/sys/cdm/tran.do",
//		type: "post",
//		dataType : "json", 
//		data : $("#form2").serialize(),
//		success: function(result){
//			//parent.jQuery( ".pop_bg" ).fadeOut('slow');
//			alert("등록되었습니다.");
//			$(opener.location).attr("href","javascript:fnList();");
//			//parent.fnList();
//			window.self.close();
//		},error: function (request, status, error) {
//			alert(request.responseText);
//		} 
//	});
//	
//}


</script>

</body>
</html>