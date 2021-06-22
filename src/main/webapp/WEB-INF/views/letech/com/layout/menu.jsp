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
						<li>
							<a class="<c:if test="${params.menu_id1 eq list.MN}">act_on </c:if>collapsed" data-toggle="collapse" data-parent="#selector" href="#collapse${status.index}" aria-expanded="false" aria-controls="collapse${status.index}">
							<!-- 사용자 1depth 메뉴 -->
								<i class="glyphicon glyphicon-cog"></i> ${list.MN_NM}<span class="pull-right glyphicon glyphicon-menu-left"></span>
							</a>
							<c:if test="${mnList2 ne null}">
								<ul class="sub panel-collapse collapse" id="collapse${status.index}" class="panel-collapse collapse" role="tabpanel" aria-labelledby="collapse${status.index}">
									<c:forEach var="list2" items="${mnList2}" varStatus="status">
										<c:if test="${list.MN eq list2.UP_MN}">
											<c:choose>
												<c:when test="${empty list2.AUTHOR_CODE }">
													<li>
														<c:if test="${list2.MN_TYPE eq 'CD0003001'}">
															<a href="${pageContext.request.contextPath}/${list2.MN_HREF}&menu_id1=${list.MN}&menu_id2=${list2.MN}" >${list2.MN_NM}</a>
														</c:if>
														<c:if test="${list2.MN_TYPE ne 'CD0003001'}">
															<c:if test="${list2.UP_MN eq 'MN0019'}">
																<a href="${pageContext.request.contextPath}/${list2.MN_HREF}&menu_id1=${list.MN}&menu_id2=${list2.MN}" >${list2.MN_NM}</a>
															</c:if>
															<c:if test="${list2.UP_MN ne 'MN0019'}">
																<a href="${pageContext.request.contextPath}/${list2.MN_HREF}?menu_id1=${list.MN}&menu_id2=${list2.MN}" >${list2.MN_NM}</a>
															</c:if>
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
								<a class="<c:if test="${params.menu_id1 eq list.MN}">act_on </c:if>collapsed " data-toggle="collapse" data-parent="#selector" href="#collapse${status.index}" aria-expanded="false" aria-controls="collapse${status.index}">
								<!-- 관리자 1depth 메뉴 -->
								<i class="glyphicon glyphicon-cog"></i> ${list.MN_NM}<span class="pull-right glyphicon glyphicon-menu-left"></span>
								</a>
								<c:if test="${mnList2 ne null}">
									<ul class="sub panel-collapse collapse"  role="tabpanel" aria-labelledby="collapse${status.index}" id="collapse${status.index}">
										<c:forEach var="list2" items="${mnList2}" varStatus="status">
											<c:if test="${list.MN eq list2.UP_MN}">
												<li>
													<!-- 하위 메뉴가 있는지 판단 -->
													<c:if test="${list2.MN_TYPE eq 'CD0003001'}">
													
														<!-- 하위메뉴 추가 김중원 START -->
														<a href="#" class="<c:if test="${params.menu_id1 eq list.MN}">act_on </c:if>" >
															${list2.MN_NM}
														</a>
														<c:if test="${mnList3 ne null}">
															<ul class="sub">
																<c:forEach var="list3" items="${mnList3}" varStatus="status">
																	<c:if test="${list2.MN eq list3.UP_MN}">
																		<li>
																			<!-- 하위 메뉴가 있는지 판단 -->
																			<c:if test="${list3.MN_TYPE eq 'CD0003001'}">
																				<a href="#" class="<c:if test="${params.menu_id2 eq list.MN}">act_on</c:if>" >
																					${list3.MN_NM}
																				</a>
																				<a href="${pageContext.request.contextPath}/${list2.MN_HREF}&menu_id1=${list.MN}&menu_id2=${list2.MN}&menu_id3=${list3.MN}" >&#45; ${list3.MN_NM}</a>
																			</c:if>
																			<!-- 하위 메뉴가 없음 -->
																			<c:if test="${list3.MN_TYPE ne 'CD0003001'}">
																				<a href="${pageContext.request.contextPath}/${list3.MN_HREF}?menu_id1=${list.MN}&menu_id2=${list2.MN}&menu_id3=${list3.MN}" >&#45; ${list3.MN_NM}</a>
																			</c:if>
																		</li>
																	</c:if>
																</c:forEach>
															</ul>
														</c:if>
														<!-- 하위메뉴 추가 김중원 END -->
														
														<%-- <a href="${pageContext.request.contextPath}/${list2.MN_HREF}&menu_id1=${list.MN}&menu_id2=${list2.MN}" >${list2.MN_NM}1</a> --%>
													</c:if>
													<!-- 하위 메뉴가 없음 -->
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
			
			<li class="">
				<a class="collapsed" data-toggle="collapse" data-parent="#selector" href="#collapse99" aria-expanded="false" aria-controls="collapse99">
					<i class="glyphicon glyphicon-user"></i> 사용자메뉴<span class="pull-right glyphicon glyphicon-menu-left"></span>
				</a>
				<ul class="sub panel-collapse collapse"  role="tabpanel" aria-labelledby="collapse99" id="collapse99">
					<sec:authorize access="!hasAnyRole('ROLE_ADMIN')">
						<li>
							<a href="${pageContext.request.contextPath}/uat/uia/ussInfoEdit.do?uss_id=${loginVO.id }" class="" role="button">정보수정</a>
						</li>
					</sec:authorize>
					<li>
						<a href="${pageContext.request.contextPath }/uat/uia/actionLogout.do" class="" role="button">로그아웃</a>
					</li>
				</ul>
			</li>
		</ul>
	</div>
</div>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.1.min.js"></script>
<script src='${pageContext.request.contextPath}/resources/js/bootstrap.min.js'></script>
<script type="text/javascript">
<!--
	$(document).ready(function(){
		$(".collapsed").click(function() {
			if($(this).attr("aria-expanded") == 'true'){
				$(this).find("span").removeClass("glyphicon-menu-down");
				$(this).find("span").addClass("glyphicon-menu-left");
			}else{
				$(this).find("span").removeClass("glyphicon-menu-left");
				$(this).find("span").addClass("glyphicon-menu-down");
			}
		});
		
		
	});
//-->
</script>
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