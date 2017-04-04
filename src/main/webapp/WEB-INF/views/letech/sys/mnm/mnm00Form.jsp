<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
	<title>Letech Intranet</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
</head>
<body>
	<div id="wrap">
		<jsp:include page="/resources/com/inc/header.jsp" />
	    <%-- <jsp:include page="/resources/com/inc/menu.jsp" /> --%>
		<%--<jsp:include page="/WEB-INF/views/letech/com/layout/menu.jsp" /> --%>
		<%@ include file="/WEB-INF/views/letech/com/layout/menu.jsp" %>
	    <div class="container">
	   	 	<jsp:include page="/resources/com/inc/aside.jsp" />
			<section class="contents">
				
	 	 <form id="form2" name="form2" method="post" action="mnm00tran.do" onsubmit="return false;">
				<input type="hidden" id="mn" name="mn" value="${params.mn}" />
				<input type="hidden" id="levl" name="levl" value="" />
				<input type="hidden" id="mode" name="mode" />
				<input type="hidden" id="up_mn" name="up_mn" value="${params.up_mn}" />
				<input type="hidden" id="flag" name="flag" value="${params.flag }" />
			    <fieldset style="width: 100%">
			      <label for="mn_nm" >메뉴명</label>
			      <input type="text" name="mn_nm" id="mn_nm" value="${getCodeView.MN_NM}" class="input input-small" style="margin-bottom:15px; width:100%;">
			      <label for="mn_type">메뉴명</label>
				  <select id="mn_type" name="mn_type">
						<option value="" >--선택--</option>
					<c:forEach var="codeList" items="${codeList}">
						<option value="${codeList.CD_VAL}" >${codeList.CD_NM}</option>
					</c:forEach>
				  </select>
				  <br>
				  <br>
			      <label for="mn_val" style="font-family:'돋움';">메뉴선택값(***Mng)</label>
			      <input type="text" name="mn_val" id="mn_val" value="${getCodeView.MN_VAL}" class="input input-small" style="margin-bottom:15px; width:100%;">
			      <label for="mn_ord" style="font-family:'돋움';">메뉴순서</label>
			      <input type="text" name="mn_ord" id="mn_ord" value="${getCodeView.MN_ORD}" maxlength="2" numberonly="true" class="input input-small" style="margin-bottom:15px; width:100%;">
			      <label for="mn_href" style="font-family:'돋움';">메뉴URL(1레벨의경우필요없음)</label>
			      <input type="text" name="mn_href" id="mn_href" value="${getCodeView.MN_HREF}" class="input input-small" style="margin-bottom:15px; width:100%;">
			 
			      <!-- Allow form submission with keyboard without duplicating the dialog button -->
			      <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
			    </fieldset>
			</form>
     <br/>
       <div class="full-right" >
           <a href="#submit" class="btn-ok" onclick="fnSubmit('${params.flag}');"><span>저장</span></a>
           <a href="#cancel" class="btn-cancel" onclick="window.self.close();"><span>닫기</span></a>
       </div>
       
</section>
   	</div>
	 <jsp:include page="/resources/com/inc/footer.jsp" />
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
		url: "<%=request.getContextPath()%>/sys/mnm/mnm00Tran.do",
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