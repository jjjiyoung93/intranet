<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>

<h1>도 서 구 매 신 청 서</h1>
<table class="table table-bordered" style="border: 2px solid black;">
	<tbody>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">부서명/직위</td>
			<td colspan="3" class="td-comm td-s3" id="emp_dp_rank"></td>
			<td colspan="2" class="td-comm td-s2 td-header">성명</td>
			<td colspan="3" class="td-comm td-s3" id="emp_nm"></td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">도서명</td>
			<td colspan="8" class="td-comm td-s8" id="bks_nm"></td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">구입목적</td>
			<td colspan="8" class="td-comm td-s8" id="puch_purp"></td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">저자명</td>
			<td colspan="3" class="td-comm td-s3" id="authr_nm"></td>
			<td colspan="2" class="td-comm td-s2 td-header">출판사</td>
			<td colspan="3" class="td-comm td-s3" id="pbcm"></td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">출판일</td>
			<td colspan="3" class="td-comm td-s3" id="pblt_dd"></td>
			<td colspan="2" class="td-comm td-s2 td-header">ISBN</td>
			<td colspan="3" class="td-comm td-s3" id="isbn"></td>

		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">구입희망일</td>
			<td colspan="3" class="td-comm td-s3" id="puch_hope_dd"></td>
			<td colspan="2" class="td-comm td-s2 td-header">권당금액</td>
			<td colspan="3" class="td-comm td-s3 text-right" id="bks_amt"></td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">구입희망권수</td>
			<td colspan="3" class="td-comm td-s3 text-right" id="puch_hope_nmvl"></td>
			<td colspan="2" class="td-comm td-s2 td-header">총금액</td>
			<td colspan="3" class="td-comm td-s3 text-right" id="bks_amt_sum"></td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">비고</td>
			<td colspan="8" class="td-comm td-s8" id="rmrk"></td>
		</tr>
	</tbody>
</table>
<div id="fileList"></div>
<div id="footer" class="text-center">
	<br>
	<h4>위와 같은 사유로 도서구매를 신청합니다.</h4>
	<br>
	<h4 id="crtn_dt"></h4>
</div>
<script>
//3자리 단위마다 콤마 생성
function addCommas(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
$(function() {
	// 금액 부분 콤마, 원, 권 추가
	$("#bks_amt").text(addCommas($("#bks_amt").text()) + "원");
	$("#bks_amt_sum").text(addCommas($("#bks_amt_sum").text()) + "원");
	$("#puch_hope_nmvl").text(addCommas($("#puch_hope_nmvl").text()) + "권");
});
</script>