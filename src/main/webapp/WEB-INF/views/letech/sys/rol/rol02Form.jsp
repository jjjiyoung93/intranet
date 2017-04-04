<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
	<title>Letech Intranet</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
<body>
				
	<form id="form2" name="form2" method="post" action="rol02tran.do" onsubmit="return false;" >
		<input type="hidden" id="mode" name="mode" />
		<input type="hidden" id="flag" name="flag" value="${params.flag }" />
		<fieldset>
			<h2 class="sub_title">권한추가</h2>
			<div class="col_md_12">
				<label class="col_md_12" for="mn" >(*ROLE_로 시작할것,PK 수정 안됨)</label>
				<label class="col_md_5" for="mn_nm" >권한코드</label>
				<input class="col_md_5" type="text" name="author_code" id="author_code" value="${getView.AUTHOR_CODE}" class="input input-small" />
				<label class="col_md_5" for="mn_val" >권한명</label>
				<input class="col_md_5" type="text" name="author_nm" id="author_nm" value="${getView.AUTHOR_NM}" class="input input-small" />
				<p class="full-right">
					<a href="#submit" class="btn-ok btn btn_info" onclick="fnSubmit('${params.flag}');"><span>저장</span></a>
					<a href="#cancel" class="btn-cancel btn btn_default" onclick="window.self.close();"><span>닫기</span></a>
				</p>
			</div>
		</fieldset>
	</form>
       
       
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">

function fnSubmit(flag){
	if(flag == '3'){
		document.form2.mode.value = '<%=VarConsts.MODE_U%>';
	}else{
		document.form2.mode.value = '<%=VarConsts.MODE_I%>';
	}
	$.ajax({
		url: "<%=request.getContextPath()%>/sys/rol/rol02Tran.do",
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