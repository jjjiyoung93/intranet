<!doctype html>
<%@page import="java.util.Date"%>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
	<jsp:include page="/resources/com/inc/meta.jsp" />
	<title>Letech Intranet</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
	<script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-code-snippet.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-dom.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-time-picker.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-date-picker.js"></script>
	<link href="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-time-picker.css" rel="stylesheet" >
	<link href="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-date-picker.css" rel="stylesheet" >
	
	<link href="<%=request.getContextPath()%>/resources/css/bootstrap.min.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/resources/css/dataTables.bootstrap.min.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/resources/css/dataTables.responsive.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
	<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.css' rel='stylesheet' />
	<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.print.css' rel='stylesheet' media='print' />
	<%-- <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css"> --%>
	<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
	<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/bootstrap.min.js"></script>
	<link href="https://unpkg.com/bootstrap-table@1.19.1/dist/bootstrap-table.min.css" rel="stylesheet">
	
	<style type="text/css">
		th.tb-col-title {
			border-bottom: solid;
			border-bottom-color: #ddd;
			vertical-align: middle !important; 
		}
		
		td.tb-col-title{
			text-align: center;
		}
		
		.th-inner{
			vertical-align: middle !important; 
		}
	</style>


</head>

<body>
	<div id="wrapper">
		<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
			<jsp:include page="/resources/com/inc/header.jsp" />
			<%@ include file="/WEB-INF/views/letech/com/layout/menu.jsp" %>
		</nav>
		<div id="page-wrapper">
			<section class="row">
				<div class="col-lg-10">
				<!-- 오늘 날짜 세팅  -->
				<c:set var="today" value="<%=new Date() %>"/>
				<!-- 금년도  -->
				<c:set var="year"><fmt:formatDate value="${today}" pattern="yyyy"/></c:set>
				<!-- page -->
					<form name="frm1" id="frm1" method="post" action="${pageContext.request.contextPath}/sys/vct/vctStatf00List.do" >
						<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}" />
						<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}" />
						<input type="hidden" id="cPage" name="cPage" value="${cPage }" />
						<!-- 타이틀 및 페이지 네비 -->
								<h2 class="page-title clearfix">
								${titleNaviMap.MN_NM }
								<span class="pull-right site-map">
									HOME > ${titleNaviMap.NAVI_NM }
								</span>
							</h2>
							<div class="form-container">
								<div class="clearfix search-box">
									<input type="hidden" name="uss_id" id="uss_id" value=""/>
									<%-- <div class="row">
										<div class ="col-xs-6 un-style">
											<!-- 기준년도(년도 선택), 재직구분  -->
											<!-- <div class="col-xs-6 un-style"> -->
												<div class="inline-element col-xs-11">
													<label>기준년도</label>
													<div class="tui-datepicker-input tui-datetime-input tui-has-focus">
														<input type="text" id="datepicker-input-ko" name="searchGubun2" value="${params.searchGubun2}" aria-label="Date" class="form-control" title="search">											
														<span class="tui-ico-date"></span>
													</div>
													<div class="datepicker-cell" id="datepicker-year-ko"></div>
												</div>
										
										</div>
										<div class ="col-xs-6 un-style">
											<!-- ID/성명 검색  -->
										
												<div class="col-xs-12">
													<label>ID/성명</label>
													<div class ="col-xs-3 un-style">
														<span class="inline-element">
															<select name="searchGubun" id="searchGubun" class="form-control" title="search" >
																<option value="01" <c:if test="${params.searchGubun == '01'}">selected = "selected"</c:if>>ID</option>
																<option value="02" <c:if test="${params.searchGubun == '02'}">selected = "selected"</c:if>>성명</option>
															</select>
														</span>
													</div>
													<div class="col-xs-8 un-style">
														<div class="input-group">
															<input type="text" name="searchField" id="searchField"  value="${params.searchField}" class="form-control" title="검색어 입력" />
															<span class="input-group-btn">
																<button type="button" class="fnSearch btn-info btn"  >
																	<i class="glyphicon glyphicon-search"></i><span class="hidden-xs hidden-sm"> 검색</span>
																</button>
															</span>
														</div>
													</div>
												</div>
										</div>
									</div>
										<div class="row">
											<div class ="col-xs-6 un-style">
												<span class="inline-element col-xs-11">
													<label>고용구분</label>
													<select name="searchGubun4" id="searchGubun4" class="form-control" title="search" >
														<option value="" >전체</option>
														<c:forEach var="empType" items="${empTypeList}">
															<option value="${empType.CD}" <c:if test="${empType.CD eq params.searchGubun4 }">selected="selected"</c:if> >${empType.CD_NM}</option>
														</c:forEach>
													</select>
												</span>
											</div>
											<div class ="col-xs-6 un-style">
												<span class="inline-element col-xs-11">
													<label >재직구분</label>
													<select name="searchGubun3" id="searchGubun3" class="form-control" title="search" >
														<option value="" >전체</option>
														<option value="N" <c:if test="${params.searchGubun3 == 'N'}">selected = "selected "</c:if>>재직</option>
														<option value="Y" <c:if test="${params.searchGubun3 == 'Y'}">selected = "selected"</c:if>>퇴직</option>
													</select>
												</span>
											</div>
											
										</div>
										<div class="row">
											<div class ="col-xs-6 un-style">
												<span class="inline-element col-xs-11">
													<label>프로젝트</label>
													<select name="searchGubun6" id="searchGubun6" class="form-control" title="search" >
														<option value="" >전체</option>
														<c:forEach var="proj" items="${projList}" varStatus="status">
															<option value="${proj.CD}" <c:if test="${proj.CD eq params.searchGubun6 }">selected="selected"</c:if> >${proj.CD_NM}</option>
														</c:forEach>
													</select>
													
												</span>
											</div>
											<div class ="col-xs-6 un-style">
												<span class="inline-element col-xs-11">
													<label>권한</label>
													<select name="searchGubun5" id="searchGubun5" class="form-control" title="search" >
														<option value="" >전체</option>
														<c:forEach var="authList" items="${authList}">
															<option value="${authList.AUTHOR_CODE}" <c:if test="${authList.AUTHOR_CODE eq params.searchGubun5 }">selected="selected"</c:if> >${authList.AUTHOR_NM}</option>
														</c:forEach>
													</select>
												</span>
											</div>
										</div> --%>
										<%-- <div class="row">
											<div class ="col-xs-6 un-style">
												<span class="inline-element col-xs-11">
													<label>휴가구분</label>
													<select name="searchGubun7" id="searchGubun7" class="form-control" title="search" >
														<option value="" >전체</option>
														<c:forEach var="vctType" items="${vctTypeList}" varStatus="status">
															<option value="${vctType.CD}" <c:if test="${vctType.CD eq params.searchGubun7 }">selected="selected"</c:if> >${vctType.CD_NM}</option>
														</c:forEach>
													</select>
													
												</span>
											</div>
											<div class ="col-xs-6 un-style">
												<span class="inline-element col-xs-11">
													<label>권한</label>
													<select name="searchGubun5" id="searchGubun5" class="form-control" title="search" >
														<option value="" >전체</option>
														<c:forEach var="authList" items="${authList}">
															<option value="${authList.AUTHOR_CODE}" <c:if test="${authList.AUTHOR_CODE eq params.searchGubun5 }">selected="selected"</c:if> >${authList.AUTHOR_NM}</option>
														</c:forEach>
													</select>
												</span>
											</div>
										</div> --%>
										
										<!-- 검색조건 restyling  -->
										<div class="row">
											<!-- 기준년도  -->
											<div class="col-lg-6 col-sm-6 col-xs-12 form-inline mt10">
												<div class="inline-element">
													<label>기준년도</label>
													<div class="tui-datepicker-input tui-datetime-input tui-has-focus form-control" style="vertical-align: middle; width:125px;">
														<input type="text" id="datepicker-input-ko" name="searchGubun2" value="${params.searchGubun2}" aria-label="Date" class="" title="search">											
														<span class="tui-ico-date"></span>
													</div>
													<div class="datepicker-cell" id="datepicker-year-ko"></div>
												</div>
											</div>
											<!-- 고용구분  -->
											<div class="col-lg-6 col-sm-6 col-xs-12 form-inline mt10" >
												<div class="inline-element">
													<label>고용구분</label>
													<select name="searchGubun4" id="searchGubun4" class="form-control" style="width: 125px;" title="search" >
														<option value="" >전체</option>
														<c:forEach var="empType" items="${empTypeList}">
															<option value="${empType.CD}" <c:if test="${empType.CD eq params.searchGubun4 }">selected="selected"</c:if> >${empType.CD_NM}</option>
														</c:forEach>
													</select>
												
												</div>
											</div>
											<!-- 재직구분  -->
											<div class="col-lg-6 col-sm-6 col-xs-12 form-inline mt10" >
												<div class="inline-element">
													<label >재직구분</label>
													<select name="searchGubun3" id="searchGubun3" class="form-control" style="width: 125px;" title="search" >
														<option value="" >전체</option>
														<option value="N" <c:if test="${params.searchGubun3 == 'N'}">selected = "selected "</c:if>>재직</option>
														<option value="Y" <c:if test="${params.searchGubun3 == 'Y'}">selected = "selected"</c:if>>퇴직</option>
													</select>
												</div>
											</div>
											<!-- 직급권한  -->
											<div class="col-lg-6 col-sm-6 col-xs-12 form-inline mt10" >
												<div class="inline-element">
													<label>직급권한</label>
													<select name="searchGubun5" id="searchGubun5" class="form-control" style="width: 125px;" title="search" >
														<option value="" >전체</option>
														<c:forEach var="authList" items="${authList}">
															<option value="${authList.AUTHOR_CODE}" <c:if test="${authList.AUTHOR_CODE eq params.searchGubun5 }">selected="selected"</c:if> >${authList.AUTHOR_NM}</option>
														</c:forEach>
													</select>
												</div>
											</div>
											<!-- 프로젝트  -->
											<div class="col-lg-6 col-sm-12 col-xs-12 form-inline mt10" >
												<div class="inline-element">
													<label>프로젝트</label>
													<select name="searchGubun6" id="searchGubun6" class="form-control" style="width: 250px;" title="search" >
														<option value="" >전체</option>
														<c:forEach var="proj" items="${projList}" varStatus="status">
															<option value="${proj.CD}" <c:if test="${proj.CD eq params.searchGubun6 }">selected="selected"</c:if> >${proj.CD_NM}</option>
														</c:forEach>
													</select>
												</div>
											</div>
											
											<!-- id/성명  -->
											<div class="col-lg-6 col-sm-12 col-xs-12 form-inline mt10" >
												<div class="col-lg-12 col-sm-12 col-xs-12" style="padding: 0px;">
													<div class="col-lg-6 col-sm-7 col-xs-7" style="padding : 0px; width:185px;">
														<label>ID / 성명</label>
														<select name="searchGubun" id="searchGubun" class="form-control" style="width: 125px;" title="search" >
																<option value="01" <c:if test="${params.searchGubun == '01'}">selected = "selected"</c:if>>ID</option>
																<option value="02" <c:if test="${params.searchGubun == '02'}">selected = "selected"</c:if>>성명</option>
														</select>
													</div>
													<div class="input-group col-xs-5 col-sm-5 col-lg-5">
														<input type="text" name="searchField" id="searchField"  value="${params.searchField}" class="form-control" title="검색어 입력" />
														<span class="input-group-btn">
															<button type="button" class="fnSearch btn-info btn"  >
																<i class="glyphicon glyphicon-search"></i><span class="hidden-xs hidden-sm"> 검색</span>
															</button>
														</span>
													</div>
												</div>
											</div>
										
										</div>
										
										<!-- 키워드 검색 샘플  -->
										<%-- <div class="search-container">
											<div class="col-xs-5 un-style">
												<span class="inline-element">
													<select class="form-control" name="searchGubun" id="searchGubun" class="" title="search" >
														<option value="01" <c:if test="${params.searchGubun == '01'}">selected = "selected"</c:if>>제목</option>
														<option value="02" <c:if test="${params.searchGubun == '02'}">selected = "selected"</c:if>>내용</option>
													</select>
												</span>
											</div>
											<div class="col-xs-7 un-style">
												<div class="input-group">
													<input type="hidden"/>
													<input type="text" name="searchField" id="searchField"  value="${params.searchField}" class="form-control" title="검색어 입력" />
													<span class="input-group-btn">
														<button class="fnSearch btn btn-info" type="button">
															<i class="glyphicon glyphicon-search"></i>
															<span class="hidden-xs hidden-sm"> 검색</span>
														</button>
													</span>
												</div>
											</div>
										</div> --%>
											
							</div>
							<p class="clearfix board-top">
									
									<br>
									<span class="pull-right">
										<button type="button" id="btnExcl" class="fnExcl btn btn-sm btn-default" >엑셀다운</button>
									</span>
									
									<strong class="list_count" >Total : ${totalCnt} 건</strong>
							</p>
						<div class="table-responsive" id="uss-list">
						
						<table id="table-uss-stat">
						<caption>${params.searchGubun2}년도_휴가현황집계</caption>
							<tr>
								<td style="border: 1px solid; border-color: #ddd;">
									<div style=" height: 500px; width:auto; overflow-y:scroll;">
									<table class="table table-bordered reactive" data-export-data-type="all" id="table-stat" summary="휴가집계">
									<caption>${params.searchGubun2}년도_직원별휴가현황집계</caption>
											<colgroup>
												<col width="3%" />
												<col width="5%" />
												<col width="5%" />
												<col width="5%" />
												<col width="5%" />
												<col width="5%" />
												<col width="8%" />
												<col width="8%" />
												<col width="5%" />
												<col width="5%" />
												<col width="5%" />
												<col width="5%" />
												<col width="5%" />
												<col width="5%" />
												<col width="5%" />
												<col width="5%" />
												<col width="5%" />
												<col width="5%" />
												<col width="5%" />
												<col width="5%" />
											</colgroup>
												<thead>
													<tr>
														<th class="text-center tb-col-title" rowspan="2" style="vertical-align: middle;">번호</th>
														<th class="tb-col-title align-middle" rowspan="2" style="vertical-align: middle;">년도</th>
														<th class="tb-col-title" rowspan="2" style="vertical-align: middle;" data-sortable="true">성명</th>
														<th class="tb-col-title" rowspan="2" style="vertical-align: middle;" data-sortable="true">고용</th>
														<th class="tb-col-title" rowspan="2" style="vertical-align: middle;" data-field="proj" data-tableexport-display="always" data-sortable="true" data-force-export="true">프로젝트</th>
														<th class="tb-col-title" rowspan="2" style="vertical-align: middle;" data-sortable="true">직급</th>
														<th class="tb-col-title" rowspan="2" style="vertical-align: middle;" data-sortable="true">재직</th>
														<th class="tb-col-title" rowspan="2" style="vertical-align: middle;" data-sortable="true">입사일</th>
														<th class="tb-col-title" rowspan="2" style="vertical-align: middle;" data-sortable="true">퇴사일</th>
														<th class="tb-col-title" rowspan="2" style="vertical-align: middle; border-right: solid; border-right-color: #ddd;" data-sortable="true">근속년</th>
														<c:forEach items="${vctTypeList}" var="vctType">
															<c:choose>
																<c:when test="${vctType.CD == 'CD0001011001'}">
																	<th rowspan="1" colspan="4" style="vertical-align: middle;"><c:out value="${fn:split(vctType.CD_NM, '휴')[0]}"/></th>
																</c:when>
																<c:otherwise>
																	<th rowspan="1" colspan="1" style="vertical-align: middle;"><c:out value="${fn:split(vctType.CD_NM, '휴')[0]}"/></th>
																</c:otherwise>
															</c:choose>
														</c:forEach>
														<th class="tb-col-title" rowspan="2" colspan="1" style="vertical-align: middle; border-left: solid; border-left-color: #ddd;">전체</th>
													</tr>
													<tr>
														<th class="tb-col-title" style="vertical-align: middle;" data-field="grnt_day">부여</th>
														<th class="tb-col-title" style="vertical-align: middle;">사용</th>
														<th class="tb-col-title" style="vertical-align: middle;">잔여</th>
														<th class="tb-col-title" style="vertical-align: middle;">활용률</th>
														<c:forEach items="${vctTypeList }" begin="1" end="${vctTypeList.size() }" step="1">
														<th class="tb-col-title" style="vertical-align: middle;">사용</th>
														
														</c:forEach>
														<!-- <th>사용</th>
														<th>사용</th>
														<th>사용</th>
														<th>사용</th> -->
													</tr>
												</thead>
											<tbody>
												<c:choose>
													<c:when test="${totalCnt < 1 }">
														<tr>
															<td colspan="${13 + fn:length(vctTypeList)}">검색된 내용이 없습니다.</td>
														</tr>
													</c:when>
													<c:otherwise>
														<c:forEach var="list" items="${resultList}" varStatus="status">
															<tr data-id="${list.USS_ID}">
																<th class="text-center" style="vertical-align: middle;">${totalCnt - status.index - ((cPage-1) * (intListCnt))}</th>
																<td align="center" style="vertical-align: middle;">${list.STDD_YR} </td>
																<td align="center" style="vertical-align: middle;">${list.USS_NM}</td>
																<td class="" style="vertical-align: middle;" align="center">${list.EMP_TYPE_NM}</td>
																<td class="" style="vertical-align: middle;" align="center" title="${list.PROJ_NM }" data-force-export="true" data-tableexport-display="always">${list.PROJ_NM }</td>
																<td class="" style="vertical-align: middle;" align="center">${list.REPT_AUTH_NM} </td>
																<td class="" style="vertical-align: middle;" align="center">${list.RTR_YN_NM}</td>
																<td class="" style="vertical-align: middle;" align="center">${list.JOIN_DT}</td>
																<td class="" style="vertical-align: middle;" align="center">${list.RTR_DT}</td>
																<td class="" align="center" style="vertical-align:middle; border-right: solid; border-right-color: #ddd;">${list.WORK_YR_CNT }년</td>
																<td align="center" style="vertical-align: middle;" data-field="grnt_day">${list.YEON_GRNT_DAY }</td>
																<td align="center" style="vertical-align: middle;">${list.YEON_USE_CNT }</td>
																<td align="center" style="vertical-align: middle;">${list.YEON_LEFT_CNT}</td>
																<td align="center" style="vertical-align: middle;">${list.YEON_USE_RATE }</td>
																<td align="center" style="vertical-align: middle;">${list.DISS_USE_CNT }</td>
																<td align="center" style="vertical-align: middle;">${list.FAM_EVNT_USE_CNT }</td>
																<td align="center" style="vertical-align: middle;">${list.REPLC_USE_CNT }</td>
																<td align="center" style="vertical-align: middle;">${list.CMFT_USE_CNT }</td>
																<td align="center" style="vertical-align: middle;">${list.FAM_CARE_USE_CNT }</td>
																<td align="center" style="border-left: solid; border-left-color: #ddd; vertical-align: middle;">${list.VCT_TOT_CNT }</td>
															</tr>
														</c:forEach>
													</c:otherwise>
											</c:choose>
										</tbody>
									</table>
									</div>
								</td>
								
							</tr>
							<tr><td><br></td></tr>
							<tr>
								<td>
									<div>
									<table class="table table-bordered reactive" id="table-stat-avg" summary="휴가집계">
									<caption>${params.searchGubun2}년도_유형별휴가통계</caption>
											<colgroup>
												<col width="10%" />
												<col width="15%" />
												<col width="5%" />
												<col width="5%" />
												<col width="5%" />
												<col width="5%" />
												<col width="5%" />
											</colgroup>
											<thead>
												<tr>
													<!-- <th class="visible-md visible-lg" rowspan="2">번호</th> -->
													<th class="tb-col-title" colspan="2">구분</th>
													<th class="tb-col-title">TOTAL</th>
													<th class="tb-col-title">1분기</th>
													<th class="tb-col-title">2분기</th>
													<th class="tb-col-title">3분기</th>
													<th class="tb-col-title">4분기</th>
													<%-- <th class="visible-md visible-lg" rowspan="2">재직구분</th>
													<th rowspan="2">입사일</th>
													<th rowspan="2">퇴사일</th>
													<th rowspan="2">근속년수(년)</th>
													<c:forEach items="${vctTypeList}" var="vctType">
														<c:choose>
															<c:when test="${vctType.CD == 'CD0001011001'}">
																<th rowspan="1" colspan="4"><c:out value="${vctType.CD_NM}"/></th>
															</c:when>
															<c:otherwise>
																<th rowspan="1" colspan="1"><c:out value="${vctType.CD_NM}"/></th>
															</c:otherwise>
														</c:choose>
													</c:forEach>
													<th rowspan="2" colspan="1">전체</th> --%>
												</tr>
												
											</thead>
											<tbody>
												<c:choose>
													<c:when test="${totalCnt < 1 }">
														<tr>
															<td colspan="7">검색된 내용이 없습니다.</td>
														</tr>
													</c:when>
													<c:otherwise>
														<c:forEach var="avg" items="${avgList}" varStatus="status">
															<c:choose>
																<c:when test="${avg.VCT_TYPE_CD eq 'CD0001011001' }">
																	<tr>
																		<td align="center" rowspan="3" style="vertical-align: middle;">${avg.VCT_TYPE_NM }</td>
																		<td align="center">평균 사용일</td>
																		<td align="center">${avg.TOT_AVG_USE_DAY }</td>
																		<td align="center">${avg.FIR_AVG_USE_DAY }</td>
																		<td align="center">${avg.SEC_AVG_USE_DAY }</td>
																		<td align="center">${avg.THR_AVG_USE_DAY }</td>
																		<td align="center">${avg.FRT_AVG_USE_DAY }</td>
																	</tr>
																	<tr>
																		<td align="center">평균 미사용일</td>
																		<td align="center">${avg.TOT_AVG_LEFT_DAY }</td>
																		<td align="center">${avg.FIR_AVG_LEFT_DAY }</td>
																		<td align="center">${avg.SEC_AVG_LEFT_DAY }</td>
																		<td align="center">${avg.THR_AVG_LEFT_DAY }</td>
																		<td align="center">${avg.FRT_AVG_LEFT_DAY }</td>
																	</tr>
																	<tr>
																		<td align="center">평균 활용률</td>
																		<td align="center">${avg.TOT_AVG_USE_RATE }</td>
																		<td align="center">${avg.FIR_AVG_USE_RATE }</td>
																		<td align="center">${avg.SEC_AVG_USE_RATE }</td>
																		<td align="center">${avg.THR_AVG_USE_RATE }</td>
																		<td align="center">${avg.FRT_AVG_USE_RATE }</td>
																	</tr>
																	
																</c:when>
																<c:otherwise>
																	<tr>
																		<td align="center" style="vertical-align: middle;">${avg.VCT_TYPE_NM }</td>
																		<td align="center">평균 사용일</td>
																		<td align="center">${avg.TOT_AVG_USE_DAY }</td>
																		<td align="center">${avg.FIR_AVG_USE_DAY }</td>
																		<td align="center">${avg.SEC_AVG_USE_DAY }</td>
																		<td align="center">${avg.THR_AVG_USE_DAY }</td>
																		<td align="center">${avg.FRT_AVG_USE_DAY }</td>
																	</tr>
																</c:otherwise>
															</c:choose>
														</c:forEach>
													</c:otherwise>
											</c:choose>
										</tbody>
									</table>
									</div>
								</td>
							</tr>
						</table>
						<%-- <table class="table table-bordered reactive" id="table-stat" summary="휴가집계">
							<colgroup>
								<col width="5%" />
								<col width="5%" />
								<col width="5%" />
								<col width="5%" />
								<col width="5%" />
								<col width="5%" />
								<col width="5%" />
								<col width="5%" />
								<col width="5%" />
								<col width="5%" />
								<col width="5%" />
								<col width="5%" />
								<col width="5%" />
								<col width="5%" />
								<col width="5%" />
								<col width="5%" />
								<col width="5%" />
								<col width="5%" />
								<col width="5%" />
								<col width="5%" />
							</colgroup>
							<thead>
								<tr>
									<th class="visible-md visible-lg" rowspan="2">번호</th>
									<th rowspan="2">기준년도</th>
									<th rowspan="2">성명</th>
									<th rowspan="2">고용구분</th>
									<th rowspan="2">프로젝트</th>
									<th rowspan="2">직급</th>
									<th class="visible-md visible-lg" rowspan="2">재직구분</th>
									<th rowspan="2">입사일</th>
									<th rowspan="2">퇴사일</th>
									<th rowspan="2">근속년수(년)</th>
									<c:forEach items="${vctTypeList}" var="vctType">
										<c:choose>
											<c:when test="${vctType.CD == 'CD0001011001'}">
												<th rowspan="1" colspan="4"><c:out value="${vctType.CD_NM}"/></th>
											</c:when>
											<c:otherwise>
												<th rowspan="1" colspan="1"><c:out value="${vctType.CD_NM}"/></th>
											</c:otherwise>
										</c:choose>
									</c:forEach>
									<th rowspan="2" colspan="1">전체</th>
								</tr>
								<tr>
									<th class="visible-md visible-lg">부여일수</th>
									<th>사용일수</th>
									<th>잔여일수</th>
									<th>활용률</th>
									<th>사용일수</th>
									<th>사용일수</th>
									<th class="visible-md visible-lg">사용일수</th>
									<th>사용일수</th>
									<th>사용일수</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${totalCnt < 1 }">
										<tr>
											<td colspan="${13 + vctTypeList.size}">검색된 내용이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="list" items="${resultList}" varStatus="status">
											<tr data-id="${list.USS_ID}">
												<th class="visible-md visible-lg text-right">${totalCnt - status.index - ((cPage-1) * (intListCnt))}</th>
												<td align="center">${list.STDD_YR} </td>
												<td>${list.USS_NM}</td>
												<td>${list.EMP_TYPE_NM}</td>
												<td>${list.PROJ_NM} </td>
												<td>${list.REPT_AUTH_NM} </td>
												<td align="center">${list.RTR_YN_NM}</td>
												<td align="center">${list.JOIN_DT}</td>
												<td align="center">${list.RTR_DT}</td>
												<td align="right">${list.WORK_YR_CNT }년</td>
												<td align="right">${list.YEON_GRNT_DAY }일</td>
												<td align="right">${list.YEON_USE_CNT }일</td>
												<td align="right">${list.YEON_LEFT_CNT}일</td>
												<td align="right">${list.YEON_USE_RATE }%</td>
												<td align="right">${list.DISS_USE_CNT }일</td>
												<td align="right">${list.FAM_EVNT_USE_CNT }일</td>
												<td align="right">${list.REPLC_USE_CNT }일</td>
												<td align="right">${list.CMFT_USE_CNT }일</td>
												<td align="right">${list.FAM_CARE_USE_CNT }일</td>
												<td align="right">${list.VCT_TOT_CNT }일</td>
											</tr>
										</c:forEach>
									</c:otherwise>
							</c:choose>
						</tbody>
					</table> --%>
					</div>
					<div class="table-responsive" id="uss-vct">
						
					</div>
					<div class="table_foot2">
						<!-- pase nav-->
						<div class="text-center">
						<br/>
							<%-- <ul class="pagination pagination-sm">
								${pageNavigator }
							</ul> --%>
							<!-- <span class="pull-right">
								<button class="fnJoin btn btn-sm btn-default" >저 장</button>
							</span> -->
						</div>
					</div>
					<div>
						</div>
					</div>
				</form>
			</div>
			<!-- 결재 정보 상세 팝업  -->
			<%-- <form id="dtilFrm" name="dtilFrm" method="post" action="${pageContext.request.contextPath}/vct/vct00Popup.do" >
				<input type="hidden" id="stddYr" name="stddYr" value="" />
				<input type="hidden" id="ussId" name="ussId" value="" />
				<input type="hidden" id="startMon" name="startMon" value="" />
				<input type="hidden" id="endMon" name="endMon" value="" />
				<input type="hidden" id="vctTypeCd" name="vctTypeCd" value="" />
				<input type="hidden" id="aprvStatCd" name="aprvStatCd" value="" />
			</form --%>
			<jsp:include page="/resources/com/inc/aside.jsp" />
		</section>
	</div>
	 	<jsp:include page="/resources/com/inc/footer.jsp" />
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/tableExport/libs/FileSaver/FileSaver.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/tableExport/libs/js-xlsx/xlsx.core.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/tableExport/libs/jsPDF/jspdf.umd.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/tableExport/tableExport.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/tableExport/libs/pdfmake/pdfmake.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/tableExport/libs/pdfmake/vfs_fonts.js"></script>
	<script src="https://unpkg.com/bootstrap-table@1.19.1/dist/bootstrap-table.min.js"></script>
	<!-- <script src="https://unpkg.com/bootstrap-table@1.19.1/dist/extensions/multiple-sort/bootstrap-table-multiple-sort.js"></script> -->
	<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script> --%>
	<script type="text/javascript">

		
		/* 엑셀Down */
		$("#btnExcl").click(function() {
			//alert("excl!!");
			var stddYr = "${params.searchGubun2}";
			$('#table-stat').tableExport({type: 'excel',fileName: stddYr+'년도_직원별휴가현황집계', exportHiddenColumns: ['proj']});
			//$('#table-stat').tableExport({type: 'excel',fileName: stddYr+'년도_직원별휴가현황집계',exportHiddenCells: 'true', mso: {fileFormat : 'xlsx', rtl: true, styles : ['text-align']}});
			$('#table-stat-avg').tableExport({type: 'excel',fileName: stddYr+'년도_유형별휴가통계',exportHiddenCells: 'true'});
			/* $("#frm1").attr("action", "${pageContext.request.contextPath}/sys/vct/vct00Tran.do");
			$("#frm1").submit(); */
		});

	
		
		/* 검색 */
		$( ".fnSearch" ).click(function() {
			goPage(1);
		});
		
		/* 상세보기 팝업 */
		/* $( "#uss-vct" ).on('click', '#btnDtil', function() {
			alert("상세보기팝업!!");
			window.open("", "vct00Popup","width=720, height=750");
			$("#dtilFrm").attr("target", "vct00Popup");
			$("#dtilFrm").attr("action", "${pageContext.request.contextPath}/vct/vct00Popup.do");
			$("#dtilFrm").submit();

		}); */
		
		/* 휴가현황목록조회 */
		/* function fnView(uss_id, stdd_yr){
			var ussId = uss_id;
			//alert(ussId);
			var stddYr = stdd_yr;
			var table = "";
			table += '<span class="pull-right">';
			table += '<button class="fnExcl btn btn-sm btn-default" >엑셀다운</button>';
			table += '</span>';
			$.ajax({
				type: 'post',
				data : {
					uss_id : ussId,
					stdd_yr : stddYr
				},
				url : "${pageContext.request.contextPath}/vct/vct00View.do",
				dataType : 'json',
				success : function (data){
					var stddYr = data.params.stdd_yr;
					var ussId = data.params.uss_id;
					var resultList = data.resultList;
					    table += '<table class="table table-bordered" summary="휴가현황 목록">'
					    table += '<colgroup>'
						table += '<col width="5%" />';
						table += '<col width="5%" />';
						table += '<col width="5%" />';
						table += '<col width="5%" />';
						table += '<col width="5%" />';
						table += '<col width="5%" />';
						table += '<col width="5%" />';
						table += '<col width="5%" />';
						table += '<col width="5%" />';
						table += '<col width="5%" />';
						table += '<col width="5%" />';
						table += '<col width="5%" />';
						table += '<col width="5%" />';
						table += '<col width="5%" />';
						table += '<col width="5%" />';
						table += '<col width="5%" />';
						table += '<col width="5%" />';
					    table += '</colgroup>'
					    table += '<thead>';
						table += '<tr>';
						table += '	<th class="visible-md visible-lg">휴가구분</th>';
						table += '	<th>휴가부여일수</th>';
						table += '	<th>사용일수</th>';
						table += '	<th>잔여일수</th>';
						table += '	<th>활용률</th>';
						table += '	<th>1월</th>';
						table += '	<th>2월</th>';
						table += '	<th>3월</th>';
						table += '	<th>4월</th>';
						table += '	<th>5월</th>';
						table += '	<th>6월</th>';
						table += '	<th>7월</th>';
						table += '	<th>8월</th>';
						table += '	<th>9월</th>';
						table += '	<th>10월</th>';
						table += '	<th>11월</th>';
						table += '	<th>12월</th>';
						table += '</tr>';
					    table += '</thead>';
					    table += '<tbody>';
				
						for (var i = 0; i < resultList.length ; i++){
							var result = resultList[i];
							table += '<tr data-id="'+result.USS_ID+'">';
							table += '<th class="visible-md visible-lg text-center">'+result.VCT_TYPE_NM+'</th>';
							if(result.VCT_GRNT_DAY == null){
								table += '<td align="center">'+ '-'+'</td>';	
							}else{
								table += '<td align="right">'+ result.VCT_GRNT_DAY+'</td>';
							}
							table += '<td align="right">'+result.VCT_TOT_USE_CNT+'</td>';
							if(result.VCT_LEFT_DAY == null){
								table += '<td align="center">'+ '-'+'</td>';	
							}else {
								table += '<td align="right">'+result.VCT_LEFT_DAY+'</td>';
							}
							if(result.VCT_USE_RATE == null){
								table += '<td align="center">'+ '-'+'</td>';	
							}else {
								table += '<td align="right">'+result.VCT_USE_RATE+'</td>';
							}
							table += '<td align="right">'+result.JAN_CNT+'</td>';
							table += '<td align="right">'+result.FEB_CNT+'</td>';
							table += '<td align="right">'+result.MAR_CNT+'</td>';
							//table += '<td>'+result.FIR_QRTR_CNT+'</td>';
							table += '<td align="right">'+result.APR_CNT+'</td>';
							table += '<td align="right">'+result.MAY_CNT+'</td>';
							table += '<td align="right">'+result.JUN_CNT+'</td>';
							//table += '<td>'+result.SEC_QRTR_CNT+'</td>';
							table += '<td align="right">'+result.JUL_CNT+'</td>';
							table += '<td align="right">'+result.AUG_CNT+'</td>';
							table += '<td align="right">'+result.SEP_CNT+'</td>';
							//table += '<td>'+result.THR_QRTR_CNT+'</td>';
							table += '<td align="right">'+result.OCT_CNT+'</td>';
							table += '<td align="right">'+result.NOV_CNT+'</td>';
							table += '<td align="right">'+result.DEC_CNT+'</td>';
							//table += '<td>'+result.FRT_QRTR_CNT+'</td>';
							
							table += '</tr>';
							
						}
							
						table += '</tbody>';
						table += '</table>';
						table += '<span class="pull-right">';
						table += '<buttn type="button" id="btnDtil" class="fnDtil btn btn-sm btn-default" >상세보기</button>';
						table += '</span>';
						
						$("#stddYr").val(stddYr);
						$("#ussId").val(ussId);
						
						$("#uss-vct").html(table);
				},error: function (request, status, error) {
			         alert(request.responseText);
			    } 
			});
		} */
		
		function goPage(cPage){
			$("#cPage").val(cPage);
			$("#frm1").attr("action", "${pageContext.request.contextPath}/sys/vct/vctStat00List.do");
			$("#frm1").submit();
		}
		
	
		/*sub_menu 탭*/
		$(function(){
			 $('#table-stat').bootstrapTable();
			//년도 캘린더 만들기 - 관리자일 경우 시작년도가 2015년 , 사용자일 경우 사용자의 입사년도
			//스프링 시큐리티를 이용해서 c:set 을 이용하여 변수 생성하고 그 값으로 세팅
			var calYearKo = new tui.DatePicker('#datepicker-year-ko',{
				date : new Date(),
				language : 'ko',
				date : "${params.searchGubun2}",
				type: 'year',
				input : {
					element : '#datepicker-input-ko',
					format : 'yyyy'
				},
				selectableRanges: [
					[new Date(2015, 0, 1), new Date(9999, 11, 31)]
				]
			});
			
			$("article.sub_contents:not("+$("ul.tab_gnb li a.sub_nav_on").attr("href")+")").hide()
			$("ul.tab_gnb li a").click(function(){
				$("ul.tab_gnb li a").removeClass("sub_nav_on");
				$(this).addClass("sub_nav_on");
				$("article.sub_contents").hide();
				$($(this).attr("href")).show();
				return false;
			});
		});

	</script>
</body>
</html>