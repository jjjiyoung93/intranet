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
<%-- <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css"> --%>
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.print.css' rel='stylesheet' media='print' />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/bootstrap.min.js"></script>

<script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-code-snippet.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-dom.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-time-picker.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-date-picker.js"></script>
<link href="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-time-picker.css" rel="stylesheet" >
<link href="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-date-picker.css" rel="stylesheet" >

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/tableExport/libs/FileSaver/FileSaver.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/tableExport/libs/js-xlsx/xlsx.core.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/tableExport/libs/jsPDF/jspdf.umd.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/tableExport/tableExport.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/tableExport/libs/pdfmake/pdfmake.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/tableExport/libs/pdfmake/vfs_fonts.js"></script>
</head>

<body style="zoom: 1; background-color: white;">
<div id="wrapper1">
 	<%-- <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
		<jsp:include page="/resources/com/inc/header.jsp" />
		<jsp:include page="/WEB-INF/views/letech/com/layout/menu.jsp" />
	</nav> --%>

	<div id="page-wrapper1">
		<div class="row">
			<div class="col-lg-10">
				<form name="frm1" id="frm1" method="post" action="${pageContext.request.contextPath}/vct/vct00Popup.do" >
					<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}" />
					<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}" />
					<input type="hidden" name="aprv_no" id="aprv_no" value="" />
					<input type="hidden" name="mode" id="mode" value="" />
					<input type="hidden" name="line_chk" id="line_chk" value="" />
					<input type="hidden" name="cPage" id="cPage" value="${cPage }" />
					<input type="hidden" name="conf_yn" id="conf_yn" value="" />
					<input type="hidden" name="conf_y_cnt" id="conf_y_cnt" value="" />
					<input type="hidden" name="ussId" id="uss_id" value="${params.ussId}" />
					<%-- <h2 class="page-title clearfix">
						${titleNaviMap.MN_NM }
						<span class="pull-right site-map">
							HOME > ${titleNaviMap.NAVI_NM }
						</span>
					</h2> --%>
					<div class="form-container">
					<div class="clearfix search-box">
						<div class="search-container2">
							<div class="row">
								<div class="col-lg-6 col-sm-6 form-inline mt10">
									<label style="width: 70px;">기준년도</label>
									<div class="tui-datepicker-input tui-datetime-input tui-has-focus form-control" style="width: 100px; vertical-align: middle;">
										<input type="text" id="datepicker-input-ko-year" name="stddYr" value="${params.stddYr}" aria-label="Year" class="" title="search" autocomplete="off">											
										<span class="tui-ico-date"></span>
									</div>
									<div class="datepicker-cell" id="datepicker-year-ko"></div>
								</div>
								<div class="col-lg-6 col-sm-6 form-inline mt10">
									<label style="width: 70px;">휴가구분</label>
									<select name="vctTypeCd" id="vctType" class="form-control" title="search" style="width: 100px; vertical-align: middle;">
										<option value="" >전체</option>
										<c:forEach var="vctType" items="${vctTypeList}">
											<option value="${vctType.CD}" <c:if test="${vctType.CD eq params.vctTypeCd }">selected="selected"</c:if> >${vctType.CD_NM}</option>
										</c:forEach>
									</select>
								</div>
								<div class="col-lg-6 col-sm-6 form-inline mt10">
								
									<label style="width: 70px;">월</label>
									<span class="tui-datepicker-input tui-datetime-input tui-has-focus inline-element form-control" style="width: 100px; vertical-align: middle;">
										<input type="text" id="datepicker-input-ko-mon-start" name="startMon" value="${params.startMon}" aria-label="Month" class="" title="search">											
										<span class="tui-ico-date"></span>
									</span>
									<span class="datepicker-cell" id="datepicker-month-ko-start"></span>
									<label>~</label>												
									<span class="tui-datepicker-input tui-datetime-input tui-has-focus inline-element form-control" style="width: 100px; vertical-align: middle;">
										<input type="text" id="datepicker-input-ko-mon-end" name="endMon" value="${params.endMon}" aria-label="Month" class="" title="search">											
										<span class="tui-ico-date"></span>
									</span>
									<span class="datepicker-cell" id="datepicker-month-ko-end"></span>
							
								</div>
								
								<div class="col-lg-6 col-sm-6 form-inline mt10">
									<label style="width: 70px;" >상태구분</label>
									<select name="aprvStatCd" id="searchGubun3" class="form-control" title="search" style="width: 100px; margin-right:10px; vertical-align: middle;">
										<option value="" >전체</option>
										<option value="<%=VarConsts.APRV_COND_WAIT %>" <c:if test="${params.aprvStatCd eq '0' }">selected="selected"</c:if>>대기</option>
										<option value="<%=VarConsts.APRV_COND_ONGO %>" <c:if test="${params.aprvStatCd eq '9' }">selected="selected"</c:if>>진행중</option>
										<option value="<%=VarConsts.APRV_COND_APPR %>" <c:if test="${params.aprvStatCd eq '1' }">selected="selected"</c:if>>완료</option>
										<option value="<%=VarConsts.APRV_COND_DEFE %>" <c:if test="${params.aprvStatCd eq '2' }">selected="selected"</c:if>>보류</option>
										<option value="<%=VarConsts.APRV_COND_RETR %>" <c:if test="${params.aprvStatCd eq '3' }">selected="selected"</c:if>>반려</option>
									</select>
									<select id="searchCdList6" style="width : 100px; display:inline-block;" name="searchCdList6" class="form-control">
										<option value="" >--전체--</option>
										<option value="<%=VarConsts.APRV_GB_APRV %>" <c:if test="${params.searchCdList6 eq '0' }">selected="selected"</c:if>>결재</option>
										<option value="<%=VarConsts.APRV_GB_REFE %>" <c:if test="${params.searchCdList6 eq '1' }">selected="selected"</c:if>>참조</option>
										<option value="<%=VarConsts.APRV_GB_CAN %>" <c:if test="${params.searchCdList6 eq '2' }">selected="selected"</c:if>>취소</option>
									</select>
									<span class="">
											<button type="button" class="fnSearch btn-info btn"  >
												<i class="glyphicon glyphicon-search"></i><span class="hidden-xs hidden-sm"> 검색</span>
											</button>
									</span>
								</div>
							</div>
							
						<div class="col-md-12">
						</div>
					</div>
					</div>
					<p class="clearfix board-top">
						<select id="listCnt" name="listCnt" class="form-control" style="width: 100px; display: inline-block;" onchange="goPage('1');">
							<option value="10" <c:if test="${params.listCnt == '10'}">selected = "selected"</c:if>>10</option>
							<option value="20" <c:if test="${params.listCnt == '20'}">selected = "selected"</c:if>>20</option>
							<option value="30" <c:if test="${params.listCnt == '30'}">selected = "selected"</c:if>>30</option>
							<option value="50" <c:if test="${params.listCnt == '50'}">selected = "selected"</c:if>>50</option>
							<option value="100" <c:if test="${params.listCnt == '100'}">selected = "selected"</c:if>>100</option>
						</select>
						<!-- <span class="pull-right"><input type="button" id="btnExcl" name="fnJoin" class="btn btn-sm btn-default" value="엑셀다운"/></span> -->
					</p>
						<table class="table table-bordered reactive" id="table-aprv"  data-show-export="true" data-pagination="true"  data-show-toggle="true" data-show-columns="true">
							<colgroup>
								<col width="50" class=""/>
								<%-- <col width="80" class="hidden-xs hidden-sm"/> --%>
								<col width="80"/>
								<col width="200"/>
								<col width="180"/>
								<col width="80" class=""/>
								<col width="100"/>
								<col width="100"/>
								<col width="80"/>
							</colgroup>
							<thead>
								<tr role="row">
									<th class="" data-force-export="true" style="vertical-align: middle;">NO</th>
									<!-- <th class="hidden-xs hidden-sm" data-force-export="true">결재문서번호</th> -->
									<!-- <th class="">보고자</th> -->
									<th class="" data-force-export="true" style="vertical-align: middle;">휴가구분</th>
									<!-- <th class="">확인</th> -->
									<th class="" data-force-export="true" style="vertical-align: middle;">제 목</th>
									<th class="" data-force-export="true" style="vertical-align: middle;">휴가기간</th>
									<th class="" data-force-export="true" style="vertical-align: middle;">사용일수</th>
									<th class="" data-force-export="true" style="vertical-align: middle;">상신자</th>
									<th class="" data-force-export="true" style="vertical-align: middle;">상태</th>
									<th class="" data-force-hide="true" style="vertical-align: middle;">신청서</th>
								</tr>
							</thead>
							<tbody>
					        	<c:choose>
									<c:when test="${totalCnt < 1 }">
										<tr>
											<td align="center" class="align-middle" colspan="8" style="vertical-align: middle;">
												검색된 내용이 없습니다.
											</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="list" items="${resultList}" varStatus="status">
											<tr class="">
												<td align="center" class="text-center align-middle" style="vertical-align: middle;" data-force-export="true">
													${totalCnt - status.index - ((cPage-1) * (intListCnt))}
												</td>
												<%-- <td align="center" class="hidden-xs hidden-sm text-center" data-force-export="true">
													${list.APRV_NO}
												</td> --%>
											<%-- 	<td>
													${list.REPT_APRV_NM}
												</td> --%>
												<td align="center" class="align-middle" style="vertical-align: middle;">
													${list.APRV_TYPE_DTIL_NM}
												</td>
											<%-- 	<td class="">
											<c:choose>
												<c:when test="${list.CONF_YN eq 'Y' }">
													확인
												</c:when>
												<c:otherwise>
													미확인
												</c:otherwise>
											</c:choose>
												</td> --%>
												<td class="center align-middle" data-force-export="true" style="vertical-align: middle;">
													<a href="javascript:fnView('${list.APRV_NO}', '${list.LINE_CHK }', '${list.CONF_YN }', '${list.CONF_Y_CNT }');">
													<span class="ellip ellip-line">${list.TITLE}</span>
													</a>
												</td>
												<td align="center" class="align-middle" data-tableexport-msonumberformat="yyyy-MM-dd" data-force-export="true" style="vertical-align: middle;">
													${list.TERM_ST_YM} - ${list.TERM_ED_YM}
												</td>
												<td align="center" class="center align-middle" data-force-export="true" style="vertical-align: middle;">
													${list.SUM_DAY_CNT}
												</td>
												<%-- <td class="hidden-xs hidden-sm">
													<c:choose>
														<c:when test="${list.TERM_ST_YM ne null }">
															${list.TERM_ST_YM} - ${list.TERM_ED_YM}
														</c:when>
														<c:otherwise>
															${list.CRTN_DT} - ${list.CRTN_DT}
														</c:otherwise>
													</c:choose> 
													
												</td> --%>
												<td align="center" class="align-middle" data-force-export="true" style="vertical-align: middle;">
													${list.REPT_APRV_NM}
												</td>
												<td align="center" class="center align-middle" data-force-export="true" style="vertical-align: middle;">
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
												<td align="center" class="align-middle" data-force-hide="true" style="vertical-align: middle;">
													<input type="button" id="" name="" class="btn btn-sm btn-default" value="보기" onclick="fn_docPopup('${list.APRV_NO}')"/>
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
							<!-- <span class="pull-right"><input type="button" id="fnJoin1" name="fnJoin" class="btn btn-sm btn-default" value="등록"/></span> -->
						</div>
					</div>
				</form>
				<form id="docFrm" name="docFrm" method="post" action="${pageContext.request.contextPath}/doc/doc00Popup.do" >
					<input type="hidden" id="aprv_no2" name="aprv_no" value="" />
				</form>
			</div>
			<%-- <jsp:include page="/resources/com/inc/aside.jsp" /> --%>
		</div>
	</div>
	<%-- <jsp:include page="/resources/com/inc/footer.jsp" /> --%>
</div>
<script type="text/javascript">

$(document).ready(function(){
	
	var stddYr = "${params.stddYr}";
	var ussId = "${params.ussId}";
	var startMon = "${params.startMon}";
	var endMon = "${params.endMon}";
	var yearStr = "${params.searchGubun2}";
	var yearInt = parseInt(stddYr);
	/* alert("stddYr : " + stddYr);
	alert("ussId : " + ussId);
	alert("startMon : " + startMon);
	alert("endMon : " + endMon); */
	
	//기준년도 선택
	calYearKo = new tui.DatePicker('#datepicker-year-ko',{
		date : new Date(),
		language : 'ko',
		date : "${params.stddYr}",
		type: 'year',
		input : {
			element : '#datepicker-input-ko-year',
			format : 'yyyy'
		},
		selectableRanges: [
			[new Date(2015, 0, 1), new Date(9999, 11, 31)]
		]
	});
	
	
	//시작월 선택	
	calMonthKoStart = new tui.DatePicker("#datepicker-month-ko-start", {
		
		date : new Date(),
		language : 'ko',
		type : 'month',
		date : '${params.startMon}',
		input : {
			element : '#datepicker-input-ko-mon-start',
			format : 'MM'
		},
		selectableRanges : [
			[new Date(yearInt, 0, 1) , new Date(yearInt, 11, 31) ]
			
		]
		
	});
	
	//종료월 선택
	calMonthKoEnd = new tui.DatePicker("#datepicker-month-ko-end", {
		
		date : new Date(),
		language : 'ko',
		type : 'month',
		date : '${params.endMon}',
		input : {
			element : '#datepicker-input-ko-mon-end',
			format : 'MM'
		},
		selectableRanges : [
			[new Date(yearInt, 0, 1) , new Date(yearInt, 11, 31) ]
			
		]
		
	});
	
	//년도 변경시 월의 선택 범위 변경 함수
	calYearKo.on('change', () =>{
		var year = $("#datepicker-input-ko-year").val();
		var yearInt = parseInt(year);
		var ranges = [[new Date(yearInt, 0, 1), new Date(yearInt, 11, 31)]];
		
		calMonthKoStart.setRanges(ranges);
		calMonthKoEnd.setRanges(ranges);
	});
	
	
	//시작월 설정시 종료월과 크기 비교
	calMonthKoStart.on('change', () =>{
		var monStart = $("#datepicker-input-ko-mon-start").val();
		var monEnd = $("#datepicker-input-ko-mon-end").val();
		
		//시작월 입력값이 있는지 체크
		if(monEnd == null || monEnd == ""){
			return;
		}
		
		var monStartInt = parseInt(monStart);
		var monEndInt = parseInt(monEnd);
		
		//시작월이 종료월보다 큰 경우 메세지 출력
		if(monEndInt < monStartInt){
			alert("시작월이 종료월보다 큽니다. 시작월을 다시 설정해주세요.");
			$("#datepicker-input-ko-mon-start").val('');
			$("#datepicker-input-ko-mon-start").focus();
			return;
		}		
	});
	
	
	
	//종료월 설정시 시작 월과 크기 비교
	calMonthKoEnd.on('change', () =>{
		var monStart = $("#datepicker-input-ko-mon-start").val();
		var monEnd = $("#datepicker-input-ko-mon-end").val();
		
		//시작월 입력값이 있는지 체크
		if(monStart == null || monStart == ""){
			alert("시작월을 먼저 선택해주세요.");
			$("#datepicker-input-ko-mon-start").focus();
			return;
		}
		
		var monStartInt = parseInt(monStart);
		var monEndInt = parseInt(monEnd);
		
		//시작월이 종료월보다 큰 경우 메세지 출력
		if(monEndInt < monStartInt){
			alert("종료월이 시작월보다 작습니다. 종료월을 다시 설정해주세요.");
			$("#datepicker-input-ko-mon-end").val('');
			$("#datepicker-input-ko-mon-end").focus();
			return;
		}		
	});
	

	
	//console.log($("#aprv_no").val());
	//console.log($("#mode").val());
	$( ".fnSearch" ).click(function() {
			goPage(1);
	});
	
	
	/* 엑셀다운 */
	$("#btnExcl").click(function(){
		$('#table-aprv').tableExport({type : 'excel', exportHiddenCells: 'true'});
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

//검색 버튼
function goPage(cPage){
	$("#cPage").val(cPage);
	$("#frm1").attr("action", "${pageContext.request.contextPath}/vct/vct00Popup.do");
	$("#frm1").submit();
}


// select option 생성
function optionCreate(val){
	$("#cdList2").find('option').each(function(){
		$(this).remove();	
	});
	
	$("#cdList2").append("<option value=''>--선택--</option>");
	
	var selectVal = val;
	
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
	window.open("", "aprv00View","width=720, height=750");
	$("#aprv_no").val(aprv_no);
	$("#line_chk").val(line_chk);		// 결재 인지 아닌지 구분 (Y:결재, N:결재신청)
	$("#conf_yn").val(conf_yn);
	$("#conf_y_cnt").val(conf_y_cnt);
	$("#mode").val("<%=VarConsts.MODE_U%>");
	$("#frm1").attr("target", "aprv00View");
	$("#frm1").attr("action", "${pageContext.request.contextPath}/vct/vct00PopupDtil.do");
	$("#frm1").submit();	
}

//보고서 보기
function fn_docPopup(aprvNo){
	window.open("", "doc00Popup","width=720, height=750");
	$("#aprv_no2").val(aprvNo);
	$("#docFrm").attr("target", "doc00Popup");
//		$("#not_uss_id").val($("#rept_aprv_no").val());
	$("#docFrm").attr("action", "${pageContext.request.contextPath}/doc/doc00Popup.do");
	$("#docFrm").submit();
} 


</script>
</body>
</html>