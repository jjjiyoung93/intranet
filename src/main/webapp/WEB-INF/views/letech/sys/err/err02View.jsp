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
<link href="${pageContext.request.contextPath}/resources/js/css/ui-lightness/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" >
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
					<div class="form-container">
						<!-- 수정본 -->
						<div class="board-view">
							<form name="frm1" id="frm1" method="post" action="<%=request.getContextPath()%>/sys/err/err00List.do" >
								<input type="hidden" id="mode" name="mode" value="${params.mode }"/>
								<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}"/>
								<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}"/>
								<input type="hidden" id="menu_id3" name="menu_id3" value="${params.menu_id3}"/>
								<input type="hidden" name="cPage" id="cPage" value="" />
								<input type="hidden" name="error_seq" id="error_seq" value="${resultView.ERROR_SEQ }" />
								
								<ul class="payment-form">
									<li>
										<dl class="clearfix first-line ">
											<dt class="col-md-2 col-xs-2">로거</dt>
											<dd class="col-md-10 col-xs-10">
												kr.letech.cmm.util.EgovProperties
											</dd>
										</dl>
										<dl class="clearfix ">
											<dt class="col-md-2 col-xs-2">메소드</dt>
											<dd class="col-md-10 col-xs-10">
												insertBizplayData
											</dd>
										</dl>
										<dl class="clearfix ">
											<dt class="col-md-2 col-xs-2">발생일</dt>
											<dd class="col-md-10 col-xs-10">
												2022-03-03 10:17:39.0
											</dd>
										</dl>
										<dl class="clearfix ">
											<dt class="col-md-2 col-xs-2">발생위치</dt>
											<dd class="col-md-10 col-xs-10">
												일정관리
											</dd>
										</dl>
										<dl class="clearfix ">
											<dt class="col-md-2 col-xs-2">에러위치</dt>
											<dd class="col-md-10 col-xs-10">
												kr.letech.aprv.service.impl.AprvMngServiceImpl.insertBizplayData(AprvMngServiceImpl.java:1138)
											</dd>
										</dl>
										<dl class="clearfix ">
											<dt class="col-md-2 col-xs-2">에러유형</dt>
											<dd class="col-md-10 col-xs-10">
												SQLException
											</dd>
										</dl>
										<dl class="clearfix ">
											<dt class="col-md-2 col-xs-2">메시지</dt>
											<dd class="col-md-10 col-xs-10" style="overflow:hidden; word-wrap:break-word;">
												[BIZPLAY] API 호출 실패 =>https://webankapi.appplay.co.kr/gateway.do?JSONData=%7B%22API_ID%22:%220411A%22,%22API_KEY%22:%22b10b7fb2-dccc-1657-bde8-b580cbc48355%22,%22ORG_CD%22:%226298800134%22,%22REQ_DATA%22:%7B%22BIZ_NO%22:%226298800134%22,%22CARD_NO%22:%22%22,%22START_DATE%22:%221%22,%22START_TIME%22:%22%22,%22END_DATE%22:%221%22,%22END_TIME%22:%22%22,%22RCV_STS%22:%22%22,%22REQ_CNT%22:%22%22,%22NEXT_KEY%22:%22%22,%22REQ_ATTIMG_YN%22:%22Y%22%7D%7D
											</dd>
										</dl>
										<dl class="clearfix ">
											<dt class="col-md-2 col-xs-2">내용</dt>
							            		<dd class="col-md-10 col-xs-10">
							            			<pre></pre>
							            		</dd>
										</dl>
									</li>
								</ul>
								<p class="clearfix">
									<input class="btn btn-default btn-sm btn-list"  type="button" value="목록" />
									<span class="pull-right">
										<c:choose>
			            	<c:when test="${params.mode eq 'edit'}">
			            		<input class="btn btn-warning btn-sm btn-completion" type="button" value="완료" />
											<input class="btn btn-warning btn-sm btn-save" type="button" value="저장" />
			            	</c:when>
			            	<c:otherwise>
			            		<input class="btn btn-warning btn-sm btn-process" type="button" value="처리" />
			            	</c:otherwise>
			            </c:choose>
									</span>
								</p>
						</form>
					</div>
				</div>					
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
			
			/* 완료 */
			$( ".btn-completion" ).click(function() {
				fnProcess("INSERT");
			});
			
			/* 저장 */
			$( ".btn-save" ).click(function() {
				fnProcess("UPDATE");
			});
			
			/* 처리 */
			$( ".btn-process" ).click(function() {
				fnEdit();
			});
		});
		
		/* 목록이동 */
		function goList(){
			$("#frm1").attr("action", "${pageContext.request.contextPath}/sys/err/err00List.do");
			$("#frm1").submit();
		}
		
		/* 조회화면 */
		function fnView(){
			$("#mode").val("view");
			$("#frm1").attr("action", "${pageContext.request.contextPath}/sys/err/err00View.do");
			$("#frm1").submit();
		}
		
		/* 작성화면 */
		function fnEdit(){
			$("#mode").val("edit");
			$("#frm1").attr("action", "${pageContext.request.contextPath}/sys/err/err00View.do");
			$("#frm1").submit();
		}
		
		/* 처리화면 */
		function fnProcess(mode){
			$("#mode").val(mode);
			var content = $("#process_content").val();
			var check_val = content.trim();
			
			if(check_val == null || check_val == ""){
				$("#process_content").focus();
				alert("내용을 입력해주세요.");
				return false;
			}
			
			$("#frm1").attr("action", "${pageContext.request.contextPath}/sys/err/err00Tran.do");
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