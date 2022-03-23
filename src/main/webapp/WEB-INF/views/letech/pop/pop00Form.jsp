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
						<form name="frm1" id="frm1" method="post" accept-charset="UTF-8">
							<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}" />
							<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}" />
							<input type="hidden" id="mode" name="mode" value="${params.mode }" />
							<input type="hidden" id="p_seq" name="p_seq" value="${params.p_seq }" />

							<input type="hidden" name="cPage" id="cPage" value="${params.cPage }" />


							<ul class="form-write row">
								<li>
									<dl class="clearfix form-group form-horizontal">
										<dt class="col-md-2 col-sm-3 control-label">제목</dt>
										<dd class="col-md-10 col-sm-9">
											<input class="form-control" name="title" id="title" type="text" value="${popInfo.TITLE }" />
										</dd>
									</dl>
								</li>
								<li>
									<dl class="clearfix form-group form-horizontal">
										<dt class="col-md-2 col-sm-3 control-label">내용</dt>
										<dd class="col-md-10 col-sm-9">
											<textarea class="form-control" name="content" id="content" rows="10" cols="99" style="width: 100%; height: 312px;">${popInfo.CONTENT}</textarea>
										</dd>
									</dl>
								</li>
								<li>
									<dl class="clearfix form-group form-horizontal">
										<dt class="col-md-2 col-sm-3 control-label">게시글 호출</dt>
										<dd class="col-md-10 col-sm-9">
											<div class="form-horizontal">
												<div class="input-group">
													<input type="text" class="form-control" name="noticeTitle" id="noticeTitle" value="${popInfo.NOTICE_TITLE}">
													<span class="input-group-btn">
														<button id="btn-notice" class="fnSearch btn btn-info" type="button">
															<i class="glyphicon glyphicon-search"></i>
															<span class="hidden-xs hidden-sm"> 조회</span>
														</button>
													</span>
												</div>
												<input class="form-control" name="noticeSeq" id="noticeSeq" type="hidden" value="${popInfo.NOTICE_SEQ }">
											</div>
										</dd>
									</dl>
								</li>
								<li>
									<dl class="clearfix form-group form-horizontal">
										<dt class="col-md-2 col-sm-3 control-label">팝업창 크기</dt>
										<dd class="col-md-2 col-sm-1  text-center">
											<div class="form-horizontal">
												<input id="popupWidth" name="popupWidth" type="text" class="form-control" placeholder="가로(px)" value="${popInfo.POPUP_WIDTH}">
											</div>
										</dd>
										<dd class="col-md-1 col-sm-1 text-center">
											<p class="h4">X</p>
										</dd>
										<dd class="col-md-2 col-sm-1 text-center">
											<div class="form-horizontal">
												<input id="popupHeight" name="popupHeight" type="text" class="form-control" placeholder="세로(px)" value="${popInfo.POPUP_HEIGHT}">
											</div>
										</dd>
									</dl>
								</li>
								<li>
									<dl class="clearfix form-group form-horizontal">
										<dt class="col-md-2 col-sm-3 control-label">팝업 닫기 설정</dt>
										<dd class="col-md-4 col-sm-4">
											<div class="radio">
												<label><input type="radio" name="hidePopup" value="oneDay" id="oneDay"
														<c:if test="${popInfo.HIDE_POPUP eq 'oneDay'}">
													checked="checked"													 		
										 		</c:if>> 오늘 하루 열지않기 </label>
											</div>
										</dd>
									</dl>
								</li>
								<li>
									<dl class="clearfix form-horizontal">
										<dt class="col-md-2 col-sm-3 control-label"></dt>
										<dd class="col-md-4 col-sm-4">
											<div class="radio">
												<label><input type="radio" name="hidePopup" value="allDay" id="allDay"
														<c:if test="${popInfo.HIDE_POPUP eq 'allDay'}">
													checked="checked"													 		
										 		</c:if>> 다시 보지않기</label>
											</div>
										</dd>
									</dl>
								</li>
							</ul>
						</form>
						<div class="clearfix">
							<span class="pull-right">
								<input class="btn-ok btn btn_info btn-sm btn btn-info" type="button" value="저장" />
								<input class="btn-view btn btn_info btn-sm btn btn-info" type="button" value="미리보기" />
								<input class="btn-cancel btn btn-sm btn-default" type="button" value="취소" />
							</span>
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
		/* 저장 */	
		$( ".btn-ok" ).click(function() {
			if(getValidation()){
				if($("#mode").val() == "<%=VarConsts.MODE_U%>"){
				}else{
					$("#mode").val("<%=VarConsts.MODE_I%>");	
				}
				
				$("#frm1").attr("action", "${pageContext.request.contextPath}/bbs/bbs00Tran.do");
				$("#frm1").submit();
			}
		});
		/* 취소 */
		$( ".btn-cancel" ).click(function() {
			if($("#mode").val() == "<%=VarConsts.MODE_U%>"){
				/* 수정 폼일경우 상세화면으로 이동 */
				$("#frm1").attr("action", "${pageContext.request.contextPath}/bbs/bbs00View.do");
			}else if($("#mode").val() == "<%=VarConsts.MODE_R%>") {
				var p_seq = $("#p_seq").val();
				$("#bbs_seq").val(p_seq);
				$("#frm1").attr("action","${pageContext.request.contextPath}/bbs/bbs00View.do");
			} else {
			/* 입력 폼일경우 목록화면으로 이동 */
				$("#frm1").attr("action", "${pageContext.request.contextPath}/pop/pop00List.do");
			}
				$("#frm1").removeAttr("enctype");
				$("#frm1").submit();
			});

			/* 첨부파일 추가 삭제 기능 */
			var count = 0;
			$('#button-add-file').click(
				function() {
					var html = "<li id='file_"+count+"'>";
					html += "<input class='input-group' type='file' name='file"+count+"' id='file"+count+"' />";
					html += "<span class='button-delete-file btn btn-danger btn-xs file-btn'><i class='glyphicon glyphicon-remove'></i></span></li>";
					count++;
					$("#my-file").append(html);
				});
			$(document).on('click', '.button-delete-file',
				function(event) {
					$(this).parent().remove();
				});
		});

		function getValidation() {
			oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);

			if ($("#title").val() == "") {
				alert("제목을 입력해 주세요.");
				$("#title").focus();
				return false;
			}

			if ($("#content").val() == "") {
				alert("내용을 선택해 주세요.");
				$("#contents").focus();
				return false;
			}

			/*2022.03.16
			  서식 자료실 첨부파일 유무 확인
			 */
			let bbsId = '${bbsInfo.BBS_ID}';
			if (bbsId == 'BB0005') {
				if ($('#file0')[0].files.length === 0) {
					alert("파일을 첨부해 주세요");
					$('#file0').click();
					return false;
				}
			}

			return true;
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
			$("#frm1").attr("action", "${pageContext.request.contextPath}/" + href);
			$("#frm1").submit();
		}

		/*sub_menu 탭*/
		$(function() {
			$("article.sub_contents:not("
				+ $("ul.tab_gnb li a.sub_nav_on").attr("href")
				+ ")").hide();
			$("ul.tab_gnb li a").click(function() {
				$("ul.tab_gnb li a").removeClass("sub_nav_on");
				$(this).addClass("sub_nav_on");
				$("article.sub_contents").hide();
				$($(this).attr("href")).show();
				return false;
			});
		});

		/* 에디터 Start */
		var oEditors = [];

		//추가 글꼴 목록
		//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
		nhn.husky.EZCreator.createInIFrame({
			oAppRef : oEditors,
			elPlaceHolder : "content",
			sSkinURI : "/letech/se2/SmartEditor2Skin.html",
			htParams : {
				bUseToolbar : true, // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseVerticalResizer : true, // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseModeChanger : true, // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
				//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
				fOnBeforeUnload : function() {
					//alert("완료!");
				}
			}, //boolean
			fOnAppLoad : function() {
				//예제 코드
				oEditors.getById["content"].exec("PASTE_HTML", [ '${resultView.CONTENT }' ]);
			},
			fCreator : "createSEditor2"
		});
		/* 에디터 End */
		
		/*
			공지사항 목록 팝업창 출력
		*/
		$('#btn-notice').on('click', function(){
			fnPrntPopup('/bbs/bbs01List.do?bbs_id=BB0001&menu_id1=MN0019&menu_id2=MN0020',700, 600, '공지사항 목록');
		})
		
		/*
			미리보기 팝업창 출력
		*/
		$('.btn-view').on('click', function(){
			let width = $('#popupWidth').val();
			let height =  $('#popupHeight').val();
			
			$('input[name="mode"]').val('preview');
			
			let content = oEditors.getById['content'].getIR();
			
			$('textarea[name="content"]').text(content);
			
			fnPrntPopup('', width, height, 'previewPopup');
			
			$("#frm1").attr("target", 'previewPopup');
			$("#frm1").attr("action", "${pageContext.request.contextPath}/pop/pop00Prnt.do");
			$("#frm1").submit();
		})
		
		function fnPrntPopup(url, popupWidth, popupHeight, name){
			// 만들 팝업창 width 크기의 1/2 만큼 보정값으로 빼주었음
			let popupX = (window.screen.width / 2) - (popupWidth / 2);
			// 만들 팝업창 height 크기의 1/2 만큼 보정값으로 빼주었음
			let popupY= (window.screen.height / 2) - (popupHeight / 2);
			
			let option = 'top='+popupY+', left='+popupX+', width='+popupWidth+', height='+popupHeight+', status=no, scrollbars=no,menubar=no, toolbar=no, resizable=no'
			window.open("${pageContext.request.contextPath}"+url, name , option);
		}
	</script>
</body>
</html>