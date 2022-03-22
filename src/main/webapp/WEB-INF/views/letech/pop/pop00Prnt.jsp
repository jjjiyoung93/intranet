<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
<jsp:include page="/resources/com/inc/meta.jsp" />
<title>Letech Intranet</title>
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.print.css' rel='stylesheet' media='print' />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/bbs_${bbsInfo.LAYOUT_TY}.css">
<link href="${pageContext.request.contextPath}/resources/js/css/ui-lightness/jquery-ui-1.9.2.custom.min.css" rel="stylesheet">
<style type="text/css">
body {
	background: white;
}

li.content {
	min-height: 60vh;
}

#footer {
	background: gray;
	position: fixed;
	bottom: 0;
	width: 100%;
	position: fixed;
}
</style>
</head>

<body>
	<!-- 전체 감싸는 id -->
	<div id="container-fluid">
		<!-- 컨텐츠-->
		<section class="clearfix">
			<div class="col-lg-10 conts-container un-style">
				<div class="form-container">
					<ul class="form-view">
						<li>
							<span>${params.title}</span>
						</li>
						<li class="content">${params.content }</li>
						<c:if test="${not empty params.noticeSeq }">
							<li>
								<div class="text-center">
									<button class="btn btn-lg">공지사항 게시글로 이동하기</button>
								</div>
							</li>
						</c:if>
					</ul>
				</div>
			</div>
		</section>
		<div id="footer">
			<label> <input type="checkbox"> <c:if test="${params.hidePopup eq 'oneDay'}">
									오늘 하루 보지않기
								</c:if> <c:if test="${params.hidePopup eq 'allDay' }">
									다시보지 않기	
								</c:if>
			</label>
		</div>
	</div>
	<!-- js파일 및 공통스크립트사용 -->
	<jsp:include page="/resources/com/inc/javascript.jsp" />
</body>
</html>