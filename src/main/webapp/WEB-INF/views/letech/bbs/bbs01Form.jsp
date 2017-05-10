<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
	<jsp:include page="/resources/com/inc/meta.jsp" />
	<title>Letech Intranet</title>
	<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.css' rel='stylesheet' />
	<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.print.css' rel='stylesheet' media='print' />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
	<link href="${pageContext.request.contextPath}/resources/js/css/ui-lightness/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" >
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
					<h4 class="page-title clearfix">
						${bbsNm }
					<span class="pull-right site-map">
						HOME > 게시판 > <strong>${bbsNm }</strong>
						</span>
					</h4>
					<br/>
				
					<div class="form-container">
						<form name="frm1" id="frm1" method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/bbs/bbs00List.do" >
							<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}" />
							<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}" />
							<input type="hidden" name="bbs_id" id="bbs_id" value="${params.bbs_id }" />
							<input type="hidden" id="mode" name="mode" value="${params.mode }" />
							<input type="hidden" id="p_seq" name="p_seq" value="${params.p_seq }" />
							<input type="hidden" name="bbs_seq" id="bbs_seq" value="${resultView.BBS_SEQ }" />
				
							<ul class="form-write">
								<li>
									<dl class="clearfix form-group form-horizontal">
										<dt class="col-md-2 col-sm-3 control-label">제목</dt>
										<dd class="col-md-10 col-sm-9">
											<input class="form-control" name="title" id="title" type="text" value="${resultView.TITLE }"  />
										</dd>
									</dl>
								</li>
								<li>
									<dl class="clearfix form-group form-horizontal">
										<dt class="col-md-2 col-sm-3 control-label">내용</dt>
										<dd class="col-md-10 col-sm-9">
											<textarea class="form-control" name="content" id="content" rows="10" cols="99" style="width:90%; height:312px;"></textarea>
										</dd>
									</dl>
								</li>
								<li>
									<dl class="clearfix form-horizontal">
										<dt class="col-md-2 col-sm-3 control-label">첨부파일</dt>
										<dd class="col-md-10 col-sm-9">
											<div  class="form-horizontal">
												<ul class="file-list">
													<c:forEach var="file" items="${fileList }" varStatus="status">
														<li class="file-form" id="file_${file.FILE_SEQ }">
															<a href="#" onclick="fn_downFile('${file.FILE_PATH}', '${file.FILE_STRE_NM }', '${file.FILE_NM }')">${file.FILE_NM }</a> 
															<span class="file-btn">
																<button class="btn btn-xs btn-danger" onclick="fn_delFile('${file.FILE_PATH}', '${file.FILE_STRE_NM }', '${file.FILE_SEQ }')" >
																	<i class="glyphicon glyphicon-remove"></i>
																</button>
															</span>
														</li>
													</c:forEach>
													<li>
														<ul id="my-file" class="form-inline">
															<li id="div_file file-form" class="file-form">
																<input class="input-group" name="file" id="file1" type="file" value="" />
																<span class="btn btn-xs btn-success file-btn" id="button-add-file">
																	<i class="glyphicon glyphicon-plus"></i>
																</span>
															</li>
														</ul>
													</li>
												</ul>
											</div>
										</dd>
									</dl>
				
									<c:set var="modeVal" value="<%=VarConsts.MODE_R%>" />
									<c:if test="${params.mode ne modeVal }">
										<c:if test="${bbsInfo.SEC_YN eq 'Y' }">
											<dl class="row">
												<dt class="col-md-2 col-xs-2">비밀글 여부</dt>
												<dd class="col-md-10 col-xs-10">
													<select  class=" col_md_3" id="sec_yn" name="sec_yn">
														<option value="Y" <c:if test="${resultView.SEC_YN eq 'Y'}" >selected="selected"</c:if> >Y</option>
														<option value="N" <c:if test="${empty resultView.SEC_YN || resultView.SEC_YN eq 'N'}" >selected="selected"</c:if> >N</option>
													</select>
												</dd>
											</dl>
										</c:if>
									</c:if>
								</li>
							</ul>
						</form>
					</div>
					<div class="clearfix">
						<span class="pull-right">
						    <input  class="btn-ok btn btn_info btn btn-warning" type="button" value="저장" />
					    	<input class="btn-cancel btn btn_default"  type="button" value="취소" />
						</span>
					</div>
				</div>
				<!-- aside(공지사항) -->
				<jsp:include page="/resources/com/inc/aside.jsp" />
			</section>
		</div>
		<jsp:include page="/resources/com/inc/footer.jsp" />
	</div>

	<form id="ussFrm" name="ussFrm" method="post" action="${pageContext.request.contextPath}/uss/umt/uss00Popup.do" >
	</form>
	<!-- 파일 다운로드 form Start -->
	<form id="downFrm" name="downFrm" method="post" action="${pageContext.request.contextPath}/cmm/FileDown.do">
		<input type="hidden" name="file_path" id="file_path" value="" /><!-- 파일위치 -->
		<input type="hidden" name="file_stre_nm" id="file_stre_nm" value="" /><!-- 저장된파일명 -->
		<input type="hidden" name="file_nm" id="file_nm" value="" /><!-- 원문파일명 -->
	</form>
	<!-- 파일 다운로드 form End -->
	
	<!-- js파일 및 공통스크립트사용 -->
	<jsp:include page="/resources/com/inc/javascript.jsp" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/se2/js/HuskyEZCreator.js" charset="utf-8"></script>
	
	<script type="text/javascript">
		var file_count = 1;
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
					$("#frm1").submit();
					
				}else if($("#mode").val() == "<%=VarConsts.MODE_R%>"){
					var p_seq = $("#p_seq").val();
					$("#bbs_seq").val(p_seq);
					$("#frm1").attr("action", "${pageContext.request.contextPath}/bbs/bbs00View.do");
					$("#frm1").submit();
				}else{
					/* 입력 폼일경우 목록화면으로 이동 */
					$("#frm1").attr("action", "${pageContext.request.contextPath}/bbs/bbs00List.do");
					$("#frm1").submit();	
				}
			});
			
			/* 첨부파일 추가 삭제 기능 */
			var count = 1;
			$('#button-add-file').click(function(){
				var html = "<li id='file_"+count+"'>";
				html += "<input class='input-group' type='file' name='file"+count+"' id='file"+count+"' />";
				html += "<span class='button-delete-file btn btn-danger btn-xs file-btn'><i class='glyphicon glyphicon-remove'></i></span></li>";
				count++;
				file_count = count;
				$("#my-file").append(html);
			});
			$(document).on('click', '.button-delete-file', function(event) {
				$(this).parent().remove();
			});
		});
		
		/* 파일 삭제 */
		function fn_delFile(file_path, file_stre_nm, file_seq){
			if(confirm("해당 파일을 삭제하시겠습니까?")){			
				$.ajax({
					url: "${pageContext.request.contextPath}/bbs/bbs02Tran.do",
					type: "post",
					dataType : "json", 
					data : {"file_path":file_path, "file_stre_nm":file_stre_nm, "file_seq":file_seq},
					success: function(result){
						$("#file_"+file_seq).remove();
						alert("삭제되었습니다.");
					},error: function (request, status, error) {
						alert("삭제에 실패 했습니다.");
		//					alert(request.responseText);
					} 
				});
			}
		}
		
		function getValidation(){
			oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
			if($("#title").val() == ""){
				alert("제목을 입력해 주세요.");
				$("#title").focus();
				return false;
			}
			
			if($("#content").val() == ""){
				alert("내용을 선택해 주세요.");
				$("#contents").focus();
				return false;
			}
			
			var fileCnt = 0;
			for(var i=0; i<file_count; i++){
				if($("#file"+i).val() == undefined){
				}else{
					if( $("#file"+i).val() != "" ){
						var ext = $("#file"+i).val().split('.').pop().toLowerCase();
						if($.inArray(ext, ['gif','png','jpg','jpeg']) == -1) {
							alert('gif,png,jpg,jpeg 파일만 업로드 할수 있습니다.');
							return false;
						}
						fileCnt++;
					}
				}
			}
			if($("#mode").val() != "<%=VarConsts.MODE_U%>"){
				if(fileCnt < 1){
					alert("이미지를 등록해 주세요");
					return false;
				}
			}
			return true;
		}
		
		/* 파일 다운로드 */
		function fn_downFile(file_path, file_stre_nm, file_nm){
			$("#file_path").val(file_path);
			$("#file_stre_nm").val(file_stre_nm);
			$("#file_nm").val(file_nm);
			$("#downFrm").submit();
		}
		
		
		/*********************************************************************************
		* function명   : fnTabMove
		* function기능 : 탭이동
		**********************************************************************************/
		function fnTabMove(href,pm1){
			$("#bbs_id").val(pm1);
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
		
		
		/* 에디터 Start */
		var oEditors = [];
		
		//추가 글꼴 목록
		//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
		
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
			elPlaceHolder: "content",
			sSkinURI: "/letech/se2/SmartEditor2Skin.html",	
			htParams : {
				bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
				//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
				fOnBeforeUnload : function(){
					//alert("완료!");
				}
			}, //boolean
			fOnAppLoad : function(){
				//예제 코드
				oEditors.getById["content"].exec("PASTE_HTML", ["${resultView.CONTENT }"]);
			},
			fCreator: "createSEditor2"
		});
		/* 에디터 End */
	</script>
</body>
</html>