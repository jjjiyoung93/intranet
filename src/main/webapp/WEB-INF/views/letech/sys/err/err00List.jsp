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
	<div id="warpper">
		<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
			<jsp:include page="/resources/com/inc/header.jsp" />
			<%@ include file="/WEB-INF/views/letech/com/layout/menu.jsp" %>
		</nav>
		<div id="page-wrapper">
			<section class="row">
				<form name="form1" id="form1" method="post" action="<%=request.getContextPath()%>/sys/err/err00List.do" >
					<input type="hidden" id="mode" name="mode" />
					<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}"/>
					<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}"/>
					<input type="hidden" id="menu_id3" name="menu_id3" value="${params.menu_id3}"/>
					<input type="hidden" name="cPage" id="cPage" value="" />
					<input type="hidden" name="error_seq" id="error_seq" value="" />
					<input type="hidden" name="process_state" id="process_state" value="" />
					<div class="col-lg-10">
						<!-- 타이틀 및 페이지 네비 -->		
						<h4 class="title">${titleNaviMap.MN_NM }<span class="pull-right text-muted small">HOME > ${titleNaviMap.NAVI_NM }</span></h4>
							
						<%-- <c:if test="${mnList3 ne null}">
							<article>
								<ul class="tab_gnb">
										<c:forEach var="list3" items="${mnList3}" varStatus="status">
											<c:if test="${params.menu_id2 eq list3.UP_MN}">
												<li class="<c:if test="${params.menu_id3 eq list3.MN}">on </c:if>col_md_3">
													<a href="javascript:fnTabMove('${list3.MN_HREF}','${list3.MN}')">${list3.MN_NM}</a>
												</li>
											</c:if>
									</c:forEach>
								</ul>
					   		</article>
						</c:if> --%>
						
						<!-- page -->
						<strong class="list_count" >Total :</strong> ${totalCnt} 건
						<div class="table-responsive">
							<!-- 테이블 -->
							<table class="table table-bordered">
								<caption>메뉴관리</caption>
								<colgroup>
									<col width="10%"  />
									<col width="*"  />
									<col width="10%"  />
									<col width="15%"  />
									<col width="15%"  />
								</colgroup>
								<thead>
									<tr>
										<th>번호</th>
										<th>로거</th>
										<th>레벨</th>
										<th>처리상태</th>
										<th>발생일자</th>
									</tr>								
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
													<td>${highList.PROCESS_STATE_NM }</td>
													<td>${highList.ERROR_DATE }</td>
												</tr>
											</c:forEach>					
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
							
							<!-- page nav -->
							<p class="page_nav">
								<strong>${pageNavigator }</strong>
							</p>
						</div>
					</div>
				</form>
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
			$("#form1").attr("action", "${pageContext.request.contextPath}/sys/err/err00View.do");
			$("#form1").submit();
		}
		
		/*********************************************************************************
		* function명   : goPage
		* function기능 : 페이지이동
		**********************************************************************************/
		function goPage(cPage){
			$("#cPage").val(cPage);
			$("#form1").attr("action", "${pageContext.request.contextPath}/sys/err/err00List.do");
			$("#form1").submit();
		}
	</script>
</body>
</html>