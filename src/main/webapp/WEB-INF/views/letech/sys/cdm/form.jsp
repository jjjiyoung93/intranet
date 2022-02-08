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
	<h1 class="">코드수정</h1>
	<div class="clearfix pop-contents">
		<ul>
			<li class="form-group">
				<label class=" ">코드명</label> 
				<input class="form-control" name="cd_nm" id="cd_nm" type="text" value="<c:if test="${params.flag eq '3' }">${getCodeView.CD_NM}</c:if>" >
			</li>
			<li class="form-group">
				<label class="">코드값</label>
				<c:if test="${params.cd eq 'CD0002' || getCodeView.UP_CD eq 'CD0002'}">
					<span style="color: red;">진행 프로젝트 : 'Y', 종료 프로제트 : 'N' (대소문자 유의)</span>
				</c:if>
				<input class="form-control" name="cd_val" id="cd_val" type="text" value="<c:if test="${params.flag eq '3' }">${getCodeView.CD_VAL}</c:if>">
			</li>
		</ul>
	</div>
		<p class="clearfix pop-btn">
				<!--<a href="#cancel" class="btn-cancel" onclick="window.parent.closeModal();"><span>닫기</span></a> -->
			<span class="pull-right">
				<a href="#submit" class="btn btn-sm btn-info" onclick="fnSubmit('${params.flag}');">저장</a>
				<a href="#cancel" class="btn btn-sm btn-default" onclick="window.self.close();">닫기</a>
			</span>
		</p>
	</fieldset>
</form>
</div>
	         
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">

function fnSubmit(flag){
	if(flag == '3'){
		document.form2.mode.value = '<%=VarConsts.MODE_U%>';
	}else{
		document.form2.mode.value = '<%=VarConsts.MODE_I%>';
	}
	$.ajax({
		url: "<%=request.getContextPath()%>/sys/cdm/tran.do",
		type: "post",
		dataType : "json", 
		data : $("#form2").serialize(),
		success: function(result){
			//parent.jQuery( ".pop_bg" ).fadeOut('slow');
			alert("등록되었습니다.");
			$(opener.location).attr("href","javascript:fnList();");
			//parent.fnList();
			window.self.close();
		},error: function (request, status, error) {
			alert(request.responseText);
		} 
	});
	
}


</script>

</body>
</html>