<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<jsp:include page="/resources/com/inc/meta.jsp" />
<title>Letech Intranet</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/bbs_${bbsInfo.LAYOUT_TY}.css">
<style type="text/css">
.table-bordered tr td {
	text-align: center;
}

.table-bordered>thead>tr>td, .table-bordered>thead>tr>th {
	vertical-align: middle;
}
</style>
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
					<form name="frm1" id="frm1" method="post" action="/letech/bbs/bbs00List.do">
						<input type="hidden" id="menu_id1" name="menu_id1" value="MN0019">
						<input type="hidden" id="menu_id2" name="menu_id2" value="MN0020">
						<input type="hidden" name="bbs_id" id="bbs_id" value="BB0001">
						<input type="hidden" name="bbs_seq" id="bbs_seq" value="">
						<!--
							19.07.30 김지연 구버전 추가기능 복사 
							Revision 387 18. 8. 10. 오전 8:51	1	jwchoi	페이지 이동을 위한 input cpage 태그 없음으로 추가
						-->
						<input type="hidden" name="cPage" id="cPage" value="1">
						<!--<input type="hidden" name="bbs_nm" id="bbs_nm" value="" />-->

						<!-- 타이틀 및 페이지 네비 -->
						<h2 class="page-title clearfix">
							${titleNaviMap.MN_NM }
							<span class="pull-right site-map"> HOME > ${titleNaviMap.NAVI_NM } </span>
						</h2>


						<div class="form-container">
							<div class="clearfix search-box">
								<!-- 								<div class="search-container"> -->
								<!-- 									<div class="col-xs-5 un-style"> -->
								<!-- 										<span class="inline-element"> -->
								<!-- 											<select class="form-control" name="searchGubun" id="searchGubun" title="search"> -->
								<!-- 												<option value="01">제목</option> -->
								<!-- 												<option value="02">내용</option> -->
								<!-- 											</select> -->
								<!-- 										</span> -->
								<!-- 									</div> -->
								<!-- 									<div class="col-xs-7 un-style"> -->
								<!-- 										<div class="input-group"> -->
								<!-- 											<input type="hidden"> -->
								<!-- 											<input type="text" name="searchField" id="searchField" value="" class="form-control" title="검색어 입력"> -->
								<!-- 											<span class="input-group-btn"> -->
								<!-- 												<button class="fnSearch btn btn-info" type="button"> -->
								<!-- 													<i class="glyphicon glyphicon-search"></i> -->
								<!-- 													<span class="hidden-xs hidden-sm"> 검색</span> -->
								<!-- 												</button> -->
								<!-- 											</span> -->
								<!-- 										</div> -->
								<!-- 									</div> -->
								<!-- 								</div> -->
							</div>
							<p class="clearfix board-top">
								<span class="pull-right">
									<input type="button" class="fnJoin btn btn-sm btn-default" value="등록">
								</span>
								<strong class="list_count">Total : 82 건</strong>
							</p>
							<div class="table-responsive">
								<table class="table table-bordered">
									<colgroup>
										<col width="60" class="hidden-xs hidden-sm">
										<col width="180">
										<col width="50" class="">
										<col width="50">
										<col width="50" class="">
										<col width="50">
										<col width="50" class="">
										<col width="50" class="">
										<col width="50">
										<col width="50" class="">
										<col width="50">
										<col width="50" class="">
										<col width="50">
										<col width="50" class="">
										<col width="50">
									</colgroup>

									<thead>
										<tr role="row">
											<th class="" rowspan="2">순번</th>
											<th class="" rowspan="2">기간</th>
											<th class="" colspan="3">전국 유가 평균</th>
											<th class="" colspan="3">유종별 연비</th>
											<th class="" colspan="3">Km당 가격</th>
											<th class="" rowspan="2">감가상각</th>
											<th class="" colspan="3">최종Km당 가격(적용값)</th>
										</tr>
										<tr role="row">
											<th class="">무연</th>
											<th class="">경유</th>
											<th class="">LPG</th>
											<th class="">무연</th>
											<th class="">경유</th>
											<th class="">LPG</th>
											<th class="">무연</th>
											<th class="">경유</th>
											<th class="">LPG</th>
											<th class="">무연</th>
											<th class="">경유</th>
											<th class="">LPG</th>
										</tr>
									</thead>
									<tbody>
										<tr class="gradeA odd" role="row">
											<td class="">1</td>
											<td class="text-center">
												<a href="javascript:fnView();">2024.07.01~2025.12.31</a>
											</td>
											<td class="">1670</td>
											<td class="text-center">1480</td>
											<td class="text-center">1000</td>
											<td class="text-center">13.0</td>
											<td class="text-center">14.0</td>
											<td class="text-center">9.0</td>
											<td class="text-center">128.46</td>
											<td class="text-center">105.71</td>
											<td class="text-center">111.11</td>
											<td class="">40</td>
											<td class="text-center">170.00</td>
											<td class="text-center">150.00</td>
											<td class="text-center">160.00</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="text-center">
								<ul class="pagination pagination-sm">
									<li class="active">
										<a href="#">1</a>
									</li>
									<li>
										<a href="#" onclick="goPage(&quot;2&quot;);">2</a>
									</li>
									<li>
										<a href="#" onclick="goPage(&quot;3&quot;);">3</a>
									</li>
									<li>
										<a href="#" onclick="goPage(&quot;4&quot;);">4</a>
									</li>
									<li>
										<a href="#" onclick="goPage(&quot;5&quot;);">5</a>
									</li>
									<li>
										<a href="#" onclick="goPage(&quot;6&quot;);">6</a>
									</li>
									<li>
										<a href="#" onclick="goPage(&quot;7&quot;);">7</a>
									</li>
									<li>
										<a href="#" onclick="goPage(&quot;8&quot;);">8</a>
									</li>
									<li>
										<a href="#" onclick="goPage(&quot;9&quot;);">9</a>
									</li>
									<li>
										<a href="#" onclick="goPage(&quot;9&quot;);" class="glyphicon glyphicon-forward paging"></a>
									</li>
								</ul>
							</div>
							<div class="clearfix">
								<span class="form-inline pull-right">
									<input type="button" class="fnJoin btn btn-sm btn-default" value="등록">
								</span>
							</div>

						</div>
					</form>
				</div>
				<!-- aside(공지사항) -->
				<aside>
					<div class="col-lg-2 visible-lg">
						<div class="panel panel-brown">
							<div class="panel-heading text-center">
								<strong class="sky">관리자4<br>(admin04)님<br>환영합니다.
								</strong>
							</div>
						</div>
					</div>
					<div class="col-lg-2 visible-lg">
						<div class="panel panel-brown">
							<div class="panel-heading">연차정보</div>
							<div class="panel-body">
								<div class="vct_box">
									<ul id="vct_info">

										<li>
											<a href="/letech/vct/vctInf00List.do?menu_id1=MN0031&amp;menu_id2=MN0033" class="text-center">
												<strong class="sky" id="vctDayCnt">사용일 : 0 <br>부여일 : 0
												</strong>
											</a>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>

					<div class="col-lg-2 visible-lg">
						<div class="panel panel-brown">
							<div class="panel-heading">공지사항</div>
							<div class="panel-body">
								<div class="notic_box">
									<ul id="noties_type">

										<li>
											<a href="#" onclick="goBbsPage('147')">
												<strong class="sky">[공지]2022년 02월 직원명부 배포</strong><br>
												<span>2022-02-15 02:52:35</span>
											</a>
										</li>
										<li>
											<a href="#" onclick="goBbsPage('145')">
												<strong class="sky">[공지]인트라넷 수정사항 배포</strong><br>
												<span>2022-02-11 04:20:53</span>
											</a>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<form id="aside_frm1" name="aside_frm1" method="post" action="/letech/bbs/bbs00View.do">
						<input type="hidden" id="aside_menu_id1" name="menu_id1" value="MN0019">
						<input type="hidden" id="aside_menu_id2" name="menu_id2" value="MN0020">
						<input type="hidden" id="aside_bbs_id" name="bbs_id" value="BB0001">
						<input type="hidden" id="aside_bbs_seq" name="bbs_seq" value="">
					</form>

				</aside>

				<script type="text/javascript" src="/letech/resources/js/jquery-1.9.1.min.js"></script>
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
			let popupWidth = 700
			let popupHeight = 800

			// 만들 팝업창 width 크기의 1/2 만큼 보정값으로 빼주었음
			let popupX = (window.screen.width / 2) - (popupWidth / 2);
			// 만들 팝업창 height 크기의 1/2 만큼 보정값으로 빼주었음
			let popupY= (window.screen.height / 2) - (popupHeight / 2);
			
			let option = 'top='+popupX+', left='+popupY+', width='+popupWidth+', height='+popupHeight+', status=no, scrollbars=no,menubar=no, toolbar=no, resizable=no'
			window.open("${pageContext.request.contextPath}/flco/flco00Form.do", '유류비 기준 정보 등록', option);
		});
		
		/* 검색 */
		$(".fnSearch").click(function() {
			goPage("1");
		});
		
		/* 상세조회 */
		function fnView(fl_seq) {
			let popupWidth = 700
			let popupHeight = 800

			// 만들 팝업창 width 크기의 1/2 만큼 보정값으로 빼주었음
			let popupX = (window.screen.width / 2) - (popupWidth / 2);
			// 만들 팝업창 height 크기의 1/2 만큼 보정값으로 빼주었음
			let popupY= (window.screen.height / 2) - (popupHeight / 2);
			
			let option = 'top='+popupX+', left='+popupY+', width='+popupWidth+', height='+popupHeight+', status=no, scrollbars=no,menubar=no, toolbar=no, resizable=no'
			window.open("${pageContext.request.contextPath}/flco/flco00View.do", '유류비 기준 정보 상세', option);
			
			
// 			$("#bbs_seq").val(bbs_seq);
// 			$("#frm1").attr("action","${pageContext.request.contextPath}/bbs/bbs00View.do");
// 			$("#frm1").submit();
		}

		function goPage(cPage) {
			$("#cPage").val(cPage);
			$("#frm1").attr("action","${pageContext.request.contextPath}/bbs/bbs00List.do");
			$("#frm1").submit();
		}

		/*********************************************************************************
		 * function명   : fnTabMove
		 * function기능 : 탭이동
		 **********************************************************************************/
		function fnTabMove(href, pm1) {
			$("#bbs_id").val(pm1);
			$("#searchGubun").val("");
			$("#searchField").val("");
			$("#frm1").attr("action","${pageContext.request.contextPath}/" + href);
			$("#frm1").submit();
		}

		/*sub_menu 탭*/
		$(function() {
			$("article.sub_contents:not("
					+$("ul.tab_gnb li a.sub_nav_on").attr("href")
						+")").hide()
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