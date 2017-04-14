<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
<jsp:include page="/resources/com/inc/meta.jsp" />
<title>Letech Intranet</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.print.css' rel='stylesheet' media='print' />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	var mode = "${params.mode}";
	var errorMsg = "${errorMsg}";
	
	if(errorMsg == "Y"){
		// 에러 났을경우
		if(mode == "<%=VarConsts.MODE_I%>"){
			alert("완료처리에 실패 했습니다.");
			history.back(-1);
		}else if(mode == "<%=VarConsts.MODE_U%>"){
			alert("저장에 실패 했습니다.");
			history.back(-1);
		}
	}else{
		if(mode == "<%=VarConsts.MODE_I%>"){
			$("#frm").attr("action", "${pageContext.request.contextPath}/sys/err/err00List.do");
 			$("#frm").submit();
		}else if(mode == "<%=VarConsts.MODE_U%>"){
			$("#frm").attr("action", "${pageContext.request.contextPath}/sys/err/err00View.do");
 			$("#frm").submit();
		}
	}
});
</script>
</head>

<body>
<div id="wrap">
	<jsp:include page="/resources/com/inc/header.jsp" />
	<%@ include file="/WEB-INF/views/letech/com/layout/menu.jsp" %>
    <div class="container">
   	 	<jsp:include page="/resources/com/inc/aside.jsp" />
		<section class="contents">

<!-- Content Start -->	
<form id="frm" name="frm" method="post" action="" >
	<input type="hidden" id="mode" name="mode" value="${params.mode }"/>
				<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}"/>
				<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}"/>
				<input type="hidden" id="menu_id3" name="menu_id3" value="${params.menu_id3}"/>
				<input type="hidden" name="cPage" id="cPage" value="${params.cPage }" />
				<input type="hidden" name="error_seq" id="error_seq" value="${params.error_seq }" />
</form>
<!-- Content Start -->

		</section>
	</div>
	<jsp:include page="/resources/com/inc/footer.jsp" />
</div>

</body>
</html>