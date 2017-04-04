/**
 * 
 */
/* datepicker 달력 기능 한글 설정 Start */
function datepickerFn(){
	$.datepicker.setDefaults({
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		changeMonth: true,	// 월 선택 활성화
		changeYear: true,	// 년도 선택 활성화
		showMonthAfterYear: true,
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dateFormat: 'yy-mm-dd'
	});	
}
/* datepicker 달력 기능 한글 설정 End */