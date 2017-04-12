<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
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
				<form name="form1" id="form1" method="post" action="<%=request.getContextPath()%>/sys/rol/rol01List.do" >
					<input type="hidden" id="mode" name="mode" />
					<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}"/>
					<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}"/>
					<input type="hidden" id="menu_id3" name="menu_id3" value="${params.menu_id3}"/>
					<input type="hidden" id="parnts_role" name="parnts_role"  value=""  /> 
					<input type="hidden" id="chldrn_role" name="chldrn_role"  value=""  /> 
					<input type="hidden" name="flag" id="flag" value="" /> 
					
					<div class="col-lg-10">
						<h4 class="title">${titleNaviMap.MN_NM }<span class="pull-right text-muted small">HOME > ${titleNaviMap.NAVI_NM }</span></h4>
						<c:if test="${mnList3 ne null}">
						<div class="tab_gnb">
							<ul class="nav nav-tabs">
									<c:forEach var="list3" items="${mnList3}" varStatus="status">
										<c:if test="${params.menu_id2 eq list3.UP_MN}">
											<li class="<c:if test="${params.menu_id3 eq list3.MN}">on </c:if>col_md_3">
												<a href="javascript:fnTabMove('${list3.MN_HREF}','${list3.MN}')">${list3.MN_NM}</a>
											</li>
										</c:if>
								</c:forEach>
							</ul>
				   		</div>
						</c:if>
					<div class="table-responsive ">
						<!-- 테이블 -->
						<table class="table table-bordered">
							<caption>메뉴관리</caption>
							<colgroup>
								<col width="14%"  />
								<col width="21%"  />
								<col width="*"  />
								<col width="21%"  />
								<col width="10%"  />
							</colgroup>
							<thead>
								<tr>
									<th>부모권한</th>
									<th>부모권한설명</th>
									<th>자식권한</th>
									<th>자식권한설명</th>
									<th>권한수정</th>
								</tr>								
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${highList eq null }">
										<tr>
											<th colspan="7">
												등록된 권한이 없습니다.
											</th>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="highList" items="${highList }">
											<tr>
												<td>${highList.PARNTS_ROLE }</td>
												<td>${highList.PR_DC }</td>
<%-- 												<td>${highList.PR_REG_DT }</td> --%>
												<td>${highList.CHLDRN_ROLE }</td>
												<td>${highList.CH_DC }</td>
<%-- 												<td>${highList.CH_REG_DT }</td> --%>
												<c:choose>
													<c:when
														test="${highList.CHLDRN_ROLE eq 'ROLE_ADMIN'}">
														<td>-</td>
													</c:when>
													<c:otherwise>
													<td>
														<a href="#" class="btn btn-xs btn-default" onclick="fnDelete('<%=VarConsts.MODE_D%>','${highList.PARNTS_ROLE}','${highList.CHLDRN_ROLE}');">롤삭제</a>
													</td>
													</c:otherwise>
												</c:choose>
												
											</tr>
										</c:forEach>					
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
						</div>
						<!-- page nav -->
						<p class="clearfix" >
							<span class="pull-right">
								<input class="btn btn-warning" onclick="fnInsert();" value="권한상속관계추가" type="button"/>
							</span>
						</p>
	
					<div class="pop_bg">
						<div class="popup">
							<a href="#" class="close" title="창닫기"></a>
					 		<iframe id="iframe" name="iframe" src="" frameborder="0" scrolling="no"></iframe>
						</div>
					</div>
				</div>
			</form>
			<jsp:include page="/resources/com/inc/aside.jsp" />
			</section>
		</div>
		<jsp:include page="/resources/com/inc/footer.jsp" />
	</div>

<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">


//코드폼 레이어 닫기(x)버튼 클릭시
jQuery(function() {	
	jQuery( ".close" ).click(
			function() {
			jQuery( ".pop_bg" ).fadeOut('slow');
			jQuery( "#iframe" ).attr("src","");
			}
	);
});

//코드폼 레이어 취소버튼 클릭시
function closeModal(){
	fnList();
	jQuery( ".pop_bg" ).fadeOut('slow');		
};


/*********************************************************************************
* function명   : fnTabMove
* function기능 : 탭이동
**********************************************************************************/
function fnTabMove(href,pm1){
	document.form1.action = "<%=request.getContextPath() %>/"+href;
	document.form1.menu_id3.value = pm1;
	document.form1.submit();
	
}

/*********************************************************************************
* function명   : fnList
* function기능 : 공통코드목록페이지로 이동
**********************************************************************************/
function fnList(){
	document.form1.submit();
}


/*********************************************************************************
* function명   : fnInsert(코드)
* function기능 : 코드 추가
**********************************************************************************/
function fnInsert(){
	//jQuery( ".pop_bg" ).fadeIn('slow');
	//jQuery( "#iframe" ).attr("src","<%=request.getContextPath() %>/sys/cdm/form.do?flag=1&cd=");
	
	window.open('rol01Form.do?flag=1','target_name','scrollbars=yes,toolbar=yes,resizable=yes,width=500,height=300,left=0,top=0');
	
}


/*********************************************************************************
* function명   : fnDelete(코드)
* function기능 : 코드 삭제 
**********************************************************************************/
function fnDelete(mode,parnts_role,chldrn_role){
	document.form1.parnts_role.value = parnts_role;
	document.form1.chldrn_role.value = chldrn_role;
	document.form1.mode.value = mode;
	if(confirm('적용롤 확인 여부를 확인 후 삭제하세요. \r\n 삭제하시겠습니까?')){
		document.form1.action = "<%=request.getContextPath() %>/sys/rol/rol01Tran.do";
		document.form1.submit();
	}
}

</script>
</body>
</html>