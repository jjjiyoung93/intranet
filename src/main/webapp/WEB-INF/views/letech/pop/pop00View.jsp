<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="/resources/com/inc/meta.jsp" />
<title>Letech Intranet</title>
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.print.css' rel='stylesheet' media='print' />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
<link href="${pageContext.request.contextPath}/resources/js/css/ui-lightness/jquery-ui-1.9.2.custom.min.css" rel="stylesheet">
<style type="text/css">
li.content {
	min-height: 40vh;
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
					<!-- 타이틀 및 페이지 네비 -->

					<h2 class="page-title clearfix">
						${titleNaviMap.MN_NM }
						<span class="pull-right site-map"> HOME > ${titleNaviMap.NAVI_NM } </span>
					</h2>

					<div class="form-container">
						<form name="frm1" id="frm1" method="post">
							<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}" />
							<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}" />
							<input type="hidden" name="pop_id" id="pop_id" value="${params.pop_id }" />
							<input type="hidden" name="pop_seq" id="pop_seq" value="${params.pop_seq }" />
							<input type="hidden" id="mode" name="mode" value="${params.mode }" />
							<input type="hidden" id="p_seq" name="p_seq" value="" />
							<input type="hidden" name="cPage" id="cPage" value="${params.cPage }" />
							<input type="hidden" name="searchGubun" id="searchGubun" value="${params.searchGubun}" />
							<input type="hidden" name="searchField" id="searchField" value="${params.searchField}" />

							<h4 class="board_title">${resultView.TITLE }<span class="pull-right site-map"></span>
							</h4>
							<ul class="form-view">
								<li class="clearfix">
									<label>등록자:</label>
									<span>${resultView.REG_NM }</span>
								</li>
								<li class="content">${resultView.CONTENT }</li>
								<c:if test="${not empty resultView.NOTICE_SEQ}">
									<li class="clearfix">
										<dl>
											<dt class="col-md-2 col-sm-3">게시판 불러오기</dt>
											<dd class="col-md-10 col-sm-9">${resultView.NOTICE_TITLE }</dd>
										</dl>
									</li>
								</c:if>
								<li class="clearfix">
									<dl>
										<dt class="col-md-2 col-sm-3">팝업창 크기</dt>
										<dd class="col-md-10 col-sm-9">${resultView.POPUP_WIDTH}X${resultView.POPUP_HEIGHT}</dd>
									</dl>
								</li>
								<li class="clearfix">
									<dl>
										<dt class="col-md-2 col-sm-3">팝업닫기 설정</dt>
										<dd class="col-md-10 col-sm-9">
											<c:choose>
												<c:when test="${resultView.HIDE_POPUP eq 'oneDay'}">
													하루 보지않기
												</c:when>
												<c:when test="${resultView.HIDE_POPUP eq 'allDay'}">
													다시 보지않기
												</c:when>
											</c:choose>
										</dd>
									</dl>
								</li>
							</ul>
						</form>
						<div class="clearfix row">
							<br />
							<!-- 작성자와 조회자가 같은경우 -->
							<!-- 
								<c:if test="${resultView.REG_ID eq loginVO.id}">
									<input class="btn-upd btn btn-sm btn-info" type="button" value="수정" />
									<input class="btn-del btn btn-sm btn-default" type="button" value="삭제" />
								</c:if>
 								-->
							<div class="col-sm-6 tetxt-left">
								<input class="btn-list btn btn-sm btn-default" type="button" value="목록">
							</div>
							<div class="col-sm-6 text-right">
								<input class="btn-upd btn btn-sm btn-info" type="button" value="수정" />
								<input class="btn-del btn btn-sm btn-default" type="button" value="삭제" />
							</div>
						</div>
					</div>
				</div>
				<!-- aside(공지사항) -->
				<jsp:include page="/resources/com/inc/aside.jsp" />
			</section>
		</div>
		<jsp:include page="/resources/com/inc/footer.jsp" />
	</div>

	<!-- js파일 및 공통스크립트사용 -->
	<jsp:include page="/resources/com/inc/javascript.jsp" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/se2/js/HuskyEZCreator.js" charset="utf-8"></script>
	<script type="text/javascript">
	
		$(document).ready(function() {
			/* 수정 */	
			$( ".btn-upd" ).click(function() {
				if(!$('#pop_id').val()){
					$('#mode').val("PROTO");
				}else{
					$("#mode").val("<%=VarConsts.MODE_U%>");
				}

				$("#frm1").attr("action", "${pageContext.request.contextPath}/pop/pop00Form.do");
				$("#frm1").removeAttr("enctype");
				$("#frm1").submit();
			});
			/* 목록 */
			$( ".btn-list" ).click(function() {
				goList();
			});
			
			$(".btn-del").click(function() {
				if(confirm("삭제하시겠습니까?")){			
					$.ajax({
						url: "${pageContext.request.contextPath}/bbs/bbs01Tran.do",
						type: "post",
						dataType : "json", 
						data : $("#frm1").serialize(),
						success: function(result){
							alert("삭제되었습니다.");
							goList();
						},error: function (request, status, error) {
							alert("삭제에 실패 했습니다.");
						} 
					});
				}
			})
			
			$(".btn-rep").click(function(){
				$("#p_seq").val($("#bbs_seq").val());
				$("#mode").val("<%=VarConsts.MODE_R%>");
				$("#frm1").attr("action", "${pageContext.request.contextPath}/bbs/bbs00Form.do");
				$("#frm1").removeAttr("enctype");
				$("#frm1").submit();
			})
		});
	
		/* 목록이동 */
		function goList(){
			$("#frm1").attr("action", "${pageContext.request.contextPath}/pop/pop00List.do");
			$("#frm1").removeAttr("enctype");
			$("#frm1").submit();
		}
		
		/* 상세조회 */
		function fnView(){
			$("#frm1").attr("action", "${pageContext.request.contextPath}/bbs/bbs00View.do");
			$("#frm1").removeAttr("enctype");
			$("#frm1").submit();
		}
		
	
		function fnRepReg(){
			if(confirm("등록하시겠습니까?")){			
				$("#mode").val("<%=VarConsts.MODE_I%>");
				$.ajax({
					url: "${pageContext.request.contextPath}/bbs/bbs00Tran01.do",
					type: "post",
					dataType : "json", 
					data : $("#frm1").serialize(),
					success: function(result){
						alert("등록되었습니다.");
						//location.reload(true);
						fnView();
					},error: function (request, status, error) {
						alert("등록에 실패 했습니다.");
	//					alert(request.responseText);
					} 
				});
			}
		}
	
		function fnReRepReg(flag,rep_seq){
			var conMsg = "";
			var params = "";
			var reMsg = "";
			if(flag == 1){
				conMsg = "등록하시겠습니까?";
				reMsg = "등록";
				var bbs_seq = $("#bbs_seq").val();
				var content = $("#reply_"+rep_seq).val();
				params = { mode : '<%=VarConsts.MODE_I%>' , bbs_seq :  bbs_seq , rep_p_seq : rep_seq , reply : content};
			}else if(flag == 2){
				var content = $("#re_mod_"+rep_seq).val();
				conMsg = "수정하시겠습니까?";
				reMsg = "수정";
				params = { mode : '<%=VarConsts.MODE_U%>' , rep_seq : rep_seq , reply : content};
			}else if(flag == 3){
				conMsg = "삭제하시겠습니까?";
				reMsg = "삭제";
				params = { mode : '<%=VarConsts.MODE_D%>',
						   rep_seq : rep_seq
						};
			}

			if (confirm(conMsg)) {
				$
						.ajax({
							url : "${pageContext.request.contextPath}/bbs/bbs00Tran01.do",
							type : "post",
							dataType : "json",
							data : params,
							success : function(result) {
								alert(reMsg + " 되었습니다.");
								//location.reload(true);
								fnView();
							},
							error : function(request, status, error) {
								alert(reMsg + "에 실패 했습니다.");
								//location.reload(true);
								fnView();
								//					alert(request.responseText);
							}
						});
			}
		}

		function fnModEditOpen(rep_seq) {
			$("#re_con_" + rep_seq).text('');

			var modTxt = "<textarea class='form-control' rows='3' cols='30' id='re_mod_"+rep_seq+"' name='re_mod_"+rep_seq+"'>"
					+ $("#re_org_" + rep_seq).val()
					+ "</textarea>"
					+ "<input class='btn btn_default col_md_1' type='button' value='수정' onclick='javascript:fnReRepReg(2,"
					+ rep_seq + ");'/>";
			$("#re_con_" + rep_seq).append(modTxt);
		}

		function fnEditOpen(rep_seq) {
			$("#re_" + rep_seq).css('display', '');
		}

		/* 파일 다운로드 */
		function fn_downFile(file_path, file_stre_nm, file_nm) {
			$("#file_path").val(file_path);
			$("#file_stre_nm").val(file_stre_nm);
			$("#file_nm").val(file_nm);
			$("#downFrm").submit();
		}

		/*********************************************************************************
		 * function명   : fnTabMove
		 * function기능 : 탭이동
		 **********************************************************************************/
		function fnTabMove(href, pm1) {
			$("#bbs_id").val(pm1);
			$("#frm1").attr("action",
					"${pageContext.request.contextPath}/" + href);
			$("#frm1").submit();
		}

		/*sub_menu 탭*/
		$(function() {
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