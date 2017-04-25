<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
<jsp:include page="/resources/com/inc/meta.jsp" />
<title>Letech Intranet</title>
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.print.css' rel='stylesheet' media='print' />
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
				<div class="col-lg-10">
					<!-- 타이틀 및 페이지 네비 -->		
					<h2 class="page-title clearfix">
						${titleNaviMap.MN_NM }
						<span class="pull-right site-map">
							HOME > ${titleNaviMap.NAVI_NM }
						</span>
					</h2>
						
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
					
						<form name="frm1" id="frm1" method="post" action="<%=request.getContextPath()%>/sys/err/err01List.do" >
							<input type="hidden" id="mode" name="mode" value="${params.mode }"/>
							<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}"/>
							<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}"/>
							<input type="hidden" id="menu_id3" name="menu_id3" value="${params.menu_id3}"/>
							<input type="hidden" name="cPage" id="cPage" value="" />
							<input type="hidden" name="error_seq" id="error_seq" value="${resultView.ERROR_SEQ }" />
							<div class="form-container">
							<div class="border-view">
								<ul class="payment-form">
									<li>
										<dl class="clearfix first-line ">
											<dt class="col-md-2 col-sm-3">로거</dt>
											<dd class="col-md-10 col-sm-9">
												${resultView.ERROR_LOGGER }
											</dd>
										</dl>
										<dl class="clearfix ">
											<dt class="col-md-2 col-sm-3">메소드</dt>
											<dd class="col-md-10 col-sm-9">
												${resultView.ERROR_METHOD }
											</dd>
										</dl>
										<dl class="clearfix ">
											<dt class="col-md-2 col-sm-3">스레드</dt>
											<dd class="col-md-10 col-sm-9">
												${resultView.ERROR_THREAD }
											</dd>
										</dl>
										<dl class="clearfix ">
											<dt class="col-md-2 col-sm-3">레벨</dt>
											<dd class="col-md-10 col-sm-9">
												${resultView.ERROR_LEVEL }
											</dd>
										</dl>
										<dl class="clearfix ">
											<dt class="col-md-2 col-sm-3">발생일</dt>
											<dd class="col-md-10 col-sm-9">
												${resultView.ERROR_DATE }
											</dd>
										</dl>
										<dl class="clearfix ">
											<dt class="col-md-2 col-sm-3">처리일</dt>
											<dd class="col-md-10 col-sm-9">
												${resultView.PROCESS_DATE }
											</dd>
										</dl>
										<dl class="clearfix ">
											<dt class="col-md-2 col-sm-3">처리자</dt>
											<dd class="col-md-10 col-sm-9">
												${resultView.PROCESS_REG_NM }
											</dd>
										</dl>
										<dl class="clearfix ">
											<dt class="col-md-2 col-sm-3">발생위치</dt>
											<dd class="col-md-10 col-sm-9">
												${resultView.ERROR_LOCATION }
											</dd>
										</dl>
										<dl class="clearfix ">
											<dt class="col-md-2 col-sm-3">메세지</dt>
											<dd class="col-md-10 col-sm-9">
												${resultView.ERROR_MESSAGE }
											</dd>
										</dl>
										<dl class="clearfix ">
											<dt class="col-md-2 col-sm-3">내용</dt>
											<dd class="col-md-10 col-sm-9">
												<pre>${resultView.PROCESS_CONTENT }</pre>
											</dd>
										</dl>
									</li>
								</ul>
									<p class="clearfix">
					  			  <span class="pull-right"><input class="btn btn-default btn-list"  type="button" value="목록" /></span>
									</p>
							</div>
							</div>
						</form>
					

				
				</div>
				<jsp:include page="/resources/com/inc/aside.jsp" />
			</section>
		</div>
		<jsp:include page="/resources/com/inc/footer.jsp" />
	</div>
	
	<!-- js파일 및 공통스크립트사용 -->
	<jsp:include page="/resources/com/inc/javascript.jsp" />
	
	<script type="text/javascript">
		$(document).ready(function() {
			/* 목록 */
			$( ".btn-list" ).click(function() {
				goList();
			});
		});
		
		/* 목록이동 */
		function goList(){
			$("#frm1").attr("action", "${pageContext.request.contextPath}/sys/err/err01List.do");
			$("#frm1").submit();
		}
		/*********************************************************************************
		* function명   : fnTabMove
		* function기능 : 탭이동
		**********************************************************************************/
		function fnTabMove(href,pm1){
			document.frm1.action = "<%=request.getContextPath() %>/"+href;
			document.frm1.menu_id3.value = pm1;
			document.frm1.submit();
			
		}
	
	</script>
</body>
</html>