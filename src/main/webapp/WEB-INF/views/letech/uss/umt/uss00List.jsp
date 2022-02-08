<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<jsp:include page="/resources/com/inc/meta.jsp" />
	<title>Letech Intranet</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
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
				<!-- page -->
					<form name="frm1" id="frm1" method="post" action="${pageContext.request.contextPath}/uss/umt/uss00List.do" >
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
								<div class="clearfix search-box form-inline">
									<input type="hidden" name="uss_id" id="uss_id" value=""/>
									<div class="row">
										<div class ="col-md-6 un-style form-inline mt10">
											<span class="inline-element col-md-8 col-md-offset-2"  >
												<label>고용구분</label>
												<select name="searchGubun3" id="searchGubun3" class="form-control" title="search" style="font-size: 12px; width : 125px; display:inline-block; margin-right: 10px;" >
													<option value="" >전체</option>
													<c:forEach var="empType" items="${empTypeList}">
														<option value="${empType.CD}" <c:if test="${empType.CD eq params.searchGubun3 }">selected="selected"</c:if> >${empType.CD_NM}</option>
													</c:forEach>
												</select>
											</span>
										</div>
										<div class ="col-md-6 un-style form-inline mt10">
											<span class="inline-element col-sm-12">
												<label>소속부서</label>
												<select name="searchGubun4" id="searchGubun4" class="form-control" title="search" style="font-size: 12px; display:inline-block; margin-right: 10px;" >
													<option value="" >전체</option>
													<c:forEach var="departList" items="${departList}">
														<option value="${departList.DP_CD}" <c:if test="${departList.DP_CD eq params.searchGubun4 }">selected="selected"</c:if> >${departList.DP_NM}</option>
													</c:forEach>
												</select>
											</span>
										</div>
										
									</div>
									<div class="row">
										<div class ="col-md-6 un-style form-inline mt10">
											<span class="inline-element col-md-8 col-md-offset-2">
												<label >재직구분</label>
												<select name="searchGubun2" id="searchGubun2" class="form-control" title="search" style="font-size: 12px; width : 125px; display:inline-block; margin-right: 10px;" >
													<option value="" >전체</option>
													<option value="N" <c:if test="${params.searchGubun2 == 'N'}">selected = "selected "</c:if>>재직</option>
													<option value="Y" <c:if test="${params.searchGubun2 == 'Y'}">selected = "selected"</c:if>>퇴직</option>
												</select>
											</span>
										</div>
										<div class="clearfix">
										</div>
										<%-- <div class ="col-md-6 un-style form-inline">
											<span class="inline-element col-sm-11 col-sm-offset-2">
												<label>소속부서</label>
												<select name="searchGubun4" id="searchGubun4" class="form-control" title="search" >
													<option value="" >전체</option>
													<c:forEach var="departList" items="${departList}">
														<option value="${departList.DP_CD}" <c:if test="${departList.DP_CD eq params.searchGubun4 }">selected="selected"</c:if> >${departList.DP_NM}</option>
													</c:forEach>
												</select>
											</span>
										</div> --%>
										<%-- <div class ="col-md-6 un-style form-inline">
											<span class="inline-element col-md-8 col-md-offset-2">
												<label>직급권한</label>
												<select name="searchGubun5" id="searchGubun5" class="form-control" title="search" >
													<option value="" >전체</option>
													<c:forEach var="authList" items="${authList}">
														<option value="${authList.AUTHOR_CODE}" <c:if test="${authList.AUTHOR_CODE eq params.searchGubun5 }">selected="selected"</c:if> >${authList.AUTHOR_NM}</option>
													</c:forEach>
												</select>
											</span>
										</div> --%>
									</div>
									
									<div class="row">
										<div class ="col-md-6 un-style form-inline mt10">
											<span class="inline-element col-md-8 col-md-offset-2">
												<label>직급권한</label>
												<select name="searchGubun5" id="searchGubun5" class="form-control" title="search" style="font-size: 12px; width : 125px; display:inline-block; margin-right: 10px;" >
													<option value="" >전체</option>
													<c:forEach var="authList" items="${authList}">
														<option value="${authList.AUTHOR_CODE}" <c:if test="${authList.AUTHOR_CODE eq params.searchGubun5 }">selected="selected"</c:if> >${authList.AUTHOR_NM}</option>
													</c:forEach>
												</select>
											</span>
										</div>
										
										<div class ="col-md-6 un-style mt10">
											<div class="col-md-12">
												<div class ="un-style col-md-12 form-inline">
													<span class="inline-element">
														<!-- <label>ID/성명</label> -->
														<select name="searchGubun" id="searchGubun" class="form-control" style="display: inline-block;" title="search" >
															<option value="01" <c:if test="${params.searchGubun == '01'}">selected = "selected"</c:if>>ID</option>
															<option value="02" <c:if test="${params.searchGubun == '02'}">selected = "selected"</c:if>>성명</option>
														</select>
														<span class="input-group col-md-8 col-xl-4" style="max-width: 250px;">
															<input type="text" name="searchField" id="searchField"  value="${params.searchField}" class="form-control" style="inline-block;" title="검색어 입력" />
															<span class="input-group-btn">
																<button type="button" class="fnSearch btn-info btn"  >
																	<i class="glyphicon glyphicon-search"></i><span class="hidden-xs hidden-sm"> 검색</span>
																</button>
															</span>
														</span>
													</span>
												</div>
											</div>
										</div>
									</div>
								</div>
						<!-- 	</div> -->
							<p class="clearfix board-top">
								<span class="pull-right">
									<button class="fnJoin btn btn-sm btn-default" >등 록</button>
								</span>
								<strong class="list_count" >Total : ${totalCnt} 건</strong>
							</p>
						<div class="table-responsive">
						<table class="table table-bordered" summary="사용자관리 목록">
							<colgroup>
								<%-- <col width="5%" />
								<col width="10%" />
								<col width="15%" />
								<col width="10%" />
								<col width="5%" />
								<col width="5%" />
								<col width="15%" />
								<col width="15%" />
								<col width="5%" /> --%>
							</colgroup>
							<thead>
								<tr>
									<th class="visible-md visible-lg" style="vertical-align: middle;">번호</th>
									<th style="vertical-align: middle;">ID</th>
									<th style="vertical-align: middle;">부서</th>
									<th style="vertical-align: middle;">성명</th>
									<th style="vertical-align: middle;">고용구분</th>
									<th style="vertical-align: middle;">권한</th>
									<th class="visible-md visible-lg" style="vertical-align: middle;">이메일</th>
									<th class="visible-md visible-lg" style="vertical-align: middle;">전화번호</th>
									<th style="vertical-align: middle;">재직구분</th>
									
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
										<c:forEach var="list" items="${resultList}" varStatus="status">
											<tr>
												<th style="vertical-align: middle;" class="visible-md visible-lg text-center">${totalCnt - status.index - ((cPage-1) * (intListCnt))}</th>
												<td style="vertical-align: middle;" align="center" >
													<a href="javascript:fnView('${list.USS_ID}');">${list.USS_ID}</a> 
												</td>
												<td style="vertical-align: middle;">${list.DP_NM}</td>
												<td style="vertical-align: middle;" align="center">${list.USS_NM}</td>
												<td style="vertical-align: middle;" align="center">${list.EMP_TYPE_NM }</td>
												<td style="vertical-align: middle;" align="center">${list.USS_AUTH_NM}</td>
												<td style="vertical-align: middle;" class="visible-md visible-lg">${list.USS_EMAIL}</td>
												<td style="vertical-align: middle;" class="visible-md visible-lg">${list.USS_TEL}</td>
												<td style="vertical-align: middle;" align="center">${list.RTR_YN == 'Y'? '퇴직' : '재직'}</td>
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
								<button class="fnJoin btn btn-sm btn-default" >등 록</button>
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
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript">

		/* 등록 */
			
		$( ".fnJoin" ).click(function() {
			$("#frm1").attr("action", "${pageContext.request.contextPath}/uss/umt/uss00Form.do");
			$("#frm1").submit();
		});
		/* 검색 */
		$( ".fnSearch" ).click(function() {
			goPage(1);
		});
		/* 상세조회 */
		function fnView(uss_id){
			$("#uss_id").val(uss_id);
			$("#frm1").attr("action", "${pageContext.request.contextPath}/uss/umt/uss00View.do");
			$("#frm1").submit();
		}
		
		function goPage(cPage){
			$("#cPage").val(cPage);
			$("#frm1").attr("action", "${pageContext.request.contextPath}/uss/umt/uss00List.do");
			$("#frm1").submit();
		}
		
	
		/*sub_menu 탭*/
		$(function(){
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