<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
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
			$(function(){
				$("article.sub_contents:not("+$("ul.tab_gnb li a.sub_nav_on").attr("href")+")").hide()
				$("ul.tab_gnb li a").click(function(){
					$("ul.tab_gnb li a").removeClass("sub_nav_on");
					$(this).addClass("sub_nav_on");
					$("article.sub_contents").hide();
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
	    <%@ include file="/WEB-INF/views/letech/com/layout/menu.jsp" %>
	    <div class="container">
	    	
	    	<aside>
	    		<div class="tab_box">
					<ul class="tab">
						<li class="col_md_4"><a href="#tab1" class="selected ">결제(5)</a></li>
						<li class="col_md_4"><a href="#tab2" >반려(1)</a></li>
						<li class="col_md_4"><a href="#tab3" >보류(0)</a></li>
					</ul>
					<ul class="panel">
						<li id="tab1" class="tab_cont">
							<ul>
								<li><a href="">업무보고서(1)</a></li>
								<li><a href="">지출결의서(3)</a></li>
								<li><a href="">휴가계획서(1)</a></li>
							</ul>
						</li>
						<li id="tab2" class="tab_cont">
							<ul>
								<li><a href="">업무보고서(1)</a></li>
								<li><a href="">지출결의서(0)</a></li>
								<li><a href="">휴가계획서(0)</a></li>
							</ul>
						</li>
						<li id="tab3" class="tab_cont">
							<ul>
								<li><a href="">업무보고서(0)</a></li>
								<li><a href="">지출결의서(0)</a></li>
								<li><a href="">휴가계획서(0)</a></li>
							</ul>
						</li>
					</ul>
				</div>
	    		<div class="side_bottom">
	    			<div class="sch">
	    				<h3>Search</h3>
    					<form>
    						<fieldset>
    							<legend>검색</legend>
	    						<select id="selectbasic" name="selectbasic" class="col_md_12">
							     	<option value="1">all</option>
							     	<option value="2">직원연락처</option>
							     	<option value="3">업무일지</option>
							     	<option value="3">일정</option>
							    </select>
								<input id="appendedtext" name="검색" class="col_md_10" placeholder="검색어를 입력해 주세요" type="text">
								<button class="btn-danger col_md_2 btn_sch"  type="submit" >
									<span class=""><img src="<%=request.getContextPath()%>/resources/images/layout/icon_sch.png" alt="검색"  >dddd </span>
								</button>
							</fieldset>
    					</form>
	    			</div>
	    			<div class="new">
	    				<h3>사내 공지사항</h3>
	    				<ul>
	    					<li>
	    						<a href="">
	    						<strong class="sky">회의장소 변경안내</strong><br>
	    						오후 5시 회의 장소가 변경 되었음을 알려 드립니다.<br>
	    						<strong>2015.10.10/ 16:00</strong>
	    						</a>
	    					</li>
	    				</ul>
	    			</div>
	    		</div>
	    	</aside>
	    	
	    	
	    	
	    	<section class="contents">
	    		<article>
					<ul class="tab_gnb">
						 <li class="on col_md_2"><a href="#section_01" class="sub_nav_on">메뉴1</a></li>
						 <li class="col_md_2"><a href="#section_02">메뉴2</a></li>
						 <li class="col_md_2"><a href="#section_03">메뉴3</a></li>
						 <li class="col_md_2"><a href="#section_04">메뉴4</a></li>
					</ul>
	    		</article>
				<article id="section_01" class="sub_contents">
					<p class="left "><strong>Total : ${totalCnt} 건</strong></p>
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
									<c:forEach var="list" items="${mnList}" varStatus="status">
										<tr>
											<td>${totalCnt - status.index - ((cPage-1) * (intListCnt))}</td>
											<td>
												${list.MN_NM}
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
				</article>
				<article id="section_02" class="sub_contents">2222</article>
				<article id="section_03" class="sub_contents">3333</article>
				<article id="section_04" class="sub_contents">44444</article>
			</section>
		</div>
		<hr>
	   	<footer>
    		<div class="container">footer</div>
    	</footer>
	</div>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.1.min.js"></script>
</body>
</html>