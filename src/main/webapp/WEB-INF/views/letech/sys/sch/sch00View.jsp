<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"  %>
<html>
<head>
<jsp:include page="/resources/com/inc/meta.jsp" />
<title>Letech Intranet</title>
<link href="<%=request.getContextPath()%>/resources/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/dataTables.bootstrap.min.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/dataTables.responsive.css" rel="stylesheet">
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.print.css' rel='stylesheet' media='print' />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<%-- <script src="<%=request.getContextPath()%>/resources/js/bootstrap.min.js"></script> --%>
<link href="${pageContext.request.contextPath}/resources/js/css/ui-lightness/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" >

<script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-code-snippet.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-dom.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-time-picker.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-date-picker.js"></script>
<link href="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-time-picker.css" rel="stylesheet" >
<link href="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-date-picker.css" rel="stylesheet" >
</head>
<style>
	.form-group{padding-left: 0px; padding-right: 0px;}
	.req-sign{color: red; font-size: 18px;}
	.tmp-pay-tb-header{font-size: 12px;}
	.req-sign-tb{color: red; font-size: 15px;}
	span{display : block;}
	td{border-collapse : collapse; border-spacing: 0;}
</style>
<body>
	<div id="wrapper">
		<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
			<jsp:include page="/resources/com/inc/header.jsp" />
			<jsp:include page="/WEB-INF/views/letech/com/layout/menu.jsp" />
		</nav>
		<div id="page-wrapper">
			<div class="row">	
				<div class="col-lg-10">
					<form name="form1" id="form1" method="post" action="${pageContext.request.contextPath}/sys/sch/sch00List.do" >
						<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}" />
						<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}" />
						<input type="hidden" id="menu_id3" name="menu_id3" value="${params.menu_id3}" />
						<!-- 타이틀 및 페이지 네비 -->
						<h2 class="page-title clearfix">
							${titleNaviMap.MN_NM }
							<span class="pull-right site-map">
								HOME > ${titleNaviMap.NAVI_NM }
							</span>
						</h2>
						
						<div class="form-container">
							<div class="board-write row">
								<!-- 이력조회 -->
								<div class="col-lg-12 form-group">
									<div class="col-lg-2 col-sm-1 text-right">
									</div>
									<div class="col-lg-9 text-right">
										<c:if test="${params.flag eq 2}">
											<button type="button" class="btn btn-info">수동실행</button>
											<button type="button" class="btn btn-info">활성화 / 비활성화</button>
											<button type="button" class="btn btn-default" onclick="showList()">이력조회</button>
										</c:if>
									</div>
								</div><hr>
								
								<!-- 배치명 -->
								<div class="col-lg-12 form-group">
									<div class="col-lg-2 col-sm-2 text-right">
										<label class="control-label">비즈플레이</label>
									</div>
									<div class="col-lg-9">
										<c:if test="${params.flag eq 2}">
											<div>배치명</div>
										</c:if>
										<c:if test="${params.flag eq 3}">
											<input class="form-control" type="text" id="title" name="title"/>
										</c:if>
									</div>
								</div> <!-- 배치명 끝 -->
								
								<!-- 배치프로그램 -->
								<div class="col-lg-12 form-group">
									<div class="col-lg-2 col-sm-2 text-right">
										<label class="control-label">배치프로그램</label>
									</div>
									<div class="col-lg-9">
										<c:if test="${params.flag eq 2}">
											<div>kr.letech.cmm.schedule.CmmScheduler.bizplayAPI</div>
										</c:if>
										<c:if test="${params.flag eq 3}">
											<input class="form-control" type="text" id="program" name="program"/>
										</c:if>
									</div>
								</div> <!-- 배치프로그램 끝 -->
							
								<!-- 배치 상세설명 -->
								<div class="col-lg-12 form-group">
									<div class="col-lg-2 col-sm-2 text-right">
										<label class="control-label">상세설명</label>
									</div>
									<div class="col-lg-9">
										<c:if test="${params.flag eq 2}">
											<div>BizPlay 결재 프로그램 연동</div>
										</c:if>
										<c:if test="${params.flag eq 3}">
											<textarea class="form-control" name="dtil_cont" id="dtil_cont"></textarea>
										</c:if>
									</div>
								</div><!-- 배치 상세설명 -->
								
								<!-- 등록일 -->
								<div class="col-lg-12 form-group">
									<div class="col-lg-2 col-sm-2 text-right">
										<label class="control-label">등록일</label>
									</div>
									<div class="col-lg-9">
										<c:if test="${params.flag eq 2}">
											<div>2020.12.01</div>
										</c:if>
										<c:if test="${params.flag eq 3}">
											<div style="width: 165px;" class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
												<input id="reg_dt"  name="reg_dt" type="text" aria-label="Date-Time" autocomplete="off"> <span class="tui-ico-date"></span>
												<div id="startpicker-container" style="margin-left: -1px;"></div>
											</div>
										</c:if>
									</div>
								</div> <!-- 등록일 끝 -->
								
								<div class="col-lg-12 form-group">
									<div class="col-lg-2 col-sm-2 text-right">
										<label class="control-label">배치주기</label>
									</div>
									<div class="table-responsive col-lg-9">
									<!-- 테이블 -->
										<table class="table table-bordered">
											<caption>배치주기등록</caption>
											<colgroup>
												<col width="16.6%" />
												<col width="*" />
												<col width="16.6%" />
												<col width="16.6%" />
												<col width="16.6%" />
												<col width="16.6%" />
											</colgroup>
											<thead class="table-secondary">
												<tr class="table-secondary">
													<th>초</th>
													<th>분</th>
													<th>시</th>
													<th>일</th>
													<th>월</th>
													<th>년</th>
												</tr>
											</thead>
											<tbody>
												<c:if test="${params.flag eq 2}">
													<tr>
														<td align="center">0</td>
														<td align="center">0</td>
														<td align="center">07,21</td>
														<td align="center">*</td>
														<td align="center">*</td>
														<td align="center">*</td>
													</tr>
												</c:if>
												<c:if test="${params.flag eq 3}">
													<tr>
														<td align="center"><input class="form-control" type="text" id="sec" name="sec"/></td>
														<td align="center"><input class="form-control" type="text" id="min" name="min"/></td>
														<td align="center"><input class="form-control" type="text" id="hour" name="hour"/></td>
														<td align="center"><input class="form-control" type="text" id="day" name="day"/></td>
														<td align="center"><input class="form-control" type="text" id="mon" name="mon"/></td>
														<td align="center"><input class="form-control" type="text" id="year" name="year"/></td>
													</tr>
												</c:if>
											</tbody>
										</table>
										<input type="button" id="detil" name="detil" class="btn btn-default " value="배치주기 상세설명 ▼"/>&nbsp;&nbsp; * 버튼 클릭 시 상세설명 확인 가능
									</div><!-- table 끝 -->
								</div> <!-- 배치주기 끝 -->
							
								<!-- 주기작성법 설명-->
								<div class="col-lg-12 form-group">
									<div class="col-lg-2 col-sm-2 text-right">
									</div>
									<div class="col-lg-9" id="cron" style="background-color : #F9F9F9; display : none;">
									<span style="text:12px;"><b>[표현식 등록방법]</b></span>
									<!-- 테이블 -->
										<table class="table table-bordered">
											<caption>배치주기등록</caption>
											<colgroup>
												<col width="33.3%" />
												<col width="*" />
												<col width="33.3%" />
											</colgroup>
											<thead class="table-secondary">
												<tr class="table-secondary">
													<th>필드명</th>
													<th>값의 허용 범위</th>
													<th>허용된 특수 문자</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td align="center">초 (Seconds)</td>
													<td align="center">0 ~ 59</td>
													<td align="center">, - * /</td>
												</tr>
												<tr>
													<td align="center">분 (Minutes)</td>
													<td align="center">0 ~ 59</td>
													<td align="center">, - * /</td>
												</tr>
												<tr>
													<td align="center">시 (Hours)</td>
													<td align="center">0 ~ 23</td>
													<td align="center">, - * /</td>
												</tr>
												<tr>
													<td align="center">일 (Day)</td>
													<td align="center">1 ~ 31</td>
													<td align="center">, - * ? / L W</td>
												</tr>
												<tr>
													<td align="center">월 (Month)</td>
													<td align="center">1 ~ 12 or JAN ~ DEC</td>
													<td align="center">, - * /</td>
												</tr>
												<tr>
													<td align="center">요일 (Week)</td>
													<td align="center">0 ~ 6 or SUN ~ SAT</td>
													<td align="center">, - * ? / L #</td>
												</tr>
												<tr>
												<td align="center">연도 (Year)</td>
												<td align="center">empty or 1970 ~ 2099</td>
												<td align="center">, - * /</td>
												</tr>
											</tbody>
										</table>
										<div>
											<span style="text:12px;"><b>*표현식 - 특수문자</b></span>
											<span>* : 모든 값(매분, 매초...)</span>
											<span>? : 특정 값이 없음</span>
											<span>- : 범위(<b>예.</b>[시] 10-12 => 10시, 11시, 12시 동작)</span>
											<span>/ : 시작시간 / 단위(<b>예.</b> 0/5 => 0분부터 매 5분)</span>
											<span>L : 일에서 사용하면 마지막 일, 요일에서는 마지막 요일(토요일)</span>
											<span>W : 가장 가까운 평일 (<b>예.</b> 15W는 15일에서 가장 가까운 평일 (월 ~ 금))</span>
											<span># : 몇째주의 무슨 요일을 표현 (<b>예.</b> 3#2 : 2번째주 수요일)</span><br>
											<span style="text:12px;"><b>*표현식 - 예시</b></span>
											<span>0 0/5 * * * ? => 5분마다</span>
											<span>0 0 12 * * ? => 매일 낮 12시</span>
											<span>0 15 10 * * ? * => 매일 오전 10시 15분</span>
										</div>
									</div>
								</div>

								
								<c:if test="${params.flag eq 2}">

									<!-- 이력조회 테이블 -->
									<div class="col-lg-12 form-group">
										<div class="col-lg-2 col-sm-2 text-right">
											<label class="control-label">이력조회</label>
										</div>
										<div class="table-responsive col-lg-9">
											<!-- 테이블 -->
											<table class="table table-bordered" style="border-collapse: collapse; border-spacing: 0">
												<caption>그룹별급수 정보관리</caption>
												<colgroup>
													<col width="10%" />
													<col width="*" />
													<col width="20%" />
													<col width="20%" />
													<col width="20%" />
												</colgroup>
												<thead>
													<tr>
														<th>순번</th>
														<th>실행일</th>
														<th>결과</th>
														<th>대상건 수</th>
														<th>처리건 수</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td align="center">5</td>
														<td align="center">2020.10.21</td>
														<td align="center">성공</td>
														<td align="right">100</td>
														<td align="right">100</td>
													</tr>
													<tr>
													<td align="center">4</td>
														<td align="center">2020.10.21</td>
														<td align="center">성공</td>
														<td align="right">150</td>
														<td align="right">150</td>
													</tr>
													<tr>
														<td align="center">3</td>
														<td align="center">2020.10.21</td>
														<td align="center">성공</td>
														<td align="right">120</td>
														<td align="right">120</td>
													</tr>
													<tr>
														<td align="center">2</td>
														<td align="center">2020.10.21</td>
														<td align="center">성공</td>
														<td align="right">130</td>
														<td align="right">130</td>
													</tr>
													<tr>
														<td align="center">1</td>
														<td align="center">2020.10.21</td>
														<td align="center">성공</td>
														<td align="right">100</td>
														<td align="right">100</td>
													</tr>
												</tbody>
											</table>
										</div><!-- table 끝 -->
									</div><!-- 이력조회 끝 -->
									<div class="text-center">
				                     <br>
				                        <!-- page nav -->
				                           <ul class="pagination pagination-sm">
				                              <li class="active"><a href="#">1</a></li>
				                           </ul>
				                    </div>
								</c:if>
								<!-- 
								<div class="text-center">
									<ul class="pagination pagination-sm">
											${pageNavigator}
									</ul>
								</div>
								-->
								
			                     
								<div class="col-lg-12 form-group">
									<div class="col-lg-2 col-sm-2 text-left">
									</div>
									<div class="table-responsive col-lg-9 text-right">
										<span>
											<c:if test="${params.flag eq 2}">
												<input type="button" id="btn-list" name="btn-list" class="btn btn-sm btn-default " value="목록" />
											</c:if>
											<c:if test="${params.flag eq 3}">
												<input type="button" id="btn-cancel" name="btn-cancel" class="btn btn-sm btn-default " value="취소" />
											</c:if>
											<c:if test="${params.flag eq 2}">
												<input type="button" id="btn-modify" name="btn-modify" onclick="btnModify()" class="btn btn-sm btn-info" value="수정"/>
											</c:if>
											<c:if test="${params.flag eq 3}">
												<input type="button" id="btn-modify" name="btn-ok" onclick="btnOk()" class="btn btn-sm btn-info" value="저장"/>
											</c:if>
											<c:if test="${params.flag eq 2}">
												<input type="button" id="btn-del" name="btn-del" onclick="btnDel()" class="btn btn-sm btn-info" value="삭제"/><!-- 비활성화 -->
											</c:if>
										</span>
									</div>
								</div>
								
								<p class="clearfix"/>

							</div> <!-- board-write row 끝 -->
					
						</div> <!-- container 끝 -->
					
					</form>
				</div>
				<jsp:include page="/resources/com/inc/aside.jsp" />
			</div><!-- div row 끝 -->
		</div><!-- div page-wrapper 끝 -->
		<jsp:include page="/resources/com/inc/footer.jsp" />
	</div><!-- div wrapper 끝 -->

<jsp:include page="/resources/com/inc/javascript.jsp" />
<script type="text/javascript">

$(function(){
	
	/* toast date */
	var datepicker = new tui.DatePicker('#startpicker-container', {
						date 	: new Date(),
						input 	: {
							element : '#reg_dt',
							format	: 'yyyy-MM-dd'
						}
					});
})

/* 목록 */
$("#btn-list").click(function(){
	goList();
});

/* 취소 */
$("#btn-cancel").click(function(){
	history.go(-1);
});

/* 목록이동 */
function goList(){
	 $("#form1").attr("action", "${pageContext.request.contextPath}/sys/sch/sch00List.do");
	 $("#form1").submit();
}

/* 저장 */
function btnOk() {
	if(confirm("배치를 저장하시겠습니까?")) {
		location.href = "sch00List.do";
	}
}

/* 수정 */
function btnModify() {
	$("#form1").attr("action", "${pageContext.request.contextPath}/sys/sch/sch00View.do?flag=3");
	$("#form1").submit();
//	location.href = "sch00View.do?flag=3";
}

/* 상세보기 토글 */
$("#detil").click(function(){
	if($("#cron").css("display") == "none") {
		$("#cron").show();
	}else {
		$("#cron").hide();
	}
});

/* 상세조회 */
function showList() {
	window.open('getSch01Form.do','target_name','scrollbars=yes,toolbar=yes,resizable=yes,width=800,height=550,left=750,top=250');
}

</script>
</body>
</html>