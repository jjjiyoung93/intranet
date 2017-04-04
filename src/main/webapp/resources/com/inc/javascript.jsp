<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
<!-- 달력 Start -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-migrate-1.2.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-ui-datepicker.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common.js"></script>
<!-- 달력 End -->

<script type="text/javascript" >

/* datepicker 달력 기능 한글 설정 Start */
$.datepicker.setDefaults({
	monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	changeMonth: true,	// 월 선택 활성화
	changeYear: true,	// 년도 선택 활성화
	showMonthAfterYear: true,
	monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	dateFormat: 'yy-mm-dd'
});
/* datepicker 달력 기능 한글 설정 End */
</script>