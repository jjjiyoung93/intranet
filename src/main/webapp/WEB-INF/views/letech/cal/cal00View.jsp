<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Letech Intranet</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">

</head>

<body>
<div id="wrap">
	<jsp:include page="/resources/com/inc/header.jsp" />
	<%@ include file="/WEB-INF/views/letech/com/layout/menu.jsp" %>
    <div class="container">
   	 	<jsp:include page="/resources/com/inc/aside.jsp" />
		<section class="contents">
<!-- Content Start -->	
<form name="frm1" id="frm1" method="post" action="${pageContext.request.contextPath}/uss/umt/list.do" >
	<input type="hidden" id="menu_id1" name="menu_id1" value="${param.menu_id1}" />
	<input type="hidden" id="menu_id2" name="menu_id2" value="${param.menu_id2}" />
	<input type="hidden" name="cal_seq" id="cal_seq" value="${params.cal_seq }" />
	<input type="hidden" id="mode" name="mode" value="${params.mode }" />
	<input type="hidden" id="view_type" name="view_type" value="${params.view_type }" />
	<input type="hidden" id="flag" name="flag" value="${params.flag }" />
	<input type="hidden" id="now_date" name="now_date" value="${params.now_date }" />
 			
			<h2 class="sub_title">
				${titleNaviMap.MN_NM }
				<span class="page_navi full-right">HOME > ${titleNaviMap.NAVI_NM }</span>
			</h2>
		 
			<table cellpadding="0" cellspacing="0" class="table_info">
				<colgroup>
					<col width="30%">
					<col width="*">
				</colgroup>
		     	<tbody>
		      		<tr>
			          	<th>시작일자(시간)</th>
			          	<td>
							${resultView.CAL_ST_DT }
							(
<c:if test="${not empty resultView.CAL_ST_TIME }">
								${resultView.CAL_ST_TIME_FRI }시 ${resultView.CAL_ST_TIME_SEC }분
</c:if>
							)
						</td>
		            </tr>
		      		<tr>
			          	<th>종료일자(시간)</th>
			          	<td>
							${resultView.CAL_ED_DT }
							(
<c:if test="${not empty resultView.CAL_ED_TIME }">
								${resultView.CAL_ED_TIME_FRI }시 ${resultView.CAL_ED_TIME_SEC }분
</c:if>
							)
						</td>
		            </tr>
		            <tr>
			          	<th>제목</th>
			          	<td>
							${resultView.CAL_NM }
			            </td>
		            </tr>
		            <tr>
			          	<th>내용</th>
			          	<td>
			          		${resultView.CAL_CONTENT }
			            </td>
		            </tr>
		            <tr>
			          	<th>첨부파일</th>
			          	<td>
<c:forEach var="file" items="${fileList }" varStatus="status">
							<p><a href="#" onclick="fn_downFile('${file.FILE_PATH}', '${file.FILE_STRE_NM }', '${file.FILE_NM }')">${file.FILE_NM }</a></p>
</c:forEach>
			            </td>
		            </tr>
		      	</tbody>
		    </table>
</form>
	
			<div class="col_md_12" >
<!-- 메인화면인이 일정관리화면인지 구분 (1:메인화면) -->
<c:if test="${params.flag ne '1' }" >
			    <a href="#submit" class="btn-ok btn btn_info" ><span>수정</span></a>
			    <a href="#submit" class="btn-del btn btn_info" ><span>삭제</span></a>
</c:if>
			    <a href="#cancel" class="btn-cancel  btn btn_default full-right" ><span>목록</span></a>
			</div>

		</section>
	</div>
	
<!-- Content Start -->

	 <jsp:include page="/resources/com/inc/footer.jsp" />
</div>

<!-- 파일 다운로드 form Start -->
<form id="downFrm" name="downFrm" method="post" action="${pageContext.request.contextPath}/cmm/FileDown.do">
	<input type="hidden" name="file_path" id="file_path" value="" /><!-- 파일위치 -->
	<input type="hidden" name="file_stre_nm" id="file_stre_nm" value="" /><!-- 저장된파일명 -->
	<input type="hidden" name="file_nm" id="file_nm" value="" /><!-- 원문파일명 -->
</form>
<!-- 파일 다운로드 form End -->


<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">


$(document).ready(function() {
	/* 수정 */	
	$( ".btn-ok" ).click(function() {
		$("#mode").val("<%=VarConsts.MODE_U%>");
		
		$("#frm1").attr("action", "${pageContext.request.contextPath}/cal/cal00Form.do");
		$("#frm1").submit();
	});
	/* 삭제 */
	$(".btn-del").click(function(){

		if(confirm("삭제하시겠습니까?")){
			$("#mode").val("<%=VarConsts.MODE_D%>");			
			$.ajax({
				url: "${pageContext.request.contextPath}/cal/cal01Tran.do",
				type: "post",
				dataType : "json", 
				data : $("#frm1").serialize(),
				success: function(result){
					alert("삭제되었습니다.");
					fnList();
				},error: function (request, status, error) {
					alert("삭제에 실패 했습니다.");
// 					alert(request.responseText);
				} 
			});
		}
	});
	
	$( ".btn-cancel" ).click(function() {
		fnList();
	});
});

function fnList(){
	var flag = $("#flag").val();
	var url = "";
	if(flag == "1"){
		// 메인화면
		url = "${pageContext.request.contextPath}/index.do"
		$("#frm1").encoding = "application/x-www-form-urlencoded";
	}else{
		// 일정관리 화면
		url = "${pageContext.request.contextPath}/cal/cal00List.do";
	}
	$("#frm1").attr("action", url);
	$("#frm1").submit();
}

function fn_downFile(file_path, file_stre_nm, file_nm){
// 	window.open("", "downFile", "");
	$("#file_path").val(file_path);
	$("#file_stre_nm").val(file_stre_nm);
	$("#file_nm").val(file_nm);
// 	$("#downFrm").attr("target", "downFile");
	$("#downFrm").submit();
}

function getValidation(){
	if($("#cal_st_dt").val() == ""){
		alert("시작날짜를 입력해 주세요.");
		$("#cal_st_dt").focus();
		return false;
	}
	if($("#cal_ed_dt").val() == ""){
		$("#cal_ed_dt").val($("#cal_st_dt").val());
	}
	
	if($("#cal_nm").val() == ""){
		alert("일정 제목을 입력해 주세요.");
		$("#cal_nm").focus();
		return false;
	}
	
	return true;
}

</script>
</body>
</html>