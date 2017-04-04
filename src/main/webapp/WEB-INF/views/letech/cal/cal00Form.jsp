<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>Letech Intranet</title>
	<link href="${pageContext.request.contextPath}/resources/js/css/ui-lightness/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" >
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
		<form name="frm1" id="frm1" method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/uss/umt/list.do" >
			<input type="hidden" id="menu_id1" name="menu_id1" value="${param.menu_id1}"/>
			<input type="hidden" id="menu_id2" name="menu_id2" value="${param.menu_id2}"/>
			<input type="hidden" name="cal_seq" id="cal_seq" value="${params.cal_seq }" />
			<input type="hidden" id="mode" name="mode" value="${params.mode }" />
			<input type="hidden" id="view_type" name="view_type" value="${params.view_type }" />
			<input type="hidden" id="uss_id" name="uss_id" value="${loginVO.id }" />
			<input type="hidden" id="now_date" name="now_date" value="${params.now_date }" />
 			
			<h2 class="sub_title">
				${titleNaviMap.MN_NM }
				<span class="page_navi full-right">HOME > ${titleNaviMap.NAVI_NM }</span>
			</h2>
			
			<table cellpadding="0" cellspacing="0" class="table_info">
				<caption>일정관리</caption>
				<colgroup>
					<col width="20%" />
					<col width="*" />
				</colgroup>
		     	<tbody>
		      		<tr>
			          	<th>시작일자(시간)</th>
			          	<td style="text-align: left;height: 20px;">
							<input name="cal_st_dt" id="cal_st_dt" type="text" value="${resultView.CAL_ST_DT}"/>
							<select name="cal_st_time1" id="cal_st_time1">
								<option value="">--</option>
								<c:forEach var="hour" items="${hourList }" varStatus="status">
									<option value="${hour }" <c:if test="${params.cal_st_time1 eq hour }">selected="selected"</c:if> >${hour }</option>
								</c:forEach>
							</select>시
							<select name="cal_st_time2" id="cal_st_time2">
								<option value="">--</option>
<c:forEach var="minute" items="${minuteList }" varStatus="status">
								<option value="${minute }" <c:if test="${params.cal_ed_time2 eq minute }">selected="selected"</c:if> >${minute }</option>
</c:forEach>
							</select>분
						</td>
		            </tr>
		      		<tr>
			          	<th>종료일자(시간)</th>
			          	<td>
							<input name="cal_ed_dt" id="cal_ed_dt" type="text" value="${resultView.CAL_ED_DT }"  />
							<select name="cal_ed_time1" id="cal_ed_time1">
								<option value="">--</option>
<c:forEach var="hour" items="${hourList }" varStatus="status">
								<option value="${hour }" <c:if test="${params.cal_ed_time2 eq hour }">selected="selected"</c:if> >${hour }</option>
</c:forEach>
							</select>시
							<select name="cal_ed_time2" id="cal_ed_time2">
								<option value="">--</option>
<c:forEach var="minute" items="${minuteList }" varStatus="status">
								<option value="${minute }" <c:if test="${params.cal_ed_time2 eq minute }">selected="selected"</c:if> >${minute }</option>
</c:forEach>
							</select>분
						</td>
		            </tr>
		            <tr>
			          	<th>제목</th>
			          	<td>
							<input class="col_md_12" name="cal_nm" id="cal_nm" type="text" value="${resultView.CAL_NM }" maxlength="50" />
			            </td>
		            </tr>
		            <tr>
			          	<th>내용</th>
			          	<td >
			          		<textarea class="col_md_12" name="cal_content" id="cal_content" maxlength="1200">${resultView.CAL_CONTENT }</textarea>
			            </td>
		            </tr>
		            <tr>
			          	<th>첨부파일</th>
			          	<td>
<c:forEach var="file" items="${fileList }" varStatus="status">
							<div id="file_${file.FILE_SEQ }"><a href="#" onclick="fn_downFile('${file.FILE_PATH}', '${file.FILE_STRE_NM }', '${file.FILE_NM }')">${file.FILE_NM }</a> <input type="button" value="파일삭제" onclick="fn_delFile('${file.FILE_PATH}', '${file.FILE_STRE_NM }', '${file.FILE_SEQ }')" /></div>
</c:forEach>
							<div id="my-file">
								<div id="div_file"><input name="file" id="file1" type="file" value="" />
									<input class="btn btn_primary " type="button" value="추가" id="button-add-file"/></div>  
							</div>
			            </td>
		            </tr>
		      	</tbody>
		    </table>
</form>
	
			<p class="full-right" >
			    <a href="#submit" class="btn-ok btn btn_info" ><span>저장</span></a>
			    <a href="#cancel" class="btn-cancel btn btn_default" ><span>취소</span></a>
			</p>
<!-- Content Start -->

		</section>
	</div>
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
<!-- 달력 Start -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-migrate-1.2.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-ui-datepicker.min.js"></script>
<!-- 달력 End -->
<script type="text/javascript">
/* datepicker 달력 기능 한글 설정 Start */
$.datepicker.setDefaults({
	monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	changeMonth: true,	// 월 선택 활성화
	changeYear: true,	// 년도 선택 활성화
	showMonthAfterYear: true,
	monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	dateFormat: 'yy-mm-dd'
});
/* datepicker 달력 기능 한글 설정 End */

$(function() {
	$("#cal_st_dt").datepicker(
		{
			// 종료날짜 있을 경우 이전 날짜만 선택되게 함
			onClose: function( selectedDate ) {
		        $( "#cal_ed_dt" ).datepicker( "option", "minDate", selectedDate );
		    }
		}		
	);
	$("#cal_ed_dt").datepicker(
		{
			// 시작날짜 있을경우 이유 날짜만 선택하게 함
			onClose: function( selectedDate ) {
				$( "#cal_st_dt" ).datepicker( "option", "maxDate", selectedDate );
			}
		}		
	);
});


$(document).ready(function() {
	/* 저장 */	
	$( ".btn-ok" ).click(function() {
		if(getValidation()){
			if($("#mode").val() == "<%=VarConsts.MODE_U%>"){
			}else{
				$("#mode").val("<%=VarConsts.MODE_I%>");	
			}
			
 			$("#frm1").attr("action", "${pageContext.request.contextPath}/cal/cal00Tran.do");
 			$("#frm1").submit();
		}
	});
	/* 취소 */
	$( ".btn-cancel" ).click(function() {
		if($("#mode").val() == "<%=VarConsts.MODE_U%>"){
			/* 수정 폼일경우 상세화면으로 이동 */
			$("#frm1").attr("action", "${pageContext.request.contextPath}/cal/cal00View.do");
			$("#frm1").submit();
			
		}else{
			/* 입력 폼일경우 목록화면으로 이동 */
			$("#frm1").attr("action", "${pageContext.request.contextPath}/cal/cal00List.do");
			$("#frm1").submit();	
		}
	});
	
	/* 첨부파일 추가 삭제 기능 */
	var count = 0;
	$('#button-add-file').click(function(){
		var html = "<div id='file_"+count+"'>";
		html += "<input type='file' name='file"+count+"' id='file"+count+"' />";
		html += "&nbsp;<input type='button' value='삭제' class='button-delete-file'/></div>";
		count++;
		$("#my-file").append(html);
	});
	$(document).on('click', '.button-delete-file', function(event) {
		$(this).parent().remove();
	});
});

function fn_delFile(file_path, file_stre_nm, file_seq){
	if(confirm("해당 파일을 삭제하시겠습니까?")){			
		$.ajax({
			url: "${pageContext.request.contextPath}/cal/cal01Ajax.do",
			type: "post",
			dataType : "json", 
			data : {"file_path":file_path, "file_stre_nm":file_stre_nm, "file_seq":file_seq},
			success: function(result){
				
				$("#file_"+file_seq).remove();
			},error: function (request, status, error) {
				alert("삭제에 실패 했습니다.");
//					alert(request.responseText);
			} 
		});
	}
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
	}else if($("#cal_nm").val().length > 50){
		alert("50자 이상 입력 할 수 없습니다.");
		$("#cal_nm").focus();
		return false;
	}
	
	return true;
}

function fn_downFile(file_path, file_stre_nm, file_nm){
	$("#file_path").val(file_path);
	$("#file_stre_nm").val(file_stre_nm);
	$("#file_nm").val(file_nm);
	$("#downFrm").submit();
}

</script>
</body>
</html>