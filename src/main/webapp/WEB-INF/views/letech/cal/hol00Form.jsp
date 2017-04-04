<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>Letech Intranet</title>
	<!-- 달력 CSS -->
	<link href="${pageContext.request.contextPath}/resources/js/css/ui-lightness/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" >
</head>

<body>
<div id="wrap">
<section>
	<form name="frm1" id="frm1" method="post" action="${pageContext.request.contextPath}/uss/umt/list.do" >
		<input type="hidden" name="cal_hol_seq" id="cal_hol_seq" value="${param.cal_hol_seq }" />
		<input type="hidden" id="mode" name="mode" value="${param.mode }" />
		<input type="hidden" id="joinType" name="joinType" value="${joinType }" />
		
	
	<h4 id="b_tlt"><span>휴일관리</span></h4> 
 
	<table cellpadding="0" cellspacing="0" class="table_list2">
     	<tbody>
            <tr>
	          	<td>휴일명</td>
	          	<td style="text-align: left;height: 20px;">
					<input name="cal_hol_nm" id="cal_hol_nm" type="text" value="${params.CAL_HOL_NM }" style="width:300px;margin-left: 10px;" class="i_text" />
	            </td>
            </tr>
            <tr>
	          	<td>날짜</td>
	          	<td style="text-align: left;height: 20px;">
					<input name="cal_hol_dt" id="cal_hol_dt" type="text" value="${params.CAL_HOL_DT }" style="width:100px;margin-left: 10px;" class="i_text" />
	            </td>
            </tr>
      	</tbody>
    </table>
	</form>
	<br/>
	
	<div class="btn" style="text-align: right;">
	    <a href="#submit" class="btn-ok" ><span>저장</span></a>
	    <a href="#cancel" class="btn-cancel" ><span>취소</span></a>
	</div>
</section>
<footer>footer</footer>
</div>

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
	$("#cal_hol_dt").datepicker();
});

$(document).ready(function() {
	/* 저장 */	
	$( ".btn-ok" ).click(function() {
		if(getValidation()){
			if($("#mode").val() == "<%=VarConsts.MODE_U%>"){
			}else{
				$("#mode").val("<%=VarConsts.MODE_I%>");	
			}
			
			$.ajax({
				url: "${pageContext.request.contextPath}/cal/hol00Tran.do",
				type: "post",
				dataType : "json", 
				data : $("#frm1").serialize(),
				success: function(result){
					var url_val = "";
					if($("#mode").val() == "<%=VarConsts.MODE_U%>"){
						/* 수정 폼일 경우 */
						alert("휴일정보가 저장되었습니다.");
						url_val = "${pageContext.request.contextPath}/cal/hol00View.do";
					}else{
						/* 등록 폼일 경우 */
						alert("휴일정보가 등록되었습니다.");
						url_val = "${pageContext.request.contextPath}/cal/hol00List.do";	
					}
					$("#frm1").attr("action", url_val);
					$("#frm1").submit();
				},error: function (request, status, error) {
					alert(request.responseText);
				} 
			});
		}
	});
	/* 취소 */
	$( ".btn-cancel" ).click(function() {
		if($("#mode").val() == "<%=VarConsts.MODE_U%>"){
			/* 수정 폼일경우 상세화면으로 이동 */
			$("#frm1").attr("action", "${pageContext.request.contextPath}/cal/hol00View.do");
			$("#frm1").submit();
			
		}else{
			/* 입력 폼일경우 목록화면으로 이동 */
			$("#frm1").attr("action", "${pageContext.request.contextPath}/cal/hol00List.do");
			$("#frm1").submit();	
		}
	});
	
});

function getValidation(){
	
	if($("#cal_hol_nm").val() == ""){
		alert("휴일명을 입력해 주세요.");
		$("#cal_hol_nm").focus();
		return false;
	}
	
	if($("#cal_hol_dt").val() == ""){
		alert("날짜을 입력해 주세요.");
		$("#cal_hol_dt").focus();
		return false;
	}
	
	return true;
}

</script>
</body>
</html>