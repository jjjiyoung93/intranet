<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>

<!-- 기간 및 일수 START -->
<div class="col-lg-12 form-group">
	<div class="col-lg-2 col-sm-2 text-right">
		<label class="control-label">출장기간</label>
		<span class="req-sign">*</span>
	</div>
	<div class="col-lg-9">
		<div class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
			<input id="term_st" name="term_st" type="text" aria-label="Date" autocomplete="off">
			<span class="tui-ico-date"></span>
			<div id="startpicker-container" style="margin-left: -1px;"></div>
		</div>
		~
		<div class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
			<input id="term_ed" name="term_ed" type="text" aria-label="Date" autocomplete="off">
			<span class="tui-ico-date"></span>
			<div id="endpicker-container" style="margin-left: -1px;"></div>
		</div>
		<input type="text" class="form-control" name="bztrp_night" id="bztrp_night" style="width: 50px; display: inline; margin-left: 5px;">
		<span>박</span>
		<input type="text" class="form-control" name="bztrp_days" id="bztrp_days" style="width: 50px; display: inline; margin-left: 5px;">
		<span>일</span>
	</div>
</div>
<!-- 기간 및 일수 END -->

<!-- 출장목적 START -->
<div class="col-lg-12 form-group">
	<div class="col-lg-2 col-sm-2 text-right">
		<label class="control-label">출장목적</label>
		<span class="req-sign">*</span>
	</div>
	<div class="col-lg-9">
		<input type="text" class="form-control" name="bztrp_purp" id="bztrp_purp">
	</div>
</div>
<!-- 출장목적 END -->

<!-- 출장자 및 장소 START -->
<div class="col-lg-6 form-group">
	<div class="col-lg-4 col-sm-2 text-right">
		<label class="control-label">출장자</label>
		<span class="req-sign">*</span>
	</div>
	<div class="col-lg-6">
		<input type="text" class="form-control" name="bztrp_per" id="bztrp_per">
	</div>
</div>
<div class="col-lg-6 form-group">
	<div class="col-lg-4 col-sm-2 text-right">
		<label class="control-label">장소</label>
		<span class="req-sign">*</span>
	</div>
	<div class="col-lg-6">
		<input type="text" class="form-control" name="bztrp_plc" id="bztrp_plc">
	</div>
</div>
<!-- 출장자 및 장소 END -->

<!-- 출발지역 및 도착지역 START -->
<div class="col-lg-6 form-group">
	<div class="col-lg-4 col-sm-2 text-right">
		<label class="control-label">출발지역</label>
		<span class="req-sign">*</span>
	</div>
	<div class="col-lg-6">
		<input type="text" class="form-control" name="dpar_area" id="dpar_area">
	</div>
</div>
<div class="col-lg-6 form-group">
	<div class="col-lg-4 col-sm-2 text-right">
		<label class="control-label">도착지역</label>
		<span class="req-sign">*</span>
	</div>
	<div class="col-lg-6">
		<input type="text" class="form-control" name="aryl_area" id="aryl_area">
	</div>
</div>
<!-- 출발지역 및 도착지역 END -->

<!-- 자차이용여부 START -->
<div class="col-lg-6 form-group">
	<div class="col-lg-4 col-sm-2 text-right">
		<label class="control-label">자차이용여부</label>
		<span class="req-sign">*</span>
	</div>
	<div class="col-lg-6">
		<select class="form-control">
			<option>자차</option>
			<option>동행</option>
			<option>대중교통</option>
		</select>
	</div>
</div>
<div class="col-lg-6 form-group">
	<div class="col-lg-4 col-sm-2 text-right">
		<label class="control-label">동행자명</label>
		<span class="req-sign">*</span>
	</div>
	<div class="col-lg-6">
		<input type="text" class="form-control" name="aryl_area" id="aryl_area" placeholder="입력">
	</div>
</div>
<!-- 자차이용여부 END -->

<!-- 일반항목 START -->
<div class="col-lg-12 form-group">
	<div class="col-lg-10 col-lg-offset-1">
		<label class="control-label" for="grnl">일반 사용내역</label>
		<table class="table table-bordered" id="CD0026">
			<colgroup>
				<col width="15%" />
				<col width="15%" />
				<col width="12%" />
				<col width="12%" />
				<col width="10%" />
				<col width="15%" />
				<col width="10%" />
				<col width="10%" />
			</colgroup>
			<thead>
				<tr>
					<th>
						항목
						<span class="req-sign">*</span>
					</th>
					<th>
						구분
						<span class="req-sign">*</span>
					</th>
					<th colspan="3">
						출발지 및 도착지
						<span class="req-sign">*</span>
					</th>
					<th>
						거리
						<span class="req-sign">*</span>
					</th>
					<th>
						금액
						<span class="req-sign">*</span>
					</th>
					<th>비고</th>
					<th>
						<span class="btn btn-xs btn-default" onClick="fn_addBztrpItem('CD0026')">
							<i class="glyphicon glyphicon-plus-sign"></i> 추가
						</span>
					</th>
				</tr>
			</thead>
			<tbody>
				<tr class="tr_bztrp_item_sum"></tr>
				<tr class="">
					<td colspan="5" class="text-center">소계</td>
					<td colspan="">(총 km 자동산출)</td>
					<td colspan="3">(총 금액 자동산출)</td>
				</tr>
			</tbody>
		</table>
		<p>* 유가평균(원) : 무연-1670, 경유-1480, LPG-1000 / 연비(Km/ℓ) :무연-13, 경유-14, LPG-9 X 감가상각(30%): 1.3 (0000.00.00부터 6개월간 적용)
		<p>
	</div>
</div>

<!-- 법인카드 항목 START -->
<div class="col-lg-12 form-group">
	<div class="col-lg-10 col-lg-offset-1">
		<label class="control-label" for="comp">법인카드 사용내역</label>
		<table class="table table-bordered" id="CD0025">
			<colgroup>
				<col width="15%" />
				<col width="*%" />
				<col width="*%" />
				<col width="15%" />
				<col width="10%" />
				<col width="7%" />
			</colgroup>
			<thead>
				<tr>
					<th>
						항목
						<span class="req-sign">*</span>
					</th>
					<th colspan="2">
						내역
						<span class="req-sign">*</span>
					</th>
					<th>
						금액
						<span class="req-sign">*</span>
					</th>
					<th>비고</th>
					<th>
						<span class="btn btn-xs btn-default" onClick="fn_addBztrpItem('CD0025')">
							<i class="glyphicon glyphicon-plus-sign"></i> 추가
						</span>
					</th>
				</tr>
			</thead>
			<tbody>
				<tr class="tr_bztrp_item_sum"></tr>
				<tr class="">
					<td colspan="3" class="text-center">소계</td>
					<td colspan="3">(총 금액 자동산출)</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
<div class="col-lg-12 form-group">
	<div class="col-lg-10 col-lg-offset-1">
		<table class="table table-bordered">
			<tbody>
				<tr>
					<td colspan="2" class="text-center" style="border-bottom-width: 2px;">
						<label class="form-label">합계</label>
					</td>
					<td colspan="3" class="text-right" style="border-bottom-width: 2px;">
						<input type="text" class="form-control text-right" id="bztrp_item_sum" name="bztrp_item_sum" readonly>
					</td>
				</tr>
				<tr>
					<td colspan="2" class="text-center">
						<label class="form-label">전도금</label>
					</td>
					<td colspan="3" class="text-right">
						<input type="text" class="form-control text-right convNum" id="plnd_amt" name="plnd_amt">
					</td>
				</tr>
				<tr>
					<td colspan="2" class="text-center">
						<label class="form-label">기업카드사용금액</label>
					</td>
					<td colspan="3" class="text-right">
						<input type="text" class="form-control text-right convNum" id="corp_crd_use_amt" name="corp_crd_use_amt">
					</td>
				</tr>
				<tr>
					<td colspan="2" class="text-center">
						<label class="form-label">지급액(차액)</label>
					</td>
					<td colspan="3" class="text-right">
						<input type="text" class="form-control text-right" id="provd_amt" name="provd_amt" readonly>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
<!-- 항목 END -->

<!-- 비고 START -->
<div class="col-lg-12 form-group">
	<div class="col-lg-2 col-sm-2 text-right">
		<label class="control-label">비고<br> (계좌번호)
		</label>
	</div>
	<div class="col-lg-9">
		<textarea class="form-control" name="bztrp_rmrk" id="bztrp_rmrk"></textarea>
	</div>
</div>
<!-- 비고 END -->

<form id="frm1" method="post">
	<input type="hidden" value="" id="mode" name="mode">
</form>

<script>
var bztrpDivCodeList ;
var cprCodeList;
var gnrlCodeList;
var plcCodeList;
var trcsList;
var trvctInfo;

$(function() {
	// 금액이 들어가는 항목
	$("body").on("propertychange change keyup paste input", ".bztrp_item_amts, #plnd_amt, #corp_crd_use_amt", function() {
		itemSum();
	});

	// 출장 숙박 변경 시 여비값 변경
	$("body").on("propertychange change input", "#bztrp_night", function() {
		fn_calNight();
	});

	// 공통코드 불러오기(지역코드, 출장항목코드, 여비)
	$.ajax({
		type: 'get',
		url: '${pageContext.request.contextPath}/aprv/aprv05Ajax.do',
		async: false,
		data: $("#frm1").serialize(),
		success: function(data){
			cprCodeList = data.cprCodeList;
			gnrlCodeList = data.gnrlCodeList
			
			plcCodeList = data.plcCodeList;
			trcsList = data.trcsList;
			trvctInfo = data.trvctInfo[0];
			
			if($("#mode").val() != "UPDATE") {
				// 항목 1개 추가
				fn_addBztrpItem('CD0026');
				fn_addBztrpItem('CD0025');
			} 
		}
	});

	// 금액 부분 콤마, 원 추가
	$("#bztrp_item_sum").val(addCommas($("#bztrp_item_sum").val() == "" ? 0 : $("#bztrp_item_sum").val()) + "원");
	$("#plnd_amt").val(addCommas($("#plnd_amt").val() == "" ? 0 : $("#plnd_amt").val()) + "원");
	$("#corp_crd_use_amt").val(addCommas($("#corp_crd_use_amt").val() == "" ? 0 : $("#corp_crd_use_amt").val()) + "원");
	$("#provd_amt").val(addCommas($("#provd_amt").val() == "" ? 0 : $("#provd_amt").val()) + "원");
});

// 금액의 합산
function itemSum() {
	var sum = 0;
// 	$(".bztrp_item_amts").each(function(i, obj) {
// 		if($(obj).val() != "") {
// 			sum += parseInt(removeCommas($(obj).val()));
// 		}
// 	});
	
	$("#bztrp_item_sum").val(addCommas(sum) + "원");
	
	if($("#plnd_amt").val() != "") {
		sum -= parseInt(removeCommas($("#plnd_amt").val()));
	}
	if($("#corp_crd_use_amt").val() != "") {
		sum -= parseInt(removeCommas($("#corp_crd_use_amt").val()));
	}
	
	$("#provd_amt").val(addCommas(sum) + "원");
}

// 출장 항목 구분 변경
function fn_changeBztrpItem(itemDiv) {
	
	var itemVar = $(itemDiv).val(); 
	var parentVar = $(itemDiv).parents('.table').attr('id');
	var selTr = $(itemDiv).parent().parent(); // 선택한 TR
	var seq = $(selTr).attr("id").split("_").pop(); // 시퀀스
	var cntn = $(selTr).find("td:eq(1)");
	var amt = $(selTr).find("td:eq(2)");
	var rmrk = $(selTr).find("td:eq(3)");
	
	var html;
	
	if(parentVar == 'CD0026'){ //일반 사용내역 항목
		if(itemVar == 'CD0026001'){ //유류비
			html = `<select class="form-control">
						<option>--선택--</option>
						<option>무연</option>
						<option>경유</option>
						<option>LPG</option>
					</select>`
			$(cntn).find("input, select").remove();
			$(cntn).append(html);
			
			html = `<div class="input-group">
						<input type="text" name="searchField" value="" class="form-control" title="검색어 입력">
						<span class="input-group-btn">
							<button class="fnSearch btn btn-info" type="button">
								<i class="glyphicon glyphicon-search"></i>
								<span class="hidden-xs hidden-sm"> 검색</span>
							</button>
						</span>
					</div>`
			$(amt).find("input, select").remove();
			$(amt).append(html);
		}
		else if(itemVar == 'CD0026002'){ //통행료
			html = `
					<div class="row">
						<div class="col-md-6">
							<input type="text" name="searchField" value="" placeholder="출발지" class="form-control">
						</div>
						<div class="col-md-6">
							<input type="text" name="searchField" value="" placeholder="도착지" class="form-control">
						</div>
					<div>
			`
			
			$(cntn).find("input, select").remove();
			
			$(amt).find("input, select, button").remove();
			$(amt).attr('readonly', '');
			$(amt).append(html);
		}else if(itemVar == 'CD0026003'){ //대중교통
			html = `
					<select class="form-control">
						<option>--선택--</option>
						<option>기차</option>
						<option>버스</option>
						<option>택시</option>
					</select>
			`
			$(cntn).find("input, select").remove();
			$(cntn).append(html);
			
			html = `<div class="input-group">
						<input type="text" name="searchField" value="" class="form-control" title="검색어 입력">
						<span class="input-group-btn">
							<button class="fnSearch btn btn-info" type="button">
								<i class="glyphicon glyphicon-search"></i>
								<span class="hidden-xs hidden-sm"> 검색</span>
							</button>
						</span>
					</div>`
					
			$(amt).find("input, select").remove();
			$(amt).append(html);
			
			$(rmrk).find("input").attr("readonly", true);
		}else if(itemVar == 'CD0026004'){ //여비
			
			html = `
					<td colspan="5">
						<input type="text" value="" readonly="readonly" class="form-control">
					</td>
			`
		
			$(cntn).replaceWith(html);
			$(amt).remove();
			$(rmrk).remove();
			
		}else if(itemVar == 'CD0026005'){ //기타
			html = `
				<td>
					<select class="form-control">
						<option>--선택--</option>
						<option>음료</option>
						<option>간식</option>
						<option>etc</option>
					</select>
				</td>
			`
			$(cntn).replaceWith(html);

			html = `
				<td colspan="4">
					<input type="text" value="" class="form-control" id="etcInput">
				</td>
			`
			$(cntn).append(html);			
		}
		
	}else if (parentVar == 'CD0025'){ // 법인카드 사용내역 항목
		if(itemVar == 'CD0025006'){
			html = `
					<td>
						<select class="form-control">			
							<option>--전체--</option>
							<option>음료</option>
							<option>간식</option>
							<option>etc</option>
						</select>
					</td>
					<td>
						<input class="form-control" type="text">
					</td>
			`
			$(cntn).replaceWith(html);
			
		} else {
			html = `
					<input type="text" class="form-control">
			`
			$(cntn).find('input', 'select').remove();
			$(cntn).append(html);
		}
	}

// 	// 공통 영역
// 	$(rmrk).find("input").attr("readonly", false);

// 	// 금액 합산 초기화
// 	itemSum();
}

function fn_changePlc(plcBox) {
	var selTr = $(plcBox).parent().parent(); // 선택한 Tr
	var selTd = $(plcBox).parent(); // 선택한 Td
	var plc1 = $(selTd).find("select").eq(0).val();
	var plc2 = $(selTd).find("select").eq(1).val();
	var amt = $(selTr).find("td:eq(2)");
	
	if(plc1 != null && plc2 != null) {
		for(var i = 0; i < trcsList.length; i++) {
			if(trcsList[i].REGN_CD1 == plc1 && trcsList[i].REGN_CD2 == plc2) {
				$(amt).find("input").val(addCommas(trcsList[i].TRCS) + "원");
				itemSum();
			}
		}
	}
}

function fn_calNight() {
	$(".bztrp_item_divs").each(function(i, v) {
		var selTr = $(v).parent().parent()
		var bztrpNight = $("#bztrp_night").val();
		var authorNm = trvctInfo.AUTHOR_NM;
		var grade = trvctInfo.CD_NM;
		var trvct = trvctInfo.TRVCT;
		
		if($(v).val() == "CD0026002") { // 여비
			if($("#bztrp_night").val() == "") {
				selTr.find(".bztrp_item_amts").val("");
				selTr.find(".bztrp_item_ctnts").val("출장기간의 숙박일을 입력하시면 자동계산 됩니다.");
			} else {
				selTr.find(".bztrp_item_amts").val(addCommas(trvct * bztrpNight) + "원");
				selTr.find(".bztrp_item_ctnts").val(addCommas(trvct) + "원(" + authorNm + ", " + grade + ") × " + bztrpNight + "박"); 
			}
		}
	});
}

// 출장 항목 추가
function fn_addBztrpItem(parentVar) {
	// 폼의 항목들을 가져와서 seq의 최대값 계산
	var bztrpCount = 0;
	$(parentVar + " .tr_bztrp_items").each(function(i, obj) {
		var bztrpId = $(obj).attr("id").split("_");
		var bztrpSeq = bztrpId[bztrpId.length-1];
		if(bztrpSeq > bztrpCount) {
			bztrpCount = bztrpSeq; 
		}
	});
	bztrpCount++;
	
	// 폼 추가
	if(parentVar == 'CD0026'){ //일반내역
		html = '';
		html += '<tr id="tr_bztrp_item_' + bztrpCount + '" class="tr_bztrp_items">';
		html += '	<td class="form-group">';
		html += '		<select id="bztrp_item_div_' + bztrpCount + '" name="bztrp_item_div_' + bztrpCount + '" class="form-control bztrp_item_divs" onChange="fn_changeBztrpItem(this);">';
		html += '			<option value="" selected disabled>--선택--</option>';
		for(let i = 0; i < gnrlCodeList.length; i++){
			html += '<option value="' + gnrlCodeList[i].CD + '">' + gnrlCodeList[i].CD_NM + '</option>'
		}
		html += '		</select>';
		html += '	</td>';
		html += `<td>
					<select class="form-control">
						<option>--선택--</option>
					</select>
				</td>`;
		html += '	<td class="form-group" colspan="3"><input id="bztrp_item_ctnt_' + bztrpCount + '" name="bztrp_item_ctnt_' + bztrpCount + '" type="text" class="form-control bztrp_item_ctnts"></td>';
		html += '	<td class="form-group"><input id="bztrp_item_amt_' + bztrpCount + '" name="bztrp_item_amt_' + bztrpCount + '" type="text" class="form-control bztrp_item_amts text-right convNum"></td>';
		html += '	<td class="form-group"><input id="bztrp_item_rmrk_' + bztrpCount + '" name="bztrp_item_rmrk_' + bztrpCount + '" type="text" class="form-control bztrp_item_rmrks"></td>';
		html += '	<td class="form-group"><input id="bztrp_item_rmrk_' + bztrpCount + '" name="bztrp_item_rmrk_' + bztrpCount + '" type="text" class="form-control bztrp_item_rmrks"></td>';
		html += '	<td class="text-center"><span class="btn btn-xs btn-default" onClick="fn_deleteBztrpItem(this)"><i class="glyphicon glyphicon-minus-sign"></i> 삭제</span></td>';
		html += '</tr>';
		
	}else if(parentVar == 'CD0025'){ //법인내역
		
		html = '';
		html += '<tr id="tr_bztrp_item_' + bztrpCount + '" class="tr_bztrp_items">';
		html += '	<td class="form-group">';
		html += '		<select id="bztrp_item_div_' + bztrpCount + '" name="bztrp_item_div_' + bztrpCount + '" class="form-control bztrp_item_divs" onChange="fn_changeBztrpItem(this);">';
		html += '			<option value="" selected disabled>--선택--</option>';
		for(let i = 0; i < cprCodeList.length; i++){
			html += '<option value="' + cprCodeList[i].CD + '">' + cprCodeList[i].CD_NM + '</option>'
		};
		html += '		</select>';
		html += '</td>';
		html += '	<td colspan="2" class="form-group"><input id="bztrp_item_ctnt_' + bztrpCount + '" name="bztrp_item_ctnt_' + bztrpCount + '" type="text" class="form-control bztrp_item_ctnts"></td>';
		html += '	<td class="form-group"><input id="bztrp_item_amt_' + bztrpCount + '" name="bztrp_item_amt_' + bztrpCount + '" type="text" class="form-control bztrp_item_amts text-right convNum"></td>';
		html += '	<td class="form-group"><input id="bztrp_item_rmrk_' + bztrpCount + '" name="bztrp_item_rmrk_' + bztrpCount + '" type="text" class="form-control bztrp_item_rmrks"></td>';
		html += '	<td class="text-center"><span class="btn btn-xs btn-default" onClick="fn_deleteBztrpItem(this)"><i class="glyphicon glyphicon-minus-sign"></i> 삭제</span></td>';
		html += '</tr>';
	}
	
	$('#'+parentVar + ' .tr_bztrp_item_sum').before(html);
}

// 출장 항목 추가(업데이트인 경우)
function fn_addBztrpItem2(data) {
	// 공통코드 불러오기(지역코드, 출장항목코드, 여비)
	$.ajax({
		type: 'get',
		url: '${pageContext.request.contextPath}/aprv/aprv03Ajax.do',
		async: false,
		data: $("#frm1").serialize(),
		success: function(data2){
			
			var divList = data2.bztrpDivCodeList;
			var plcList = data2.plcCodeList;
			for(key in data) {
				var bztrpSeq = data[key].BZTRP_ITEM_SEQ;
				var bztrpDivCd = data[key].BZTRP_ITEM_DIV;
				var bztrpDivNm = data[key].BZTRP_ITEM_DIV_NM;
				var bztrpStPlc = data[key].BZTRP_ITEM_ST_PLC;
				var bztrpEdPlc = data[key].BZTRP_ITEM_ED_PLC;
				html = '';
				/* 항목 */
				html += '<tr id="tr_bztrp_item_' + bztrpSeq + '" class="tr_bztrp_items">';
				html += '	<td class="form-group">';
				html += '		<select id="bztrp_item_div_' + bztrpSeq + '" name="bztrp_item_div_' + bztrpSeq + '" class="form-control bztrp_item_divs" onChange="fn_changeBztrpItem(this);">';
				html += '			<option value="" disabled>--선택--</option>';
				divList.forEach(item => {
					html += '<option value="' + item.CD + '" ' + (item.CD == bztrpDivCd ? "selected" : "") + '>' + item.CD_NM + '</option>'
				});
				html += '		</select>';
				html += '	</td>';
				/* 내역 */
				if(bztrpDivCd == 'CD0026001') { // 일반-교통비
					html += '<td class="form-group">';
					html += '	<select id="bztrp_item_st_plc_' + bztrpSeq + '" name="bztrp_item_st_plc_' + bztrpSeq + '" class="form-control bztrp_item_st_plcs" style="width:45%; display:inline;" onChange="fn_changePlc(this)">';
					html += '		<option value="" disabled>--출발지--</option>';
					plcList.forEach(item => {
						html += '	<option value="' + item.CD + '" ' + (item.CD == bztrpStPlc ? "selected" : "") + '>' + item.CD_NM + '</option>';
					});
					html += '	</select>';
					html += '	<select id="bztrp_item_ed_plc_' + bztrpSeq + '" name="bztrp_item_ed_plc_' + bztrpSeq + '" class="form-control bztrp_item_ed_plcs" style="width:45%; display:inline; float:right;" onChange="fn_changePlc(this)">';
					html += '		<option value="" disabled>--도착지--</option>';
					plcList.forEach(item => {
						html += '	<option value="' + item.CD + '" ' + (item.CD == bztrpEdPlc ? "selected" : "") + '>' + item.CD_NM + '</option>';
					});
					html += '	</select>';
				} else if(bztrpDivCd == 'CD0026002') { // 일반-여비
					html += '	<td class="form-group"><input id="bztrp_item_ctnt_' + bztrpSeq + '" name="bztrp_item_ctnt_' + bztrpSeq + '" type="text" class="form-control bztrp_item_ctnts" value="' + (data[key].BZTRP_ITEM_CTNT == null ? "" : data[key].BZTRP_ITEM_CTNT) + '" readonly></td>';
				} else {
					html += '	<td class="form-group"><input id="bztrp_item_ctnt_' + bztrpSeq + '" name="bztrp_item_ctnt_' + bztrpSeq + '" type="text" class="form-control bztrp_item_ctnts" value="' + (data[key].BZTRP_ITEM_CTNT == null ? "" : data[key].BZTRP_ITEM_CTNT) + '"></td>';
				}
				/* 금액 */
				html += '	<td class="form-group"><input id="bztrp_item_amt_' + bztrpSeq + '" name="bztrp_item_amt_' + bztrpSeq + '" type="text" class="form-control bztrp_item_amts text-right convNum" value="' + (data[key].BZTRP_ITEM_AMT == null ? "" : addCommas(data[key].BZTRP_ITEM_AMT)) + '원" ' + (bztrpDivCd == "CD0026001" || bztrpDivCd == "CD0026002" ? "readonly" : "") + '></td>';
				/* 비고 */
				html += '	<td class="form-group"><input id="bztrp_item_rmrk_' + bztrpSeq + '" name="bztrp_item_rmrk_' + bztrpSeq + '" type="text" class="form-control bztrp_item_rmrks" value="' + (data[key].BZTRP_ITEM_RMRK == null ? "" : data[key].BZTRP_ITEM_RMRK) + '"></td>';
				/* 삭제 */
				html += '	<td class="text-center"><span class="btn btn-xs btn-default" onClick="fn_deleteBztrpItem(this)"><i class="glyphicon glyphicon-minus-sign"></i> 삭제</span></td>';
				html += '</tr>';
				$("#tr_bztrp_item_sum").before(html);
			};
		}
	});
}

// 출장 항목 제거
function fn_deleteBztrpItem(btn) {
	$(btn).parent().parent().remove();
	itemSum();
}

function getValidation2(valid) {
	if($("#term_st").val() == ""){
		if(valid) {
			alert("시작 날짜를 선택해 주세요.");
			$("#term_st").focus();
		}
		$("#term_st").closest(".form-group").addClass("has-error");
		valid = false;
	}
	if($("#term_ed").val() == ""){
		if(valid) {
			alert("종료 날짜를 선택해 주세요.");
			$("#term_st").focus();
		}
		$("#term_st").closest(".form-group").addClass("has-error");
		valid = false;
	}
	if($("#bztrp_night").val() == ""){
		if(valid) {
			alert("숙박일을 입력해 주세요.");
			$("#bztrp_night").focus();
		}
		$("#bztrp_night").closest(".form-group").addClass("has-error");
		valid = false;
	}
	if($("#bztrp_days").val() == ""){
		if(valid) {
			alert("출장일을 입력해 주세요.");
			$("#bztrp_days").focus();
		}
		$("#bztrp_days").closest(".form-group").addClass("has-error");
		valid = false;
	}
	if($("#bztrp_purp").val() == ""){
		if(valid) {
			alert("출장목적을 입력해 주세요.");
			$("#bztrp_purp").focus();
		}
		$("#bztrp_purp").closest(".form-group").addClass("has-error");
		valid = false;
	}
	if($("#bztrp_per").val() == ""){
		if(valid) {
			alert("출장자를 입력해 주세요.");
			$("#bztrp_per").focus();
		}
		$("#bztrp_per").closest(".form-group").addClass("has-error");
		valid = false;
	}
	if($("#bztrp_plc").val() == ""){
		if(valid) {
			alert("장소를 입력해 주세요.");
			$("#bztrp_plc").focus();
		}
		$("#bztrp_plc").closest(".form-group").addClass("has-error");
		valid = false;
	}
	if($("#dpar_area").val() == ""){
		if(valid) {
			alert("출발지역을 입력해 주세요.");
			$("#dpar_area").focus();
		}
		$("#dpar_area").closest(".form-group").addClass("has-error");
		valid = false;
	}
	if($("#aryl_area").val() == ""){
		if(valid) {
			alert("도착지역을 입력해 주세요.");
			$("#aryl_area").focus();
		}
		$("#aryl_area").closest(".form-group").addClass("has-error");
		valid = false;
	}
	// 상세 내역
	$(".tr_bztrp_items").each(function(i, obj) {
		if($(obj).find(".bztrp_item_divs option:selected").val() == "") {
			if(valid) {
				alert("상세내역의 항목을 선택해 주세요.");
				$($(obj).find(".bztrp_item_divs")).focus();
			}
			$($(obj).find(".bztrp_item_divs")).closest(".form-group").addClass("has-error");
			valid = false;
		}
		if($(obj).find(".bztrp_item_st_plcs option:selected").val() == "") {
			if(valid) {
				alert("상세내역의 출발지를 선택해 주세요.");
				$($(obj).find(".bztrp_item_ctnts")).focus();
			}
			$($(obj).find(".bztrp_item_st_plcs")).closest(".form-group").addClass("has-error");
			valid = false;
		}
		if($(obj).find(".bztrp_item_ed_plcs option:selected").val() == "") {
			if(valid) {
				alert("상세내역의 도착지를 선택해 주세요.");
				$($(obj).find(".bztrp_item_ctnts")).focus();
			}
			$($(obj).find(".bztrp_item_ed_plcs")).closest(".form-group").addClass("has-error");
			valid = false;
		}
		if($(obj).find(".bztrp_item_ctnts").val() == "" && $(obj).find(".bztrp_item_ctnts").prop("readonly") == false) {
			if(valid) {
				alert("상세내역의 내역을 입력해 주세요.");
				$($(obj).find(".bztrp_item_ctnts")).focus();
			}
			$($(obj).find(".bztrp_item_ctnts")).closest(".form-group").addClass("has-error");
			valid = false;
		}
		if($(obj).find(".bztrp_item_amts").val() == "" && $(obj).find(".bztrp_item_amts").prop("readonly") == false) {
			if(valid) {
				alert("상세내역의 금액을 입력해 주세요.");
				$($(obj).find(".bztrp_item_amts")).focus();
			}
			$($(obj).find(".bztrp_item_amts")).closest(".form-group").addClass("has-error");
			valid = false;
		}
	});

	return valid;
}

/*
 * 2022.03.23 김민석
 * 출발지 및 도착지 검색
 */
 $('#CD0026').on('click', '.fnSearch', function(){
	 let popupWidth = 600
	 let popupHeight = 300
	
	let popupX = (screen.availWidth - popupWidth) / 2;
	 
	if( window.screenLeft < 0){
		popupX += window.screen.width*-1;
	}else if ( window.screenLeft > window.screen.width ){
		popupX += window.screen.width;
	}
	
	let popupY = (screen.availHeight - popupHeight) / 2 - 10;
	
	let option = 'top='+popupY+', left='+popupX+', width='+popupWidth+', height='+popupHeight+', status=no, scrollbars=no,menubar=no, toolbar=no, resizable=no'
	window.open("", 'searchArea', option);
	 
	$('#mode').val("TEST");
	$("#frm1").attr("target", 'searchArea');
	$("#frm1").attr("action", "${pageContext.request.contextPath}/aprv/popup00View.do");
	$("#frm1").submit();
 })
</script>
<!-- Trigger the modal with a button -->