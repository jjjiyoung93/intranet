<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>

<h1>시 차 출 퇴 근 제 신 청 서</h1>
<table class="table table-bordered" style="border: 2px solid black;">
	<tbody>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">부서명/직위</td>
			<td colspan="3" class="td-comm td-s3" id="emp_dp_rank"></td>
			<td colspan="2" class="td-comm td-s2 td-header">성명</td>
			<td colspan="3" class="td-comm td-s3" id="emp_nm"></td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">주요업무</td>
			<td colspan="8" class="td-comm td-s8" id="main_busi"></td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">이용기간</td>
			<td colspan="8" class="td-comm td-s8" id="term"></td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">근무시간</td>
			<td colspan="8" class="td-comm td-s8" id="wrk_hh"></td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">신청사유</td>
			<td colspan="8" class="td-comm td-s8" id="rqst_rsn"></td>
		</tr>
	</tbody>
</table>
<div id="fileList"></div>
<div id="footer" class="text-center">
	<br>
	<h4>위와 같은 사유로 시차출퇴근제를 신청합니다.</h4>
	<br>
	<h4 id="crtn_dt"></h4>
</div>