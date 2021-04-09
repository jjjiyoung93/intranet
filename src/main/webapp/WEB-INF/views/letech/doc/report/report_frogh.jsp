<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>

<h1>휴 가 신 청 서</h1>
<table class="table table-bordered" style="border: 2px solid black;">
	<tbody>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">부서명/직위</td>
			<td colspan="3" class="td-comm td-s3" id="emp_dp_rank"></td>
			<td colspan="2" class="td-comm td-s2 td-header">성명</td>
			<td colspan="3" class="td-comm td-s3" id="emp_nm"></td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">기간</td>
			<td colspan="8" class="td-comm td-s8" id="term"></td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">사유</td>
			<td colspan="8" class="td-comm td-s8" id="frogh_rsn"></td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">행선지</td>
			<td colspan="8" class="td-comm td-s8" id="addr"></td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">연락처</td>
			<td colspan="8" class="td-comm td-s8" id="cttplc"></td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">휴가구분</td>
			<td colspan="8" class="td-comm td-s8" id="frogh_div"></td>
		</tr>
	</tbody>
</table>
<div id="fileList"></div>
<div id="footer" class="text-center">
	<br>
	<h4>위와 같은 사유로 휴가를 신청합니다.</h4>
	<br>
	<h4 id="crtn_dt"></h4>
</div>