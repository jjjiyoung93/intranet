<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>

<h1>품 의 서</h1>
<table class="table table-bordered" style="border: 2px solid black;">
	<tbody>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">부서명/직위</td>
			<td colspan="3" class="td-comm td-s3" id="emp_dp_rank"></td>
			<td colspan="2" class="td-comm td-s2 td-header">성명</td>
			<td colspan="3" class="td-comm td-s3" id="emp_nm"></td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">품의구분</td>
			<td colspan="8" class="td-comm td-s8" id="pttn_div"></td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">품의내용</td>
			<td colspan="8" class="td-comm td-s8" style="height: 500px;" id="pttn_cont"></td>
		</tr>
	</tbody>
</table>
<div id="fileList"></div>
<div id="footer" class="text-center">
	<br>
	<h4>위와 같은 사유로 품의를 신청합니다.</h4>
	<br>
	<h4 id="crtn_dt"></h4>
</div>