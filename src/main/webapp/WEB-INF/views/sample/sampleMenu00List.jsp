<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>layout2-html5</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
<script type="text/javascript">
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
		</script>

</head>

<body>
	<div id="wrap">
	    <jsp:include page="/resources/com/inc/header.jsp" />
	    <%-- <jsp:include page="/resources/com/inc/menu.jsp" /> --%>
	    <%@ include file="menu2.jsp" %>
	    <div class="container">
	   	 	<jsp:include page="/resources/com/inc/aside.jsp" />
	    	<section class="contents">
	    		<article>
					<ul class="tab_gnb">
						 <li class="on col_md_3 sub_on"><a href="#section_01">메뉴1</a></li>
						 <li class="col_md_3"><a href="#section_02">메뉴2</a></li>
						 <li class="col_md_3"><a href="#section_03">메뉴3ffff</a></li>
					</ul>
	    		</article>
				<article>
					<div id="section_01">
						 <p class=""><strong >Total : ${totalCnt} 건</strong></p>
						<table>
					        <thead>
					        	<tr>
					            	<th>번호</th>
									<th>아이디</th>
									<th>이름</th>
									<th>성별</th>
									<th>키</th>
									<th>몸무게</th>
					            </tr>
					        </thead>
					        <tbody>
					        	<c:choose>
									<c:when test="${totalCnt < 1 }">
										<tr>
											<td colspan="6">
												검색된 내용이 없습니다.
											</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="list" items="${getList}" varStatus="status">
											<tr>
												<td>${totalCnt - status.index - ((cPage-1) * (intListCnt))}</td>
												<td>
													${list.usr_id}
												</td>
												<td>
													${list.usr_nm}
												</td>
												<td>
													${list.usr_sex}
												</td>
												<td>
													${list.usr_height}
												</td>
												<td>
													${list.usr_weight}
												</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
						 	</tbody>
				        </table>
						 <div class="table_foot2">
				            <!-- pase nav-->
				     
							<p class="page_nav" style="text-align: center;">
								<strong>
								<%=(String)request.getAttribute("pageNavigator")%>
								</strong>
							</p>
				        </div>			
					</div>
					<div id="section_02"></div>
					<div id="section_03"></div>
				</article>
			</section>
		</div>
		<hr>
		 <jsp:include page="/resources/com/inc/footer.jsp" />
	</div>
</body>
</html>