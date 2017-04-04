<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Letech Intranet</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
</head>

<body>
	<div id="wrap">
		<jsp:include page="/resources/com/inc/header.jsp" />
	    <%-- <jsp:include page="/resources/com/inc/menu.jsp" /> --%>
		<%--<jsp:include page="/WEB-INF/views/letech/com/layout/menu.jsp" /> --%>
		<%@ include file="/WEB-INF/views/letech/com/layout/menu.jsp" %>
	    <div class="container">
	   	 	<jsp:include page="/resources/com/inc/aside.jsp" />
	   	 	<section class="contents">
	
				<!-- page -->
					<form name="frm1" id="frm1" method="post" action="${pageContext.request.contextPath}/uss/umt/uss00List.do" >
						<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}" />
						<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}" />
						<input type="hidden" id="cPage" name="cPage" value="${cPage }" />
						<!-- 타이틀 및 페이지 네비 -->
							<h2 class="sub_title">
								${titleNaviMap.MN_NM }
								<span class="page_navi full-right">HOME > ${titleNaviMap.NAVI_NM }</span>
							</h2>
						<fieldset>
							<input type="hidden" name="uss_id" id="uss_id" value=""/>
							<p class=" ">
								<strong class="list_count" >Total : ${totalCnt} 건</strong>
							</p>
							<div class="full-right">
								<div class="">
										<select name="searchGubun" id="searchGubun" class="" title="search" >
											<option value="01" <c:if test="${params.searchGubun == '01'}">selected = "selected"</c:if>>ID</option>
											<option value="02" <c:if test="${params.searchGubun == '02'}">selected = "selected"</c:if>>성명</option>
										</select>
										<input type="text" name="searchField" id="searchField"  value="${params.searchField}" class="" title="검색어 입력" />
										<input type="button" class="fnSearch btn_default" value="검색" title="검색" />
									</div>
								</div>
						</fieldset>
						<table  width="100%" cellspacing="0" cellpadding="0"  summary="사용자관리 목록">
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
									<th>번호</th>
									<th>ID</th>
									<th>부서</th>
									<th>성명</th>
									<th>권한</th>
									<th>이메일</th>
									<th>전화번호</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${totalCnt < 1 }">
										<tr>
											<td colspan="5">검색된 내용이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="list" items="${resultList}" varStatus="status">
											<tr>
												<th>${totalCnt - status.index - ((cPage-1) * (intListCnt))}</th>
												<td >
													<a href="javascript:fnView('${list.USS_ID}');">${list.USS_ID}</a> 
												</td>
												<td>${list.DP_NM}</td>
												<td>${list.USS_NM}</td>
												<td>${list.USS_AUTH_NM}</td>
												<td>${list.USS_EMAIL}</td>
												<td>${list.USS_TEL}</td>
											</tr>
										</c:forEach>
									</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					<div class="table_foot2">
						<!-- pase nav-->
						<p class="page_nav">
							<strong>${pageNavigator }</strong>
							<button class="fnJoin full-right btn btn_info" >등 록</button>
						</p>
					</div>
					<div>
						
					</div>
</form>
			</article>
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