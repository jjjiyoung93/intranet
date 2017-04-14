<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
	<jsp:include page="/resources/com/inc/meta.jsp" />
	<title>Letech Intranet</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
<body class="pop">
				
 	 <form class="pp_form" id="form2" name="form2" method="post" action="rol00tran.do" onsubmit="return false;" >
			<input type="hidden" id="mn" name="mn" value="${params.mn}" />
			<input type="hidden" id="mode" name="mode" />
			<input type="hidden" id="role_code" name="role_code" value="${getView.ROLE_CODE}" />
			<input type="hidden" id="flag" name="flag" value="${params.flag }" />
		    <fieldset>
		    	<h2 class="sub_title">패턴추가</h2>
		    	<div class="col_md_12">
			     	<label class="col_md_3" for="role_nm" >권한패턴명</label>
			     	<input class="col_md_9" type="text" name="role_nm" id="role_nm" value="${getView.ROLE_NM}" class="input input-small" >
			     	<label class="col_md_3 " for="role_pttrn" >권한패턴</label>
			     	<input class="col_md_9"  type="text" name="role_pttrn" id="role_pttrn" value="${getView.ROLE_PTTRN}" class="input input-small" >
			     	<label class="col_md_3" for="role_dc" >권한설명</label>
			     	<input class="col_md_9" type="text" name="role_dc" id="role_dc" value="${getView.ROLE_DC}" class="input input-small" >
			     	<label class="col_md_3" for="role_sort" >접근순번</label>
			     	<input class="col_md_9"  type="text" name="role_sort" id="role_sort" value="${getView.ROLE_SORT}" class="input input-small" >
<c:if test="${params.flag eq '3'  }">
			     	<label class="col_md_3" for="author_code" >권한추가</label>
			     	<select id="author_code" name="author_code" class="col_md_9">
			     		<option value="">--선택--</option>
	<c:forEach var="roleResult" items="${codeList }">
						<option value="${roleResult.CD_VAL }">${roleResult.CD_NM }</option>
	</c:forEach>
	<c:forEach var="roleResult" items="${codeList2 }">
						<option value="${roleResult.CD_VAL }">${roleResult.CD_NM }</option>
	</c:forEach>
			     	</select>
</c:if>
			 		<p class="full-right">
			 			 <a href="#submit" class="btn btn_info" onclick="fnSubmit('${params.flag}');"><span>저장</span></a>
      					 <a href="#cancel" class="btn btn_default" onclick="window.self.close();"><span>닫기</span></a>
			 		</p>
			 	</div>
		      <!-- Allow form submission with keyboard without duplicating the dialog button -->
		      <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
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
		url: "<%=request.getContextPath()%>/sys/rol/rol00Tran.do",
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