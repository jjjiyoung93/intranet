<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
<jsp:include page="/resources/com/inc/meta.jsp" />   
<title>Letech Intranet</title>

<link href="<%=request.getContextPath()%>/resources/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/dataTables.bootstrap.min.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/dataTables.responsive.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.print.css' rel='stylesheet' media='print' />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<%-- <script src="<%=request.getContextPath()%>/resources/js/bootstrap.min.js"></script> --%>

<script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-code-snippet.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-dom.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-time-picker.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-date-picker.js"></script>
<link href="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-time-picker.css" rel="stylesheet" >
<link href="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-date-picker.css" rel="stylesheet" >

<style type="text/css">
	select{
		 font-size: 12px;
		 width : 130px;
		 display:inline-block;
		 margin-right: 10px;
	}
</style>
</head>

<body>
<div id="wrapper">
 	<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
		<jsp:include page="/resources/com/inc/header.jsp" />
		<jsp:include page="/WEB-INF/views/letech/com/layout/menu.jsp" />
	</nav>

	<div id="page-wrapper">
		<div class="row">
			<div class="col-lg-10">
				<form name="frm1" id="frm1" method="post" action="${pageContext.request.contextPath}/aprv/aprv00List.do" >
					<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}" />
					<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}" />
					<input type="hidden" name="aprv_no" id="aprv_no" value="" />
					<input type="hidden" name="mode" id="mode" value="" />
					<input type="hidden" name="line_chk" id="line_chk" value="" />
					<input type="hidden" name="cPage" id="cPage" value="${cPage }" />
					<input type="hidden" name="conf_yn" id="conf_yn" value="" />
					<input type="hidden" name="conf_y_cnt" id="conf_y_cnt" value="" />
					<h2 class="page-title clearfix">
						${titleNaviMap.MN_NM }
						<span class="pull-right site-map">
							HOME > ${titleNaviMap.NAVI_NM }
						</span>
					</h2>
					<div class="form-container">
					<div class="clearfix search-box">
						<div class="search-container2 row">
							<div class="col-md-12">
								<div class="col-md-6 mt10 text-right">
									<span class="search-select-wrap" style="margin: 0px;">
										<!-- <label style="font-size: 14px; padding: 0px;">구분코드</label> -->
										<%-- <label style="font-size: 14px; padding: 0px;">업무구분</label>
										<select id="searchCdList1" style=" font-size: 12px; width: 100px;" name="searchCdList1" class="form-control table-cell">
												<option value="" >--전체--</option>
											<c:forEach var="codeList" items="${codeList}">
												<option value="${codeList.CD}" <c:if test="${codeList.CD eq params.searchCdList1 }">selected="selected"</c:if> >${codeList.CD_NM}</option>
											</c:forEach>
										</select>
										<!-- <label style="font-size: 14px; padding: 0px;">&nbsp;&nbsp;확인</label> -->
										<label style="font-size: 14px; padding: 0px;">&nbsp;&nbsp;확인여부</label>
										<select id="searchCdList2" style="width: 100px;" name="searchCdList2" class="form-control table-cell">
												<option value="" >--전체--</option>
												<option value="Y" <c:if test="${params.searchCdList2 eq 'Y' }">selected="selected"</c:if>>확인</option>
												<option value="N" <c:if test="${params.searchCdList2 eq 'N' }">selected="selected"</c:if> >미확인</option>
										</select>
										<!-- <label style="font-size: 14px; padding: 0px;">상태</label> -->
										<label style="font-size: 14px; padding: 0px;">진행상태</label>
										<select id="searchCdList3" style="width: 100px;" name="searchCdList3" class="form-control table-cell">
												<option value="" >--전체--</option>
												<option value="<%=VarConsts.APRV_COND_WAIT %>" <c:if test="${params.searchCdList3 eq '0' }">selected="selected"</c:if>>대기</option>
												<option value="<%=VarConsts.APRV_COND_ONGO %>" <c:if test="${params.searchCdList3 eq '9' }">selected="selected"</c:if>>진행중</option>
												<option value="<%=VarConsts.APRV_COND_APPR %>" <c:if test="${params.searchCdList3 eq '1' }">selected="selected"</c:if>>완료</option>
												<option value="<%=VarConsts.APRV_COND_DEFE %>" <c:if test="${params.searchCdList3 eq '2' }">selected="selected"</c:if>>보류</option>
												<option value="<%=VarConsts.APRV_COND_RETR %>" <c:if test="${params.searchCdList3 eq '3' }">selected="selected"</c:if>>반려</option>
										</select>
										<!-- <label style="font-size: 14px; padding: 0px;">구분</label> -->
										<label style="font-size: 14px; padding: 0px;">결재구분</label>
										<select id="searchCdList6" style="width: 100px;" name="searchCdList6" class="form-control table-cell">
												<option value="" >--전체--</option>
												<option value="<%=VarConsts.APRV_GB_APRV %>" <c:if test="${params.searchCdList6 eq '0' }">selected="selected"</c:if>>결재</option>
												<option value="<%=VarConsts.APRV_GB_REFE %>" <c:if test="${params.searchCdList6 eq '1' }">selected="selected"</c:if>>참조</option>
												<option value="<%=VarConsts.APRV_GB_CAN %>" <c:if test="${params.searchCdList6 eq '2' }">selected="selected"</c:if>>취소</option>
										</select> --%>
									</span>
								</div>
								
								<%-- <div class="col-md-6 mt10 text-right">
									<span class="search-select-wrap" style="margin: 0px;">
										<!-- <label style="font-size: 14px; padding: 0px;">소속1</label> -->
										<label style="font-size: 14px; padding: 0px;">상위부서</label>
										<select id="searchCdList4" style="width: 130px; font-size: 12px; display:inline-block;" name="searchCdList4" class="form-control" onchange="javascript:fn_dp2List(this.value)">
													<option value="" >--전체--</option>
													<c:forEach var="dp" items="${dpList}">
														<option value="${dp.CD}" <c:if test="${dp.CD eq params.searchCdList4 }">selected="selected"</c:if> >${dp.CD_NM}</option>
													</c:forEach>
										</select>
										<!-- <label style="font-size: 14px; padding: 0px;">소속2</label>	 -->				
										<label style="font-size: 14px; padding: 0px;">하위부서</label>					
										<select id="searchCdList5" style="width: 150px; font-size: 12px; display:inline-block;" name="searchCdList5" class="form-control">
													<option value="" >--전체--</option>
													
													<c:forEach var="dp" items="${dpList}">
														<option value="${dp.CD}" <c:if test="${dp.CD eq params.searchCdList4 }">selected="selected"</c:if> >${dp.CD_NM}</option>
													</c:forEach>
										</select>					
										<label style="font-size: 14px; padding: 0px;">&nbsp;&nbsp;보고자</label>
										<input class="form-control" style="width: 100px; display:inline-block;" type="text" name="searchField2" id="searchField2" value="${params.searchField2}" title="검색어 입력" />
										
									</span>
								</div> --%>
<!-- 								<div class="col-lg-6 mt10 text-right" style="display:inline-block;"> -->
<!-- 									<div class="search-select-wrap"> -->
<!-- 										<label style="font-size: 14px;">보고일</label> -->
<!-- 										<div class="search-select-wrap" style="display: inline-block; vertical-align: middle;"> -->
<!-- 												<div style="width: 130px;" class="form-control tui-datepicker-input tui-datetime-input tui-has-focus"> -->
<!-- 													<input id="st_dt"  name="st_dt" type="text" aria-label="Date" autocomplete="off"> <span class="tui-ico-date"></span> -->
<!-- 													<div id="startpicker-container" style="margin-left: -1px;"></div> -->
<!-- 												</div> -->
<!-- 												~ -->
<!-- 												<div style="width: 130px;" -->
<!-- 													class="form-control tui-datepicker-input tui-datetime-input tui-has-focus"> -->
<!-- 													<input id="ed_dt" name="ed_dt" type="text" aria-label="Date" autocomplete="off"> <span class="tui-ico-date"></span> -->
<!-- 													<div id="endpicker-container" style="margin-left: -1px;"></div> -->
<!-- 												</div> -->
<!-- 												<div style="display: inline-block;"><button type="button" id="delDate" class="btn btn-sm btn-default" onclick="fn_delDate()">지우기</button></div> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 								</div> -->
							</div>
<!-- 						<div class="col-md-12 mt10 pull-left"> -->
<!-- 							<div class="col-md-12"> -->
<!-- 							</div> -->
<!-- 						</div> -->
						<div class="col-md-12">
<!-- 							<div class="col-lg-6 mt10 text-right"> -->
<!-- 								<span class="search-select-wrap" style="margin: 0px;"> -->
<!-- 									<label style="font-size: 14px; padding: 0px;">&nbsp;&nbsp;보고자</label> -->
<%-- 									<input class="form-control" style="width: 100px; display:inline-block;" type="text" name="searchField2" id="searchField2" value="${params.searchField2}" title="검색어 입력" /> --%>
<!-- 									<label style="font-size: 14px; padding: 0px;">결재자</label> -->
<%-- 									<input class="form-control" style="width: 100px; display:inline-block;" type="text" name="searchField3" id="searchField3" value="${params.searchField3}" title="검색어 입력" /> --%>
<!-- 									<label style="font-size: 14px; padding: 0px;">소속</label> -->
<!-- 									<select id="searchCdList4" style="width: 100px; font-size: 12px; display:inline-block;" name="searchCdList4" class="form-control"> -->
<!-- 												<option value="" >--전체--</option> -->
<%-- 												<c:forEach var="dp" items="${dpList}"> --%>
<%-- 													<option value="${dp.CD}" <c:if test="${dp.CD eq params.searchCdList4 }">selected="selected"</c:if> >${dp.CD_NM}</option> --%>
<%-- 												</c:forEach> --%>
<!-- 									</select>					 -->
<!-- 								</span> -->
<!-- 							</div> -->
							<!-- <div class="col-md-6 mt10 text-right" style="display:inline-block;">
								<div class="search-select-wrap">
									<label style="font-size: 14px;">보고일자</label>
									<div class="search-select-wrap" style="display: inline-block; vertical-align: middle;">
											<div style="width: 135px;" class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
												<input id="st_dt"  name="stDtSrch" type="text" aria-label="Date" autocomplete="off"> <span class="tui-ico-date"></span>
												<div id="startpicker-container" style="margin-left: -1px;"></div>
											</div>
											~
											<div style="width: 135px;"
												class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
												<input id="ed_dt"name="edDtSrch" type="text" aria-label="Date" autocomplete="off"> <span class="tui-ico-date"></span>
												<div id="endpicker-container" style="margin-left: -1px;"></div>
											</div>
											<div style="display: inline-block;"><button type="button" id="delDate" class="btn btn-md btn-default" onclick="fn_delDate()">지우기</button></div>
									</div>
								</div>
							</div> -->
							
<!-- 							<div class="col-md-6 mt10 pull-right"> -->
<!-- 								<div class="" style="max-width: 430px;"> -->
<!-- 									<div class="col-md-3 un-style"> -->
<!-- 										<span class="inline-element"> -->
<!-- 											<select name="searchGubun" id="searchGubun" class="form-control" title="search" > -->
<!-- 												<option value="01" > -->
<!-- 												제목 -->
<!-- 												</option> -->
<!-- 												<option value="02" > -->
<!-- 												내용 -->
<!-- 												</option> -->
<!-- 											</select> -->
<!-- 										</span> -->
<!-- 									</div> -->
								
<!-- 									<div class="col-md-9 un-style"> -->
<!-- 										<div class="input-group" style="width: 95%;"> -->
<!-- 										<input class="form-control" type="text" name="searchField" id="searchField" value="" title="검색어 입력" /> -->
<!-- 											<span class="input-group-btn"> -->
<!-- 												<button class="btn btn-info" type="button" onclick="goPage('1');"><i class="glyphicon glyphicon-search"></i><span class="hidden-xs hidden-sm"> 검색</span></button> -->
<!-- 											</span> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
							
							
							
							
							<%-- <div class="col-md-6 mt10">
								<div class="" style="max-width: 430px;">
									<div class="col-lg-4 un-style">
										<span class="inline-element">
											<select name="searchGubun" id="searchGubun" class="form-control" title="search" >
												<option value="01" <c:if test="${params.searchGubun == '01'}">selected = "selected"</c:if>>
												제목
												</option>
												<option value="02" <c:if test="${params.searchGubun == '02'}">selected = "selected"</c:if> >
												내용
												</option>
											</select>
										</span>
									</div>
								
									<div class="col-lg-8 un-style">
										<div class="input-group">
										<input class="form-control" type="text" name="searchField" id="searchField" value="${params.searchField}" title="검색어 입력" />
											<span class="input-group-btn">
												<button class="btn btn-info" type="button" onclick="goPage('1');"><i class="glyphicon glyphicon-search"></i><span class="hidden-xs hidden-sm"> 검색</span></button>
											</span>
										</div>
									</div>
								</div>
							</div> --%>
							
							
							
<!-- 							<div class="col-lg-6 mt10 text-right"> -->
<!-- 								<div class="text-right search-select-wrap"> -->
<!-- 									<div class="col-lg-2" style="display: inline-block; vertical-alignment: middle; width: 80px; padding: 0px;"> -->
<!-- 												<select name="searchGubun" id="searchGubun" class="form-control" title="search" > -->
<%-- 													<option value="01" <c:if test="${params.searchGubun == '01'}">selected = "selected"</c:if>> --%>
<!-- 													제목 -->
<!-- 													</option> -->
<%-- 													<option value="02" <c:if test="${params.searchGubun == '02'}">selected = "selected"</c:if>> --%>
<!-- 													내용 -->
<!-- 													</option> -->
<!-- 												</select>											 -->
<!-- 									</div> -->
								
<!-- 									<div class="col-lg-4 text-right" style="display: inline-block; width: 320px;  padding: 0px;"> -->
<!-- 										<div class="input-group"> -->
<%-- 										<input class="form-control" type="text" name="searchField" id="searchField" value="${params.searchField}" title="검색어 입력" /> --%>
<!-- 											<span class="input-group-btn"> -->
<!-- 												<button class="btn btn-info" type="button" onclick="goPage('1');"><i class="glyphicon glyphicon-search"></i><span class="hidden-xs hidden-sm"> 검색</span></button> -->
<!-- 											</span> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
						</div>
					</div>
					<!-- <div class="container"> -->
						<div class="row">
							<!--업무구분, 확인여부  -->
							<div class="col-lg-6 col-md-12 col-sm-12 col-xs-6 mt10">
								<!-- <label style="font-size: 14px; padding: 0px;">구분코드</label> -->
									<label style="padding: 0px; width: 70px;">업무구분</label>
									<select id="searchCdList1" style="font-size: 12px; width : 125px; display:inline-block; margin-right: 10px;"  name="searchCdList1" class="form-control">
											<option value="" >--전체--</option>
										<c:forEach var="codeList" items="${codeList}">
											<option value="${codeList.CD}" <c:if test="${codeList.CD eq params.searchCdList1 }">selected="selected"</c:if> >${codeList.CD_NM}</option>
										</c:forEach>
									</select>
									<!-- <label style="font-size: 14px; padding: 0px;">&nbsp;&nbsp;확인</label> -->
									<!-- <label style="padding: 0px; width: 70px;">확인여부</label> -->
									<select id="searchCdList2" style=" font-size: 12px; width : 125px; display:inline-block;" name="searchCdList2" class="form-control">
											<option value="" >--전체--</option>
											<option value="Y" <c:if test="${params.searchCdList2 eq 'Y' }">selected="selected"</c:if>>확인</option>
											<option value="N" <c:if test="${params.searchCdList2 eq 'N' }">selected="selected"</c:if> >미확인</option>
									</select>
							</div>
							<!-- 진행상태, 결재구분  -->
							<div class="col-lg-6 col-md-12 col-sm-12 col-xs-6 mt10">
								<label style="padding: 0px; width: 70px;"">진행상태</label>
								<select id="searchCdList3" style="font-size: 12px; width : 125px; display:inline-block; margin-right: 10px;" name="searchCdList3" class="form-control">
										<option value="" >--전체--</option>
										<option value="<%=VarConsts.APRV_COND_WAIT %>" <c:if test="${params.searchCdList3 eq '0' }">selected="selected"</c:if>>대기</option>
										<option value="<%=VarConsts.APRV_COND_ONGO %>" <c:if test="${params.searchCdList3 eq '9' }">selected="selected"</c:if>>진행중</option>
										<option value="<%=VarConsts.APRV_COND_APPR %>" <c:if test="${params.searchCdList3 eq '1' }">selected="selected"</c:if>>완료</option>
										<option value="<%=VarConsts.APRV_COND_DEFE %>" <c:if test="${params.searchCdList3 eq '2' }">selected="selected"</c:if>>보류</option>
										<option value="<%=VarConsts.APRV_COND_RETR %>" <c:if test="${params.searchCdList3 eq '3' }">selected="selected"</c:if>>반려</option>
								</select>
								<!-- <label style="font-size: 14px; padding: 0px;">결재구분</label> -->
								<select id="searchCdList6" style="font-size: 12px; width : 125px; display:inline-block; margin-right: 10px;" name="searchCdList6" class="form-control">
										<option value="" >--전체--</option>
										<option value="<%=VarConsts.APRV_GB_APRV %>" <c:if test="${params.searchCdList6 eq '0' }">selected="selected"</c:if>>결재</option>
										<option value="<%=VarConsts.APRV_GB_REFE %>" <c:if test="${params.searchCdList6 eq '1' }">selected="selected"</c:if>>참조</option>
										<option value="<%=VarConsts.APRV_GB_CAN %>" <c:if test="${params.searchCdList6 eq '2' }">selected="selected"</c:if>>취소</option>
								</select>
							</div>
							<!-- 상위소속  -->
							<div class="col-lg-7 col-md-12 col-sm-12 col-xs-6 mt10">
								<!-- <label style="font-size: 14px; padding: 0px;">소속1</label> -->
								<label style="font-size: 14px; padding: 0px; width: 70px;">소속부서</label>
								<select id="searchCdList4" style="width: 125px; font-size: 12px; display:inline-block;" name="searchCdList4" class="form-control" onchange="javascript:fn_dp2List(this.value)">
											<option value="" >--전체--</option>
											<c:forEach var="dp" items="${dpList}">
												<option value="${dp.CD}" <c:if test="${dp.CD eq params.searchCdList4 }">selected="selected"</c:if> >${dp.CD_NM}</option>
											</c:forEach>
								</select>
								
								<select id="searchCdList5" style="width: 125px; font-size: 12px; display:inline-block;" name="searchCdList5" class="form-control">
											<option value="" >--전체--</option>
											
											<%-- <c:forEach var="dp" items="${dpList}">
												<option value="${dp.CD}" <c:if test="${dp.CD eq params.searchCdList5 }">selected="selected"</c:if> >${dp.CD_NM}</option>
											</c:forEach> --%>
								</select>
								
							</div>
							<!-- 하위소속  -->
							<div class="col-lg-5 col-lg-pull-1 col-md-6 col-sm-6 col-xs-6 mt10">
								<!-- <label style="font-size: 14px; padding: 0px;">하위부서</label>	 -->
								<!-- 보고자  -->
								<label style="padding: 0px; width: 70px;">보고사원</label>
								<input class="form-control" style="width: 125px; display:inline-block;" type="text" name="searchField2" id="searchField2" value="${params.searchField2}" title="검색어 입력" />
							</div>
						
						</div>
						<div class="row">
							<!-- 보고일자  -->
							<div class="col-xl-6 col-lg-12 col-md-12 col-sm-12 col-xs-12 form-inline mt10">
								<label style="padding: 0px; width: 70px;">보고일자</label>
								<div class="search-select-wrap" style="display:inline-block; vertical-align: middle;">
										<div style="width: 125px;" class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
											<input id="st_dt"  name="stDtSrch" type="text" aria-label="Date" autocomplete="off"> <span class="tui-ico-date"></span>
											<div id="startpicker-container" style="margin-left: -1px;"></div>
										</div>
										~
										<div style="width: 125px;"
											class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
											<input id="ed_dt"name="edDtSrch" type="text" aria-label="Date" autocomplete="off"> <span class="tui-ico-date"></span>
											<div id="endpicker-container" style="margin-left: -1px;"></div>
										</div>
										<div style="display: inline-block;" class="ml10"><button type="button" id="delDate" class="btn btn-md btn-default" onclick="fn_delDate()">지우기</button></div>
								</div>
							</div>
							
							<div class="col-xl-6 col-lg-12 col-md-12 col-sm-12 col-xs-12 mt10">
									<div class="search-container pull-left">
										<div class="col-xs-3 un-style">
											<span class="inline-element">
												<select name="searchGubun" id="searchGubun" class="form-control" style="display:inline;" title="search" >
													<option value="01" <c:if test="${params.searchGubun == '01'}">selected = "selected"</c:if>>
													제목
													</option>
													<option value="02" <c:if test="${params.searchGubun == '02'}">selected = "selected"</c:if> >
													내용
													</option>
												</select>
											</span>
										</div>
										<div class="col-xs-9 un-style">
											<div class="input-group">
												<input type="text" name="searchField" id="searchField"  value="${params.searchField}" class="form-control" title="검색어 입력" />
												<span class="input-group-btn">
													<button class=" fnSearch btn btn-info" type="button" onclick="search();"><i class="glyphicon glyphicon-search"></i><span class="hidden-xs hidden-sm"> 검색</span></button>
												</span>
											</div>
										</div>
									</div>
								</div>
							
						</div>
						<div class="row">
							<!-- 검색  -->
							<%-- <div class="col-xs-12 mt10">
									<div class="search-container pull-left">
										<div class="col-xs-5 un-style">
											<span class="inline-element">
												<select name="searchGubun" id="searchGubun" class="form-control" style="display:inline;" title="search" >
													<option value="01" <c:if test="${params.searchGubun == '01'}">selected = "selected"</c:if>>
													제목
													</option>
													<option value="02" <c:if test="${params.searchGubun == '02'}">selected = "selected"</c:if> >
													내용
													</option>
												</select>
											</span>
										</div>
										<div class="col-xs-7 un-style">
											<div class="input-group">
												<input type="text" name="searchField" id="searchField"  value="${params.searchField}" class="form-control" title="검색어 입력" />
												<span class="input-group-btn">
													<button class=" fnSearch btn btn-info" type="button" onclick="goPage('1');"><i class="glyphicon glyphicon-search"></i><span class="hidden-xs hidden-sm"> 검색</span></button>
												</span>
											</div>
										</div>
									</div>
								</div> --%>
							<%-- <div class="col-lg-6 col-md-12 col-sm-12 pull-right">
								<div class="inline-form">
									<div class="un-style">
										<span class="inline-element">
											<select name="searchGubun" id="searchGubun" class="form-control" style="width: 100px; display:inline;" title="search" >
												<option value="01" <c:if test="${params.searchGubun == '01'}">selected = "selected"</c:if>>
												제목
												</option>
												<option value="02" <c:if test="${params.searchGubun == '02'}">selected = "selected"</c:if> >
												내용
												</option>
											</select>
										</span>
									</div>
									
									<div class="un-style">
										<div class="input-group">
										<input class="form-control" type="text" name="searchField" id="searchField" value="${params.searchField}" title="검색어 입력" />
											<span class="input-group-btn">
												<button class="btn btn-info" type="button" onclick="goPage('1');"><i class="glyphicon glyphicon-search"></i><span class="hidden-xs hidden-sm"> 검색</span></button>
											</span>
										</div>
									</div>
								</div>
							</div> --%>
						</div>
						<div class="row"></div>
						<div class="row"></div>
					
					<!-- </div> -->
					
					
					
					<!-- 업무구분 , 진행상태   -->
					<%-- <div class="search-container2 row">
						<div class="col-md-12">
								<div class="col-md-12 form-inline">
									<!-- <span class="search-select-wrap" style="margin: 0px;"> -->
										<!-- <label style="font-size: 14px; padding: 0px;">구분코드</label> -->
										<label style="padding: 0px;">업무구분</label>
										<select id="searchCdList1" style=" font-size: 12px; width: 100px;" name="searchCdList1" class="form-control table-cell">
												<option value="" >--전체--</option>
											<c:forEach var="codeList" items="${codeList}">
												<option value="${codeList.CD}" <c:if test="${codeList.CD eq params.searchCdList1 }">selected="selected"</c:if> >${codeList.CD_NM}</option>
											</c:forEach>
										</select>
										<!-- <label style="font-size: 14px; padding: 0px;">&nbsp;&nbsp;확인</label> -->
										<label style="font-size: 14px; padding: 0px;">&nbsp;&nbsp;확인여부</label>
										<select id="searchCdList2" style="width: 100px;" name="searchCdList2" class="form-control table-cell">
												<option value="" >--전체--</option>
												<option value="Y" <c:if test="${params.searchCdList2 eq 'Y' }">selected="selected"</c:if>>확인</option>
												<option value="N" <c:if test="${params.searchCdList2 eq 'N' }">selected="selected"</c:if> >미확인</option>
										</select>
										<label style="padding: 0px;">진행상태</label>
										<select id="searchCdList3" style="width: 100px;" name="searchCdList3" class="form-control table-cell">
												<option value="" >--전체--</option>
												<option value="<%=VarConsts.APRV_COND_WAIT %>" <c:if test="${params.searchCdList3 eq '0' }">selected="selected"</c:if>>대기</option>
												<option value="<%=VarConsts.APRV_COND_ONGO %>" <c:if test="${params.searchCdList3 eq '9' }">selected="selected"</c:if>>진행중</option>
												<option value="<%=VarConsts.APRV_COND_APPR %>" <c:if test="${params.searchCdList3 eq '1' }">selected="selected"</c:if>>완료</option>
												<option value="<%=VarConsts.APRV_COND_DEFE %>" <c:if test="${params.searchCdList3 eq '2' }">selected="selected"</c:if>>보류</option>
												<option value="<%=VarConsts.APRV_COND_RETR %>" <c:if test="${params.searchCdList3 eq '3' }">selected="selected"</c:if>>반려</option>
										</select>
										<!-- <label style="font-size: 14px; padding: 0px;">구분</label> -->
										<label style="font-size: 14px; padding: 0px;">결재구분</label>
										<select id="searchCdList6" style="width: 100px;" name="searchCdList6" class="form-control table-cell">
												<option value="" >--전체--</option>
												<option value="<%=VarConsts.APRV_GB_APRV %>" <c:if test="${params.searchCdList6 eq '0' }">selected="selected"</c:if>>결재</option>
												<option value="<%=VarConsts.APRV_GB_REFE %>" <c:if test="${params.searchCdList6 eq '1' }">selected="selected"</c:if>>참조</option>
												<option value="<%=VarConsts.APRV_GB_CAN %>" <c:if test="${params.searchCdList6 eq '2' }">selected="selected"</c:if>>취소</option>
										</select>
							<!-- 		</span> -->
								</div>
							</div>
							<div class="col-md-12">
								<div class="col-md-12 mt10">
									<span class="search-select-wrap" style="margin: 0px;">
										<!-- <label style="font-size: 14px; padding: 0px;">소속1</label> -->
										<label style="font-size: 14px; padding: 0px;">상위부서</label>
										<select id="searchCdList4" style="width: 130px; font-size: 12px; display:inline-block;" name="searchCdList4" class="form-control" onchange="javascript:fn_dp2List(this.value)">
													<option value="" >--전체--</option>
													<c:forEach var="dp" items="${dpList}">
														<option value="${dp.CD}" <c:if test="${dp.CD eq params.searchCdList4 }">selected="selected"</c:if> >${dp.CD_NM}</option>
													</c:forEach>
										</select>
										<!-- <label style="font-size: 14px; padding: 0px;">소속2</label>	 -->				
										<label style="font-size: 14px; padding: 0px;">하위부서</label>					
										<select id="searchCdList5" style="width: 150px; font-size: 12px; display:inline-block;" name="searchCdList5" class="form-control">
													<option value="" >--전체--</option>
													
													<c:forEach var="dp" items="${dpList}">
														<option value="${dp.CD}" <c:if test="${dp.CD eq params.searchCdList4 }">selected="selected"</c:if> >${dp.CD_NM}</option>
													</c:forEach>
										</select>					
										<label style="font-size: 14px; padding: 0px;">&nbsp;&nbsp;보고자</label>
										<input class="form-control" style="width: 100px; display:inline-block;" type="text" name="searchField2" id="searchField2" value="${params.searchField2}" title="검색어 입력" />
										
									</span>
								</div>
								<div class="col-md-12 mt10 text-right">
									<span class="search-select-wrap" style="margin: 0px;">
										
									</span>
								</div>
							
							</div>
					</div>
					<!-- 소속 , 보고일자  -->
					<div class="search-container2 row">
						<div class="col-md-12">
							<div class="col-md-12 mt10 text-right" style="margin: 0px;">
								<div class="search-select-wrap">
									<label style="font-size: 14px;">보고일</label>
									<div class="search-select-wrap" style="display: inline-block; vertical-align: middle;">
											<div style="width: 135px;" class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
												<input id="st_dt"  name="stDtSrch" type="text" aria-label="Date" autocomplete="off"> <span class="tui-ico-date"></span>
												<div id="startpicker-container" style="margin-left: -1px;"></div>
											</div>
											~
											<div style="width: 135px;"
												class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
												<input id="ed_dt"name="edDtSrch" type="text" aria-label="Date" autocomplete="off"> <span class="tui-ico-date"></span>
												<div id="endpicker-container" style="margin-left: -1px;"></div>
											</div>
											<div style="display: inline-block;"><button type="button" id="delDate" class="btn btn-md btn-default" onclick="fn_delDate()">지우기</button></div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-12">
							<div class="col-md-12 mt10">
								<div class="" style="max-width: 430px;">
									<div class="col-md-4 un-style">
										<span class="inline-element">
											<select name="searchGubun" id="searchGubun" class="form-control" title="search" >
												<option value="01" <c:if test="${params.searchGubun == '01'}">selected = "selected"</c:if>>
												제목
												</option>
												<option value="02" <c:if test="${params.searchGubun == '02'}">selected = "selected"</c:if> >
												내용
												</option>
											</select>
										</span>
									</div>
								
									<div class="col-md-8 un-style">
										<div class="input-group">
										<input class="form-control" type="text" name="searchField" id="searchField" value="${params.searchField}" title="검색어 입력" />
											<span class="input-group-btn">
												<button class="btn btn-info" type="button" onclick="goPage('1');"><i class="glyphicon glyphicon-search"></i><span class="hidden-xs hidden-sm"> 검색</span></button>
											</span>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div> --%>
					<!-- 보고자, 검색  -->
					<div class="search-container2 row"></div>
					</div>
					<p class="clearfix board-top">
						<select id="listCnt" name="listCnt" class="form-control" style="width: 100px; display: inline-block;" onchange="goPage('1');">
							<option value="10">10</option>
							<option value="20">20</option>
							<option value="30">30</option>
							<option value="50">50</option>
							<option value="100">100</option>
						</select>
						<span class="">
						<input type="checkbox" value="Y" id="myAprvList" class="form-check-input" name="myAprvList" <c:if test="${params.myAprvList eq 'Y' }"> checked="checked"</c:if> >
						<label>내 결재문서 보기</label>
						</span>
						
						<span class="pull-right ml-1"><input type="button" id="fnJoin" name="fnJoin" class="btn btn-sm btn-default" value="등록"/></span>
						<br>
					</p>
						<table class="table table-bordered reactive" >
							<colgroup>
								<col width="50" class="hidden-xs hidden-sm"/>
								<col width="80"/>
								<col width="80" class="hidden-xs hidden-sm"/>
								<col width="50"/>
								<col width="*"/>
								<col width="180" class="hidden-xs hidden-sm"/>
								<col width="100" class="hidden-xs hidden-sm"/>
								<col width="100"/>
							</colgroup>
							<thead>
								<tr role="row">
									<th class="hidden-xs hidden-sm">NO</th>
									<th class="">보고자</th>
									<th class="hidden-xs hidden-sm">구분</th>
									<th class="">확인</th>
									<th class="">제 목</th>
									<th class="hidden-xs hidden-sm">기간</th>
									<th class="hidden-xs hidden-sm">보고일</th>
									<th class="">상태</th>
								</tr>
							</thead>
							<tbody>
					        	<c:choose>
									<c:when test="${totalCnt < 1 }">
										<tr>
											<td colspan="8">
												검색된 내용이 없습니다.
											</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="list" items="${resultList}" varStatus="status">
											<tr class="">
												<td class="hidden-xs hidden-sm text-center">
													${totalCnt - status.index - ((cPage-1) * (intListCnt))}
												</td>
												<td>
													${list.REPT_APRV_NM}
												</td>
												<td class="hidden-xs hidden-sm">
													${list.APRV_TYPE_NM}
												</td>
												<td class="">
											<c:choose>
												<c:when test="${list.CONF_YN eq 'Y' }">
													확인
												</c:when>
												<c:otherwise>
													미확인
												</c:otherwise>
											</c:choose>
												</td>
												<td class="center">
													<a href="javascript:fnView('${list.APRV_NO}', '${list.LINE_CHK }', '${list.CONF_YN }', '${list.CONF_Y_CNT }');">
													<span class="ellip ellip-line">${list.TITLE}</span>
													</a>
												</td>
												<td class="hidden-xs hidden-sm">
													<c:choose>
														<c:when test="${list.TERM_ST_YM ne null }">
															${list.TERM_ST_YM} - ${list.TERM_ED_YM}
														</c:when>
														<c:otherwise>
															${list.CRTN_DT} - ${list.CRTN_DT}
														</c:otherwise>
													</c:choose> 
													
												</td>
												<td class="hidden-xs hidden-sm">
													${list.CRTN_DT}
												</td>
												<td class="center">
													<c:choose>
														<c:when test="${list.LINE_CHK eq 'N' && list.APRV_YN_TP eq '1' && list.CONF_Y_CNT > 0 && list.CONF_Y_CNT > list.CONF_REFE_CNT }">
															진행중
														</c:when>
														<c:otherwise>
															${list.APRV_YN_NM}
														</c:otherwise>
													</c:choose>
													
													<c:choose>
														<c:when test="${!empty list.CANCEL_YN && list.CANCEL_YN eq 'Y' }">
															<span style="color:blue;">(취소)</span>
														</c:when>
														<c:otherwise>
															<c:if test="${list.LINE_CHK eq 'Y' }">
																<c:choose>
																	<c:when test="${list.REFE_YN eq 'Y' }">
																	(참조)
																	</c:when>
																	<c:otherwise>
																	<c:if test="${list.LINE_CHK eq 'Y' }">
																		<c:choose>
																			<c:when test="${list.APRV_ID eq params.uss_id }">
																				<span style="color:red;">(결재)</span>
																			</c:when>
																			<c:otherwise>
																				(결재)
																			</c:otherwise>
																		</c:choose>
																	</c:if>
																	</c:otherwise>
																</c:choose>
															</c:if>
														</c:otherwise>
													</c:choose>
												</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>			
							</tbody>
						</table>
						<div class="text-center">
							<ul class="pagination pagination-sm" >
								${pageNavigator}
							</ul>
						</div>
						<div class="clearfix">
							<span class="pull-right"><input type="button" id="fnJoin1" name="fnJoin" class="btn btn-sm btn-default" value="등록"/></span>
						</div>
					</div>
				</form>
			</div>
			<jsp:include page="/resources/com/inc/aside.jsp" />
		</div>
	</div>
	<jsp:include page="/resources/com/inc/footer.jsp" />
</div>
<script type="text/javascript">

$(document).ready(function(){
// 	var optVal = $("#cdList1").val();
// 	if(optVal != ""){
// 		optionCreate(optVal);
// 	}
	
	//console.log($("#aprv_no").val());
	//console.log($("#mode").val());
	
	var dpCd = "<c:out value='${params.searchCdList4}'/>";
	
	fn_dp2List(dpCd);
		
	/* 등록 */
	$("#fnJoin").click(function(){
		$("#frm1").attr("action", "${pageContext.request.contextPath}/aprv/aprv00Form.do");
		$("#frm1").submit();
	});
	
	/* 등록 */
	$("#fnJoin1").click(function(){
		$("#frm1").attr("action", "${pageContext.request.contextPath}/aprv/aprv00Form.do");
		$("#frm1").submit();
	});

	//$("#listCnt").val("${params.listCnt}");

	//select box 선택 기능
// 	$("#cdList1").change(function(){
// 		optionCreate($(this).val());
// 	});
});

// select option 생성
function optionCreate(val){
	$("#cdList2").find('option').each(function(){
		$(this).remove();	
	});
	
	$("#cdList2").append("<option value=''>--선택--</option>");
	
	var selectVal = val; //$(this).val();
	
	if(selectVal != ""){
		$.ajax({
				type:'get',
				url:'/option/getCodeList.do?cd='+selectVal,
				dataType:'json',
				success: function(json){
					var data = json.codeList;
					if(data==null){
						data=0;
					}
					for(var i=0; i<data.length; i++){
						$("#cdList2").append("<option value='"+ data[i]['CD'] + "'>" + data[i]['CD_NM'] + "</option>");
					}
					$("#cdList2").val("${param.cdList2}").attr("selected", "selected");
				}
		});
	}
}

/* 글보기 */
function fnView(aprv_no, line_chk, conf_yn, conf_y_cnt){
	
	$("#aprv_no").val(aprv_no);
	$("#line_chk").val(line_chk);		// 결재 인지 아닌지 구분 (Y:결재, N:결재신청)
	$("#conf_yn").val(conf_yn);
	$("#conf_y_cnt").val(conf_y_cnt);
	$("#mode").val("<%=VarConsts.MODE_U%>");
	$("#frm1").attr("action", "${pageContext.request.contextPath}/aprv/aprv00View.do");
	$("#frm1").submit();	
}

function search(){
	$("#myAprvList").prop("checked", false);
	goPage(1);
}

function goPage(cPage){
	$("#cPage").val(cPage);
	$("#frm1").attr("action", "${pageContext.request.contextPath}/aprv/aprv00List.do");
	$("#frm1").submit();
	
}

var picker = tui.DatePicker.createRangePicker({
	language: 'ko',
	startpicker: {
		input: '#st_dt',
		container: '#startpicker-container'
	},
	endpicker: {
		input: '#ed_dt',
		container: '#endpicker-container'
	},
	type: 'date',
	format: 'yyyy-MM-dd'
});

$("#listCnt").val("<c:out value='${params.listCnt}'/>");

var stDt = "<c:out value='${params.stDtSrch}'/>";
var edDt = "<c:out value='${params.edDtSrch}'/>";
if(stDt != null && stDt != ''){
	var stDtStr = stDt.split("-");
	var stYear = stDtStr[0];
	var stMon = stDtStr[1] - 1;
	var stDay = stDtStr[2];
	var stDate = new Date(stYear ,stMon ,stDay);
	picker.setStartDate(stDate);
	
}

if(edDt != null && edDt != ''){
	var edDtStr = edDt.split("-");
	var edYear = edDtStr[0];
	var edMon = edDtStr[1] - 1;
	var edDay = edDtStr[2];
	var edDate = new Date(edYear, edMon, edDay);
	picker.setEndDate(edDate);	
}

function fn_delDate(){
	picker.setStartDate(null);
	picker.setEndDate(null);
}

function fn_dp2List(val){
	var dp2Cd = '${params.searchCdList5}';
	
	var dpCd = val;
	
	$.ajax({
		type: 'post',
		data : {
			upCd : dpCd 
		},
		url : "${pageContext.request.contextPath}/aprv/getCdList.do",
		dataType : 'json',
		success : function (data){
			var params = data.params;
			var cdList = data.cdList;
			var html = '';
			$(".cdList").remove();
			for(var i in cdList){
				var cd = cdList[i];
				html += '<option class="cdList" value="'+cd.CD+'" id="'+cd.CD+'">'+cd.CD_NM+'</option>';
			}
			$("#searchCdList5").append(html);
			$("#"+dp2Cd).prop('selected', true);
		},error: function (request, status, error) {
	         alert(request.responseText);
	    } 
	});
}

$("#myAprvList").on("change", function(){
	var myAprv = $("#myAprvList").is(":checked");
	//alert(myAprv);
	if(myAprv){
		$("#searchField").val("");
		$("#searchField2").val("");
		$("#searchField3").val("");
		$("#searchGubun").val("");
		$("#searchCdList1").val("");
		$("#searchCdList2").val("");
		$("#searchCdList3").val("");
		$("#searchCdList4").val("");
		$("#searchCdList5").val("");
		$("#searchCdList6").val("");
		
		$("#stDtSrch").val("");
		$("#edDtSrch").val("");
		
		goPage(1);
	}
	
})

</script>
</body>
</html>