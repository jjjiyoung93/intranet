<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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
<link href="${pageContext.request.contextPath}/resources/js/css/ui-lightness/jquery-ui-1.9.2.custom.min.css" rel="stylesheet">

<script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-code-snippet.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-dom.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-time-picker.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-date-picker.js"></script>
<link href="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-time-picker.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-date-picker.css" rel="stylesheet">
</head>
<style>
body {
	background-color: white;
	height: 100%;
}

body>#wrapper {
	height: 100%;
}

.form-group {
	padding-left: 0px;
	padding-right: 0px;
}

.req-sign {
	color: red;
	font-size: 18px;
}

.tmp-pay-tb-header {
	font-size: 12px;
}

.req-sign-tb {
	color: red;
	font-size: 15px;
}

body .form-container .row div {
	vertical-align: middle;
}

.form-container .form-group input {
	text-align: center;
	vertical-align: middle;
}

.form-group p {
	vertical-align: middle;
	text-align: center;
}

.form-group:not(.fuelType) label.control-label {
	padding-top: 9px;
	padding-bottom: 4px;
	background: lightgray;
	text-align: center;
}

#depreciation-div .form-group {
	margin-bottom: 0px;
}

#depreciation-div .form-group p {
	margin-bottom: 10px;
}
</style>
<body>
	<div id="wrapper">
		<div class="container">
			<form class="form-horizontal" name="frm1" id="frm1" method="post">
				<input type="hidden" id="menu_id1" name="menu_id1" value="MN0013">
				<input type="hidden" id="menu_id2" name="menu_id2" value="MN0014">
				<input type="hidden" id="mode" name="mode" value="">
				<input type="hidden" id="aprv_no" name="aprv_no" value="">
				<input type="hidden" id="line_chk" name="line_chk" value="">
				<input type="hidden" id="aprv_line_cd" name="aprv_line_cd" value="">
				<!-- 검색 정보 Start -->
				<input type="hidden" name="cPage" id="cPage" value="1">
				<input type="hidden" id="searchCdList1" name="searchCdList1" value="">
				<input type="hidden" id="searchCdList2" name="searchCdList2" value="">
				<input type="hidden" id="searchCdList3" name="searchCdList3" value="3">
				<input type="hidden" id="searchCdList4" name="searchCdList4" value="">
				<input type="hidden" id="searchCdList5" name="searchCdList5" value="">
				<input type="hidden" id="searchCdList6" name="searchCdList6" value="">
				<input type="hidden" id="myAprvList" name="myAprvList" value="">
				<input type="hidden" id="searchGubun" name="searchGubun" value="01">
				<input type="hidden" id="searchField" name="searchField" value="">
				<input type="hidden" id="searchField2" name="searchField2" value="">
				<input type="hidden" id="searchField3" name="searchField3" value="">
				<input type="hidden" id="listCnt" name="listCnt" value="10">
				<!-- 검색 정보 End -->

				<input type="hidden" id="cal_no" name="cal_no" value="">

				<input type="hidden" id="term_st_ym" name="term_st_ym" value="">
				<input type="hidden" id="term_ed_ym" name="term_ed_ym" value="">
				<input type="hidden" id="term_st_hm" name="term_st_hm" value="">
				<input type="hidden" id="term_ed_hm" name="term_ed_hm" value="">

				<input type="hidden" name="stDtSrch" value="">
				<input type="hidden" name="edDtSrch" value="">

				<input type="hidden" name="tmpPayItemList[0].cd1" value="">

				<h2 class="page-title clearfix">
					유류비관리
					<span class="pull-right site-map"> HOME &gt; 결재관리 &gt; 결재관리 </span>
				</h2>
				<div class="form-container">
					<!-- 적용일자 START -->
					<div class="section">
						<div class="row form-group">
							<label class="col-sm-2 control-label" for="effectiveDate">적용일자</label>
							<div class="col-sm-9 row" id="effectiveDate">
								<div class="col-sm-5">
									<p class="h4">2024.07.01</p>
								</div>
								<div class="col-sm-2 text-center vh-100">
									<p class="h4">~</p>
								</div>
								<div class="col-sm-5">
									<p class="h4">9999.12.31</p>
								</div>
							</div>
						</div>
					</div>
					<!-- 적용일자 END -->
					<!-- 전귝유가 평균 START -->
					<div class="section">
						<div class="form-group row">
							<label for="nopFuelType" class="col-sm-2 control-label">전국유가 평균</label>
						</div>
						<div id="nopFuelType">
							<div class="form-group row fuelType">
								<label class="col-sm-2 control-label" for="nopUnlead">무연</label>
								<div class="col-sm-3">
									<p class="h4">1670 원</p>
								</div>
							</div>
							<div class="form-group row fuelType">
								<label class="col-sm-2 control-label" for="nopVia">경유</label>
								<div class="col-sm-3">
									<p class="h4">1480 원</p>
								</div>
							</div>
							<div class="form-group row fuelType">
								<label class="col-sm-2 control-label" for="nopLPG">LPG</label>
								<div class="col-sm-3">
									<p class="h4">1000 원</p>
								</div>
							</div>
						</div>
					</div>
					<!-- 전귝유가 평균 END -->
					<!-- 유종별 연비 START -->
					<div class="section">
						<div class="form-group row">
							<label class="col-sm-2 control-label" for="flcoType">유종별 연비</label>
						</div>
						<div id="fleff">
							<div class="form-group row fuelType">
								<label class="col-sm-2 control-label" for="fleffUnlead">무연</label>
								<div class="col-sm-3">
									<p class="h4">13.0</p>
								</div>
							</div>
							<div class="form-group row fuelType">
								<label class="col-sm-2 control-label" for="fleffVia">경유</label>
								<div class="col-sm-3">
									<p class="h4">14.0</p>
								</div>
							</div>
							<div class="form-group row fuelType">
								<label class="col-sm-2 control-label" for="fleffLPG">LPG</label>
								<div class="col-sm-3">
									<p class="h4">9.0</p>
								</div>
							</div>
						</div>
					</div>
					<!-- 유종별 연비 END -->
					<!-- 감가상각 START -->
					<div class="section" id="depreciation-div">
						<div class="form-group row">
							<label class="col-sm-2 control-label" for="depreciation">감가상각</label>
							<div id="depreciation">
								<div class="col-sm-3">
									<p class="h4">1670</p>
								</div>
								<div class="col-sm-1 text-center vh-100">
									<p class="h4">X</p>
								</div>
								<div class="col-sm-2">
									<p class="h4">30%</p>
								</div>
								<div class="col-sm-1 text-center vh-100">
									<p class="h4">=</p>
								</div>
								<div class="col-sm-3">
									<p class="h4">40</p>
								</div>
							</div>
						</div>
					</div>
					<!-- 감가상각 END -->
					<!-- 감가상각 Km당 가격 -->
					<div class="section">
						<div class="form-group row">
							<label class="col-sm-2 control-label" id="kmPer">Km당 가격</label>
						</div>
						<div id="kmPer">
							<div class="form-group row fuelType">
								<label class="col-sm-2 control-label control-label" for="kmPerUnlead">무연</label>
								<div class="col-sm-3">
									<p class="h4">170.00 원</p>
								</div>
							</div>
							<div class="form-group row fuelType">
								<label class="col-sm-2 control-label control-label" for="kmPerVia">경유</label>
								<div class="col-sm-3">
									<p class="h4">150.00 원</p>
								</div>
							</div>
							<div class="form-group row fuelType">
								<label class="col-sm-2 control-label control-label" for="kmPerLPG">LPG</label>
								<div class="col-sm-3">
									<p class="h4">160.00 원</p>
								</div>
							</div>
						</div>
					</div>
					<!-- 감가상각 Km당 가격 -->
					<div class="row col-lg-12">
						<span class="pull-right">
							<input type="button" id="btn-tran" name="btn-ok" class="btn btn-sm btn-info" value="수정">
							<input type="button" id="btn-del" name="btn-ok" class="btn btn-sm btn-info" value="삭제">
							<input type="button" id="btn-cancel" name="btn-cancel" class="btn btn-sm btn-default " value="취소" onclick="javascript:self.close()">
						</span>
					</div>
					<p class="clearfix"></p>
				</div>
			</form>
		</div>
	</div>
	<!-- js파일 및 공통스크립트사용 -->
	<jsp:include page="/resources/com/inc/javascript.jsp" />
	<script type="text/javascript">
		$('#btn-tran').on('click', function(){
			$("#mode").val("<%=VarConsts.MODE_U%>");
			$("#frm1").attr("action", "${pageContext.request.contextPath}/flco/flco00Form.do");
			$("#frm1").submit();
		});
	</script>
</body>
</html>