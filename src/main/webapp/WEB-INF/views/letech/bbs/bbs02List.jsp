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

<!--
 2022.03.22 김민석
 팝업 등록시 공지사항 출력 화면 
-->
<body style="background: white;">
	<!-- 전체 감싸는 id -->
	<div class="container">
		<!-- 컨텐츠-->
		<section class="row">

			<!-- 내용부분(작업할 부분 클래스 col-lg-10안에 넣음 됨) -->
			<div class="col-lg-10">
				<!-- page -->
				<form name="frm1" id="frm1" method="post" action="${pageContext.request.contextPath}/bbs/bbs00List.do">
					<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}" />
					<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}" />
					<input type="hidden" name="bbs_id" id="bbs_id" value="${params.bbs_id }" />
					<input type="hidden" name="bbs_seq" id="bbs_seq" value="" />
					<input type="hidden" name="cPage" id="cPage" value="${cPage }" />
					<!--<input type="hidden" name="bbs_nm" id="bbs_nm" value="" />-->

					<!-- 타이틀 및 페이지 네비 -->
					<h2 class="page-title clearfix">
						${params.bbs_nm}
						<span class="pull-right site-map"> HOME > ${titleNaviMap.MN_NM } > ${params.bbs_nm} </span>
					</h2>

					<div class="form-container">
						<div class="table-responsive">
							<table class="table table-bordered reactive">
								<!-- 
									22.03.21 김민석 서식자료실 작성자 미출력 추가 
								-->
								<colgroup>
									<col width="50" class="" />
									<col width="*" />
									<col width="80" class="" />
									<col width="110" />
								</colgroup>
								<thead>
									<tr role="row">
										<th class="">번호</th>
										<th class="">제목</th>
										<th class="">작성자</th>
										<th class="">작성일</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${totalCnt < 1 }">
											<tr>
												<td class="text-center" colspan="5">검색된 내용이 없습니다.</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach var="list" items="${resultList}" varStatus="status">
												<tr id="${list.BBS_SEQ}" class="gradeA odd" role="row">
													<td class="text-center ">${totalCnt - status.index - ((cPage-1) * (intListCnt))}</td>
													<td class="">
														<c:forEach begin="1" end="${list.LEVEL_CNT }" step="1">
															<span class="re_re"></span>
														</c:forEach>
														<a class="" href="#" onclick="fnSelect('${list.BBS_SEQ}');">
															<span class="ellip ellip-line">${list.TITLE}</span>
														</a>
													</td>
													<!-- 
														22.03.21 김민석 서식자료실 작성자 미출력 추가 
													-->
													<td class="text-center ">${list.REG_NM}</td>
													<td class="text-center">${list.REG_DT}</td>
												</tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>
						<div class="text-center">
							<br>
							<ul class="pagination pagination-sm">${pageNavigator}
							</ul>
							<div style="float: right;" class="text-right">
								<input type="button" class="btn btn_info btn-sm" value="닫기" onclick="self.close();">
							</div>
						</div>

					</div>
				</form>

			</div>
		</section>
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

		/* 검색 */
		$(".fnSearch").click(function() {
			//alert("엔터");
			goPage("1");
		});

		function goPage(cPage) {
			//alert('엔터');
			$("#cPage").val(cPage);
			$("#frm1").attr("action",
					"${pageContext.request.contextPath}/bbs/bbs01List.do");
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
			$("#frm1").attr("action",
					"${pageContext.request.contextPath}/" + href);
			$("#frm1").submit();
		}

		/*sub_menu 탭*/
		$(function() {
			//alert("엔터");
			$(
					"article.sub_contents:not("
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

		function fnSelect(BBS_SEQ) {
			let tds = $('tr#' + BBS_SEQ).find('td');
			opener.document.getElementById('noticeTitle').value = tds[1].innerText;
			opener.document.getElementById('noticeSeq').value = BBS_SEQ
			self.close();
		}
	</script>
</body>
</html>