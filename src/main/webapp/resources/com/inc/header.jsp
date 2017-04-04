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
	<div class="container">
		<div class="top_menu">
			<%if(Sessinfo != null){%>
			<%=SES_NM %> 님 환영합니다. &nbsp;
			<a href="/letech/index.do">HOME</a><span class="line">|</span><a href="<%=request.getContextPath() %>/usr/myPage00L.do">마이페이지</a>
			<span class="line">|</span>
			<a href="<%=request.getContextPath() %>/LogOut.do" title="logout">로그아웃</a>
			<%if( "9".equals(SES_GB)){ %><span class="line">|</span><a href="<%=request.getContextPath() %>/mng/myPage00L.do">관리페이지</a><%} %>
			<%}else{%>
				<!-- 
					<a href="/letech/index.do">HOME</a><span class="line">|</span>
					<a href="/letech/Login.do">로그인</a>
					<a href="<%=request.getContextPath()%>/usr/join.do">회원가입</a>
				 <span class="log_info">
						홍길동<strong class="st_white">(사원)</strong>님 환영합니다.
				 		<a href="" class="btn btn_xs btn_classic" role="button">Logout</a>
				</span>
				 -->
			<% }%>
			 <c:if test="${loginVO != null}">
			 <span class="log_info">
				${loginVO.name }님 환영합니다.
				<sec:authorize access="hasAnyRole('ROLE_ADMIN')">
					관리자
				</sec:authorize> 
				<sec:authorize access="!hasAnyRole('ROLE_ADMIN')">
					<a href="${pageContext.request.contextPath}/uat/uia/ussInfoEdit.do?uss_id=${loginVO.id }" class="btn btn_xs btn_classic" role="button">정보수정</a>
				</sec:authorize>
				<a href="${pageContext.request.contextPath }/uat/uia/actionLogout.do" class="btn btn_xs btn_classic" role="button">로그아웃</a>
			</span>
			</c:if>
		</div>
	</div>
</header>
<%
String pageInfo=request.getRequestURI();

%>
