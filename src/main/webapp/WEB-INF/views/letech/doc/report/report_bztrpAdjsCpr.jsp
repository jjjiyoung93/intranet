<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>

<h1>출 장 정 산 서(국내)</h1>
<table class="table table-bordered" style="border: 2px solid black;">
	<tbody>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">부서명/직위</td>
			<td colspan="3" class="td-comm td-s3" id="emp_dp_rank"></td>
			<td colspan="2" class="td-comm td-s2 td-header">성명</td>
			<td colspan="3" class="td-comm td-s3" id="emp_nm"></td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">출장구분</td>
			<td colspan="8" class="td-comm td-s8">법인</td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">출장목적</td>
			<td colspan="8" class="td-comm td-s8" id="bztrp_purp"></td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">출장기간</td>
			<td colspan="8" class="td-comm td-s8" id="term"></td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">출장자</td>
			<td colspan="3" class="td-comm td-s3" id="bztrp_per"></td>
			<td colspan="2" class="td-comm td-s2 td-header">장소</td>
			<td colspan="3" class="td-comm td-s3" id="bztrp_plc"></td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">출발지역</td>
			<td colspan="3" class="td-comm td-s3" id="dpar_area"></td>
			<td colspan="2" class="td-comm td-s2 td-header">도착지역</td>
			<td colspan="3" class="td-comm td-s3" id="aryl_area"></td>
		</tr>
	</tbody>
</table>
<table class="table table-bordered" style="border: 2px solid black;">
	<tbody>
		<tr>
			<td colspan="1" class="td-comm td-s1 td-header">항목</td>
			<td colspan="5" class="td-comm td-s5 td-header">내역</td>
			<td colspan="2" class="td-comm td-s2 td-header">금액</td>
			<td colspan="2" class="td-comm td-s2 td-header">비고</td>
		</tr>
		<tr id="tr_sum">
			<td colspan="6" class="td-comm td-s6 td-header">합계</td>
			<td colspan="4" class="td-comm td-s4 text-right" id="bztrp_item_sum"></td>
		</tr>
	</tbody>
</table>
<div id="fileList"></div>
<div id="footer" class="text-center">
	<br>
	<h4>위와 같은 사유로 정산을 신청합니다.</h4>
	<br>
	<h4 id="crtn_dt"></h4>
</div>

<script>
// 출장 항목
function fn_addBztrpItem(data) {
	for(key in data) {
		var html = "";
		html += '<tr>';
		html += '	<td colspan="1" class="td-comm td-s1 text-center">' + data[key].BZTRP_ITEM_DIV_NM + '</td>';
		html += '	<td colspan="5" class="td-comm td-s5">' + data[key].BZTRP_ITEM_CTNT + '</td>';
		html += '	<td colspan="2" class="td-comm td-s2 text-right">' + addCommas(data[key].BZTRP_ITEM_AMT) + '원</td>';
		html += '	<td colspan="2" class="td-comm td-s2 text-center">' + (data[key].BZTRP_ITEM_RMRK == null ? "" : data[key].BZTRP_ITEM_RMRK) + '</td>';
		html += '</tr>';
		$("#tr_sum").before(html);
	};
}
//3자리 단위마다 콤마 생성
function addCommas(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
$(function() {
	// 금액 부분 콤마, 원 추가
	$("#bztrp_item_sum").text(addCommas($("#bztrp_item_sum").text()) + "원");
});
</script>