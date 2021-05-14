<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<!-- 지급희망일 Start  -->
<div class="col-lg-12 form-group">
	<div class="col-lg-2 col-sm-2 text-right">
		<label class="control-label">지급희망일</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-9">
		<div class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
			<input id="pay_dt" name="pay_dt" type="text" aria-label="Date" autocomplete="off"> <span class="tui-ico-date"></span>
			<div id="startpicker-container" style="margin-left: -1px;"></div>
		</div>
<!-- 		~
		<div
			class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
			<input id="term_ed" name="term_ed" type="text" aria-label="Date" autocomplete="off"> <span class="tui-ico-date"></span>
			<div id="endpicker-container" style="margin-left: -1px;"></div>
		</div> -->
	</div>
</div>
<!-- 지급 희망일 end  -->

<!-- 구분 START -->
<!-- <div class="col-lg-6 form-group">
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
</div> -->
<!-- 구분 END -->

<!-- <div class="col-lg-6 form-group">
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
</div> -->

<!--  계좌번호 START  -->
<div class="col-lg-6 form-group">
	<div class="col-lg-4 col-sm-2 text-right">
		<label class="control-label">계좌번호</label> <span class="req-sign"></span>
	</div>
	<div class="col-lg-6">
		<input type="text" name="pay_acnt" id="pay_acnt" class="form-control" placeholder="미기입시 급여계좌" />
	</div>
</div>
<!--  계좌번호 END  -->

<!-- 신청금액 START  -->
<div class="col-lg-6 form-group">
	<div class="col-lg-4 col-sm-2 text-right">
		<label class="control-label">신청금액</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-6">
		<input type="text" name="pay_amt" id="pay_amt" class="form-control"/>
	</div>
</div>
<!-- 신청금액 END  -->

<!-- 비고(이전잔액) START  -->
<div class="col-lg-6 form-group">
	<div class="col-lg-4 col-sm-2 text-right">
		<label class="control-label">이전잔액</label> <span class="req-sign"></span>
	</div>
	<div class="col-lg-6">
		<input type="text" name="pay_rmk" id="pay_rmk" class="form-control" />
	</div>
</div>
<!-- 비고(이전잔액) END  -->

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




<!-- 내용 START -->
<div class="col-lg-12 form-group">
	<div class="col-lg-2 col-sm-2 text-right">
		<label class="control-label">상세</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-9">
		<textarea class="form-control" name="pay_dtl" id="pay_dtl" style="height: 400px"></textarea>
	</div>
</div>
<!-- 내용 END -->

<script>
function getValidation2(valid) {
	if($("#cdList1").val() == "CD0001010") {
		/* if($("#pttn_div option:selected").val() == ""){
			if(valid) {
				alert("품의구분을 선택해 주세요.");
				$("#pttn_div").focus();
			}
			$("#pttn_div").closest(".form-group").addClass("has-error");
			valid = false;
		} */

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