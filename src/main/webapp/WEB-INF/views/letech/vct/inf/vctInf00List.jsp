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
					<form name="frm1" id="frm1" method="post" action="${pageContext.request.contextPath}/sys/vct/vctDay00List.do" >
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
											<!-- </div> -->
											<%-- <div class ="col-xs-6 un-style">
												<span class="inline-element col-xs-11">
													<label >재직구분</label>
													<select name="searchGubun3" id="searchGubun3" class="form-control" title="search" >
														<!-- <option value="" >전체</option> -->
														<option value="N" <c:if test="${empty params.searchGubun3 || params.searchGubun3 == 'N'}">selected = "selected "</c:if>>재직중</option>
														<option value="Y" <c:if test="${params.searchGubun3 == 'Y'}">selected = "selected"</c:if>>퇴사</option>
													</select>
												</span>
											</div> --%>
										</div>
										<div class ="col-xs-6 un-style">
											<!-- ID/성명 검색  -->
											<sec:authorize access="hasAnyRole('ROLE_ADMIN')">
												<%-- <li>
													<a href="${pageContext.request.contextPath}/uat/uia/ussInfoEdit.do?uss_id=${loginVO.id }" class="" role="button">정보수정</a>
												</li> --%>
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
										<%-- <li>
											<a href="${pageContext.request.contextPath}/uat/uia/ussInfoEdit.do?uss_id=${loginVO.id }" class="" role="button">정보수정</a>
										</li> --%>
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
													<%-- <label>부서</label>
													<select name="searchGubun4" id="searchGubun4" class="form-control" title="search" >
														<option value="" >전체</option>
														<c:forEach var="departList" items="${departList}">
															<option value="${departList.DP_CD}" <c:if test="${departList.DP_CD eq params.searchGubun4 }">selected="selected"</c:if> >${departList.DP_NM}</option>
														</c:forEach>
													</select> --%>
													<label>프로젝트</label>
													<select name="searchGubun6" id="searchGubun6" class="form-control" title="search" >
														<option value="" >전체</option>
														<c:forEach var="proj" items="${projList}" varStatus="status">
															<option value="${proj.CD}" <c:if test="${proj.CD eq params.searchGubun6 }">selected="selected"</c:if> >${proj.CD_NM}</option>
														</c:forEach>
														<%-- <select id="proj_cd" name="proj_cd" class="form-control">
															<option value="">선택</option>
															<c:forEach var="proj" items="${projList }" varStatus="status">
															<option value="${proj.CD }" <c:if test="${proj.CD eq viewMap.PROJ_CD }" >selected="selected"</c:if> >${proj.CD_NM }</option>
															</c:forEach>
														</select> --%>
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
							<p class="clearfix board-top">
								<sec:authorize access="hasAnyRole('ROLE_ADMIN')">
									<%-- <select id="listCnt" name="listCnt" class="form-control" style="width: 100px; display: inline-block;" onchange="goPage('1');">
										<option value="10" <c:if test="${params.listCnt == '10'}">selected = "selected"</c:if>>10</option>
										<option value="20" <c:if test="${params.listCnt == '20'}">selected = "selected"</c:if>>20</option>
										<option value="30" <c:if test="${params.listCnt == '30'}">selected = "selected"</c:if>>30</option>
										<option value="50" <c:if test="${params.listCnt == '50'}">selected = "selected"</c:if>>50</option>
										<option value="100" <c:if test="${params.listCnt == '100'}">selected = "selected"</c:if>>100</option>
									</select> --%>
									<br>
									<span class="pull-right">
										<button class="fnExcl btn btn-sm btn-default" >엑셀다운</button>
									</span>
									
									<strong class="list_count" >Total : ${totalCnt} 건</strong>
								</sec:authorize>
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
									<!-- <th class="visible-md visible-lg">휴가부여일수(일)</th>
									<th>퇴사일</th> -->
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
													<a href="javascript:fnView('${list.USS_ID}', '${list.STDD_YR}');">
														<span class="ellip ellip-line">${list.USS_NM}</span>
													</a>
												</td>
												<td>${list.EMP_TYPE_NM}</td>
												<td>${list.PROJ_NM} </td>
												<td>${list.AUTH_NM} </td>
												<td align="center">${list.RTR_YN == 'Y'? '퇴사' : '재직중'}</td>
												<td align="center">${list.JOIN_DT}</td>
												<td align="right">${list.WORK_YR_CNT }</td>
												<%-- <td align="right"><input id="vct_grnt_day" type="number" class="form-control text-right vct-grnt-day"  min="0" value="${empty list.VCT_GRNT_DAY ? 0 : list.VCT_GRNT_DAY}" 
													<c:if test="${empty list.VCT_GRNT_DAY || list.VCT_GRNT_DAY == 0}">style="color: red;"</c:if> name="vct_grnt_day-${list.USS_ID}" oninput="this.value = this.value.replace(/[^0-9]/g, '')" <c:if test="${year > list.STDD_YR || list.RTR_YN == 'Y'}">readonly</c:if>>
												</td>
												<td align="center">${list.RTR_DT}</td> --%>
											</tr>
										</c:forEach>
									</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					</div>
					<div class="table-responsive" id="uss-vct">
						<table class="table table-bordered" summary="휴가현황 목록">
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
							</colgroup>
							<thead>
								<tr>
									<th class="visible-md visible-lg">휴가구분</th>
									<th>휴가부여일수</th>
									<th>사용일수</th>
									<th>잔여일수</th>
									<th>활용률</th>
									<th>1월</th>
									<th>2월</th>
									<th>3월</th>
									<th>4월</th>
									<th>5월</th>
									<th>6월</th>
									<th>7월</th>
									<th>8월</th>
									<th>9월</th>
									<th>10월</th>
									<th>11월</th>
									<th>12월</th>
									<!-- <th class="visible-md visible-lg">재직구분</th>
									<th>입사일</th>
									<th>근속년수(년)</th> -->
									<!-- <th class="visible-md visible-lg">휴가부여일수(일)</th>
									<th>퇴사일</th> -->
								</tr>
							</thead>
							<tbody>
								<c:forEach var="list" items="${resultList}" varStatus="status">
									<tr data-id="${list.USS_ID}">
										<th class="visible-md visible-lg text-right">${totalCnt - status.index - ((cPage-1) * (intListCnt))}</th>
										<td align="center">${list.STDD_YR} </td>
										<td>
											<a href="javascript:fnView('${list.USS_ID}', '${list.STDD_YR}');">
												<span class="ellip ellip-line">${list.USS_NM}</span>
											</a>
										</td>
										<td>${list.EMP_TYPE_NM}</td>
										<td>${list.PROJ_NM} </td>
										<td>${list.AUTH_NM} </td>
										<td align="center">${list.RTR_YN == 'Y'? '퇴사' : '재직중'}</td>
										<td align="center">${list.JOIN_DT}</td>
										<td align="right">${list.WORK_YR_CNT }</td>
										<%-- <td align="right"><input id="vct_grnt_day" type="number" class="form-control text-right vct-grnt-day"  min="0" value="${empty list.VCT_GRNT_DAY ? 0 : list.VCT_GRNT_DAY}" 
											<c:if test="${empty list.VCT_GRNT_DAY || list.VCT_GRNT_DAY == 0}">style="color: red;"</c:if> name="vct_grnt_day-${list.USS_ID}" oninput="this.value = this.value.replace(/[^0-9]/g, '')" <c:if test="${year > list.STDD_YR || list.RTR_YN == 'Y'}">readonly</c:if>>
										</td>
										<td align="center">${list.RTR_DT}</td> --%>
									</tr>
								</c:forEach>
							</tbody>
						</table>
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
				<input type="hidden" id="stdd_yr" name="stddYr" value="" />
				<input type="hidden" id="uss_id" name="ussId" value="" />
			</form>
			<jsp:include page="/resources/com/inc/aside.jsp" />
		</section>
	</div>
	 	<jsp:include page="/resources/com/inc/footer.jsp" />
	</div>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript">

		/* 엑셀Down */
		$( ".fnExcl" ).click(function() {
			/* $("#frm1").attr("action", "${pageContext.request.contextPath}/sys/vct/vct00Tran.do");
			$("#frm1").submit(); */
		});
		
		/* 검색 */
		$( ".fnSearch" ).click(function() {
			goPage(1);
		});
		
		/* 상세보기 팝업 */
		$( ".fnDtil" ).click(function() {
			
			window.open("", "vct00Popup","width=720, height=750");
			$("#dtilFrm").attr("target", "vct00Popup");
//	 		$("#not_uss_id").val($("#rept_aprv_no").val());
			$("#dtilFrm").attr("action", "${pageContext.request.contextPath}/vct/vct00Popup.do");
			$("#dtilFrm").submit();
			//$("#frm1").attr("action", "${pageContext.request.contextPath}/sys/vct/vct00Tran.do");
			//$("#frm1").submit();
		});
		
		/* 휴가현황목록조회 */
		function fnView(uss_id, stdd_yr){
			var ussId = uss_id;
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
					    table = '<table class="table table-bordered" summary="휴가현황 목록">'
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
						table += '<tr>';'
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
					    tab;e += '<tbody>';
						<c:forEach var="list" items="${resultList}" varStatus="status">
						for (var i = 0; i < resultList.length ; i++){
							var result = resultList[i];
							table += '<tr data-id="'+result.USS_ID+'">';
							table += '<th class="visible-md visible-lg text-right">'+result.VCT_TYPE_NM+'</th>';
							table += '<td align="center">'+result.VCT_GRNT_DAY+'</td>';
							table += '<td>'+result.VCT_TOT_USE_CNT+'</td>';
							table += '<td>'+result.VCT_LEFT_DAY+'</td>';
							table += '<td>'+result.VCT_USE_RATE+'</td>';
							table += '<td>'+result.JAN_CNT+'</td>';
							table += '<td>'+result.FEB_CNT+'</td>';
							table += '<td>'+result.MAR_CNT+'</td>';
							//table += '<td>'+result.FIR_QRTR_CNT+'</td>';
							table += '<td>'+result.APR_CNT+'</td>';
							table += '<td>'+result.MAY_CNT+'</td>';
							table += '<td>'+result.JUN_CNT+'</td>';
							table += '<td>'+result.SEC_QRTR_CNT+'</td>';
							table += '<td>'+result.JUL_CNT+'</td>';
							table += '<td>'+result.AUG_CNT+'</td>';
							table += '<td>'+result.SEP_CNT+'</td>';
							//table += '<td>'+result.THR_QRTR_CNT+'</td>';
							table += '<td>'+result.OCT_CNT+'</td>';
							table += '<td>'+result.NOV_CNT+'</td>';
							table += '<td>'+result.DEC_CNT+'</td>';
							//table += '<td>'+result.FRT_QRTR_CNT+'</td>';
							
							table += '</tr>;
							
						}
							
						table += '</tbody>';
						table += '</table>';
						table += '<span class="pull-right">';
						table += '<button class="fnDtil btn btn-sm btn-default" >상세보기</button>';
						table += '</span>';
						
						$("#stdd_yr").val(stddYr);
						$("#uss_id").val(ussId);
						
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
</body>
</html>