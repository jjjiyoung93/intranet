<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">

<h1>가 지 급 금 신 청 서</h1>
<table class="table table-bordered" style="border: 2px solid black;">
	<tbody>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header-tmppay">부서명/직위</td>
			<td colspan="3" class="td-comm td-s3" id="emp_dp_rank"></td>
			<td colspan="2" class="td-comm td-s2 td-header-tmppay">성명</td>
			<td colspan="3" class="td-comm td-s3" id="emp_nm"></td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header-tmppay">목적</td>
			<td colspan="8" class="td-comm td-s8" id="pay_prps_nm"></td>
		</tr>

		<tr>
			<td colspan="2" class="td-comm td-s2 td-header-tmppay">기간</td>
			<td colspan="8" class="td-comm td-s8" id="term"></td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s2 td-header-tmppay">계좌번호</td>
			<td colspan="3" class="td-comm td-s3" id="pay_acnt"></td>
			<td colspan="2" class="td-comm td-s2 td-header-tmppay">지급희망일</td>
			<td colspan="3" class="td-comm td-s3" id="pay_dt"></td>
		</tr>
<!-- 		<tr> -->
<!-- 			<td colspan="2" class="td-comm td-s2 td-header-tmppay">이전잔액</td> -->
<!-- 			<td colspan="3" class="td-comm td-s3 amt-compo" id="pay_rmk"></td> -->
<!-- 			<td colspan="2" class="td-comm td-s2 td-header-tmppay">신청금액</td> -->
<!-- 			<td colspan="3" class="td-comm td-s3 amt-compo" id="pay_amt"></td> -->
<!-- 		</tr> -->
	</tbody>
</table>
<table class="table table-bordered" style="border: 2px solid black; padding: 0;">
	<colgroup>
		<col width="8%"></col>
		<col width="65%"></col>
		<col width="15%"></col>
		<!-- <col width="10%"></col> -->	
	</colgroup>
	<thead>
		<tr>
			<th class="td-header-tmppay td-comm td-s2 theader-tmppay" style="border: 1px solid black;">구분</th>
			<th class="td-header-tmppay td-comm td-s2 theader-tmppay" style="border: 1px solid black;">상세내역</th>
			<th class="td-header-tmppay td-comm td-s2 theader-tmppay" style="border: 1px solid black;">금액</th>
			<!-- <th class="td-header-tmppay td-comm td-s2 theader-tmppay" style="border: 1px solid black;">비고</th> -->
		</tr>
	
	</thead>
	<tbody id="detail-tbody">

	</tbody>
	<tbody style="font-weight: bold; border: 1px solid black;">		
		<tr>
			<td colspan="2" class="td-comm td-s1 td-header-tmppay text-right">합계금액</td>
			<td colspan="1" class="text-right"><span id="totSum" class="amt-compo"></span></td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s1 td-header-tmppay">이전잔액</td>
			<td colspan="1" class="text-right">-<span id="pay_rmk" class="amt-compo"></span></td>
		</tr>
		<tr>
			<td colspan="2" class="td-comm td-s1 td-header-tmppay">신청금액</td>
			<td colspan="1" class="text-right"><span id="pay_amt" class="amt-compo"></span></td>
		</tr>
	</tbody>
</table>

<div id="fileList"></div>
<div id="footer" class="text-center">
	<br>
	<h4>위와 같은 사유로 가지급금을 신청합니다.</h4>
	<br>
	<h4 id="crtn_dt"></h4>
</div>
<script>
	function fn_drawRptDetail(docJson, viewJson){
		//console.log(docJson);
		//console.log(viewJson);
		var tmpPayItemList = docJson.tmpPayItemList;
		var sum = 0;
		//항목별 소계
		var trfSum = 0;
		var accomSum = 0;
		var foodSum = 0;
		var etcSum = 0;
		var prchsSum = 0; 
		//상세 내역 전체 틀잡기
		//구분 기타 이외
		for(var i=0; i < tmpPayItemList.length; i++){
			var item = tmpPayItemList[i];
			var html = "";
			var cd1 = item.CD1;
			var cd2 = item.CD2;
			var amt = item.AMT * 1;
			sum += amt;
			var cd1Nm = item.CD1_NM;
			var trList = $("#detail-tbody").find(".tr-"+cd1);
			if(trList.length == 0){
				if(cd1 != 'CD0013004'){
					html += '<tr class="tr-'+cd1+'">';
					html += '<td class="td-comm td-s1 td-header-tmppay">'+cd1Nm+'</td>';
					html += '<td class="td-comm td-s5" style="padding: 0;">';
					html += '<table class="table" style="width:100%; height: 100%; margin: 0;">';
					html += '<tbody class="tbody-cont" id="tbody-'+cd1+'">';
					html += '</tbody>';
					html += '<tfoot id="tfoot-'+cd1+'">';
					html += '<tr><td class="td-header-tmppay">소계</td></tr>';
					html += '</tfoot>';
					html += '</table>';
					html += '</td>';
					html += '<td class="td-comm td-s5" style="padding: 0;">';
					html += '<table class="table" style="width:100%; height: 100%; border:none; margin: 0;">';
					html += '<tbody id="tbody-amt-'+cd1+'">';
					//html += '<tr><td><span id="span-amt-'+cd1+'" class="span-amt amt-compo"></span></td></tr>'
					html += '</tbody>';
					html += '<tfoot id="tfoot-amt-'+cd1+'">';
					html += '<tr><td class="text-right"><span id="span-amt-sum-'+cd1+'" class="span-amt amt-compo"></span></td></tr>';
					html += '</tfoot>';
					html += '</table>';
					html += '</td>';
	// 				html += '<td class="td-comm td-s5" style="padding: 0;">';
	// 				html += '<table class="table" style="width:100%; height: 100%; border:none; margin: 0;">';
	// 				html += '<tbody id="tbody-rmk4-'+cd1+'">';
	// 				html += '</tbody>';
	// 				html += '<tfoot id="tfoot-rmk4-'+cd1+'">';
	// 				html += '<tr><td><span style="visibility: hidden;">공란</span></td></tr>';
	// 				html += '</tfoot>';
	// 				html += '</table>';
	// 				html += '</td>';
					html += '</tr>';
					
					$("#detail-tbody").append(html);			

				}
			}

		}
		
		// 기타
		for(var i=0; i < tmpPayItemList.length; i++){
			var item = tmpPayItemList[i];
			var html = "";
			var cd1 = item.CD1;
			var cd2 = item.CD2;
			var amt = item.AMT * 1;
			sum += amt;
			var cd1Nm = item.CD1_NM;
			var trList = $("#detail-tbody").find(".tr-"+cd1);
			if(trList.length == 0){
				if(cd1 == 'CD0013004'){
					html += '<tr class="tr-'+cd1+'">';
					html += '<td class="td-comm td-s1 td-header-tmppay">'+cd1Nm+'</td>';
					html += '<td class="td-comm td-s5" style="padding: 0;">';
					html += '<table class="table" style="width:100%; height: 100%; margin: 0;">';
					html += '<tbody class="tbody-cont" id="tbody-'+cd1+'">';
					html += '</tbody>';
					html += '<tfoot id="tfoot-'+cd1+'">';
					html += '<tr><td class="td-header-tmppay">소계</td></tr>';
					html += '</tfoot>';
					html += '</table>';
					html += '</td>';
					html += '<td class="td-comm td-s5" style="padding: 0;">';
					html += '<table class="table" style="width:100%; height: 100%; border:none; margin: 0;">';
					html += '<tbody id="tbody-amt-'+cd1+'">';
					//html += '<tr><td><span id="span-amt-'+cd1+'" class="span-amt amt-compo"></span></td></tr>'
					html += '</tbody>';
					html += '<tfoot id="tfoot-amt-'+cd1+'">';
					html += '<tr><td class="text-right"><span id="span-amt-sum-'+cd1+'" class="span-amt amt-compo"></span></td></tr>';
					html += '</tfoot>';
					html += '</table>';
					html += '</td>';
					html += '</tr>';
					
					$("#detail-tbody").append(html);			

				}
			}

		}
		

		//상세 내역 데이터 입력
		for(var j=0; j<tmpPayItemList.length ;j++){			
			var item = tmpPayItemList[j];
			var cd1 = item.CD1;
			var cd2 = item.CD2;
			var cd2Nm = item.CD2_NM;
			var rmk1 = item.RMK1;
			var rmk2 = item.RMK2;
			var rmk3 = item.RMK3;
			var price = item.PRICE;
			var cnt = item.CNT;
			var amt = item.AMT;
			var stDt = item.ST_DT;
			var edDt = item.ED_DT;
			var rmk4 = item.RMK4;
			var detailHtml = "";
			var amtHtml = "";
			var rmk4Html = "";

			if(cd1 == "CD0013001"){
				detailHtml += '<tr class="tr-cont">';
				detailHtml += '<td style="height: 30px;">';
				detailHtml += '<span>'+cd2Nm+' ('+stDt+' ~ '+edDt+', '+rmk1
				if(rmk3 == "1") {
					detailHtml += '<i class="fas fa-long-arrow-alt-right"></i>';
				} else if(rmk3 == "2"){
					detailHtml += '<i class="fas fa-arrows-alt-h"></i>';
				}
				detailHtml += rmk2 + ', ';
				if(rmk3 == "1") {
					detailHtml += '편도) X '+cnt+'회 X '+price+'원</span>';
				} else if(rmk3 == "2"){
					detailHtml += '왕복) X '+cnt+'회 X '+price+'원</span>';
				}

				if(rmk4 != null && rmk4 != ''){
					detailHtml += '<br> => 비고 : ' +rmk4;
				}
				detailHtml += '</td>';
									
				detailHtml += '</tr>';
				trfSum += removeCommas(amt) * 1;	
			}else if(cd1 == "CD0013002"){
				detailHtml += '<tr class="tr-cont">';
				detailHtml += '<td style="height: 30px;">';
				detailHtml += '<span>'+cd2Nm+' ('+stDt+' ~ '+edDt+') X '+cnt+'회 X '+price+'원</span>'
				if(rmk4 != null && rmk4 != ''){
					detailHtml += '<br> => 비고 : ' +rmk4;
				}
				detailHtml += '</td>';
									
				detailHtml += '</tr>';
				foodSum += removeCommas(amt) * 1;	
			}else if(cd1 == "CD0013003"){
				detailHtml += '<tr class="tr-cont">';
				detailHtml += '<td style="height: 30px;">';
				detailHtml += '<span>숙박 ('+stDt+' ~ '+edDt+') X '+cnt+'박 X '+price+'원</span>'
				if(rmk4 != null && rmk4 != ''){
					detailHtml += '<br> => 비고 : ' +rmk4;
				}
				detailHtml += '</td>';					
				detailHtml += '</tr>';
				accomSum += removeCommas(amt) * 1;	
			}else if(cd1 == "CD0013004") {
				detailHtml += '<tr class="tr-cont">';
				detailHtml += '<td style="height: 30px;">';
				detailHtml += '<span>'+cd2Nm+' ('+stDt+' ~ '+edDt+') X '+cnt+'회 X '+price+'원</span>'
				if(rmk4 != null && rmk4 != ''){
					detailHtml += '<br> => 비고 : ' +rmk4;
				}
				detailHtml += '</td>';					
				detailHtml += '</tr>';
				etcSum += removeCommas(amt) * 1;	
			}else if(cd1 == "CD0013005") {
				detailHtml += '<tr class="tr-cont">';
				detailHtml += '<td style="height: 30px;">';
				detailHtml += '<span>'+cd2Nm+' ('+rmk1+') X '+cnt+'개 X '+price+'원</span>'
				if(rmk4 != null && rmk4 != ''){
					detailHtml += '<br> => 비고 : ' +rmk4;
				}
				detailHtml += '</td>';					
				detailHtml += '</tr>';
				prchsSum += removeCommas(amt) * 1;	

			}
			
			amtHtml += '<tr>';
			amtHtml += '<td class="text-right" style="height: 30px;">';
			amtHtml += '<span class="amt-compo span-sum-'+cd1+'">'+amt+'</span>'
			if(rmk4 != null && rmk4 != ''){
				amtHtml += '<br><span style="visibility: hidden;">비고</span>'
			}
			amtHtml += '</td>';
			amtHtml += '</tr>';
			
// 			rmk4Html += '<tr>';
// 			rmk4Html += '<td>';

// 			if(rmk4 == null || rmk4 == ''){
// 				rmk4 = "없음";
// 				rmk4Html += '<span style="visibility: hidden;">'; 
// 			} else {
// 				rmk4Html += '<span>'; 
// 			}
// 			rmk4Html += rmk4;
// 			rmk4Html += '</span>';
// 			rmk4Html += '</td>';
// 			rmk4Html += '</tr>';
			
			$("#tbody-"+cd1).append(detailHtml);
// 			$("#tbody-rmk4-"+cd1).append(rmk4Html);
			$("#tbody-amt-"+cd1).append(amtHtml);
				
		}
		
		var spanAmtList = $(".span-amt");
		for(var k=0; k<spanAmtList.length; k++){
			var spanAmt = spanAmtList[k];
			var id = $(spanAmt).attr("id");
			var idSplit = id.split("-");
			var cd1 = idSplit[3];

			if(cd1 == "CD0013001"){
				$(spanAmt).text(addCommas(trfSum));
			}else if(cd1 == "CD0013002"){
				$(spanAmt).text(addCommas(foodSum));
			}else if(cd1 == "CD0013003"){
				$(spanAmt).text(addCommas(accomSum));
			}else if(cd1 == "CD0013004"){
				$(spanAmt).text(addCommas(etcSum));
			}else if("CD0013005") {
				$(spanAmt).text(addCommas(prchsSum));
			}
		}

		//금액 요약 정보
		var totSum = fn_getTotSum();
		var totSumComma = ""; 
		totSumComma =  addCommas(totSum);
		//$("#sum").text();
		$("#totSum").text(totSumComma);
		//$("#rmk").text(docJson.PAY_RMK);
		var payRmk = $("#pay_rmk").text();
		//$("#rmk").append("원");
		var payRmk = removeCommas(payRmk);
		var payAmt = 0;
		payAmt = totSum - payRmk;
		var payAmtComma = "";
		payAmtComma = addCommas(payAmt);
		//$("#amt").text(payAmtComma);
	}


	function fn_getTotSum(){
		var spanAmtList = $(".span-amt");
		var totSum = 0;
		for(var i=0; i < spanAmtList.length; i++){
			var sum = $(spanAmtList[i]).text();
			sum = removeCommas(sum) * 1;
			totSum += sum;
		}
		return totSum;
	}

</script>
