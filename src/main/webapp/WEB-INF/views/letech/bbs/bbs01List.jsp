<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<jsp:include page="/resources/com/inc/meta.jsp" />
	<title>Letech Intranet</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/bbs_${bbsInfo.LAYOUT_TY}.css">
	
</head>

<body>
	<!-- 전체 감싸는 id -->
	<div id="wrapper">
		<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
			<jsp:include page="/resources/com/inc/header.jsp" />
			<%@ include file="/WEB-INF/views/letech/com/layout/menu.jsp" %>
		</nav>
		
		<%-- <jsp:include page="/resources/com/inc/header.jsp" />
	    <jsp:include page="/resources/com/inc/menu.jsp" />
		<jsp:include page="/WEB-INF/views/letech/com/layout/menu.jsp" />
		<%@ include file="/WEB-INF/views/letech/com/layout/menu.jsp" %> --%>
		
	    <!-- 컨텐츠-->
   		<div class="" id="page-wrapper">
			<section class="row">
				<!-- 내용부분(작업할 부분 클래스 col-lg-10안에 넣음 됨) -->
				<div class="col-lg-10">
				<!-- page -->
					<form name="frm1" id="frm1" method="post" action="${pageContext.request.contextPath}/uss/umt/uss00List.do" >
						<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}" />
						<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}" />
						<input type="hidden" name="bbs_id" id="bbs_id" value="${params.bbs_id }" />
						<input type="hidden" name="bbs_seq" id="bbs_seq" value="" />
						<input type="hidden" name="bbs_nm" id="bbs_nm" value="" />
						
						<c:if test="${bbsTabList ne null}">
							<article>
								<ul class="tab_gnb">
									<c:forEach var="list3" items="${bbsTabList}" varStatus="status">
										<c:if test="${params.bbs_id eq list3.BBS_ID}">
											<c:set var="bbsNm" value="${list3.BBS_NM}" />
										</c:if>
										<%-- <li class="<c:if test="${params.bbs_id eq list3.BBS_ID}">on </c:if>col_md_3">
											<a href="#" onclick="fnTabMove('bbs/bbs00List.do','${list3.BBS_ID}')">${list3.BBS_NM}</a>
										</li> --%>
									</c:forEach>
								</ul>
					   		</article>
						</c:if>
						
						<!-- 타이틀 및 페이지 네비 -->
						<h2 class="page-title clearfix">
							${bbsNm}
							<span class="pull-right site-map">
								HOME > ${titleNaviMap.MN_NM } > ${bbsNm}
							</span>
						</h2>
						
						<div class="form-container">
						<div class="clearfix search-box">
							<div class="search-container">
								<div class="col-xs-5 un-style">
									<span class="inline-element">
										<select class="form-control " name="searchGubun" id="searchGubun" class="" title="search" >
											<option value="01" <c:if test="${params.searchGubun == '01'}">selected = "selected"</c:if>>제목</option>
											<option value="02" <c:if test="${params.searchGubun == '02'}">selected = "selected"</c:if>>내용</option>
										</select>
									</span>
								</div>
								<div class="col-xs-7 un-style">
									<div class="input-group">
										<input type="text" name="searchField" id="searchField"  value="${params.searchField}" class="form-control" title="검색어 입력" />
										<span class="input-group-btn">
											<button class="fnSearch btn btn-default" type="button">
													<i class="glyphicon glyphicon-search"></i>
													<span class="hidden-xs hidden-sm"> 검색</span>
											</button>
										</span>
									</div>
								</div>
							</div>
						</div>
						<p class="clearfix board-top">
							<span class="pull-right">
								<input type="button" class="fnJoin btn btn-sm btn-default" value="등록"/>
							</span>
							<strong class="list_count" >Total : ${totalCnt} 건</strong>
						</p>
						<div class="">
							<div class="gallery_bd">
								<c:choose>
									<c:when test="${fn:length(resultList) < 1 }">
										<ul class="none_result">
											<li>검색된 내용이 없습니다.</li>
										</ul>
									</c:when>
									<c:otherwise>
										<ul class="row">
											<c:forEach var="list" items="${resultList}" varStatus="status">
												<li>
														<dl class="row">
															<dt class="col-xs-3"><img src="${pageContext.request.contextPath}/cmm/FileDown.do?file_path=${list.FILE_PATH }&file_stre_nm=${list.FILE_STRE_NM }&file_nm=${list.FILE_STRE_NM }.${list.FILE_EXT}" alt="${list.FILE_NM }"  /></dt>
															<dd class="col-xs-9">
																<a class="img-title" href="#" onclick="fnView('${list.BBS_SEQ}');">${list.TITLE }</a>
																<div class="img_content">${list.CONTENT }</div>
																<span class="img_dt">${list.REG_DT }</span>
															</dd>
														</dl>
												</li>
											</c:forEach>
										</ul>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="text-center">
							<br/>
							<ul class="pagination pagination-sm">
								${pageNavigator }
							</ul>
							<span class="form-inline pull-right">
								<input type="button" class="fnJoin btn btn-sm btn-default" value="등록"/>
							</span>
						</div>
						</div>			 
					</form>
				</div>
				<!-- aside(공지사항) -->
				<jsp:include page="/resources/com/inc/aside.jsp" />
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
		function fnTabMove(href,pm1,pm2){
			$("#bbs_id").val(pm1);
			$("#bbs_nm").val(pm2);
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