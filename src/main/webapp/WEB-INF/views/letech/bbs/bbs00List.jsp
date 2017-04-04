<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>Letech Intranet</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/bbs_${bbsInfo.LAYOUT_TY}.css">
	
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
					<input type="hidden" name="bbs_id" id="bbs_id" value="${params.bbs_id }" />
					<input type="hidden" name="bbs_seq" id="bbs_seq" value="" />
<!-- 					<input type="hidden" name="bbs_nm" id="bbs_nm" value="" />
 -->					
					<!-- 타이틀 및 페이지 네비 -->
					<h2 class="sub_title">
						 ${params.bbs_nm}
						<span class="page_navi full-right">HOME > ${titleNaviMap.MN_NM } > ${params.bbs_nm}</span>
					</h2>
					<!--tab  -->
					<c:if test="${bbsTabList ne null}">
						<article>
							<ul class="tab_gnb">
								<c:forEach var="list3" items="${bbsTabList}" varStatus="status">
									<c:if test="${params.bbs_id eq list3.BBS_ID}">
										<c:set var="bbsNm" value="${list3.BBS_NM}" />
									</c:if>
									<li class="<c:if test="${params.bbs_id eq list3.BBS_ID}">on </c:if>col_md_3">
										<a href="#" onclick="fnTabMove('bbs/bbs00List.do','${list3.BBS_ID}')">${list3.BBS_NM}</a>
									</li>
								</c:forEach>
							</ul>
				   		</article>
					</c:if>
					
					
					
					<fieldset>
						<p class=" ">
							<strong class="list_count" >Total : ${totalCnt} 건</strong>
						</p>
						<div class="full-right">
							<select name="searchGubun" id="searchGubun" class="" title="search" >
								<option value="01" <c:if test="${params.searchGubun == '01'}">selected = "selected"</c:if>>제목</option>
								<option value="02" <c:if test="${params.searchGubun == '02'}">selected = "selected"</c:if>>내용</option>
							</select>

							<input type="text" name="searchField" id="searchField"  value="${params.searchField}" class="" title="검색어 입력" />
							<input type="button" class="fnSearch btn_default" value="검색" title="검색" />
						</div>
						
					</fieldset>
					<table class="list_table" summary="사용자관리 목록">
						<colgroup>
							<col width="10%" />
							<col width="50%" />
							<col width="10%" />
							<col width="20%" />
							<col width="10%" />
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>히트수</th>
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
											<td style="text-align:left">
												<c:forEach begin="1" end="${list.LEVEL_CNT }" step="1">
													<span class="re_re"></span>
												</c:forEach>
												<a href="#" onclick="fnView('${list.BBS_SEQ}');">${list.TITLE}</a> 
											</td>
											<td>${list.REG_NM}</td>
											<td>${list.REG_DT}</td>
											<td>${list.HIT}</td>
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
			</form>
		</section>
	</div>
	 	<jsp:include page="/resources/com/inc/footer.jsp" />
	</div>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript">

		/* 등록 */
			
		$( ".fnJoin" ).click(function() {
			$("#frm1").attr("action", "${pageContext.request.contextPath}/bbs/bbs00Form.do");
			$("#frm1").submit();
		});
		/* 검색 */
		$( ".fnSearch" ).click(function() {
			goPage("1");
		});
		/* 상세조회 */
		function fnView(bbs_seq){
			$("#bbs_seq").val(bbs_seq);
			$("#frm1").attr("action", "${pageContext.request.contextPath}/bbs/bbs00View.do");
			$("#frm1").submit();
		}
		
		function goPage(cPage){
			$("#cPage").val(cPage);
			$("#frm1").attr("action", "${pageContext.request.contextPath}/bbs/bbs00List.do");
			$("#frm1").submit();
		}
		
		/*********************************************************************************
		* function명   : fnTabMove
		* function기능 : 탭이동
		**********************************************************************************/
		function fnTabMove(href,pm1){
			$("#bbs_id").val(pm1);
			$("#searchGubun").val("");
			$("#searchField").val("");
			$("#frm1").attr("action", "${pageContext.request.contextPath}/"+href);
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