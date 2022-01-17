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
			alert("저장에 실패 했습니다.");
			history.back(-1);
		}else if(mode == "<%=VarConsts.MODE_U%>"){
			alert("수정에 실패 했습니다.");
			history.back(-1);
		}
	}else{
		if(mode == "<%=VarConsts.MODE_I%>"){
			$("#cPage").val("1");
			$("#searchCdList1").val("");
			$("#searchCdList2").val("");
			$("#searchCdList3").val("");
			$("#searchGubun").val("");
			$("#searchField").val("");
			$("#frm").attr("action", "${pageContext.request.contextPath}/aprv/aprv00List.do");
 			$("#frm").submit();
		}else if(mode == "<%=VarConsts.MODE_U%>"){
			$("#frm").attr("action", "${pageContext.request.contextPath}/aprv/aprv00View.do");
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
	<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}" />
	<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}" />
	<input type="hidden" name="mode" id="mode" value="${params.mode}" />
	<input type="hidden" name="aprv_no" id="aprv_no" value="${params.aprv_no }" />
	<input type="hidden" id="line_chk" name="line_chk" value="${params.line_chk }" />
	<!-- 검색 정보 Start -->
	<input type="hidden" name="cPage" id="cPage" value="${param.cPage }" />
	<input type="hidden" id="searchCdList1" name="searchCdList1" value="${param.searchCdList1}" />
	<input type="hidden" id="searchCdList2" name="searchCdList2" value="${param.searchCdList2}" />
	<input type="hidden" id="searchCdList3" name="searchCdList3" value="${param.searchCdList3}" />
	
	<input type="hidden" id="searchCdList4" name="searchCdList4" value="${params.searchCdList4}" />
	<input type="hidden" id="searchCdList5" name="searchCdList5" value="${params.searchCdList5}" />
    <input type="hidden" id="searchCdList6" name="searchCdList6" value="${params.searchCdList6}" />
    <input type="hidden" id="myAprvList" name="myAprvList" value="${params.myAprvList}" />
	
	<input type="hidden" id="searchGubun" name="searchGubun" value="${param.searchGubun}" />
	<input type="hidden" id="searchField" name="searchField" value="${param.searchField}" />
 	<input type="hidden" id="searchField2" name="searchField2" value="${params.searchField2}" />
    <input type="hidden" id="searchField3" name="searchField3" value="${params.searchField3}" />
    <input type="hidden" id="listCnt" name="listCnt" value="${params.listCnt}" />
    <input type="hidden" name="stDtSrch" value="${params.stDtSrch}"/>
    <input type="hidden" name="edDtSrch" value="${params.edDtSrch}"/>
	<!-- 검색 정보 End -->
</form>
<!-- Content Start -->

		</section>
	</div>
	<jsp:include page="/resources/com/inc/footer.jsp" />
</div>

</body>
</html>