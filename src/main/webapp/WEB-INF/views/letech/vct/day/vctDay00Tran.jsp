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
	/* var mode = "${params.mode}";
	var errorMsg = "${errorMsg}"; */
	
	var resultCnt = "${resultCnt}";
	var resultMsg = "${resultMsg}";
	
	var msg = "";
	
	//정상 작동한 경우
	if(resultMsg == "0000"){
		msg = "휴가부여일수 " + resultCnt +"개의 변경사항이 저장되었습니다.";
		alert(msg);
		$("#frm").attr("action", "${pageContext.request.contextPath}/sys/vct/vctDay00List.do");
		$("#frm").submit();
	}else if(resultMsg == "9999"){ // 오류 발생한 경우
		msg = "휴가부여일수 변경을 실패 했습니다."
		alert(msg);
		history.back(-1);
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
	<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}" />
	<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}" />
	<%-- <input type="hidden" name="mode" id="mode" value="${params.mode}" />
	<input type="hidden" name="aprv_no" id="aprv_no" value="${params.aprv_no }" />
	<input type="hidden" id="line_chk" name="line_chk" value="${params.line_chk }" /> --%>
	<!-- 검색 정보 Start -->
	<input type="hidden" name="cPage" id="cPage" value="${param.cPage }" />
	<%-- <input type="hidden" id="searchCdList1" name="searchCdList1" value="${param.searchCdList1}" />
	<input type="hidden" id="searchCdList2" name="searchCdList2" value="${param.searchCdList2}" />
	<input type="hidden" id="searchCdList3" name="searchCdList3" value="${param.searchCdList3}" /> --%>
	
	<input type="hidden" id="searchGubun2" name="searchGubun2" value="${param.searchGubun2}" />
	<input type="hidden" id="searchGubun3" name="searchGubun3" value="${param.searchGubun3}" />
	<input type="hidden" id="searchGubun" name="searchGubun" value="${param.searchGubun}" />
	<input type="hidden" id="searchField" name="searchField" value="${param.searchField}" />
	<!-- 검색 정보 End -->
</form>
<!-- Content Start -->

		</section>
	</div>
	<jsp:include page="/resources/com/inc/footer.jsp" />
</div>

</body>
</html>