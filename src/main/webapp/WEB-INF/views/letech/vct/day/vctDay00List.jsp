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
	
	<link href="https://unpkg.com/bootstrap-table@1.19.1/dist/bootstrap-table.min.css" rel="stylesheet">
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
											<!-- 기준년도  -->
											<div class="col-lg-3 col-sm-6 form-inline mt10">
												<label>기준년도</label>
												<div class="tui-datepicker-input tui-datetime-input tui-has-focus" style="vertical-align: middle; width: 90px;">
													<input type="text" id="datepicker-input-ko" name="searchGubun2" value="${params.searchGubun2}" aria-label="Date" class="" title="search">
													<span class="tui-ico-date"></span>
												</div>
												<div class="datepicker-cell" id="datepicker-year-ko"></div>
											</div>
											<!-- 재직구분  -->
											<div class="col-lg-3 col-sm-6 form-inline mt10">
												<label >재직구분</label>
												<div class="search-select-wrap" style="display:inline-block; vertical-align: middle;">
													<select name="searchGubun3" id="searchGubun3" class="form-control" style="font-size: 12px; width : 90px; display:inline-block;" title="search" >
														<option value="" >전체</option>
														<option value="N" <c:if test="${params.searchGubun3 == 'N'}">selected = "selected "</c:if>>재직</option>
														<option value="Y" <c:if test="${params.searchGubun3 == 'Y'}">selected = "selected"</c:if>>퇴직</option>
													</select>
												</div>
											</div>
											<!-- id/성명  -->
											<div class="col-lg-5 col-sm-12 mt10">
												<div class="col-xs-4 un-style">
													<span class="inline-element">
														<select name="searchGubun" id="searchGubun" class="form-control" style="display: inline;" title="search" >
															<option value="01" <c:if test="${params.searchGubun == '01'}">selected = "selected"</c:if>>ID</option>
															<option value="02" <c:if test="${params.searchGubun == '02'}">selected = "selected"</c:if>>성명</option>
														</select>
													</span>
												</div>
												<div class="col-xs-8 un-style">
													<div class="input-group">
														<input type="text" name="searchField" id="searchField"  value="${params.searchField}" class="form-control" title="검색어 입력" />
														<span class="input-group-btn">
															<button class="fnSearch btn btn-info" type="button">
																<i class="glyphicon glyphicon-search"></i>
																<span class="hidden-xs hidden-sm"> 검색</span>
															</button>
														</span>
													</div>
												</div>
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
								<br>
								<span class="pull-right">
									<button class="fnJoin btn btn-sm btn-default" >저 장</button>
								</span>
								<strong class="list_count" >Total : ${totalCnt} 건</strong>
							</p>
						<div class="table-responsive">
						<table class="table table-bordered" id="vct-day-table" summary="사용자관리 목록">
							<colgroup>
								<col width="3%" />
								<col width="5%" />
								<col width="10%" />
								<col width="10%" />
								<col width="5%" />
								<col width="10%" />
								<col width="10%" />
								<col width="5%" />
								<col width="10%" />
							</colgroup>
							<thead>
								<tr>
									<th class="visible-md visible-lg" data-align="center" data-valign="middle" data-halign="center">번호</th>
									<th data-align="center" data-valign="middle" data-halign="center">기준년도</th>
									<th data-align="center" data-valign="middle" data-halign="center" data-sortable="true">ID</th>
									<th data-align="center" data-valign="middle" data-halign="center" data-sortable="true">성명</th>
									<th data-align="center" data-valign="middle" data-halign="center" data-sortable="true" class="visible-md visible-lg">재직구분</th>
									<th data-align="center" data-valign="middle" data-halign="center" data-sortable="true">입사일</th>
									<th data-align="center" data-valign="middle" data-halign="center" data-sortable="true">근속년수(년)</th>
									<th data-align="center" data-valign="middle" data-halign="center" data-sortable="true" class="visible-md visible-lg">휴가부여일수(일)</th>
									<th data-align="center" data-valign="middle" data-halign="center" data-sortable="true">퇴사일</th>
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
											<tr>
												<th class="visible-md visible-lg text-center" style="vertical-align: middle;">${totalCnt - status.index - ((cPage-1) * (intListCnt))}</th>
												<td align="center" style="vertical-align: middle;">${list.STDD_YR} </td>
												<td style="vertical-align: middle;" align="center">${list.USS_ID} </td>
												<td align="center" style="vertical-align: middle;">${list.USS_NM}</td>
												<td align="center" style="vertical-align: middle;">${list.RTR_YN == 'Y'? '퇴직' : '재직'}</td>
												<td align="center" style="vertical-align: middle;">${list.JOIN_DT}</td>
												<td align="center" style="vertical-align: middle;">${list.WORK_YR_CNT }</td>
												<td align="right" style="vertical-align: middle;"><input id="vct_grnt_day" type="number" class="form-control text-right vct-grnt-day"  min="0" value="${empty list.VCT_GRNT_DAY ? 0 : list.VCT_GRNT_DAY}" 
													<c:if test="${(list.RTR_YN ne 'Y') &&(year <= list.STDD_YR) && (empty list.VCT_GRNT_DAY || list.VCT_GRNT_DAY == 0)}">style="color: red;"</c:if> name="vct_grnt_day-${list.USS_ID}" oninput="this.value = this.value.replace(/[^0-9]/g, '')" <c:if test="${year > list.STDD_YR || list.RTR_YN == 'Y'}">readonly</c:if>>
												</td>
												<td align="center" style="vertical-align: middle;">${list.RTR_DT}</td>
											</tr>
										</c:forEach>
									</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					</div>
					<div class="table_foot2">
						<!-- pase nav-->
						<div class="text-center">
						<br/>
							<ul class="pagination pagination-sm">
								${pageNavigator }
							</ul>
							<span class="pull-right">
								<button class="fnJoin btn btn-sm btn-default" >저 장</button>
							</span>
						</div>
					</div>
					<div>
						</div>
					</div>
				</form>
			</div>
			<jsp:include page="/resources/com/inc/aside.jsp" />
		</section>
	</div>
	 	<jsp:include page="/resources/com/inc/footer.jsp" />
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script> --%>
	<script src="https://unpkg.com/bootstrap-table@1.19.1/dist/bootstrap-table.min.js"></script>
	<script type="text/javascript">

		/* 저장 */
			
		$( ".fnJoin" ).click(function() {
			$("#frm1").attr("action", "${pageContext.request.contextPath}/sys/vct/vct00Tran.do");
			$("#frm1").submit();
		});
		/* 검색 */
		$( ".fnSearch" ).click(function() {
			goPage(1);
		});
		/* 상세조회 */
		/* function fnView(uss_id){
			$("#uss_id").val(uss_id);
			$("#frm1").attr("action", "${pageContext.request.contextPath}/uss/umt/uss00View.do");
			$("#frm1").submit();
		} */
		
		function goPage(cPage){
			$("#cPage").val(cPage);
			$("#frm1").attr("action", "${pageContext.request.contextPath}/sys/vct/vctDay00List.do");
			$("#frm1").submit();
		}
		
	
		/*sub_menu 탭*/
		$(function(){
			
			$("#vct-day-table").bootstrapTable();
			
			
			//년도 캘린더 만들기
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