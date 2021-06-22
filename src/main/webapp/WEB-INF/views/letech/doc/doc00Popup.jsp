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
@media screen { /* 화면에만 보여줄 것, 화면 출력시만 적용되는 css */
	.page-footer {
		display: none;
	}
}
@media print { /* 인쇄할 때만 보여줄 것, 인쇄시만 적용되는 css */
	
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
	.no-print-page { /*인쇄 제외 페이지*/
		display: none;
	}

	body .page .td-header-tmppay {
		vertical-align: middle !important; 
		text-align: center; 
		background-color: #ececec !important;
		-webkit-print-color-adjust: exact; 
	}
	body .page .theader-tmppay{
		border: 1px solid black !important;
		-webkit-print-color-adjust: exact !important;
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
.td-header {vertical-align: middle !important; text-align: left; background-color: #ececec !important;}
.td-header-tmppay {vertical-align: middle !important; text-align: center; background-color: #ececec !important;}
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

.reciptInfoHeader {width : 100px;}
.recipt{text-align: right; padding-right: 10px;}

#previewImg{
	width: 400px;
	height: 400px;
	z-index: 999;
}
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
		<div id="docReport"></div>
	</div>
</body>
<!-- 파일 다운로드 form Start -->
<form id="downFrm" name="downFrm" method="post" action="${pageContext.request.contextPath}/cmm/FileDown.do">
   <input type="hidden" name="file_path" id="file_path" value="" /><!-- 파일위치 -->
   <input type="hidden" name="file_stre_nm" id="file_stre_nm" value="" /><!-- 저장된파일명 -->
   <input type="hidden" name="file_nm" id="file_nm" value="" /><!-- 원문파일명 -->
</form>
<!-- 파일 다운로드 form End -->

<!-- 이미지 미리보기  -->
<!-- <div id="previewImg" style="border: 1px solid black;"> -->
<!-- 	<img id="preview" src="" alt="" width="100%" height="100%"/> -->
<!-- </div> -->


<script type="text/javascript">
$(function() {
	var docJson = ${docJson };	 // 컨트롤러에서 받아온 문서에 대한 json
	viewJson = ${viewJson }; // 컨트롤러에서 받아온 결재에 대한 json
	var fileJson = ${fileJson }; // 컨트롤러에서 받아온 첨부파일에 대한 json
	
	recList = ${recList};
	recFileList = ${recFileList};
	projList = ${projList};
	
	$.ajax({
		url: "${pageContext.request.contextPath}/doc/doc01Ajax.do?APRV_TYPE_CD="+viewJson.APRV_TYPE_CD+"&APRV_TYPE_DTIL_CD="+viewJson.APRV_TYPE_DTIL_CD,
		type: "get",
		async: false,
		success: function(data) {
			//문서가 지출 결의서일 경우
			if("CD0001007" == viewJson.APRV_TYPE_CD){
				//지출 결의서 제목 세팅(카드 정보에 따른 제목)
				var mainTitle = $(data).find("#mainTitle");
				$("#docReport").append(mainTitle);
				var cardType = $(mainTitle[0]).find("#cardType");
				//카드 종류
				if(recList[0].CARD_TYPE == '1'){
					cardType.text('법인');
				} else if(recList[0].CARD_TYPE == '2'){
					cardType.text('일반');
				} else if(recList[0].CARD_TYPE == '3'){
					cardType.text('송금');		
				}
				
				//지출결의서 공통 정보 세팅
				var commData = $(data).find(".recCommData");
				fn_renderRecComm(commData);
				$("#docReport").append(commData);

				//지출결의서 영수증 정보 세팅
				for(var i = 0; i < recList.length; i++){
					var recView = $(data).find(".recView")[0];
					$(recView).attr("id", "recView"+i);
					$(recView).attr("data-idx", i);
					fn_renderRecView(recView);
					$("#docReport").append(recView)
				}
				//로케일 정보에 맞게 금액 정보 포맷 수정
				fn_amtFormat($("#docReport"), 'ko-KR');
			} else if ("CD0001010" == viewJson.APRV_TYPE_CD) {
				$("#docReport").append(data);
				fn_drawRptDetail(docJson, viewJson);
			} else{
				//지출결의서 외 나머지 문서
				$("#docReport").append(data);
			}
			
		}
	});

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

	//문서정보의 키값을 추출 후 루프 돌면서 엘리먼트에 값을 세팅
	for(key in docJson) {
		if(key != "items") { // 항목인지 확인
			$("#" + key.toLowerCase()).text(docJson[key]);
		} else {
			if(viewJson.APRV_TYPE_CD == "CD0001009" && (viewJson.APRV_TYPE_DTIL_CD == "CD0001009001" || viewJson.APRV_TYPE_DTIL_CD == "CD0001009002")) {
				fn_addBztrpItem(docJson[key]);
			}
		}
	}
	
	//지출결의서 외 문서 첨부파일(서버 저장된 문서 다운로드)
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
	
	//지출결의서의 경우 문서 파일 참조 링크 세팅(bizPlay 서버 저장, url로 참조만 함)
	if(recFileList != "") {
		console.log(recFileList);
		var cnt = 0;
		var html = '';
		for(key in recFileList) {
			if(cnt++ != 0) {
				html += '';
			}
			html += '<a href="'+ recFileList[key].ORG_IMG_URL+'" onclick="fn_receiptPopup(this, event)">'
			html += '	<span class="glyphicon glyphicon-save"></span><span class="imgName"> ' +recFileList[key].IMG_NM+'</span>';
			html += '	<img class="preview" src="'+recFileList[key].ORG_IMG_URL+'" alt="'+recFileList[key].IMG_NM+'" width="400px" height="400px" hidden />';
			html += '</a><br>'; 
		}
		$("#fileList").append(html);
	}
	//가지급금 보고서의 경우 금액 요소에 화폐단위(원) 추가
	var amtCompoList = $(".amt-compo");
	for(var m=0; m < amtCompoList.length; m++){
		var amtCompo = amtCompoList[m];
		$(amtCompo).append("원");
	}
});

/* 파일 다운로드 */
function fn_downFile(file_path, file_stre_nm, file_nm){
	$("#file_path").val(file_path);
	$("#file_stre_nm").val(file_stre_nm);
	$("#file_nm").val(file_nm);
	$("#downFrm").submit();
}


/* 지출결의서 공통 데이터 화면 출력 */
function fn_renderRecComm(commData){
	var recCommData = $(commData);
	//var cardType = recCommData.find("#cardType");
	var docNo = recCommData.find("#docNo");
	var reptAprvEmp = recCommData.find("#reptAprvEmp");
	var draftDate = recCommData.find("#draftDate");
	var title = recCommData.find("#title");
	var reptCont = recCommData.find("#reptCont");
	var recListSize = recCommData.find("#recListSize");
	var sumAmt = recCommData.find("#sumAmt");
	
	//카드 종류
// 	if(recList[0].CARD_TYPE == '1'){
// 		cardType.text('법인');
// 	} else if(recList[0].CARD_TYPE == '2'){
// 		cardType.text('일반');
// 	} else if(recList[0].CARD_TYPE == '3'){
// 		cardType.text('송금');		
// 	}

	//문서번호
	docNo.text("문서번호 : "+recList[0].DOC_NO);

	//발의자
	var reptAprvEmpHtml = viewJson.REPT_APRV_NM +"/"+ viewJson.DPNM + " ( ";
	for(var i=0; i < projList.length; i++){
		if(projList[i].CD == viewJson.PROJ_CD){
			reptAprvEmpHtml += projList[i].CD_NM + " )";
		}
	}
	reptAprvEmp.text(reptAprvEmpHtml);

	//발의일자
	draftDate.text(recList[0].DRAFT_DATE_FORMAT);

	//제목
	title.text(viewJson.TITLE);

	//내용
	reptCont.text(viewJson.REPT_CONT);

	//건수
	recListSize.text(recList.length);

	//지불 총액
	var sum = 0;
	for(var j=0; j<recList.length; j++){
		sum += recList[j].APR_AMT;
	}
	var sumHtml = sum;
	sumAmt.text(sumHtml);
	
}



/* 지출 결의서 영수증 화면 출력 */
function fn_renderRecView(recSrc) {
	var recView = $(recSrc);
	var idx = $(recView).data("idx");
	var rec = recList[idx];
	var apvDt = recView.find(".apvDt");
	var apvTm = recView.find(".apvTm");
	var mestType = recView.find(".mestType");
	var mestNm = recView.find(".mestNm");
	var buyInfo = recView.find(".buyInfo");
	var buySum = recView.find(".buySum");
	var cardInfo = recView.find(".cardInfo");
	var reciptApvDt = recView.find(".reciptApvDt");
	var reciptApvTm = recView.find(".reciptApvTm");
	var apvNo = recView.find(".apvNo");
	var splyAmt = recView.find(".splyAmt");
	var vatAmt = recView.find(".vatAmt");
	var srvFee = recView.find(".srvFee");
	var mest = recView.find(".mest");
	var cardTpbzNm = recView.find(".cardTpbzNm");
	var mestAddr = recView.find(".mestAddr");
	var mestBizNo = recView.find(".mestBizNo");
	var tranKindNm = recView.find(".tranKindNm");
	var summary = recView.find(".summary");
	var summary2 = recView.find(".summary2");
	var aprAmt = recView.find(".aprAmt");
	var bizUnitNm = recView.find(".bizUnitNm");
	var summary3 = recView.find(".summary3");

	//승인일자
	apvDt.text(rec.APV_DT_FORMAT);
	console.log("tm : " + rec.APV_TM_FORMAT);
	//승인시간
	apvTm.text(rec.APV_TM_FORMAT);

	//가맹점 종류
	var mestTypeInfo = rec.MEST_TAXT_TYP_INFO;
	console.log(mestTypeInfo);
	if('00' == mestTypeInfo){
		mestType.text('미등록');
	} else if('01' == mestTypeInfo){
		mestType.text("일반");
	} else if('02' == mestTypeInfo){
		mestType.text("간이");
	} else if('03' == mestTypeInfo){
		mestType.text("면세");
	} else if('04' == mestTypeInfo){
		mestType.text("비영리");
	} else if('09' == mestTypeInfo){
		mestType.text("휴업");
	} else if('10' == mestTypeInfo){
		mestType.text("폐업");
	} else if('99' == mestTypeInfo){
		mestType.text("해외");
	}
	
	//가맹점이름
	mestNm.text(rec.MEST_NM);

	//지출정보
	var buyInfoText = rec.BANK_NM + rec.CARD_NO_MASKING +" ( "+ rec.R_USER_NM + " )";
	buyInfo.text(buyInfoText);

	//합계
	buySum.text(rec.BUY_SUM);

	//카드정보
	var cardInfoText = rec.BANK_NM + rec.CARD_NO_MASKING;
	cardInfo.text(cardInfoText);

	//카드 거래일시
	reciptApvDt.text(rec.APV_DT_FORMAT);
	reciptApvTm.text(rec.APV_TM_FORMAT);

	//승인번호
	apvNo.text(rec.APV_NO);
	//공급금액
	splyAmt.text(rec.SPLY_AMT);
	//부가세
	vatAmt.text(rec.VAT_AMT);
	//봉사료
	srvFee.text(rec.SRV_FEE);
	//가맹점/대표자
	var mestHtml = rec.MEST_NM;
	
	if(rec.MEST_REPR_NM != null ){
		mestHtml += '&nbsp;' + rec.MEST_REPR_NM;
	}
	
	mest.html(mestHtml);
	//가맹점업종
	cardTpbzNm.text(rec.CARD_TPBZ_NM);
	//가맹점주소
	mestAddr.text(rec.MEST_ADDR_1);
	//사업자등록번호
	mestBizNo.text(rec.MEST_BIZ_NO);
	//구분
	tranKindNm.text(rec.TRAN_KIND_NM);
	//분류
	summary.text(rec.SUMMARY);
	//상세내용
	summary2.text(rec.SUMMARY_2);
	//신청금액
	aprAmt.text(rec.APR_AMT);
	//프로젝트
	bizUnitNm.text(rec.BIZ_UNIT_NM);
	//계좌정보
	if('2' == rec.CARD_TYPE){
		recView.find(".summary3-tr").css("display:block;");
		summary3.text(rec.SUMMARY_3);
	}
		
}

//적용할 곳과 로케일 정보를 지정하여 금액 정보를 포맷 설정 
function fn_amtFormat(source, locale){

	 var target	= source.find(".amt");

   for(var i=0; i<target.length; i++){
	 var value = parseInt($(target[i]).text());
	 var formatValue = value.toLocaleString(locale) + "원";
 	 $(target[i]).text(formatValue); 
	}
	
}
//지출결의서에서 첨부파일 클릭시 영수증 팝업창으로 출력
function fn_receiptPopup(source, event){
	event.preventDefault();
	var url = source.href;
	window.open(url, '영수증');
}

//3자리 단위마다 콤마 생성
function addCommas(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
// 모든 콤마, 원 제거
function removeCommas(x) {
	if(!x || x.length == 0) return "";
	else return x.split(",").join("").split("원").join("").split("권").join("");
}

//지출결의서에서 첨부파일 마우스 오버시 미리보기 출력 마우스 아웃시 숨김
// function fn_previewImg(source, event){
// 	var div
// 	var img
// 	var src
// 	var alt
// 	var imgName

	
// 	console.log($(source));

	
// 	console.log($(source).position().top);
	

// 	var img = $(source).find(".preview")[0];
// 	$(img).offset({top:200, left:200});
// 	var type = event.type;
	
    

    
// 	if(type == 'mouseout'){
// 		$(img).hide();
// 		console.log("==mouseout==");
// 		console.log("top : "+$(source).offset().top);
// 		console.log("left : "+$(source).offset().left);
// 	} else if(type == 'mouseover'){
// 		console.log("==mouseover==");
// 		console.log("top : "+$(source).offset().top);
// 		console.log("left : "+$(source).offset().left);
// 		$(img).show();
// 	}
// }
</script>
</html>