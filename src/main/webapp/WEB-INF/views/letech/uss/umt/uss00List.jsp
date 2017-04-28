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
	<div id="warpper">
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
								<div class="clearfix search-box">
									<input type="hidden" name="uss_id" id="uss_id" value=""/>
									<div class="search-container ">
										<div class ="col-xs-5 un-style">
											<span class="inline-element">
												<select name="searchGubun" id="searchGubun" class="form-control" title="search" >
													<option value="01" <c:if test="${params.searchGubun == '01'}">selected = "selected"</c:if>>ID</option>
													<option value="02" <c:if test="${params.searchGubun == '02'}">selected = "selected"</c:if>>성명</option>
												</select>
											</span>
										</div>
										<div class="col-xs-7 un-style">
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
							<p class="clearfix board-top">
								<span class="pull-right">
									<button class="fnJoin btn btn-sm btn-warning" >등 록</button>
								</span>
								<strong class="list_count" >Total : ${totalCnt} 건</strong>
							</p>
						<div class="table-responsive">
						<table class="table table-bordered" summary="사용자관리 목록">
							<colgroup>
								<col width="10%" />
								<col width="15%" />
								<col width="15%" />
								<col width="15%" />
								<col width="10%" />
								<col width="15%" />
								<col width="*" />
							</colgroup>
							<thead>
								<tr>
									<th class="visible-md visible-lg">번호</th>
									<th>ID</th>
									<th>부서</th>
									<th>성명</th>
									<th>권한</th>
									<th class="visible-md visible-lg">이메일</th>
									<th class="visible-md visible-lg">전화번호</th>
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
												<th class="visible-md visible-lg">${totalCnt - status.index - ((cPage-1) * (intListCnt))}</th>
												<td >
													<a href="javascript:fnView('${list.USS_ID}');">${list.USS_ID}</a> 
												</td>
												<td>${list.DP_NM}</td>
												<td>${list.USS_NM}</td>
												<td>${list.USS_AUTH_NM}</td>
												<td class="visible-md visible-lg">${list.USS_EMAIL}</td>
												<td class="visible-md visible-lg">${list.USS_TEL}</td>
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
								<button class="fnJoin btn btn-sm btn-warning" >등 록</button>
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