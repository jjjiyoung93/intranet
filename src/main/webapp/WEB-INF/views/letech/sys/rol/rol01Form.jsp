<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
	<jsp:include page="/resources/com/inc/meta.jsp" />
	<title>Letech Intranet</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
<body class="pop">
	<div class="container">			
 	 <form class="pp_form" id="form2" name="form2" method="post" action="rol01tran.do" onsubmit="return false;" >
			<input type="hidden" id="mode" name="mode" />
			<input type="hidden" id="role_code" name="role_code" value="${params.role_code}" />
			<input type="hidden" id="flag" name="flag" value="${params.flag }" />
				 <fieldset style="width: 100%">
					 <h1 class="sub_title">권한상속관계추가</h1>
					 <div class="pop-contents">
					 	<ul>
					 		<li>
					 			<label class="" for="parnts_role" >부모코드</label>
								<select class="form-control" id="parnts_role" name="parnts_role">
									<c:forEach var="authList" items="${authList}">
										<c:if test="${authList.AUTHOR_CODE ne 'ROLE_ANONYMOUS' }">
											<option value="${authList.AUTHOR_CODE}" >${authList.AUTHOR_NM}</option>
										</c:if>
									</c:forEach>
								</select>
					 		</li>
					 		<li>
					 			<label class="" for="chldrn_role" >자식코드</label>
								<select class="form-control" id="chldrn_role" name="chldrn_role">
									<c:forEach var="authList" items="${authList}">
										<c:if test="${authList.AUTHOR_CODE ne 'ROLE_ANONYMOUS' }">
											<option value="${authList.AUTHOR_CODE}" >${authList.AUTHOR_NM}</option>
										</c:if>
									</c:forEach>
								</select>
					 		</li>
						</ul>
					</div>
					<p class="clearfix pop-btn">
						<span class="pull-right">
	           <a href="#submit" class="btn btn-info btn-sm" onclick="fnSubmit('${params.flag}');">저장</a>
	           <a href="#cancel" class="btn btn-default btn-sm" onclick="window.self.close();">닫기</a>
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