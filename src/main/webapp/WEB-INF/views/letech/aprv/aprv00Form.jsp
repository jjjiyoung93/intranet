<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<link href="${pageContext.request.contextPath}/resources/js/css/ui-lightness/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" >

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
						<form name="frm1" id="frm1" method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/aprv/aprv00List.do" >
							<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}" />
							<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}" />
							<input type="hidden" id="mode" name="mode" value="${params.mode }" />
							<input type="hidden" id="aprv_no" name="aprv_no" value="${viewMap.APRV_NO }" />
							<input type="hidden" id="line_chk" name="line_chk" value="${params.line_chk }" />
							<input type="hidden" id="aprv_line_cd" name="aprv_line_cd" value="${viewMap.APRV_LINE_CD }" />
							<!-- 검색 정보 Start -->
							<input type="hidden" name="cPage" id="cPage" value="${param.cPage }" />
							<input type="hidden" id="searchCdList1" name="searchCdList1" value="${param.searchCdList1}" />
							<input type="hidden" id="searchCdList2" name="searchCdList2" value="${param.searchCdList2}" />
							<input type="hidden" id="searchCdList3" name="searchCdList3" value="${param.searchCdList3}" />
							<input type="hidden" id="searchGubun" name="searchGubun" value="${param.searchGubun}" />
							<input type="hidden" id="searchField" name="searchField" value="${param.searchField}" />
							<!-- 검색 정보 End -->
							
							<h2 class="page-title clearfix">
								${titleNaviMap.MN_NM }
								<span class="pull-right site-map">
									HOME > ${titleNaviMap.NAVI_NM }
								</span>
							</h2>
						
						
							<div class="form-container">
								<div class="board-write">
									<ul>
										<li>
											<dl class="clearfix ">
												<dt class="col-md-2 col-sm-3">보고자</dt>
												<dd class="col-md-10 col-sm-9 form-group">
												<span class="form-inline">
													<c:set var="rept_aprv_no" value=""/>
													<c:set var="mode_u" value="<%=VarConsts.MODE_U%>"/>
													<c:choose>
														<c:when test="${params.mode eq mode_u }">
															<input type="text" class="form-control" value="${viewMap.REPT_APRV_NM }" readonly/>
															<c:set var="rept_aprv_no" value="${viewMap.REPT_APRV_NO }"/>
														</c:when>
														<c:otherwise>
															<input type="text" class="form-control" value="${loginVO.name }" readonly/>
															<c:set var="rept_aprv_no" value="${loginVO.id }"/>
														</c:otherwise>
													</c:choose>
													<input type="hidden" id="rept_aprv_no" name="rept_aprv_no" value="${rept_aprv_no }" />
													</span>
												</dd>
											</dl>
		
										</li>
										<li>
											<dl class="clearfix">
												<dt class="col-md-2 col-sm-3">소속</dt>
												<dd class="col-md-10 col-sm-9 form-group"><span class="form-inline"><input class="form-control" type="text" value="${loginVO.orgnztNm }" readonly/></span></dd>
											</dl>
										</li>
										<li>
											<dl class="clearfix">
												<dt class="col-md-2 col-sm-3">프로젝트</dt>
												<dd class="col-md-10 col-sm-9 form-group">
													<div class="form-inline">
														<select id="proj_cd" name="proj_cd" class="form-control">
															<option value="">선택</option>
															<c:forEach var="proj" items="${projList }" varStatus="status">
															<option value="${proj.CD }" <c:if test="${proj.CD eq viewMap.PROJ_CD }" >selected="selected"</c:if> >${proj.CD_NM }</option>
															</c:forEach>
														</select>
													</div>
												</dd>
											</dl>
										</li>
										<li>
											<dl class="clearfix">
												<dt class="col-md-2 col-sm-3">결제구분</dt>
												<dd class="col-md-10 col-sm-9 form-group">
													<div class="form-inline">
														<select id="cdList1" name="cdList1" class="form-control form-group">
																<option value="" >--1차 구분 선택--</option>
															<c:forEach var="codeList" items="${codeList}">
																<option value="${codeList.CD}" <c:if test="${viewMap.APRV_TYPE_CD eq codeList.CD }">selected</c:if>>${codeList.CD_NM}</option>
															</c:forEach>
														</select>
														<select id="cdList2" name="cdList2" class="form-control ">
																<option value="" >--2차 구분 선택--</option>
															<c:forEach var="codeList2" items="${codeList2}">
																<option value="${codeList2.CD}" <c:if test="${viewMap.APRV_TYPE_DTIL_CD eq codeList2.CD }">selected</c:if>>${codeList2.CD_NM}</option>
															</c:forEach>
														</select>
														<!--  반차여부 -->
														<input type="hidden" id="half_type_cd" name="half_type_cd" value="0" />
													</div>
												</dd>
											</dl>
										</li>
										<li>
											<dl class="clearfix">
												<dt class="col-md-2 col-sm-3">제목</dt>
												<dd class="col-md-10 col-sm-9 form-group"><input type="text" id="title" name="title" class="form-control" value="${viewMap.TITLE }"/></dd>
											</dl>
										</li>
										<li>
											<dl class="clearfix">
												<dt class="col-md-2 col-sm-3">기간</dt>
												<dd class="col-md-10 col-sm-9 form-group">
													<div class="form-inline">
														<input name="term_st_ym" id="term_st_ym" type="text" value="${viewMap.TERM_ST_YM }" class="form-control table-cell"/>
															~
														<input name="term_ed_ym" id="term_ed_ym" type="text" value="${viewMap.TERM_ED_YM }" class="form-control table-cell"/>
													</div>
												</dd>
											</dl>
										</li>
										<li>
											<dl class="clearfix">
												<dt class="col-md-2 col-sm-3">행선지</dt>
												<dd class="col-md-10 col-sm-9 form-group"><input type="text" name="place" id="place" class="form-control" value="${viewMap.PLACE }"/></dd>
											</dl>
										</li>
										<li>
											<dl class="clearfix">
												<dt class="col-md-2 col-sm-3">보고내용</dt>
												<dd class="col-md-10 col-sm-9 form-group"><textarea class="form-control" name="rept_cont" id="rept_cont">${viewMap.REPT_CONT }</textarea></dd>
											</dl>
										</li>
										<li>
											<dl class="clearfix">
												<dt class="col-md-2 col-sm-3 control-label">첨부파일</dt>
												<dd class="col-md-10 col-sm-9">
													<ul class="file-list">
														<c:forEach var="file" items="${fileList }" varStatus="status">
															<li id="file_${file.FILE_NO }">
																<a href="#" onclick="fn_downFile('${file.FILE_PATH}', '${file.FILE_STRE_NM }', '${file.FILE_NM }')">${file.FILE_NM }</a> 
																<span class="file-btn">
																	<button class="btn btn-xs btn-danger" onclick="fn_delFile('${file.FILE_PATH}', '${file.FILE_STRE_NM }', '${file.FILE_NO }')" >
																		<i class="glyphicon glyphicon-remove"></i>
																	</button>
																</span>
															</li>
														</c:forEach>
														<li>
															<ul class="" id="my-file">
																<li class="file-form">
																		<input type="file" name="file" id="file1" class="input-group">
																	<span class="btn btn-xs btn-success file-btn" id="button-add-file">
																		<i class="glyphicon glyphicon-plus"></i>
																	</span>
																</li>
															</ul>
														</li>
													</ul>
												</dd>
											</dl>
										</li>
									</ul>
								</div>
								<div class="clearfix">
									<dl class="panel panel-default">
										<dt class="panel-heading">결제라인</dt>
										<dd class="panel-body">
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
														<tr class="gradeA odd" role="row">
															<td class="sorting_1">
																<div class="from-inline">
									    						<input name="aprv_emp_no1" id="aprv_emp_no1" type="hidden" value="" />
									    							<input name="aprv_emp_no1_nm" id="aprv_emp_no1_nm" class="form-control table-cell input-sm" type="text" value="" />
										    							<input type="button" class="btn btn-default btn-sm" value="찾기" onclick="fn_ussSearch('aprv_emp_no1')" />
										    						<span style="display:none">
										    							<input type="checkbox" id="refe_yn1" name="refe_yn1" value="Y" onclick="fn_order(this)" /><label for="refe_yn1">참조인</label>
										    						</span>
									    					</div>
															</td>
															<td>
																<span class="form-inline">
																	<input name="aprv_ordr1" id="aprv_ordr1" type="text" value="1" class="form-control input-sm" readonly />														
																</span>
															</td>
															<td>대기<input name="aprv_yn_cd1" id="aprv_yn_cd1" type="hidden" value="0" class="i_text" /></td>
															<td></td>
														</tr>
													</c:otherwise>
												</c:choose>
											</tbody>
										</table>
										</div>
									</dd>
								</dl>
							</div>
							<p class="clearfix">
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
							</p>
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
	$("#term_st_ym").datepicker(
		{
			// 종료날짜 있을 경우 이전 날짜만 선택되게 함
			onClose: function( selectedDate ) {
		        $( "#term_ed_ym" ).datepicker( "option", "minDate", selectedDate );
		    }
		}		
	);
	$("#term_ed_ym").datepicker(
		{
			// 시작날짜 있을경우 이유 날짜만 선택하게 함
			onClose: function( selectedDate ) {
				$( "#term_st_ym" ).datepicker( "option", "maxDate", selectedDate );
			}
		}		
	);
});

//select box 선택 기능
$("#cdList1").change(function(){
	$("#cdList2").find('option').each(function(){
		$(this).remove();	
	});
	
	$("#cdList2").append("<option value=''>--선택--</option>");
	
	var selectVal = $(this).val();
	
	if(selectVal != ""){
		$.ajax({
				type:'get',
				url:'${pageContext.request.contextPath}/option/getCodeList.do?cd='+selectVal,
				dataType:'json',
				success: function(json){
					var data = json.codeList;
					if(data==null){
						data=0;
					}
					for(var i=0; i<data.length; i++){
						$("#cdList2").append("<option value='"+ data[i]['CD'] + "' >" + data[i]['CD_NM'] + "</option>");
					}
				}
		});
	}
	
});

$(document).ready(function() {
	/* 저장 */	
	$( "#btn-ok" ).click(function() {
		document.frm1.aprv_line_cnt.value = aprv_line.rows.length-1; 
		if(getValidation()){
			if($("#mode").val() == "<%=VarConsts.MODE_U%>"){
			}else{
				$("#mode").val("<%=VarConsts.MODE_I%>");	
			}
			
			$("#frm1").attr("action", "${pageContext.request.contextPath}/aprv/aprv00Tran.do");
			$("#frm1").submit();
		}
	});
	/* 취소 */
	$( "#btn-cancel" ).click(function() {
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
	
	/* 첨부파일 추가 삭제 기능 */
	var count = 0;
	$('#button-add-file').click(function(){
		var html = "<li id='file_"+count+"'>";
		html += "<input type='file' name='file"+count+"' id='file"+count+"' />";
		html += "<span class='button-delete-file btn btn-danger btn-xs file-btn'><i class='glyphicon glyphicon-remove'></i></span></li>";
		count++;
		$("#my-file").append(html);
	});
	$(document).on('click', '.button-delete-file', function(event) {
		$(this).parent().remove();
	});
});

/* 파일 삭제 */
function fn_delFile(file_path, file_stre_nm, file_no){
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

function getValidation(){
	if($("#mode").val() == "<%=VarConsts.MODE_U%>"){
		
	}else{
		/* 입력 폼일경우 */
		if($("#proj_cd").val() == ""){
			alert("프로젝트를 입력해 주세요.");
			$("#proj_cd").focus();
			return false;
		}
		
		if($("#cdList1 option:selected").val() == ""){
			alert("결재구분코드를 선택해 주세요.");
			$("#cdList1").focus();
			return false;
		}
		
		if($("#cdList2 option").size() > 1 && $("#cdList2 option:selected").val() == ""){
			alert("결재상세구분코드를 선택해 주세요.");
			$("#cdList2").focus();
			return false;
		}
		
		if($("#title").val() == ""){
			alert("제목을 입력해 주세요.");
			$("#title").focus();
			return false;
		}
		
		if($("#term_st_ym").val() == ""){
			alert("기간시작일자를 입력해 주세요.");
			$("#term_st_ym").focus();
			return false;
		}
		
		if($("#term_ed_ym").val() == ""){
			alert("기간종료일자를 입력해 주세요.");
			$("#term_ed_ym").focus();
			return false;
		}
		if($("#cdList1").val() == "CD0001003" || $("#cdList1").val() == "CD0001004"){
			if($("#place").val() == ""){
				alert("행선지를 입력해 주세요.");
				$("#place").focus();
				return false;
			}
		}
		
		if($("#rept_cont").val() == ""){
			alert("보고내용을 입력해 주세요.");
			$("#rept_cont").focus();
			return false;
		}
	}
	
	return true;
}

/* 결재자 검색 */
var div_id = "";
function fn_ussSearch(no){
	div_id = no;
	window.open("", "uss00Popup","width=1300, height=750");
	$("#ussFrm").attr("target", "uss00Popup");
	$("#not_uss_id").val($("#rept_aprv_no").val());
	$("#ussFrm").attr("action", "${pageContext.request.contextPath}/search/uss00Popup.do");
	$("#ussFrm").submit();
}
function setUssForm(id, nm){
	$("#"+div_id).val(id);
	$("#"+div_id+"_nm").val(nm);
}

/* 파일 다운로드 */
function fn_downFile(file_path, file_stre_nm, file_nm){
	$("#file_path").val(file_path);
	$("#file_stre_nm").val(file_stre_nm);
	$("#file_nm").val(file_nm);
	$("#downFrm").submit();
}


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
	for(var i = 1; i <= aprv_line.rows.length; i++) {
		if($("#refe_yn"+i).is(":checked")){
		}else{
			aprv_line.rows[i].cells[1].innerHTML = "<input name='aprv_ordr"+ i +"' id='aprv_ordr"+ i +"' value='"+ cnt +"' type='text' class='form-control input-sm' readonly />";
			cnt++;
		}
	}
	
//		document.recalc();
}

function delRow() {
	aprv_line.deleteRow(aprv_line.clickedRowIndex);
	for(var i = aprv_line.clickedRowIndex; i < aprv_line.rows.length; i++) {
		var checkVal = "";
		
		if($("#refe_yn"+(i+1)).is(":checked")){			
			checkVal = "checked='checked'";
		}
		/* aprv_line.rows[i].cells[0].innerHTML = "<input name='aprv_emp_no"+ i +"' id='aprv_emp_no"+ i +"' value='"+$("#aprv_emp_no"+(i+1)).val()+"' type='hidden' />"
				+ "<input name='aprv_emp_no"+ i +"_nm' id='aprv_emp_no"+ i +"_nm' type='text' value='"+$("#aprv_emp_no"+(i+1)+"_nm").val()+"' class='i_text input_size100' />&nbsp;"
				+ "<input type='button' value='찾기' onclick=\"fn_ussSearch('aprv_emp_no"+ i +"')\" />&nbsp;&nbsp;"
				+ "<input type='checkbox' id='refe_yn"+ i +"' name='refe_yn"+ i +"' value='Y' onclick='fn_order(this)' "+checkVal+" /><label for='refe_yn"+ i +"'>참조인</label>";
// 		aprv_line.rows[i].cells[1].innerHTML = "<input name='aprv_ordr"+ i +"' id='aprv_ordr"+ i +"' value='"+ i +"' type='text' class='i_text input_size50' readonly />";
		aprv_line.rows[i].cells[2].innerHTML = "대기<input name='aprv_yn_cd"+ i +"' id='aprv_yn_cd"+ i +"' type='hidden' value='0' />";
		aprv_line.rows[i].cells[3].innerHTML = "<input type=button value='삭제' onClick='delRow()' />"; */
		
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
	for(var i = 1; i <= aprv_line.rows.length; i++) {
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
		for(var i = 1; i <= aprv_line.rows.length; i++) {
			if($("#refe_yn"+i).is(":checked")){
			}else{
				aprv_line.rows[i].cells[1].innerHTML = "<input name='aprv_ordr"+ i +"' id='aprv_ordr"+ i +"' value='"+ cnt +"' type='text' class='form-control input-sm' readonly />";
				cnt++;
			}
		}
	}
}

</script>
</body>
</html>