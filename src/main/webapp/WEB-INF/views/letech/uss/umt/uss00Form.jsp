<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
<jsp:include page="/resources/com/inc/meta.jsp" />
<title>Letech Intranet</title>
<link href="${pageContext.request.contextPath}/resources/js/css/ui-lightness/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" >
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
<link href="${pageContext.request.contextPath}/resources/js/css/ui-lightness/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" >
</head>
<body>
	<div id="warpper">
		<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
			<jsp:include page="/resources/com/inc/header.jsp" />
			<%@ include file="/WEB-INF/views/letech/com/layout/menu.jsp" %>
		</nav>
		<div id="page-wrapper">
			<section class="clearfix">
				<div class="col-lg-10">
					<!-- 타이틀 및 페이지 네비 -->
						<h2 class="page-title clearfix">
								${titleNaviMap.MN_NM }
								<span class="pull-right site-map">
									HOME > ${titleNaviMap.NAVI_NM }
								</span>
							</h2>
					<div class="form-container">
					<div class="board-view">
						<form name="frm1" id="frm1" method="post" action="${pageContext.request.contextPath}/uss/umt/list.do" >
							<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}"/>
							<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}"/>
							<input type="hidden" name="id_check" id="id_check" value="" />
							<input type="hidden" id="mode" name="mode" value="${params.mode }" />
							<input type="hidden" id="joinType" name="joinType" value="${joinType }" />
							<input type="hidden" id="bir_cal_seq" name="bir_cal_seq" value="${resultView.BIR_CAL_SEQ}" />
							
							<div class="row">
								<ul class="col-md-12">
									<li class="form-group col-md-6">
											<label>사용자 ID</label>
																							<c:set var="modeType" value="<%=VarConsts.MODE_U%>"/>
													<c:choose>
														<c:when test="${params.mode eq modeType }">
															<br/><span class="">${resultView.USS_ID }</span>
															<input type="hidden" id="uss_id" name="uss_id" class="form-control" value="${params.uss_id }" />
															<input type="hidden" id="emp_no" name="emp_no" class="form-control" value="${params.uss_id }" />
														</c:when>
														<c:otherwise>
															<div class="input-group">
																<input name="uss_id" id="uss_id" type="text" value="" class="form-control" />
																<a href="#" class="btn_usrChk input-group-addon">중복체크</a>
															</div>
															<span class="clearfix" id="id_check_text"></span>
														</c:otherwise>
													</c:choose>
										</li>
										<li class="form-group col-md-6">
												<label>성명</label>
													<input name="uss_nm" id="uss_nm" type="text" value="${resultView.USS_NM }" class="form-control" />
										</li>
								</ul>
							</div>
							<!-- <div class="row">
								<ul class="col-md-12">
								
								</ul>
							</div> -->
							
							<div class="row">
								<ul class="col-md-12">
									<li class="form-group col-md-6">
										<label>비밀번호</label>
										<input name="uss_pwd" id="uss_pwd" type="password" value="" class="form-control" />
									</li>
									<li class="form-group col-md-6">
										<label class=" ">비밀번호확인</label>
											<input name="uss_pwd_conf" id="uss_pwd_conf" type="password" value=""  class="form-control" />
									</li>								
								</ul>
							</div>
							
							<div class="row">
								<ul class="col-md-12">
									<li class="form-group col-md-6">
										<label>부서</label>
										<select id="dp_cd" name="dp_cd" class="form-control">
											<option value="" >--선택--</option>
											<c:forEach var="departList" items="${departList}">
												<option value="${departList.DP_CD}" <c:if test="${departList.DP_CD eq resultView.DP_CD }">selected="selected"</c:if> >${departList.DP_NM}</option>
											</c:forEach>
										</select>
									</li>
									<li class="form-group col-md-6">
										<label>사원번호</label>
										<div class="input-group">
											<input name="uss_em_no" id="uss_em_no" type="text" value="" class="form-control" />
											<a class="btn_emnoChk input-group-addon" href="#">중복체크</a>
										</div>
										<span id="emno_check_text" ></span>
									</li>
								</ul>
							</div>
							<div class="row">
								<ul class="col-md-12">
									<!-- 고용구분  -->
									<li class="form-group col-md-6">
										<label>고용구분</label>
										<select id="emp_type" name="emp_type" class="form-control">
											<option value="" >--선택--</option>
											<c:forEach var="empType" items="${empTypeList}">
												<option value="${empType.CD}" <c:if test="${empType.CD eq resultView.EMP_TYPE }">selected="selected"</c:if> >${empType.CD_NM}</option>
											</c:forEach>
										</select>
									</li>
									<li class="form-group col-md-6">
										<label>권한</label>
										<select id="uss_auth_cd" name="uss_auth_cd" class="form-control">
						          			<option value="" >--선택--</option>
											<c:forEach var="authList" items="${authList}">
												<option value="${authList.AUTHOR_CODE}" <c:if test="${resultView.USS_AUTH_CD eq authList.AUTHOR_CODE }">selected="selected"</c:if> >${authList.AUTHOR_NM}</option>
											</c:forEach>
										</select>
									</li>
								</ul>
							</div>
							<div class="row">
								<ul class="col-md-12">
									<li class="form-group col-md-6">
										<label>전화번호</label><br/>
										<span class="form-inline">
										<input name="uss_tel1" id="uss_tel1" type="text" value="${resultView.USS_TEL1 }"  class="form-control table-cell"/>
										-
										<input name="uss_tel2" id="uss_tel2" type="text" value="${resultView.USS_TEL2 }"  class="form-control table-cell"/>
										-
										<input name="uss_tel3" id="uss_tel3" type="text" value="${resultView.USS_TEL3 }" class="form-control table-cell"/>
										</span>
									</li>
									<li class="form-group col-md-6">
										<label>이메일</label>
										<input name="uss_email" id="uss_email" type="text" value="${resultView.USS_EMAIL }"  class="form-control" />
									</li>
								</ul>
							</div>
							<div class="row">
								<ul class="col-md-12">
									<!-- 입사일  -->
									<li class="form-group col-md-6">
										<label>입사일</label>
										<input name="join_dt" id="join_dt" type="text" value="${resultView.JOIN_DT }" class="form-control" />
									</li>
									<li class="form-group col-md-6">
										<label>생년월일</label>
										<input name="uss_birth" id="uss_birth" type="text" value="${resultView.USS_BIRTH }" class="form-control" />
									</li>
								</ul>
							</div>
							<div class="row">
								<ul class="col-md-12">
									<!-- 근속년수  -->
									<li class="form-group col-md-6">
										<label>근속년수</label>
										<input name="work_yr_cnt" id="work_yr_cnt" type="number" min="0" value="${resultView.WORK_YR_CNT }" class="form-control" oninput="this.value = this.value.replace(/[^0-9]/g, '')" />
									</li>
									<c:if test="${params.mode eq VarConsts.MODE_U}">
										<li class="form-group col-md-6" id="rtr_yn_select">
											<label>재직구분</label>
											<select id="rtr_yn" name="rtr_yn" class="form-control" onchange="javascript:fn_showRtrDt(this.value)" >
												<option value="N" <c:if test="${empty resultView.RTR_YN || 'N' eq resultView.RTR_YN }">selected="selected"</c:if>>재직중</option>
												<option value="Y" <c:if test="${'Y' eq resultView.RTR_YN }">selected="selected"</c:if>>퇴사</option>
											</select>
										</li>
									</c:if>
								</ul>
							</div>
							<div class="row">
								<ul class="col-md-12">
								<c:if test="${params.mode eq VarConsts.MODE_U}">
									<li class="form-group col-md-6">
										<label>퇴사일</label>
										<input name="rtr_dt" id="rtr_dt" type="text" value="${resultView.RTR_DT }" class="form-control" disabled />
									</li>
									<!-- 퇴사사유 : 수정 화면에서 퇴사구분을 퇴사로 선택했을 시 표시  -->
									<li class="form-group col-md-6">
										<label>퇴사사유</label>
										<select id="rtr_rsn" name="rtr_rsn" class="form-control" disabled>
											<option value="" >--선택--</option>
											<c:forEach var="rtrRsn" items="${rtrRsnList}">
												<option value="${rtrRsn.CD}" <c:if test="${rtrRsn.CD eq resultView.RTR_RSN }">selected="selected"</c:if> >${rtrRsn.CD_NM}</option>
											</c:forEach>
										</select>
									</li>
								</c:if>	
								</ul>
							</div>
							<div class="row">
								<ul class="col-md-12">
									<li class="form-group col-md-6">
										<label>성별</label><br/>
										<span class="col-md-12">
											<input class="col_md_2" name="uss_sex" id="uss_sex_m" type="radio" value="M" <c:if test="${empty resultView.USS_SEX || resultView.USS_SEX eq 'M' }">checked="checked"</c:if>>
											남자
											<input class="col_md_2"  name="uss_sex" id="uss_sex_w" type="radio" value="W" <c:if test="${resultView.USS_SEX eq 'W' }">checked="checked"</c:if> >
											여자
										</span>
									</li>
									<!-- 생일 : 월 , 일 , 음/양력 구분  -->
									<li class="form-group col-md-6">
										<label>생일</label>
										<br/>
										<span class="col-md-12">
											<input class="col_md_2 table-cell" name="uss_birth_day_type" id="uss_birth_day_type_s" type="radio" value="S" <c:if test="${empty resultView.USS_BIRTH_DAY_TYPE || resultView.USS_BIRTH_DAY_TYPE eq 'S' }">checked="checked"</c:if>>
											양력
											<input class="col_md_2 table-cell"  name="uss_birth_day_type" id="uss_birth_day_type_l" type="radio" value="L" <c:if test="${resultView.USS_BIRTH_DAY_TYPE eq 'L' }">checked="checked"</c:if> >
											음력
										</span>
										<span class="col-md-12">
										<select id="uss_birth_day_mon" name="uss_birth_day_mon" class="form-control table-cell">
											<option value="" >--선택--</option>
											<option value="01" >01</option>
											<option value="02" >02</option>
											<option value="03" >03</option>
											<option value="04" >04</option>
											<option value="05" >05</option>
											<option value="06" >06</option>
											<option value="07" >07</option>
											<option value="08" >08</option>
											<option value="09" >09</option>
											<option value="10" >10</option>
											<option value="11" >11</option>
											<option value="12" >12</option>
											<option value="12" >12</option>
										</select>
										<label>월</label>
										<select id="uss_birth_day_date" name="uss_birth_day_date" class="form-control table-cell">
											<option value="" >--선택--</option>
											<option value="01" >01</option>
											<option value="02" >02</option>
											<option value="03" >03</option>
											<option value="04" >04</option>
											<option value="05" >05</option>
											<option value="06" >06</option>
											<option value="07" >07</option>
											<option value="08" >08</option>
											<option value="09" >09</option>
											<option value="10" >10</option>
											<option value="11" >11</option>
											<option value="12" >12</option>
											<option value="13" >13</option>
											<option value="14" >14</option>
											<option value="15" >15</option>
											<option value="16" >16</option>
											<option value="17" >17</option>
											<option value="18" >18</option>
											<option value="19" >19</option>
											<option value="20" >20</option>
											<option value="21" >21</option>
											<option value="22" >22</option>
											<option value="23" >23</option>
											<option value="24" >24</option>
											<option value="25" >25</option>
											<option value="26" >26</option>
											<option value="27" >27</option>
											<option value="28" >28</option>
											<option value="29" >29</option>
											<option value="30" >30</option>
											<option value="31" >31</option>
										</select>
										<label>일</label>
										</span>
									</li>
								</ul>
							</div>
							<div class="row">
								<ul class="col-md-12">
									<li class="form-group col-md-12">
										<label>사용자 서명</label><br>
										<img src="${pageContext.request.contextPath}/doc/sign.do?emp_no=${params.uss_id }" style="width: 140px; max-height: 70px;">
										<br>
										<input class="input-group" name="uss_sign" id="uss_sign" accept="image/png" type="file" onChange="fileCheck(this)"/>
									</li>
								</ul>
							</div>
							<div class="clearfix">
								<hr>
								<div class="form-group">
									<label>결재라인</label>
									<table class="table table-bordered text-center">
										<colgroup>
											<col width="10%"/>
											<col width="10%"/>
											<col width="20%"/>
											<col width="40%"/>
											<col width="10%"/>
											<col width="10%"/>
										</colgroup>
										<tr class="active">
											<th class="text-center">순서</th>
											<th class="text-center">순번</th>
											<th class="text-center">이름</th>
											<th class="text-center">부서명/직급</th>
											<th class="text-center">참조인</th>
											<th class="text-center">삭제</th>
										</tr>
										<c:forEach items="${lineInfoList }" var="lineInfo">
											<tr class="lineInfoList">
												<td>
													<input type="hidden" class="aprv_emp_no_list" id="aprv_emp_no_${lineInfo.APRV_ORDR }" name="aprv_emp_no_${lineInfo.APRV_ORDR }" value="${lineInfo.APRV_EMP_NO }"/>
													<input type="hidden" class="aprv_ordr_list" id="aprv_ordr_${lineInfo.APRV_ORDR }" name="aprv_ordr_${lineInfo.APRV_ORDR }" value="${lineInfo.APRV_ORDR }">
													<button type="button" class="btn btn-default btn-xs" onClick="fn_upOrdr(this);">
														<span class="glyphicon glyphicon-menu-up"></span>
													</button>
													<button type="button" class="btn btn-default btn-xs" onClick="fn_downOrdr(this);">
														<span class="glyphicon glyphicon-menu-down"></span>
													</button>
												</td>
												<td class="aprv_ordr_list_val">
													${lineInfo.APRV_ORDR }
												</td>
												<td>
													${lineInfo.APRV_EMP_NM }
												</td>
												<td>
													${lineInfo.CD_NM } / ${lineInfo.AUTHOR_NM }
												</td>
												<td>
													<input type="checkbox" value="Y" class="refe_yn_list" id="refe_yn_${lineInfo.APRV_ORDR }" name="refe_yn_${lineInfo.APRV_ORDR }" <c:if test="${lineInfo.REFE_YN == 'Y'}">checked</c:if>/>
												</td>
												<td>
													<button type="button" class="btn btn-default btn-xs" onClick="fn_deleteLine(this);">
														<span class="glyphicon glyphicon-trash"></span> 삭제
													</button>
												</td>
											</tr>
										</c:forEach>
										<tr id="trAddLine">
											<td colspan="7">
												<button type="button" class="btn btn-default btn-xs" onClick="fn_addLine();">
													<span class="glyphicon glyphicon-plus"></span> 추가
												</button>
											</td>
										</tr>
									</table>
								</div>
							    <span class="pull-right">
							    	<input  class="btn-ok btn btn btn-sm btn-info" type="button" value="저장" />
							    	<input class="btn-cancel btn btn-sm btn-default"  type="button" value="취소" />
								</span>
							</div>	
						</form>
					</div>
					</div>
				</div>
				<jsp:include page="/resources/com/inc/aside.jsp" />
			</section>
		</div>
		<jsp:include page="/resources/com/inc/footer.jsp" />
	</div>
	<form id="ussFrm" name="ussFrm" method="post" action="${pageContext.request.contextPath}/uss/umt/uss00Popup.do" >
		<input type="hidden" id="not_uss_id" name="not_uss_id" value="" />
	</form>
	<!-- js파일 및 공통스크립트사용 -->
	<jsp:include page="/resources/com/inc/javascript.jsp" />
	<script type="text/javascript">
		$(function() {
			$("#uss_birth").datepicker();
			$("#join_dt").datepicker();
			var birthday = null;
			var mon = "";
			var day = "";
			var birthDayArr = null;
			
			birthday = "${resultView.USS_BIRTH_DAY}";

			if(birthday != null && "" != birthday){
				birthDayArr = birthday.split("-");
				mon = birthDayArr[0];
				day = birthDayArr[1];		
			}
			
			$("#uss_birth_day_mon").val(mon).prop("selected", true);
			
			$("#uss_birth_day_date").val(day).prop("selected", true);
			
			//재직구분이 퇴사 일 경우 퇴사일, 퇴사사유 항목 활성화 
			var rtrYn = null;
			rtrYn = "${resultView.RTR_YN}";
			if(rtrYn != null && rtrYn == "Y"){
				$("#rtr_dt").prop("disabled", false);
				$("#rtr_rsn").prop("disabled", false);
				$("#rtr_dt").datepicker();
			}
			
		});
		
		$(document).ready(function() {
			/* 저장 */	
			$( ".btn-ok" ).click(function() {
				if(getValidation()){
					if($("#mode").val() == "<%=VarConsts.MODE_U%>"){
					}else{
						$("#mode").val("<%=VarConsts.MODE_I%>");	
					}
					$.ajax({
						url: "${pageContext.request.contextPath}/uss/umt/uss00Tran.do",
						type: "post",
						enctype: 'multipart/form-data',
						processData: false,
						contentType: false,
						data : new FormData($("#frm1")[0]),
						success: function(result){
							var url_val = "";
							fn_goPage();
						},error: function (request, status, error) {
							alert(request.responseText);
						} 
					});
				}
			});
			
			/* 취소 */
			$( ".btn-cancel" ).click(function() {
				if($("#mode").val() == "<%=VarConsts.MODE_U%>"){
					/* 수정 폼일경우 상세화면으로 이동 */
					$("#frm1").attr("action", "${pageContext.request.contextPath}/uss/umt/uss00View.do");
					$("#frm1").submit();
					
				}else{
					/* 입력 폼일경우 목록화면으로 이동 */
					$("#frm1").attr("action", "${pageContext.request.contextPath}/uss/umt/uss00List.do");
					$("#frm1").submit();	
				}
			});
			
			/* ID중복체크 */
			$(".btn_usrChk").click(function() {
				var uss_id = $("#uss_id").val();
				if(uss_id == ""){
					alert("사용자ID를 입력하세요.");
				}else{
					$.ajax({
						url: "${pageContext.request.contextPath}/uss/umt/uss00Ajax.do",
						type: "post",
						dataType : "json", 
						data : {"uss_id":uss_id},
						success: function(result){
							if(result.id_check == "Y"){
								$("#id_check").val(result.id_check);
								$("#id_check_text").html("사용 가능한 ID입니다");
								$("#id_check_text").css("color", "red");
							}else{
								$("#id_check_text").html("사용 불가능한 ID입니다");
								$("#id_check_text").css("color", "red");
							}
						},error: function (request, status, error) {
							alert(request.responseText);
						} 
					});
				}
			});
			
			/* 사원번호중복체크 */
			$(".btn_emnoChk").click(function() {
				var uss_em_no = $("#uss_em_no").val();
				if(uss_em_no == ""){
					alert("사원번호를 입력하세요.");
				}else{
					$.ajax({
						url: "${pageContext.request.contextPath}/uss/umt/uss01Ajax.do",
						type: "post",
						dataType : "json", 
						data : {"uss_em_no":uss_em_no},
						success: function(result){
							if(result.emno_check == "Y"){
								$("#emno_check").val(result.emno_check);
								$("#emno_check_text").html("사용 가능한 사원번호입니다");
								$("#emno_check_text").css("color", "red");
							}else{
								$("#emno_check_text").html("사용 불가능한 사원번호입니다");
								$("#emno_check_text").css("color", "red");
							}
						},error: function (request, status, error) {
							alert(request.responseText);
						} 
					});
				}
			});
		});
			
		function getValidation(){
			if($("#mode").val() == "<%=VarConsts.MODE_U%>"){
				/* 수정 폼일경우 */
				if($("#uss_pwd").val() == ""){
					
				}else{
					/* 비밀번호 수정할 경우 (비밀번호를 입력할 경우) */
					if($("#uss_pwd_conf").val() == ""){
						alert("비밀번호 확인을 입력해 주세요.");
						$("#uss_pwd_conf").focus();
						return false;
					}
					
					if($("#uss_pwd").val() != $("#uss_pwd_conf").val()){
						alert("비밀번호와 비밀번호 확인이 틀립니다.\n다시 입력해 주세요.");
						$("#uss_pwd_conf").focus();
						return false;
					}
				}
				
			}else{
				/* 입력 폼일경우 */
				if($("#uss_id").val() == ""){
					alert("ID를 입력해 주세요.");
					$("#uss_id").focus();
					return false;
				}
				
				if($("#id_check").val() == "Y"){
				}else{
					alert("사용 불가능한 ID입니다. 다시 입력해 주세요.");
					$("#uss_id").focus();
					return false;
				}
				
				if($("#id_check").val() == ""){
					alert("ID 중복체크를 주세요.");
					$("#uss_id").focus();
					return false;
				}
				
				if($("#uss_pwd").val() == ""){
					alert("비밀번호를 입력해 주세요.");
					$("#uss_pwd").focus();
					return false;
				}
				
				if($("#uss_pwd_conf").val() == ""){
					alert("비밀번호 확인을 입력해 주세요.");
					$("#uss_pwd_conf").focus();
					return false;
				}
				
				if($("#uss_pwd").val() != $("#uss_pwd_conf").val()){
					alert("비밀번호와 비밀번호 확인이 틀립니다.\n다시 입력해 주세요.");
					$("#uss_pwd_conf").focus();
					return false;
				}
			}
			//성명
			if($("#uss_nm").val() == ""){
				alert("성명을 입력해 주세요.");
				$("#uss_nm").focus();
				return false;
			}
			//부서
			if($("#dp_cd").val() == ""){
				alert("부서를 선택해 주세요.");
				$("#dp_cd").focus();
				return false;
			}
			
			//권한
			if($("#uss_auth_cd").val() == ""){
				alert("권한을 선택해 주세요.");
				$("#uss_auth_cd").focus();
				return false;
			}
			//전화번호
			if($("#uss_tel1").val() != "" || $("#uss_tel2").val() != "" || $("#uss_tel3").val() != ""){
				if($("#uss_tel1").val() != "" && !$.isNumeric($("#uss_tel1").val()) ){
					alert("숫자 형식으로 입력하세요");
					$("#uss_tel1").focus();
					return false;
				}else if($("#uss_tel2").val() != "" && !$.isNumeric($("#uss_tel2").val()) ){
					alert("숫자 형식으로 입력하세요");
					$("#uss_tel2").focus();
					return false;
				}else if($("#uss_tel3").val() != "" && !$.isNumeric($("#uss_tel3").val()) ){
					alert("숫자 형식으로 입력하세요");
					$("#uss_tel3").focus();
					return false;
				}else{
					if(!fnPhoneCheck($("#uss_tel1").val()+""+$("#uss_tel2").val()+""+$("#uss_tel3").val())){
						alert("전화번호가 유효하지 않습니다.");
						return false;
					}
				}
			}
			//이메일	
			if($("#uss_email").val() != ""){
				if(!fnEmailCheck($("#uss_email").val())){
					alert('이메일 주소가 유효하지 않습니다');
					return false;
				}
			}
			
			/*항목추가에 따른 validation 추가 - 2022.01.05 : BEGIN*/
			//고용구분
			if($("#emp_type").val() == ""){
				alert("고용구분을 선택해 주세요.");
				$("#emp_type").focus();
				return false;
			}
			
			//입사일
			if($("#join_dt").val() == ""){
				alert("입사일을 선택 또는 입력해 주세요.");
				$("#join_dt").focus();
				return false;
			}
			
			//근속년수
			if($("#work_yr_cnt").val() == ""){
				alert("근속년수를 입력해 주세요.");
				$("#work_yr_cnt").focus();
				return false;
			}
			
			//생일
			if($("#uss_birth_day_mon").val() == ""){
				alert("생일(월)을 선택해 주세요.");
				$("#uss_birth_day_mon").focus();
				return false;
			}
			if($("#uss_birth_day_date").val() == ""){
				alert("생일(일)을 선택해 주세요.");
				$("#uss_birth_day_date").focus();
				return false;
			}
			/*항목추가에 따른 validation 추가 - 2022.01.05 : END*/
			
			
			return true;
		}
			
		function fn_goPage(){
			if($("#mode").val() == "<%=VarConsts.MODE_U%>"){
				/* 수정 폼일 경우 */
				alert("사용자가 저장되었습니다.");
				url_val = "${pageContext.request.contextPath}/uss/umt/uss00View.do";
				$("#uss_pwd").val("");
			}else{
				/* 등록 폼일 경우 */
				alert("사용자가 등록되었습니다.");
				if($("joinType").val() == "Y"){
					// 회원가입일경우(로그인 화면으로)
					url_val = "${pageContext.request.contextPath}/uat/uia/egovLoginUsr.do";
				}else{
					// 사용자 관리에서 사용자 등록일경우
					url_val = "${pageContext.request.contextPath}/uss/umt/uss00List.do";	
				}	
			}
			$("#frm1").attr("action", url_val);
			$("#frm1").submit();
		}
		
		// 결재라인 tr 위로 이동
		function fn_upOrdr(clickedBtn) {
			var clickedTr = $(clickedBtn).context.closest(".lineInfoList"); // 클릭한 tr
			var lineInfoList = $(".lineInfoList"); // 결재라인 전체 tr 배열
			
			$(lineInfoList).each(function(idx, obj) { // 결재라인 전체 tr 반복문
				if(clickedTr == obj) { // 클릭한 tr인 경우
					if(idx == 0) { // 이미 첫번째인 경우
						alert("첫번째 입니다.");
					} else {
						lineInfoList[idx - 1].before(obj);
						fn_changeOrdr();
					}
				}
			});
		}
		
		// 결재라인 tr 아래로 이동
		function fn_downOrdr(clickedBtn) {
			var clickedTr = $(clickedBtn).context.closest(".lineInfoList"); // 클릭한 tr
			var lineInfoList = $(".lineInfoList"); // 결재라인 전체 tr 배열
			
			$(lineInfoList).each(function(idx, obj) { // 결재라인 전체 tr 반복문
				if(clickedTr == obj) { // 클릭한 tr인 경우
					if(idx == lineInfoList.size()-1) { // 이미 첫번째인 경우
						alert("마지막 입니다.");
					} else {
						lineInfoList[idx + 1].after(obj);
						fn_changeOrdr();
					}
				}
			});
		}
		
		// 결재라인 추가
		function fn_addLine() {
			window.open("", "uss00Popup","width=1300, height=750");
			$("#ussFrm").attr("target", "uss00Popup");
			$("#ussFrm").attr("action", "${pageContext.request.contextPath}/search/uss00Popup.do");
			$("#ussFrm").submit();
		}
		function setUssForm(id, nm, auth_nm, dept_nm){
			var check = true;
			$(".lineInfoList").each(function(idx, obj) {
				if($(obj).find(".aprv_emp_no_list").val() == id) {
					alert("이미 결재라인에 존재합니다.");
					check = false;
				}
			});
			if($("#uss_id").val() == id) {
				alert("사용자와 결재 대상이 같습니다.");
				check = false;
			}
			if(check) {
				var nextSeq = $(".lineInfoList").size() + 1;
				var html = "";
				html += '<tr class="lineInfoList">';
				html += '	<td>';
				html += '		<input type="hidden" class="aprv_emp_no_list" id="aprv_emp_no_' + nextSeq + '" name="aprv_emp_no_' + nextSeq + '" value="' + id + '"/>';
				html += '		<input type="hidden" class="aprv_ordr_list" id="aprv_ordr_' + nextSeq + '" name="aprv_ordr_' + nextSeq + '" value="' + nextSeq + '">';
				html += '		<button type="button" class="btn btn-default btn-xs" onClick="fn_upOrdr(this);">';
				html += '			<span class="glyphicon glyphicon-menu-up"></span>';
				html += '		</button>';
				html += '		<button type="button" class="btn btn-default btn-xs" onClick="fn_downOrdr(this);">';
				html += '			<span class="glyphicon glyphicon-menu-down"></span>';
				html += '		</button>';
				html += '	</td>';
				html += '	<td class="aprv_ordr_list_val">';
				html += '		' + nextSeq;
				html += '	</td>';
				html += '	<td>';
				html += '		' + nm;
				html += '	</td>';
				html += '	<td>';
				html += '		' + dept_nm + ' / ' + auth_nm;
				html += '	</td>';
				html += '	<td>';
				html += '		<input type="checkbox" value="Y" class="refe_yn_list" id="refe_yn_' + nextSeq + '" name="refe_yn_' + nextSeq + '"/>';
				html += '	</td>';
				html += '	<td>';
				html += '		<button type="button" class="btn btn-default btn-xs" onClick="fn_deleteLine(this);">';
				html += '			<span class="glyphicon glyphicon-trash"></span> 삭제';
				html += '		</button>';
				html += '	</td>';
				html += '</tr>';
				$("#trAddLine").before(html);
			}
		}
		
		// 결재라인 삭제
		function fn_deleteLine(clickedBtn) {
			var clickedTr = $(clickedBtn).context.closest(".lineInfoList"); // 클릭한 tr
			clickedTr.remove();
			fn_changeOrdr();
		}
		
		// 결재라인 순번 새로 매기기
		function fn_changeOrdr() {
			var lineInfoList = $(".lineInfoList"); // 결재라인 전체 tr 배열
			$(lineInfoList).each(function(idx, obj) {
				// 순번 input, td 값 변경
				$(obj).find(".aprv_ordr_list").val(idx + 1);
				$(obj).find(".aprv_ordr_list_val").text(idx + 1);
				
				// form input 값 변경
				$(obj).find(".aprv_emp_no_list").prop("id", "aprv_emp_no_" + (idx + 1));
				$(obj).find(".aprv_emp_no_list").prop("name", "aprv_emp_no_" + (idx + 1));
				$(obj).find(".aprv_ordr_list").prop("id", "aprv_ordr_" + (idx + 1));
				$(obj).find(".aprv_ordr_list").prop("name", "aprv_ordr_" + (idx + 1));
				$(obj).find(".refe_yn_list").prop("id", "refe_yn_" + (idx + 1));
				$(obj).find(".refe_yn_list").prop("name", "refe_yn_" + (idx + 1));
			});
		}
		
		function fileCheck(obj) {
			var pathpoint = obj.value.lastIndexOf('.');
			var filepoint = obj.value.substring(pathpoint + 1, obj.length);
			var filetype = filepoint.toLowerCase();
			if(filetype != 'png') {
				if(obj.value != "") {
					alert("png형식의 이미지 파일만 선택하세요.");
					$(obj).val("");
					return false;
				}
			}
		}
		
		//재직구분 선택에 따라 퇴사일, 퇴사사유 옵션 활성/비활성화
		function fn_showRtrDt(val) {
			var value = val;
			//퇴사 선택 시
			if(value == "Y"){
				$("#rtr_dt").prop("disabled", false);
				$("#rtr_rsn").prop("disabled", false);
				$("#rtr_dt").datepicker();
			}else if(value = "N"){ // 재직 선택 시
				$("#rtr_dt").val("");
				$("#rtr_rsn").val("");
				$("#rtr_dt").prop("disabled", true);
				$("#rtr_rsn").prop("disabled", true);
			}	
			
		}
		
	</script>
</body>
</html>