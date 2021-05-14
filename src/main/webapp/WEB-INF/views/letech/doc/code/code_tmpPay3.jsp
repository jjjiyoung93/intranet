<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>



<!-- STD_APRV_MNG  -->
<!-- 기간 START -->
<div class="col-lg-12 form-group">
	<div class="col-lg-2 col-sm-2 text-right">
		<label class="control-label">기간</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-9">
		<div class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
			<input id="term_st" name="term_st" type="text" aria-label="Date" autocomplete="off"> <span class="tui-ico-date"></span>
			<div id="startpicker-container" style="margin-left: -1px;"></div>
		</div>
		~
		<div
			class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
			<input id="term_ed" name="term_ed" type="text" aria-label="Date" autocomplete="off"> <span class="tui-ico-date"></span>
			<div id="endpicker-container" style="margin-left: -1px;"></div>
		</div>
	</div>
</div>
<!-- 기간 END -->

<!-- DOC_TMPPAY  -->
<!-- 목적 START -->
<div class="col-lg-12 form-group">
	<div class="col-lg-2 col-sm-2 text-right">
		<label class="control-label">목적</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-9">
		<input type="text" class="form-control" name="pay_prps" id="pay_prps">
	</div>
</div>
<!-- 목적 END -->

<!-- 지급희망일 Start  -->
<div class="col-lg-6 form-group">
	<div class="col-lg-4 col-sm-2 text-right">
		<label class="control-label">지급희망일</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-6">
		<div class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
			<input id="pay_dt" name="pay_dt" type="text" aria-label="Date" autocomplete="off"> <span class="tui-ico-date"></span>
			<div id="startpicker-container2" style="margin-left: -1px;"></div>
		</div>
	</div>
</div>
<!-- 지급 희망일 end  -->

<!--  계좌번호 START  -->
<div class="col-lg-6 form-group">
	<div class="col-lg-4 col-sm-2 text-right">
		<label class="control-label">계좌번호</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-6">
		<input type="text" name="pay_acnt" id="pay_acnt" class="form-control" placeholder="입력형식 : 성명, 은행, 계좌번호" />
	</div>
</div>
<!--  계좌번호 END  -->

<!-- 항목 START -->
<div id="tmp-pay-details">
	<div class="col-lg-12 form-group pay-detail" id="pay-detail">
		<!-- 공통  -->
		<div class="col-lg-2 col-sm-2 text-right" >
			<label class="control-label">내역</label> <span class="req-sign"></span>
		</div>
		<br>
		<div class="col-lg-9" id="details">
			<!-- 항목별 사항  -->	
			<input type="hidden" id="delList" name="delList" value="">
		</div>
	</div>
<!-- SUMMARY  -->
	<div class="col-lg-12 form-group" id="pay-summary">
		
		<div class="col-lg-2 col-sm-2 text-right" >
		</div>
		<div class=" col col-lg-9">
			<label class="control-label label-trps">합계</label>
			<table class="table table-bordered" id="tb-trps">
				<colgroup>
					<col width="60%"></col>
					<col width="40%"></col
				</colgroup>
				<thead>
				</thead>
				<tbody id="tbody-summary">
				</tbody>
				<tfoot>
					<tr id="tr-total-sum" class="tmpPaySummary" >
						<td class="text-right">합계 총액</td>
						<td><i class="glyphicon glyphicon-plus"></i>&nbsp;&nbsp;<input type="text" style="width: 90%; display: inline-block;" class="form-control text-right tot-sum amt-comp" id="tot-sum" value="0" readonly>원</td>
					</tr>
					<tr id="tr-total-sum" class="tmpPaySummary" >
						<td class="text-right">이전 잔액</td>
						<td class="form-group"><i class="glyphicon glyphicon-minus"></i>&nbsp;&nbsp;<input type="text" name="pay_rmk" id="pay_rmk" style="width: 90%; display: inline-block;" class="form-control text-right amt-comp" value="0" oninput="fn_calcPayAmt(this)"/>원</td>
					</tr>
					<tr id="tr-total-sum" class="tmpPaySummary" >
						<td class="text-right">신청 금액<br>(합계 총액 - 이전 잔액)</td>
						<td class="form-group"><i class="glyphicon glyphicon-arrow-right"></i>&nbsp;&nbsp;<input type="text" name="pay_amt" id="pay_amt" style="width: 90%; display: inline-block;" class="form-control text-right amt-comp" value="0" readonly />원</td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
</div>	
<!-- 항목 END -->

<script>

//item 갯수 현황
var itemIdx = 0;
var curritemIdx = 0;
var delList = [];


	// 상세 내역 화면 출력
fn_drawTmpPayDetail();


function getValidation2(valid) {
	//기간
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
	//목적
	if($("#pay_prps").val() == "" || $("#pay_prps").val() == null){
		if(valid) {
			alert("신청 목적을 입력해 주세요.");
			$("#pay_prps").focus();
		}
		$("#pay_prps").closest(".form-group").addClass("has-error");
		valid = false;
	}
	// 지급희망일
	if($("#pay_dt").val() == "" || $("#pay_dt").val() == null){
		if(valid) {
			alert("지급희망일자를 선택해 주세요.");
			$("#pay_dt").focus();
		}
		$("#pay_dt").closest(".form-group").addClass("has-error");
		valid = false;
	}
	// 계좌번호
	if($("#pay_acnt").val() == "" || $("#pay_acnt").val() == null){
		if(valid) {
			alert("계좌번호를 입력해 주세요.");
			$("#pay_acnt").focus();
		}
		$("#pay_acnt").closest(".form-group").addClass("has-error");
		valid = false;
	}
	// 이전잔액
	if($("#pay_rmk").val() == "" || $("#pay_rmk").val() == null){
		if(valid) {
			alert("이전 잔액을 입력해 주세요.");
			$("#pay_rmk").focus();
		}
		$("#pay_rmk").closest(".form-group").addClass("has-error");
		valid = false;
	}
	//신청금액
	if($("#pay_amt").val() == "" || $("#pay_amt").val() == null){
		if(valid) {
			alert("신청 금액을 입력해 주세요.");
			$("#pay_amt").focus();
		}
		$("#pay_amt").closest(".form-group").addClass("has-error");
		valid = false;
	}
	//내역
	var trList = $(".tmpPayItemList");

	for(var i = 0; i < trList.length; i++){

		var tr = trList[i];
		//구분
		if($(tr).find(".cd2").length != 0) {
			if($(tr).find(".cd2").val() == "" || $(tr).find(".cd2").val() == null){
				if(valid) {
					alert("분류를 선택해 주세요.");
					$(tr).find(".cd2").focus();
				}
				$(tr).find(".cd2").closest(".form-group").addClass("has-error");
				valid = false;
			}
		}
		//횟수 || 숙박일수
		if($(tr).find(".cnt").val() == "" || $(tr).find(".cnt").val() == null) {
			if(valid) {
				alert("횟수(숙박일수)를 입력해 주세요.");
				$(tr).find(".cnt").focus();
			}
			$(tr).find(".cnt").closest(".form-group").addClass("has-error");
			valid = false;
		} else if($(tr).find(".cnt").val().split(".").length > 1) {
			if(valid) {
				alert("0이나 양수로 입력해 주세요.");
				$(tr).find(".cnt").focus();
			}
			$(tr).find(".cnt").closest(".form-group").addClass("has-error");
			valid = false;
		}
		
		// 시작일
		if($(tr).find(".st-dt").val() == "" || $(tr).find(".st-dt").val() == null) {
			if(valid) {
				alert("시작일을 선택해 주세요.");
				$(tr).find(".st-dt").focus();
			}
			$(tr).find(".st-dt").closest(".form-group").addClass("has-error");
			valid = false;
		}
		// 종료일
		if($(tr).find(".ed-dt").val() == "" || $(tr).find(".ed-dt").val() == null) {
			if(valid) {
				alert("종료일을 선택해 주세요.");
				$(tr).find(".ed-dt").focus();
			}
			$(tr).find(".ed-dt").closest(".form-group").addClass("has-error");
			valid = false;
		}

		//출발지
		if($(tr).find(".rmk1").length != 0) {
			if($(tr).find(".rmk1").val() == "" || $(tr).find(".rmk1").val() == null){
				if(valid) {
					alert("출발지를 입력해 주세요.");
					$(tr).find(".rmk1").focus();
				}
				$(tr).find(".rmk1").closest(".form-group").addClass("has-error");
				valid = false;
			}
		}
		//도착지
		if($(tr).find(".rmk2").length != 0) {
			if($(tr).find(".rmk2").val() == "" || $(tr).find(".rmk2").val() == null){
				if(valid) {
					alert("도착지를 입력해 주세요.");
					$(tr).find(".rmk2").focus();
				}
				$(tr).find(".rmk2").closest(".form-group").addClass("has-error");
				valid = false;
			}
		}
		//왕복/편도
		if($(tr).find(".rmk3").length != 0) {
			if($(tr).find(".rmk3").val() == "" || $(tr).find(".rmk3").val() == null){
				if(valid) {
					alert("왕복/편도를 선택해 주세요.");
					$(tr).find(".rmk3").focus();
				}
				$(tr).find(".rmk3").closest(".form-group").addClass("has-error");
				valid = false;
			}
		}
		//기준금액
		if($(tr).find(".price").val() == "" || $(tr).find(".price").val() == null) {
			if(valid) {
				alert("기준금액을 입력해 주세요.");
				$(tr).find(".price").focus();
			}
			$(tr).find(".price").closest(".form-group").addClass("has-error");
			valid = false;
		}
		//금액
		if($(tr).find(".amt").val() == "" || $(tr).find(".amt").val() == null) {
			if(valid) {
				alert("기준금액을 입력해 주세요.");
				$(tr).find(".amt").focus();
			}
			$(tr).find(".amt").closest(".form-group").addClass("has-error");
			valid = false;
		}

		//비고
		if($(tr).find(".cd2").val() == "CD0014008" 
			|| $(tr).find(".cd2").val() == "CD0015004"
			|| $(tr).find(".cd2").val() == "CD0016003") {
			if($(tr).find(".rmk4").val() == "" || $(tr).find(".rmk4").val() == null){
				if(valid) {
					alert("비고사항을 입력해 주세요.");
					$(tr).find(".rmk4").focus();
				}
				$(tr).find(".rmk4").closest(".form-group").addClass("has-error");
				valid = false;
			}
		}
		
	}

	return valid;
}




//validation  추가할것


//가지급금 구분코드1(가지급금 구분코드) 가져오기
function fn_getCdList(param){
	var cd = param;
	var codeList;
	$.ajax({
		url : "${pageContext.request.contextPath}/sys/cdm/getCodeList.do?cd="+cd,
		method : 'get',
		async : false,
		dataType : 'json',
		success : function(data) {
			codeList = data.codeList;
		}
	})
	return codeList;
}
//코드 상세 정보 가져오기
function fn_getCode(param){
	var cd = param;
	var getCodeView;
	$.ajax({
		url : "${pageContext.request.contextPath}/sys/cdm/getCode.do?cd="+cd,
		method : 'get',
		async : false,
		dataType : 'json',
		success : function(data) {
			getCodeView = data.getCodeView;
		}
	})
	return getCodeView;
}

//가지급금 상세 내역 화면 출력
function fn_drawTmpPayDetail(){
	console.log("draw!!");
	var cdList = fn_getCdList("CD0013");
	
	for(var i= 0; i < cdList.length; i++){
		var cd = cdList[i];

		var code = cd.CD;
		var cd1 = "\'"+code+"\'";
		var name = cd.CD_NM;
		var val = "\'"+cd.CD_VAL+"\'";
		var html = "";
		html += '<div>'
		html +=		'<div>'				
		html +=			'<label class="control-label label-'+code+'">'+name+'</label>'
		html +=			'<table class="table table-bordered" id="tb-'+code+'">'
		html +=				'<colgroup>'
		if(code == "CD0013001") {
			html += 				'<col width="2%;"/>'
			html += 				'<col width="10%;"/>'
			html += 				'<col width="7%;"/>'
			html += 				'<col width="12%;"/>'
			html += 				'<col width="12%;"/>'
			html += 				'<col width="10%;"/>'
			html += 				'<col width="10%;"/>'
			html += 				'<col width="8%;"/>'
			html += 				'<col width="10%;"/>'
			html += 				'<col width="10%;"/>'
			html += 				'<col width="10%;"/>'			
		} else if(code == "CD0013002") {
			html += 				'<col width="2%;"/>'
			html += 				'<col width="10%;"/>'
			html += 				'<col width="7%;"/>'
			html += 				'<col width="12%;"/>'
			html += 				'<col width="12%;"/>'
			html += 				'<col width="10%;"/>'
			html +=					'<col width="10%;"/>'
			html +=					'<col width="40%;"/>'
		} else if(code == "CD0013003") {
			html += 				'<col width="2%;"/>'
			html += 				'<col width="10%;"/>'
			html += 				'<col width="12%;"/>'
			html += 				'<col width="12%;"/>'
			html += 				'<col width="10%;"/>'
			html +=					'<col width="10%;"/>'
			html +=					'<col width="50%;"/>'
		} else if(code == "CD0013004") {
			html += 				'<col width="2%;"/>'
			html += 				'<col width="10%;"/>'
			html += 				'<col width="7%;"/>'
			html += 				'<col width="12%;"/>'
			html += 				'<col width="12%;"/>'
			html += 				'<col width="10%;"/>'
			html +=					'<col width="10%;"/>'
			html +=					'<col width="40%;"/>'
			
		}

		html +=				'</colgroup>'
		html +=				'<thead>'
		html +=					'<tr id="thead-tr-'+code+'">'
		html +=						'<th>#<span class="req-sign"></span></th>'			
		//숙박비일 경우 (숙박 일수, 분류 제외)
		if(code == "CD0013003") {
			html +=						'<th>숙박일수 <span class="req-sign">*</span></th>'
		}else {
			html +=						'<th>분류 <span class="req-sign">*</span></th>'
			html +=						'<th>횟수 <span class="req-sign">*</span></th>'
		}
		html +=						'<th>시작일 <span class="req-sign">*</span></th>'
		html +=						'<th>종료일 <span class="req-sign">*</span></th>'

		//교통비일 경우 추가 항목(출발지, 도착지, 왕복/편도 구분)	
		if(code == "CD0013001"){
			html +=						'<th>출발지 <span class="req-sign">*</span></th>';
			html +=						'<th>도착지 <span class="req-sign">*</span></th>';
			html +=						'<th>왕복/편도 <span class="req-sign">*</span></th>';
		}

		html +=						'<th>기준금액 <span class="req-sign">*</span></th>'
		html +=						'<th>금액 <span class="req-sign">*</span></th>'
		html +=						'<th>비고 <span class="req-sign"></span></th>'
		html +=						'<th><span class="btn btn-xs btn-default" onclick="fn_addItem(this,'+val+','+cd1+')"><i class="glyphicon glyphicon-plus-sign"></i> 추가</span></th>'
	    html +=					'</tr>'
	    html +=				'</thead>'
	    html +=				'<tbody id="tbody-'+code+'">'
		html += 				'<tr id="tbody-tr-empty" class="text-center">'
		if(code == "CD0013001"){
			html +=                     '<td colspan="12">항목이 비어있습니다. 추가해주세요.</td>'
		} else {
			html +=                     '<td colspan="11">항목이 비어있습니다. 추가해주세요.</td>'
		}
		html +=                 '</tr>'    
	    html +=				'</tbody>'
	    html +=				'<tfoot>'
	    html +=					'<tr id="sum-tr-'+code+'">'
	    if(code == "CD0013003") {
		    html +=						'<td colspan="6" class="text-right" style="border-bottom-width: 2px;">'
		    html +=						'	<label class="form-label">소계</label>'
		    html +=						'</td>'
	    } else {
		    html +=						'<td colspan="7" class="text-right" style="border-bottom-width: 2px;">'
		    html +=						'	<label class="form-label">소계</label>'
		    html +=						'</td>'

		}
	    html +=						'<td colspan="5" class="text-right" style="border-bottom-width: 2px;">'
	    html +=						'	<input type="text" style="display: inline-block; width: 90%;" class="form-control text-right sum-input amt-comp" id="sum-'+code+'" value="0" readonly>원'
	    html +=						'</td>'
	    html +=					'</tr>'				
	    html +=				'</tfoot>'
	    html +=			'</table>'
	    html +=		'</div>'
	    html +=	'</div>'


		//합계 요약
// 		var summHtml = "";
// 		summHtml += '<tr id="tr-'+code+'-sum" class="tmpPaySummary" >'
// 		summHtml += 	'<td class="text-right">'+name+' 총액</td>'
// 		summHtml += 	'<td><input type="text" class="form-control text-right summary-sum" id="'+code+'-sum" value="0" readonly></td>'
// 		summHtml += '</tr>'
		
	
		$("#details").append(html);
		//$("#tbody-summary").append(summHtml);
		console.log("draw end!!");
	}



	

}

// 추가 버튼 눌렀을 때 cd1 값에 따라 tr 추가
function fn_addItem(src, cdVal, cd1){
	var code = cdVal;
	var upCd = cd1
	var cd2List = fn_getCdList(code);
	var idx = itemIdx;

	
	var src = $(src);
	var tb = $(src).parents("table")[0];
    var dest = $(src).parents("table").find("tbody")[0];
	var trCnt = $(dest).find(".tmpPayItemList").length + 1;

    var html = "";
   	html +=					'<tr id="tmpPayItemList['+idx+']" class="tmpPayItemList" >'
   	html +=						'<input type="hidden" name="tmpPayItemList['+idx+'].cd1" id="tmpPayItemList['+idx+'].CD1" class="cd1" value="'+upCd+'">'
    html +=						'<td class="tr-no">'+trCnt+'</td>'
	//숙박비가 아닐경우 분류 컬럼을 추가
    if(upCd != "CD0013003") {
	    html +=						'<td class="form-group">'
	    html +=							'<select class="form-control cd2" name="tmpPayItemList['+idx+'].cd2">'
	    html += 							'<option value="">선택</option>'
		for(var i=0; i < cd2List.length; i++){
			var cd = cd2List[i].CD;
			var name = cd2List[i].CD_NM;
			html += '<option value="'+cd+'">'+name+'</option>';
		}
	    html +=							'</select>'
	    html +=						'</td>'				
    }	
    html +=						'<td class="form-group"><input type="number" min="0" style="display: inline-block; width: 80%;" name="tmpPayItemList['+idx+'].cnt" class="form-control w-25 cnt calc-comp" value="0" oninput="this.value = this.value.replace(/[^0-9.]/g, \'\')" />회</td>'				
    html +=						'<td class="form-group">'
    html +=						'	<div class="form-control tui-datepicker-input tui-datetime-input tui-has-focus" style="display: inline-block; width: 100%;">'
    html +=						'		<input id="tmpPayItemList-'+idx+'-ST_DT" name="tmpPayItemList['+idx+'].stDt" class="st-dt" type="text" aria-label="Date" autocomplete="off"> <span class="tui-ico-date"></span>'
    html +=						'		<div id="itemStartpicker-container-'+idx+'" class="st-dt-container" style="margin-left: -1px;"></div>'
    html +=						'	</div>	'
    html +=						'</td>		'		
    html +=						'<td class="form-group">'
    html +=						'	<div class="form-control tui-datepicker-input tui-datetime-input tui-has-focus" style="display: inline-block; width: 100%;">'
    html +=						'		<input id="tmpPayItemList-'+idx+'-ED_DT" name="tmpPayItemList['+idx+'].edDt" class="ed-dt" type="text" aria-label="Date" autocomplete="off"> <span class="tui-ico-date"></span>'
    html +=						'		<div id="itemEndpicker-container-'+idx+'" class="ed-dt-container" style="margin-left: -1px;"></div>'
    html +=						'	</div>'
    html +=						'</td>		'
   	//교통비일 경우 추가 항목(출발지, 도착지, 왕복/편도 구분)	
	if(upCd == "CD0013001"){
		html +=						'<td class="form-group"><input type="text" class="form-control text-right rmk1" id="tmpPayItemList['+idx+'].RMK1" name="tmpPayItemList['+idx+'].rmk1"></td>';
		html +=						'<td class="form-group"><input type="text" class="form-control text-right rmk2" id="tmpPayItemList['+idx+'].RMK2" name="tmpPayItemList['+idx+'].rmk2"></td>';
		html +=						'<td class="form-group">'
		html += 						'<select class="form-control trip calc-comp rmk3" name="tmpPayItemList['+idx+'].rmk3">'
		html +=								'<option value="">선택</option>'
		html +=								'<option value="1">편도</option>'
		html +=								'<option value="2">왕복</option>'
		html += 						'</select>'
		html +=						'</td>'
	}
	html +=						'<td class="form-group"><input type="text" style="display: inline-block; width: 80%;" class="form-control text-right price calc-comp amt-comp" id="tmpPayItemList['+idx+'].PRICE" name="tmpPayItemList['+idx+'].price" value="0" >원</td>'
	html +=						'<td class="form-group"><input type="text" style="display: inline-block; width: 80%;" class="form-control text-right amt amt-comp" id="tmpPayItemList['+idx+'].AMT" name="tmpPayItemList['+idx+'].amt" value="0" readonly>원</td>'
	html +=						'<td class="form-group"><input type="text" class="form-control text-right rmk4" id="tmpPayItemList['+idx+'].RMK4" name="tmpPayItemList['+idx+'].rmk4" value="" placeholder="기타시 필수"></td>'
	html += 					'<td class="text-center"><span class="btn btn-xs btn-default" onClick="fn_delItem(this)"><i class="glyphicon glyphicon-minus-sign"></i> 삭제</span></td>';							
    html +=					'</tr>'

    $(dest).find("#tbody-tr-empty").remove();
    $(dest).append(html);
	itemIdx += 1;

    fn_addDatePicker(tb)
	
}


//datepicker 추가

function fn_addDatePicker(src){

	var trList = $(src).find(".tmpPayItemList");
	var lastTr = trList[trList.length-1];
	var stCont = $(lastTr).find(".st-dt-container");
	var edCont = $(lastTr).find(".ed-dt-container");
	var stInput = $(lastTr).find(".st-dt");
	var edInput = $(lastTr).find(".ed-dt");

	var stInputId = "#"+$(stInput).attr("id")+"";
	var edInputId = "#"+$(edInput).attr("id")+"";
	var stContId = "#"+$(stCont).attr("id")+"";
	var edContId = "#"+$(edCont).attr("id")+"";

	var picker = tui.DatePicker.createRangePicker({
		language: 'ko',
		startpicker: {
			input: stInputId,
			container: stContId
		},
		endpicker: {
			input: edInputId,
			container: edContId
		},
		type: 'date',
		format: 'yyyy-MM-dd'
	});

	return picker;
	
}

//항목당 금액 계산
function fn_calcAmt(src) {
	var target = $(src).parents("tr");
	var cnt = 1;
	var trip = 1;
	var price = 1;

	var targetCnt = $(target).find(".cnt").val();
	var targetTrip = $(target).find(".trip").val();
	var targetPrice = $(target).find(".price").val();

	targetPrice = removeCommas(targetPrice);
	var targetAmt = $(target).find(".amt");
	 
	if(targetCnt != null && targetCnt != "") {
		cnt = targetCnt * 1;
	}
	if(targetTrip != null && targetTrip != "") {
		trip = targetTrip * 1;
	}
	if(targetPrice != null && targetPrice != "") {
		price = targetPrice * 1;
	}

	var amt = cnt * trip * price;

	amt = addCommas(amt);
	$(targetAmt).val(amt);
}


//항목당 소계 계산
function fn_calcSum(src){
	var code = $(src).parents(".tmpPayItemList").find(".cd1").val();
	var sum = 0;

	var amtList = $(src).parents("table").find(".amt");
	for(var i = 0; i < amtList.length;  i++){
		var amt = amtList[i];
		var amtVal = $(amt).val();
		amtVal = removeCommas(amtVal) * 1;
		sum += amtVal;
	}
	sum = addCommas(sum);

	var dest = $(src).parents("table").find(".sum-input")[0];
	$(dest).val(sum);
	
}

//합계 총액 계산
function fn_calcTotSum() {

	var totSum = 0;
	var sumList = $("#pay-detail").find(".sum-input");
	for(var i = 0; i < sumList.length;  i++){
		var sum = sumList[i];
		var sumVal = $(sum).val();
		sumVal = removeCommas(sumVal) * 1;
		totSum += sumVal;
	}
	totSum = addCommas(totSum);
	$("#tot-sum").val(totSum);
}

//신청 금액 계산
function fn_calcPayAmt(){
	var totSum = $("#tot-sum").val();
	totSum = removeCommas(totSum) * 1;
	var payRmk = $("#pay_rmk").val();
	payRmk = removeCommas(payRmk) * 1;
	var payAmt = totSum - payRmk;
	payAmt = addCommas(payAmt);
	$("#pay_amt").val(payAmt);
}


//계산 항목들의 값이 변경 될 때 금액, 소계 금액 , 합계 총액, 신청 금액을 자동 계산
$("#pay-detail").on('change', ".calc-comp", function(){
	fn_calcAmt(this);
	fn_calcSum(this);
	fn_calcTotSum();
	fn_calcPayAmt();
})

//금액 항목 입력시 표시 형식 출력
$("#tmp-pay-details").on('change', ".amt-comp", function(){
	var val = $(this).val();
	val = addCommas(val);
	$(this).val(val);
})

//금액 정보 표시 형식 추가
function addCommas(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

//금액 정보 계산시 표시 형식 제거 => aprv00Form.jsp 참조



//삭제 버튼 클릭 후 순번 재조정 및 삭제
function fn_delItem(src) {

	var tbody = $(src).parents("table").find("tbody")[0];
	var trList = $(tbody).find(".tmpPayItemList");
	var target = $(src).parents(".tmpPayItemList");
	var delNo = $(target).find(".tr-no").text() * 1; // 기준
	var code = $(target).find(".cd1").val();
	var itemNo = $(target).find(".itemNo").val();

	for(var i = 0; i < trList.length; i++){
		var tr = trList[i];
		var trNo = $(tr).find(".tr-no").text() * 1;

		if(trNo > delNo){
			trNo -= 1;
			$(tr).find(".tr-no").text(trNo);
		}
	}
	// 금액 재계산
	var delAmt = $(target).find(".amt").val();
	delAmt = removeCommas(delAmt) * 1;
	var sumInput = $(src).parents("table").find(".sum-input")[0];
	var sum = $(sumInput).val();
	sum = removeCommas(sum) * 1;
	sum -= delAmt;
	sum = addCommas(sum);
	$(sumInput).val(sum);
	
	var totSum = $("#tot-sum").val();
	totSum = removeCommas(totSum) * 1;
	totSum -= delAmt;
	totSum = addCommas(totSum);
	$("#tot-sum").val(totSum);
	var payAmt = $("#pay_amt").val();
	payAmt = removeCommas(payAmt) * 1;
	payAmt -= delAmt;
	payAmt = addCommas(payAmt);
	$("#pay_amt").val(payAmt);
	
	$(target).remove();

	//세부 항목이 비어 있을 때 추가되는 기본 tr 
	var trCnt = $(tbody).find(".tmpPayItemList").length;
	if(trCnt == 0){

		var html = "";
		html += 				'<tr id="tbody-tr-empty" class="text-center">'
		if(code == "CD0013001"){
			html +=                     '<td colspan="12">항목이 비어있습니다. 추가해주세요.</td>'
		} else {
			html +=                     '<td colspan="11">항목이 비어있습니다. 추가해주세요.</td>'
		}
		html +=                 '</tr>'     

		$(tbody).append(html);	
	}

	delList.push(itemNo);
	$("#delList").val(delList);
}

//저장된 데이터 불러오기
function fn_addTmpPayItem(data, data2){
	console.log("additem start");
	//console.log(data);
	var tmpPayItemList = data.tmpPayItemList;
	//console.log(tmpPayItemList);
	itemIdx = tmpPayItemList.length;
	if(tmpPayItemList.length > 0) {
		for(var j=0; j < tmpPayItemList.length; j++) {
			var item = tmpPayItemList[j];
			var upCd = item.CD1;
			console.log(upCd);
			var codeView = fn_getCode(upCd);
			var cd2List = fn_getCdList(codeView.CD_VAL);
			var cd2 = item.CD2;
			var cnt = item.CNT * 1;
			var stDt = item.ST_DT;
			var edDt = item.ED_DT;
			var itemNo = item.ITEM_NO;
			var rmk1 = item.RMK1 == null ? "" : item.RMK1;
			var rmk2 = item.RMK2 == null ? "" : item.RMK2;
			var rmk3 = item.RMK3 == null ? "" : item.RMK3;
			var rmk4 = item.RMK4 == null ? "" : item.RMK4;
			var price = item.PRICE;
			var amt = item.AMT;
			var idx = j;
			var tb = $("#tb-"+upCd);
			var dest = $("#tbody-"+upCd);
			console.log(dest);
			var html = "";
			   	html +=					'<tr id="tmpPayItemList['+idx+']" class="tmpPayItemList" >'
			   	html +=						'<input type="hidden" name="tmpPayItemList['+idx+'].cd1" id="tmpPayItemList['+idx+'].CD1" class="cd1" value="'+upCd+'">'
				html +=						'<input type="hidden" class="itemNo" name="tmpPayItemList['+idx+'].itemNo" value="'+itemNo+'">'
			    html +=						'<td class="tr-no">'+(idx+1)+'</td>'
				//숙박비가 아닐경우 분류 컬럼을 추가
			    if(upCd != "CD0013003") {
				    html +=						'<td class="form-group">'
				    html +=							'<select class="form-control cd2" name="tmpPayItemList['+idx+'].cd2" id="cd2-'+idx+'">'
				    html += 							'<option value="">선택</option>'
					for(var i=0; i < cd2List.length; i++){
						var cd = cd2List[i].CD;
						var name = cd2List[i].CD_NM;
						html += '<option value="'+cd+'">'+name+'</option>';
					}
				    html +=							'</select>'
				    html +=						'</td>'				
			    }	
			    html +=						'<td class="form-group"><input type="number" min="0" style="display: inline-block; width: 80%;" name="tmpPayItemList['+idx+'].cnt" class="form-control w-25 cnt calc-comp" value="'+cnt+'" oninput="this.value = this.value.replace(/[^0-9.]/g, \'\')" />회</td>'				
			    html +=						'<td class="form-group">'
			    html +=						'	<div class="form-control tui-datepicker-input tui-datetime-input tui-has-focus" style="display: inline-block; width: 100%;">'
			    html +=						'		<input id="tmpPayItemList-'+idx+'-ST_DT" name="tmpPayItemList['+idx+'].stDt" class="st-dt" type="text" aria-label="Date" autocomplete="off"> <span class="tui-ico-date"></span>'
			    html +=						'		<div id="itemStartpicker-container-'+idx+'" class="st-dt-container" style="margin-left: -1px;"></div>'
			    html +=						'	</div>	'
			    html +=						'</td>		'		
			    html +=						'<td class="form-group">'
			    html +=						'	<div class="form-control tui-datepicker-input tui-datetime-input tui-has-focus" style="display: inline-block; width: 100%;">'
			    html +=						'		<input id="tmpPayItemList-'+idx+'-ED_DT" name="tmpPayItemList['+idx+'].edDt" class="ed-dt" type="text" aria-label="Date" autocomplete="off"> <span class="tui-ico-date"></span>'
			    html +=						'		<div id="itemEndpicker-container-'+idx+'" class="ed-dt-container" style="margin-left: -1px;"></div>'
			    html +=						'	</div>'
			    html +=						'</td>		'
			   	//교통비일 경우 추가 항목(출발지, 도착지, 왕복/편도 구분)	
				if(upCd == "CD0013001"){
					html +=						'<td class="form-group"><input type="text" class="form-control text-right rmk1" id="tmpPayItemList['+idx+'].RMK1" name="tmpPayItemList['+idx+'].rmk1" value="'+rmk1+'"></td>'
					html +=						'<td class="form-group"><input type="text" class="form-control text-right rmk2" id="tmpPayItemList['+idx+'].RMK2" name="tmpPayItemList['+idx+'].rmk2" value="'+rmk2+'"></td>'
					html +=						'<td class="form-group">'
					html += 						'<select class="form-control trip calc-comp rmk3" id="rmk3-'+idx+'" name="tmpPayItemList['+idx+'].rmk3">'
					html +=								'<option value="">선택</option>'
					html +=								'<option value="1">편도</option>'
					html +=								'<option value="2">왕복</option>'
					html += 						'</select>'
					html +=						'</td>'
				}
				html +=						'<td class="form-group"><input type="text" style="display: inline-block; width: 80%;" class="form-control text-right price calc-comp amt-comp" id="tmpPayItemList['+idx+'].PRICE" name="tmpPayItemList['+idx+'].price" value="'+price+'" >원</td>'
				html +=						'<td class="form-group"><input type="text" style="display: inline-block; width: 80%;" class="form-control text-right amt amt-comp" id="amt-'+idx+'" name="tmpPayItemList['+idx+'].amt" value="'+amt+'" readonly>원</td>'
				html +=						'<td class="form-group"><input type="text" class="form-control text-right rmk4" id="tmpPayItemList['+idx+'].RMK4" name="tmpPayItemList['+idx+'].rmk4" value="'+rmk4+'" placeholder="기타시 필수"></td>'
				html += 					'<td class="text-center"><span class="btn btn-xs btn-default" onClick="fn_delItem(this)"><i class="glyphicon glyphicon-minus-sign"></i> 삭제</span></td>'							
			    html +=					'</tr>'			


			    $(dest).find("#tbody-tr-empty").remove();
			    $(dest).append(html);
			    var rmk3Sel = $("#rmk3-"+idx);
			    var cd2Sel = $("#cd2-"+idx);  
				var amtInput = $("#amt-"+idx);
				console.log(amtInput);
				
				$(rmk3Sel).val(rmk3);
			    $(cd2Sel).val(cd2);
			    var picker = fn_addDatePicker(tb);
			    
			    var stDtStr = stDt.split("-");
			    var stYear = stDtStr[0];
			    var stMon = stDtStr[1] - 1;
			    var stDay = stDtStr[2];

			    var edDtStr = edDt.split("-");
			    var edYear = edDtStr[0];
			    var edMon = edDtStr[1] - 1;
			    var edDay = edDtStr[2];
			    

			    var stDate = new Date(stYear ,stMon ,stDay);
		    	var edDate = new Date(edYear, edMon, edDay);
				picker.setStartDate(stDate);
				picker.setEndDate(edDate);
			    fn_calcSum($(amtInput));
			    fn_calcTotSum();
			    
		}
	}
}



</script>