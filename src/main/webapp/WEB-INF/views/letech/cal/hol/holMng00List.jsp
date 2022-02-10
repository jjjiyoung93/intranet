<!doctype html>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<%@page import="java.util.Date"%>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
	<jsp:include page="/resources/com/inc/meta.jsp" />
	<title>Letech Intranet</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
	<script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-code-snippet.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-dom.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-time-picker.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-date-picker.js"></script>
	<link href="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-time-picker.css" rel="stylesheet" >
	<link href="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-date-picker.css" rel="stylesheet" >
	
	<link href="https://unpkg.com/bootstrap-table@1.19.1/dist/bootstrap-table.min.css" rel="stylesheet">
</head>

<body>
	<div id="wrapper">
		<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
			<jsp:include page="/resources/com/inc/header.jsp" />
			<%@ include file="/WEB-INF/views/letech/com/layout/menu.jsp" %>
		</nav>
		<div id="page-wrapper">
			<section class="row">
				<div class="col-lg-10">
				<!-- 오늘 날짜 세팅  -->
				<c:set var="today" value="<%=new Date() %>"/>
				<!-- 금년도  -->
				<c:set var="year"><fmt:formatDate value="${today}" pattern="yyyy"/></c:set>
				<!-- page -->
					<form name="frm1" id="frm1" method="post" action="${pageContext.request.contextPath}/sys/vct/vctDay00List.do" >
						<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}" />
						<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}" />
						<input type="hidden" id="cPage" name="cPage" value="${cPage }" />
						<input type="hidden" id="mode" name="mode" value="${params.mode}" />
						<input type="hidden" id="cal_hol_seq" name="cal_hol_seq" value="">
						<input type="hidden" id="max_row_seq" name="max_row_cnt" value="">
						<!-- 타이틀 및 페이지 네비 -->
								<h2 class="page-title clearfix">
								${titleNaviMap.MN_NM }
								<span class="pull-right site-map">
									HOME > ${titleNaviMap.NAVI_NM }
								</span>
							</h2>
							<div class="form-container">
								<div class="clearfix search-box">
										<div class="row">
											<!-- 기준년도  -->
											<div class="col-lg-3 col-sm-5 col-xs-8 form-inline">
												<label>기준년도</label>
												<div class="tui-datepicker-input tui-datetime-input tui-has-focus" style="vertical-align: middle; width: 90px;">
													<input type="text" id="datepicker-input-ko" name="stdd_yr" value="${params.stdd_yr}" aria-label="Date" class="text-center" title="search">
													<span class="tui-ico-date"></span>
												</div>
												<div class="datepicker-cell" id="datepicker-year-ko"></div>
											</div>
											<!-- id/성명  -->
											<div class="col-lg-9 col-sm-6 col-xs-4 pull-right">
												<div class="col-xs-12 un-style">
													<div class="input-group text-right">
														<span class="input-group-btn">
															<button class="fnLoadHol btn btn-info" type="button">
																<i class="glyphicon glyphicon-refresh"></i>
																<span class="hidden-xs hidden-sm">공공데이터포털 휴일 API 동기화</span>
															</button>
														</span>
													</div>
												</div>
											</div>
										</div>
							</div>
							<p class="clearfix board-top">
<%-- 								<select id="listCnt" name="listCnt" class="form-control" style="width: 100px; display: inline-block;" onchange="goPage('1');">
									<option value="10" <c:if test="${params.listCnt == '10'}">selected = "selected"</c:if>>10</option>
									<option value="20" <c:if test="${params.listCnt == '20'}">selected = "selected"</c:if>>20</option>
									<option value="30" <c:if test="${params.listCnt == '30'}">selected = "selected"</c:if>>30</option>
									<option value="50" <c:if test="${params.listCnt == '50'}">selected = "selected"</c:if>>50</option>
									<option value="100" <c:if test="${params.listCnt == '100'}">selected = "selected"</c:if>>100</option>
								</select> --%>
								<br>
								<span class="pull-right">
									<button type="button" class="btn btn-sm btn-default" onClick="addRow();" >추 가</button>
									<!-- <button type="button" class="fnDel btn btn-sm btn-default" >삭 제</button> -->
								</span>
								<%-- <strong class="list_count" >Total : ${totalCnt} 건</strong> --%>
							</p>
						<div class="table-responsive">
						<table class="table table-bordered" id="holidayList" summary="휴일관리 목록">
							<colgroup>
								<col width="10%" />
								<col width="10%" />
								<col width="10%" />
								<col width="10%" />
								<col width="10%" />
								<col width="10%" />
							</colgroup>
							<thead>
								<tr>
									<!-- <th id="checkbox-header" data-checkbox="true"></th> -->
									<!-- <th class="visible-md visible-lg" data-align="center" data-valign="middle" data-halign="center">번호</th> -->
									<th data-align="center" data-valign="middle" data-halign="center" data-sortable="true"><span class="req-sign" style="color:red;">*</span>날짜</th>
									<th data-align="center" data-valign="middle" data-halign="center" data-sortable="true"><span class="req-sign" style="color:red;">*</span>내용</th>
									<th data-align="center" data-valign="middle" data-halign="center" data-sortable="true">비고</th>
									<th data-align="center" data-valign="middle" data-halign="center" data-sortable="true">수정자</th>
									<th data-align="center" data-valign="middle" data-halign="center" data-sortable="true">수정일</th>
									<th data-align="center" data-valign="middle" data-halign="center"></th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${empty resultList}">
										<tr>
											<td colspan="6" align="center">검색된 내용이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:set var="totalCnt" value="${fn:length(resultList)}"/>
										<c:set var="intListCnt" value="${fn:length(resultList)}"/>
										<input type="hidden" name="rowCnt" id="rowCnt" value="${totalCnt}"/>
										<c:forEach var="list" items="${resultList}" varStatus="status">
											<tr id="${list.CAL_HOL_SEQ}" class="hol_tr">
												<!-- <td></td> -->
												<%-- <th class="visible-md visible-lg text-center" style="vertical-align: middle;">${totalCnt - status.index - ((cPage-1) * (intListCnt))}</th> --%>
												<td align="center" style="vertical-align: middle;">
														<div class="tui-datepicker-input tui-datetime-input tui-has-focus form-group" style="vertical-align: middle; margin-bottom:0px; width: 130px;">
															<input type="text" id="datepicker-input-ko-${list.CAL_HOL_SEQ}" name="dt_${list.CAL_HOL_SEQ}" value="${list.CAL_HOL_DT}" aria-label="Date" class="hol_dt form-control text-center" title="date">
															<span class="tui-ico-date tui-ico-date-${list.CAL_HOL_SEQ}"></span>
														</div>
														<div class="datepicker-cell datepicker-date-ko" id="datepicker-date-${list.CAL_HOL_SEQ}"></div>
												</td> 
												<td style="vertical-align: middle;" class="form-group">
														<input type="hidden" name="seq_${list.CAL_HOL_SEQ }" id="seq_${list.CAL_HOL_SEQ }" value="${list.CAL_HOL_SEQ}" class="form-control hol_seq">
														<input type="text" name="nm_${list.CAL_HOL_SEQ }" id="nm_${list.CAL_HOL_SEQ }" value="${list.CAL_HOL_NM}" class="form-control hol_nm">
														<input type="hidden" name="mode_${list.CAL_HOL_SEQ }" id="mode_${list.CAL_HOL_SEQ }" value="<%=VarConsts.MODE_U %>" class="form-control hol_mode">
												</td>
												<td align="center" style="vertical-align: middle;">
													<input type="text" name="rmk_${list.CAL_HOL_SEQ }" id="rmk_${list.CAL_HOL_SEQ }" value="${list.CAL_HOL_RMK}" class="form-control hol_rmk">
												</td>
												<td align="center" style="vertical-align: middle;" >
													<input type="hidden" id="mod_emp_${list.CAL_HOL_SEQ }" value="${list.CAL_HOL_LST_MOD_EMP }" class="hol_mod_emp">
													${list.CAL_HOL_LST_MOD_EMP eq 'SYSTEM' ? '시스템' : list.CAL_HOL_LST_MOD_EMP_NM}
												</td>
												<td align="center" style="vertical-align: middle;">
													${list.CAL_HOL_MOD_DT}
												</td>
												<td align="center" style="vertical-align: middle;">
													<button type="button" class="fnDel btn btn-sm btn-default" onclick="fn_delHoliday('${list.CAL_HOL_SEQ}', '${list.CAL_HOL_NM}')">삭 제</button>
												</td>
												
											</tr>
										</c:forEach>
									</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					</div>
					<div class="table_foot2">
						<!-- pase nav-->
						<div class="text-center">
						<br/>
							<ul class="pagination pagination-sm">
								<%-- ${pageNavigator } --%>
							</ul>
							<span class="pull-right">
								<button type="button" class="fnJoin btn btn-sm btn-default" >저 장</button>
							</span>
						</div>
					</div>
					<div>
						</div>
					</div>
				</form>
			</div>
			<jsp:include page="/resources/com/inc/aside.jsp" />
		</section>
	</div>
	 	<jsp:include page="/resources/com/inc/footer.jsp" />
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script> --%>
	<script src="https://unpkg.com/bootstrap-table@1.19.1/dist/bootstrap-table.min.js"></script>
	<script type="text/javascript">
	
		var insRowSeq = parseInt("${maxSeq}");
		
		/*필수값 validation*/
		function fn_validation(){
			var reuslt = true;
			var trList = $(".hol_tr");
			var len = $(".hol_tr").length;
			
			for(var i=0; i< len; i++){
				var tr = trList[i];
				//시퀀스
				var seq = $(tr).find('.hol_seq');
				var seqVal = $(seq).val();
				//일자
				var dt = $(tr).find('.hol_dt');
				var dtVal = $(dt).val();
				//내용
				var nm = $(tr).find('.hol_nm');
				var nmVal = $(nm).val();
				
				/* if(seqVal == null || seqVal == ""){
					return false
				} */
				if(dtVal == null || dtVal == ""){
					alert("날짜를 선택해주세요");
					$(dt).focus();
					$(dt).closest(".form-group").addClass("has-error");
					return false
				}
				if(nmVal == null || nmVal == ""){
					alert("내용을 입력해주세요.");
					$(nm).focus();
					$(nm).closest(".form-group").addClass("has-error");
					return false
				}
			}
			return true;
		}

		/* 저장 */
			
		$( ".fnJoin" ).click(function() {
			$("#max_row_seq").val(insRowSeq);
			
			var val = fn_validation();
			if(val){
				$("#frm1").attr("action", "${pageContext.request.contextPath}/sys/cal/hol00Tran.do");
				$("#frm1").submit();
			}
		});
		
		/* 검색 */
		$( ".fnSearch" ).click(function() {
			goPage(1);
		});
		
		/* 공공데이터포털 특일정보 api를 통해 공휴일정보 동기화  */
		$(".fnLoadHol").click(function(){
			if(confirm("기존 데이터가 삭제될 수 있습니다. 업데이트를 진행하시겠습니까?")){
				$("#frm1").attr("action", "${pageContext.request.contextPath}/sys/cal/hol00Upd.do");
				$("#frm1").submit();
			}else{
				return false;
			}
			
		})
		
		
		/* 상세조회 */
// 		 function fnView(uss_id){
// 			$("#uss_id").val(uss_id);
// 			$("#frm1").attr("action", "${pageContext.request.contextPath}/uss/umt/uss00View.do");
// 			$("#frm1").submit();
// 		}
		
		function goPage(cPage){
			$("#cPage").val(cPage);
			$("#frm1").attr("action", "${pageContext.request.contextPath}/sys/cal/hol00List.do");
			$("#frm1").submit();
		}
		
		/*등록 데이터 삭제*/
		function fn_delHoliday(seq, nm){
		  	var msg = nm+"을 삭제하시겠습니까?";
		  	if(confirm(msg)){
				//alert(seq);
				$("#mode").val("DELETE");
				$("#cal_hol_seq").val(seq);
				$("#frm1").attr("action", "${pageContext.request.contextPath}/sys/cal/hol00Tran.do");
				$("#frm1").submit();
		  	}
		}
		
		/*추가 로우 삭제*/
		function fn_delRow(target){
			var msg = "행을 삭제하시겠습니까?";
			var object = $(target);
			//alert(object);
			var tr = $(object).parents('tr');
			if(confirm(msg)){
				$(tr).remove();
			}
		}
		
		// 추가
		function addRow() {
			insRowSeq++;
			
			var rowOrd = insRowSeq;
			
			//alert(rowOrd);
			var nextRows = holidayList.rows.length;
			
			// row개수 설정
			document.frm1.rowCnt.value = nextRows;
			//alert("nextRow = " +nextRows);
			
 			var oRow = holidayList.insertRow();
 			$(oRow).attr("id", rowOrd);
 			$(oRow).addClass("hol_tr");
 			oRow.onmouseover=function(){holidayList.clickedRowIndex=this.rowIndex};
			 
 			var oCell1 = oRow.insertCell(0);
 			var oCell2 = oRow.insertCell(1);
 			$(oCell2).addClass("form-group");
 			var oCell3 = oRow.insertCell(2);
 			var oCell4 = oRow.insertCell(3);
 			var oCell5 = oRow.insertCell(4);
 			var oCell6 = oRow.insertCell(5);
 			
 			var totalCnt  = "${totalCnt}";
 			//alert("totalCnt = " + totalCnt);
 			var insRowOrd = parseInt(nextRows) - parseInt(totalCnt);
 			//alert("insRowOrd = "+ insRowOrd);
 			
 			var stddYr = "${params.stdd_yr}";
 			
			
			oCell1.style.cssText = "text-align:center; vertical-align:middle;";
			oCell2.style.cssText = "text-align:center; vertical-align:middle;";
 			oCell3.style.cssText = "text-align:center; vertical-align:middle;";
 			oCell4.style.cssText = "text-align:center; vertical-align:middle;";
 			oCell5.style.cssText = "text-align:center; vertical-align:middle;";
 			oCell6.style.cssText = "text-align:center; vertical-align:middle;";
			
 			oCell1.innerHTML = '<div class="tui-datepicker-input tui-datetime-input tui-has-focus form-group" style="vertical-align: middle; margin-bottom:0px; width: 130px;">'
			                 +  '<input type="text" id="datepicker-input-ko-'+rowOrd+'" name="dt_'+rowOrd+'" value="" aria-label="Date" class="hol_dt form-control text-center" title="date">'
			                 +  '<span class="tui-ico-date tui-ico-date-'+rowOrd+'"></span>'
		                     +  '</div>'
		                     +  '<div class="datepicker-cell datepicker-date-ko" id="datepicker-date-'+rowOrd+'"></div>';
           
		   var holDtKo = new tui.DatePicker('#datepicker-date-'+rowOrd ,{
					date : new Date(),
					language : 'ko',
					date : '',
					type: 'date',
					input : {
						element : '#datepicker-input-ko-'+rowOrd,
						format : 'yyyyMMdd'
					},
					//선택 범위 : 기준년도 내
					selectableRanges: [
						[new Date(stddYr, 0, 1), new Date(stddYr, 11, 31)]
					]
				});                 
		                     
// 							 + "<input name='aprv_emp_no"+ nextRows +"_nm' id='aprv_emp_no"+ nextRows +"_nm' type='text' class='form-control table-cell input-sm' />&nbsp;"
// 							 + "<input type='button' class='btn btn-default btn-sm' value='찾기' onclick=\"fn_ussSearch('aprv_emp_no"+ nextRows +"')\" />&nbsp;&nbsp;"
// 							 + "<input type='checkbox' id='refe_yn"+ nextRows +"' name='refe_yn"+ nextRows +"' value='Y' onclick='fn_order(this)' />"
// 							 + "<label for='refe_yn"+ nextRows +"'>참조인</label>";
 			oCell2.innerHTML = '<input type="hidden" name="seq_'+rowOrd+'" id="seq_'+rowOrd+'" value="'+rowOrd+'" class="form-control hol_seq">'
 			                 + '<input type="text" name="nm_'+rowOrd+'" id="nm_'+rowOrd+'" value="" class="form-control hol_nm">'
			                 + '<input type="hidden" name="mode_'+rowOrd+'" id="mode_'+rowOrd+'" value="INSERT" class="form-control hol_mode">';
 			oCell3.innerHTML = '<input type="text" name="rmk_'+rowOrd+'" id="rmk_'+rowOrd+'" value="" class="form-control hol_rmk">'
 			oCell4.innerHTML = '${loginVO.name}';
 			oCell5.innerHTML = '';
 			oCell6.innerHTML = '<button type="button" class="fnDel btn btn-sm btn-default" onclick="fn_delRow(this)">삭 제</button>';
			
// 			var cnt = 1;
// 			for(var i = 1; i < aprv_line.rows.length; i++) {
// 				if($("#refe_yn"+i).is(":checked")){
// 				}else{
// 					aprv_line.rows[i].cells[1].innerHTML = "<input name='aprv_ordr"+ i +"' id='aprv_ordr"+ i +"' value='"+ cnt +"' type='text' class='form-control input-sm' readonly />";
// 					cnt++;
// 				}
// 			}
		}
		
	
		/*sub_menu 탭*/
		$(function(){
			
			//$("#holidayList").bootstrapTable();
			
			var today = new Date();
			var thisYr = today.getFullYear(); 
			var nextYr = thisYr + 1;
			var stddYr = "${params.stdd_yr}";
			
			
			//년도 캘린더 만들기
			calYearKo = new tui.DatePicker('#datepicker-year-ko',{
				date : new Date(),
				language : 'ko',
				date : "${params.stdd_yr}",
				type: 'year',
				input : {
					element : '#datepicker-input-ko',
					format : 'yyyy'
				},
				//2015년도 부터 금년도 다음 해까지 범위 설정
				selectableRanges: [
					[new Date(2015, 0, 1), new Date(nextYr, 11, 31)]
				]
			});
			
			calYearKo.on('change', () =>{
				goPage(1);
			});
			
			//var resultListStr = ${resultList};
			
			var resultList = ${jsonList};
			
			//날짜 datepicker 생성
			for(var i = 0; i < resultList.length; i++){
				
				var result = resultList[i];
				
				var seq = result.CAL_HOL_SEQ;
				var dt = result.CAL_HOL_DT;
				
				//var datepickerid = "date"
				
				var holDtKo = new tui.DatePicker('#datepicker-date-'+seq ,{
					date : new Date(),
					language : 'ko',
					date : dt,
					type: 'date',
					input : {
						element : '#datepicker-input-ko-'+seq,
						format : 'yyyyMMdd'
					},
					//선택 범위 : 기준년도 내
					selectableRanges: [
						[new Date(stddYr, 0, 1), new Date(stddYr, 11, 31)]
					]
				});
				
			}
			
			$("article.sub_contents:not("+$("ul.tab_gnb li a.sub_nav_on").attr("href")+")").hide()
			$("ul.tab_gnb li a").click(function(){
				$("ul.tab_gnb li a").removeClass("sub_nav_on");
				$(this).addClass("sub_nav_on");
				$("article.sub_contents").hide();
				$($(this).attr("href")).show();
				return false;
			});
			
			$("input").on('click', function(e){
				var trgt = e.target;
				$(trgt).closest(".has-error").removeClass("has-error");
			})
		});

	</script>
</body>
</html>