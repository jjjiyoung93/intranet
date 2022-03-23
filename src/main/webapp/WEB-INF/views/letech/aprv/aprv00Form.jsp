<!doctype html>
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
	.modal {
        text-align: center;
}
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
						<form name="frm1" id="frm1" method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/aprv/aprv00List.do" >
							<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}" />
							<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}" />
							<input type="hidden" id="mode" name="mode" value="${params.mode }" />
							<input type="hidden" id="aprv_no" name="aprv_no" value="${viewMap.APRV_NO }" />
							<input type="hidden" id="line_chk" name="line_chk" value="${params.line_chk }" />
							<input type="hidden" id="aprv_line_cd" name="aprv_line_cd" value="${viewMap.APRV_LINE_CD }" />
							<!-- 검색 정보 Start -->
							<input type="hidden" name="cPage" id="cPage" value="${params.cPage }" />
							<input type="hidden" id="searchCdList1" name="searchCdList1" value="${params.searchCdList1}" />
							<input type="hidden" id="searchCdList2" name="searchCdList2" value="${params.searchCdList2}" />
							<input type="hidden" id="searchCdList3" name="searchCdList3" value="${params.searchCdList3}" />
							<input type="hidden" id="searchCdList4" name="searchCdList4" value="${params.searchCdList4}" />
							<input type="hidden" id="searchCdList5" name="searchCdList5" value="${params.searchCdList5}" />
               				<input type="hidden" id="searchCdList6" name="searchCdList6" value="${params.searchCdList6}" />
               				<input type="hidden" id="myAprvList" name="myAprvList" value="${params.myAprvList}" />
							<input type="hidden" id="searchGubun" name="searchGubun" value="${params.searchGubun}" />
							<input type="hidden" id="searchField" name="searchField" value="${params.searchField}" />
							<input type="hidden" id="searchField2" name="searchField2" value="${params.searchField2}" />
							<input type="hidden" id="searchField3" name="searchField3" value="${params.searchField3}" />
							<input type="hidden" id="listCnt" name="listCnt" value="${params.listCnt}" />
							<!-- 검색 정보 End -->
							
							<input type="hidden" id="cal_no" name="cal_no" value="${viewMap.CAL_NO}" />
							
							<input type="hidden" id="term_st_ym" name="term_st_ym" value="${viewMap.TERM_ST_YM}" />
							<input type="hidden" id="term_ed_ym" name="term_ed_ym" value="${viewMap.TERM_ED_YM}" />
							<input type="hidden" id="term_st_hm" name="term_st_hm" value="${viewMap.TERM_ST_HM}" />
							<input type="hidden" id="term_ed_hm" name="term_ed_hm" value="${viewMap.TERM_ED_HM}" />
							
					       	<input type="hidden" name="stDtSrch" value="${params.stDtSrch}"/>
               				<input type="hidden" name="edDtSrch" value="${params.edDtSrch}"/>
							
							<input type="hidden" name="tmpPayItemList[0].cd1" value="" />
							
							<h2 class="page-title clearfix">
								${titleNaviMap.MN_NM }
								<span class="pull-right site-map">
									HOME > ${titleNaviMap.NAVI_NM }
								</span>
							</h2>
						
							<div class="form-container">
								<div class="board-write row">
								
									<!-- 소속 및 프로젝트 시작 START -->
									<div class="col-lg-6 form-group">
										<div class="col-lg-4 col-sm-2 text-right">
											<label class="control-label">소속</label>
										</div>
										<div class="col-lg-6">
											<c:choose>
												<c:when test="${params.mode eq 'UPDATE' }">
													<c:set var="rept_dp_cd" value="${viewMap.REPT_DP_CD }"/>
													<input type="text" class="form-control" id="rept_dp_nm" value="${viewMap.REPT_DP_NM }" readonly/>
												</c:when>
												<c:otherwise>
													<c:set var="rept_dp_cd" value="${loginVO.authCd != 'ROLE_ADMIN' ? loginVO.orgnztId : '' }"/>
													<input type="text" class="form-control" id="rept_dp_nm" value="${loginVO.authCd != 'ROLE_ADMIN' ? loginVO.orgnztNm : ''}" readonly/>
													
												</c:otherwise>
											</c:choose>
											<input type="hidden" id="rept_dp_cd" name="rept_dp_cd" value="${rept_dp_cd }" />
										</div>
									</div>
									<div class="col-lg-6 form-group">
										<div class="col-lg-4 col-sm-2 text-right">
											<label class="control-label">프로젝트</label>
											<span class="req-sign">*</span>
										</div>
										<div class="col-lg-6">
											<select id="proj_cd" name="proj_cd" class="form-control">
												<option value="">선택</option>
												<c:if test="${params.mode eq 'UPDATE' }">
													<option value="${viewMap.PROJ_CD }" selected>${viewMap.PROJ_NM }</option>
												</c:if>
												<c:forEach var="proj" items="${projList }" varStatus="status">
												<option value="${proj.CD }" <c:if test="${proj.CD eq viewMap.PROJ_CD }" >selected="selected"</c:if> >${proj.CD_NM }</option>
												</c:forEach>
											</select>
										</div>
									</div>
									<!-- 소속 및 프로젝트 끝 END -->
									
									<!-- 직위 및 보고자 START -->
									<div class="col-lg-6 form-group">
										<div class="col-lg-4 col-sm-2 text-right">
											<label class="control-label">직위</label>
										</div>
										<div class="col-lg-6">
											<c:choose>
												<c:when test="${params.mode eq 'UPDATE' }">
													<c:set var="rept_auth_cd" value="${viewMap.REPT_AUTH_CD }"/>
													<input type="text" class="form-control" id="rept_auth_nm" value="${viewMap.REPT_AUTH_NM }" readonly/>
												</c:when>
												<c:otherwise>
													<c:set var="rept_auth_cd" value="${loginVO.authCd != 'ROLE_ADMIN' ? loginVO.authCd : ''}"/>
													<input type="text" class="form-control" id="rept_auth_nm" value="${loginVO.authCd != 'ROLE_ADMIN' ? loginVO.authNm : '' }" readonly/>
												</c:otherwise>
											</c:choose>
											<input type="hidden" id="rept_auth_cd" name="rept_auth_cd" value="${rept_auth_cd }" />
										</div>
									</div>
									<div class="col-lg-6 form-group">
										<div class="col-lg-4 col-sm-2 text-right">
											<label class="control-label">보고자</label>
										</div>
										<div class="col-lg-6 form-inline">
											<c:set var="rept_aprv_no" value=""/>
											<c:set var="mode_u" value="<%=VarConsts.MODE_U%>"/>
											<c:choose>
												<c:when test="${params.mode eq mode_u }">
													<div class="">
													<input type="text" class="form-control" value="${viewMap.REPT_APRV_NM }" readonly/>
													<c:set var="rept_aprv_no" value="${viewMap.REPT_APRV_NO }"/>
													<input type="hidden" class="form-control" name="rept_aprv_no_nm" id="rept_aprv_no_nm" value="${viewMap.REPT_APRV_NM }" readonly/>
													</div>
												</c:when>
												<c:otherwise>
													<input type="text" class="form-control" name="rept_aprv_no_nm" id="rept_aprv_no_nm" value="${loginVO.name }" readonly/>
													<!-- 2022.01.18 관리자 등록 시 보고자 선택 가능 : BEGIN  -->
													<sec:authorize access="hasAnyRole('ROLE_ADMIN')">
															<button type="button" class="btn btn-default btn-sm" onclick="fn_ussSearch('rept_aprv_no')">찾기</button>
													</sec:authorize>
													<!-- 2022.01.18 관리자 등록 시 보고자 선택 가능 : END  -->
													<c:set var="rept_aprv_no" value="${loginVO.id }"/>
												</c:otherwise>
											</c:choose>
											<input type="hidden" id="rept_aprv_no" name="rept_aprv_no" value="${rept_aprv_no }" />
										</div>
									</div>
									<!-- 직위 및 보고자 END -->
									
									<!-- 결재구분 START -->
									<div class="col-lg-12 form-group">
										<div class="col-lg-2 col-sm-2 text-right">
											<label class="control-label">결재구분</label>
											<span class="req-sign">*</span>
										</div>
										<div class="col-lg-2">
											<c:if test="${params.mode eq mode_u}"><input type="hidden" name="cdList1" value="${viewMap.APRV_TYPE_CD }"></c:if>
											<select id="cdList1" name="cdList1" class="form-control" <c:if test="${params.mode eq mode_u}">disabled</c:if>>
													<option value="" >--1차 구분 선택--</option>
												<c:forEach var="codeList" items="${codeList}">
													<option value="${codeList.CD}" <c:if test="${viewMap.APRV_TYPE_CD eq codeList.CD }">selected</c:if>>${codeList.CD_NM}</option>
												</c:forEach>
											</select>
										</div>
										<div class="col-lg-2">
											<c:if test="${params.mode eq mode_u}">
												<input type="hidden" name="cdList2" value="${viewMap.APRV_TYPE_DTIL_CD }">
											</c:if>
											<c:if test="${not (params.mode eq mode_u && empty viewMap.APRV_TYPE_DTIL_CD) }"> 
												<select id="cdList2" name="cdList2" class="form-control" <c:if test="${params.mode eq mode_u}">disabled</c:if>>
													<option value="" >--2차 구분 선택--</option>
													<c:forEach var="codeList2" items="${codeList2}">
														<option value="${codeList2.CD}" <c:if test="${viewMap.APRV_TYPE_DTIL_CD eq codeList2.CD }">selected</c:if>>${codeList2.CD_NM}</option>
													</c:forEach>
												</select>
											</c:if>
										</div>
										<!--  반차여부 -->
										<input type="hidden" id="half_type_cd" name="half_type_cd" value="0" />
									</div>
									<!-- 결재 구분 END -->
									
									<!-- 제목 START -->
									<div class="col-lg-12 form-group">
										<div class="col-lg-2 col-sm-2 text-right">
											<label class="control-label">제목</label>
											<span class="req-sign">*</span>
										</div>
										<div class="col-lg-9">
											<input class="form-control" type="text" id="title" name="title" value="${viewMap.TITLE }"/>
										</div>
									</div>
									<!-- 제목 END -->
									
									<!-- 보고내용 START -->
									<div class="col-lg-12 form-group">
										<div class="col-lg-2 col-sm-2 text-right">
											<label class="control-label">보고내용</label>
											<span class="req-sign">*</span>
										</div>
										<div class="col-lg-9">
											<textarea class="form-control" name="rept_cont" id="rept_cont">${viewMap.REPT_CONT }</textarea>
										</div>
									</div>
									<!-- 보고내용 END -->
									
									<!-- 결재 구분에 따라 폼 추가될 영역 START -->
									<div id="docForm"></div>
									<!-- 결재 구분에 따라 폼 추가될 영역 END -->
									
									<!-- 첨부파일 START -->
									<div class="col-lg-12 form-group">
										<div class="col-lg-2 col-sm-2 text-right">
											<label class="control-label">첨부파일</label>
										</div>
										<div class="col-lg-9 file-list">
											<c:forEach var="file" items="${fileList }" varStatus="status">
												<div id="file_${file.FILE_NO }">
													<a href="#" onclick="fn_downFile('${file.FILE_PATH}', '${file.FILE_STRE_NM }', '${file.FILE_NM }')">${file.FILE_NM }</a> 
													<span class="file-btn">
														<button class="btn btn-xs btn-danger" onclick="fn_delFile('${file.FILE_PATH}', '${file.FILE_STRE_NM }', '${file.FILE_NO }', event)" >
															<i class="glyphicon glyphicon-remove"></i>
														</button>
													</span>
												</div>
											</c:forEach>
											<div id="my-file">
												<div class="file-form">
													<input type="file" name="file" id="file1" class="input-group" style="display: inline;">
													<span class="btn btn-xs btn-success file-btn" id="button-add-file"><i class="glyphicon glyphicon-plus"></i></span>
												</div>
											</div>
										</div>
									</div>
									<!-- 첨부파일 END -->
								</div>
								<div class="row col-lg-12">
									<div class="panel panel-default">
										<div class="panel-heading">결재라인</div>
										<div class="panel-body">
											<c:set var="lineVar" value="1" />
											<c:if test="${fn:length(lineList) > 0 }">
												<c:set var="lineVar" value="${fn:length(lineList) }" />
											</c:if>
											<input type="hidden" name="aprv_line_cnt" id="aprv_line_cnt" value="${lineVar }">
											
											<div class="table-responsive">
											<table id="aprv_line" class="table table-bordered">
											<thead>
												<tr role="row">
													<th>결재자</th>
													<th>순서</th>
													<th>상태</th>
													<th >
														<span class="">
															<c:if test="${viewMap.APRV_LINE_CD ne '3' }">
																<span class="btn btn-xs btn-default" onClick="addRow();"><i class="glyphicon glyphicon-plus-sign" ></i> 추가</span>
															</c:if>
														</span>
													</th>
												</tr>
											</thead>
											<tbody>
												<c:choose>
													<c:when test="${params.mode eq mode_u && fn:length(lineList) > 0 }">
														<!-- 수정 폼일경우 -->
														<c:forEach var="line" items="${lineList }" varStatus="status">
															<tr class="gradeA odd" role="row" onMouseOver="aprv_line.clickedRowIndex=this.rowIndex">
																<td class="sorting_1">
																	<input name="aprv_emp_no${status.count }" id="aprv_emp_no${status.count }" type="hidden" value="${line.APRV_EMP_NO }" />
																	<input name="aprv_emp_no${status.count }_nm" id="aprv_emp_no${status.count }_nm" type="text" value="${line.USS_NM }" class="i_text form-control table-cell" readonly="readonly" />
																	<!-- 반려일경우 결재자 추가 삭제 막음 -->
																	<c:if test="${viewMap.APRV_LINE_CD ne '3' }">
																			<input type="button" value="찾기" class="btn btn-default btn-sm" onclick="fn_ussSearch('aprv_emp_no${status.count }')" />
																			<input type="checkbox" id="refe_yn${status.count }" name="refe_yn${status.count }" value="Y" onclick="fn_order(this)" <c:if test="${line.REFE_YN eq 'Y' }">checked="checked"</c:if> /><label for="refe_yn${status.count }">참조인</label>
																	</c:if>
																	<c:if test="${viewMap.APRV_LINE_CD eq '3' }">
																			<input type="checkbox" id="refe_yn${status.count }" name="refe_yn${status.count }" value="Y" onclick="return false;"  <c:if test="${line.REFE_YN eq 'Y' }">checked="checked"</c:if> /><label for="refe_yn${status.count }">참조인</label>
																	</c:if>
																</td>
																<td><input name="aprv_ordr${status.count }" id="aprv_ordr${status.count }" type="text" value="${line.APRV_ORDR }" class="i_text form-inline input-sm"  readonly /></td>
																<td><input name="aprv_yn_cd${status.count }" id="aprv_yn_cd${status.count }" type="hidden" value="${line.APRV_YN_CD }" class="i_text" /></td>
																<td><i class="glyphicon glyphicon-minus-sign"></i>
																	<!-- 반려일경우 결재자 추가 삭제 막음 -->
																	<c:if test="${viewMap.APRV_LINE_CD ne '3' }">
																		<c:if test="${status.count > 1 }">	<!-- 첫번재 결재자는 삭제 안됨. -->
																			<input type="button" class="btn bnt-xs btn-default" value="삭제" onClick="delRow()" />
																		</c:if>
																	</c:if>
																</td>
															</tr>
														</c:forEach>
													</c:when>
														<c:otherwise>
														<!-- 등록폼일경우 -->
														<c:choose>
															<c:when test="${not empty lineInfoList }"> <!-- 결재라인 정보가 디비에 등록되어 있는 경우 -->
																<c:forEach var="lineInfo" items="${lineInfoList }" varStatus="status">
																	<tr class="gradeA odd" role="row" onMouseOver="aprv_line.clickedRowIndex=this.rowIndex">
																		<td>
																			<input name="aprv_emp_no${status.count }" id="aprv_emp_no${status.count }" type="hidden" value="${lineInfo.APRV_EMP_NO }" />
																			<input name="aprv_emp_no${status.count }_nm" id="aprv_emp_no${status.count }_nm" class="form-control table-cell input-sm" type="text" value="${lineInfo.APRV_EMP_NM }" />
																			<input type="button" class="btn btn-default btn-sm" value="찾기" onclick="fn_ussSearch('aprv_emp_no${status.count }')" />
																			<input type="checkbox" id="refe_yn${status.count }" name="refe_yn${status.count }" value="Y" onclick="fn_order(this)" <c:if test="${lineInfo.REFE_YN eq 'Y' }">checked</c:if>/>
																			<label for="refe_yn${status.count }">참조인</label>
																		</td>
																		<td style="text-align: center;">
																			<input name="aprv_ordr${status.count }" id="aprv_ordr${status.count }" type="text" 
																			value="<c:choose><c:when test="${lineInfo.REFE_YN eq 'Y' }">0</c:when><c:otherwise>${lineInfo.APRV_ORDR }</c:otherwise></c:choose>" class="form-control" readonly />
																		</td>
																		<td style="text-align: center;">
																			<input name="aprv_yn_cd${status.count }" id="aprv_yn_cd${status.count }" type="hidden" value="0" class="i_text"/>
																			<span>대기</span>
																		</td>
																		<td>
																			<c:if test="${status.count != 1 }">
																				<span class="btn btn-xs btn-default" onclick="delRow()"><i class="glyphicon glyphicon-remove">삭제</i></span>
																			</c:if>
																		</td>
																	</tr>
																</c:forEach>
															</c:when>
															<c:otherwise> <!-- 결재라인 정보가 디비에 없는 경우 -->
																<tr>
																	<td>
																		<input name="aprv_emp_no1" id="aprv_emp_no1" type="hidden" value="" />
																		<input name="aprv_emp_no1_nm" id="aprv_emp_no1_nm" class="form-control table-cell input-sm" type="text" value="" />
																		<input type="button" class="btn btn-default btn-sm" value="찾기" onclick="fn_ussSearch('aprv_emp_no1')" />
																		<span style="display:none">
																			<input type="checkbox" id="refe_yn1" name="refe_yn1" value="Y" onclick="fn_order(this)" /><label for="refe_yn1">참조인</label>
																		</span>
																	</td>
																	<td style="text-align: center;">
																		<input name="aprv_ordr1" id="aprv_ordr1" type="text" value="1" class="form-control" readonly />
																	</td>
																	<td style="text-align: center;">
																		<input name="aprv_yn_cd1" id="aprv_yn_cd1" type="hidden" value="0" class="i_text"/>
																		<span>대기</span>
																	</td>
																	<td></td>
																</tr>
															</c:otherwise>
														</c:choose>
													</c:otherwise>
												</c:choose>
											</tbody>
										</table>
										</div>
									</div>
								</div>
							</div>
							<div class="row col-lg-12">
								<span class="pull-right">
									<c:set var="btnVal" value="저장" />
									<c:if test="${viewMap.APRV_LINE_CD eq '3' }">	<!-- 반려일경우 -->
										<c:set var="btnVal" value="재결재" />
									</c:if>
									<input type="button" id="btn-ok" name="btn-ok" class="btn btn-sm btn-info" value="${btnVal }"/>
									<input type="button" id="btn-cancel" name="btn-cancel" class="btn btn-sm btn-default " value="취소" onclick="javascript:self.location='index.html'"/>
<%--
 							    <input  class="btn-ok btn btn_info" type="button" value="${btnVal }" />
							    <input class="btn-cancel btn btn_default"  type="button" value="취소" />
 --%>
								</span>
							</div>
							<p class="clearfix"/>
						</div>
					</form>
				</div>
				<jsp:include page="/resources/com/inc/aside.jsp" />
			</div>
		</div>
		<jsp:include page="/resources/com/inc/footer.jsp" />
	</div>
<form id="ussFrm" name="ussFrm" method="post" action="${pageContext.request.contextPath}/uss/umt/uss00Popup.do" >
	<input type="hidden" id="not_uss_id" name="not_uss_id" value="" />
</form>
<!-- 파일 다운로드 form Start -->
<form id="downFrm" name="downFrm" method="post" action="${pageContext.request.contextPath}/cmm/FileDown.do">
	<input type="hidden" name="file_path" id="file_path" value="" /><!-- 파일위치 -->
	<input type="hidden" name="file_stre_nm" id="file_stre_nm" value="" /><!-- 저장된파일명 -->
	<input type="hidden" name="file_nm" id="file_nm" value="" /><!-- 원문파일명 -->
</form>
<!-- 파일 다운로드 form End -->

<!-- js파일 및 공통스크립트사용 -->
<jsp:include page="/resources/com/inc/javascript.jsp" />

<script type="text/javascript">
$(function() {
	// 저장	
	$("#btn-ok").click(function() {
		document.frm1.aprv_line_cnt.value = aprv_line.rows.length-1; 
		var vali1 = getValidation1(); // 공통
		var vali2 = getValidation2(vali1); // 개별
		if(vali1 && vali2){
			if($("#mode").val() == "<%=VarConsts.MODE_U%>") {
			} else {
				$("#mode").val("<%=VarConsts.MODE_I%>");	
			}
			// datepicker의 시간을 yyyyMMdd, hhmm으로 구분하여 저장
			var cd1 = $("#cdList1").val();
			if(cd1 != "<%=VarConsts.EAM_VACATION_CODE%>"){
				if($("#term_st").size() == "1" && $("#term_st").val() != "" && $("#term_ed").val() != "") { // 기간을 사용하지 않는 양식인지 확인
					var term_st = $("#term_st").val();
					var term_st_ym = term_st.split(" ")[0];
					var term_st_hm = term_st.split(" ")[1].replace(":", "");
					$("#term_st_ym").val(term_st_ym);
					$("#term_st_hm").val(term_st_hm);
					var term_ed = $("#term_ed").val();
					var term_ed_ym = term_ed.split(" ")[0];
					var term_ed_hm = term_ed.split(" ")[1].replace(":", "");
					$("#term_ed_ym").val(term_ed_ym);
					$("#term_ed_hm").val(term_ed_hm);
				}
			}else{
				var term_st = $("#term_st").val();
				$("#term_st_ym").val(term_st);
				var term_ed = $("#term_ed").val();
				$("#term_ed_ym").val(term_ed);
			}
			
			$("#frm1").attr("action", "${pageContext.request.contextPath}/aprv/aprv00Tran.do");
			$("#frm1").submit();
		}
	});
	
	// 취소
	$("#btn-cancel").click(function() {
		if($("#mode").val() == "<%=VarConsts.MODE_U%>"){
			/* 수정 폼일경우 상세화면으로 이동 */
			$("#frm1").attr("action", "${pageContext.request.contextPath}/aprv/aprv00View.do");
		}else{
			/* 입력 폼일경우 목록화면으로 이동 */
			$("#frm1").attr("action", "${pageContext.request.contextPath}/aprv/aprv00List.do");	
		}
		$("#frm1").removeAttr("enctype");
		$("#frm1").submit();
	});
	
	// 첨부파일 추가 삭제 기능
	var count = 0;
	$('#button-add-file').click(function() {
		var html = "<div id='file_"+count+"'>";
		html += "<input type='file' name='file"+count+"' id='file"+count+"' class='input-group' style='display: inline;' />";
		html += "<span class='btn btn-xs btn-danger file-btn button-delete-file'><i class='glyphicon glyphicon-remove'></i></span>";
		html += "</div>";
		count++;
		$("#my-file").append(html);
	});
	$(document).on('click', '.button-delete-file', function(event) {
		$(this).parent().remove();
	});
	
	// 수정
	if($("#mode").val() == "<%=VarConsts.MODE_U%>" ) {
		fn_getDocCode($("#cdList1").val(), $("#cdList2").val()); // 문서 양식 불러와서 HTML에 찍어줌
		
		var docJson = ${docJson };	 // 컨트롤러에서 받아온 문서에 대한 json
		var viewJson = ${viewJson }; // 컨트롤러에서 받아온 결재에 대한 json
		var vacTermList = ${jsonVacTerm}; // 휴가 기간 구분 코드 콕록
		
		for(key in docJson){
			if(key != "items") { // 항목인지 확인
				$("#" + key.toLowerCase()).val(docJson[key]);
			} else {
				if($("#cdList1").val() == "CD0001009" && ($("#cdList2").val() == "CD0001009001" || $("#cdList2").val() == "CD0001009002")) {
					fn_addBztrpItem2(docJson[key]);
				}
			}
		}
		
		if($("#place").size() == "1") { // 행선지 이용하는 양식인지 확인
			$("#place").val(viewJson["PLACE"]);
		}
		if($("#term_st").size() == "1") { // 기간을 사용하지 않는 양식인지 확인
			var term_st_ym;
			var term_ed_ym;
			var cd1 = viewJson["APRV_TYPE_CD"];
			//tui.date-picker
			if(viewJson["TERM_ST_YM"] != null) {
				if(cd1 != "<%=VarConsts.EAM_VACATION_CODE%>"){
					term_st_ym = new Date(viewJson["TERM_ST_YM"] + " " + viewJson["TERM_ST_HM"].substring(0, 2) + ":" + viewJson["TERM_ST_HM"].substring(2, 4));
					term_ed_ym = new Date(viewJson["TERM_ED_YM"] + " " + viewJson["TERM_ED_HM"].substring(0, 2) + ":" + viewJson["TERM_ED_HM"].substring(2, 4))
				}else{
					term_st_ym = new Date(viewJson["TERM_ST_YM"]);
					term_ed_ym = new Date(viewJson["TERM_ED_YM"]);
				}
			}
			
			var html = "<div id='vacTermSt'>";
			var html2 = "<div id='vacTermEd'>";
			
			html += "<hr/>";
			html2 += "<hr/>";
			
			var picker = null;
			
			if(cd1 != "<%=VarConsts.EAM_VACATION_CODE%>"){
				picker = tui.DatePicker.createRangePicker({
					language: 'ko',
					startpicker: {
						input: '#term_st',
						container: '#startpicker-container',
						date: term_st_ym
					},
					endpicker: {
						input: '#term_ed',
						container: '#endpicker-container',
						date: term_ed_ym
					},
					type: 'date',
				    format: 'yyyy-MM-dd hh:mm',
					timepicker: {
						language: 'ko',
						showMeridiem: false,
						minuteStep: 10
					}
				});				
			}else{
				picker = tui.DatePicker.createRangePicker({
					language: 'ko',
					startpicker: {
						input: '#term_st',
						container: '#startpicker-container',
						date: term_st_ym
					},
					endpicker: {
						input: '#term_ed',
						container: '#endpicker-container',
						date: term_ed_ym
					},
					type: 'date',
					foramt : 'yyyy-MM-dd'
				});	
			}	
			//휴가일경우
			if(cd1 == "<%=VarConsts.EAM_VACATION_CODE%>"){
				html += '<div class="select-box">';
				html += '<select name="half_type_cd_st" id="half_type_cd_st" class="half_type_cd_st half_type_cd form-control vac-term">';
				html += '<option  class="half_type_cd_st_opt" value="" cnt="" nm="">선택</option>';
				html2 += '<div class="select-box">';
				html2 += '<select name="half_type_cd_ed" id="half_type_cd_ed" class="half_type_cd_ed half_type_cd form-control vac-term">';
				html2 += '<option  class="half_type_cd_ed_opt" value="" cnt="" nm="">선택</option>';
				
				
				for(var i in vacTermList){
					var vacTerm = vacTermList[i];
					
					html += '<option class="half_type_cd_st_opt" id="half_type_cd_st_'+vacTerm.CD+'" value="'+vacTerm.CD+'" cnt="'+vacTerm.CD_VAL+'" nm="'+vacTerm.CD_NM+'">'+vacTerm.CD_NM+'</option>';
					html2 += '<option class="half_type_cd_ed_opt" id="half_type_cd_ed_'+vacTerm.CD+'" value="'+vacTerm.CD+'" cnt="'+vacTerm.CD_VAL+'" nm="'+vacTerm.CD_NM+'">'+vacTerm.CD_NM+'</option>';
					
				}
				
				html += '</select>';
				html2 += '</select>';
				html += '</div>';
				html2 += '</div>';
				
				$("#startpicker-container .tui-rangepicker").append(html);
				$("#endpicker-container .tui-rangepicker").append(html2);

				
				$("#startpicker-container table.tui-calendar-body-inner").addClass("startpicker-selectable");
				$("#endpicker-container table.tui-calendar-body-inner").addClass("endpicker-selectable");
				
				$("#half_type_cd_st_"+viewJson["HALF_TYPE_CD"]).prop("selected", true);
				$("#half_type_cd_ed_"+viewJson["HALF_TYPE_CD_ED"]).prop("selected", true);
				
				fn_calcVacDay();
			}
			
			$("#term_ed").attr("disabled", false);
		}
		//가지급금 상세 불러오기
		if($("#cdList1").val() == "CD0001010") {
			//console.log("가지급금");
			fn_addTmpPayItem(docJson, viewJson);
		}
	}
	
	// validation으로 error class가 추가된 div에 내용이 변경되면 error class를 지워줌
	$("body").on("propertychange change keyup paste input", ".has-error", function() {
		$(this).closest(".form-group").removeClass("has-error")
	});
	$("body").on("click", "#term_st, #term_ed", function() {
		$(this).closest(".form-group").removeClass("has-error")
	});
	$("body").on("click", ".st-dt, .ed-dt", function() {
		$(this).closest(".form-group").removeClass("has-error")
	});
	$("body").on("click", "#pay_dt", function() {
		$(this).closest(".form-group").removeClass("has-error");		
	})
	$("body").on("change", ".cd2", function() {
		$(this).parents("tr").find(".rmk4").closest(".form-group").removeClass("has-error");
		//$(this).closest(".form-group").removeClass("has-error");		
		
	})
});

// 1차 코드 선택
$("#cdList1").change(function() {
	var cd1 = $(this).val(); // 1차 코드
	
	// 2차 코드 초기화
	$("#cdList2").find('option').each(function(){
		$(this).remove();	
	});
	$("#cdList2").append("<option value=''>--2차 구분 선택--</option>");
	
	$.ajax({ // 2차 코드 
		type:'get',
		url:'${pageContext.request.contextPath}/option/getCodeList.do?cd='+cd1,
		dataType:'json',
		success: function(json){
			var data = json.codeList;
			if(data==""){ // 2차 코드가 없을 때 ==> 2차 셀렉트 박스를 제거하고 해당 양식의 코드를 찍어줌
				data=0;
				$("#cdList2").css("display", "none");
				fn_getDocCode($("#cdList1").val(), null); // 문서 양식 불러와서 HTML에 찍어줌
			} else { // 2차 코드가 존재할 때 ==> 2차 셀렉트 박스만 출력함
				$("#cdList2").css("display", "");
				for(var i=0; i<data.length; i++){
					$("#cdList2").append("<option value='"+ data[i]['CD'] + "' >" + data[i]['CD_NM'] + "</option>");
				}
			}
		}
	});
});

// 2차 코드 선택
$("#cdList2").change(function() { 
	fn_getDocCode($("#cdList1").val(), $("#cdList2").val()); // 문서 양식 불러옴(2가지 경우 중 두번째)
});

/*2022.01.18 휴가 기간 선택에 따른 사용일수 계산 : BEGIN*/
// 휴가 기간 선택

function fn_calcVacDay(){
	//시작일자
	var termSt = $("#term_st").val();
	//console.log(termSt);
	//종료일자
	var termEd = $("#term_ed").val();
	//console.log(termEd);
	//시작일자휴가기간코드
	var halfTypeCdSt = $(".half_type_cd_st_opt:selected").attr('cnt');
	//console.log(halfTypeCdSt);
	//종료일자휴가기간코드
	var halfTypeCdEd = $(".half_type_cd_ed_opt:selected").attr('cnt');
	//console.log(halfTypeCdEd);
	
	var dayCnt = 0;
	
	
	if(termSt == null || termSt == ""){
		return false;
	}
	
	if(termEd == null || termEd == ""){
		return false;
	}
	
	if(halfTypeCdSt == null || halfTypeCdSt == ""){
		return false;
		
	}
	
	if(halfTypeCdEd == null || halfTypeCdEd == ""){
		return false;
	}
	
	var stDate = new Date(termSt);
	var edDate = new Date(termEd);
	var diffDate = (edDate - stDate) / (1000 * 60 * 60 * 24) -1;
	dayCnt = parseFloat(halfTypeCdSt) + parseFloat(halfTypeCdEd) + diffDate;
	
	$("#day_cnt").val(dayCnt);
	
	
	/*구하는 법 : (종료일자 - 시작일자 - 1) + 시작기간코드값 + 종료기간코드값*/
	
}
/*2022.01.18 휴가 기간 선택에 따른 사용일수 계산 : END*/



/*2022.01.18 반차구분코드 변경 시 사용일수 계산 함수 : BEGIN */
$(document).on('change', ".vac-term", function(){
	fn_calcVacDay();
	var halfTypeNmSt = $(".half_type_cd_st_opt:selected").attr("nm");
	var halfTypeNmEd = $(".half_type_cd_ed_opt:selected").attr("nm");
	$(".half_type_nm_st").text(halfTypeNmSt);
	$(".half_type_nm_ed").text(halfTypeNmEd);
	
});
	
$(document).on('click', '.tui-calendar-date', function(e){
	fn_calcVacDay();
	var halfTypeNmSt = $(".half_type_cd_st_opt:selected").attr("nm");
	var halfTypeNmEd = $(".half_type_cd_ed_opt:selected").attr("nm");
	$(".half_type_nm_st").text(halfTypeNmSt);
	$(".half_type_nm_ed").text(halfTypeNmEd);
});
/*2022.01.18 반차구분코드 변경 시 사용일수 계산 함수 : END */



/*2022.01.21 캘린더 버튼 이벤트 버블링 방지 : BEGIN*/
//캘린더 이전 월, 다음 월 버튼 클릭 시 submit 이벤트 방지	
$(document).on('click', '.tui-calendar-btn', function(e){
	e.preventDefault();
});	
	
//모바일에서 캘린더 날짜 선택 시 이벤트 겹침 방지
$(document).on('touchend', '.tui-calendar-date', function(e){
	e.preventDefault();
});	
/*2022.01.21 캘린더 버튼 이벤트 버블링 방지 : END*/


//공휴일 정보 불로오기
function fn_loadHolMng(trgt){
	var prnt = "#"+trgt;
	
	var stddYr = $(prnt+" .tui-calendar-title").text();
	stddYr = stddYr.substr(0,4);
	//console.log(stddYr);
	
	$.ajax({
		url: "${pageContext.request.contextPath}/cal/hol00Ajax.do",
		type: "post",
		dataType : "json", 
		async : false,
		data : {"stdd_yr" : stddYr},
		success: function(result){
			holList = result.jsonList;
			//console.log(holList);
			if(holList != null){
				for(var i = 0; i< holList.length ; i++){
					var hol = holList[i];
					var holDt = hol.CAL_HOL_DT;
					var holNm = hol.CAL_HOL_NM;
					var year = parseInt(holDt.substr(0, 4));
					var mon = parseInt(holDt.substr(4, 2));
					var date = parseInt(holDt.substr(6, 2));
					
					var dt = new Date(year, mon-1, date, 0, 0, 0);
					var timestamp = dt.getTime();
					//var text = "<div class='cal-nm' style='font-size : 5px; text-align:center;'>"+holNm+"</div>";
					$(prnt+" td.tui-calendar-date[data-timestamp='"+timestamp+"']").css({"color" : "red"}).attr("title", holNm);
				}
				
			}else{
				alert("공휴일 정보가 등록되지 않았습니다. 공휴일 정보를 먼저 등록해주세요.");
			}
			
			
		},error: function (request, status, error) {
			alert("공휴일 정보 불러오기를 실패했습니다.");
			//alert(request.responseText);
		} 
	});
	
	
}


// 문서 양식을 불러옴(cdList1, cdList2가 변할 때 마다 호출)
function fn_getDocCode(cd1, cd2) {
	var vacTermList= null ;
	var html = "";
	var html2 = "";
	$.ajax({
		type:'get',
		async: false,
		url:'${pageContext.request.contextPath}/doc/doc00Ajax.do?APRV_TYPE_CD='+cd1+'&APRV_TYPE_DTIL_CD='+cd2,
		success: function(json){
			// cd1, cd2에 해당하는 문서 양식을 화면에 찍어줌
			$("#docForm").empty();
			$("#docForm").append(json);
			if(cd1 == "<%=VarConsts.EAM_VACATION_CODE %>"){
				html = "<div id='vacTermSt'>";
				html2 = "<div id='vacTermEd'>";
				
				html += "<hr/>";
				html2 += "<hr/>";
			
				//vacTermList = ${jsonVacTerm};
				vacTermList = jsonVacCdList;
				//console.log (vacTermList);
				
			}
			//console.log("화명end:");

			// 화면에 찍은 양식에서 date picker를 사용할 때 라이브러리를 초기화 시킴 
			if($("#term_st").length > 0) {
				var picker = null;
				if(cd1 != "<%=VarConsts.EAM_VACATION_CODE%>"){
					picker = tui.DatePicker.createRangePicker({
						language: 'ko',
						startpicker: {
							input: '#term_st',
							container: '#startpicker-container'
						},
						endpicker: {
							input: '#term_ed',
							container: '#endpicker-container'
						},
						type: 'date',
						format: 'yyyy-MM-dd hh:mm',
					    timepicker: {
								language: 'ko',
								showMeridiem: false,
								minuteStep: 10
						}
							
					});
				}else{
					picker = tui.DatePicker.createRangePicker({
						language: 'ko',
						startpicker: {
							input: '#term_st',
							container: '#startpicker-container'
						},
						endpicker: {
							input: '#term_ed',
							container: '#endpicker-container'
						},
						type: 'date',
						format: 'yyyy-MM-dd'
					   
							
					});
				}
				
				//tui.date-picker
			}
			
			if(cd1 == "<%=VarConsts.EAM_VACATION_CODE%>"){
				html += '<div class="select-box">';
				html += '<select name="half_type_cd_st" id="half_type_cd_st" class="half_type_cd_st half_type_cd form-control vac-term">';
				html += '<option  class="half_type_cd_st_opt" value="" cnt="" nm="">선택</option>';
				html2 += '<div class="select-box">';
				html2 += '<select name="half_type_cd_ed" id="half_type_cd_ed" class="half_type_cd_ed half_type_cd form-control vac-term">';
				html2 += '<option  class="half_type_cd_ed_opt" value="" cnt="" nm="">선택</option>';
				
				for(var i in vacTermList){
					var vacTerm = vacTermList[i];
					
					html += '<option class="half_type_cd_st_opt" id="half_type_cd_st_'+vacTerm.CD+'" value="'+vacTerm.CD+'" cnt="'+vacTerm.CD_VAL+'" nm="'+vacTerm.CD_NM+'">'+vacTerm.CD_NM+'</option>';
					html2 += '<option class="half_type_cd_ed_opt" id="half_type_cd_ed_'+vacTerm.CD+'" value="'+vacTerm.CD+'" cnt="'+vacTerm.CD_VAL+'" nm="'+vacTerm.CD_NM+'">'+vacTerm.CD_NM+'</option>';
					
				}
				
				html += '</select>';
				html2 += '</select>';
				html += '</div>';
				html2 += '</div>';
				
				$("#startpicker-container .tui-rangepicker").append(html);
				$("#endpicker-container .tui-rangepicker").append(html2);
				
				$("#startpicker-container table.tui-calendar-body-inner").addClass("startpicker-selectable");
				$("#endpicker-container table.tui-calendar-body-inner").addClass("endpicker-selectable");
				
				$("#half_type_cd_st_CD0021001").prop('selected', true);
				$("#half_type_cd_ed_CD0021001").prop('selected', true);
			}
			//가지급금 지급희망일자 datepicker
			if($("#pay_dt").length > 0) {
				//tui.date-picker
				var picker = new tui.DatePicker("#startpicker-container2", {
					language: 'ko',
					input : {
						element: '#pay_dt',
						format : 'yyyy-MM-dd'
					}
				});
			}

			// 문서 양식에 따라 title 양식 설정(경영지원실 요청사항)
			if(!($("#mode").val() == '<%=VarConsts.MODE_U%>')) {
				var title = "";
				if(cd1 == "CD0001001") { // 업무보고
					if(cd2 == "CD0001001001") { // 주간
						title = "00월_업무보고_주간_0주차";
					} else if(cd2 == "CD0001001002") { // 월간
						title = "00월_업무보고_월간";
					}
				} else if(cd1 == "CD0001007") { // 지출결의
					if(cd2 == "CD0001007001") { // 법인
						title = "";
					} else if(cd2 == "CD0001007002") { // 일반(개인)
						title = "";
					} else if(cd2 == "CD0001007003") { // 송금
						title = "";
					}
				} else if(cd1 == "CD0001008") { // 품의
					if(cd2 == "CD0001008001") { // 구매
						title = "00월_품의_OO(법인,일반,송금)_구매";
					} else if(cd2 == "CD0001008002") { // 회식
						title = "00월_품의_OO(법인,일반,송금)_회식";
					}
				} else if(cd1 == "CD0001009") { // 출장
					if(cd2 == "CD0001009001") { // 출장정산(국내)
						title = "00월_출장정산서(국내)_법인";
					} else if(cd2 == "CD0001009002") { // 출장정산(국내)
						title = "00월_출장정산서(국내)_일반";
					} else if(cd2 == "CD0001009003") { // 출장계획(해외)
						title = "00월_출장계획서(해외)_OO(법인,송금)";
					}
				} else if(cd1 == "CD0001010") { // 가지급금
					title = "00월_가지급금신청_OO(송금,법인)";
				} else if(cd1 == "CD0001011") { // 휴가신청
					if(cd2 == "CD0001011001") { // 연차
						title = "00월_휴가신청_연차";
					} else if(cd2 == "CD0001011002") { // 병가
						title = "00월_휴가신청_병가";
					} else if(cd2 == "CD0001011003") { // 기타(경조사)
						title = "00월_휴가신청_경조";
					} else if(cd2 == "CD0001011004") { // 대체휴가
						title = "00월_휴가신청_기타";
					} else if(cd2 == "CD0001011005") { // 위로휴가
						title = "00월_휴가신청_기타";
					} else if(cd2 == "CD0001011006") { // 가족돌봄휴가
						title = "00월_휴가신청_기타";
					}
				} else if(cd1 == "CD0001012") { // 휴직신청
					if(cd2 == "CD0001012001") { // 남성육아휴직
						title = "00월_휴직신청_육아휴직";
					} else if(cd2 == "CD0001012002") { // 가족돌봄휴직
						title = "00월_휴직신청_가족돌봄";
					}
				} else if(cd1 == "CD0001013") { // 유연근무제신청
					if(cd2 == "CD0001013001") { // 시차출퇴근제
						title = "00월_시차출퇴근신청";
					} else if(cd2 == "CD0001013003") { // 조기퇴근제
						title = "00월_조기퇴근신청";
					}
				} else if(cd1 == "CD0001014") { // 기타
					title = "";
				} else if(cd1 == "CD0001015") { // 도서
					title = "00월_도서구매신청";
				} else if(cd1 == "CD0001016") { // 교육훈련신청
					title = "00월_교육훈련신청";
				} 
				
				var date = new Date();
				var year = date.getFullYear();
				var month = ("0" + (1 + date.getMonth())).slice(-2);
				var day = ("0" + date.getDate()).slice(-2);
				var yyyymmdd = year + month + day;
				if(title != "") {
					title += "_" + yyyymmdd
				};

				$("#title").val(title);
				//가지급금 양식 로드
// 				if("CD0001010" == cd1){
// 					fn_getDocTmplt(cd1, null);
// 				}
				
			}
		}
	});
};

// 파일 삭제
function fn_delFile(file_path, file_stre_nm, file_no, event){
	/* 19.08.02	김지연	파일 삭제시 목록으로 이동하는 문제 해결
		원인 : 클릭 이벤트 전파
		해결 : event.preventDefault() 추가
	 */
	event.preventDefault();
	if(confirm("해당 파일을 삭제하시겠습니까?")){			
		$.ajax({
			url: "${pageContext.request.contextPath}/aprv/aprv01Ajax.do",
			type: "post",
			dataType : "json", 
			data : {"file_path":file_path, "file_stre_nm":file_stre_nm, "file_no":file_no},
			success: function(result){
				
				$("#file_"+file_no).remove();
				
			},error: function (request, status, error) {
				alert("삭제에 실패 했습니다.");
//					alert(request.responseText);
			} 
		});
	}
}

// 결재자 검색
var div_id = "";
function fn_ussSearch(no){
	div_id = no;
	window.open("", "uss00Popup","width=1300, height=750");
	$("#ussFrm").attr("target", "uss00Popup");
	$("#not_uss_id").val($("#rept_aprv_no").val());
	$("#ussFrm").attr("action", "${pageContext.request.contextPath}/search/uss00Popup.do");
	$("#ussFrm").submit();
}
function setUssForm(id, nm, authNm, deptNm, authCd, deptCd){

	$("#"+div_id).val(id);
	$("#"+div_id+"_nm").val(nm);
	/*2022.01.18 관리자 결재 등록 시 보고자 선택 후 부서정보 및 권한 정보 수정:BEGIN*/	
	var loginAuthCd = "${loginVO.authCd}";
	if(loginAuthCd == 'ROLE_ADMIN' && div_id == 'rept_aprv_no' ){
		$("#rept_dp_nm").val(deptNm);
		$("#rept_auth_nm").val(authNm);
		$("#rept_dp_cd").val(deptCd);
		$("#rept_auth_cd").val(authCd);
	}
	/*2022.01.18 관리자 결재 등록 시 보고자 선택 후 부서정보 및 권한 정보 수정:END*/	
	
}

// 파일 다운로드
function fn_downFile(file_path, file_stre_nm, file_nm){
	$("#file_path").val(file_path);
	$("#file_stre_nm").val(file_stre_nm);
	$("#file_nm").val(file_nm);
	$("#downFrm").submit();
}

// 결재라인 추가
function addRow() {
	var nextRows = aprv_line.rows.length;
	
	// 결재라인 개수 설정
	document.frm1.aprv_line_cnt.value = nextRows;
	
	var oRow = aprv_line.insertRow();
	oRow.onmouseover=function(){aprv_line.clickedRowIndex=this.rowIndex};
	 
	var oCell1 = oRow.insertCell(0);
	var oCell2 = oRow.insertCell(1);
	var oCell3 = oRow.insertCell(2);
	var oCell4 = oRow.insertCell(3);
	
	oCell2.style.cssText = "text-align:center;";
	oCell3.style.cssText = "text-align:center;";
	
	oCell1.innerHTML = "<input name='aprv_emp_no"+ nextRows +"' id='aprv_emp_no"+ nextRows +"' type='hidden' />"
					 + "<input name='aprv_emp_no"+ nextRows +"_nm' id='aprv_emp_no"+ nextRows +"_nm' type='text' class='form-control table-cell input-sm' />&nbsp;"
					 + "<input type='button' class='btn btn-default btn-sm' value='찾기' onclick=\"fn_ussSearch('aprv_emp_no"+ nextRows +"')\" />&nbsp;&nbsp;"
					 + "<input type='checkbox' id='refe_yn"+ nextRows +"' name='refe_yn"+ nextRows +"' value='Y' onclick='fn_order(this)' />"
					 + "<label for='refe_yn"+ nextRows +"'>참조인</label>";
	oCell2.innerHTML = "<input name='aprv_ordr"+ nextRows +"' id='aprv_ordr"+ nextRows +"' value='"+ nextRows +"' type='text' class='form-control input-sm' readonly />";
	oCell3.innerHTML = "대기<input name='aprv_yn_cd"+ nextRows +"' id='aprv_yn_cd"+ nextRows +"' type='hidden' value='0' />";
	oCell4.innerHTML = "<span class='btn btn-xs btn-default' onClick='delRow()'><i class='glyphicon glyphicon-remove' >삭제</i></span>";
	
	var cnt = 1;
	for(var i = 1; i < aprv_line.rows.length; i++) {
		if($("#refe_yn"+i).is(":checked")){
		}else{
			aprv_line.rows[i].cells[1].innerHTML = "<input name='aprv_ordr"+ i +"' id='aprv_ordr"+ i +"' value='"+ cnt +"' type='text' class='form-control input-sm' readonly />";
			cnt++;
		}
	}
}

// 결재라인 삭제
function delRow() {
	aprv_line.deleteRow(aprv_line.clickedRowIndex);
	for(var i = aprv_line.clickedRowIndex; i < aprv_line.rows.length; i++) {
		var checkVal = "";
		
		if($("#refe_yn"+(i+1)).is(":checked")){			
			checkVal = "checked='checked'";
		}

		aprv_line.rows[i].cells[0].innerHTML = "<input name='aprv_emp_no"+ i +"' id='aprv_emp_no"+ i +"' value='"+$("#aprv_emp_no"+(i+1)).val()+"' type='hidden' />"
				+ "<input name='aprv_emp_no"+ i +"_nm' id='aprv_emp_no"+ i +"_nm' type='text' value='"+$("#aprv_emp_no"+(i+1)+"_nm").val()+"' class='form-control table-cell input-sm' />&nbsp;"
				+ "<input type='button' class='btn btn-default btn-sm' value='찾기' onclick=\"fn_ussSearch('aprv_emp_no"+ i +"')\" />&nbsp;&nbsp;"
				+ "<input type='checkbox' id='refe_yn"+ i +"' name='refe_yn"+ i +"' value='Y' onclick='fn_order(this)' "+checkVal+" />"
				+ "<label for='refe_yn"+ i +"'>참조인</label>";
		aprv_line.rows[i].cells[1].innerHTML = "<input name='aprv_ordr"+ i +"' id='aprv_ordr"+ i +"' value='"+ i +"' type='text' class='form-control input-sm' readonly />";
		aprv_line.rows[i].cells[2].innerHTML = "대기<input name='aprv_yn_cd"+ i +"' id='aprv_yn_cd"+ i +"' type='hidden' value='0' />";
		aprv_line.rows[i].cells[3].innerHTML = "<span class='btn btn-xs btn-default' onClick='delRow()'><i class='glyphicon glyphicon-remove' >삭제</i></span>";
	}
	var cnt = 1;
	for(var i = 1; i < aprv_line.rows.length; i++) {
		if($("#refe_yn"+i).is(":checked")){
			aprv_line.rows[i].cells[1].innerHTML = "<input name='aprv_ordr"+ i +"' id='aprv_ordr"+ i +"' value='0' type='text' class='form-control input-sm' readonly />";
		}else{
			aprv_line.rows[i].cells[1].innerHTML = "<input name='aprv_ordr"+ i +"' id='aprv_ordr"+ i +"' value='"+ cnt +"' type='text' class='form-control input-sm' readonly />";
			cnt++;
		}
	}
	// 결재라인 개수 설정
	document.frm1.aprv_line_cnt.value = aprv_line.rows.length-1;
}

function fn_order(obj){
	var cnt = 1;
	if($(obj).is(":checked")){
		for(var i = 1; i < aprv_line.rows.length; i++) {
			if(i == aprv_line.clickedRowIndex || $("#refe_yn"+i).is(":checked")){
				aprv_line.rows[i].cells[1].innerHTML = "<input name='aprv_ordr"+ i +"' id='aprv_ordr"+ i +"' value='0' type='text' class='form-control input-sm' readonly />";
			}else{
				aprv_line.rows[i].cells[1].innerHTML = "<input name='aprv_ordr"+ i +"' id='aprv_ordr"+ i +"' value='"+ cnt +"' type='text' class='form-control input-sm' readonly />";
				cnt++;
			}
		}
	}else{
		for(var i = 1; i < aprv_line.rows.length; i++) {
			if($("#refe_yn"+i).is(":checked")){
			}else{
				aprv_line.rows[i].cells[1].innerHTML = "<input name='aprv_ordr"+ i +"' id='aprv_ordr"+ i +"' value='"+ cnt +"' type='text' class='form-control input-sm' readonly />";
				cnt++;
			}
		}
	}
}

// .convNum을 가진 input박스들을 숫자만 입력받게 하며 3자리마다 콤마 생성하고 원 붙이기
$("body").on("focus", ".convNum", function() {
	var x = $(this).val();
	x = removeCommas(x);
	$(this).val(x);
}).on("focusout", ".convNum", function() {
	var x = $(this).val();
	if(x && x.length > 0) {
		if(!$.isNumeric(x)) {
			x = x.replace(/[^0-9]/g,"");
		}
		x = addCommas(x);
		$(this).val(x + "원");
	}
}).on("keyup", ".convNum", function() {
	$(this).val($(this).val().replace(/[^0-9]/g,""));
});
//.convVol을 가진 input박스들을 숫자만 입력받게 하며 3자리마다 콤마 생성하고 권 붙이기
$("body").on("focus", ".convVol", function() {
	var x = $(this).val();
	x = removeCommas(x);
	$(this).val(x);
}).on("focusout", ".convVol", function() {
	var x = $(this).val();
	if(x && x.length > 0) {
		if(!$.isNumeric(x)) {
			x = x.replace(/[^0-9]/g,"");
		}
		x = addCommas(x);
		$(this).val(x + "권");
	}
}).on("keyup", ".convVol", function() {
	$(this).val($(this).val().replace(/[^0-9]/g,""));
});
// 3자리 단위마다 콤마 생성
function addCommas(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
// 모든 콤마, 원 제거
function removeCommas(x) {
	if(!x || x.length == 0) return "";
	else return x.split(",").join("").split("원").join("").split("권").join("");
}

function getValidation1(){
	var valid = true;
	
	if($("#proj_cd").val() == ""){
		if(valid) {
			alert("프로젝트를 입력해 주세요.");
			$("#proj_cd").focus();
		}
		$("#proj_cd").closest(".form-group").addClass("has-error");
		valid = false;
	}
	if($("#cdList1 option:selected").val() == ""){
		if(valid) {
			alert("결재 1차 구분을 선택해 주세요.");
			$("#cdList1").focus();
		}
		$("#cdList1").closest(".form-group").addClass("has-error");
		valid = false;
	}
	if($("#cdList2 option").size() > 1 && $("#cdList2 option:selected").val() == ""){
		if(valid) {
			alert("결재 2차 구분을 선택해 주세요.");
			$("#cdList2").focus();
		}
		$("#cdList2").closest(".form-group").addClass("has-error");
		valid = false;
	}
	if($("#title").val() == ""){
		if(valid) {
			alert("제목을 입력해 주세요.");
			$("#title").focus();
		}
		$("#title").closest(".form-group").addClass("has-error");
		valid = false;
	}
	if($("#rept_cont").val() == ""){
		if(valid) {
			alert("보고내용을 입력해 주세요.");
			$("#rept_cont").focus();
		}
		$("#rept_cont").closest(".form-group").addClass("has-error");
		valid = false;
	}
	
	return valid;
}

//결재 문서 템플릿 로드
function fn_getDocTmplt(cd1, cd2){
	$.ajax({
		type:'get',
		async: false,
		url: '${pageContext.request.contextPath}/doc/doc02Ajax.do?APRV_TYPE_CD='+cd1+'&APRV_TYPE_DTIL_CD='+cd2,
		success: function(json){
			$("#pay_dtl").val(json);
			// 가지급금
			//$("#pay_dtl").empty();
			//$("#pay_dtl").append(json);
		}
	});			
}
/*2022-02-09 : 캘린더 년도, 월 변경 시 공휴일 정보 추가 : BEGIN*/
$(document).on('DOMSubtreeModified', '#startpicker-container .tui-calendar-body', function(e){
	var trgt = "startpicker-container";
	//console.log(trgt);
	/*ajax - 공휴일 정보 불러오기*/
	fn_loadHolMng(trgt);

});

$(document).on('DOMSubtreeModified', '#endpicker-container .tui-calendar-body', function(e){
	var trgt = "endpicker-container";
	//console.log(trgt);
	/*ajax - 공휴일 정보 불러오기*/
	fn_loadHolMng(trgt);
});
/*2022-02-09 : 캘린더 년도, 월 변경 시 공휴일 정보 추가 : BEGIN*/


</script>
</body>
</html>