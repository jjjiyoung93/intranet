<%@page import="kr.letech.cmm.util.ObjToConvert"%>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<%@page import="kr.letech.cmm.util.ReqUtils"%>
<%@page import="java.util.Map"%>
<%@page import="org.springframework.web.util.WebUtils"%>
<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"  %>
<%
Map Sessinfo = (Map)WebUtils.getSessionAttribute(request, VarConsts.SESS_USER);
String SES_ID = "", SES_NM="", SES_GB_NM="",SES_GB="",SES_AUTY = "";
if(Sessinfo != null){
	SES_ID		= (String)Sessinfo.get("SES_ID"); //ID
	SES_NM 		= (String)Sessinfo.get("SES_NM"); //성명
	SES_GB 		= ObjToConvert.objToIntStr(Sessinfo.get("SES_GB")); //권한

}
%>
<header>
<!-- 헤더_로고,메뉴 -->
		<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<h1 class="logo">
					<a class="navbar-brand" href="<%=request.getContextPath() %>/index.do">
						<img src="http://intra.letech.kr/letech/resources/images/layout/nav_logo.png" width="150"alt="" />
					</a>
				</h1>
			</div>
		<div class="top_menu">
			<ul class="nav navbar-top-links navbar-right" >
					<li>
						<a data-toggle="collapse" data-parent="#accordion" href="#alarmOne" aria-expanded="false">
							<i class="glyphicon glyphicon-bell"></i>
							<span class="text-muted small">(<font id="aside_aprvTotCnt"></font>)</span>
							<i class="glyphicon glyphicon-triangle-bottom"></i> 
						</a>
						<ul id="alarmOne" class="panel navber-right dropdown-menu collapse">
							<li>
								<a data-toggle="collapse" data-parent="#accordion" href="#aside_aprv0" aria-expanded="false">결제(<font id="aside_aprvCnt0"></font>)
									<span class="pull-right"><i class="glyphicon glyphicon-chevron-down"></i></span>
								</a>
								<ul id="aside_aprv0" class="collapse">
								</ul>
							</li>
							<li>
								<a data-toggle="collapse" data-parent="#accordion" href="#aside_aprv2" aria-expanded="false">보류(<font id="aside_aprvCnt2"></font>)
									<span class="pull-right"><i class="glyphicon glyphicon-chevron-down"></i></span>
								</a>
								<ul id="aside_aprv2" class="collapse">
								</ul>
							</li>
							<li>
								<a data-toggle="collapse" data-parent="#accordion" href="#aside_aprv3" aria-expanded="false">반려(<font id="aside_aprvCnt3"></font>)
									<span class="pull-right"><i class="glyphicon glyphicon-chevron-down"></i></span>
								</a>
								<ul id="aside_aprv3" class="collapse">
								</ul>
							</li>
						</ul>
					</li>
					
					<%-- <li class="hidden-xs">
						<a data-toggle="collapse" data-parent="#accordion" href="#userOne" aria-expanded="false">
							<i class="glyphicon glyphicon-user"></i><%=SES_NM %>
							<i class="glyphicon glyphicon-triangle-bottom"></i> 
						</a>
						<ul id="userOne" class="panel navber-right dropdown-menu collapse">
							<li>
								<a href="/letech/index.do">HOME</a><a href="<%=request.getContextPath() %>/usr/myPage00L.do">마이페이지</a>
							</li>
							<li>
								<a href="<%=request.getContextPath() %>/LogOut.do" title="logout">로그아웃</a>
							</li>
							<li>
									<!-- 
										<a href="/letech/index.do">HOME</a><span class="line">|</span>
										<a href="/letech/Login.do">로그인</a>
										<a href="<%=request.getContextPath()%>/usr/join.do">회원가입</a>
									 <span class="log_info">
											홍길동<strong class="st_white">(사원)</strong>님 환영합니다.
									 		<a href="" class="btn btn_xs btn_classic" role="button">Logout</a>
									</span>
									 -->
								</li>
						</ul>
					</li> --%>
					
					<c:if test="${loginVO != null}">
					<li class="dropdown hidden-xs">
						<a class="dropdown-toggle" data-toggle="dropdown" href="#">
							<i class="glyphicon glyphicon-user"></i>
							<sec:authorize access="!hasAnyRole('ROLE_ADMIN')">
								<span class="text-muted small">(${loginVO.name })</span>
							</sec:authorize>
							<sec:authorize access="hasAnyRole('ROLE_ADMIN')">
								<span class="text-muted small">(관리자)</span>
							</sec:authorize>
							<i class="glyphicon glyphicon-triangle-bottom"></i> 
						</a>
						<ul class="dropdown-menu dropdown-user">
							<li>
								<sec:authorize access="!hasAnyRole('ROLE_ADMIN')">
								<a href="${pageContext.request.contextPath}/uat/uia/ussInfoEdit.do?uss_id=${loginVO.id }" class="btn btn_xs btn_classic" role="button">정보수정</a>
								</sec:authorize>
								<a href="${pageContext.request.contextPath }/uat/uia/actionLogout.do" class="btn btn_xs btn_classic" role="button">로그아웃</a>
							</li>
						</ul>
					</li>
					</c:if>
			</ul>
		</div>
</header>
<%
String pageInfo=request.getRequestURI();

%>



<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">	    	
/*aside	*/
$(function(){
	$("ul.panel li.tab_cont:not("+$("ul.tab li a.selected").attr("href")+")").hide()
	$("ul.tab li a").click(function(){
		$("ul.tab li a").removeClass("selected");
		$(this).addClass("selected");
		$("ul.panel li.tab_cont").hide();
		$($(this).attr("href")).show();
		return false;
	});
});
$(document).ready(function(){
	$.ajax({
		type:'post',
		url:'${pageContext.request.contextPath}/aprv/aprv02Ajax.do',
		dataType:'json',
		success: function(json){
			/* 결재 정보 목록 START */
			var aprvList0 = json.aprvList0;		// 결재중
			var aprvList2 = json.aprvList2;		// 보류
			var aprvList3 = json.aprvList3;		// 반려
			
			var aprvListCnt0 = aprvList0.length;
			var aprvListCnt2 = aprvList2.length;
			var aprvListCnt3 = aprvList3.length;
			
			for(var i=0; i<aprvListCnt0; i++){
				$("#aside_aprv0").append("<li><a href=\"${pageContext.request.contextPath }/aprv/aprv00List.do?menu_id1=MN0013&menu_id2=MN0014&searchCdList1="+aprvList0[i]['CD']+"\">"+aprvList0[i]['CD_NM']+"("+aprvList0[i]['TYPE_CNT']+")</a></li>");
			}

			for(var i=0; i<aprvListCnt2; i++){
				$("#aside_aprv2").append("<li><a href=\"${pageContext.request.contextPath }/aprv/aprv00List.do?menu_id1=MN0013&menu_id2=MN0014&searchCdList1="+aprvList2[i]['CD']+"\">"+aprvList2[i]['CD_NM']+"("+aprvList2[i]['TYPE_CNT']+")</a></li>");
			}

			for(var i=0; i<aprvListCnt3; i++){
				$("#aside_aprv3").append("<li><a href=\"${pageContext.request.contextPath }/aprv/aprv00List.do?menu_id1=MN0013&menu_id2=MN0014&searchCdList1="+aprvList3[i]['CD']+"\">"+aprvList3[i]['CD_NM']+"("+aprvList3[i]['TYPE_CNT']+")</a></li>");
			}
			/* 결재 정보 목록 END */
			
			/* 결재 관련 건수 START */
			var aprvCount0 = json.aprvCount0;		// 결재중
			var aprvCount2 = json.aprvCount2;		// 보류
			var aprvCount3 = json.aprvCount3;		// 반려
			var aprvCountTotCnt = json.aprvCount0 + json.aprvCount2 + json.aprvCount3; 
			
			$("#aside_aprvCnt0").text(aprvCount0);
			$("#aside_aprvCnt2").text(aprvCount2);
			$("#aside_aprvCnt3").text(aprvCount3);
			$("#aside_aprvTotCnt").text(aprvCountTotCnt);
			/* 결재 관련 건수 END */
		}
	});	
});
</script>
			
	    	