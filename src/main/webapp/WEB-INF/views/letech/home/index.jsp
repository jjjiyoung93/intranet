<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<jsp:include page="/resources/com/inc/meta.jsp" />
<title>Letech Intranet</title>
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.print.css' rel='stylesheet' media='print' />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
</head>

<body>
<!-- 전체 감싸는 id -->
<div id="wrapper">
<!-- top, left 메뉴  -->
	<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
		<jsp:include page="/resources/com/inc/header.jsp" />
		<%@ include file="/WEB-INF/views/letech/com/layout/menu.jsp" %>
	</nav>
	
	<!-- 컨텐츠-->
    <div class="" id="page-wrapper">
			<section class="row">

				<!-- 내용부분(작업할 부분 클래스 col-lg-10안에 넣음 됨) -->
				<div class="col-lg-10">
					<form name="frm1" id="frm1" method="post" action="${pageContext.request.contextPath}/uss/umt/cal00List.do" >
						<input type="hidden" name="cal_seq" id="cal_seq" value=""/>
						<input type="hidden" name="now_date" id="now_date" value=""/>
						<input type="hidden" name="view_type" id="view_type" value="${view_type}"/>
						<input type="hidden" name="CAL_ST_DT" id="CAL_ST_DT" value=""/>
						<input type="hidden" name="CAL_ED_DT" id="CAL_ED_DT" value=""/>
						<input type="hidden" name="flag" id="flag" value="1"/>
							<h4 id="b_tlt"><span></span></h4> 
							<!-- 달력 start -->
								<div id='calendar'></div>
							<!-- 달력 end -->
					</form>
				</div>

				<!-- aside(공지사항) -->
				<jsp:include page="/resources/com/inc/aside.jsp" />

			</section>
		</div>
		
		<!-- footer부분 -->
	 <jsp:include page="/resources/com/inc/footer.jsp" />
</div>

<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script> --%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/fullcalendar/lib/jquery.min.js"></script>
<script src='${pageContext.request.contextPath}/resources/js/fullcalendar/lib/moment.min.js'></script>
<script src='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.min.js'></script>
<script src='${pageContext.request.contextPath}/resources/js/fullcalendar/lang-all.js'></script>
<script src='${pageContext.request.contextPath}/resources/js/flipout_cards.js'></script>
<script src='${pageContext.request.contextPath}/resources/js/modernizr.js'></script>
<script type="text/javascript">
$(document).ready(function() {	

	/** fullcalendar start **/
	var currentLangCode = 'ko';
	$('#calendar').fullCalendar({
		header: {
			left: 'prev,next today',
			center: 'title',
			right: 'month,basicWeek'
//			right: 'month,basicWeek,basicDay'
		},
		buttonText: {
			today : "오늘",
			month : "월별",
			week : "주별"
		},
		monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', 
		    	       '7월','8월', '9월', '10월', '11월', '12월'],
		monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월',
					            '7월','8월', '9월', '10월', '11월', '12월'],
		dayNames:['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
		dayNamesShort:['일(SUN)', '월(MON)', '화(TUE)', '수(WED)', '목(THU)', '금(FRI)', '토(SAT)'],
		defaultDate: '${now_date}',	// 오늘 날짜 설정 (2015-09으로 넣으면 9월로 세팅)
		defaultView: '${view_type}',		// month 월별 , basicWeek 주별
 		lang: currentLangCode,	// 언어 설정 (영어:en, 한국어 : ko 등등)
		editable: false,	// true 일때 드래그 또는 사이즈 조정을 하도록함, false 일경우 드래그 또는 사이즈 조정을 하지 않음
		eventLimit: true, // allow "more" link when too many events
		currentTimezone: 'Asia/Seoul',	
		weekends : true, // 주말기능 true/false
        viewRender: function(view){
            // fullCalendar 렌더링 후 처리되어야할 내용
            $("#view_type").val(view.name);
//             var moment = $('#calendar').fullCalendar('getDate');	// 해당 달 및 주에 첫번째 일자
//             alert(moment.stripZone());
//             $("#now_date").val(moment.format());
        },
		events: function(start, end, timezone, callback) {
			var moment = $('#calendar').fullCalendar('getDate');	// 현재 날짜 ,  해당 달 및 주에 첫번째 일자
			var view = $('#calendar').fullCalendar('getView');		// 월별인지 주별인지 구분
			$("#now_date").val(moment.format());
			$("#view_type").val(view.name);
// 			alert(start.format()+"||"+end.format());
			// DB에서 데이터 가져오기
	        $.ajax({
	            url: '${pageContext.request.contextPath}/cal/cal00Ajax.do',
	            dataType: 'json',
	            data: {"now_date":moment.format(), "view_type":view.name, "flag":"1"},
	            success: function(doc) {
	            	var array = doc.calList;
	                var events = [];
	                var arrayCnt = array.length;
	                for(var i=0; i<arrayCnt; i++){
	                	events.push({
	                        title: array[i].title,
	                        start: array[i].start,
	                        end: array[i].end,
	                        url: array[i].url,
	                      	dateStart: array[i].startDate,
	                        dateEnd: array[i].endDate,
	                        timeStart: array[i].startTimeFri + array[i].startTimeSec,
	                        timeEnd: array[i].endTimeFri + array[i].endTimeSec
	                    });
	                }
	                callback(events);
	            }
	        });
	    }, eventClick: function(event) {
	    	if (event.url) {
		    	fnView(event.url);
	            return false;
	        }
/* 				
	        alert('Event: ' + calEvent.title);
	        alert('Coordinates: ' + jsEvent.pageX + ',' + jsEvent.pageY);
	        alert('View: ' + view.name);
*/
	    }, eventMouseover: function(event){
	      	$("#ev_title").html( event.title );
	      	$("#ev_start").html(event.dateStart + "("+event.timeStart+")");
	      	$("#ev_end").html(" "+ event.dateEnd + "("+event.timeEnd+")");
	    	$("#btn_id").html(" <input  class=\"btn_view\" type=\"button\" value=\"상세보기\" onclick=\"fnView('"+event.url+"');\" />  ");
	    	
	    	$('.memo-popup').click();
	    }
	});
});

function fnView(cal_seq){
	$("#cal_seq").val(cal_seq);
	$("#frm1").attr("action", "${pageContext.request.contextPath}/cal/cal00View.do");
	$("#frm1").submit();
}

</script>

<script type="text/javascript">
	  $(document).ready( function() {
	    $(".flipout").flipout_cards();
	  });
    
  </script>



</body>
</html>