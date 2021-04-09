<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>

<!-- 구분 START -->
<div class="col-lg-6 form-group">
	<div class="col-lg-4 col-sm-2 text-right">
		<label class="control-label">품의구분</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-6">
		<select id="pttn_div" name="pttn_div" class="form-control">
			<option value="">--선택--</option>
			<option value="품의">품의</option>
			<option value="보고">보고</option>
		</select>
	</div>
</div>
<!-- 구분 END -->

<!-- 내용 START -->
<div class="col-lg-12 form-group">
	<div class="col-lg-2 col-sm-2 text-right">
		<label class="control-label">품의내용</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-9">
		<textarea class="form-control" name="pttn_cont" id="pttn_cont"
			style="height: 400px"></textarea>
	</div>
</div>
<!-- 내용 END -->

<script>
function getValidation2(valid) {
	if($("#cdList1").val() == "CD0001008") {
		if($("#pttn_div option:selected").val() == ""){
			if(valid) {
				alert("품의구분을 선택해 주세요.");
				$("#pttn_div").focus();
			}
			$("#pttn_div").closest(".form-group").addClass("has-error");
			valid = false;
		}
		if($("#pttn_cont").val() == ""){
			if(valid) {
				alert("품의내용을 선택해 주세요.");
				$("#pttn_cont").focus();
			}
			$("#pttn_cont").closest(".form-group").addClass("has-error");
			valid = false;
		}
	}

	return valid;
}
</script>