<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"  %>
<html>
<head>
<jsp:include page="/resources/com/inc/meta.jsp" />
<title>Letech Intranet</title>
<link href="<%=request.getContextPath()%>/resources/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/dataTables.bootstrap.min.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/dataTables.responsive.css" rel="stylesheet">
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.print.css' rel='stylesheet' media='print' />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<%-- <script src="<%=request.getContextPath()%>/resources/js/bootstrap.min.js"></script> --%>
<link href="${pageContext.request.contextPath}/resources/js/css/ui-lightness/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" >

<script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-code-snippet.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-dom.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-time-picker.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-date-picker.js"></script>
<link href="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-time-picker.css" rel="stylesheet" >
<link href="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-date-picker.css" rel="stylesheet" >
</head>
<style>
	.form-group{padding-left: 0px; padding-right: 0px;}
	.req-sign{color: red; font-size: 18px;}
	.tmp-pay-tb-header{font-size: 12px;}
	.req-sign-tb{color: red; font-size: 15px;}
</style>
<body>
	<div id="wrapper">
		<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
			<jsp:include page="/resources/com/inc/header.jsp" />
			<jsp:include page="/WEB-INF/views/letech/com/layout/menu.jsp" />
		</nav>
		<div id="page-wrapper">
			<div class="row">	
				<div class="col-lg-10">
					<form name="frm1" id="frm1" method="get" action="${pageContext.request.contextPath}/sys/sch/sch00List.do" >
						<!-- 타이틀 및 페이지 네비 -->
						<h2 class="page-title clearfix">
							${titleNaviMap.MN_NM }
							<span class="pull-right site-map">
								HOME > ${titleNaviMap.NAVI_NM }
							</span>
						</h2>
						
						<div class="form-container">
							<div class="board-write row">
								<!-- 배치명 -->
								<div class="col-lg-12 form-group">
									<div class="col-lg-2 col-sm-2 text-right">
										<label class="control-label">배치명</label>
									</div>
									<div class="col-lg-9">
										<c:if test="${params.flag eq 2}">
											<div>배치명</div>
										</c:if>
										<c:if test="${params.flag eq 3}">
											<input class="form-control" type="text" id="title" name="title"/>
										</c:if>
									</div>
								</div> <!-- 배치명 끝 -->
								
								<!-- 배치프로그램 -->
								<div class="col-lg-12 form-group">
									<div class="col-lg-2 col-sm-2 text-right">
										<label class="control-label">배치프로그램</label>
									</div>
									<div class="col-lg-9">
										<c:if test="${params.flag eq 2}">
											<div>배치프로그램</div>
										</c:if>
										<c:if test="${params.flag eq 3}">
											<input class="form-control" type="text" id="program" name="program"/>
										</c:if>
									</div>
								</div> <!-- 배치프로그램 끝 -->
							
								<!-- 배치 상세설명 -->
								<div class="col-lg-12 form-group">
									<div class="col-lg-2 col-sm-2 text-right">
										<label class="control-label">상세설명</label>
									</div>
									<div class="col-lg-9">
										<c:if test="${params.flag eq 2}">
											<div>상세설명</div>
										</c:if>
										<c:if test="${params.flag eq 3}">
											<textarea class="form-control" name="dtil_cont" id="dtil_cont"></textarea>
										</c:if>
									</div>
								</div><!-- 배치 상세설명 -->
								
								<!-- 등록일 -->
								<div class="col-lg-12 form-group">
									<div class="col-lg-2 col-sm-2 text-right">
										<label class="control-label">등록일</label>
									</div>
									<div class="col-lg-9">
										<c:if test="${params.flag eq 2}">
											<div>2021-03-22</div>
										</c:if>
										<c:if test="${params.flag eq 3}">
											<div style="width: 165px;" class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
												<input id="reg_dt"  name="reg_dt" type="text" aria-label="Date-Time" autocomplete="off"> <span class="tui-ico-date"></span>
												<div id="startpicker-container" style="margin-left: -1px;"></div>
											</div>
										</c:if>
									</div>
								</div> <!-- 등록일 끝 -->
								
								<!-- 배치주기 -->
								<div class="col-lg-12 form-group">
									<div class="col-lg-2 col-sm-2 text-right">
									<label class="control-label">배치주기</label>
									</div>
									<div class="col-lg-9">
										<p>배치주기 설명</p>
									</div>
								</div>
								<div class="col-lg-12 form-group">
									<div class="col-lg-2 col-sm-2 text-right">
									</div>
									<div class="table-responsive col-lg-9">
									<!-- 테이블 -->
										<table class="table table-bordered">
											<caption>배치주기등록</caption>
											<colgroup>
												<col width="16.6%" />
												<col width="*" />
												<col width="16.6%" />
												<col width="16.6%" />
												<col width="16.6%" />
												<col width="16.6%" />
											</colgroup>
											<thead class="table-secondary">
												<tr class="table-secondary">
													<th>초</th>
													<th>분</th>
													<th>시</th>
													<th>일</th>
													<th>월</th>
													<th>년</th>
												</tr>
											</thead>
											<tbody>
												<c:if test="${params.flag eq 2}">
													<tr>
														<td align="center">*</td>
														<td align="center">*</td>
														<td align="center">*</td>
														<td align="center">*</td>
														<td align="center">*</td>
														<td align="center">*</td>
													</tr>
												</c:if>
												<c:if test="${params.flag eq 3}">
													<tr>
														<td align="center"><input class="form-control" type="text" id="sec" name="sec"/></td>
														<td align="center"><input class="form-control" type="text" id="min" name="min"/></td>
														<td align="center"><input class="form-control" type="text" id="hour" name="hour"/></td>
														<td align="center"><input class="form-control" type="text" id="day" name="day"/></td>
														<td align="center"><input class="form-control" type="text" id="mon" name="mon"/></td>
														<td align="center"><input class="form-control" type="text" id="year" name="year"/></td>
													</tr>
												</c:if>
											</tbody>
										</table>
									</div><!-- table 끝 -->
								</div> <!-- 배치주기 끝 -->
				
								<!--
								<div class="col-lg-12 form-group">
									<div class="col-lg-3 col-sm-1 text-right">
										<button type="button" class="btn btn-info">수동실행</button>
										<button type="button" class="btn btn-info">활성화 / 비활성화</button>
									</div>
								</div>
								-->
								
								<!-- 이력조회 -->
								<div class="col-lg-12 form-group">
									<div class="col-lg-2 col-sm-1 text-right">
										<label class="control-label">이력조회</label>
									</div>
									<div class="col-lg-9 text-right">
										<button type="button" class="btn btn-info">수동실행</button>
										<button type="button" class="btn btn-info">활성화 / 비활성화</button>
									</div>
								</div>
								
								<!-- 이력조회 테이블 -->
								<div class="col-lg-12 form-group">
									<div class="col-lg-2 col-sm-2 text-right">
									</div>
									<div class="table-responsive col-lg-9">
									<!-- 테이블 -->
										<table class="table table-bordered">
											<caption>그룹별급수 정보관리</caption>
											<colgroup>
												<col width="10%" />
												<col width="*" />
												<col width="15%" />
												<col width="20%" />
												<col width="20%" />
											</colgroup>
											<thead>
												<tr>
													<th>순번</th>
													<th>실행일</th>
													<th>결과</th>
													<th>대상건 수</th>
													<th>처리건 수</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td align="center">1</td>
													<td align="center">비즈플레이</td>
													<td align="center">2020.12.01</td>
													<td align="center">20222.03.02</td>
													<td align="center">* * * * * *</td>
												</tr>
											</tbody>
										</table>
									</div><!-- table 끝 -->
								</div><!-- 이력조회 끝 -->
								
								<div class="col-lg-12 form-group">
									<div class="col-lg-2 col-sm-2 text-left">
									</div>
									<div class="table-responsive col-lg-9 text-right">
										<span>
											<c:if test="${params.flag eq 2}">
												<input type="button" id="btn-list" name="btn-list" class="btn btn-sm btn-default " value="목록" onclick="javascript:self.location='sch00List.do'"/>
											</c:if>
											<c:if test="${params.flag eq 3}">
												<input type="button" id="btn-list" name="btn-list" class="btn btn-sm btn-default " value="취소" onclick="history.go(-1)"/>
											</c:if>
											<input type="button" id="btn-modify" name="btn-modify" onclick="btnModify()" class="btn btn-sm btn-info" value="수정"/>
											<input type="button" id="btn-del" name="btn-del" onclick="btnOk()" class="btn btn-sm btn-info" value="삭제"/><!-- 비활성화 -->
										</span>
									</div>
								</div>
								
								<p class="clearfix"/>

							</div> <!-- board-write row 끝 -->
					
						</div> <!-- container 끝 -->
					
					</form>
				</div>
				<jsp:include page="/resources/com/inc/aside.jsp" />
			</div><!-- div row 끝 -->
		</div><!-- div page-wrapper 끝 -->
		<jsp:include page="/resources/com/inc/footer.jsp" />
	</div><!-- div wrapper 끝 -->
	
<script type="text/javascript">

$(function(){
	
/* toast date */
var datepicker = new tui.DatePicker('#startpicker-container', {
						date 	: new Date(),
						input 	: {
							element : '#reg_dt',
							format	: 'yyyy-MM-dd'
						}
					});
})

/* 저장 */
function btnOk() {
	alert('등록');
//	$("#frm1").submit();
	location.href = "sch00List.do";
}

/* 수정 */
function btnModify() {
	location.href = "sch00View.do?flag=3";
}

</script>
</body>
</html>