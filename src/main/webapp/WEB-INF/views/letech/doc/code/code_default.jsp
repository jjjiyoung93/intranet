<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>

<!-- 행선지 START -->
<div class="col-lg-12 form-group">
	<div class="col-lg-2 col-sm-2 text-right">
		<label class="control-label">행선지</label>
	</div>
	<div class="col-lg-9">
		<input type="text" name="place" id="place" class="form-control" />
	</div>
</div>
<!-- 행선지 END -->

<!-- 기간 START -->
<div class="col-lg-12 form-group">
	<div class="col-lg-2 col-sm-2 text-right">
		<label class="control-label">기간</label>
	</div>
	<div class="col-lg-9">
		<div
			class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
			<input id="term_st" name="term_st" type="text" aria-label="Date" autocomplete="off">
			<span class="tui-ico-date"></span>
			<div id="startpicker-container" style="margin-left: -1px;"></div>
		</div>
		~
		<div
			class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
			<input id="term_ed" name="term_ed" type="text" aria-label="Date" autocomplete="off">
			<span class="tui-ico-date"></span>
			<div id="endpicker-container" style="margin-left: -1px;"></div>
		</div>
	</div>
</div>
<!-- 기간 END -->