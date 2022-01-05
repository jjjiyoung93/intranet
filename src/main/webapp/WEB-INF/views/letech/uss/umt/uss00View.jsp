<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
<jsp:include page="/resources/com/inc/meta.jsp" />
<title>Letech Intranet</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
</head>

<body>
	<div id="warpper">
		<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
			<jsp:include page="/resources/com/inc/header.jsp" />
			<%@ include file="/WEB-INF/views/letech/com/layout/menu.jsp" %>
		</nav>
		
		<div id="page-wrapper">
			<section class="row">
				<div class="col-lg-10">
				
					<!-- 타이틀 및 페이지 네비 -->		
					<h2 class="page-title clearfix">
								${titleNaviMap.MN_NM }
								<span class="pull-right site-map">
									HOME > ${titleNaviMap.NAVI_NM }
								</span>
							</h2>
					
					<!-- 수정본 -->
					<div class="form-container">
					<div class="board-view">
						<form name="frm1" id="frm1" method="post" action="${pageContext.request.contextPath}/uss/umt/uss01Form.do" >
							<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}"/>
							<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}"/>
							<input type="hidden" name="uss_id" id="uss_id" value="${params.uss_id }" />
							<input type="hidden" id="mode" name="mode" value="" />
							
							<ul class="payment-form">
								<li class="">
									<dl class="clearfix">
										<dt class="col-md-2 col-sm-3">사용자 ID</dt>
										<dd class="col-md-10 col-sm-9">
											${resultView.USS_ID }
										</dd>
									</dl>
								</li>
								<li class="">
									<dl class="clearfix ">
										<dt class="col-md-2 col-sm-3">부서</dt>
										<dd class="col-md-10 col-sm-9">
											${resultView.DP_NM }
										</dd>
									</dl>
								</li>
								<li class="">
									<dl class="clearfix ">
										<dt class="col-md-2 col-sm-3">성명</dt>
										<dd class="col-md-10 col-sm-9">
											${resultView.USS_NM }
										</dd>
									</dl>
								</li>
								<li class="">
									<dl class="clearfix ">
										<dt class="col-md-2 col-sm-3">생년월일</dt>
										<dd class="col-md-10 col-sm-9">
											${resultView.USS_BIRTH }
										</dd>
									</dl>
								</li>
								<li class="">
									<dl class="clearfix ">
										<dt class="col-md-2 col-sm-3">성별</dt>
										<dd class="col-md-10 col-sm-9">
											${resultView.USS_SEX_VAL }
										</dd>
									</dl>
								</li>
								<li class="">
									<dl class="clearfix ">
										<dt class="col-md-2 col-sm-3">전화번호</dt>
										<dd class="col-md-10 col-sm-9">
											${resultView.USS_TEL }
										</dd>
									</dl>
								</li>
								<li class="">
									<dl class="clearfix ">
										<dt class="col-md-2 col-sm-3">이메일</dt>
										<dd class="col-md-10 col-sm-9">
											${resultView.USS_EMAIL }
										</dd>
									</dl>
								</li>
								<li class="">
									<dl class="clearfix ">
										<dt class="col-md-2 col-sm-3">권한</dt>
										<dd class="col-md-10 col-sm-9">
											${resultView.USS_AUTH_NM }
										</dd>
									</dl>
								</li>
							</ul>
							<p class="clearfix">
									<input class="btn btn-default btn-list"  type="button" value="목록" />
									<span class="pull-right">
										<input class="btn-upd btn btn-warning" type="button" value="수정" />
										<input class="btn-del btn btn-warning" type="button" value="삭제" />
									</span>
							</p>
						</form>
					</div>
				</div>
				</div>
				<jsp:include page="/resources/com/inc/aside.jsp" />
			</section>
		</div>
		<jsp:include page="/resources/com/inc/footer.jsp" />
	</div>


	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			/* 수정폼 */	
			$( ".btn-upd" ).click(function() {
				$("#mode").val("<%=VarConsts.MODE_U%>");
				$("#frm1").attr("action", "${pageContext.request.contextPath}/uss/umt/uss00Form.do");
				$("#frm1").submit();
			});
			/* 삭제 */
			$( ".btn-del" ).click(function() {
				if(confirm("삭제하시겠습니까?")){
					$("#mode").val("<%=VarConsts.MODE_D%>");			
					$.ajax({
						url: "${pageContext.request.contextPath}/uss/umt/uss00Tran.do",
						type: "post",
						dataType : "json", 
						data : $("#frm1").serialize(),
						success: function(result){
							alert("삭제되었습니다.");
							goList();
						},error: function (request, status, error) {
							alert("삭제에 실패 했습니다.");
		// 					alert(request.responseText);
						} 
					});
				}
			});
			/* 목록 */
			$( ".btn-list" ).click(function() {
				goList();
			});
			
		});
		
		function goList(){
			$("#frm1").attr("action", "${pageContext.request.contextPath}/uss/umt/uss00List.do");
			$("#frm1").submit();
		}
		
		/*문서전체 키다운 onKeyDown*/
		$(document).keydown(function(e){
			keyDown();
		});
			
		/* 키를 눌렀을 시 동작.*/
		function keyDown(){
			if(event != null) {
				//엔터키
				if (event.keyCode==13){
					fnSearch();
					
				}
			}
		}
	</script>
</body>
</html>