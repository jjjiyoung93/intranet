<!doctype html>
<%@page import="java.util.Date"%>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
					<form name="frm1" id="frm1" method="post" action="${pageContext.request.contextPath}/sys/vct/vctInf00List.do" >
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
									<div class="row">
										<div class ="col-xs-6 un-style">
											<!-- 기준년도(년도 선택), 재직구분  -->
											<!-- <div class="col-xs-6 un-style"> -->
												<div class="inline-element col-xs-11">
													<label>기준년도</label><br>
													<div class="tui-datepicker-input tui-datetime-input tui-has-focus">
														<input type="text" id="datepicker-input-ko" name="searchGubun2" value="${params.searchGubun2}" aria-label="Date" class="form-control" title="search">											
														<span class="tui-ico-date"></span>
													</div>
													<div class="datepicker-cell" id="datepicker-year-ko"></div>
												</div>
										
										</div>
										<div class ="col-xs-6 un-style">
											<!-- ID/성명 검색  -->
											<sec:authorize access="hasAnyRole('ROLE_ADMIN')">
										
												<div class="col-xs-12">
													<label>ID/성명</label><br>
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
											</sec:authorize>
										</div>
									</div>
									<sec:authorize access="hasAnyRole('ROLE_ADMIN')">
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
														<option value="N" <c:if test="${params.searchGubun3 == 'N'}">selected = "selected "</c:if>>재직중</option>
														<option value="Y" <c:if test="${params.searchGubun3 == 'Y'}">selected = "selected"</c:if>>퇴사</option>
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
										</div>
									</sec:authorize>
									
							</div>
							<sec:authorize access="hasAnyRole('ROLE_ADMIN')">
							<p class="clearfix board-top">
									
									<br>
									<span class="pull-right">
										<button type="button" class="btnExcl-uss btn btn-sm btn-default" >엑셀다운</button>
									</span>
									
									<strong class="list_count" >Total : ${totalCnt} 건</strong>
							</p>
						<div class="table-responsive" id="uss-list" style=" height: 200px; overflow-y:scroll;">
						<table class="table table-bordered" summary="사용자관리 목록">
							<colgroup>
								<col width="5%" />
								<col width="5%" />
								<col width="10%" />
								<col width="10%" />
								<col width="10%" />
								<col width="10%" />
								<col width="10%" />
								<col width="8%" />
								<col width="10%" />
							</colgroup>
							<thead>
								<tr>
									<th class="visible-md visible-lg">번호</th>
									<th>기준년도</th>
									<th>성명</th>
									<th>고용구분</th>
									<th>프로젝트</th>
									<th>직급</th>
									<th class="visible-md visible-lg">재직구분</th>
									<th>입사일</th>
									<th>근속년수(년)</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${totalCnt < 1 }">
										<tr>
											<td colspan="9">검색된 내용이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="list" items="${resultList}" varStatus="status">
											<tr data-id="${list.USS_ID}">
												<th class="visible-md visible-lg text-right">${totalCnt - status.index - ((cPage-1) * (intListCnt))}</th>
												<td align="center">${list.STDD_YR} </td>
												<td>
													<a href="javascript:fnView('${list.USS_ID}', '${list.STDD_YR}', '${list.USS_NM}');">
														<span class="ellip ellip-line">${list.USS_NM}</span>
													</a>
												</td>
												<td>${list.EMP_TYPE_NM}</td>
												<td>${list.PROJ_NM} </td>
												<td>${list.AUTH_NM} </td>
												<td align="center">${list.RTR_YN == 'Y'? '퇴사' : '재직중'}</td>
												<td align="center">${list.JOIN_DT}</td>
												<td align="right">${list.WORK_YR_CNT }</td>
											</tr>
										</c:forEach>
									</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					</div>
					</sec:authorize>
					<div class="table-responsive" id="uss-vct">
						
					</div>
					<div class="table-reponsive" id="uss-vct-excl">
					
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
			<form id="dtilFrm" name="dtilFrm" method="post" action="${pageContext.request.contextPath}/vct/vct00Popup.do" >
				<input type="hidden" id="stddYr" name="stddYr" value="" />
				<input type="hidden" id="ussId" name="ussId" value="" />
				<input type="hidden" id="startMon" name="startMon" value="" />
				<input type="hidden" id="endMon" name="endMon" value="" />
				<input type="hidden" id="vctTypeCd" name="vctTypeCd" value="" />
				<input type="hidden" id="aprvStatCd" name="aprvStatCd" value="" />
			</form>
			<jsp:include page="/resources/com/inc/aside.jsp" />
		</section>
	</div>
	 	<jsp:include page="/resources/com/inc/footer.jsp" />
	</div>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/tableExport/libs/FileSaver/FileSaver.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/tableExport/libs/js-xlsx/xlsx.core.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/tableExport/libs/jsPDF/jspdf.umd.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/tableExport/tableExport.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/tableExport/libs/pdfmake/pdfmake.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/tableExport/libs/pdfmake/vfs_fonts.js"></script>
	<script type="text/javascript">
		/*사원정보엑셀Down*/
		$(".btnExcl-uss").click(function() {
			
			$.ajax({
				type: 'post',
				data : $("#frm1").serialize(),
				url : "${pageContext.request.contextPath}/vct/vctInf00Excl.do",
				dataType : 'json',
				success : function (data){
					var map = data.map;
					var resultList = map.resultList;
					var totalCnt = map.totalCnt;
					var cPage = map.cPage;
					var params = data.params;
					var vctTypeList = data.vctTypeList;
					var vctTypeCnt = vctTypeList.length;
					var intListCnt = map.intListCnt;
					var stddYr = params.searchGubun2;
					
					var html = "";
					
					html += '<table class="table table-bordered" id="table-stat" summary="휴가집계">';
					html += '<colgroup>';
					html +=	'<col width="5%" />';
				    html += '<col width="5%" />';
					html += '<col width="5%" />';
					html += '<col width="5%" />';
					html += '<col width="5%" />';
					html += '<col width="5%" />';
					html += '<col width="5%" />';
					html += '<col width="5%" />';
					html += '<col width="5%" />';
					html += '<col width="5%" />';
						for(var i  in vctTypeList){
							html += '<col width="5%" />';
							html += '<col width="5%" />';
							html += '<col width="5%" />';
							html += '<col width="5%" />';
							html += '<col width="5%" />';
							html += '<col width="5%" />';
							html += '<col width="5%" />';
							html += '<col width="5%" />';
							html += '<col width="5%" />';						
						}
						
						html += '<col width="5%" />';
						html += '</colgroup>';
					html += '<thead>';
					html += '	<tr>';
					html += '		<th class="visible-md visible-lg" rowspan="2">번호</th>';
					html += '		<th rowspan="2">기준년도</th>';
					html += '		<th rowspan="2">성명</th>';
					html += '		<th rowspan="2">고용구분</th>';
					html += '		<th rowspan="2">프로젝트</th>';
					html += '		<th rowspan="2">직급</th>';
					html += '		<th class="visible-md visible-lg" rowspan="2">재직구분</th>';
					html += '		<th rowspan="2">입사일</th>';
					html += '		<th rowspan="2">퇴사일</th>';
					html += '		<th rowspan="2">근속년수(년)</th>';
					
							for(var i in vctTypeList){
								var vctType = vctTypeList[i];
								
								if(vctType.CD == "CD0001011001" ){
									html += '<th rowspan="1" colspan="4">'+vctType.CD_NM+'</th>';
								}else{
									html += '<th rowspan="1" colspan="1">'+vctType.CD_NM+'</th>';	
								}
							
							}
							
							html += '<th rowspan="2" colspan="1">전체</th>'
						html+='</tr>';
						html+='<tr>';
							for(var i in vctTypeList){
								var vctType = vctTypeList[i];
								
								if(vctType.CD == 'CD0001011001'){
									html += '<th class="visible-md visible-lg">부여일수</th>';
									html += '<th>사용일수</th>';
									html += '<th>잔여일수</th>';
									html += '<th>활용률</th>';
								}else {
									html += '<th>사용일수</th>';
								}
							
							}

						html+='</tr>';
					html+='</thead>';
					html+='<tbody>';
						if (totalCnt < 1){
								
							html+='<tr>';
								html+='<td colspan="'+(vctTypeCnt +13)+'">검색된 내용이 없습니다.</td>'
							html+='</tr>';
						
						}else{
							for(var i in resultList){
								var result = resultList[i];
								html+='<tr data-id="'+result.USS_ID+'">';
								html+='<th class="visible-md visible-lg text-right">'+(totalCnt - i - ((cPage-1) * (intListCnt)))+'</th>';
								html+='<td align="center">'+result.STDD_YR+'</td>';
								html+='<td>'+result.USS_NM+'</td>';
								html+='<td>'+(result.EMP_TYPE_NM == null ? '' : result.EMP_TYPE_NM)+'</td>';
								html+='<td>'+(result.PROJ_NM == null ? '' : result.PROJ_NM)+'</td>';
								html+='<td>'+(result.REPT_AUTH_NM == null ? '' : result.REPT_AUTH_NM)+'</td>';
								html+='<td align="center">'+(result.RTR_YN_NM == null ? '' : result.RTR_YN_NM)+'</td>';
								html+='<td align="center">'+(result.JOIN_DT == null ? '' : result.JOIN_DT)+'</td>';
								html+='<td align="center">'+(result.RTR_DT == null ? '' : result.RTR_DT)+'</td>';
								html+='<td align="right">'+result.WORK_YR_CNT+'년</td>';
								html+='<td align="right">'+result.YEON_GRNT_DAY+'일</td>';
								html+='<td align="right">'+result.YEON_USE_CNT+'일</td>';
								html+='<td align="right">'+result.YEON_LEFT_CNT+'일</td>';
								html+='<td align="right">'+result.YEON_USE_RATE+'%</td>';
								html+='<td align="right">'+result.DISS_USE_CNT+'일</td>';
								html+='<td align="right">'+result.FAM_EVNT_USE_CNT+'일</td>';
								html+='<td align="right">'+result.REPLC_USE_CNT+'일</td>';
								html+='<td align="right">'+result.CMFT_USE_CNT+'일</td>';
								html+='<td align="right">'+result.FAM_CARE_USE_CNT+'일</td>';
								html+='<td align="right">'+result.VCT_TOT_CNT+'일</td>';
								html+='</tr>';
							}
						
						}
					html+= '</tbody>';
				html += '</table>';
					
				$("#uss-vct-excl").html(html);

				$('#table-stat').tableExport({fileName: stddYr+'년도_사원_휴가현황', type: 'excel'});
				$("#uss-vct-excl").hide();
					
				},error: function (request, status, error) {
			         alert(request.responseText);
			    }  
		});
	
	})
		/* 휴가현황엑셀Down */
		$( "#uss-vct" ).on('click', '.btnExcl-vct', function() {
			var id = $(this).attr('id');
			var ussNm = id.split('-')[0];
			var stddYr =id.split('-')[1];
			var name = stddYr+'년도_'+ussNm+'_휴가현황';
			//alert(stddYr);
			$('#table-vct').tableExport({fileName: name, type: 'excel'});
			/* $("#frm1").attr("action", "${pageContext.request.contextPath}/sys/vct/vct00Tran.do");
			$("#frm1").submit(); */
		});
		
		/* 검색 */
		$( ".fnSearch" ).click(function() {
			goPage(1);
		});
		
		/* 상세보기 팝업 */
		$( "#uss-vct" ).on('click', '#btnDtil', function() {
			alert("상세보기팝업!!");
			window.open("", "vct00Popup","width=720, height=750");
			$("#dtilFrm").attr("target", "vct00Popup");
			$("#dtilFrm").attr("action", "${pageContext.request.contextPath}/vct/vct00Popup.do");
			$("#dtilFrm").submit();

		});
		
		/* 휴가현황목록조회 */
		function fnView(uss_id, stdd_yr, uss_nm){
			var ussId = uss_id;
			var ussNm = uss_nm;
			//alert(ussId);
			var stddYr = stdd_yr;
			var table = "";
			table += '<span class="pull-right">';
			table += '<button type="button" class="btnExcl-vct btn btn-sm btn-default" id="'+ussNm+'-'+stddYr+'" >엑셀다운</button>';
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
					    table += '<table class="table table-bordered" id="table-vct" summary="휴가현황 목록">'
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
					/*상세항목 테이블 추가*/
				},error: function (request, status, error) {
			         alert(request.responseText);
			    } 
			});
		}
		
		function goPage(cPage){
			$("#cPage").val(cPage);
			$("#frm1").attr("action", "${pageContext.request.contextPath}/vct/vctInf00List.do");
			$("#frm1").submit();
		}
		
	
		/*sub_menu 탭*/
		$(function(){
			//년도 캘린더 만들기 - 관리자일 경우 시작년도가 2015년 , 사용자일 경우 사용자의 입사년도
			//스프링 시큐리티를 이용해서 c:set 을 이용하여 변수 생성하고 그 값으로 세팅
			calYearKo = new tui.DatePicker('#datepicker-year-ko',{
				date : new Date(),
				language : 'ko',
				date : "${params.searchGubun2}",
				type: 'year',
				input : {
					element : '#datepicker-input-ko',
					format : 'yyyy'
				},
				selectableRanges: [
					[new Date(2015, 1, 1), new Date(9999, 12, 31)]
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
	<sec:authorize access="!hasAnyRole('ROLE_ADMIN')">
		<script type="text/javascript">
			$(document).ready(function() {
				var ussId = "${params.uss_id}";
				var ussNm = "${params.uss_nm}";
				var stddYr = "${params.searchGubun2}";
				
				
				fnView(ussId, stddYr, ussNm);

				calYearKo.on('change', function() {
					goPage(1);
				});
			})
			
		
		</script>
	</sec:authorize>	
</body>
</html>