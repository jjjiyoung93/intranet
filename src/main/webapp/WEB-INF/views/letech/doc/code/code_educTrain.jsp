<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>

<!-- 교육명 START -->
<div class="col-lg-12 form-group">
	<div class="col-lg-2 col-sm-2 text-right">
		<label class="control-label">교육명</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-9">
		<input type="text" name="educ_nm" id="educ_nm" class="form-control" />
	</div>
</div>
<!-- 교육명 END -->

<!-- 교육훈련목적 및 내용 START -->
<div class="col-lg-12 form-group">
	<div class="col-lg-2 col-sm-2 text-right">
		<label class="control-label">교육훈련목적 및 내용</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-9">
		<textarea class="form-control" name="educ_purp_cntn" id="educ_purp_cntn"></textarea>
	</div>
</div>
<!-- 교육훈련목적 및 내용 END -->

<!-- 교육기간 START -->
<div class="col-lg-12 form-group">
	<div class="col-lg-2 col-sm-2 text-right">
		<label class="control-label">교육기간</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-9">
		<div
			class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
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
<!-- 교육기간 END -->

<!-- 교육장소, 교육기관 START -->
<div class="col-lg-6 form-group">
	<div class="col-lg-4 col-sm-2 text-right">
		<label class="control-label">교육장소</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-6">
		<input type="text" name="educ_plc" id="educ_plc" class="form-control" />
	</div>
</div>
<div class="col-lg-6 form-group">
	<div class="col-lg-4 col-sm-2 text-right">
		<label class="control-label">교육기관</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-6">
		<input type="text" name="educ_inst" id="educ_inst" class="form-control" />
	</div>
</div>
<!-- 교육장소, 교육기관 END -->

<!-- 교육비, 지원액 START -->
<div class="col-lg-6 form-group">
	<div class="col-lg-4 col-sm-2 text-right">
		<label class="control-label">교육비</label>
	</div>
	<div class="col-lg-6">
		<input type="text" name="educ_cost" id="educ_cost" class="form-control text-right convNum" />
	</div>
</div>
<div class="col-lg-6 form-group">
	<div class="col-lg-4 col-sm-2 text-right">
		<label class="control-label">지원액</label>
	</div>
	<div class="col-lg-6">
		<input type="text" name="spmn" id="spmn" class="form-control text-right convNum" />
	</div>
</div>
<!-- 교육비, 지원액 END -->

<!-- 비고 START -->
<div class="col-lg-12 form-group">
	<div class="col-lg-2 col-sm-2 text-right">
		<label class="control-label">비고</label>
	</div>
	<div class="col-lg-9">
		<textarea class="form-control" name="rmrk" id="rmrk"></textarea>
	</div>
</div>
<!-- 비고 END -->

<script>
function getValidation2(valid) {
	if($("#cdList1").val() == "CD0001016") {
		if($("#educ_nm").val() == ""){
			if(valid) {
				alert("교육명을 입력해 주세요.");
				$("#educ_nm").focus();
			}
			$("#educ_nm").closest(".form-group").addClass("has-error");
			valid = false;
		}
		if($("#educ_purp_cntn").val() == ""){
			if(valid) {
				alert("교육훈련목적 및 내용을 입력해 주세요.");
				$("#educ_purp_cntn").focus();
			}
			$("#educ_purp_cntn").closest(".form-group").addClass("has-error");
			valid = false;
		}
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
		if($("#educ_plc").val() == ""){
			if(valid) {
				alert("교육장소를 입력해 주세요.");
				$("#educ_plc").focus();
			}
			$("#educ_plc").closest(".form-group").addClass("has-error");
			valid = false;
		}
		if($("#educ_inst").val() == ""){
			if(valid) {
				alert("교육기관을 입력해 주세요.");
				$("#educ_inst").focus();
			}
			$("#educ_inst").closest(".form-group").addClass("has-error");
			valid = false;
		}
	}

	return valid;
}
</script>