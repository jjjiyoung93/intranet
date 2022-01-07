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
			<section class="row">
				<!-- 타이틀 및 페이지 네비 -->
				<div class="col-lg-10">
					<h2 class="page-title clearfix">
							정보수정
							<span class="pull-right site-map">
								HOME > 정보수정
							</span>
						</h2>
					<div class="form-container">
					<form name="frm1" id="frm1" method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/index.do" >
						<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}"/>
						<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}"/>
						<input type="hidden" name="id_check" id="id_check" value="" />
						<input type="hidden" id="mode" name="mode" value="${params.mode }" />
						<input type="hidden" id="joinType" name="joinType" value="${joinType }" />
						<input type="hidden" id="uss_auth_cd" name="uss_auth_cd" value="${resultView.USS_AUTH_CD}"/>
							<div class="board-view">
								<div class="row">
								<ul class="col-md-6">
									<li>
										<dl class="row first-line">
											<dt class="col-md-3 col-sm-3">부서</dt>
											<dd class="col-md-9 col-sm-9">
												<input name="dp_cd" id="dp_cd" type="hidden" value="${resultView.DP_CD }" />
												<c:forEach var="departList" items="${departList}">
													<c:if test="${departList.DP_CD eq resultView.DP_CD }">
														<input type="text" value="${departList.DP_NM}" class="form-control form-group" readonly/>
													</c:if>
												</c:forEach>
											</dd>
										</dl>
									</li>
									<li>
										<dl class="row ">
											<dt class="col-md-3 col-sm-3">성명</dt>
											<dd class="col-md-9 col-sm-9">
												<input name="uss_nm" id="uss_nm" type="text" class="form-control form-group" value="${resultView.USS_NM }" readonly/>
											</dd>
										</dl>
									</li>
									<li>
										<dl class="row ">
											<dt class="col-md-3 col-sm-3">비밀번호</dt>
											<dd class="col-md-9 col-sm-9 ">
												<div class="form-group">
													<input name="uss_pwd" id="uss_pwd" type="password" value="" class="form-control" />
												</div>
											</dd>
										</dl>
									</li>
									<li>
										<dl class="row ">
											<dt class="col-md-3 col-sm-3">전화번호</dt>
											<dd class="col-md-9 col-sm-9">
												<div class="form-inline form-group" >
													<input name="uss_tel1" id="uss_tel1" type="text" value="${resultView.USS_TEL1 }"  class="i_text form-control table-cell"/>
														-
														<input name="uss_tel2" id="uss_tel2" type="text" value="${resultView.USS_TEL2 }"  class="i_text form-control table-cell"/>
														-
													<input name="uss_tel3" id="uss_tel3" type="text" value="${resultView.USS_TEL3 }" class="i_text form-control table-cell"/>
												</div>
											</dd>
										</dl>
									</li>
									<li>
										<dl class="row ">
											<dt class="col-md-3 col-sm-3">입사일</dt>
											<dd class="col-md-9 col-sm-9">
												<input name="join_dt" id="join_dt" type="text" value="${resultView.JOIN_DT }" class="form-control form-group" readonly />
											</dd>
										</dl>
									</li>
									<li>
										<dl class="row ">
											<dt class="col-md-3 col-sm-3">생년월일</dt>
											<dd class="col-md-9 col-sm-9">
												<div class="form-group">
													<span class="col-md-12">
														<input class="col_md_2" name="uss_sex" id="uss_sex_m" type="radio" value="M" <c:if test="${empty resultView.USS_SEX || resultView.USS_SEX eq 'M' }">checked="checked"</c:if> disabled>
														남자
														<input class="col_md_2"  name="uss_sex" id="uss_sex_w" type="radio" value="W" <c:if test="${resultView.USS_SEX eq 'W' }">checked="checked"</c:if> disabled>
														여자
													</span>
												</div>
											</dd>
										</dl>
									</li>
									
								</ul>
								<ul class="col-md-6">
									<li>
										<dl class="row ">
											<dt class="col-md-3 col-sm-3">직급(권한)</dt>
											<dd class="col-md-9 col-sm-9">
												<input name="uss_auth_cd" id="uss_auth_cd" type="text" class="form-control form-group" value="${resultView.USS_AUTH_NM }" readonly/>
											</dd>
										</dl>
									</li>
									<li>
										<dl class="row">
											<dt class="col-md-3 col-sm-3">사용자 ID</dt>
											<dd class="col-md-9 col-sm-9">
												<input type="text" value="${resultView.USS_ID }" class="form-control form-group" readonly/>
												<input type="hidden" id="uss_id" name="uss_id" value="${params.uss_id }" />
												<input name="uss_sex" id="uss_sex" type="hidden" value="${resultView.USS_SEX }"/>
											</dd>
										</dl>
									</li>
									<li>
										<dl class="row ">
											<dt class="col-md-3 col-sm-3">비밀번호 확인</dt>
											<dd class="col-md-9 col-sm-9 ">
												<div class="form-group">
													<input name="uss_pwd_conf" id="uss_pwd_conf" type="password" value=""  class="form-control " />
												</div>
											</dd>
										</dl>
									</li>
									<li>
										<dl class="row ">
											<dt class="col-md-3 col-sm-3">이메일</dt>
											<dd class="col-md-9 col-sm-9">
												<input name="uss_email" id="uss_email" type="text" value="${resultView.USS_EMAIL }" class="form-control form-group" />
											</dd>
										</dl>
									</li>
									<li>
										<dl class="row ">
											<dt class="col-md-3 col-sm-3">근속년수</dt>
											<dd class="col-md-9 col-sm-9">
												<div class="form-group">
													<input name="work_yr_cnt" id="work_yr_cnt" type="number" min="0" value="${resultView.WORK_YR_CNT }" class="form-control" oninput="this.value = this.value.replace(/[^0-9]/g, '')" readonly />
												</div>
											</dd>
										</dl>
									</li>
									<li>
										<dl class="row ">
											<dt class="col-md-3 col-sm-3">생년월일</dt>
											<dd class="col-md-9 col-sm-9">
												<div class="form-group">
													<input name="uss_birth" id="uss_birth" type="text" value="${resultView.USS_BIRTH }" class="form-control " />
												</div>
											</dd>
										</dl>
									</li>
									<li>
										<dl class="row ">
											<dt class="col-md-3 col-sm-3">생일</dt>
											<dd class="col-md-9 col-sm-9">
												<div class="form-group">
													<span class="col-md-12">
														<input class="col_md_2 table-cell" name="uss_birth_day_type" id="uss_birth_day_type_s" type="radio" value="S" <c:if test="${empty resultView.USS_BIRTH_DAY_TYPE || resultView.USS_BIRTH_DAY_TYPE eq 'S' }">checked="checked"</c:if> disabled>
														양력
														<input class="col_md_2 table-cell"  name="uss_birth_day_type" id="uss_birth_day_type_l" type="radio" value="L" <c:if test="${resultView.USS_BIRTH_DAY_TYPE eq 'L' }">checked="checked"</c:if> disabled>
														음력
													</span>
													<span class="col-md-12">
														<input name="uss_birth_day_mon" id="uss_birth_day_mon" type="text" value="${resultView.USS_BIRTH_DAY }" class="form-control " readonly />
													</span>
												</div>
											</dd>
										</dl>
									</li>
									
									<%-- <li>
										<dl class="row ">
											<dt class="col-md-3 col-sm-3">사용자 서명</dt>
											<dd class="col-md-9 col-sm-9 ">
												<div class="form-group">
													<img src="${pageContext.request.contextPath}/doc/sign.do?emp_no=${params.uss_id }" style="width: 140px; max-height: 70px;">
													<br>
													<input class="input-group" name="uss_sign" id="uss_sign" accept="image/png" type="file" onChange="fileCheck(this)"/>
												</div>
											</dd>
										</dl>
									</li> --%>
								</ul>
								</div>
								<div class="row">
									<ul class="col-md-12">
										<li>
											<dl class="row ">
												<dt class="col-md-3 col-sm-3">사용자 서명</dt>
												<dd class="col-md-9 col-sm-9 ">
													<div class="form-group">
														<img src="${pageContext.request.contextPath}/doc/sign.do?emp_no=${params.uss_id }" style="width: 140px; max-height: 70px;">
														<br>
														<input class="input-group" name="uss_sign" id="uss_sign" accept="image/png" type="file" onChange="fileCheck(this)"/>
													</div>
												</dd>
											</dl>
										</li>
									</ul>
								</div>
							</div>
						</form>
						<p class="clearfix" >
							<span class="pull-right">
							<a class="btn-ok btn btn-info btn-sm" href="#submit" role="button">수정</a>
						  <a href="#cancel" class="btn-cancel btn btn-default btn-sm" ><span>취소</span></a>
							</span>
						</p>
						</div>
					</div>
					<jsp:include page="/resources/com/inc/aside.jsp" />
				</section>
			</div>
			<jsp:include page="/resources/com/inc/footer.jsp" />
		</div>
			
			<!-- js파일 및 공통스크립트사용 -->
		<jsp:include page="/resources/com/inc/javascript.jsp" />
		<script type="text/javascript">
			$(function() {
				$("#uss_birth").datepicker();
			});
		
			$(document).ready(function() {
				/* 저장 */	
				$( ".btn-ok" ).click(function() {
					if(getValidation()){
						$.ajax({
							url: "${pageContext.request.contextPath}/uat/uia/uss00Tran.do",
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
					history.go(-1);
				});
			});
			
			function getValidation(){
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

				
				if($("#uss_nm").val() == ""){
					alert("성명을 입력해 주세요.");
					$("#uss_nm").focus();
					return false;
				}
				
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
				
				if($("#uss_email").val() != ""){
					if(!fnEmailCheck($("#uss_email").val())){
						alert('이메일 주소가 유효하지 않습니다');
						return false;
					}
				}
				
				return true;
			}
			
			function fn_goPage(){
				/* 수정 폼일 경우 */
				alert("정보수정이 완료되었습니다.");
				$("#uss_pwd").val("");
				$("#frm1").submit();
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
		</script>
	</body>
</html>