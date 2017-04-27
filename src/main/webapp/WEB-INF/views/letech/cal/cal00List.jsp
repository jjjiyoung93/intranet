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
<div id="wrapper">
	<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
		<jsp:include page="/resources/com/inc/header.jsp" />
		<%@ include file="/WEB-INF/views/letech/com/layout/menu.jsp" %>
	</nav>
	<div class="" id="page-wrapper">
		<section class="row">
			<div class="col-lg-10">
				
				<form name="frm1" id="frm1" method="post" action="${pageContext.request.contextPath}/uss/umt/cal00List.do" >
					<input type="hidden" id="menu_id1" name="menu_id1" value="${param.menu_id1}"/>
					<input type="hidden" id="menu_id2" name="menu_id2" value="${param.menu_id2}"/>
					<input type="hidden" name="cal_seq" id="cal_seq" value=""/>
					<input type="hidden" name="now_date" id="now_date" value=""/>
					<input type="hidden" name="view_type" id="view_type" value="${view_type}"/>
					<input type="hidden" name="CAL_ST_DT" id="CAL_ST_DT" value=""/>
					<input type="hidden" name="CAL_ED_DT" id="CAL_ED_DT" value=""/>
												
					<h2 class="page-title clearfix">
						${titleNaviMap.MN_NM }
						<span class="pull-right site-map">
							HOME > ${titleNaviMap.NAVI_NM }
						</span>
					</h2>
				
					<!-- 달력 start -->
					<div class="form-container">
						<div id='calendar'></div>
						<!-- 달력 end -->
						<p class="Clearfix">
							<span class="pull-right"><input class="fnJoin btn btn-warning" type="button" value="일정등록" /></span>
						</p>
					</div>
				</form>
			</div>
			<jsp:include page="/resources/com/inc/aside.jsp" />
		</section>
	</div>
	 <jsp:include page="/resources/com/inc/footer.jsp" />
</div>

<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script> --%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/fullcalendar/lib/jquery.min.js"></script>
<script src='${pageContext.request.contextPath}/resources/js/fullcalendar/lib/moment.min.js'></script>

<script src='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.min.js'></script>
<script src='${pageContext.request.contextPath}/resources/js/fullcalendar/lang-all.js'></script>
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
		defaultDate: '${now_date}',	// 오늘 날짜 설정
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
//             $("#now_date").val(moment.format());
        },
		dayClick: function(date, allDay, jsEvent, view) 
		{ 
			fnInsert(date.format());	// 등록화면으로 이동
		},
		events: function(start, end, timezone, callback) {
			var moment = $('#calendar').fullCalendar('getDate');	// 현재 날짜 ,  해당 달 및 주에 첫번째 일자
			var view = $('#calendar').fullCalendar('getView');		// 월별인지 주별인지 구분
			$("#now_date").val(moment.format());
			$("#view_type").val(view.name);
			// DB에서 데이터 가져오기
	        $.ajax({
	            url: '${pageContext.request.contextPath}/cal/cal00Ajax.do',
	            dataType: 'json',
	            data: {"now_date":moment.format(), "view_type":view.name},
	            success: function(doc) {
	            	var array = doc.calList;
	                var events = [];
	                var arrayCnt = array.length;
	                for(var i=0; i<arrayCnt; i++){
	                	if(array[i].ussId == "${params.session_uss_id}"){
		                	events.push({
		                        title: array[i].title,
		                        uss_id: array[i].uss_id,
		                        start: array[i].start,
		                        end: array[i].end,
		                        url: array[i].url,
		                        dateStart: array[i].startDate,
		                        dateEnd: array[i].endDate,
		                        timeStart: array[i].startTimeFri + array[i].startTimeSec,
		                        timeEnd: array[i].endTimeFri + array[i].endTimeSec,
		                        color: '#f0ad4e'
		                    });
	                	}else{
	                		events.push({
		                        title: array[i].title,
		                        uss_id: array[i].uss_id,
		                        start: array[i].start,
		                        end: array[i].end,
		                        url: array[i].url,
		                        dateStart: array[i].startDate,
		                        dateEnd: array[i].endDate,
		                        timeStart: array[i].startTimeFri + array[i].startTimeSec,
		                        timeEnd: array[i].endTimeFri + array[i].endTimeSec
		                    });
	                	}
                	}
	                callback(events);
	            }
	        });
	    }, eventClick: function(event) {
	    	var moment = $('#calendar').fullCalendar('getDate');
	    	$("#now_date").val(moment.format());
	    	if (event.url) {
		    	fnView(event.url);
	            return false;
	        }
	    }
	});
//		$(".fc-sun").css('color','red');	// 일요일 백그라운드 색생 변경
//		$(".fc-sat").css('color','blue');	// 토요일 백그라운드 색생 변경
	/** fullcalendar end **/

	/* 일정등록버튼 클릭 */
	$(".fnJoin").click(function(){
		fnInsert("");
	})
});


function fnView(cal_seq){
	$("#cal_seq").val(cal_seq);
	$("#frm1").attr("action", "${pageContext.request.contextPath}/cal/cal00View.do");
	$("#frm1").submit();
}

function fnInsert(now_date){
	$("#CAL_ST_DT").val(now_date);
	$("#CAL_ED_DT").val(now_date);
	$("#frm1").attr("action", "${pageContext.request.contextPath}/cal/cal00Form.do");
	$("#frm1").submit();
}

</script>
</body>
</html>