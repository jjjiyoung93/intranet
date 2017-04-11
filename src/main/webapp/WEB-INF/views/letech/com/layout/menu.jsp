<%@ page contentType="text/html; charset=utf-8" language="java" errorPage="" %>
<%@page import="org.springframework.web.util.WebUtils"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"  %>

	<div class="navbar-default sidebar " role="navigation">
	<div class="sidebar-nav navbar-collapse collapse" aria-expanded="false" style="height: 1px;">
		<ul class="nav in" id="side-menu">
			<c:forEach var="list" items="${mnList}" varStatus="status">
				<c:choose>
					<c:when test="${empty list.AUTHOR_CODE }">
						<li class="visible-md visible-lg">
							<a href="#" <c:if test="${params.menu_id1 eq list.MN}">class="act_on" </c:if> >
								${list.MN_NM}
							</a>
							<c:if test="${mnList2 ne null}">
								<ul class="sub">
									<c:forEach var="list2" items="${mnList2}" varStatus="status">
										<c:if test="${list.MN eq list2.UP_MN}">
											<c:choose>
												<c:when test="${empty list2.AUTHOR_CODE }">
													<li>
														<c:if test="${list2.MN_TYPE eq 'CD0003001'}">
															<a href="${pageContext.request.contextPath}/${list2.MN_HREF}&menu_id1=${list.MN}&menu_id2=${list2.MN}" >${list2.MN_NM}</a>
														</c:if>
														<c:if test="${list2.MN_TYPE ne 'CD0003001'}">
															<a href="${pageContext.request.contextPath}/${list2.MN_HREF}?menu_id1=${list.MN}&menu_id2=${list2.MN}" >${list2.MN_NM}</a>
														</c:if>
													</li>
												</c:when>
												<c:otherwise>
													<sec:authorize access="hasAnyRole('${list2.AUTHOR_CODE}')">
													<li>
														<c:if test="${list2.MN_TYPE eq 'CD0003001'}">
															<a href="${pageContext.request.contextPath}/${list2.MN_HREF}&menu_id1=${list.MN}&menu_id2=${list2.MN}" >${list2.MN_NM}</a>
														</c:if>
														<c:if test="${list2.MN_TYPE ne 'CD0003001'}">
															<a href="${pageContext.request.contextPath}/${list2.MN_HREF}?menu_id1=${list.MN}&menu_id2=${list2.MN}" >${list2.MN_NM}</a>
														</c:if>
													</li>
												</sec:authorize>
												</c:otherwise>
											</c:choose>
										</c:if>
									</c:forEach>
								</ul>
							</c:if>
						</li>
					</c:when>
					<c:otherwise>
						<sec:authorize access="hasAnyRole('${list.AUTHOR_CODE}')">
							<li>
								<a href="#" <c:if test="${params.menu_id1 eq list.MN}">class="act_on" </c:if> >
								${list.MN_NM}
								</a>
								<c:if test="${mnList2 ne null}">
									<ul class="sub">
										<c:forEach var="list2" items="${mnList2}" varStatus="status">
											<c:if test="${list.MN eq list2.UP_MN}">
												<li>
													<c:if test="${list2.MN_TYPE eq 'CD0003001'}">
														<a href="${pageContext.request.contextPath}/${list2.MN_HREF}&menu_id1=${list.MN}&menu_id2=${list2.MN}" >${list2.MN_NM}</a>
													</c:if>
													<c:if test="${list2.MN_TYPE ne 'CD0003001'}">
														<a href="${pageContext.request.contextPath}/${list2.MN_HREF}?menu_id1=${list.MN}&menu_id2=${list2.MN}" >${list2.MN_NM}</a>
													</c:if>
												</li>
											</c:if>
										</c:forEach>
									</ul>
								</c:if>
							</li>
						</sec:authorize> 
					</c:otherwise>
				</c:choose>
			
			</c:forEach>
		</ul>
	</div>
</div>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.1.min.js"></script>
<!-- <script>
$(function(){

    $("ul.sub").hide();

	 $("ul.gnb li").hover(function(){

	    $("ul:not(:animated)",this).slideDown("fast");

		},

		function(){

		   $("ul",this).slideUp("fast");

		});

 });	
</script>
 -->

<!-- 
<a href="/letech/usr/memb00L.do">회원가입</a>
<a href="/letech/usr/memb00L.do">로그인</a>
<a href="/letech/sample/list.do">샘플페이지</a>
<a href="/letech/sample/menu.do">샘플프레임</a>
<a href="/letech/sys/cdm/list.do">코드관리</a>
<a href="/letech/sys/mnm/mnm00List.do">메뉴관리</a>
<a href="/letech/uss/umt/uss00List.do">사용자관리</a>
<a href="/letech/cal/cal00List.do">일정관리</a>
<a href="/letech/aprv/aprv00List.do">결제관리</a>
 -->