<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>


<!-- 기간 START -->
<div class="col-lg-12 form-group">
	<div class="col-lg-2 col-sm-2 text-right">
		<label class="control-label">기간</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-9 form-inline">
		<div class="form-control tui-datepicker-input tui-datetime-input tui-has-focus" style="vertical-align: middle;">
			<input id="term_st" class="vac-term" name="term_st" type="text" aria-label="Date" autocomplete="off"> <span class="tui-ico-date"></span>
			<div id="startpicker-container" style="margin-left: -1px;"></div>
		</div>
		<label class="control-label">(<span class="half_type_nm_st"></span>)</label>
		<label class="control-label">~</label>
		<div
			class="form-control tui-datepicker-input tui-datetime-input tui-has-focus" style="vertical-align: middle;">
			<input id="term_ed" class="vac-term" name="term_ed" type="text" aria-label="Date" autocomplete="off"> <span class="tui-ico-date"></span>
			<div id="endpicker-container" style="margin-left: -1px;"></div>
		</div>
		<label class="control-label">(<span class="half_type_nm_ed"></span>)</label>
		<div class="col-lg-6 col-sm-6 pull-right" style="display:none;">
			<div class="col-lg-4 col-sm-2 col-xs-12 text-right">
				<label class="control-label">사용일수</label> <span class="req-sign"></span>
 			</div>
			<div class="col-lg-6 col-sm-6 col-xs-12">
				<input id="day_cnt" type="text" class="form-control" value="0" readonly>
			</div>
		</div>
	</div>
	
</div>
<!-- 기간 END -->

<!-- 사유 START -->
<div class="col-lg-12 form-group">
	<div class="col-lg-2 col-sm-2 text-right">
		<label class="control-label">사유</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-9">
		<input type="text" name="frogh_rsn" id="frogh_rsn" class="form-control" />
	</div>
</div>
<!-- 사유 END -->

<!-- 주소 START -->
<div class="col-lg-12 form-group">
	<div class="col-lg-2 col-sm-2 text-right">
		<label class="control-label">행선지</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-9">
		<input type="text" name="addr" id="addr" class="form-control" />
	</div>
</div>
<!-- 주소 END -->

<!-- 연락처 START -->
<div class="col-lg-12 form-group">
	<div class="col-lg-2 col-sm-2 text-right">
		<label class="control-label">연락처</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-9">
		<input type="text" name="cttplc" id="cttplc" class="form-control" oninput="this.value = this.value.replace(/[^0-9]/g, '')" />
	</div>
</div>
<!-- 연락처 END -->

<script>

jsonVacCdList = ${jsonVacTerm};

function getValidation2(valid) {
	if($("#cdList1").val() == "CD0001011") {
		var vctLeftDay;
		
		/* 2022.01.27 휴가잔여일수 조회 추가 : BEGIN*/
		$.ajax({
			url : "${pageContext.request.contextPath}/aprv/aprv04Ajax.do",
			type : "post",
			dataType : 'json',
			async : false,
			data : {"rept_aprv_no" : $("#rept_aprv_no").val()},
			success : function(json){
				var vctMap = json.vctMap;
				var leftDay = vctMap.VCT_LEFT_DAY;
				vctLeftDay = leftDay;
				//console.log("잔여일 : " + leftDay);
			}, error: function (request, status, error) {
				valid = false;
				return false;
			}
		});
		/* 2022.01.27 휴가잔여일수 조회 추가 : END*/
		
		if($("#term_st").val() == ""){
			if(valid) {
				alert("시작 날짜를 선택해 주세요.");
				$("#term_st").focus();
			}
			$("#term_st").closest(".form-group").addClass("has-error");
			valid = false;
		}
		
		if($("#half_type_cd_st").val() == ""){
			if(valid) {
				alert("휴가 시간 구분(시작일자)을 선택해 주세요.");
				$("#half_type_cd_st").focus();
			}
			$("#half_type_cd_st").closest(".form-group").addClass("has-error");
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
		
		if($("#half_type_cd_ed").val() == ""){
			if(valid) {
				alert("휴가 시간 구분(종료일자)을 선택해 주세요.");
				$("#half_type_cd_ed").focus();
			}
			$("#half_type_cd_ed").closest(".form-group").addClass("has-error");
			valid = false;
		}
		/*2022.01.27 휴가 잔여일 비교 validation 추가 : BEGIN*/
		// 작성년도 기준 신청일
		
		if(valid && $("#cdList2").val() == "CD0001011001"){
			//휴가 신청 일수
			var vctDayCnt = 0;
			
			var today = new Date();
			//작성일 기준 년도
			var thisYr = today.getFullYear();
			//시작일자
			var vctStDt = $("#term_st").val();
			var stDate = new Date(vctStDt);
			//종료일자
			var vctEdDt = $("#term_ed").val();
			var edDate = new Date(vctEdDt);
			//시작일자 반차구분
			var vctStGb = $(".half_type_cd_st_opt:selected").attr('cnt');
			//console.log("시작일자 구분 : "+ vctStGb);
			//종료일자 반차구분
			var vctEdGb = $(".half_type_cd_ed_opt:selected").attr('cnt');
			//console.log("종료일자 구분 : "+ vctEdGb);
			
			//종료일자 - 시작일자 일자 차이
			var diffDate = (edDate - stDate) / (24 * 60 * 60 * 1000);
			//console.log("날짜 차이 : " + diffDate);
			var date;
			var year;
			
			for(var i = 0; i <= diffDate; i++){
				date = new Date(vctStDt);
				
				date.setDate(date.getDate() + i);
				year = date.getFullYear();
				
				if(thisYr == year){
					if(date.getDate() == stDate.getDate()){
						vctDayCnt += parseFloat(vctStGb);
					}else if(date.getDate() ==  edDate.getDate()){
						vctDayCnt += parseFloat(vctEdGb);
					}else{
						vctDayCnt += 1;
					}
				}
			}
			//alert("신청일수 : "+vctDayCnt);
			if(vctLeftDay != null){
				var vctDayCntNum = vctDayCnt;
				var vctLeftDayNum = parseFloat(vctLeftDay);
				
				if(vctDayCntNum > vctLeftDayNum){
					var msg = "휴가 잔여일 : "+vctLeftDayNum+"일, 신청일 : "+vctDayCntNum+"일 \n 휴가 잔여일이 부족하여 등록할 수 없습니다.";
					alert(msg);
					valid = false;
				}
				
			}else{
				alert("휴가부여일수 등록 자료를 찾을 수 없습니다. 휴가부여일수를 먼저 등록해주세요.");
				valid = false;
				
			}
		}

		/*2022.01.27 휴가 잔여일 비교 validation 추가 : END*/
		
		
		if($("#frogh_rsn").val() == ""){
			if(valid) {
				alert("사유를 입력해 주세요.");
				$("#frogh_rsn").focus();
			}
			$("#frogh_rsn").closest(".form-group").addClass("has-error");
			valid = false;
		}
		if($("#addr").val() == ""){
			if(valid) {
				alert("행선지를 입력해 주세요.");
				$("#addr").focus();
			}
			$("#addr").closest(".form-group").addClass("has-error");
			valid = false;
		}
		if($("#cttplc").val() == ""){
			if(valid) {
				alert("연락처를 입력해 주세요.");
				$("#cttplc").focus();
			}
			$("#cttplc").closest(".form-group").addClass("has-error");
			valid = false;
		}
	}

	return valid;
}

</script>