<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
			<%@ include file="/WEB-INF/views/letech/com/layout/menu.jsp"%>
		</nav>
		<!-- 컨텐츠-->
		<div class="" id="page-wrapper">
			<section class="row">

				<!-- 내용부분(작업할 부분 클래스 col-lg-10안에 넣음 됨) -->
				<div class="col-lg-10">
					<!-- page -->
					<form class="form-horizontal" name="frm1" id="frm1" method="post">
						<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}" />
						<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}" />
						<input type="hidden" name="pop_seq" id="pop_seq" value="" />
						<input type="hidden" name="cPage" id="cPage" value="${cPage }" />
						<!--<input type="hidden" name="bbs_nm" id="bbs_nm" value="" />-->

						<!-- 타이틀 및 페이지 네비 -->
						<h2 class="page-title clearfix">
							${titleNaviMap.MN_NM}
							<span class="pull-right site-map"> HOME > ${titleNaviMap.NAVI_NM} </span>
						</h2>
						<div class="form-container">
							<div class="clearfix search-box align-middle">
								<div class="form-group">
									<label class="control-label col-sm-1" for="title">제목</label>
									<div class="col-sm-3">
										<input type="text" class="form-control" id="title" placeholder="제목을 입력하세요">
									</div>
								</div>
								<div class="form-group" style="margin-bottom: 0px;">
									<label class="control-label col-sm-1" for="content">내용</label>
									<div class="col-sm-3">
										<input type="text" class="form-control" id="content" placeholder="내용을 입력하세요">
									</div>
									<div class="col-sm-6"></div>
									<div class="col-sm-2">
										<span class="input-group-btn" style="text-align: right;">
											<button class=" fnSearch btn btn-info" type="button" onclick="search();">
												<i class="glyphicon glyphicon-search"></i>
												<span class="hidden-xs hidden-sm"> 검색</span>
											</button>
										</span>
									</div>
								</div>

							</div>
							<p class="clearfix board-top">
								<span class="pull-right">
									<input type="button" class="fnJoin btn btn-sm btn-default" value="등록" />
								</span>
								<strong class="list_count">Total : ${totalCnt} 건</strong>
							</p>
							<div class="table-responsive">
								<table class="table table-bordered reactive">
									<colgroup>
										<col width="50" class="hidden-xs hidden-sm" />
										<col width="180" />
										<col width="*" />
										<col width="80" class="hidden-xs hidden-sm" />
										<col width="130" class="hidden-xs hidden-sm" />
									</colgroup>
									<thead>
										<tr role="row">
											<th class="hidden-xs hidden-sm">번호</th>
											<th class="">기간</th>
											<th class="">제목</th>
											<th class="hidden-xs hidden-sm">작성자</th>
											<th class="hidden-xs hidden-sm">작성일</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="text-center hidden-xs hidden-sm">5</td>
											<td class="text-center">
												<a href="javascript:fnView()">2022.02.11 ~ 2022-02-28</a>
											</td>
											<td>
												<span class="ellip ellip-line">[공지]인트라넷 수정사항 배포</span>
											</td>
											<td class="text-center hidden-xs hidden-sm">관리자1</td>
											<td class="text-center hidden-xs hidden-sm">2022-02-11</td>
										</tr>
										<tr>
											<td class="text-center hidden-xs hidden-sm">4</td>
											<td class="text-center">
												<a href="#">2022.02.11 ~ 2022-02-28</a>
											</td>
											<td>
												<span class="ellip ellip-line">[공지]인트라넷 수정사항 배포</span>
											</td>
											<td class="text-center hidden-xs hidden-sm">관리자1</td>
											<td class="text-center hidden-xs hidden-sm">2022-02-11</td>
										</tr>
										<tr>
											<td class="text-center hidden-xs hidden-sm">3</td>
											<td class="text-center">
												<a href="#">2022.02.11 ~ 2022-02-28</a>
											</td>
											<td>
												<span class="ellip ellip-line">[공지]인트라넷 수정사항 배포</span>
											</td>
											<td class="text-center hidden-xs hidden-sm">관리자1</td>
											<td class="text-center hidden-xs hidden-sm">2022-02-11</td>
										</tr>
										<tr>
											<td class="text-center hidden-xs hidden-sm">2</td>
											<td class="text-center">
												<a href="#">2022.02.11 ~ 2022-02-28</a>
											</td>
											<td>
												<span class="ellip ellip-line">[공지]인트라넷 수정사항 배포</span>
											</td>
											<td class="text-center hidden-xs hidden-sm">관리자1</td>
											<td class="text-center hidden-xs hidden-sm">2022-02-11</td>
										</tr>
										<tr>
											<td class="text-center hidden-xs hidden-sm">1</td>
											<td class="text-center">
												<a href="#">2022.02.11 ~ 2022-02-28</a>
											</td>
											<td>
												<span class="ellip ellip-line">[공지]인트라넷 수정사항 배포</span>
											</td>
											<td class="text-center hidden-xs hidden-sm">관리자1</td>
											<td class="text-center hidden-xs hidden-sm">2022-02-11</td>
										</tr>

										<%-- 										<c:choose> --%>
										<%-- 											<c:when test="${totalCnt < 1 }"> --%>
										<!-- 												<tr> -->
										<!-- 													<td class="text-center" colspan="5">검색된 내용이 없습니다.</td> -->
										<!-- 												</tr> -->
										<%-- 											</c:when> --%>
										<%-- 											<c:otherwise> --%>
										<%-- 												<c:forEach var="list" items="${resultList}" varStatus="status"> --%>
										<!-- 													<tr class="gradeA odd" role="row"> -->
										<%-- 														<td class="text-center hidden-xs hidden-sm">${totalCnt - status.index - ((cPage-1) * (intListCnt))}</td> --%>
										<!-- 														<td class=""> -->
										<%-- 															<c:forEach begin="1" end="${list.LEVEL_CNT }" step="1"> --%>
										<!-- 																<span class="re_re"></span> -->
										<%-- 															</c:forEach> --%>
										<%-- 															<a class="" href="#" onclick="fnView('${list.BBS_SEQ}');"> --%>
										<%-- 																<span class="ellip ellip-line">${list.TITLE}</span> --%>
										<!-- 															</a> -->
										<!-- 														</td> -->
										<!-- 														
<!-- 														22.03.21 김민석 서식자료실 작성자 미출력 추가  -->
										<!-- 													-->
										<%-- 														<c:if test="${bbsInfo.BBS_ID  ne 'BB0005'}"> --%>
										<%-- 															<td class="text-center hidden-xs hidden-sm">${list.REG_NM}</td> --%>
										<%-- 														</c:if> --%>
										<%-- 														<td class="text-center">${list.REG_DT}</td> --%>
										<%-- 														<td class="text-center hidden-xs hidden-sm">${list.HIT}</td> --%>
										<!-- 													</tr> -->
										<%-- 												</c:forEach> --%>
										<%-- 											</c:otherwise> --%>
										<%-- 										</c:choose> --%>
									</tbody>
								</table>
							</div>


							<div class="text-center">
								<ul class="pagination pagination-sm">${pageNavigator}
								</ul>
							</div>
							<div class="clearfix">
								<span class="form-inline pull-right">
									<input type="button" class="fnJoin btn btn-sm btn-default" value="등록" />
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
	<script src="${pageContext.request.contextPath}/resources/js/jquery.dataTables.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/dataTables.responsive.js"></script>
	<script type="text/javascript">
		//엔터 입력 시 폼 전송 방지	
		$('input[type="text"]').keydown(function() {
			if (event.keyCode === 13) {
				event.preventDefault();
			}
		});

		/* 등록 */

		$(".fnJoin").click(function() {
			$("#frm1").attr("action", "${pageContext.request.contextPath}/pop/pop00Form.do");
			$("#frm1").submit();
		});
		/* 검색 */
		$(".fnSearch").click(function() {
			//alert("엔터");
			goPage("1");
		});
		/* 상세조회 */
		function fnView(pop_seq) {
			if(typeof pop_seq == "undefined" || pop_seq == null || pop_seq == ""){
				pop_seq= "proto"
			}
			$("#pop_seq").val(pop_seq);
			$("#frm1").attr("action","${pageContext.request.contextPath}/pop/pop00View.do");
			$("#frm1").submit();
		}

		function goPage(cPage) {
			//alert('엔터');
			$("#cPage").val(cPage);
			$("#frm1").attr("action","${pageContext.request.contextPath}/pop/pop00List.do");
			$("#frm1").submit();
		}

		/*********************************************************************************
		 * function명   : fnTabMove
		 * function기능 : 탭이동
		 **********************************************************************************/
		function fnTabMove(href, pm1) {
			//alert("엔터");
			$("#bbs_id").val(pm1);
			$("#searchGubun").val("");
			$("#searchField").val("");
			$("#frm1").attr("action","${pageContext.request.contextPath}/" + href);
			$("#frm1").submit();
		}

		/*sub_menu 탭*/
		$(function() {
			//alert("엔터");
			$("article.sub_contents:not("
				+ $("ul.tab_gnb li a.sub_nav_on").attr("href")
				+ ")").hide()
			$("ul.tab_gnb li a").click(function() {
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