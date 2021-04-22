<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>

<!-- 기간 및 일수 START -->
<div class="col-lg-12 form-group">
	<div class="col-lg-2 col-sm-2 text-right">
		<label class="control-label">출장기간</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-9">
		<div class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
			<input id="term_st" name="term_st" type="text" aria-label="Date" autocomplete="off"> <span class="tui-ico-date"></span>
			<div id="startpicker-container" style="margin-left: -1px;"></div>
		</div>
		~
		<div class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
			<input id="term_ed" name="term_ed" type="text" aria-label="Date" autocomplete="off"> <span class="tui-ico-date"></span>
			<div id="endpicker-container" style="margin-left: -1px;"></div>
		</div>
		<input type="text" class="form-control" name="bztrp_night" id="bztrp_night" style="width: 50px; display: inline; margin-left: 5px;"> <span>박</span>
		<input type="text" class="form-control" name="bztrp_days" id="bztrp_days" style="width: 50px; display: inline; margin-left: 5px;"> <span>일</span>
	</div>
</div>
<!-- 기간 및 일수 END -->

<!-- 출장목적 START -->
<div class="col-lg-12 form-group">
	<div class="col-lg-2 col-sm-2 text-right">
		<label class="control-label">출장목적</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-9">
		<input type="text" class="form-control" name="bztrp_purp" id="bztrp_purp">
	</div>
</div>
<!-- 출장목적 END -->

<!-- 출장자 및 장소 START -->
<div class="col-lg-6 form-group">
	<div class="col-lg-4 col-sm-2 text-right">
		<label class="control-label">출장자</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-6">
		<input type="text" class="form-control" name="bztrp_per" id="bztrp_per">
	</div>
</div>
<div class="col-lg-6 form-group">
	<div class="col-lg-4 col-sm-2 text-right">
		<label class="control-label">장소</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-6">
		<input type="text" class="form-control" name="bztrp_plc" id="bztrp_plc">
	</div>
</div>
<!-- 출장자 및 장소 END -->

<!-- 출발지역 및 도착지역 START -->
<div class="col-lg-6 form-group">
	<div class="col-lg-4 col-sm-2 text-right">
		<label class="control-label">출발지역</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-6">
		<input type="text" class="form-control" name="dpar_area" id="dpar_area">
	</div>
</div>
<div class="col-lg-6 form-group">
	<div class="col-lg-4 col-sm-2 text-right">
		<label class="control-label">도착지역</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-6">
		<input type="text" class="form-control" name="aryl_area" id="aryl_area">
	</div>
</div>
<!-- 출발지역 및 도착지역 END -->

<!-- 항목 START -->
<div class="col-lg-12 form-group">
	<div class="col-lg-10 col-lg-offset-1">
		<table class="table table-bordered">
			<colgroup>
				<col width="15%" />
				<col width="43%" />
				<col width="15%" />
				<col width="20%" />
				<col width="7%" />
			</colgroup>
			<thead>
				<tr>
					<th>항목 <span class="req-sign">*</span></th>
					<th>내역 <span class="req-sign">*</span></th>
					<th>금액 <span class="req-sign">*</span></th>
					<th>비고</th>
					<th><span class="btn btn-xs btn-default" onClick="fn_addBztrpItem()"><i class="glyphicon glyphicon-plus-sign"></i> 추가</span></th>
				</tr>
			</thead>
			<tbody>
				<tr id="tr_bztrp_item_sum">
					<td colspan="2" class="text-center" style="border-bottom-width: 2px;">
						<label class="form-label">합계</label>
					</td>
					<td colspan="3" class="text-right" style="border-bottom-width: 2px;">
						<input type="text" class="form-control text-right" id="bztrp_item_sum" name="bztrp_item_sum" readonly>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
<!-- 항목 END -->

<script>
var bztrpDivCodeList;

$(function() {
	// 금액이 들어가는 항목
	$("body").on("propertychange change keyup paste input", ".bztrp_item_amts, #plnd_amt, #corp_crd_use_amt", function() {
		itemSum();
	});

	// 공통코드 불러오기(출장항목코드)
	$.ajax({
		type: 'get',
		url: '${pageContext.request.contextPath}/aprv/aprv03Ajax.do',
		async: false,
		data: $("#frm1").serialize(),
		success: function(data){
			bztrpDivCodeList = data.bztrpDivCodeList;
			if($("#mode").val() != "UPDATE") {
				// 항목 1개 추가
				fn_addBztrpItem();
			} 
		}
	});

	// 금액 부분 콤마, 원 추가
	$("#bztrp_item_sum").val(addCommas($("#bztrp_item_sum").val() == "" ? 0 : $("#bztrp_item_sum").val()) + "원");
});

//3자리 단위마다 콤마 생성
function addCommas(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

// 금액의 합산
function itemSum() {
	var sum = 0;
	$(".bztrp_item_amts").each(function(i, obj) {
		if($(obj).val() != "") {
			sum += parseInt(removeCommas($(obj).val()));
		}
	});
	
	$("#bztrp_item_sum").val(addCommas(sum) + "원");
}

//출장 항목 추가
function fn_addBztrpItem() {
	// 폼의 항목들을 가져와서 seq의 최대값 계산
	var bztrpCount = 0;
	$(".tr_bztrp_items").each(function(i, obj) {
		var bztrpId = $(obj).attr("id").split("_");
		var bztrpSeq = bztrpId[bztrpId.length-1];
		if(bztrpSeq > bztrpCount) {
			bztrpCount = bztrpSeq; 
		}
	});
	bztrpCount++;
	
	// 폼 추가
	html = '';
	html += '<tr id="tr_bztrp_item_' + bztrpCount + '" class="tr_bztrp_items">';
	html += '	<td class="form-group">';
	html += '		<select id="bztrp_item_div_' + bztrpCount + '" name="bztrp_item_div_' + bztrpCount + '" class="form-control bztrp_item_divs">';
	html += '			<option value="" selected disabled>--선택--</option>';
	bztrpDivCodeList.forEach(function(item) {
		html += '<option value="' + item.CD + '">' + item.CD_NM + '</option>'
	});
	html += '		</select>';
	html += '	</td>';
	html += '	<td class="form-group"><input id="bztrp_item_ctnt_' + bztrpCount + '" name="bztrp_item_ctnt_' + bztrpCount + '" type="text" class="form-control bztrp_item_ctnts"></td>';
	html += '	<td class="form-group"><input id="bztrp_item_amt_' + bztrpCount + '" name="bztrp_item_amt_' + bztrpCount + '" type="text" class="form-control bztrp_item_amts text-right convNum"></td>';
	html += '	<td class="form-group"><input id="bztrp_item_rmrk_' + bztrpCount + '" name="bztrp_item_rmrk_' + bztrpCount + '" type="text" class="form-control bztrp_item_rmrks"></td>';
	html += '	<td class="text-center"><span class="btn btn-xs btn-default" onClick="fn_deleteBztrpItem(this)"><i class="glyphicon glyphicon-minus-sign"></i> 삭제</span></td>';
	html += '</tr>';
	$("#tr_bztrp_item_sum").before(html);
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
			for(key in data) {
				var bztrpSeq = data[key].BZTRP_ITEM_SEQ;
				var bztrpDivCd = data[key].BZTRP_ITEM_DIV;
				var bztrpDivNm = data[key].BZTRP_ITEM_DIV_NM;
				html = '';
				html += '<tr id="tr_bztrp_item_' + bztrpSeq + '" class="tr_bztrp_items">';
				html += '	<td class="form-group">';
				html += '		<select id="bztrp_item_div_' + bztrpSeq + '" name="bztrp_item_div_' + bztrpSeq + '" class="form-control bztrp_item_divs">';
				html += '			<option value="" disabled>--선택--</option>';
				divList.forEach(item => {
					html += '<option value="' + item.CD + '" ' + (item.CD == bztrpDivCd ? "selected" : "") + '>' + item.CD_NM + '</option>'
				});
				html += '		</select>';
				html += '	</td>';
				html += '	<td class="form-group"><input id="bztrp_item_ctnt_' + bztrpSeq + '" name="bztrp_item_ctnt_' + bztrpSeq + '" type="text" class="form-control bztrp_item_ctnts" value="' + (data[key].BZTRP_ITEM_CTNT == null ? "" : data[key].BZTRP_ITEM_CTNT) + '"></td>';
				html += '	<td class="form-group"><input id="bztrp_item_amt_' + bztrpSeq + '" name="bztrp_item_amt_' + bztrpSeq + '" type="text" class="form-control bztrp_item_amts text-right convNum" value="' + (data[key].BZTRP_ITEM_AMT == null ? "" : addCommas(data[key].BZTRP_ITEM_AMT)) + '원"></td>';
				html += '	<td class="form-group"><input id="bztrp_item_rmrk_' + bztrpSeq + '" name="bztrp_item_rmrk_' + bztrpSeq + '" type="text" class="form-control bztrp_item_rmrks" value="' + (data[key].BZTRP_ITEM_RMRK == null ? "" : data[key].BZTRP_ITEM_RMRK) + '"></td>';
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
	if($("#cdList1").val() == "CD0001009" && $("#cdList2").val() == "CD0001009001") {
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
			if($(obj).find(".bztrp_item_ctnts").val() == "") {
				if(valid) {
					alert("상세내역의 내역을 입력해 주세요.");
					$($(obj).find(".bztrp_item_ctnts")).focus();
				}
				$($(obj).find(".bztrp_item_ctnts")).closest(".form-group").addClass("has-error");
				valid = false;
			}
			if($(obj).find(".bztrp_item_amts").val() == "") {
				if(valid) {
					alert("상세내역의 금액을 입력해 주세요.");
					$($(obj).find(".bztrp_item_amts")).focus();
				}
				$($(obj).find(".bztrp_item_amts")).closest(".form-group").addClass("has-error");
				valid = false;
			}
		});
	}

	return valid;
}
</script>