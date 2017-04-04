<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Letech Intranet</title>
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.print.css' rel='stylesheet' media='print' />
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
				<!-- 타이틀 및 페이지 네비 -->
				<article>
					<h2 class="sub_title">
						${bbsNm }
						<span class="page_navi full-right">HOME > 게시판 > <strong>${bbsNm }</strong></span>
					</h2>
					
				</article>
				<br/>
				<!-- page -->
				<article>
	
				<form name="frm1" id="frm1" method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/bbs/bbs00List.do" >
					<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}" />
					<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}" />
					<input type="hidden" name="bbs_id" id="bbs_id" value="${params.bbs_id }" />
					<input type="hidden" name="bbs_seq" id="bbs_seq" value="${params.bbs_seq }" />
					<input type="hidden" id="mode" name="mode" value="${params.mode }" />
					<input type="hidden" id="p_seq" name="p_seq" value="" />
				
				<table width="100%" cellpadding="0" cellspacing="0" class="table_info">
					<colgroup>
						<col width="10%" />
						<col width="*" />
						<col width="10%" />
						<col width="25%" />
						<col width="10%" />
						<col width="10%" />
					</colgroup>
			     	<tbody>
			            <tr>
				          	<th>제목</th>
				          	<td colspan="5">
								${resultView.TITLE }
				            </td>
			            </tr>
			            <tr>
				          	<th>등록자</th>
				          	<td>
				          		${resultView.REG_NM }
				            </td>
				          	<th>등록일</th>
				          	<td>
				          		${resultView.REG_DT }
				            </td>
				          	<th>조회수</th>
				          	<td>
				          		${resultView.HIT }
				            </td>
			            </tr>
			            <tr>
				          	<th>내용</th>
				          	<td colspan="5">
				          		${resultView.CONTENT }
				            </td>
			            </tr>
			            <tr>
				          	<th>첨부파일</th>
				          	<td colspan="5">
								<c:forEach var="file" items="${fileList }" varStatus="status">
									<div id="file_${file.FILE_NO }">
										<a href="#" onclick="fn_downFile('${file.FILE_PATH}', '${file.FILE_STRE_NM }', '${file.FILE_NM }')">${file.FILE_NM }</a>
									</div>
								</c:forEach>
				            </td>
			            </tr>
<c:if test="${bbsInfo.SEC_YN eq 'Y' }">
			            <tr>
				          	<th>비밀글 여부</th>
				          	<td colspan="5">
				          		<c:choose>
				          			<c:when test="${resultView.SEC_YN eq 'Y' }">
				          				Y
				          			</c:when>
				          			<c:otherwise>
				          				N
				          			</c:otherwise>
				          		</c:choose>
				            </td>
			            </tr>
</c:if>
			      	</tbody>
			    </table>
			    
			    
			    <!-- 
			    <table width="100%" cellpadding="0" cellspacing="0" class="table_info">
					<colgroup>
						<col width="80%" />
						<col width="10%" />
						<col width="10%" />
					</colgroup>
			     	<tbody>
						<c:forEach var="list" items="${repList}" varStatus="status">
							
							<tr>
								<td style="text-align:left">
								
								<font> ${list.REG_ID}
								
								</font>
									<br>
								<c:forEach begin="1" end="${list.LEVEL_CNT }" step="1">
									&nbsp;&nbsp;
								</c:forEach>
									${list.REPLY}
								</td>
								<td>
									${list.REG_DT}
									<br>
								</td>
								<td>
							<c:if test="${list.REG_ID eq loginVO.id }">
								    <input  class="btn btn_info" type="button" value="수정" />
								    <input  class="btn btn_info" type="button" value="삭제" />
							</c:if>
								    <input  class="btn btn_info" type="button" value="답글" onclick="javascript:fnReReply('${list.REP_SEQ}');"/>
							    </td>
							</tr>
						</c:forEach>
			            
			            <tr>
				          	<th>댓글등록</th>
				          	<td>
								<textarea rows="3" cols="50" id="reply" name="reply"></textarea>
				            </td>
				            <td>
								<input class="btn btn_info" type="button" value="등록" onclick="javascript:fnRepReg();"/>
				            </td>
			            </tr>
			      	</tbody>
			    </table>
			     -->
			    
			    
			    
			    <ul class="re">
			   		<c:forEach var="list" items="${repList}" varStatus="status">
			   		<input type="hidden" id="re_org_${list.REP_SEQ}" value="${list.REPLY}" />
			    	<li class="reply rp_view">
				    	<dl>
				    		<dt>
				    			<strong>
				    			<c:forEach begin="1" end="${list.LEVEL_CNT }" step="1">
				    			<span class="re_re"></span>
				    			</c:forEach>
				    			${list.REG_ID}
				    			</strong>
				    			<span class="re_dt">${list.REG_DT}</span>
				    			<span class="full-right">
				    				<c:if test="${list.REG_ID eq loginVO.id }">
									   <a href="javascript:fnModEditOpen('${list.REP_SEQ}');">수정</a>
									   <a href="javascript:fnReRepReg(3,'${list.REP_SEQ}');">삭제</a>
									</c:if>
									<a href="javascript:fnEditOpen('${list.REP_SEQ}');" >답글</a>
				    			</span>
				    		</dt>
				    		<dd id="re_con_${list.REP_SEQ}">
				    			<c:forEach begin="1" end="${list.LEVEL_CNT }" step="1">
				    			&nbsp;
				    			&nbsp;
				    			</c:forEach>
				    		${list.REPLY}
				    		</dd>
				    	</dl>
				    	<div class="row" id="re_${list.REP_SEQ }" style="display: none;">
					     	<label class="col_md_1 re_re_label">답글쓰기</label>
					     	<div class="col_md_10 pdd_ten" >
					     		<textarea rows="3" cols="50" id="reply_${list.REP_SEQ}" name="reply_${list.REP_SEQ}"></textarea>
					     	</div>
			    			<span class="">
			    				<input class="btn btn_default col_md_1" type="button" value="등록" onclick="javascript:fnReRepReg(1,'${list.REP_SEQ}');"/>
			    			</span>
		    			</div>
				    </li>
				    </c:forEach>
				    <!-- 댓글의 댓글 쓰기 시작 -->
				    <li class="reply">
				    </li>
				    <!-- 댓글의 댓글 쓰기 시작 -->
				    <li class="reply rp_write row">
				     	<label class="col_md_1">댓글쓰기</label>
				     	<div class="col_md_10 pdd_ten" >
				     		<textarea rows="3" cols="50" id="reply" name="reply"></textarea>
				     	</div>
		    			<span class="">
		    				<input class="btn btn_default col_md_1" type="button" value="등록" onclick="javascript:fnRepReg();"/>
		    			</span>
				    </li>
			    </ul>
			  
				</form>
				
				<div class="full-right">
<c:if test="${bbsInfo.REP_YN eq 'Y' }">
					<input  class="btn-rep btn btn_info" type="button" value="답변" />
</c:if>
<c:if test="${resultView.REG_ID eq loginVO.id }">
				    <input  class="btn-upd btn btn_info" type="button" value="수정" />
				    <input  class="btn-del btn btn_info" type="button" value="삭제" />
</c:if>
				    <input class="btn-list btn btn_default"  type="button" value="목록" />
				</div>
				</article>
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

<script type="text/javascript">

$(document).ready(function() {
	/* 수정 */	
	$( ".btn-upd" ).click(function() {
		$("#mode").val("<%=VarConsts.MODE_U%>");
		$("#frm1").attr("action", "${pageContext.request.contextPath}/bbs/bbs00Form.do");
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
//						alert(request.responseText);
				} 
			});
		}
	})
	
	$(".btn-rep").click(function(){
		$("#p_seq").val($("#bbs_seq").val());
		$("#mode").val("<%=VarConsts.MODE_R%>");
		$("#frm1").attr("action", "${pageContext.request.contextPath}/bbs/bbs00Form.do");
		$("#frm1").submit();
	})
});

/* 목록이동 */
function goList(){
	$("#frm1").attr("action", "${pageContext.request.contextPath}/bbs/bbs00List.do");
	$("#frm1").submit();
}
/* 상세조회 */
function fnView(){
	$("#frm1").attr("action", "${pageContext.request.contextPath}/bbs/bbs00View.do");
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
		params = { mode : '<%=VarConsts.MODE_D%>' , rep_seq : rep_seq };
	}
	
	if(confirm(conMsg)){			
		$.ajax({
			url: "${pageContext.request.contextPath}/bbs/bbs00Tran01.do",
			type: "post",
			dataType : "json", 
			data : params,
			success: function(result){
				alert(reMsg+" 되었습니다.");
				//location.reload(true);
				fnView();
			},error: function (request, status, error) {
				alert(reMsg+"에 실패 했습니다.");
				//location.reload(true);
				fnView();
//					alert(request.responseText);
			} 
		});
	}
}

function fnModEditOpen(rep_seq){
	$("#re_con_"+rep_seq).text('');
	
	var modTxt = "<textarea rows='3' cols='30' id='re_mod_"+rep_seq+"' name='re_mod_"+rep_seq+"'>"+$("#re_org_"+rep_seq).val()+"</textarea>"
				+ "<input class='btn btn_default col_md_1' type='button' value='수정' onclick='javascript:fnReRepReg(2,"
				+rep_seq+");'/>";
	$("#re_con_"+rep_seq).append(modTxt);
}

function fnEditOpen(rep_seq){
	$("#re_"+rep_seq).css('display','');
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

</script>
</body>
</html>