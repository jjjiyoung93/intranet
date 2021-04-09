<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>

<h1>교 육 훈 련 신 청 서</h1>
<table class="table table-bordered" style="border: 2px solid black;">
	<tbody>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">부서명/직위</td>
			<td colspan="3" class="td-comm td-s3" id="emp_dp_rank"></td>
			<td colspan="2" class="td-comm td-s2 td-header">성명</td>
			<td colspan="3" class="td-comm td-s3" id="emp_nm"></td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">교육명</td>
			<td colspan="8" class="td-comm td-s8" id="educ_nm"></td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header" style="height: 300px;">교육훈련목적<br>및 내용</td>
			<td colspan="8" class="td-comm td-s8" id="educ_purp_cntn"></td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">교육기간</td>
			<td colspan="8" class="td-comm td-s8" id="term"></td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">교육장소</td>
			<td colspan="3" class="td-comm td-s3" id="educ_plc"></td>
			<td colspan="2" class="td-comm td-s2 td-header">교육기관</td>
			<td colspan="3" class="td-comm td-s3" id="educ_inst"></td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">교육비</td>
			<td colspan="3" class="td-comm td-s3 text-right" id="educ_cost"></td>
			<td colspan="2" class="td-comm td-s2 td-header">지원액</td>
			<td colspan="3" class="td-comm td-s3 text-right" id="spmn"></td>
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
	<h4>위와 같은 사유로 교육훈련을 신청합니다.</h4>
	<br>
	<h4 id="crtn_dt"></h4>
</div>