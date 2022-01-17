<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>

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
		<input type="text" name="cttplc" id="cttplc" class="form-control" />
	</div>
</div>
<!-- 연락처 END -->

<script>
$(document).ready(function(){
	
	jsonVacTerm = ${jsonVacTerm};
	
	
	
})

function getValidation2(valid) {
	if($("#cdList1").val() == "CD0001011") {
		if($("#term_st").val() == ""){
			if(valid) {
				alert("시작 날짜를 선택해 주세요.");
				$("#term_st").focus();
			}
			$("#term_st").closest(".form-group").addClass("has-error");
			valid = false;
		}
		
		if($("input[name='half_type_cd_st']:checked").val() == ""){
			if(valid) {
				alert("휴가 기간 구분을 선택해 주세요.");
				$("input[name='half_type_cd_st']").focus();
			}
			$("input[name='half_type_cd_st']").closest(".form-group").addClass("has-error");
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
		
		if($("input[name='half_type_cd_ed']:checked").val() == ""){
			if(valid) {
				alert("휴가 기간 구분을 선택해 주세요.");
				$("input[name='half_type_cd_ed']").focus();
			}
			$("input[name='half_type_cd_ed']").closest(".form-group").addClass("has-error");
			valid = false;
		}
		
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