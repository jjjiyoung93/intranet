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
							<div class="row">
							<ul class="col-md-6">
								<li class="form-group">
										<label>사용자 ID</label>
																						<c:set var="modeType" value="<%=VarConsts.MODE_U%>"/>
												<c:choose>
													<c:when test="${params.mode eq modeType }">
														<br/><span class="">${resultView.USS_ID }</span>
														<input type="hidden" id="uss_id" name="uss_id" class="form-control" value="${params.uss_id }" />
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
									<li class="form-group">
										<label>비밀번호</label>
										<input name="uss_pwd" id="uss_pwd" type="password" value="" class="form-control" />
									</li>
									<li class="form-group">
										<label class=" ">비밀번호확인</label>
											<input name="uss_pwd_conf" id="uss_pwd_conf" type="password" value=""  class="form-control" />
									</li>
									<li class="form-group">
										<label>사원번호</label>
										<div class="input-group">
											<input name="uss_em_no" id="uss_em_no" type="text" value="" class="form-control" />
											<a class="btn_emnoChk input-group-addon" href="#">중복체크</a>
									</div>
									<span id="emno_check_text" ></span>
									</li>
									<li class="form-group">
										<label>권한</label>
										<select id="uss_auth_cd" name="uss_auth_cd" class="form-control">
						          			<option value="" >--선택--</option>
											<c:forEach var="authList" items="${authList}">
												<option value="${authList.AUTHOR_CODE}" <c:if test="${resultView.USS_AUTH_CD eq authList.AUTHOR_CODE }">selected="selected"</c:if> >${authList.AUTHOR_NM}</option>
											</c:forEach>
										</select>
								</li>
								</ul>
								<ul class="col-md-6">
									<li class="form-group">
											<label>성명</label>
												<input name="uss_nm" id="uss_nm" type="text" value="${resultView.USS_NM }" class="form-control" />
									</li>
									<li class="form-group">
											<label>부서</label>
												<select id="dp_cd" name="dp_cd" class="form-control">
													<option value="" >--선택--</option>
													<c:forEach var="departList" items="${departList}">
														<option value="${departList.DP_CD}" <c:if test="${departList.DP_CD eq resultView.DP_CD }">selected="selected"</c:if> >${departList.DP_NM}</option>
													</c:forEach>
												</select>
									</li>
									<li class="form-group">
										<label>생년월일</label>
											<input name="uss_birth" id="uss_birth" type="text" value="${resultView.USS_BIRTH }" class="form-control" />
									</li>
									<li class="form-group">
										<label>성별</label><br/>
										<span>
											<input class="col_md_2" name="uss_sex" id="uss_sex_m" type="radio" value="M" <c:if test="${empty resultView.USS_SEX || resultView.USS_SEX eq 'M' }">checked="checked"</c:if>>
											남자
											<input class="col_md_2"  name="uss_sex" id="uss_sex_w" type="radio" value="W" <c:if test="${resultView.USS_SEX eq 'W' }">checked="checked"</c:if> >
											여자
										</span>
									</li>
									<li class="form-group">
										<label>전화번호</label><br/>
											<span class="form-inline">
											<input name="uss_tel1" id="uss_tel1" type="text" value="${resultView.USS_TEL1 }"  class="form-control table-cell"/>
											-
											<input name="uss_tel2" id="uss_tel2" type="text" value="${resultView.USS_TEL2 }"  class="form-control table-cell"/>
											-
											<input name="uss_tel3" id="uss_tel3" type="text" value="${resultView.USS_TEL3 }" class="form-control table-cell"/>
											</span>
									</li>
									<li class="form-group">
										<label>이메일</label>
											<input name="uss_email" id="uss_email" type="text" value="${resultView.USS_EMAIL }"  class="form-control" />
									</li>
									
							</ul>
							</div>
						<div class="clearfix">
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
					if($("#mode").val() == "<%=VarConsts.MODE_U%>"){
					}else{
						$("#mode").val("<%=VarConsts.MODE_I%>");	
					}
					
					$.ajax({
						url: "${pageContext.request.contextPath}/uss/umt/uss00Tran.do",
						type: "post",
						dataType : "json", 
						data : $("#frm1").serialize(),
						success: function(result){
							var url_val = "";
							fn_goPage();
						},error: function (request, status, error) {
							alert(request.responseText);
						} 
					});
					
		// 			$("#frm1").attr("action", "${pageContext.request.contextPath}/uss/umt/uss00Tran.do");
		// 			$("#frm1").submit();
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
	</script>
</body>
</html>