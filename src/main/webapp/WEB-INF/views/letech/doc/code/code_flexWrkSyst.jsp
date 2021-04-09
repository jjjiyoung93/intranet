<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>

<!-- 이용기간 START -->
<div class="col-lg-12 form-group">
	<div class="col-lg-2 col-sm-2 text-right">
		<label class="control-label">이용기간</label> <span class="req-sign">*</span>
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
	</div>
</div>
<!-- 이용기간 END -->

<!-- 근무시간 START -->
<div class="col-lg-12 form-group">
	<div class="col-lg-2 col-sm-2 text-right">
		<label class="control-label">근무시간</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-9">
		<textarea class="form-control" name="wrk_hh" id="wrk_hh"></textarea>
	</div>
</div>
<!-- 근무시간 END -->

<!-- 주요업무 START -->
<div class="col-lg-12 form-group">
	<div class="col-lg-2 col-sm-2 text-right">
		<label class="control-label">주요업무</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-9">
		<input type="text" name="main_busi" id="main_busi"
			class="form-control" />
	</div>
</div>
<!-- 주요업무 END -->

<!-- 요청사유 START -->
<div class="col-lg-12 form-group">
	<div class="col-lg-2 col-sm-2 text-right">
		<label class="control-label">신청사유</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-9">
		<input type="text" name="rqst_rsn" id="rqst_rsn" class="form-control" />
	</div>
</div>
<!-- 요청사유 END -->

<script>
function getValidation2(valid) {
	if($("#cdList1").val() == "CD0001013" && $("#cdList2").val() == "CD0001013001") {
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
		if($("#wrk_hh").val() == ""){
			if(valid) {
				alert("근무시간을 입력해 주세요.");
				$("#wrk_hh").focus();
			}
			$("#wrk_hh").closest(".form-group").addClass("has-error");
			valid = false;
		}
		if($("#main_busi").val() == ""){
			if(valid) {
				alert("주요업무를 입력해 주세요.");
				$("#main_busi").focus();
			}
			$("#main_busi").closest(".form-group").addClass("has-error");
			valid = false;
		}
		if($("#rqst_rsn").val() == ""){
			if(valid) {
				alert("요청사유를 입력해 주세요.");
				$("#rqst_rsn").focus();
			}
			$("#rqst_rsn").closest(".form-group").addClass("has-error");
			valid = false;
		}
	}

	return valid;
}
</script>