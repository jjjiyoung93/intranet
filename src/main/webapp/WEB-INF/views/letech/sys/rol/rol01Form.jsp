<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
	<title>Letech Intranet</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
<body class="pop">
				
 	 <form class="pp_form" id="form2" name="form2" method="post" action="rol01tran.do" onsubmit="return false;" >
			<input type="hidden" id="mode" name="mode" />
			<input type="hidden" id="role_code" name="role_code" value="${params.role_code}" />
			<input type="hidden" id="flag" name="flag" value="${params.flag }" />
			 <fieldset style="width: 100%">
			 <h2 class="sub_title">권한상속관계추가</h2>
			 <div class="col_md_12">
			 	<label class="col_md_3" for="parnts_role" >부모코드</label>
				<select class="col_md_9" id="parnts_role" name="parnts_role">
			<c:forEach var="authList" items="${authList}">
				<c:if test="${authList.AUTHOR_CODE ne 'ROLE_ANONYMOUS' }">
					<option value="${authList.AUTHOR_CODE}" >${authList.AUTHOR_NM}</option>
				</c:if>
			</c:forEach>
				</select>
				<label class="col_md_3" for="chldrn_role" >자식코드</label>
				<select class="col_md_9" id="chldrn_role" name="chldrn_role">
			<c:forEach var="authList" items="${authList}">
				<c:if test="${authList.AUTHOR_CODE ne 'ROLE_ANONYMOUS' }">
					<option value="${authList.AUTHOR_CODE}" >${authList.AUTHOR_NM}</option>
				</c:if>
			</c:forEach>
				</select>
			 </div>
				<p class="full-right">
		           <a href="#submit" class="btn btn_info" onclick="fnSubmit('${params.flag}');"><span>저장</span></a>
		           <a href="#cancel" class="btn btn_default" onclick="window.self.close();"><span>닫기</span></a>
		       </div>
		    </fieldset>
		  </form>
     <br/>
       
       
       
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">

function fnSubmit(flag){
	if(flag == '3'){
		document.form2.mode.value = '<%=VarConsts.MODE_U%>';
	}else{
		document.form2.mode.value = '<%=VarConsts.MODE_I%>';
	}
	$.ajax({
		url: "<%=request.getContextPath()%>/sys/rol/rol01Tran.do",
		type: "post",
		dataType : "json", 
		data : $("#form2").serialize(),
		success: function(result){
			//parent.jQuery( ".pop_bg" ).fadeOut('slow');
			alert("등록되었습니다.");
//			$(opener.location).attr("href","javascript:fnList('MN0001','MN0015','MN0016');");
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