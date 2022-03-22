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
			<%@ include file="/WEB-INF/views/letech/com/layout/menu.jsp" %>
		</nav>
		<div id="page-wrapper">
			<div class="row">	
				<div class="col-lg-10">
					<form name="form1" id="form1" method="post" action="<%=request.getContextPath()%>/sys/sch/sch00List.do" >
						<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}" />
						<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}" />
						<input type="hidden" id="menu_id3" name="menu_id3" value="${params.menu_id3}" />
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
										<input class="form-control" type="text" id="title" name="title"/>
									</div>
								</div> <!-- 배치명 끝 -->
								
								<!-- 배치프로그램 -->
								<div class="col-lg-12 form-group">
									<div class="col-lg-2 col-sm-2 text-right">
										<label class="control-label">배치프로그램</label>
									</div>
									<div class="col-lg-9">
										<input class="form-control" type="text" id="program" name="program"/>
									</div>
								</div> <!-- 배치프로그램 끝 -->
							
								<!-- 배치 상세설명 -->
								<div class="col-lg-12 form-group">
									<div class="col-lg-2 col-sm-2 text-right">
										<label class="control-label">상세설명</label>
									</div>
									<div class="col-lg-9">
										<textarea class="form-control" name="dtil_cont" id="dtil_cont"></textarea>
									</div>
								</div><!-- 배치 상세설명 -->
								
								<!-- 등록일 -->
								<div class="col-lg-12 form-group">
									<div class="col-lg-2 col-sm-2 text-right">
										<label class="control-label">등록일</label>
									</div>
									<div class="col-lg-9">
										<div style="width: 165px;" class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
											<input id="reg_dt"  name="reg_dt" type="text" aria-label="Date-Time" autocomplete="off"> <span class="tui-ico-date"></span>
											<div id="startpicker-container" style="margin-left: -1px;"></div>
										</div>
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
												<tr>
													<td align="center"><input class="form-control" type="text" id="sec" name="sec"  placeholder="0~59, - * /"/></td>
													<td align="center"><input class="form-control" type="text" id="min" name="min"  placeholder="0~59, - * /" /></td>
													<td align="center"><input class="form-control" type="text" id="hour" name="hour"placeholder="0~23, - * /" /></td>
													<td align="center"><input class="form-control" type="text" id="day" name="day"  placeholder="1~31, - * ? / L W" /></td>
													<td align="center"><input class="form-control" type="text" id="mon" name="mon"  placeholder="" /></td>
													<td align="center"><input class="form-control" type="text" id="year" name="year"placeholder="" /></td>
												</tr>
											</tbody>
										</table>
									</div><!-- table 끝 -->
								</div> <!-- 배치주기 끝 -->
								
								<div class="col-lg-12 form-group">
									<div class="col-lg-2 col-sm-2 text-right">
									</div>
									<div class="table-responsive col-lg-9 text-right">
										<span>
											<input type="button" id="btn-ok" name="btn-ok" onclick="btnOk()" class="btn btn-sm btn-info" value="등록"/>
											<input type="button" id="btn-cancel" name="btn-cancel" class="btn btn-sm btn-default " value="취소"/>
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
							language: 'ko',		//한글 지원
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

/* 취소 */
$("#btn-cancel").click(function(){
	$("#form1").attr("action", "${pageContext.request.contextPath}/sys/sch/sch00List.do");
	$("#form1").submit();
});

</script>
</body>
</html>