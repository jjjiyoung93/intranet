<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>

<h1>국 내 출 장 정 산 서(일반,법인)</h1>
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
			<td colspan="8" class="td-comm td-s8">일반</td>
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
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">자차여부</td>
			<td colspan="3" class="td-comm td-s3" id="selfcar_yn">없음</td>
			<td colspan="2" class="td-comm td-s2 td-header">동행자</td>
			<td colspan="3" class="td-comm td-s3" id="companion">없음</td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header">비고</td>
			<td colspan="8" class="td-comm td-s8" id="bztrp_rmrk"></td>
		</tr>
	</tbody>
</table>
<!--  일반 사용내역 START -->
<table class="table table-bordered" style="border: 2px solid black;">
	<tbody>
		<tr>
			<td colspan="7" class="td-comm td-header" style="text-align: center;">일반 사용내역</td>
		</tr>
		<tr>
			<td colspan="1" class="td-comm td-s1 td-header">항목</td>
			<td colspan="1" class="td-comm td-s1 td-header">구분</td>
			<td colspan="1" class="td-comm td-s1 td-header">출발지</td>
			<td colspan="1" class="td-comm td-s1 td-header">도착지</td>
			<td colspan="1" class="td-comm td-s1 td-header">거리</td>
			<td colspan="1" class="td-comm td-s2 td-header">금액</td>
			<td colspan="1" class="td-comm td-s2 td-header">비고</td>
		</tr>
		<tr>
			<td>유류비</td>
			<td>무연</td>
			<td>대전</td>
			<td>서울</td>
			<td>140 km</td>
			<td>30,000</td>
			<td></td>
		</tr>
		<tr id="tr_sum">
			<td colspan="4" class="td-comm td-s6 td-header">합계</td>
			<td class="td-comm td-s4 text-right" id="bztrp_distance_sum"></td>
			<td colspan="2" class="td-comm td-s4 text-right" id="bztrp_item_sum"></td>
		</tr>
	</tbody>
</table>
<p>* 유가평균(원) : 무연-1670, 경유-1480, LPG-1000 / 연비(Km/ℓ) :무연-13, 경유-14, LPG-9 X 감가상각(30%): 1.3 (0000.00.00부터 6개월간 적용)</p>
<!-- 일반 사용내역 END -->
<br>
<!--  법인카드 사용내역 START -->
<table class="table table-bordered" style="border: 2px solid black;">
	<tbody>
		<tr>
			<td colspan="10" class="td-comm td-header" style="text-align: center;">법인카드 사용내역</td>
		</tr>
		<tr>
			<td colspan="1" class="td-comm td-s1 td-header">항목</td>
			<td colspan="5" class="td-comm td-s5 td-header">내역</td>
			<td colspan="2" class="td-comm td-s2 td-header">금액</td>
			<td colspan="2" class="td-comm td-s2 td-header">비고</td>
		</tr>
		<tr>
			<td>유류비</td>
			<td colspan="5">유류비</td>
			<td colspan="2">30,000</td>
			<td colspan="2"></td>
		</tr>
		<tr id="tr_sum">
			<td colspan="6" class="td-comm td-s6 td-header">합계</td>
			<td colspan="4" class="td-comm td-s4 text-right" id="bztrp_item_sum"></td>
		</tr>
	</tbody>
</table>
<!-- 법인카드 사용내역 END -->
<table class="table table-bordered" style="border: 2px solid black;">
	<tbody>
		<tr>
			<td rowspan="2" colspan="2" class="td-comm td-s2 td-header">정산</td>
			<td colspan="2" class="td-comm td-s2 td-header">전도금</td>
			<td colspan="2" class="td-comm td-s2 td-header">기업카드사용금액</td>
			<td colspan="4" class="td-comm td-s4 td-header">지급액(차액)</td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 text-right" id="plnd_amt"></td>
			<td colspan="2" class="td-comm td-s2 text-right" id="corp_crd_use_amt"></td>
			<td colspan="4" class="td-comm td-s4 text-right" id="provd_amt"></td>
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
		for (key in data) {
			var html = "";
			html += '<tr>';
			var bztrpCtnt;
			html += '	<td colspan="1" class="td-comm td-s1 text-center">'
					+ data[key].BZTRP_ITEM_DIV_NM + '</td>';
			if (data[key].BZTRP_ITEM_DIV == "CD0011001") {
				bztrpCtnt = data[key].BZTRP_ITEM_ST_PLC_NM + " → "
						+ data[key].BZTRP_ITEM_ED_PLC_NM
			} else {
				bztrpCtnt = data[key].BZTRP_ITEM_CTNT
			}
			html += '	<td colspan="5" class="td-comm td-s5">' + bztrpCtnt
					+ '</td>';
			html += '	<td colspan="2" class="td-comm td-s2 text-right">'
					+ addCommas(data[key].BZTRP_ITEM_AMT) + '원</td>';
			html += '	<td colspan="2" class="td-comm td-s2 text-center">'
					+ (data[key].BZTRP_ITEM_RMRK == null ? ""
							: data[key].BZTRP_ITEM_RMRK) + '</td>';
			html += '</tr>';
			$("#tr_sum").before(html);
		}
		;
	}
	//3자리 단위마다 콤마 생성
	function addCommas(x) {
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	$(function() {
		// 금액 부분 콤마, 원 추가
		$("#bztrp_item_sum").text(addCommas($("#bztrp_item_sum").text()) + "원");
		$("#plnd_amt").text(addCommas($("#plnd_amt").text()) + "원");
		$("#corp_crd_use_amt").text(
				addCommas($("#corp_crd_use_amt").text()) + "원");
		$("#provd_amt").text(addCommas($("#provd_amt").text()) + "원");
	});
</script>