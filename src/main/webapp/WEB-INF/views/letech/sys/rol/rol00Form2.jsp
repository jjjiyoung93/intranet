<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
	<title>Letech Intranet</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
<body>
			
 	 <form class="pp_form"  id="form2" name="form2" method="post" action="rol01tran.do" onsubmit="return false;" >
			<input type="hidden" id="mode" name="mode" />
			<input type="hidden" id="role_code" name="role_code" value="${params.role_code}" />
			<input type="hidden" id="flag" name="flag" value="${params.flag }" />
			<h2>접근롤 추가</h2>
		    <fieldset>
		    	<div class="col_md_12">
			     	<p class="col_md_12"><label class="col_md_3 lb_text" for="mn_nm" >롤코드 : </label>
			     	${params.role_code}</p>
			        <label class="col_md_3"  for="author_code" >권한코드 : </label>
					<select class="col_md_9" id="author_code" name="author_code">
				<c:forEach var="authList" items="${authList}">
						<option value="${authList.AUTHOR_CODE}" >${authList.AUTHOR_NM}</option>
				</c:forEach>
					</select>
				</div>	
		      <!-- Allow form submission with keyboard without duplicating the dialog button -->
		      <p class="full-right">
		      	 <a href="#submit" class="btn btn_info" onclick="fnSubmit('${params.flag}');"><span>저장</span></a>
          		 <a href="#cancel" class="btn btn_default" onclick="window.self.close();"><span>닫기</span></a>
		      </p>
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
		url: "<%=request.getContextPath()%>/sys/rol/rol00Tran2.do",
		type: "post",
		dataType : "json", 
		data : $("#form2").serialize(),
		success: function(result){
			//parent.jQuery( ".pop_bg" ).fadeOut('slow');
			alert("등록되었습니다.");
			$(opener.location).attr("href","javascript:goTwoList('${params.role_code}');");
			window.self.close();
		},error: function (request, status, error) {
			alert(request.responseText);
		} 
	});
	
}


</script>

</body>
</html>