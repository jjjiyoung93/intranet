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
				<form name="form1" id="form1" method="post" action="<%=request.getContextPath()%>/sys/rol/rol02List.do" >
					<input type="hidden" id="mode" name="mode" />
					<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}"/>
					<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}"/>
					<input type="hidden" id="menu_id3" name="menu_id3" value="${params.menu_id3}"/>
					<input type="hidden" id="author_code"name="author_code" value="" /> 
					<input type="hidden" name="flag" id="flag" value="" /> 
					<!-- 타이틀 및 페이지 네비 -->
					<div class="col-lg-10">
						<h2 class="page-title clearfix">
							${titleNaviMap.MN_NM }
							<span class="pull-right site-map">
								HOME > ${titleNaviMap.NAVI_NM }
							</span>
						</h2>
						<%-- 	<c:if test="${mnList3 ne null}">
							<div class="tab_gnb">
								<ul class="nav nav-tabs">
									<c:forEach var="list3" items="${mnList3}" varStatus="status">
										<c:if test="${params.menu_id2 eq list3.UP_MN}">
											<li class="<c:if test="${params.menu_id3 eq list3.MN}">active</c:if>" role="presentaion">
												<a class="" href="javascript:fnTabMove('${list3.MN_HREF}','${list3.MN}')">${list3.MN_NM}</a>
											</li>
										</c:if>
									</c:forEach>
								</ul>
							</div>
							</c:if> --%>
					<!-- page -->
					<div class="form-container">
					<div class="table-responsive ">
						<!-- 테이블 -->
						<table class="table table-bordered">
							<caption>메뉴관리</caption>
							<colgroup>
								<col width="25%"  />
								<col width="25%"  />
								<col width="30%"  />
								<col width="20%"  />
							</colgroup>
							<thead>
								<tr>
									<th>코드</th>
									<th>권한코드</th>
									<th>권한명</th>
									<th>비고</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${authList eq null }">
										<tr>
											<th colspan="4">
												등록된 권한이 없습니다.
											</th>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="authResult" items="${authList }">
											<tr>
												<td >
													${authResult.CD }
												</td>
												<td >
													${authResult.AUTHOR_CODE }
												</td>
												<td>
													${authResult.CD_NM }
												</td>							
												<td>
											<c:set var="user_auth" value="<%=VarConsts.SYS_USER_CODE%>"/>
											<c:choose>
												<c:when test="${authResult.UP_CD eq user_auth }">
													-변경 불가-
												</c:when>
												<c:when test="${empty authResult.AUTHOR_CODE}">
													<a href="#" class="btn btn-xs btn-default" onclick="fnInsert('${authResult.CD}', '${authResult.CD_NM }')">권한생성</a>
												</c:when>
												<c:otherwise>
													<a href="#" class="btn btn-xs btn-default" onclick="fnDelete('${authResult.AUTHOR_CODE}')">권한삭제</a>
												</c:otherwise>
											</c:choose>
												</td>
											</tr>
										</c:forEach>	
									</c:otherwise>
								</c:choose>
								
								
							</tbody>
						</table>
						<!-- page nav -->
					</div>
			
				
				<div class="pop_bg">
					<div class="popup" style="height:1px;">
						<a href="#" class="close" title="창닫기"></a>
				 		<iframe id="iframe" name="iframe" src="" frameborder="0" scrolling="no"></iframe>
					</div>
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
function fnInsert(cd_map, author_nm){
// 	window.open('rol02Form.do?flag=1','target_name','scrollbars=yes,toolbar=yes,resizable=yes,width=500,height=300,left=0,top=0');

	var mode = '<%=VarConsts.MODE_I%>';
	$.ajax({
		url: "<%=request.getContextPath()%>/sys/rol/rol02Tran.do",
		type: "post",
		dataType : "json", 
		data : {"mode":mode, "author_nm":author_nm, "cd_map":cd_map},
		success: function(result){
			//parent.jQuery( ".pop_bg" ).fadeOut('slow');
			alert("권한생성 되었습니다.");
			fnList();
		},error: function (request, status, error) {
			alert(request.responseText);
		} 
	});
}

/*********************************************************************************
* function명   : fnDelete(코드)
* function기능 : 코드 삭제 
**********************************************************************************/
function fnDelete(cd){
	if(confirm('권한 삭제는 전체 권한 참여 여부 후 삭제하세요. \r\n 삭제하시겠습니까?')){

		var mode = '<%=VarConsts.MODE_D%>';
		$.ajax({
			url: "<%=request.getContextPath()%>/sys/rol/rol02Tran.do",
			type: "post",
			dataType : "json", 
			data : {"mode":mode, "author_code":cd},
			success: function(result){
				//parent.jQuery( ".pop_bg" ).fadeOut('slow');
				alert("권한삭제 되었습니다.");
				fnList();
			},error: function (request, status, error) {
				alert(request.responseText);
			} 
		});
	}
}

</script>
</body>
</html>