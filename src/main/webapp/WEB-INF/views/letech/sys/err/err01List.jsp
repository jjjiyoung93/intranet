<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
	<jsp:include page="/resources/com/inc/meta.jsp" />
	<title>Letech Intranet</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
</head>
<body>
	<!-- 전체 감싸는 id -->
	<div id="wrapper">
		<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
			<jsp:include page="/resources/com/inc/header.jsp" />
			<%@ include file="/WEB-INF/views/letech/com/layout/menu.jsp" %>
		</nav>
		
		<div class="" id="page-wrapper">
	   	 	<section class="row">
	   	 		<!-- 내용부분(작업할 부분 클래스 col-lg-10안에 넣음 됨) -->
				<div class="col-lg-10">
					<form name="form1" id="form1" method="post" action="<%=request.getContextPath()%>/sys/err/err01List.do" >
						<input type="hidden" id="mode" name="mode" />
						<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}"/>
						<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}"/>
						<input type="hidden" id="menu_id3" name="menu_id3" value="${params.menu_id3}"/>
						<input type="hidden" name="cPage" id="cPage" value="" />
						<input type="hidden" name="error_seq" id="error_seq" value="" />
						<input type="hidden" name="process_state" id="process_state" value="" />
						
						<!-- 타이틀 및 페이지 네비 -->
						<h4 class="title">
							${titleNaviMap.MN_NM }
							<span class="pull-right text-muted small">
								HOME > ${titleNaviMap.NAVI_NM }
							</span>
						</h4>
						
						<div class="row">
							<div class="col-lg-6">
								<div class="form-inline">
									<div class="form-group">
										<div class="input-group">
											<strong class="list_count" >Total : ${totalCnt} 건</strong>
										</div>
									</div>
								</div>
							</div>
						</div>
						
						<div class="">
							<table class="table table-bordered">
								<thead>
									<th class="hidden-xs hidden-sm">번호</th>
									<th class="">로거</th>
									<th class="">레벨</th>
									<th class="">발생일자</th>
									<th class="hidden-xs hidden-sm">처리일자</th>
									<th class="">처리자</th>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${pageInfo eq null }">
											<tr>
												<th colspan="7">
													등록된 에러가 없습니다.
												</th>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach var="highList" items="${pageInfo.highList }" varStatus="status">
												<tr>
													<th>${totalCnt - status.index - ((cPage-1) * (intListCnt))}</th>
													<td>
														<a href="#" onclick="fnView('${highList.ERROR_SEQ}', '${highList.PROCESS_STATE}');">${highList.ERROR_LOGGER }</a> 
													</td>
													<td>${highList.ERROR_LEVEL }</td>
													<td>${highList.ERROR_DATE }</td>
													<td>${highList.PROCESS_DATE }</td>
													<td>${highList.PROCESS_REG_NM }</td>
												</tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>
						
						<div class="row">
							<div class="col-md-12 col-xs-12">
								<div class="form-inline">
									<p class="row text-center">
										<strong>${pageNavigator }</strong>
									</p>
								</div>
							</div>
						</div>
					</form>
				</div>
				<!-- aside(공지사항) -->
				<jsp:include page="/resources/com/inc/aside.jsp" />
	   	 	</section>
	   	 </div>
	   	 <jsp:include page="/resources/com/inc/footer.jsp" />
	</div>

	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript">

		/*********************************************************************************
		* function명   : fnTabMove
		* function기능 : 탭이동
		**********************************************************************************/
		function fnTabMove(href,pm1){
			document.form1.action = "<%=request.getContextPath() %>/"+href;
			document.form1.menu_id3.value = pm1;
			document.form1.submit();
			
		}
		
		/*********************************************************************************
		* function명   : fnView
		* function기능 : 에러 상세조회
		**********************************************************************************/
		function fnView(error_seq, process_state){
			$("#error_seq").val(error_seq);
			$("#process_state").val(process_state);
			$("#form1").attr("action", "${pageContext.request.contextPath}/sys/err/err01View.do");
			$("#form1").submit();
		}
		
		/*********************************************************************************
		* function명   : goPage
		* function기능 : 페이지이동
		**********************************************************************************/
		function goPage(cPage){
			$("#cPage").val(cPage);
			$("#form1").attr("action", "${pageContext.request.contextPath}/sys/err/err01List.do");
			$("#form1").submit();
		}
	</script>
</body>
</html>