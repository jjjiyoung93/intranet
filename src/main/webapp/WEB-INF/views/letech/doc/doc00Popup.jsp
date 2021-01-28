<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
<jsp:include page="/resources/com/inc/meta.jsp" />
<title>Letech Intranet</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<link href="<%=request.getContextPath()%>/resources/css/bootstrap.min.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/resources/js/bootstrap.min.js"></script>
<jsp:include page="/resources/com/inc/javascript.jsp" />

<style>
.page-head {
	height: 50px;
}
@media screen { /* 화면에만 보여줄 것 */
	.page-footer {
		display: none;
	}
}
@media print { /* 인쇄할 때만 보여줄 것 */
	body {
		margin: 0;
	}
	button {
		display: none !important;
	}
	.page-footer {
		position: fixed;
		bottom: 0;
		right: 0;
		margin-right: -1cm;
	}
	.page-footer > img {
		width: 50%;
		height: 50%;
	}
	body .page .td-header {
		background-color: #ececec !important;
		-webkit-print-color-adjust: exact; 
	}
}
body {
	-webkit-print-color-adjust: exact !important;
	margin-top: 10mm;
	margin-left: 10mm;
	margin-right: 10mm;
	margin-bottom: 0mm;
	font-size: 12px;
}
h1 {
	text-align: center;
	margin: 0px 0px 130px 0px;
}
.aprv-line {
	border: 2px solid black;
	width: auto;
	position: absolute;
	top: 3.8cm;
	right: 1cm;
}
.aprv-line > tbody > tr > td {
	border: 1px solid black;
	text-align: center;
	vertical-align: middle;
}
.aprv-line > tbody > tr:last-child > td {
	width: 70px;
	height: 50px;
	color: red;
	padding: 0;
}
.table-bordered > tbody > tr > td {
	border: 1px solid black !important;
}
h4 {
	margin-bottom: 0px;
}
.td-comm {vertical-align: middle !important; height: 35px; white-space: break-spaces;}
.td-header {vertical-align: middle !important; text-align: center; background-color: #ececec !important;}
.td-ss1 {width: 0.5cm;}
.td-ss2 {width: 1.0cm;}
.td-s1 {width: 1.7cm;}
.td-s2 {width: 3.4cm;}
.td-s3 {width: 5.1cm;}
.td-s4 {width: 6.8cm;}
.td-s5 {width: 8.5cm;}
.td-s6 {width: 10.2cm;}
.td-s7 {width: 11.9cm;}
.td-s8 {width: 13.6cm;}
.td-s9 {width: 15.3cm;}
.td-s10 {width: 17cm;}
</style>
</head>
<body class="pop">
	<div class="page-head text-right">
		<button type="button" class="btn btn-default" onClick="window.print();">
			<span class="glyphicon glyphicon-print" aria-hidden="true"></span> 인쇄
		</button>
	</div>
	<div class="page-footer ">
		<img src="${pageContext.request.contextPath}/resources/images/layout/login-logo.png">
	</div>
	
	<div class="page" style="line-height: 2;">
		<table class="table table-bordered aprv-line">
			<tbody>
				<tr>
					<td rowspan="2" class="td-ss1 td-header">결<br><br>재</td>
					<td colspan="2" class="td-ss2 td-header">담당</td>
					<c:forEach var="line" items="${lineList }" varStatus="status">
						<c:if test="${line.REFE_YN == 'N' }">
							<td colspan="2" class="td-ss2 td-header">${line.APRV_AUTH_NM }<br>(${line.USS_NM })</td>
						</c:if>
					</c:forEach>
				</tr>
				<tr>
					<td colspan="2" class="td-ss2">
						<img src="${pageContext.request.contextPath}/doc/sign.do?emp_no=${viewMap.REPT_APRV_NO }" style="width: 70px; max-height: 35px;">
					</td>
					<c:forEach var="line" items="${lineList }" varStatus="status">
						<c:if test="${line.REFE_YN == 'N' }">
							<td colspan="2" class="td-ss2">
								<c:if test="${line.APRV_YN_CD eq '1' }">
									<img src="${pageContext.request.contextPath}/doc/sign.do?emp_no=${line.APRV_EMP_NO }" style="width: 70px; max-height: 35px;">
								</c:if>
							</td>
						</c:if>
					</c:forEach>
				</tr>
			</tbody>
		</table>
		<div id="docReport">
			${docReport }
		</div>
	</div>
</body>
<!-- 파일 다운로드 form Start -->
<form id="downFrm" name="downFrm" method="post" action="${pageContext.request.contextPath}/cmm/FileDown.do">
   <input type="hidden" name="file_path" id="file_path" value="" /><!-- 파일위치 -->
   <input type="hidden" name="file_stre_nm" id="file_stre_nm" value="" /><!-- 저장된파일명 -->
   <input type="hidden" name="file_nm" id="file_nm" value="" /><!-- 원문파일명 -->
</form>
<!-- 파일 다운로드 form End -->

<script type="text/javascript">
	$(function() {
		var docJson = ${docJson };	 // 컨트롤러에서 받아온 문서에 대한 json
		var viewJson = ${viewJson }; // 컨트롤러에서 받아온 결재에 대한 json
		var fileJson = ${fileJson }; // 컨트롤러에서 받아온 첨부파일에 대한 json
		
		document.title = viewJson.TITLE; // 창 제목
		
		$("#emp_dp_rank").text(viewJson.REPT_DP_NM + " / " + viewJson.REPT_AUTH_NM);
		$("#emp_nm").text(viewJson.REPT_APRV_NM);
		var crtn_dt = viewJson.CRTN_DT.split("-");
		$("#crtn_dt").text(crtn_dt[0] + "년 " + crtn_dt[1] + "월 " + crtn_dt[2] + "일");
		if($("#term").size() == "1" && docJson != null) {
			var term = "";
			if(viewJson.hasOwnProperty('TERM_ST_HM') && viewJson.hasOwnProperty('TERM_ED_YM')) {
				term = viewJson.TERM_ST_YM + " " + viewJson.TERM_ST_HM.slice(0, 2) + ":" + viewJson.TERM_ST_HM.slice(2, 4) + " ~ " + viewJson.TERM_ED_YM + " " + viewJson.TERM_ED_HM.slice(0, 2) + ":" + viewJson.TERM_ED_HM.slice(2, 4);
			} else {
				term = viewJson.TERM_ST_YM + " ~ " + viewJson.TERM_ED_YM;
			}
			$("#term").text(term);
			if(docJson.hasOwnProperty('BZTRP_NIGHT') && docJson.hasOwnProperty('BZTRP_DAYS')) {
				$("#term").text(term + " (" + docJson.BZTRP_NIGHT + "박 " + docJson.BZTRP_DAYS + "일)");
			}
		}
		for(key in docJson) {
			if(key != "items") { // 항목인지 확인
				$("#" + key.toLowerCase()).text(docJson[key]);
			} else {
				if(viewJson.APRV_TYPE_CD == "CD0001009" && viewJson.APRV_TYPE_DTIL_CD == "CD0001009001") {
					fn_addBztrpItem(docJson[key]);
				}
			}
		}
		
		if(fileJson != "") {
			var cnt = 0;
			var html = '<span style="margin-left: 40px;">첨부파일 : </span>';
			for(key in fileJson) {
				if(cnt++ != 0) {
					html += '<span style="margin-left: 98px;"></span>';
				}
				html += '<a href="#" onclick="fn_downFile(\'' + fileJson[key].FILE_PATH + '\', \'' + fileJson[key].FILE_STRE_NM + '\', \'' + fileJson[key].FILE_NM + '\')">'; 
				html += '	<span class="glyphicon glyphicon-save"></span><span> ' + fileJson[key].FILE_NM + '</span>';
				html += '</a><br>';
			}
			$("#fileList").append(html);
		}
	});
	
	// 출장 항목
	function fn_addBztrpItem(data) {
		for(key in data) {
			var html = "";
			html += '<tr>';
			html += '	<td colspan="1" class="td-comm td-s1 text-center">' + data[key].BZTRP_ITEM_DIV + '</td>';
			html += '	<td colspan="5" class="td-comm td-s5">' + data[key].BZTRP_ITEM_CTNT + '</td>';
			html += '	<td colspan="2" class="td-comm td-s2 text-right">' + data[key].BZTRP_ITEM_AMT + '</td>';
			html += '	<td colspan="2" class="td-comm td-s2 text-center">' + (data[key].BZTRP_ITEM_RMRK == null ? "" : data[key].BZTRP_ITEM_RMRK) + '</td>';
			html += '</tr>';
			$("#tr_items").after(html);
		};
	}
	
	/* 파일 다운로드 */
	function fn_downFile(file_path, file_stre_nm, file_nm){
		$("#file_path").val(file_path);
		$("#file_stre_nm").val(file_stre_nm);
		$("#file_nm").val(file_nm);
		$("#downFrm").submit();
	}

</script>
</html>