<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>Letech Intranet</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
</head>

<body>
<div id="wrap">
		<jsp:include page="/resources/com/inc/header.jsp" />
	    <%-- <jsp:include page="/resources/com/inc/menu.jsp" /> --%>
	    <jsp:include page="/WEB-INF/views/letech/com/layout/menu.jsp" />
		<%-- <%@ include file="../com/layout/menu.jsp" %> --%>
	    <div class="container">
	   	 	<jsp:include page="/resources/com/inc/aside.jsp" />
			<section class="contents">
	
	
	<form name="frm1" id="frm1" method="post" action="${pageContext.request.contextPath}/uss/umt/uss01Form.do" >
		<input type="hidden" name="cal_hol_seq" id="cal_hol_seq" value="${param.cal_hol_seq }" />
		<input type="hidden" id="mode" name="mode" value="" />
	
	<h4 id="b_tlt"><span>사용자관리</span></h4> 
 
	<table cellpadding="0" cellspacing="0" class="table_list2">
     	<tbody>
            <tr>
	          	<td>휴일명</td>
	          	<td style="text-align: left;height: 20px;">
					${params.CAL_HOL_NM}
	            </td>
            </tr>
            <tr>
	          	<td>생년월일</td>
	          	<td style="text-align: left;height: 20px;">
					${params.CAL_HOL_DT}
	            </td>
            </tr>
      	</tbody>
    </table>
	</form>
	<br/>
	
	<div class="btn" style="text-align: right;">
	    <a href="#submit" class="btn-upd" ><span>수정</span></a>
	    <a href="#submit" class="btn-del" ><span>삭제</span></a>
	    <a href="#cancel" class="btn-list" ><span>목록</span></a>
	</div>
</section>
</div>
 <jsp:include page="<%=request.getContextPath()%>/resources/com/inc/footer.jsp" />
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	/* 수정폼 */	
	$( ".btn-upd" ).click(function() {
		$("#mode").val("<%=VarConsts.MODE_U%>");
		$("#frm1").attr("action", "${pageContext.request.contextPath}/cal/hol00Form.do");
		$("#frm1").submit();
	});
	/* 삭제 */
	$( ".btn-del" ).click(function() {
		if(confirm("삭제하시겠습니까?")){
			$("#mode").val("<%=VarConsts.MODE_D%>");			
			$.ajax({
				url: "${pageContext.request.contextPath}/cal/hol00Tran.do",
				type: "post",
				dataType : "json", 
				data : $("#frm1").serialize(),
				success: function(result){
					alert("삭제되었습니다.");
					goList();
				},error: function (request, status, error) {
					alert("삭제에 실패 했습니다.");
// 					alert(request.responseText);
				} 
			});
		}
	});
	/* 목록 */
	$( ".btn-list" ).click(function() {
		goList();
	});
	
});

function goList(){
	$("#frm1").attr("action", "${pageContext.request.contextPath}/cal/hol00List.do");
	$("#frm1").submit();
}

</script>
</body>
</html>