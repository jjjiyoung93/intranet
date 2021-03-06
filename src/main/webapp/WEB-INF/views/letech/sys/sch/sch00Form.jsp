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
</style>
<body>
	<div id="wrapper">
		<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
			<jsp:include page="/resources/com/inc/header.jsp" />
			<%@ include file="/WEB-INF/views/letech/com/layout/menu.jsp" %>
		</nav>
		<div id="page-wrapper">
			<div class="row">	
				<div class="col-lg-10">
					<form name="form1" id="form1" method="post" action="<%=request.getContextPath()%>/sys/sch/sch00List.do" >
						<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}" />
						<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}" />
						<input type="hidden" id="menu_id3" name="menu_id3" value="${params.menu_id3}" />
						<!-- ????????? ??? ????????? ?????? -->
						<h2 class="page-title clearfix">
							${titleNaviMap.MN_NM }
							<span class="pull-right site-map">
								HOME > ${titleNaviMap.NAVI_NM }
							</span>
						</h2>
						
						<div class="form-container">
							<div class="board-write row">
								
								<!-- ????????? -->
								<div class="col-lg-12 form-group">
									<div class="col-lg-2 col-sm-2 text-right">
										<label class="control-label">?????????</label>
									</div>
									<div class="col-lg-9">
										<input class="form-control" type="text" id="title" name="title"/>
									</div>
								</div> <!-- ????????? ??? -->
								
								<!-- ?????????????????? -->
								<div class="col-lg-12 form-group">
									<div class="col-lg-2 col-sm-2 text-right">
										<label class="control-label">??????????????????</label>
									</div>
									<div class="col-lg-9">
										<input class="form-control" type="text" id="program" name="program"/>
									</div>
								</div> <!-- ?????????????????? ??? -->
							
								<!-- ?????? ???????????? -->
								<div class="col-lg-12 form-group">
									<div class="col-lg-2 col-sm-2 text-right">
										<label class="control-label">????????????</label>
									</div>
									<div class="col-lg-9">
										<textarea class="form-control" name="dtil_cont" id="dtil_cont"></textarea>
									</div>
								</div><!-- ?????? ???????????? -->
								
								<!-- ????????? -->
								<div class="col-lg-12 form-group">
									<div class="col-lg-2 col-sm-2 text-right">
										<label class="control-label">?????????</label>
									</div>
									<div class="col-lg-9">
										<div style="width: 165px;" class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
											<input id="reg_dt"  name="reg_dt" type="text" aria-label="Date-Time" autocomplete="off"> <span class="tui-ico-date"></span>
											<div id="startpicker-container" style="margin-left: -1px;"></div>
										</div>
									</div>
								</div> <!-- ????????? ??? -->
								
								
								<div class="col-lg-12 form-group">
									<div class="col-lg-2 col-sm-2 text-right">
										<label class="control-label">????????????</label>
									</div>
									<div class="table-responsive col-lg-9">
									<!-- ????????? -->
										<table class="table table-bordered">
											<caption>??????????????????</caption>
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
													<th>???</th>
													<th>???</th>
													<th>???</th>
													<th>???</th>
													<th>???</th>
													<th>???</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td align="center"><input class="form-control" type="text" id="sec" name="sec" /></td>
													<td align="center"><input class="form-control" type="text" id="min" name="min"  /></td>
													<td align="center"><input class="form-control" type="text" id="hour" name="hour"/></td>
													<td align="center"><input class="form-control" type="text" id="day" name="day"  /></td>
													<td align="center"><input class="form-control" type="text" id="mon" name="mon"   /></td>
													<td align="center"><input class="form-control" type="text" id="year" name="year" /></td>
												</tr>
											</tbody>
										</table>
										<input type="button" id="detil" name="detil" class="btn btn-default " value="???????????? ???????????? ???"/>&nbsp;&nbsp; * ?????? ?????? ??? ???????????? ?????? ??????
									</div><!-- table ??? -->
								</div> 
								<div class="col-lg-12 form-group">
									<div class="col-lg-2 col-sm-2 text-right">
									</div>
									<div class="col-lg-9" id="cron" style="background-color : #F9F9F9; display : none;">
										<span style="text:12px;"><b>[????????? ????????????]</b></span>
										<!-- ????????? -->
										<table class="table table-bordered">
											<caption>??????????????????</caption>
											<colgroup>
												<col width="33.3%" />
												<col width="*" />
												<col width="33.3%" />
											</colgroup>
											<thead class="table-secondary">
												<tr class="table-secondary">
													<th>?????????</th>
													<th>?????? ?????? ??????</th>
													<th>????????? ?????? ??????</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td align="center">??? (Seconds)</td>
													<td align="center">0 ~ 59</td>
													<td align="center">, - * /</td>
												</tr>
												<tr>
													<td align="center">??? (Minutes)</td>
													<td align="center">0 ~ 59</td>
													<td align="center">, - * /</td>
												</tr>
												<tr>
													<td align="center">??? (Hours)</td>
													<td align="center">0 ~ 23</td>
													<td align="center">, - * /</td>
												</tr>
												<tr>
													<td align="center">??? (Day)</td>
													<td align="center">1 ~ 31</td>
													<td align="center">, - * ? / L W</td>
												</tr>
												<tr>
													<td align="center">??? (Month)</td>
													<td align="center">1 ~ 12 or JAN ~ DEC</td>
													<td align="center">, - * /</td>
												</tr>
												<tr>
													<td align="center">?????? (Week)</td>
													<td align="center">0 ~ 6 or SUN ~ SAT</td>
													<td align="center">, - * ? / L #</td>
												</tr>
												<tr>
												<td align="center">?????? (Year)</td>
												<td align="center">empty or 1970 ~ 2099</td>
												<td align="center">, - * /</td>
												</tr>
											</tbody>
										</table>
										<div>
											<span style="text:12px;"><b>*????????? - ????????????</b></span>
											<span>* : ?????? ???(??????, ??????...)</span>
											<span>? : ?????? ?????? ??????</span>
											<span>- : ??????(<b>???.</b>[???] 10-12 => 10???, 11???, 12??? ??????)</span>
											<span>/ : ???????????? / ??????(<b>???.</b> 0/5 => 0????????? ??? 5???)</span>
											<span>L : ????????? ???????????? ????????? ???, ??????????????? ????????? ??????(?????????)</span>
											<span>W : ?????? ????????? ?????? (<b>???.</b> 15W??? 15????????? ?????? ????????? ?????? (??? ~ ???))</span>
											<span># : ???????????? ?????? ????????? ?????? (<b>???.</b> 3#2 : 2????????? ?????????)</span><br>
											<span style="text:12px;"><b>*????????? - ??????</b></span>
											<span>0 0/5 * * * ? => 5?????????</span>
											<span>0 0 12 * * ? => ?????? ??? 12???</span>
											<span>0 15 10 * * ? * => ?????? ?????? 10??? 15???</span>
										</div>
									</div>
								</div><!-- ???????????? ??? -->
								
								
								
								<div class="col-lg-12 form-group">
									<div class="col-lg-2 col-sm-2 text-right">
									</div>
									<div class="table-responsive col-lg-9 text-right">
										<span>
											<input type="button" id="btn-ok" name="btn-ok" onclick="btnOk()" class="btn btn-sm btn-info" value="??????"/>
											<input type="button" id="btn-cancel" name="btn-cancel" class="btn btn-sm btn-default " value="??????"/>
										</span>
									</div>
								</div>
								
								<p class="clearfix"/>

							</div> <!-- board-write row ??? -->
					
						</div> <!-- container ??? -->
					
					</form>
				</div>
				<jsp:include page="/resources/com/inc/aside.jsp" />
			</div><!-- div row ??? -->
		</div><!-- div page-wrapper ??? -->
		<jsp:include page="/resources/com/inc/footer.jsp" />
	</div><!-- div wrapper ??? -->
	
<script type="text/javascript">

$(function(){
	
	/* toast date */
	var datepicker = new tui.DatePicker('#startpicker-container', {
							language: 'ko',		//?????? ??????
							date 	: new Date(),
							input 	: {
								element : '#reg_dt',
								format	: 'yyyy-MM-dd'
							}
						});
})

/* ?????? */
function btnOk() {
	if(confirm("????????? ?????????????????????????")) {
		location.href = "sch00List.do";
	}
//	$("#frm1").submit();
}

/* ?????? */
$("#btn-cancel").click(function(){
	$("#form1").attr("action", "${pageContext.request.contextPath}/sys/sch/sch00List.do");
	$("#form1").submit();
});

/* ???????????? ?????? */
$("#detil").click(function(){
	if($("#cron").css("display") == "none") {
		$("#cron").show();
	}else {
		$("#cron").hide();
	}
});

</script>
</body>
</html>