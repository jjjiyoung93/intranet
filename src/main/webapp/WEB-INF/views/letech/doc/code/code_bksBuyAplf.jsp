<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>

<!-- 도서명  START -->
<div class="col-lg-12 form-group">
	<div class="col-lg-2 col-sm-2 text-right">
		<label class="control-label">도서명</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-9">
		<input class="form-control" type="text" id="bks_nm" name="bks_nm" />
	</div>
</div>
<!-- 도서명 END -->

<!-- 구입목적 START -->
<div class="col-lg-12 form-group">
	<div class="col-lg-2 col-sm-2 text-right">
		<label class="control-label">구입목적</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-9">
		<textarea class="form-control" name="puch_purp" id="puch_purp"></textarea>
	</div>
</div>
<!-- 구입목적 END -->

<!-- 저자명 및 출판사 START -->
<div class="col-lg-6 form-group">
	<div class="col-lg-4 col-sm-2 text-right">
		<label class="control-label">저자명</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-6">
		<input class="form-control" type="text" id="authr_nm" name="authr_nm" />
	</div>
</div>
<div class="col-lg-6 form-group">
	<div class="col-lg-4 col-sm-2 text-right">
		<label class="control-label">출판사</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-6">
		<input class="form-control" type="text" id="pbcm" name="pbcm" />
	</div>
</div>
<!-- 저자명 및 출판사 END -->

<!-- 출판일 및 ISBN START -->
<div class="col-lg-6 form-group">
	<div class="col-lg-4 col-sm-2 text-right">
		<label class="control-label">출판일</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-6">
		<input class="form-control" type="text" id="pblt_dd" name="pblt_dd" />
	</div>
</div>
<div class="col-lg-6 form-group">
	<div class="col-lg-4 col-sm-2 text-right">
		<label class="control-label">ISBN</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-6">
		<input class="form-control" type="text" id="isbn" name="isbn" />
	</div>
</div>
<!-- 출판일 및 ISBN END -->

<!-- 구입희망권수 및 권당금액 START -->
<div class="col-lg-6 form-group">
	<div class="col-lg-4 col-sm-2 text-right">
		<label class="control-label">구입희망권수</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-6">
		<input class="form-control text-right convVol" type="text" id="puch_hope_nmvl" name="puch_hope_nmvl" />
	</div>
</div>
<div class="col-lg-6 form-group">
	<div class="col-lg-4 col-sm-2 text-right">
		<label class="control-label">권당금액</label> <span class="req-sign">*</span>
	</div>
	<div class="col-lg-6">
		<input class="form-control text-right convNum" type="text" id="bks_amt" name="bks_amt" />
	</div>
</div>
<!-- 구입희망권수 및 권당금액 END -->

<!-- 구입희망일 및 총금액 START -->
<div class="col-lg-6 form-group">
	<div class="col-lg-4 col-sm-2 text-right">
		<label class="control-label">구입희망일</label>
	</div>
	<div class="col-lg-6">
		<input class="form-control" type="text" id="puch_hope_dd" name="puch_hope_dd" />
	</div>
</div>
<div class="col-lg-6 form-group">
	<div class="col-lg-4 col-sm-2 text-right">
		<label class="control-label">총금액</label>
	</div>
	<div class="col-lg-6">
		<input class="form-control text-right convNum" type="text" id="bks_amt_sum" name="bks_amt_sum" readonly />
	</div>
</div>
<!-- 구입희망일 및 총금액 END -->

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
$(function() {
	// 금액이 들어가는 항목
	$("body").on("propertychange change keyup paste input", "#puch_hope_nmvl, #bks_amt", function() {
		itemSum();
	});
	
	// 금액 부분 콤마, 원, 권 추가
	$("#bks_amt").val(addCommas($("#bks_amt").val()) + "원");
	$("#bks_amt_sum").val(addCommas($("#bks_amt_sum").val()) + "원");
	$("#puch_hope_nmvl").val(addCommas($("#puch_hope_nmvl").val()) + "권");
});

//3자리 단위마다 콤마 생성
function addCommas(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

//금액의 합산
function itemSum() {
	var sum = 0;
	if($("#puch_hope_nmvl").val() != "" && $("#bks_amt").val() != "") {
		sum = parseInt(removeCommas($("#puch_hope_nmvl").val())) * parseInt(removeCommas($("#bks_amt").val()));
	}
	
	$("#bks_amt_sum").val(addCommas(sum) + "원");
}

function getValidation2(valid) {
	if($("#cdList1").val() == "CD0001015") {
		if($("#bks_nm").val() == ""){
			if(valid) {
				alert("도서명을 입력해 주세요.");
				$("#bks_nm").focus();
			}
			$("#bks_nm").closest(".form-group").addClass("has-error");
			valid = false;
		}
		if($("#puch_purp").val() == ""){
			if(valid) {
				alert("구입목적을 입력해 주세요.");
				$("#puch_purp").focus();
			}
			$("#puch_purp").closest(".form-group").addClass("has-error");
			valid = false;
		}
		if($("#authr_nm").val() == ""){
			if(valid) {
				alert("저자명을 입력해 주세요.");
				$("#authr_nm").focus();
			}
			$("#authr_nm").closest(".form-group").addClass("has-error");
			valid = false;
		}
		if($("#pbcm").val() == ""){
			if(valid) {
				alert("출판사를 입력해 주세요.");
				$("#pbcm").focus();
			}
			$("#pbcm").closest(".form-group").addClass("has-error");
			valid = false;
		}
		if($("#pblt_dd").val() == ""){
			if(valid) {
				alert("출판일을 입력해 주세요.");
				$("#pblt_dd").focus();
			}
			$("#pblt_dd").closest(".form-group").addClass("has-error");
			valid = false;
		}
		if($("#isbn").val() == ""){
			if(valid) {
				alert("ISBN을 입력해 주세요.");
				$("#isbn").focus();
			}
			$("#isbn").closest(".form-group").addClass("has-error");
			valid = false;
		}
		if($("#puch_hope_nmvl").val() == ""){
			if(valid) {
				alert("구입희망권수를 입력해 주세요.");
				$("#puch_hope_nmvl").focus();
			}
			$("#puch_hope_nmvl").closest(".form-group").addClass("has-error");
			valid = false;
		}
		if($("#bks_amt").val() == ""){
			if(valid) {
				alert("권당금액을 입력해 주세요.");
				$("#bks_amt").focus();
			}
			$("#bks_amt").closest(".form-group").addClass("has-error");
			valid = false;
		}
	}

	return valid;
}
</script>