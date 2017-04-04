<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
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
<div id="wrap">

<form class="pp_form" id="form2" name="form2" method="post" action="">
	<input type="hidden" id="mode" name="mode" value="" />
	<input type="hidden" id="cd" name="cd" value="${getCodeView.CD }" />
	<input type="hidden" id="flag" name="flag" value="${params.flag }" />
	<fieldset>
	<h2 class="sub_title">코드수정</h2>
	<div class="col_md_12">
		<label class="col_md_2 ">코드명</label> 
		<input class="col_md_10" name="cd_nm" id="cd_nm" type="text" value="<c:if test="${params.flag eq '3' }">${getCodeView.CD_NM}</c:if>" >
		<label class="col_md_2">코드값</label>
		<input class="col_md_10" name="cd_val" id="cd_val" type="text" value="<c:if test="${params.flag eq '3' }">${getCodeView.CD_VAL}</c:if>">
		<p class="full-right">
			<a href="#submit" class="btn btn_info" onclick="fnSubmit('${params.flag}');"><span>저장</span></a>
		<!--            <a href="#cancel" class="btn-cancel" onclick="window.parent.closeModal();"><span>닫기</span></a> -->
		           <a href="#cancel" class="btn btn_default" onclick="window.self.close();"><span>닫기</span></a>
		</p>
	</div>
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