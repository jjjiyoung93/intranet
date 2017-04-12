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
			<ul class="nav navbar-top-links navbar-right">
					<li class="dropdown hidden-xs">
						<a class="dropdown-toggle" data-toggle="dropdown" href="#">
							<i class="glyphicon glyphicon-user"></i><%=SES_NM %>
							<i class="glyphicon glyphicon-triangle-bottom"></i> 
						</a>
						<ul class="dropdown-menu dropdown-user">
							<li>
								<a href="/letech/index.do">HOME</a><span class="line">|</span><a href="<%=request.getContextPath() %>/usr/myPage00L.do">마이페이지</a>
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
					</li>
					<c:if test="${loginVO != null}">
					<li class="dropdown hidden-xs">
						<a class="dropdown-toggle" data-toggle="dropdown" href="#">
							<i class="glyphicon glyphicon-user"></i>${loginVO.name }
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

